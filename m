Return-Path: <netdev+bounces-292750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF0eFwNvGGoSkAgAu9opvQ
	(envelope-from <netdev+bounces-292750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:36:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C982A5F5106
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 747E7328BE7F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E568A3FF8AE;
	Thu, 28 May 2026 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqmCgD+V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828433FF1A2;
	Thu, 28 May 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983734; cv=none; b=CEgX9aSTkx0iGTqqbsQBl1I6zmNv4CTIVaQt4RcoGiyOcjLFiZT1xQTkWppv/uP4RVVeLZNSdBHo8TJoQ+jcfi3Yah+vsxrHBItar/bQXoWaXRS6IXIkotcXFkOVZhqarNsde6bkBliwrDVJo4z2/gsmznZP2MlZot7NB1y5hB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983734; c=relaxed/simple;
	bh=49g/W4nPFGn+vpZROvQnXPRYmRCLYo6lZkJSzpL1b2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VTed9bnMySxzmcFBdhhndtqs1RtscMyKxi/ZmNCAM4HHL26QaavgDzWtqC4gD8Z4YiFQKEK1u/I2G9Vz4q6Yqfg6rRdDJUBzsNoPbfRT7hYkOVG8Bf9vpeCVgPSZamcZ3u9Ja3zdsaCe3XOcvQMWrZtXDMim4jUAonnoMtPDvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqmCgD+V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787981F000E9;
	Thu, 28 May 2026 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779983733;
	bh=+BWIkJYelMwDM/RJ8EOI6yq0aaQUtuHk+/lFKFUusWg=;
	h=Date:From:To:Cc:Subject;
	b=lqmCgD+Vc99G1kH6NNNXA/HlOc+oYucOuw5M5dpElI+mQ20RvBkBFr+l7WUC2wKA+
	 ikNEEjcCrcbPgive+feZXAY9KFc2LxXwc0RK2Y9eWscYJzxNgV1EvuI9Jg1ToPAcdd
	 /NH2IPAELi076xjJt0DmX+Do9Z3GseS8HLJ0bCapBaX0cMXBz4k60XzZ+fIgldgljH
	 2xuWhtyqtY0eCM5UGjQSBTmVTQrgpmRvPiilZRmm6HBWADukPKYMfHr5ZmbtX4Ys4J
	 In1/lnW9Y4L4gasuZWXqjVhKG8XICaf1AACYPdVzu940ajvPJV9SfupRA8X/K/ckdC
	 BSk59uDWabdrA==
Date: Thu, 28 May 2026 16:55:28 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Lucien Jheng <lucienzx159@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <ahhlcK0ufJn0VEzM@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="soxlRVeWDInW4BKF"
Content-Disposition: inline
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292750-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,collabora.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Queue-Id: C982A5F5106
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--soxlRVeWDInW4BKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/phy/air_en8811h.c

between commit:

  d895767c33781 ("net: phy: air_en8811h: add AN8811HB MCU assert/deassert s=
upport")

=66rom the net tree and commits:

  dddfadd75197e ("net: phy: Add Airoha phy library for shared code")
  5226bb6634cdf ("net: phy: air_phy_lib: Factorize BuckPBus register access=
ors")
  e08f0ea6daf2e ("net: phy: Rename Airoha common BuckPBus register accessor=
s")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/net/phy/air_en8811h.c
index a86129ce693c2,a42898ae41358..0000000000000
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@@ -260,218 -229,6 +245,31 @@@ static const unsigned long en8811h_led_
  					      BIT(TRIGGER_NETDEV_RX)          |
  					      BIT(TRIGGER_NETDEV_TX);
 =20
- static int air_phy_read_page(struct phy_device *phydev)
- {
- 	return __phy_read(phydev, AIR_EXT_PAGE_ACCESS);
- }
-=20
- static int air_phy_write_page(struct phy_device *phydev, int page)
- {
- 	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
- }
-=20
 +static int __air_pbus_reg_write(struct mdio_device *mdiodev,
 +				u32 pbus_reg, u32 pbus_data)
 +{
 +	int ret;
 +
 +	ret =3D __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_EXT_PAGE_ACCESS,
 +			      upper_16_bits(pbus_reg));
 +	if (ret < 0)
 +		return ret;
 +
 +	ret =3D __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_ADDR_HIGH,
 +			      FIELD_GET(AIR_PBUS_REG_ADDR_HIGH_MASK, pbus_reg));
 +	if (ret < 0)
 +		return ret;
 +
 +	ret =3D __mdiobus_write(mdiodev->bus, mdiodev->addr,
 +			      FIELD_GET(AIR_PBUS_REG_ADDR_LOW_MASK, pbus_reg),
 +			      lower_16_bits(pbus_data));
 +	if (ret < 0)
 +		return ret;
 +
 +	return __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_DATA_HIGH,
 +			       upper_16_bits(pbus_data));
 +}
 +
- static int __air_buckpbus_reg_write(struct phy_device *phydev,
- 				    u32 pbus_address, u32 pbus_data)
- {
- 	int ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
- 	if (ret < 0)
- 		return ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_WR_ADDR_HIGH,
- 			  upper_16_bits(pbus_address));
- 	if (ret < 0)
- 		return ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_WR_ADDR_LOW,
- 			  lower_16_bits(pbus_address));
- 	if (ret < 0)
- 		return ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_WR_DATA_HIGH,
- 			  upper_16_bits(pbus_data));
- 	if (ret < 0)
- 		return ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_WR_DATA_LOW,
- 			  lower_16_bits(pbus_data));
- 	if (ret < 0)
- 		return ret;
-=20
- 	return 0;
- }
-=20
- static int air_buckpbus_reg_write(struct phy_device *phydev,
- 				  u32 pbus_address, u32 pbus_data)
- {
- 	int saved_page;
- 	int ret =3D 0;
-=20
- 	saved_page =3D phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
-=20
- 	if (saved_page >=3D 0) {
- 		ret =3D __air_buckpbus_reg_write(phydev, pbus_address,
- 					       pbus_data);
- 		if (ret < 0)
- 			phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
- 				   pbus_address, ret);
- 	}
-=20
- 	return phy_restore_page(phydev, saved_page, ret);
- }
-=20
- static int __air_buckpbus_reg_read(struct phy_device *phydev,
- 				   u32 pbus_address, u32 *pbus_data)
- {
- 	int pbus_data_low, pbus_data_high;
- 	int ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
- 	if (ret < 0)
- 		return ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_RD_ADDR_HIGH,
- 			  upper_16_bits(pbus_address));
- 	if (ret < 0)
- 		return ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_RD_ADDR_LOW,
- 			  lower_16_bits(pbus_address));
- 	if (ret < 0)
- 		return ret;
-=20
- 	pbus_data_high =3D __phy_read(phydev, AIR_BPBUS_RD_DATA_HIGH);
- 	if (pbus_data_high < 0)
- 		return pbus_data_high;
-=20
- 	pbus_data_low =3D __phy_read(phydev, AIR_BPBUS_RD_DATA_LOW);
- 	if (pbus_data_low < 0)
- 		return pbus_data_low;
-=20
- 	*pbus_data =3D pbus_data_low | (pbus_data_high << 16);
- 	return 0;
- }
-=20
- static int air_buckpbus_reg_read(struct phy_device *phydev,
- 				 u32 pbus_address, u32 *pbus_data)
- {
- 	int saved_page;
- 	int ret =3D 0;
-=20
- 	saved_page =3D phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
-=20
- 	if (saved_page >=3D 0) {
- 		ret =3D __air_buckpbus_reg_read(phydev, pbus_address, pbus_data);
- 		if (ret < 0)
- 			phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
- 				   pbus_address, ret);
- 	}
-=20
- 	return phy_restore_page(phydev, saved_page, ret);
- }
-=20
- static int __air_buckpbus_reg_modify(struct phy_device *phydev,
- 				     u32 pbus_address, u32 mask, u32 set)
- {
- 	int pbus_data_low, pbus_data_high;
- 	u32 pbus_data_old, pbus_data_new;
- 	int ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
- 	if (ret < 0)
- 		return ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_RD_ADDR_HIGH,
- 			  upper_16_bits(pbus_address));
- 	if (ret < 0)
- 		return ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_RD_ADDR_LOW,
- 			  lower_16_bits(pbus_address));
- 	if (ret < 0)
- 		return ret;
-=20
- 	pbus_data_high =3D __phy_read(phydev, AIR_BPBUS_RD_DATA_HIGH);
- 	if (pbus_data_high < 0)
- 		return pbus_data_high;
-=20
- 	pbus_data_low =3D __phy_read(phydev, AIR_BPBUS_RD_DATA_LOW);
- 	if (pbus_data_low < 0)
- 		return pbus_data_low;
-=20
- 	pbus_data_old =3D pbus_data_low | (pbus_data_high << 16);
- 	pbus_data_new =3D (pbus_data_old & ~mask) | set;
- 	if (pbus_data_new =3D=3D pbus_data_old)
- 		return 0;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_WR_ADDR_HIGH,
- 			  upper_16_bits(pbus_address));
- 	if (ret < 0)
- 		return ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_WR_ADDR_LOW,
- 			  lower_16_bits(pbus_address));
- 	if (ret < 0)
- 		return ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_WR_DATA_HIGH,
- 			  upper_16_bits(pbus_data_new));
- 	if (ret < 0)
- 		return ret;
-=20
- 	ret =3D __phy_write(phydev, AIR_BPBUS_WR_DATA_LOW,
- 			  lower_16_bits(pbus_data_new));
- 	if (ret < 0)
- 		return ret;
-=20
- 	return 0;
- }
-=20
- static int air_buckpbus_reg_modify(struct phy_device *phydev,
- 				   u32 pbus_address, u32 mask, u32 set)
- {
- 	int saved_page;
- 	int ret =3D 0;
-=20
- 	saved_page =3D phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
-=20
- 	if (saved_page >=3D 0) {
- 		ret =3D __air_buckpbus_reg_modify(phydev, pbus_address, mask,
- 						set);
- 		if (ret < 0)
- 			phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
- 				   pbus_address, ret);
- 	}
-=20
- 	return phy_restore_page(phydev, saved_page, ret);
- }
-=20
  static int __air_write_buf(struct phy_device *phydev, u32 address,
  			   const struct firmware *fw)
  {
@@@ -664,16 -373,8 +463,16 @@@ static int an8811hb_load_firmware(struc
  {
  	int ret;
 =20
 +	ret =3D an8811hb_mcu_assert(phydev);
 +	if (ret < 0)
 +		return ret;
 +
 +	ret =3D an8811hb_mcu_deassert(phydev);
 +	if (ret < 0)
 +		return ret;
 +
- 	ret =3D air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
- 				     EN8811H_FW_CTRL_1_START);
+ 	ret =3D air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+ 					 EN8811H_FW_CTRL_1_START);
  	if (ret < 0)
  		return ret;
 =20
@@@ -760,18 -461,8 +559,18 @@@ static int en8811h_restart_mcu(struct p
  {
  	int ret;
 =20
 +	if (phy_id_compare_model(phydev->phy_id, AN8811HB_PHY_ID)) {
 +		ret =3D an8811hb_mcu_assert(phydev);
 +		if (ret < 0)
 +			return ret;
 +
 +		ret =3D an8811hb_mcu_deassert(phydev);
 +		if (ret < 0)
 +			return ret;
 +	}
 +
- 	ret =3D air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
- 				     EN8811H_FW_CTRL_1_START);
+ 	ret =3D air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+ 					 EN8811H_FW_CTRL_1_START);
  	if (ret < 0)
  		return ret;
 =20
@@@ -1324,23 -996,16 +1123,23 @@@ static int an8811hb_probe(struct phy_de
  	/* Co-Clock Output */
  	ret =3D an8811hb_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
  	if (ret)
 -		return ret;
 +		goto err_dev_create;
 =20
  	/* Configure led gpio pins as output */
- 	ret =3D air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
- 				      AN8811HB_GPIO_OUTPUT_345,
- 				      AN8811HB_GPIO_OUTPUT_345);
+ 	ret =3D air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+ 					  AN8811HB_GPIO_OUTPUT_345,
+ 					  AN8811HB_GPIO_OUTPUT_345);
  	if (ret < 0)
 -		return ret;
 +		goto err_dev_create;
 =20
  	return 0;
 +
 +err_dev_create:
 +	mdio_device_remove(mdiodev);
 +
 +err_dev_free:
 +	mdio_device_free(mdiodev);
 +	return ret;
  }
 =20
  static int en8811h_probe(struct phy_device *phydev)

--soxlRVeWDInW4BKF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoYZXAACgkQJNaLcl1U
h9BIPQf9FsVt0wHSY12fYNLGr2wW0yZ0dUWgpbu7VcnG3DoN62kuwcBHvA9PeXLk
L2g5pfdR1TjNm4g3/FOefDLk7RdfiNIQKJR8OSMdi9tm/eml7PhIeDZpOWRkiMTd
dNCNqGZofn26mc1Ym7KAf2e7qlSi0sfgPvanZQjS/Jrjz0qRepSvzw8KbY7RD9bq
CRDugA1D2tSWablPe6QJ4/INddnak7I/qou0Xk5ToIbvlgKPwnsruuZwPey0vxGV
2S+mf/p/Ukc2FfH2fScds3CfnHx2Zwoy06IHbgGHiCA23xGlco+G0xGPdzMes5N8
4qNjzJkiUzXpAio0xqs9hovJOxWCkA==
=qd7/
-----END PGP SIGNATURE-----

--soxlRVeWDInW4BKF--

