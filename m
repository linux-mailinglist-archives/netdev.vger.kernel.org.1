Return-Path: <netdev+bounces-261841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCpCFp+foWl8ugQAu9opvQ
	(envelope-from <netdev+bounces-261841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:43:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A681B7D1D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E31683020A79
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6142B3A9D83;
	Fri, 27 Feb 2026 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GQNvOt82"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay48-hz3.antispameurope.com (mx-relay48-hz3.antispameurope.com [94.100.134.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB97330334
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.237
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199731; cv=pass; b=AixTOhih8aDlFhDlgE4JifUW53Az+McsUnNc9uxui+dU/QCNllfZxmuTladalUQ+bRSgEIAtgEqphlhmBP0a2kLgIKUnzLWKUvC7B25pt9kqw4LSi3wHs07MxtjcJOJX5J7U+UQxHwITJN1diV85AgUmPHplkRWGakWirHjxG6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199731; c=relaxed/simple;
	bh=jLVFCfmCwwDGYyE2TA37Jk9yg0QSrnQZYu/oVIAKa00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKPe57dWx/4iNUCGAVEMxDHFyQ5mBVFzsZUgPQRitH8NOFubPqxVaO/Xpa35XYKAw/CZgw625C+Z28rEjEZ12PHtARy5Ot/tNBQIyLw7aVublHCLOCTv33DbKSDT/cVoMIgF1xCIKq7hHmb6z93gmYNZENFitJ2Myc//1VuRF90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GQNvOt82; arc=pass smtp.client-ip=94.100.134.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=yd7VoGo5h85v/tCZbd5Wr9gZqrsgFKoh7cUl95XNvMI=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772199714;
 b=Hm9wMElSHFOsULVAqPdaC/DTyJy25DiErH2ZGIrxezoDglF9aREogrgBUdkrNuPt0swn5Xfa
 RItPskxZ9OUMFVxVG5amD4y9hxmfVbCup6cEWdGKPfA9VbcuCvQN55aK29ZMdZS5/HgQBcfs9R+
 2nt3YoomHgd57kiBbT+xYIx4lNPiKkH7b1ESuIgBnIW9grt1j3j0LuPXm/TbKARA3oao5gfiWdW
 +VCFbB65Zr3fwFG+ta7/77n9hXKuPe+O5g6/3erO5gHVJ6m1w4mUz9grlCmO8RbSgiE6Tq62FmF
 U75PsZtsj9jcgvHA+GfysgtryKmuddBHgkR8pGqLICe+w==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772199714;
 b=qJtOUTerm+7yhPc5CijJHlcu0pyRmLV9A+yzDvK5BGsjfP6b7E1jRiNcP1ZjfcliL6oXbZZD
 Ky98B8aEQr41H/Tgi26Da+Zz7J2kVcLokUUBLT3ZR4jpWbOtOuBpPECnu6QPEZzakEgOS+BU3Oc
 HLg2K/BtnzW+yRFKBGBat/sMcVpK80EpltFBbZxOBfE0kQICWKW+uHDm1pDUodsV30PpXPcpi2G
 S0NDMBuiUZhOFjsWtmmJMV6HkxTxiXJZPBXcoZOwIlqJXJbsX2ZFnj03NvOT/Cqvga0PEcOSUWF
 W6SNqxjnMPNEc2PI5JuWKXDWBxYrGEGJlv+exuIpXca9w==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay48-hz3.antispameurope.com;
 Fri, 27 Feb 2026 14:41:54 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id E8E585A0F0A;
	Fri, 27 Feb 2026 14:41:40 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Wei Fang <wei.fang@nxp.com>
Cc: aziz.sellami@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 net-next 1/3] net: enetc: set the external PHY address in IERB
 for port MDIO usage
