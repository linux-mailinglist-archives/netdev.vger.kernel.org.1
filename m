Return-Path: <netdev+bounces-93834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9678BD569
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB7D1C21A49
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC6F159581;
	Mon,  6 May 2024 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qln/Agtl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2341159206;
	Mon,  6 May 2024 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023573; cv=none; b=VBRS0qk9A0jWio1QsdcdAF5z/Dh+RSB5JQt5jLz/aWZ6yR/L4ky4jmBATiXqVSQQd3IhY6TejWML38sd/bjieek9PuKrZSBHzWqbIvULLNpHJWgOLBBepHsdz9bHlL+ScsM8RAys0DiTYHmJf/1mokXwFtaBclia8TUZiZrzKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023573; c=relaxed/simple;
	bh=PUAyAttn0BKIfeZD4/qDnrmM92r9QENORaSiXUsLREY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuRVLuTKFqS+o2iWiwFHZNF9EDMFUzOzVaNwWZu/DRjZewxhVxL8c3E2J8PwZlGZZH/pFDAbwHe+FY0N24q8iwZot1yNJFR2fTFSmyXKhJN0EhLAXUZjO0GJxcg5ImyjqtMpr+9kSYCqrgN6YHTzB0T2K9qxwS2J/GUh5/qvMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qln/Agtl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LA25mCBNrIfnRuq2EfMXoCZDT7uYIaOWZsOvrNhBoRQ=; b=Ql
	n/AgtlaC1Cbc3LJq3x162IdcFC5YgfoKFBFlOWkUK7zlxvX1xMejO1sdAf1sbQf8nNIZplLcTiSLr
	4A8AuCIMrA+w0MdAjUbOmP8gvvHAJsZE+6SlQif6s/Ju2Jw8aFDjTAKF1xJHywg+YTLQkZPQGBT+O
	qZFZwQ602pDbX6o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s43yR-00EnAX-VK; Mon, 06 May 2024 21:26:07 +0200
Date: Mon, 6 May 2024 21:26:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] net: phy: bcm54811: Add LRE registers definitions
Message-ID: <b3c6fe44-f251-441a-bb0a-8617aac5c1f2@lunn.ch>
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-3-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240506144015.2409715-3-kamilh@axis.com>

On Mon, May 06, 2024 at 04:40:14PM +0200, Kamil Horák - 2N wrote:
> Add the definitions of LRE registers for Broadcom BCM5481x PHY
> ---
>  include/linux/brcmphy.h | 91 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
> index 1394ba302367..9c0b78c1b6fb 100644
> --- a/include/linux/brcmphy.h
> +++ b/include/linux/brcmphy.h
> @@ -270,16 +270,105 @@
>  #define BCM5482_SSD_SGMII_SLAVE		0x15	/* SGMII Slave Register */
>  #define BCM5482_SSD_SGMII_SLAVE_EN	0x0002	/* Slave mode enable */
>  #define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
> +#define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
> +
> +/* BroadR-Reach LRE Registers. */
> +#define MII_BCM54XX_LRECR		0x00	/* LRE Control Register                    */
> +#define MII_BCM54XX_LRESR		0x01	/* LRE Status Register                     */
> +#define MII_BCM54XX_LREPHYSID1		0x02	/* LRE PHYS ID 1                           */
> +#define MII_BCM54XX_LREPHYSID2		0x03	/* LRE PHYS ID 2                           */
> +#define MII_BCM54XX_LREANAA		0x04	/* LDS Auto-Negotiation Advertised Ability */
> +#define MII_BCM54XX_LREANAC		0x05	/* LDS Auto-Negotiation Advertised Control */
> +#define MII_BCM54XX_LREANPT		0x06	/* LDS Ability Next Page Transmit          */
> +#define MII_BCM54XX_LRELPA		0x07	/* LDS Link Partner Ability                */
> +#define MII_BCM54XX_LRELPNPM		0x08	/* LDS Link Partner Next Page Message      */
> +#define MII_BCM54XX_LRELPNPC		0x09	/* LDS Link Partner Next Page Control      */
> +#define MII_BCM54XX_LRELDSE		0x0a	/* LDS Expansion Register                  */
> +#define MII_BCM54XX_LREES		0x0f	/* LRE Extended Status                     */

Please look at these side by side to standard C22 registers. Which are
different? Is LRECR actually different to BMCR that it needs it own
define? Is LRESR different enought to BMSR that it needs its own
define? Does the ID registers use a different format?

> +/* LRE control register. */
> +#define LRECR_RESET			0x8000	/* Reset to default state      */
> +#define LRECR_LOOPBACK			0x4000	/* Internal Loopback           */
> +#define LRECR_LDSRES			0x2000	/* Restart LDS Process         */
> +#define LRECR_LDSEN			0x1000	/* LDS Enable                  */
> +#define LRECR_PDOWN			0x0800	/* Enable low power state      */
> +#define LRECR_ISOLATE			0x0400	/* Isolate data paths from MII */
> +#define LRECR_SPEED100			0x0200	/* Select 100 Mbps             */
> +#define LRECR_SPEED10			0x0000	/* Select 10 Mbps              */
> +#define LRECR_4PAIRS			0x0020	/* Select 4 Pairs              */
> +#define LRECR_2PAIRS			0x0010	/* Select 2 Pairs              */
> +#define LRECR_1PAIR			0x0000	/* Select 1 Pair               */
> +#define LRECR_MASTER			0x0008	/* Force Master when LDS disabled */
> +#define LRECR_SLAVE			0x0000	/* Force Slave when LDS disabled  */

Reverse the order of these, and then compare them to:

/* Basic mode control register. */
#define BMCR_SPEED1000          0x0040  /* MSB of Speed (1000)         */
#define BMCR_CTST               0x0080  /* Collision test              */
#define BMCR_FULLDPLX           0x0100  /* Full duplex                 */
#define BMCR_ANRESTART          0x0200  /* Auto negotiation restart    */
#define BMCR_ISOLATE            0x0400  /* Isolate data paths from MII */
#define BMCR_PDOWN              0x0800  /* Enable low power state      */
#define BMCR_ANENABLE           0x1000  /* Enable auto negotiation     */
#define BMCR_SPEED100           0x2000  /* Select 100Mbps              */
#define BMCR_LOOPBACK           0x4000  /* TXD loopback bits           */
#define BMCR_RESET              0x8000  /* Reset to default state      */

Drop any which are the same, and just add defined for those which are
different.


> +
> +/* LRE status register. */
> +#define LRESR_ERCAP			0x0001	/* Ext-reg capability          */
> +#define LRESR_JCD			0x0002	/* Jabber detected             */
> +#define LRESR_LSTATUS			0x0004	/* Link status                 */
> +#define LRESR_LDSABILITY		0x0008	/* Can do LDS                  */

What does LDS mean? In BMSR this bit is about auto-neg. How does LDS
differ from auto-neg?

Ideally, where the functionality is the same, please use the existing
definitions. It makes it easier for somebody who knows C22 to look at
the code and understand it. And it makes it easier to spot where the
differences actually are.

	Andrew

