Return-Path: <netdev+bounces-264983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO++JLB4q2nSdQEAu9opvQ
	(envelope-from <netdev+bounces-264983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:00:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 140F0229330
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C249A3089547
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 00:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3873F2D77FA;
	Sat,  7 Mar 2026 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHKKiR0k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D60288C81;
	Sat,  7 Mar 2026 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845186; cv=none; b=I/gLY4jnHB/utMPyxMATi0cVk5FoShbN2Es0PN19DeeNx6X6TikqURX1+ltTbnnSvFGcr+reZj4mWKC7bYGxmopby3Vf6hb6UuiQokabnt6LYmQO/BnVrj470MY0hrW3/u/jI74UhqOI3Or90rk4ckKFNRXmFkboBDMKsSK14uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845186; c=relaxed/simple;
	bh=zuhOXLsrJ25rdGb84BAPcA5Mx//WKSQ+2nw1sNib/JY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQCUS7TOkfMOukmwLaKSZJzk+wZEcobIXpItb079VOSYW3Q+5rfTxYG5MPn5wjo86yQcgVc5+TtVvuYJ4B6dQFHD8qsOj8+0tji/ynIRRQsj2N+TfcCaetcKjY1N4zCbVFXnBpZUsl9TOxja0I0/mmrbojcyRP62xrm0hmNPsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHKKiR0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E6AC4CEF7;
	Sat,  7 Mar 2026 00:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772845185;
	bh=zuhOXLsrJ25rdGb84BAPcA5Mx//WKSQ+2nw1sNib/JY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gHKKiR0k9QyOr5zo3o7b9saC7qV0Nnf2ga6NSt/GFufOCTjw56pCwzNTc1a5p9ZD7
	 xKAasFZpHFj8y3VeQpsnXNRFvH6MLT0M+XxN0267pU3dnOs33A4F3A5nsFkWMr8DD6
	 jOsY6Keq0zLYb17ZcFuWQ59iDkmH3r5LRjaLwM/Z96fqBfXJw5G+MwdWjFMIkT19WE
	 U1tpZ3zkDXmMwuwvFHosL7CZwquKA4h9i28yGqL0QoIz3vBlIGZ16x9WmViBI0/uHJ
	 0IYifwla0NqvHTCzSvbZyL9g5yNq1Wz4s4JlB1ZEFPEn41fOHwVFznf1/gVcpKQJpO
	 TWJem5PVyUXzA==
Date: Fri, 6 Mar 2026 16:59:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Raju Rangoju <Raju.Rangoju@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] net: xgbe: use device_get_mac_addr
Message-ID: <20260306165941.525574cc@kernel.org>
In-Reply-To: <20260304042240.7964-1-rosenp@gmail.com>
References: <20260304042240.7964-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 140F0229330
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264983-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue,  3 Mar 2026 20:22:40 -0800 Rosen Penev wrote:
> -	ret = device_property_read_u8_array(dev, XGBE_MAC_ADDR_PROPERTY,
> -					    pdata->mac_addr,
> -					    sizeof(pdata->mac_addr));
> -	if (ret || !is_valid_ether_addr(pdata->mac_addr)) {
> +	ret = device_get_mac_address(dev, pdata->mac_addr);
> +	if (ret) {
>  		dev_err(dev, "invalid %s property\n", XGBE_MAC_ADDR_PROPERTY);

Feels a little odd to still use XGBE_MAC_ADDR_PROPERTY in the error
message when now we support any property name for MAC address.
Let's rewrite the error to "invalid MAC address property\n"
and delete  XGBE_MAC_ADDR_PROPERTY 
-- 
pw-bot: cr

