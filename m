Return-Path: <netdev+bounces-52810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D2780046B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784BE1C20CF1
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09A11CA2;
	Fri,  1 Dec 2023 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcvyVC/a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C8C130
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4141FC433C8;
	Fri,  1 Dec 2023 07:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701414493;
	bh=kkDlSi8LK9wnO0BxtoNklTwo0Po3lzBpozTfDh5KYnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DcvyVC/azyDijmRL8how/2ktMXVEwKIFt5n4L6TFDZ9/YbVs6t4DBQJGb3xWXQNw7
	 CThYeS4obQ4V9I/mInL+2uX5bMRuYkx1C7EXpUoQjE5zAtYb96Wu6svE1ppqEayKOK
	 kH+frqVB83WDfjMVmYTBQNs/I6VCXLdIP0I7dagdGgNMI01jHBUT4dzH3uQ04Aoepz
	 n0jYCcIWo0WdcN3ZnK/8NM7yCBX0LcKDOCd941LyLvKpELhfV5R3VmGFBZLLOrIaU+
	 LbI1B6Y3cByx5dO/oKqPn2iRH921YFJOnqF0QMeDde6/4n3skcm9FvT/OIFJT53KlL
	 ZMxfwsEVqJa0A==
Date: Thu, 30 Nov 2023 23:08:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: almasrymina@google.com, edumazet@google.com, hawk@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: page_pool: Fix NULL pointer dereference in
 page_pool_unlist()
Message-ID: <20231130230812.16461d0f@kernel.org>
In-Reply-To: <20231130192542.4503-1-spasswolf@web.de>
References: <20231130192542.4503-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 20:25:42 +0100 Bert Karwatzki wrote:
> When the the hlist_node pool->user.list is in an in an unhashed state,
> calling hlist_del() leads to a NULL pointer dereference. This happens
> e. g. when rmmod'ing the mt7921e (mediatek wifi driver) kernel module.
> An additional check fixes the issue.
> 
> Fixes: 083772c9f972dc ("net: page_pool: record pools per netdev")
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>

Thanks for the patch, we got a couple of similar submissions,
and merged the first one to be posted.. should be fixed in net-next now.
-- 
pw-bot: na

