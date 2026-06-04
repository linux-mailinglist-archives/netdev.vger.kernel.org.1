Return-Path: <netdev+bounces-295119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KdNHGq9AIWr+BwEAu9opvQ
	(envelope-from <netdev+bounces-295119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:09:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C510E63E5C2
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:09:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=XNTfI1hb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295119-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295119-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FCEF30E2774
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5FA3F39EB;
	Thu,  4 Jun 2026 08:57:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261F3F23D7;
	Thu,  4 Jun 2026 08:57:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563434; cv=none; b=K2+kfVS2LWM0ejtvwVFfeacs1Zgie+IvD4fc5FEahqAWpJFHVq8fWNrDp6kC2mAjHR1SuCfjtB8H17XN/B6A1/mOZwn6WB09ruQ4PpQCZBtoCQiDxxBWUqxGPMz/CjV2tmEOQeo3R1Zq8Ir86YSY8PkU2r5d+kwyD9nr+kRQ+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563434; c=relaxed/simple;
	bh=cujquTacYS0SyI/O00lZ117HDJtHKItexeInz5hUx+8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eDESNaCkz8ZajVWOD8o2QPCkrvkLdkrtcz0dmYp+RvvL45Il1UC1UuEdcJ+tF5qmCcKlXv0iX5RDiPKKmo9IXxNUrJVRxDgI26QFY1m9XfDQXBIQ7XONUYRTLP7d6s/ISyFq5jHg02vMvUxyytnEkUCq4BSVzv+AoyyRjg1GIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=XNTfI1hb; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EDAAA4BA0;
	Thu,  4 Jun 2026 10:57:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780563430; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lTuCvk0QyaGOhkLATuC+pQdtUcUwnJUH6ax50eJJVXg=;
	b=XNTfI1hb7nPiWWBh5K6F45NKgd530joprylAeTNLo8of2KV8psUcTPJ6/0Dsd9Zsy8MPOt
	N7d9fwcyBnu0BZSQIjf/juGT4AGvDvfzLs8xT1erEKKvUk0sMR8Y3+qVpAdzlgt7JX5lkr
	pe1Z3uoVe+SzY9780uXODEJid5+Ip1UsF2E81C6h/uz1Vo9ClaCkpXa/3Hz2cpXZNhl27d
	zSDUScsyobGur6ahuoBIQZXPtsZW1IWtcnYYu9aVdE0PNx3PFgDa0aN6lL3r88IjE+1Cbj
	vrhdWDuuvwMT1wkR0/hqRA6fP0RDAip/mxxBCxw0WPoOCULBfRDv3fUTCoH9oA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 10:57:09 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v2 3/4] net: phy: realtek: add support for
 RTL8261C_CG
In-Reply-To: <20260604074209.93-4-javen_xu@realsil.com.cn>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
 <20260604074209.93-4-javen_xu@realsil.com.cn>
Message-ID: <94d987457c307b11316cdd49ede213b0@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-295119-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C510E63E5C2

Hi Javen

On 4.6.2026 09:42, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for Realtek phy chip RTL8261C_CG. Its PHY ID is
> 0x001cc898.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - remove RTL8261D, only support RTL8261C_CG
>  - remove speed 500, rarely used
>  - add helper function, genphy_c45_soft_reset() and 
> genphy_c45_config_master_slave()
> ---
>  drivers/net/phy/realtek/realtek_main.c | 178 +++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c 
> b/drivers/net/phy/realtek/realtek_main.c

> [...]

> +
> +#define RTL8261C_CE_MODEL		0x00
> +#define RTL8261X_GBCR_REG		0xa412

IMHO this is just RTL822X_VND2_C22_REG(MII_CTRL1000) (= 0xa412), already
used elsewhere in the file. Drop the define and reuse the macro, as
Aleksander suggested on v1.

> [...]

> +struct rtl8261x_priv {
> +	u8 sub_phy_id;
> +};

sub_phy_id is only written, never read. Andrew already asked about the
unused priv fields on v1. A local in probe() is enough, drop the field?

> [...]

> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +			      phydev->advertising))
> +		adv_1g = ADVERTISE_1000FULL;
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
> +				     RTL8261X_GBCR_REG,
> +				     ADVERTISE_1000FULL, adv_1g);

See above and replace with RTL822X_VND2_C22_REG(MII_CTRL1000).

The aneg-restart handling looks correct now, thanks for picking up the 
v1
comment.

> [...]

Thanks,
Nicolai

