Return-Path: <netdev+bounces-58622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0A6817943
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 18:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F11B1F220B2
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8243154;
	Mon, 18 Dec 2023 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fkqw5uB3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980CA3AC19
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 17:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0F1C433C7;
	Mon, 18 Dec 2023 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702922153;
	bh=NJKxC/qUhbeJDBZCdkswh/lxFwJVpEXd8gzNVRcCDTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fkqw5uB3WAF9rVgnwnTDafg5aI0dFLrK6TWH1TTWT9Q9cmNkaaLuDPLuM8J9ZrlKl
	 EJCOZdz0K7iTvCvp1lcbTe2TepnRGXFAQ9JswZX9sOMaJRYcOR4IejK7H5I/50NoC5
	 Dbqq9nM5ML8TYl9lEknEfFVkvc2w2Tsi/pzK61CSTYnH8pnbqc/luz99Al+ZB/PuTJ
	 CnHAu2keQHgThAf2JpLR19yHDZGyqr8ZsijE92T24XxhrvJ0sahkcx1ZnSpLAl3K1j
	 Ow4beH4Q4TAqiYUJSTvHgnUaW5r2MGVpSM7Ag/KxaQYQZTDEKSVYo4+0TpAiPpcfsS
	 j35O11dRsD4WA==
Date: Mon, 18 Dec 2023 17:55:48 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net] net: ethernet: mtk_wed: fix possible NULL pointer
 dereference in mtk_wed_wo_queue_tx_clean()
Message-ID: <20231218175548.GI6288@kernel.org>
References: <3c1262464d215faa8acebfc08869798c81c96f4a.1702827359.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c1262464d215faa8acebfc08869798c81c96f4a.1702827359.git.lorenzo@kernel.org>

On Sun, Dec 17, 2023 at 04:37:40PM +0100, Lorenzo Bianconi wrote:
> In order to avoid a NULL pointer dereference, check entry->buf pointer before running
> skb_free_frag in mtk_wed_wo_queue_tx_clean routine.
> 
> Fixes: 799684448e3e ("net: ethernet: mtk_wed: introduce wed wo support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

can I clarify that this can actually happen?
What I am getting at, is that if not, it might be net-next material.
In either case, I have no objection to the change itself.

Reviewed-by: Simon Horman <horms@kernel.org>

