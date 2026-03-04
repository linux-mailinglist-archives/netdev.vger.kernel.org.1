Return-Path: <netdev+bounces-263825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB7END88qGl6rQAAu9opvQ
	(envelope-from <netdev+bounces-263825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 15:05:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37643200F2F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 15:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4426930490E2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC36D3A4F5B;
	Wed,  4 Mar 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Q43SxBt9"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay92-hz2.antispameurope.com (mx-relay92-hz2.antispameurope.com [94.100.136.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547036A00F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.192
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632746; cv=pass; b=GXprRarSmCxNh/Uu7G8qWQGoAJnOwKB4dNAhNGlO/nm+kCB6+RMT0AOa/dT+WjtzePvCKs2jz/TJAbkFMhGlxKjFPhcumXXp2tp/hAP9UqhRR0BkdKCaGMQKEUCx4TnkIRee705FVcrHbt248YnZWIG7UZsk+awF8sPHsa8XzNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632746; c=relaxed/simple;
	bh=YjQvBPnz5w+n6o4jeKrsQnkPSb1XKtMdj2bYvjGkJfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acTXbOCdSl0WRJmSqrqd7ukPbSO5ZQ+iAt9A/sMocwhaH7comPbbVNkNJMESms+QweyjCpUDkGz5jaydmZhhiLofT6H8csgzmgYhc7/XBZ6cWFA5TtWURqkCcUhojCVcvc/vSjTPzSYe/yYclivCvSyo+K4426QZ0QuclNqnNHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Q43SxBt9; arc=pass smtp.client-ip=94.100.136.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate92-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=5DnBcRqn/2PHlj5yIxkWZa44u0ODIznnWZcL8KBuF3E=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772632712;
 b=YijssvdSpzqTBxujTfJBgLJSU7mVmsdTFC6Ivj+fcayaAy/I4yglHa84De0YBGLsOKnu5ehY
 YdzC7OC82+IHjzE5OOqlGkA8Kq4NYokRfD685KGyFj/5jTt/HuSfVzmo2TBAOSPgxEuFt1aqdPI
 iATPqOJi8nlZfgV9yiGNOFlqOul7FJIjN26rMQTyfbFpsvuP3whnXhB+MVgC5v7wg7Swf1nwILu
 g/TGyuvw1ceS5uVvvrCHyjHLYymx25LHNaM6EHM2WFAzFezwRpE3JO2v+9SSSrGLpzMl/2cI9Qh
 t3jVeGuMBa0BSwHA9W6ugCWHFDh5gUByZ9NWL68mG9k8w==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772632712;
 b=W5rOsfempN0w/0rtB1sBxCLldBpAi8nxPApvs3ueZUWNvglNhiLc1340LjMwasbkmPKcu5R3
 zaJYSwhSm4b+8rAMQG8UnsDj9X+puvjbPGfvEvMNSG5m+pPnLG1sX70zy5WQehpE9QD0rmcMv3F
 PQMwBsh1ryrej/96kTztYS9kBM9KQWV0rxjE7bjgVutRpt1ZI8QDZKcw6FPH9uBkZEWIo3mkPeh
 aXcOaTSMZ1K5J0sCI4DvKiVCD1AgsZPWr2As2SLQvcTQytaj/ylFh2WMr7vbDzPygpeGtLbSUYB
 soY3t7AbtsB8SViXP0t53B0bAUQkrnMB5KnNjIgxgP87g==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay92-hz2.antispameurope.com;
 Wed, 04 Mar 2026 14:58:32 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 1850C22074F;
	Wed,  4 Mar 2026 14:58:18 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Wei Fang <wei.fang@nxp.com>
Cc: aziz.sellami@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject:
 Re: [PATCH net] net: enetc: fix fallback PHY address handling and do not skip
 setting for addr 0
Date: Wed, 04 Mar 2026 14:58:18 +0100
Message-ID: <6437896.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260303103047.228005-1-wei.fang@nxp.com>
References: <20260303103047.228005-1-wei.fang@nxp.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay92-hz2.antispameurope.com with 4fQvQL6yj6z1R5Wq
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:f8a0c59699ddcf4d7cbc1c4697f18c93
X-cloud-security:scantime:2.460
DKIM-Signature: a=rsa-sha256;
 bh=5DnBcRqn/2PHlj5yIxkWZa44u0ODIznnWZcL8KBuF3E=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772632711; v=1;
 b=Q43SxBt9AC9tT62SvvqYo56cWN3zCPM2l0QvxK0RfWwTSpaD3ylttu75LIeKsr8W8r9HxBhN
 1mh26BSXBaKDcB0b0NiAvH+sdYDSmL/bNFUqfzsVWAOqOVXa7dcIJ9qQsCNymjuIZc9Vs2H7T+Z
 55+LcYd37l9sMxP5yhz9Bhc1g0PJCD4N9mjYyhB36l4LQosEPgGKmK+LthUMWvIA7FWbcS8M78X
 nTisAt3CWR95EziIFXS9CCOLqnU9QoUC2ms5UKbVp2KIEyrHxz2SJWuM3HpfY5Ca2Yqr2Ie4UE0
 z9EGLfgAmTEntv6yS+AisEGlxLdoMPPaXlf2LfuNGzr+g==
X-Rspamd-Queue-Id: 37643200F2F
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
	TAGGED_FROM(0.00)[bounces-263825-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tq-group.com:url,tq-group.com:email,nxp.com:email,ew.tq-group.com:dkim]
X-Rspamd-Action: no action

Am Dienstag, 3. M=E4rz 2026, 11:30:47 CET schrieb Wei Fang:
> The current netc_get_phy_addr() implementation falls back to PHY address
> 0 when the "mdio" node or any PHY child node is missing. On i.MX95, this
> causes failures when a real PHY is actually assigned address 0 and is
> managed through the EMDIO interface, the bit 0 of phy_mask becomes set,
> leading imx95_enetc_mdio_phyaddr_config() to return an error, and the
> netc_blk_ctrl driver probe subsequently fails. Fix this by returning
> -ENODEV when neither an "mdio" node nor any PHY node is present.
>=20
> Given that some platforms may use PHY address 0 (I suppose the PHY may
> not treat address 0 as a broadcast address or default response address).
> It is possible for some boards to connect multiple PHYs to a single
> ENETC MAC, for example:
>=20
>   - a SGMII PHY with a non-zero address (selected via DTS_A)
>   - a RGMII PHY with address 0 (selected via DTS_B)
>=20
> For the case where the ENETC port MDIO is used to manage the PHY, when
> switching from DTS_A to DTS_B via soft reboot, LaBCR[MDIO_PHYAD_PRTAD]
> must be updated to 0 because the NETCMIX block is not reset during soft
> reboot. However, the current driver explicitly skips configuring address
> 0, which leaves the hardware in an inconsistent state.
>=20
> Therefore, remove the special-case skip of PHY address 0 so that valid
> configurations using address 0 are properly supported.
>=20
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Closes: https://lore.kernel.org/all/7825188.GXAFRqVoOG@steina-w
> Fixes: 6633df05f3ad ("net: enetc: set the external PHY address in IERB fo=
r port MDIO usage")
> Fixes: 50bfd9c06f0f ("net: enetc: set external PHY address in IERB for i.=
MX94 ENETC")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Thanks,
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 24 ++++++++-----------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drive=
rs/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> index 7fd39f895290..92a0f824dae7 100644
> --- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> @@ -333,11 +333,13 @@ static int netc_get_phy_addr(struct device_node *np)
> =20
>  	mdio_node =3D of_get_child_by_name(np, "mdio");
>  	if (!mdio_node)
> -		return 0;
> +		return -ENODEV;
> =20
>  	phy_node =3D of_get_next_child(mdio_node, NULL);
> -	if (!phy_node)
> +	if (!phy_node) {
> +		err =3D -ENODEV;
>  		goto of_put_mdio_node;
> +	}
> =20
>  	err =3D of_property_read_u32(phy_node, "reg", &addr);
>  	if (err)
> @@ -423,6 +425,9 @@ static int imx95_enetc_mdio_phyaddr_config(struct pla=
tform_device *pdev)
> =20
>  			addr =3D netc_get_phy_addr(gchild);
>  			if (addr < 0) {
> +				if (addr =3D=3D -ENODEV)
> +					continue;
> +
>  				dev_err(dev, "Failed to get PHY address\n");
>  				return addr;
>  			}
> @@ -433,12 +438,6 @@ static int imx95_enetc_mdio_phyaddr_config(struct pl=
atform_device *pdev)
>  				return -EINVAL;
>  			}
> =20
> -			/* The default value of LaBCR[MDIO_PHYAD_PRTAD ] is
> -			 * 0, so no need to set the register.
> -			 */
> -			if (!addr)
> -				continue;
> -
>  			switch (bus_devfn) {
>  			case IMX95_ENETC0_BUS_DEVFN:
>  				netc_reg_write(priv->ierb, IERB_LBCR(0),
> @@ -578,16 +577,13 @@ static int imx94_enetc_mdio_phyaddr_config(struct n=
etc_blk_ctrl *priv,
> =20
>  	addr =3D netc_get_phy_addr(np);
>  	if (addr < 0) {
> +		if (addr =3D=3D -ENODEV)
> +			return 0;
> +
>  		dev_err(dev, "Failed to get PHY address\n");
>  		return addr;
>  	}
> =20
> -	/* The default value of LaBCR[MDIO_PHYAD_PRTAD] is 0,
> -	 * so no need to set the register.
> -	 */
> -	if (!addr)
> -		return 0;
> -
>  	if (phy_mask & BIT(addr)) {
>  		dev_err(dev,
>  			"Find same PHY address in EMDIO and ENETC node\n");
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



