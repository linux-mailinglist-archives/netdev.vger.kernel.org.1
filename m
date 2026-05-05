Return-Path: <netdev+bounces-284412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC6+KyHw+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:26:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9C4CE75C
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F26FF301E67B
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CAB388371;
	Tue,  5 May 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="OGjfSHaO"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A276342C9E;
	Tue,  5 May 2026 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987551; cv=none; b=DNfpmiqOOmGncVQSefbt2vVCt5aW+fZltraMVNlEw6hTh92qao33OmapnZ5olGBV4e8E+gbT5lT3P1wDS7aTSfWooLVQfShET62s+9MTYt9mnKQHFt2cmeT/Nkdjw7nwTlRtxYVOhdvM7NT3oiOseqETfCfG0v75fHiA4060KjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987551; c=relaxed/simple;
	bh=GBG5ZkoMWgxxX3NbRxwM7N9wK90IpVl5TPUkLpgzrQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TR/F5kTadYMhlp/KnKWTeUDmFQ5Lj1sZPdQGjW2p9AlaphYAcCGbzxKaHY+/LEEjL+EfhdsjUfIVag+EaVoK1PA3t+T/6B2a7dOFGy3mwtFIF8FkbS/wlUpKGEavxLYxhggD08y3bVAReTOu+8bGIySbU9GfDMKGiD5wu6gyNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=OGjfSHaO; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 256581156F0;
	Tue,  5 May 2026 15:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777987547;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wLrcqSm2CBZBQt2nkUnC3C284Xkr16/u4fVAES1FDlw=;
	b=OGjfSHaOx3M98N74on5bTGT+NUz7m2mHsD1y8pFyhQ9Xk2ZtK5vch8Rr+KhwcjleV4omhV
	uz7gzBJtZiZoroGwyOSWC6wuewDOFO5iwqsn1j20L7Zc1INQlsw2ZpGzAOWSX2zAhQbVj7
	knjucrxBTGGDEKeW+qi35xb+Y/wj1hCjNAP57xkeQkHsfrxi+D8brDezfwhgXe4XLHHrRa
	8BH1kZOYjflSgk1aINaP8ydXNMAIL9r7sIYEMdraulAW5zN1vEdexgPKDfeh16x831lbhZ
	vzHvteargoLRK4aWAE4R6+BKqxmHpfB5PUPV+wIVj1fwIXaCRFnms2uPcw/HEw==
Message-ID: <203945a0-4712-45c6-8940-f0148195effe@nabladev.com>
Date: Tue, 5 May 2026 15:25:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] net: phy: micrel: expose KSZ87xx low-loss cable
 tunables
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
 <20260505-ksz87xx_errata_low_loss_connections-v5-3-da4002b21c42@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260505-ksz87xx_errata_low_loss_connections-v5-3-da4002b21c42@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 67C9C4CE75C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284412-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:mid]

On 5/5/26 1:42 PM, Fidelio Lawson wrote:

[...]

>   static int ksz9021_load_values_from_of(struct phy_device *phydev,
>   				       const struct device_node *of_node,
>   				       u16 reg,
> @@ -6809,6 +6861,8 @@ static struct phy_driver ksphy_driver[] = {
>   	/* PHY_BASIC_FEATURES */
>   	.config_init	= kszphy_config_init,
>   	.match_phy_device = ksz8795_match_phy_device,
> +	.get_tunable	= ksz87xx_get_tunable,
> +	.set_tunable	= ksz87xx_set_tunable,
It might be good to keep the function name prefix consistent, i.e. 
ksz8795_get_tunable and ksz8795_set_tunable . Or add a separate rename 
patch for ksz8795_match_phy_device -> ksz87xx_match_phy_device.

