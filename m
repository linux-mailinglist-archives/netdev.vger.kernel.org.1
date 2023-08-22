Return-Path: <netdev+bounces-29760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C9E78496C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673BA1C20BCC
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488701CA17;
	Tue, 22 Aug 2023 18:33:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4092B542
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:33:46 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B1BCD1;
	Tue, 22 Aug 2023 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ekQ2+z1rJ3Hgh9TnPo6eVKPd6yHPuM9PqoaemUvTtM8=; b=lRa+WD04bpeFSjyHCgoPsaIbnI
	n6EgIFXz69dJ5alQuX1Am2hpU9aOkHxFmJrqI0oZx5oCfAbTLuwlwhsg6lIlXLoxLQVid4M/7mlys
	teTokCNPVCWRMnWXqwd8nHk87jh6sNhysQVYrELBFHj0Fk0CrfoBbNxh0Gd6043NmR/VPZ0d6FgRd
	EhvPOatk3x2fIo9umhjUe30avKbL/CuD17F6cwlLGfgKsOIbOzixgIsLG8Fm5bLfVeLEozT6oOpcc
	AYgEgSk7NM4ICPWlj/+69v1arJfQtqStcApGSx5DHahKdLGES+RPslkuOmwCF1YszOpJ/bRYVfl0H
	f/HcePBQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35082)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qYWBp-0001pM-2r;
	Tue, 22 Aug 2023 19:33:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qYWBk-00061G-Oa; Tue, 22 Aug 2023 19:33:12 +0100
Date: Tue, 22 Aug 2023 19:33:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Henry Yen <Henry.Yen@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC net-next] net: ethernet: mtk_eth_soc: add paths and
 SerDes modes for MT7988
Message-ID: <ZOT/aIelVomIzdZk@shell.armlinux.org.uk>
References: <27c3f231485968874487f9a35cb7e8d74ca3dfd8.1692726676.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c3f231485968874487f9a35cb7e8d74ca3dfd8.1692726676.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I haven't fully reviewed this yet, but here's some initial comments.

On Tue, Aug 22, 2023 at 07:04:42PM +0100, Daniel Golle wrote:
> MT7988 comes with a built-in 2.5G PHY as well as SerDes lanes to
> connect external PHYs or transceivers in USXGMII, 10GBase-R, 5GBase-KR,

5Gbase-KR K normally means backplane mode.

> +/* Register to read PCS AN status */
> +#define RG_PCS_AN_STS0		0x81c
> +#define USXGMII_LPA_SPEED_MASK	GENMASK(11, 9)
> +#define USXGMII_LPA_SPEED_10	0
> +#define USXGMII_LPA_SPEED_100	1
> +#define USXGMII_LPA_SPEED_1000	2
> +#define USXGMII_LPA_SPEED_10000	3
> +#define USXGMII_LPA_SPEED_2500	4
> +#define USXGMII_LPA_SPEED_5000	5
> +#define USXGMII_LPA_DUPLEX	BIT(12)
> +#define USXGMII_LPA_LINK	BIT(15)

Aren't these the same as the MDIO_USXGMII_xxx definitions that define
the UsxgmiiChannelInfo[15:0] bits?

