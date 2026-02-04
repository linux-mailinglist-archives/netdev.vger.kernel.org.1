Return-Path: <netdev+bounces-256552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J/tDubCgmkpaAMAu9opvQ
	(envelope-from <netdev+bounces-256552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:54:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEB0E1679
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67A773009399
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3062E2DD5F6;
	Wed,  4 Feb 2026 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azTm3gIj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E42C21EB
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177248; cv=none; b=QmnHj6/lQ3akWSPaWvaxxOBQzNi4FpDpHMzpgerj85zUbz0JiBBNCOWtD0jcowQFSZfbzIMMBWdRUGuDXIUM2ZmCHktedJ3qh0M+2HwnuY5BEJAu42AwjHtejFdfKv0CPu80vDuB/Bh2cCXwzJyhLjpX0LccAlf1UaO+YuzGa4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177248; c=relaxed/simple;
	bh=VeokmRxKrzPdkUW4Q5G306mDxXMWUl855v4qe7W+BKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLHKiJRZ0tsJJ/upIU2+umbezygQocHf8ZOqpzBDOpHmHgK5GhaScOGMQnX016ZiGJrA9BdRmUwc/ioKoLH/VvBpu6l4VaGpyLJ3Rykq3jdaC8jnCO21BZzwqHAUTkPqNxaUGcikSq0blE7WrJsSI4lKb4HO5YTKodrnXQou0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azTm3gIj; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c7199e7f79so952989385a.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 19:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770177246; x=1770782046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs6BBarzwmD2Zm1TSaGTp7E5XeDaUo3g+3j+s/whg7M=;
        b=azTm3gIj40TLD4n8703vrESuIU+mfxLVEao1MmLILQnOxD/uLbO4AYVB5GGi97DfNw
         dHLk+FsbqNTsEY1eM+FeeZIpz5tDiH0crbapjGsbhKlUZ8/mEqt3kY+ACSX5zuO/3yt3
         2n6dc2QoHHBKkX/f/eccQq/7+142hmMxKm8Wpgdm24MUiIS5h6sMh1kBtWytk9C9fYmX
         WjCvSZTNY0YZVAHTB+mnywRMUadZhAG7S5HPgjWdmfuVCF580BcOwk3vPkf/Rx7h9gxD
         FdbTwvwXbnh7aDfPsx4/qt72u8awh+LAv3ZmjwauTijvG0eCYHxXyUwOoiMfe65u1upJ
         ChhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770177246; x=1770782046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rs6BBarzwmD2Zm1TSaGTp7E5XeDaUo3g+3j+s/whg7M=;
        b=mBY9ckUp6Suxsw/TiIy6sL38sKbDJm1+P783t3XyrKI7l4lB7Cf7ZaPQJNt8vV9rE0
         LrhWGpmvr0z99N2fL8B2oePd8tC2M+/rQWm3G2+IIa+9t8PJv2r7myFfVDnh6hbFjfX+
         inKBbxEkMDLrcSg+5PqDJS3FJzbLqtl6evIwH43OOpWtvnBaWZlZ95JjGqC5pvlGifBZ
         07yBcUVHQB4v9zDzTkap58or7B9+ymsIH+MQ6+g2lppuIwBXIofrQCi67CIJ+MONXj/S
         pYU3FFSRlAic7Ax0tpmrpqeaGZKIJPX+vge5y+bArXpWH1oVWXtnjZi4vl1XapzZ4HJw
         bOng==
X-Forwarded-Encrypted: i=1; AJvYcCUABqIH9DE5joeNo/UoNPz54jcDykoHpnqPFlOr4aEpdj7balGEIm1QLFC8bWe0z5T5WY8+RQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe08caGgNZsjVBKkWPStPgJCVE/WlC9zACK9emLWrFxk65Y85D
	hU/v+C0XSqmQAn3AoGXk92YoZ9qB6PrTjFO+L+6Q4a69u+GeQ/dVqokRU8UxTMQW
X-Gm-Gg: AZuq6aJD3Bqz1G8h2HcfEU5eO1zw+2zT4UfKvfshSO+mGpUdp/g+BbyuxrQdLPCEAEe
	8nZkNbMdwT58tQYScqBptoijW++DUQWMFKq7ZaCYclP1MptGRWewrdQEGGF6fKEQBQwIAYzHZHA
	qpzr5l7xRb8GWIItDmtAo5c+xqBcY6SXh1AfVrjczaCAnfsfhAYCDXiDg+lAsSws4Fp09OClmZi
	sJd99K6SRy0vk9p1Kp1BaHojtlv1CUZL6ZTVHtui4xr4xG2Z/HB3U+VHozV6vziAIghvQvib/Qg
	hWz9TqX7JkItLav2dUi2t7SFL9okI1iCj+iYHcJCzeO++kCkau06g2YB1Geu0yHnbhs0TXyBKfz
	qonKOWB42wE9PDtskrz6HI+Xed2V1GPh+xfcQnqAeHd19kONIYA+uGejr5Uck5chDZfatUN9Ciu
	I2PrNACgYd/2JElpooDUi2
X-Received: by 2002:a05:7022:f103:b0:119:e56b:91f2 with SMTP id a92af1059eb24-126f47daa76mr613066c88.35.1770171313127;
        Tue, 03 Feb 2026 18:15:13 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832feacc6sm940814eec.35.2026.02.03.18.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:15:12 -0800 (PST)
Date: Wed, 4 Feb 2026 10:14:47 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yanteng Si <siyanteng@cqsoftware.com.cn>, 
	Yao Zi <ziyao@disroot.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Shangjuan Wei <weishangjuan@eswincomputing.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Zhi Li <lizhi2@eswincomputing.com>, 
	Boon Khai Ng <boon.khai.ng@altera.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v4 3/3] net: stmmac: Add glue layer for Spacemit
 K3 SoC
