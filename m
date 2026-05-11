Return-Path: <netdev+bounces-286815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAl/Gjg0AmocpAEAu9opvQ
	(envelope-from <netdev+bounces-286815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:55:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B89515544
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D6CB304E665
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB2F37EFF0;
	Mon, 11 May 2026 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jAgXnJ+M"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EE037E31E;
	Mon, 11 May 2026 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529333; cv=none; b=FNoyDYGU3Gt2e6H6V7yoOuaC40QVGKKcp71jtC5vimZFCP1fUzQW7LzB2y9iRMESxSFXyY6SGHNPsezKmmFBo5NP9Xss3L4Ly8QtAwZEoGUS9azBRudC3Jp6H1BoKUCe8g3OM/bIxY0cX5lcCWGv8E46fPpvQ2MCBfkHUDrSSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529333; c=relaxed/simple;
	bh=td/msFDLYOkLi3omzOi3zK2vVOtwEHv7DN3heQmMk4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4WoiHfgEF8SNlS+X3+eiv17LDdmzD48quMabtzJR1Nm2p2dUHX5vyogu8bbCEUYT2MjFjzPHsx6/WYv1DS6lwmSMLkJSNBQXgTvKh2tB0I3CwfPDZUb+AdefJx4YEdnqC0pPjYuzVNasDNoTdT/69YmEZVojkWh7Itdjsu/2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jAgXnJ+M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q/2albmhxQkLZgimHwKYmc1iebJjrIQrSyHvOxL4P3Q=; b=jAgXnJ+MB+HEV7buFhgStBqf2a
	XXYebmgYut2JgquPRveeqskLfFV8zWgERd/Pjzhw8NIols9AjfUrzbLomj+QZ0zDLi2NOSNxOVDux
	t0uNZGkdjLalMVcGaBQzptgv4v9gaqO4R8e8nlLUKiOmymw2TPpBela9bUeDiOEZ80hY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMWio-002Qr4-T8; Mon, 11 May 2026 21:55:22 +0200
Date: Mon, 11 May 2026 21:55:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 7/9] net: ethernet: oa_tc6: fix for minor
 issues
Message-ID: <587f96bb-bcfd-4515-a4b6-e9e4292ce5a1@lunn.ch>
References: <CY8PR02MB92494EEBB98152678D3CCEF183382@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92494EEBB98152678D3CCEF183382@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: D5B89515544
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286815-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

> @@ -459,9 +459,7 @@ EXPORT_SYMBOL_GPL(oa_tc6_hwtstamp_ioctl);
>  /**
>   * Add vendor specific MDIO_MMD to OA TC6 MMS mapper value.
>   * @tc6: oa_tc6 struct.
> - * @mms: vendor defined MMS value.
> - *
> - * Return: 0 on success otherwise failed.
> + * @mms: vendor defined MMS value for VEND1 mdio device.

You just added this in a previous patch. Don't patch your own patch,
get it right the first time.

> @@ -701,7 +699,7 @@ static int oa_tc6_mdiobus_read(struct mii_bus *bus, int addr, int regnum)
>  {
>  	struct oa_tc6 *tc6 = bus->priv;
>  	u32 regval;
> -	bool ret;
> +	int ret;
>  
>  	ret = oa_tc6_read_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
>  				   (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),
> @@ -864,7 +862,7 @@ static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
>  	oa_tc6_mdiobus_unregister(tc6);
>  }

Please put this in a patch of its own, with a good commit
message. Lots of small patches, each with a good commit message.


>  
> -static int oa_tc6_read_status0(struct oa_tc6 *tc6)
> +static u32 oa_tc6_read_status0(struct oa_tc6 *tc6)
>  {
>  	u32 regval;
>  	int ret;

A patch of its own, and the commit message can explain why, because it
takes a bit of work to understand why.

	Andrew

