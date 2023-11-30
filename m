Return-Path: <netdev+bounces-52608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCF37FF734
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8F71F20F2E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FADA54FB9;
	Thu, 30 Nov 2023 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpTGK9F7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE954671
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1C5C433C7;
	Thu, 30 Nov 2023 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701363272;
	bh=+JApM2xxvJ76AYAMsy1eDzT9dueJOrHv87TMof3GiAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpTGK9F7eUx2VyXMCE3tqj2B7X/ibYFfq6DVIOrkvzbt8KoSx5f5UeSxN9PicGLzb
	 UHzHQMNtDyKSjPZYs60zwNsUTVPiv3CcX1frQ1JATuoP3pPKgWxQTFeJ+xbjU+kEbR
	 NSE1ZJZYJKfrR8MJ0sh+BRw3sUuAHVuF84RJp8RdRGl8klNbxB0FsvIM9qSEWcg0tQ
	 /LpwDpstlEOClk+Uvdl52hqB5MR17Nymmp70BBHUlGADo1Q1OyKN4siLtJqLZ7JDtE
	 sXcS2jRxDkceFmR8SqlitXP+a1aREy1fdYQApfQE04qavRT+GQu1Wh7Cwyejio1A3t
	 m7WewvYvVTnmA==
Date: Thu, 30 Nov 2023 16:54:26 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, wojciech.drewek@intel.com
Subject: Re: [net-next PATCH v5 1/2] octeontx2-af: Add new mbox to support
 multicast/mirror offload
Message-ID: <20231130165426.GE32077@kernel.org>
References: <20231130034324.3900445-1-sumang@marvell.com>
 <20231130034324.3900445-2-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130034324.3900445-2-sumang@marvell.com>

On Thu, Nov 30, 2023 at 09:13:23AM +0530, Suman Ghosh wrote:
> A new mailbox is added to support offloading of multicast/mirror
> functionality. The mailbox also supports dynamic updation of the
> multicast/mirror list.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


