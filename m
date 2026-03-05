Return-Path: <netdev+bounces-264161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFTiCj3yqGnDzQAAu9opvQ
	(envelope-from <netdev+bounces-264161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:02:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDD820A669
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 602A73035A49
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 03:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7983D239E7F;
	Thu,  5 Mar 2026 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB6p7voS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562EC1B983F;
	Thu,  5 Mar 2026 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679718; cv=none; b=gVQrU7keCQc2XMSMbjoJQsBFHPifqFPiUAEWFh0NI0Jky/yJWhk99uQyUGXMvTZ6Hmi5kW/Oq/SwGiO1NqyPW2VWIFEpA7Euz1RNLiFiaHZFSgO1Pj6oz33Sb2MJ9drIctN8yqHVaDCvkJkMuQMnrVfoGAYytyZK6pXys9p1cQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679718; c=relaxed/simple;
	bh=g/xB4YsTbYh0ccsdun8rgPCLY72J9n6v5AetsTKKLRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZV3NRWWAtKyfEjHJ7HUJ6j5QIiBZoy4IROHXBaKy2KZbUb2RbtCcpdnWCgbSFI412vfhqiwntRJ44CjA6f69tBgmXZ9WumnXh980j8i2fP0fuQDeqITdkNYfqXzLmXsAmGErIIKzrI+KKIi2uJdTQYyHMBBXgLvwD56lpy9GCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB6p7voS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDDEC4CEF7;
	Thu,  5 Mar 2026 03:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772679717;
	bh=g/xB4YsTbYh0ccsdun8rgPCLY72J9n6v5AetsTKKLRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WB6p7voSleUADKS6z22jdQc4R+TffsXzkMM3RdtjGhMJwXfx2X11eaBqz6ewPjE/5
	 hWpfyKea3LgKHC+Yy7xacQc5sgDpurhiXrHcE+wX3lGno4punIxgHWmPh78zWK6IPl
	 63bJqE0jh5ayJLmTxQbY4pK+aC8u1wYSNcV30i4/4sVVRJBASEIvYzpozihonqn3RV
	 a59p1YcwhTGeQfbz8wcVzYXegAwtBKI/S/iLuDG+ucuf68SMD+EOQSwgpMZGfSLx4D
	 pLeVOhZx4dEjFrPWBDIN/i+O4o/+dATR7nnplTebBITebhSgs106PJcp4ASubZ0WOO
	 qItJxaZGCY/oA==
Date: Wed, 4 Mar 2026 19:01:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Michael Walle <mwalle@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vignesh
 Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, "MD Danish Anwar"
 <danishanwar@ti.com>, Vishnu Singh <v-singh1@ti.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix rx_filter
 value for PTP support
Message-ID: <20260304190156.319df897@kernel.org>
In-Reply-To: <20260303075819.3246032-1-c-vankar@ti.com>
References: <20260303075819.3246032-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7FDD820A669
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264161-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 3 Mar 2026 13:28:19 +0530 Chintan Vankar wrote:
> @@ -1888,8 +1894,8 @@ static int am65_cpsw_nuss_hwtstamp_get(struct net_device *ndev,
>  	cfg->flags = 0;
>  	cfg->tx_type = port->tx_ts_enabled ?
>  		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
> -	cfg->rx_filter = port->rx_ts_enabled ? HWTSTAMP_FILTER_PTP_V2_EVENT |
> -			HWTSTAMP_FILTER_PTP_V1_L4_EVENT : HWTSTAMP_FILTER_NONE;
> +	cfg->rx_filter = port->rx_ts_enabled ?
> +			 port->rx_ts_filter : HWTSTAMP_FILTER_NONE;

HWTSTAMP_FILTER_NONE == 0
a lot of code depends on that
so you can just assign port->rx_ts_filter

>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> index 917c37e4e89b..595123c155db 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> @@ -53,6 +53,7 @@ struct am65_cpsw_port {
>  	struct am65_cpsw_slave_data	slave;
>  	bool				tx_ts_enabled;
>  	bool				rx_ts_enabled;
> +	int				rx_ts_filter;

given none == 0 you can just turn rx_ts_enabled from a bool into
an enum hwtstamp_rx_filters and maybe rename it?
no need to have two members in the struct for rx
-- 
pw-bot: cr

