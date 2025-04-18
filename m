Return-Path: <netdev+bounces-184065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20288A93095
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 05:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C90444CD5
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C91C5485;
	Fri, 18 Apr 2025 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b="DPcZ735f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TXINkV89"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3A23AD
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744945472; cv=none; b=HGQAPwSjMLojvFyqYy/0M+A/BlRXit9npRn1J0LoNiuaZrPf/Y0/tdq70w93wczMsPEC8HuPeMP1d4lJiTflGh6oAx9S5UT+iwfCxZk1tGHub63qMa8t4n0LhpsMZ23xGhhvYdZG7N8c4rkhaxdLmS0hbvlMD1RcF+Xf77CobIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744945472; c=relaxed/simple;
	bh=eRukUZMe8g68G7MrdAupVSKVP0KA4yLwHp07VM3k6OU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KNuGdqBaXVz23APf9ct2/0uoLBh8Yhfmr6TGwzwNFQo5VWqJIKFdcWXVG9hoTHRG53KbT4DEfKRXfc03ypDX0zpV4cznPl0ayCsvbmH95d1G6PRl43ijoyNlRQOasB2zh5A+8ZsZBMNmfPswGokcfhxInqvm0s/v3QeuvT31+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au; spf=pass smtp.mailfrom=traverse.com.au; dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b=DPcZ735f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TXINkV89; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=traverse.com.au
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5BF81140135;
	Thu, 17 Apr 2025 23:04:27 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-01.internal (MEProxy); Thu, 17 Apr 2025 23:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1744945467; x=1745031867; bh=YSblgLG2ncNrSgO9fePQMpL+vbff589c
	OtDlv186mZs=; b=DPcZ735fauqwDn4l6FV9Ja/iowDVxmWlu7/KbFPJ9oOsxGS6
	DTsmFsKziwWTgE1PjHaoPGtjOSrGwyrf4SAE2sK5IQkYkGBuzL/S9RIUWvPq3EVM
	ICLgYk0wfYxdUd5Cpu5MbZAKhmpvzuMFDYrSHrCkqhxTWkhWqmyEh3un3uHV3RZG
	nLd2RhZGuDvoFPd/1Jgce60FRwYXIqs7I1mezb+4shVDAZqtzawv6H3ZADLIm1Iz
	LAvBFWX1Mj0ER54eaPAtFM9HqChAaHEr6mdiakws4fb1o9O4MEWsfhTJdq7NHo02
	RTF0yxd34QGMDpw/w7m1WJgcIICDmjnHkZ3okw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744945467; x=
	1745031867; bh=YSblgLG2ncNrSgO9fePQMpL+vbff589cOtDlv186mZs=; b=T
	XINkV89MvjpG6W6WenXFc4v3Lv5lMy+ow3aLtItofJPRNZFWug26KMuDzp7ijxDi
	+FhUZESzn199+0yi/auAZEXfA5yIv6Bs5GAsUc1oKVwPiRYvwN3yUgWiNOdKY6uv
	ZuUgt+c13utxPRde3Ne85Epla12vHIrUugSNtdtQudQm8B12a9wysGtHOaQkFKBO
	8INjZU6xxNAp/gVYiSfTFsLXuzCyWdHdyCOnjU5eN8HHUwjUPnrDw19I1v6lFlmJ
	OOF2XYFtuIaRX10G5hWvRG28LBc2bQAdQhPLb+LNTNlr8gTzMVgqK5ULjd0Qvr55
	TrTzqZqcRubjuhWX/rZKQ==
X-ME-Sender: <xms:OsEBaMHgkMsL5kkyuQejq0yDb5750G6cstFtjJDOueLE3YKMiXP4Cg>
    <xme:OsEBaFU0f65B1HjcW8QOGL7kS3vZoPtQPYvsexp_VpXmv6t-hZxfIKXx1ANrxk1Au
    nVV0GuIvzt3Cj1z3S8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfofgrthhhvgifucfotgeurhhiuggvfdcuoehmrghtthesthhrrg
    hvvghrshgvrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepvdeitdeufeffheeltddu
    tddtuddugfdtveffffekvdffvdfhgfejuedtgeeluddtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrthhtsehtrhgrvhgvrhhsvgdrtgho
    mhdrrghupdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhhmkhdokhgvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthht
    ohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehhkhgrlhhlfi
    gvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthht
    oheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepihhorghnrgdrtghiohhrnh
    gvihesnhigphdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:OsEBaGL-6YA5A877Id9It6jAdE2cYDj-3aXBikfdpp7CVOgNqeK4GA>
    <xmx:OsEBaOHHaOFk61-2FvcbgmUBPwB4h4ceMSesgpQ8Rm796SokgX0u7w>
    <xmx:OsEBaCUF4boRmsPnLjSWzZNeDMMUgB6KuBoUFGH26nGT2yu88l3C8g>
    <xmx:OsEBaBMLcRE5WyaZPfUtU4LMlN15AdAQcvKilRdi6QrmqM02YOkFvw>
    <xmx:O8EBaK7l5K9RrTRzpxV4gr0zcUt8CHIhwwz6GoTyC7r1VuRNzj7czOZ6>
