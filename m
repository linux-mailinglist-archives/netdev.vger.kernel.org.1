Return-Path: <netdev+bounces-297777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /MwHMiyUKWr+ZwMAu9opvQ
	(envelope-from <netdev+bounces-297777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A4666B9C8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:43:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=J6w0LCPd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297777-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297777-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82C553125D91
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70689332EBB;
	Wed, 10 Jun 2026 16:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27465332EAC
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:32:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109169; cv=none; b=eDgtXo1YmVOiLXCuQSkrG4C206lkS6uNZ8hK3tV3vigw+8eLiBfgiHh3k8jimQ02oK8wQcbYhsy63U+O8AgcdKWeEtX9a3y8LJpYyLc+zpcx2ITX0UtJtIgN6Pq/RcXto6EzKomCDTpGFoWceAO9QovA5kiMkLvUJOQRVw/wl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109169; c=relaxed/simple;
	bh=TMEzfUQLssg5wNKq/jlt1a3iau2h5D0PdUtQtzIN32I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7ESRdVYPTdQj1sWcDGYk+2zLJPcbHRiwnBZmavky8UaShqv/fMo1DZz2hl/cD0OhbWZjdiMw/vb49nw/yMfMhFxdy3QSnEbhMoVrITvKUhj/e9sTNmmQ/f65dseJpnO+2DM+Eog4tpl5d/jxBzjRJEEZWY8qGicpqjilu4SYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J6w0LCPd; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5FC1BC4FEDD;
	Wed, 10 Jun 2026 16:32:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 441305FFC9;
	Wed, 10 Jun 2026 16:32:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9456106B9B31;
	Wed, 10 Jun 2026 18:32:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781109164; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DJ6myqASREWHuJJOHXc0Aa1s/r8YHpCv7VS2pMiv0nE=;
	b=J6w0LCPdG5UtkYkRNtVFCqKJL1exBSA8b6gtJkFG8z5mvYDfQ1rolBl+BwJMnKpGrtpzsd
	a0WFBN8zXcw2HRUpKZUmdg9zehLNxGxGtwA5tt9DFNxsyi2T4Q3iwmAeHh5vFVR5TKvUGD
	mK/DTj5krxkMNz/gmH2h9ZZT1pZxbpt0v1AUSYKaYwgH4MLMOzBXpouGISXNXxwW/UMy/i
	Qmn8Yj4n67rP0IVGd2fP/7Hq5pnvL7fBh8oSLRKpqVIrqvl4m+KPjTK4h1WV5LO/9SscBo
	sfoCYNPi0AvzHj66vm3Ho1jtNAXmmfXAyv0g/IUCExp152L1WC5ctn0Xypem3w==
Message-ID: <6309a8e9-c0cb-4473-8d94-c6c4ca8ec3f9@bootlin.com>
Date: Wed, 10 Jun 2026 18:32:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/4] net: phy: realtek: add support for
 RTL8261C_CG
To: javen <javen_xu@realsil.com.cn>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, freddy_gu@realsil.com.cn, nb@tipi-net.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org, vladimir.oltean@nxp.com
References: <20260609020727.1152-1-javen_xu@realsil.com.cn>
 <20260609020727.1152-4-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260609020727.1152-4-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[realsil.com.cn,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,tipi-net.de];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297777-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realsil.com.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35A4666B9C8

Hi,

On 6/9/26 04:07, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for Realtek phy chip RTL8261C_CG. Its PHY ID is
> 0x001cc898.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

[...]

> +static int rtl8261x_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	u16 adv_1g = 0;
> +	int ret;
> +
> +	if (phydev->autoneg == AUTONEG_DISABLE)
> +		return genphy_c45_pma_setup_forced(phydev);

This condition above is already done when calling genphy_c45_config_aneg,
is it really necessary to put it there ?

> +
> +	ret = genphy_c45_an_setup_master_slave(phydev);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;

I'm wondering if this call to genphy_c45_an_setup_master_slave() may actually
be integrated directly into genphy_c45_config_aneg(), as we do for C22.

It _may_ break some C45 phys that would rely on default values though, but this
should be more correct ?

Maxime