Date: Fri, 27 Feb 2026 14:41:40 +0100
Message-ID: <7825188.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20251119102557.1041881-2-wei.fang@nxp.com>
References:
 <20251119102557.1041881-1-wei.fang@nxp.com>
 <20251119102557.1041881-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay48-hz3.antispameurope.com with 4fMqHT4hrrz1kNt46
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:06b01824bbfbcb4227c6efdf7863bdb3
X-cloud-security:scantime:1.786
DKIM-Signature: a=rsa-sha256;
 bh=yd7VoGo5h85v/tCZbd5Wr9gZqrsgFKoh7cUl95XNvMI=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772199714; v=1;
 b=GQNvOt82KQDUd8i+chfLEjQN00Zh26MBKiG/FPdJrwy66R1Tp5GSItNqKDn2gvYiZt+0xsfK
 bGXeHs61NsIlox23N2Q8oy9uurs++Ncjq6sMJYx5pmTxWmLcSv6BZ3OZkIhZTsNHm6x52KD0Fw6
 xXAeJGgRE9VVLueljd9Ne+b4hqGtJ/kxp0rvsLwaJqBN7aWFhgRjFnkAoXsqDWvcNJE/qbuNDA9
 j20YI4DNBJniPQZLHbC9sfMVK0j7HUsItDRJNzyKadZ++s/suCncF4gLw0egs7hCjostoKpxmZS
 90Gia8YPo10UXV2CTvFb5Fvg8To9gVTh2nq0knieIpb+Q==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=hse1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261841-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,0.0.0.0:email,ew.tq-group.com:dkim]
X-Rspamd-Queue-Id: A1A681B7D1D
X-Rspamd-Action: no action

Hi,

sorry for the very late reply. I didn't get the chance to boot our
i.MX95 based board (TQMa95xxSA) in the meantime.

