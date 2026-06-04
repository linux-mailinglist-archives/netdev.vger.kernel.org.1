Return-Path: <netdev+bounces-295116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GCNYAARAIWrQBwEAu9opvQ
	(envelope-from <netdev+bounces-295116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:06:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87863E541
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:06:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=uxk2j58F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295116-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295116-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F84A301992D
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AA13C818B;
	Thu,  4 Jun 2026 08:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC673C37AC;
	Thu,  4 Jun 2026 08:49:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562970; cv=none; b=bXJZjAm+ONJKNmJILycib/n7OdqMentybbmj1dLTi+rGw5q/eMRLrhHKFqoorbFJodeRzoiEqRq1qKDa4SMiMAe8pwV+LDafhqY/n1SBB0vm6WijhS/+/q0O6e0KCjRKHh1Zd9P67pzhaa2Td+OwTvdbkKWRHeXx8QR13R0bmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562970; c=relaxed/simple;
	bh=k4Azq0MQ+WyzKh7QHZp7hckLTDape11Sl1KkrWJUI9E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=USo6tVGE/ztOopVyA1B4zxewvD7Z7wgznRpLMfq7h5qTyntAJotYkn/sNH97iDbcb2aVSN5sBkGe3TpG6Q/fWXQhJgzqJ8JX2JXBHQLzSlMCyNa1mKxuebx++nqdkY+UXYmSKV5Ft6Uqg2KaFHEniDBs0uCgK4VSjLS5vIcwAg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=uxk2j58F; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D949EA027B;
	Thu,  4 Jun 2026 10:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780562967; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y1TmL6XUHxSu6zxj61u379IiRdxDdicnUhfIlf5MmjE=;
	b=uxk2j58F4ws5gEllgITLJHlKFnMb45MnmXWVOxJaFJUFCHjm1a5O+TAbIKvAh2iji3VEbb
	j48dr4o0RcFFwZ9N7SDjFOBOx/2qW2SP5MVnkbpTaAl4b2jQQU9sIwZksYoksoQCaZJ2nh
	ar9Jh8z/fVHKcAPUEpPOj9tMSHJCvcqfUKDxwX6m2Cwjy6HuCKAtEMGCOkkk+6x7oUQcT7
	CDjQ19rPXd3lR+8DMXhDWjLblVfk5euuJChLmUt2EMz5m0u3t5aSnugRCUB6SOh8X+ftL/
	AA1djHq4HwUE01Mfe9R8Ntw2LtHccptvfIz3BCxrD2B0/DvVvEF6w1/PRv0EUg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 10:49:25 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v2 2/4] net: phy: c45: add
 genphy_c45_config_master_slave()
In-Reply-To: <20260604074209.93-3-javen_xu@realsil.com.cn>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
 <20260604074209.93-3-javen_xu@realsil.com.cn>
Message-ID: <521e53fe8f22eb938ea7b9073516378f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-295116-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,makrotopia.org,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E87863E541

Hi Javen

On 4.6.2026 09:42, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic helper to configure forced master/slave mode for Clause 
> 45
> PHYs using the 10GBASE-T AN control register.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

> [...]

> +/**
> + * genphy_c45_config_master_slave - Configure Master/Slave setting for 
> C45 PHYs
> + * @phydev: target phy_device struct
> + *
> + * Description: Configures the Master/Slave manual setting in the
> + * 10GBASE-T control register (MMD 7, Register 0x0020) according to
> + * IEEE 802.3 standards.
> + */

Please document the return value (0 = unchanged, 1 = changed, <0 errno), 
like
it is done for genphy_c45_an_config_aneg().

> +int genphy_c45_config_master_slave(struct phy_device *phydev)
> +{
> +	u16 val = 0;
> +
> +	switch (phydev->master_slave_set) {
> +	case MASTER_SLAVE_CFG_MASTER_FORCE:
> +		val = MDIO_AN_10GBT_CTRL_MS_ENABLE | MDIO_AN_10GBT_CTRL_MS_VALUE;
> +		break;
> +	case MASTER_SLAVE_CFG_SLAVE_FORCE:
> +		val = MDIO_AN_10GBT_CTRL_MS_ENABLE;
> +		break;
> +	case MASTER_SLAVE_CFG_UNKNOWN:
> +	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
> +	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
> +	default:
> +		break;
> +	}

Per IEEE 802.3 (45.2.7.10.3), 7.32.13 (port type) is a copy of 9.10 /
CTL1000_PREFER_MASTER, like it is done in c22's 
genphy_setup_master_slave().

So set it for MASTER_PREFERRED, clear it for SLAVE_PREFERRED and leave 
UNKNOWN/UNSUPPORTED
untouched (return 0). Use -EOPNOTSUPP only for default.

> [...]

Thanks,
Nicolai