> +static int mtk_usxgmii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +				  phy_interface_t interface,
> +				  const unsigned long *advertising,
> +				  bool permit_pause_to_mac)
> +{
> +	struct mtk_usxgmii_pcs *mpcs = pcs_to_mtk_usxgmii_pcs(pcs);
> +	struct mtk_eth *eth = mpcs->eth;
> +	struct regmap *pextp = eth->regmap_pextp[mpcs->id];
> +	unsigned int an_ctrl = 0, link_timer = 0, xfi_mode = 0, adapt_mode = 0;
> +	bool mode_changed = false;
> +
> +	if (!pextp)
> +		return -ENODEV;
> +
> +	if (interface == PHY_INTERFACE_MODE_USXGMII) {
> +		an_ctrl = FIELD_PREP(USXGMII_AN_SYNC_CNT, 0x1FF) |
> +			  (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) ?

Using the new neg_mode here... but you haven't set pcs.neg_mode below
true.

> +static void mtk_usxgmii_pcs_get_state(struct phylink_pcs *pcs,
> +				      struct phylink_link_state *state)
> +{
> +	struct mtk_usxgmii_pcs *mpcs = pcs_to_mtk_usxgmii_pcs(pcs);
> +	struct mtk_eth *eth = mpcs->eth;
> +	struct mtk_mac *mac = eth->mac[mtk_xgmii2mac_id(eth, mpcs->id)];
> +	u32 val = 0;
> +
> +	regmap_read(mpcs->regmap, RG_PCS_AN_CTRL0, &val);
> +	if (FIELD_GET(USXGMII_AN_ENABLE, val)) {
> +		/* Refresh LPA by inverting LPA_LATCH */
> +		regmap_read(mpcs->regmap, RG_PCS_AN_STS0, &val);
> +		regmap_update_bits(mpcs->regmap, RG_PCS_AN_STS0,
> +				   USXGMII_LPA_LATCH,
> +				   !(val & USXGMII_LPA_LATCH));
> +
> +		regmap_read(mpcs->regmap, RG_PCS_AN_STS0, &val);
> +
> +		state->interface = mpcs->interface;
> +		state->link = FIELD_GET(USXGMII_LPA_LINK, val);
> +		state->duplex = FIELD_GET(USXGMII_LPA_DUPLEX, val);
> +
> +		switch (FIELD_GET(USXGMII_LPA_SPEED_MASK, val)) {
> +		case USXGMII_LPA_SPEED_10:
> +			state->speed = SPEED_10;
> +			break;
> +		case USXGMII_LPA_SPEED_100:
> +			state->speed = SPEED_100;
> +			break;
> +		case USXGMII_LPA_SPEED_1000:
> +			state->speed = SPEED_1000;
> +			break;
> +		case USXGMII_LPA_SPEED_2500:
> +			state->speed = SPEED_2500;
> +			break;
> +		case USXGMII_LPA_SPEED_5000:
> +			state->speed = SPEED_5000;
> +			break;
> +		case USXGMII_LPA_SPEED_10000:
> +			state->speed = SPEED_10000;
> +			break;
> +		}

Maybe consider using phylink_decode_usxgmii_word() ?

> +	} else {
> +		val = mtk_r32(mac->hw, MTK_XGMAC_STS(mac->id));
> +
> +		if (mac->id == MTK_GMAC2_ID)
> +			val >>= 16;
> +
> +		switch (FIELD_GET(MTK_USXGMII_PCS_MODE, val)) {
> +		case 0:
> +			state->speed = SPEED_10000;
> +			break;
> +		case 1:
> +			state->speed = SPEED_5000;
> +			break;
> +		case 2:
> +			state->speed = SPEED_2500;
> +			break;
> +		case 3:
> +			state->speed = SPEED_1000;
> +			break;
> +		}
> +
> +		state->interface = mpcs->interface;
> +		state->link = FIELD_GET(MTK_USXGMII_PCS_LINK, val);
> +		state->duplex = DUPLEX_FULL;
> +	}
> +
> +	if (state->link == 0)
> +		mtk_usxgmii_pcs_config(pcs, MLO_AN_INBAND,

Passing old-style mode rather than neg_mode here.

> +				       state->interface, NULL, false);

It would be good to describe why you're reconfiguring the interface
here. You describe why in mtk_usxgmii_pcs_link_up...

> +		eth->usxgmii_pcs[i] = devm_kzalloc(dev, sizeof(*eth->usxgmii_pcs), GFP_KERNEL);
> +		if (!eth->usxgmii_pcs[i])
> +			return -ENOMEM;
> +
> +		eth->usxgmii_pcs[i]->id = i;
> +		eth->usxgmii_pcs[i]->eth = eth;
> +		eth->usxgmii_pcs[i]->regmap = syscon_node_to_regmap(np);
> +		if (IS_ERR(eth->usxgmii_pcs[i]->regmap))
> +			return PTR_ERR(eth->usxgmii_pcs[i]->regmap);
> +
> +		eth->usxgmii_pcs[i]->pcs.ops = &mtk_usxgmii_pcs_ops;
> +		eth->usxgmii_pcs[i]->pcs.poll = true;
> +		eth->usxgmii_pcs[i]->interface = PHY_INTERFACE_MODE_NA;

All new PCS should set pcs.neg_mode true.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

