Return-Path: <netdev+bounces-274315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K4WAj/NzWnihQYAu9opvQ
	(envelope-from <netdev+bounces-274315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:58:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42186382683
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 03:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2783E3014924
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 01:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63370332EA0;
	Thu,  2 Apr 2026 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM1noMFv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D68B3328FD;
	Thu,  2 Apr 2026 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095096; cv=none; b=fl+lNLzqioANks4gmxybvDrvmwjBauhQr7QAWIjHVb8AuHor0xRdgBkbM7jAFL2mcaLqg9+P0RQjcPSwm/YI3lk/kMwH8e5LSIXOZJmFdgl5ugF1IRh9FSGRc3rbThD0t1tvYyQSzkTPGFXLhM1r4i+O5QmOk6Zc637EV9QhJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095096; c=relaxed/simple;
	bh=OhkZb1PanLgxrZ/zVo0cHlKmip8idlqqwyDhpMPau+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1Z0oKBuAve/RVDjP+zxmcFd36tYuz7RmLqrr0qXSrC80EY+smqMwhcBCU9ZJsGt+XeY8otx/HvJaYGa2lLUdbfn/Z3Vb1JhK8JYxANCEqnHxiSTFMnh5q3QTsRi56IB1F/p4LpgfjaVTu7ogKF+mn568bLtucTI0JE64sP+GaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM1noMFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672E8C4CEF7;
	Thu,  2 Apr 2026 01:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775095095;
	bh=OhkZb1PanLgxrZ/zVo0cHlKmip8idlqqwyDhpMPau+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TM1noMFv53UldSBvxvic6PaEjCjIeA87RrAT7bpxWnOXEj/tFNozSgokcbHXgHGTv
	 WWyZGFREuUR5frfDeV9nTJGaRuPmuRjs+bzLXLl9TVyt9tOp4dfSERSHvQtZAxbtOf
	 E7m/LxXetSeWUIApK4Dsfj3372hXiXxv1z8s7RVYXuVCOBx9wimgZ0w6Eb+qkhJF1y
	 rJBcjvJzVBZbj63x9bITk8QxhgjxSJQupYiWVpLYKOAVg565zveogZKanu4gPWD71A
	 DPp7m4X2V58HSKS5uyTiWu5bbGPY866g4VmihrP/rudgyWr3Vf1qpmt5/i6+Eva3GX
	 CZgfQdkUDDYjQ==
Date: Wed, 1 Apr 2026 18:58:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: manabian@gmail.com, davem@davemloft.net, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stmmac: cleanup dead dependencies on STMMAC_PLATFORM
 and STMMAC_ETH in Kconfig
Message-ID: <20260401185814.45dfc444@kernel.org>
In-Reply-To: <20260331125817.117091-1-julianbraha@gmail.com>
References: <20260331125817.117091-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,st.com,foss.st.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-274315-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42186382683
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 13:58:17 +0100 Julian Braha wrote:
> @@ -53,7 +51,6 @@ config DWMAC_DWC_QOS_ETH
>  
>  config DWMAC_GENERIC
>  	tristate "Generic driver for DWMAC"
> -	default STMMAC_PLATFORM
>  	help

This is a default not depends.

As much as I'd love to make stmmac default to y this will probably
break boot for some people..
-- 
pw-bot: cr