Am Mittwoch, 19. November 2025, 11:25:55 CET schrieb Wei Fang:
> The ENETC supports managing its own external PHY through its port MDIO
> functionality. To use this function, the PHY address needs be set in the
> corresponding LaBCR register in the Integrated Endpoint Register Block
> (IERB), which is used for pre-boot initialization of NETC PCIe functions.
> The port MDIO can only work properly when the PHY address accessed by the
> port MDIO matches the corresponding LaBCR[MDIO_PHYAD_PRTAD] value.
>=20
> Because the ENETC driver only registers the MDIO bus (port MDIO bus) when
> it detects an MDIO child node in its node, similarly, the netc-blk-ctrl
> driver only resolves the PHY address and sets it in the corresponding
> LaBCR when it detects an MDIO child node in the ENETC node.
>=20
> Co-developed-by: Aziz Sellami <aziz.sellami@nxp.com>
> Signed-off-by: Aziz Sellami <aziz.sellami@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 141 +++++++++++++++++-
>  1 file changed, 140 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drive=
rs/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> index d7aee3c934d3..6dd54b0d9616 100644
> --- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> @@ -67,6 +67,9 @@
>  #define IERB_EMDIOFAUXR			0x344
>  #define IERB_T0FAUXR			0x444
>  #define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
> +#define IERB_LBCR(a)			(0x1010 + 0x40 * (a))
> +#define  LBCR_MDIO_PHYAD_PRTAD(addr)	(((addr) & 0x1f) << 8)
> +
>  #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
>  #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
>  #define FAUXR_LDID			GENMASK(3, 0)
> @@ -322,6 +325,142 @@ static int netc_unlock_ierb_with_warm_reset(struct =
netc_blk_ctrl *priv)
>  				 1000, 100000, true, priv->prb, PRB_NETCRR);
>  }
> =20
> +static int netc_get_phy_addr(struct device_node *np)
> +{
> +	struct device_node *mdio_node, *phy_node;
> +	u32 addr =3D 0;
> +	int err =3D 0;
> +
> +	mdio_node =3D of_get_child_by_name(np, "mdio");
> +	if (!mdio_node)
> +		return 0;

If there is no 'mdio' node below enetc_portX node, then 0 is returned...

> +
> +	phy_node =3D of_get_next_child(mdio_node, NULL);
> +	if (!phy_node)
> +		goto of_put_mdio_node;
> +
> +	err =3D of_property_read_u32(phy_node, "reg", &addr);
> +	if (err)
> +		goto of_put_phy_node;
> +
> +	if (addr >=3D PHY_MAX_ADDR)
> +		err =3D -EINVAL;
> +
> +of_put_phy_node:
> +	of_node_put(phy_node);
> +
> +of_put_mdio_node:
> +	of_node_put(mdio_node);
> +
> +	return err ? err : addr;
> +}
> +
> +static int netc_parse_emdio_phy_mask(struct device_node *np, u32 *phy_ma=
sk)
> +{
> +	u32 mask =3D 0;
> +
> +	for_each_child_of_node_scoped(np, child) {
> +		u32 addr;
> +		int err;
> +
> +		err =3D of_property_read_u32(child, "reg", &addr);
> +		if (err)
> +			return err;
> +
> +		if (addr >=3D PHY_MAX_ADDR)
> +			return -EINVAL;
> +
> +		mask |=3D BIT(addr);
> +	}
> +
> +	*phy_mask =3D mask;
> +
> +	return 0;
> +}
> +
> +static int netc_get_emdio_phy_mask(struct device_node *np, u32 *phy_mask)
> +{
> +	for_each_child_of_node_scoped(np, child) {
> +		for_each_child_of_node_scoped(child, gchild) {
> +			if (!of_device_is_compatible(gchild, "pci1131,ee00"))
> +				continue;
> +
> +			return netc_parse_emdio_phy_mask(gchild, phy_mask);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv =3D platform_get_drvdata(pdev);
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct device *dev =3D &pdev->dev;
> +	int bus_devfn, addr, err;
> +	u32 phy_mask =3D 0;
> +
> +	err =3D netc_get_emdio_phy_mask(np, &phy_mask);
> +	if (err) {
> +		dev_err(dev, "Failed to get PHY address mask\n");
> +		return err;
> +	}
> +
> +	/* Update the port EMDIO PHY address through parsing phy properties.
> +	 * This is needed when using the port EMDIO but it's harmless when
> +	 * using the central EMDIO. So apply it on all cases.
> +	 */
> +	for_each_child_of_node_scoped(np, child) {
> +		for_each_child_of_node_scoped(child, gchild) {
> +			if (!of_device_is_compatible(gchild, "pci1131,e101"))
> +				continue;
> +
> +			bus_devfn =3D netc_of_pci_get_bus_devfn(gchild);
> +			if (bus_devfn < 0) {
> +				dev_err(dev, "Failed to get BDF number\n");
> +				return bus_devfn;
> +			}
> +
> +			addr =3D netc_get_phy_addr(gchild);
> +			if (addr < 0) {
> +				dev_err(dev, "Failed to get PHY address\n");
> +				return addr;
> +			}
> +
> +			if (phy_mask & BIT(addr)) {

=2E.. which will break here if there is an Ethernet PHY using address 0 in =
'netc_emdio' node.
See arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi node ethernet-phy@0.

Best regards,
Alexander

> +				dev_err(dev,
> +					"Find same PHY address in EMDIO and ENETC node\n");
> +				return -EINVAL;
> +			}
> +
> +			/* The default value of LaBCR[MDIO_PHYAD_PRTAD ] is
> +			 * 0, so no need to set the register.
> +			 */
> +			if (!addr)
> +				continue;
> +
> +			switch (bus_devfn) {
> +			case IMX95_ENETC0_BUS_DEVFN:
> +				netc_reg_write(priv->ierb, IERB_LBCR(0),
> +					       LBCR_MDIO_PHYAD_PRTAD(addr));
> +				break;
> +			case IMX95_ENETC1_BUS_DEVFN:
> +				netc_reg_write(priv->ierb, IERB_LBCR(1),
> +					       LBCR_MDIO_PHYAD_PRTAD(addr));
> +				break;
> +			case IMX95_ENETC2_BUS_DEVFN:
> +				netc_reg_write(priv->ierb, IERB_LBCR(2),
> +					       LBCR_MDIO_PHYAD_PRTAD(addr));
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int imx95_ierb_init(struct platform_device *pdev)
>  {
>  	struct netc_blk_ctrl *priv =3D platform_get_drvdata(pdev);
> @@ -349,7 +488,7 @@ static int imx95_ierb_init(struct platform_device *pd=
ev)
>  	/* NETC TIMER */
>  	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
> =20
> -	return 0;
> +	return imx95_enetc_mdio_phyaddr_config(pdev);
>  }
> =20
>  static int imx94_get_enetc_id(struct device_node *np)
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