Feedback-ID: i426947f3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5BDCB78006B; Thu, 17 Apr 2025 23:04:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Apr 2025 13:02:19 +1000
From: "Mathew McBride" <matt@traverse.com.au>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: "Ioana Ciornei" <ioana.ciornei@nxp.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
 "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 regressions@lists.linux.dev
Message-Id: <025c0ebe-5537-4fa3-b05a-8b835e5ad317@app.fastmail.com>
In-Reply-To: <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
Subject: [REGRESSION] net: pcs-lynx: 10G SFP no longer links up
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

#regzbot introduced: 6561f0e547be221f411fda5eddfcc5bd8bb058a5

Hi Russell,

On Thu, Dec 5, 2024, at 8:42 PM, Russell King (Oracle) wrote:
> Report the PCS in-band capabilities to phylink for the Lynx PCS.
> 

The implementation of in-band capabilities has broken SFP+ (10GBase-R) mode on my LS1088 board.
The other ports in the system (QSGMII) work fine.

$ dmesg | grep -E (eth8|dpmac2-sfp)
sfp dpmac2-sfp: module FS               SFPP-AO02        rev B1   sn F1940200586-2    dc 200615
fsl_dpaa2_eth dpni.1 eth8: autoneg setting not compatible with PCS
$ sudo ip link set eth8 up
fsl_dpaa2_eth dpni.1 eth8: configuring for inband/10gbase-r link mode 
< no link up occurs>

Reverting this exact commit resolves the issue, and the SFP comes up as normal:

fsl_dpaa2_eth dpni.1 eth8: configuring for inband/10gbase-r link mode
fsl_dpaa2_eth dpni.1 eth8: Link is Up - 10Gbps/Full - flow control off

The changes that were merged into net-next recently ("net: phylink: fix PCS without autoneg") did not resolve this problem.

Obviously, I don't think this particular patch is responsible (but it's what the bisect arrives at). Do you have any suggestions on where to insert some tracing/debug?

Transceiver information:
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
        Connector                                 : 0x21 (Copper pigtail)
        Transceiver codes                         : 0x00 0x00 0x00 0x00 0x00 0x08 0x00 0x00 0x00
        Transceiver type                          : Active Cable
        Encoding                                  : 0x00 (unspecified)
        BR, Nominal                               : 10300MBd
        Rate identifier                           : 0x00 (unspecified)
        Length (SMF,km)                           : 0km
        Length (SMF)                              : 0m
        Length (50um)                             : 0m
        Length (62.5um)                           : 0m
        Length (Copper)                           : 3m
        Length (OM3)                              : 0m
        Active Cu cmplnce.                        : 0x0c (unknown) [SFF-8472 rev10.4 only]
        Vendor name                               : FS
        Vendor OUI                                : 00:17:6a
        Vendor PN                                 : SFPP-AO02
        Vendor rev                                : B1
        Option values                             : 0x00 0x12
        Option                                    : RX_LOS implemented
        Option                                    : TX_DISABLE implemented
        BR margin, max                            : 0%
        BR margin, min                            : 0%
        Vendor SN                                 : F1940200586-2
        Date code                                 : 200615

Passive cables are also affected:
        Transceiver codes                         : 0x00 0x00 0x00 0x00 0x00 0x04 0x00 0x00 0x00
        Transceiver type                          : Passive Cable

Best Regards,
Matt

> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk <mailto:rmk%2Bkernel@armlinux.org.uk>>
> ---
> drivers/net/pcs/pcs-lynx.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> index b79aedad855b..767a8c0714ac 100644
> --- a/drivers/net/pcs/pcs-lynx.c
> +++ b/drivers/net/pcs/pcs-lynx.c
> @@ -35,6 +35,27 @@ enum sgmii_speed {
> #define phylink_pcs_to_lynx(pl_pcs) container_of((pl_pcs), struct lynx_pcs, pcs)
> #define lynx_to_phylink_pcs(lynx) (&(lynx)->pcs)
>  
> +static unsigned int lynx_pcs_inband_caps(struct phylink_pcs *pcs,
> + phy_interface_t interface)
> +{
> + switch (interface) {
> + case PHY_INTERFACE_MODE_1000BASEX:
> + case PHY_INTERFACE_MODE_SGMII:
> + case PHY_INTERFACE_MODE_QSGMII:
> + return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
> +
> + case PHY_INTERFACE_MODE_10GBASER:
> + case PHY_INTERFACE_MODE_2500BASEX:
> + return LINK_INBAND_DISABLE;
> +
> + case PHY_INTERFACE_MODE_USXGMII:
> + return LINK_INBAND_ENABLE;
> +
> + default:
> + return 0;
> + }
> +}
> +
> static void lynx_pcs_get_state_usxgmii(struct mdio_device *pcs,
>        struct phylink_link_state *state)
> {
> @@ -306,6 +327,7 @@ static void lynx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
> }
>  
> static const struct phylink_pcs_ops lynx_pcs_phylink_ops = {
> + .pcs_inband_caps = lynx_pcs_inband_caps,
> .pcs_get_state = lynx_pcs_get_state,
> .pcs_config = lynx_pcs_config,
> .pcs_an_restart = lynx_pcs_an_restart,
> -- 
> 2.30.2
> 
> 