Message-ID: <aYKq4qlgCDo42rnw@inochi.infowork>
References: <20260130022705.1059214-1-inochiama@gmail.com>
 <20260130022705.1059214-4-inochiama@gmail.com>
 <aYI00Exytbgbnuzp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYI00Exytbgbnuzp@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256552-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,cqsoftware.com.cn,disroot.org,bp.renesas.com,eswincomputing.com,bootlin.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,inochi.infowork:mid]
X-Rspamd-Queue-Id: 5BEB0E1679
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 05:48:00PM +0000, Russell King (Oracle) wrote:
> On Fri, Jan 30, 2026 at 10:27:04AM +0800, Inochi Amaoto wrote:
> > +/* ctrl register bits */
> > +#define CTRL_PHY_INTF_RGMII		BIT(3)
> > +#define CTRL_PHY_INTF_MII		BIT(4)
> > +#define CTRL_WAKE_IRQ_EN		BIT(9)
> > +#define CTRL_PHY_IRQ_EN			BIT(12)
> 
> Thanks for updating these.
> 
> > +static int spacemit_dwmac_update_ifconfig(struct plat_stmmacenet_data *plat_dat,
> > +					  struct stmmac_resources *stmmac_res,
> > +					  struct regmap *apmu,
> > +					  unsigned int ctrl_offset)
> > +{
> > +	unsigned int mask = CTRL_PHY_INTF_MII | CTRL_PHY_INTF_RGMII | CTRL_WAKE_IRQ_EN;
> > +	unsigned int val = 0;
> > +
> > +	switch (plat_dat->phy_interface) {
> > +	case PHY_INTERFACE_MODE_MII:
> > +		val = CTRL_PHY_INTF_MII;
> > +		break;
> > +
> > +	case PHY_INTERFACE_MODE_RMII:
> > +		break;
> > +
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > +		val = CTRL_PHY_INTF_RGMII;
> > +		break;
> > +
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (stmmac_res->wol_irq >= 0)
> > +		val |= CTRL_WAKE_IRQ_EN;
> > +
> > +	return regmap_update_bits(apmu, ctrl_offset, mask, val);
> 
> I would suggest that this is split into two parts - first, this is
> renamed and reduced to just controlling CTRL_WAKE_IRQ_EN.
> 
> Next, a function hooked into plat_dat->set_phy_intf_sel which sets
> the CTRL_PHY_INTF_RGMII and CTRL_PHY_INTF_MII bits as appropriate.
> Note that this function is passed the dwmac's own phy_intf_sel
> value from common.h which will be PHY_INTF_SEL_GMII_MII,
> PHY_INTF_SEL_RGMII or PHY_INTF_SEL_RMII for you.
> 
> It would also be good to have plat_dat->get_interfaces populated
> using phy_interface_set_rgmii(), and __set_bit(PHY_INTERFACE_MODE_MII)
> and __set_bit(PHY_INTERFACE_MODE_RMII) to indicate to phylink which
> interface modes are permissable.
> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thanks for your detailed guide, I will try to switch to these helper
apis in the next version.

Regards,
Inochi

