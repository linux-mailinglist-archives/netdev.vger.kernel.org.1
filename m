Return-Path: <netdev+bounces-293797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBP6BaGcHWpucgkAu9opvQ
	(envelope-from <netdev+bounces-293797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:52:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE4621315
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588C73068901
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D461A3C140F;
	Mon,  1 Jun 2026 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rz3kjOZL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B43C1989;
	Mon,  1 Jun 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325251; cv=none; b=Uw6g1u66hlDYXI7kO1tDVC1eBn1IEqJuXsoPySexWNjEwARx6hdeL6UbyGY/KmsGaeCjn8Dwmh3Xwqvmw2HlOuW8g/fw20wZdyZOh58hEozrCaYJFincZGuT2R0g+VCldl5c0Ce6GVnchfpiuoeMgo8rrAS54YzSx//H9BgE0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325251; c=relaxed/simple;
	bh=BhH6W7G4s3U/K7UzE3foH4hk/qhVH4QAfv9g/nI3Pjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z+z78vZ4vE+dn/n6ZH5BsCe+JOaqbAd5xbUJnqf403RNrmlw6bEx6+zikNvJkCrWDCNUGjB74SB9/iHj0qpn5KA+CGBcQJAcV1PezuVsE4/rjhh63+ak7eBo29PAZonbenpyuXfiu0e5QMshnCBXeREi85YBQJQ5Tt+p0A2hdmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rz3kjOZL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492151F00893;
	Mon,  1 Jun 2026 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780325250;
	bh=dqZOaUgYfpWNGg/s/JHgNBr+k+vfbZbFcHGUEX8leko=;
	h=Date:From:To:Cc:Subject;
	b=Rz3kjOZLOXD6XUW877Hon+qkThBU2n9065zQ9dSm1sPzwwzo8CGlQEGOUyj77yMtM
	 jPE1fCQO1BYAp7nPLoVuNqRrdN5EEy8vSyN+2EASyWqYpuAXDIIHwSsgdrSha29Nwb
	 8Puwn0DFBmyLaG/29Zc3DKtGRbAKfRwsMLQ/Tr/zekspGIz87S0ZcD2aMUQavGxq6N
	 NJ3TEW+cGbKzc9F7W0QGKdUz+p5ntchw5iAWEwJw9+lPpxwi/ksTPdd7G2Q6NPHCy3
	 gHZkMZxalG8qgl5ygwcCUwO5/2bzGuNA/JEogePKBrRFBivzNrRq35sYhq/l9cH/6U
	 tZtIN7fIpaf8A==
Date: Mon, 1 Jun 2026 15:47:25 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Aaron Katzin <aaron.katzin@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: linux-next: manual merge of the net-next tree with the iwlwifi tree
Message-ID: <ah2bfedhV45ZxMO8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1D4eVuRo4sJCH0bO"
Content-Disposition: inline
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293797-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6DAE4621315
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--1D4eVuRo4sJCH0bO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got conflicts in:

  drivers/net/wireless/intel/iwlwifi/mld/ap.c
  drivers/net/wireless/intel/iwlwifi/pcie/drv.c

between commits:

  9bf1b409afc7c ("wifi: iwlwifi: mld: send tx power constraints before link=
 activation")
  093305d801fae ("wifi: iwlwifi: pcie: simplify the resume flow if fast res=
ume is not used")

=66rom the iwlwifi tree and commits:

  a342c99cb70dd ("wifi: iwlwifi: mld: honor BSS_CHANGED_BEACON_ENABLED")
  e2323929a68af ("wifi: iwlwifi: pcie: add debug print for resume flow if p=
owered off")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/net/wireless/intel/iwlwifi/mld/ap.c
index 6598d93333330,bc426b911ce5c..0000000000000
--- a/drivers/net/wireless/intel/iwlwifi/mld/ap.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
@@@ -1,6 -1,6 +1,6 @@@
  // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
  /*
-  * Copyright (C) 2024 Intel Corporation
+  * Copyright (C) 2024, 2026 Intel Corporation
   */
  #include <linux/crc32.h>
 =20
@@@ -9,6 -9,7 +9,6 @@@
  #include "ap.h"
  #include "hcmd.h"
  #include "tx.h"
 -#include "power.h"
  #include "key.h"
  #include "phy.h"
  #include "iwl-utils.h"
@@@ -238,6 -239,58 +238,58 @@@ int iwl_mld_store_ap_early_key(struct i
  	return -ENOSPC;
  }
 =20
+ static void iwl_mld_stop_beacon(struct iwl_mld *mld, struct ieee80211_vif=
 *vif,
+ 				struct ieee80211_bss_conf *link)
+ {
+ 	struct iwl_mld_link *mld_link =3D iwl_mld_link_from_mac80211(link);
+ 	struct iwl_mac_beacon_cmd cmd =3D {};
+ 	int cmd_ver =3D iwl_fw_lookup_cmd_ver(mld->fw, BEACON_TEMPLATE_CMD, 14);
+=20
+ 	if (WARN_ON(!mld_link))
+ 		return;
+=20
+ 	if (cmd_ver < 15)
+ 		return;
+=20
+ 	/* leave byte_cnt 0 */
+ 	cmd.link_id =3D cpu_to_le32(mld_link->fw_id);
+=20
+ 	iwl_mld_send_cmd_pdu(mld, BEACON_TEMPLATE_CMD, &cmd);
+ }
+=20
+ void
+ iwl_mld_link_info_changed_ap_ibss(struct iwl_mld *mld,
+ 				  struct ieee80211_vif *vif,
+ 				  struct ieee80211_bss_conf *link,
+ 				  u64 changes)
+ {
+ 	u32 link_changes =3D 0;
+=20
+ 	if (changes & BSS_CHANGED_ERP_SLOT)
+ 		link_changes |=3D LINK_CONTEXT_MODIFY_RATES_INFO;
+=20
+ 	if (changes & (BSS_CHANGED_ERP_CTS_PROT | BSS_CHANGED_HT))
+ 		link_changes |=3D LINK_CONTEXT_MODIFY_PROTECT_FLAGS;
+=20
+ 	if (changes & (BSS_CHANGED_QOS | BSS_CHANGED_BANDWIDTH))
+ 		link_changes |=3D LINK_CONTEXT_MODIFY_QOS_PARAMS;
+=20
+ 	if (changes & BSS_CHANGED_HE_BSS_COLOR)
+ 		link_changes |=3D LINK_CONTEXT_MODIFY_HE_PARAMS;
+=20
+ 	if (link_changes)
+ 		iwl_mld_change_link_in_fw(mld, link, link_changes);
+=20
+ 	if (changes & BSS_CHANGED_BEACON) {
+ 		WARN_ON(!link->enable_beacon);
+ 		iwl_mld_update_beacon_template(mld, vif, link);
+ 	}
+=20
+ 	/* Enabling beacons was already covered above */
+ 	if ((changes & BSS_CHANGED_BEACON_ENABLED) && !link->enable_beacon)
+ 		iwl_mld_stop_beacon(mld, vif, link);
+ }
+=20
  static int iwl_mld_send_ap_early_keys(struct iwl_mld *mld,
  				      struct ieee80211_vif *vif,
  				      struct ieee80211_bss_conf *link)
@@@ -272,10 -325,9 +324,6 @@@ int iwl_mld_start_ap_ibss(struct ieee80
  	struct ieee80211_chanctx_conf *ctx;
  	int ret;
 =20
- 	ret =3D iwl_mld_update_beacon_template(mld, vif, link);
- 	if (ret)
- 		return ret;
 -	if (vif->type =3D=3D NL80211_IFTYPE_AP)
 -		iwl_mld_send_ap_tx_power_constraint_cmd(mld, vif, link);
--
  	/* the link should be already activated when assigning chan context,
  	 * and LINK_CONTEXT_MODIFY_EHT_PARAMS is deprecated
  	 */
diff --combined drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index eb3c5a6dd0884,608100bc6b119..0000000000000
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@@ -537,6 -537,8 +537,8 @@@ VISIBLE_IF_IWLWIFI_KUNIT const struct p
  	{IWL_PCI_DEVICE(0xA840, 0x4314, iwl_bz_mac_cfg)},
  	{IWL_PCI_DEVICE(0xA840, 0x1775, iwl_bz_mac_cfg)},
  	{IWL_PCI_DEVICE(0xA840, 0x1776, iwl_bz_mac_cfg)},
+ 	{IWL_PCI_DEVICE(0xA840, 0x1735, iwl_bz_mac_cfg)},
+ 	{IWL_PCI_DEVICE(0xA840, 0x1736, iwl_bz_mac_cfg)},
  	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_mac_cfg)},
  	{IWL_PCI_DEVICE(0x4D40, PCI_ANY_ID, iwl_bz_mac_cfg)},
 =20
@@@ -1052,6 -1054,8 +1054,8 @@@ VISIBLE_IF_IWLWIFI_KUNIT const struct i
  	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750i_name, SUBDEV(0x1772)),
  	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1790s_name, SUBDEV(0x1791)),
  	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1790i_name, SUBDEV(0x1792)),
+ 	IWL_DEV_INFO(iwl_rf_fm_160mhz, iwl_killer_be1730x_name, SUBDEV(0x1730)),
+ 	IWL_DEV_INFO(iwl_rf_fm_160mhz, iwl_killer_be1730x_name, SUBDEV(0x1731)),
 =20
  /* Killer discrete */
  	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750w_name,
@@@ -1069,7 -1073,7 +1073,7 @@@
 =20
  /* PE RF */
  	IWL_DEV_INFO(iwl_rf_pe, iwl_bn201_name, RF_TYPE(PE)),
- 	IWL_DEV_INFO(iwl_rf_pe, iwl_be223_name, RF_TYPE(PE),
+ 	IWL_DEV_INFO(iwl_rf_pe_no_uhr, iwl_be223_name, RF_TYPE(PE),
  		     SUBDEV_MASKED(0x0524, 0xFFF)),
  	IWL_DEV_INFO(iwl_rf_pe, iwl_bn203_name, RF_TYPE(PE),
  		     SUBDEV_MASKED(0x0324, 0xFFF)),
@@@ -1077,6 -1081,8 +1081,8 @@@
  /* Killer */
  	IWL_DEV_INFO(iwl_rf_wh, iwl_killer_be1775s_name, SUBDEV(0x1776)),
  	IWL_DEV_INFO(iwl_rf_wh, iwl_killer_be1775i_name, SUBDEV(0x1775)),
+ 	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_killer_be1735x_name, SUBDEV(0x1735)),
+ 	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_killer_be1735x_name, SUBDEV(0x1736)),
 =20
  	IWL_DEV_INFO(iwl_rf_pe, iwl_killer_bn1850w2_name, SUBDEV(0x1851)),
  	IWL_DEV_INFO(iwl_rf_pe, iwl_killer_bn1850i_name, SUBDEV(0x1852)),
@@@ -1225,41 -1231,37 +1231,41 @@@ static int _iwl_pci_resume(struct devic
  	if (!trans->op_mode)
  		return 0;
 =20
 -	/*
 -	 * Scratch value was altered, this means the device was powered off, we
 -	 * need to reset it completely.
 -	 * Note: MAC (bits 0:7) will be cleared upon suspend even with wowlan,
 -	 * but not bits [15:8]. So if we have bits set in lower word, assume
 -	 * the device is alive.
 -	 * Alternatively, if the scratch value is 0xFFFFFFFF, then we no longer
 -	 * have access to the device and consider it powered off.
 -	 * For older devices, just try silently to grab the NIC.
 -	 */
 -	if (trans->mac_cfg->device_family >=3D IWL_DEVICE_FAMILY_BZ) {
 -		u32 scratch =3D iwl_read32(trans, CSR_FUNC_SCRATCH);
 -
 -		if (!(scratch & CSR_FUNC_SCRATCH_POWER_OFF_MASK) ||
 -		    scratch =3D=3D ~0U) {
 -			device_was_powered_off =3D true;
 -			IWL_DEBUG_WOWLAN(trans,
 -					 "Scratch 0x%08x indicates device was powered off\n",
 -					 scratch);
 -		}
 -	} else {
 +	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
  		/*
 -		 * bh are re-enabled by iwl_trans_pcie_release_nic_access,
 -		 * so re-enable them if _iwl_trans_pcie_grab_nic_access fails.
 +		 * Scratch value was altered, this means the device was powered
 +		 * off, we need to reset it completely.
 +		 * Note: MAC (bits 0:7) will be cleared upon suspend even with
 +		 * wowlan, but not bits [15:8]. So if we have bits set in lower
 +		 * word, assume the device is alive.
 +		 * Alternatively, if the scratch value is 0xFFFFFFFF, then we
 +		 * no longer have access to the device and consider it powered
 +		 * off.
 +		 * For older devices, just try silently to grab the NIC.
  		 */
 -		local_bh_disable();
 -		if (_iwl_trans_pcie_grab_nic_access(trans, true)) {
 -			iwl_trans_pcie_release_nic_access(trans);
 +		if (trans->mac_cfg->device_family >=3D IWL_DEVICE_FAMILY_BZ) {
 +			u32 scratch =3D iwl_read32(trans, CSR_FUNC_SCRATCH);
 +
 +			if (!(scratch & CSR_FUNC_SCRATCH_POWER_OFF_MASK) ||
 +			    scratch =3D=3D ~0U) {
 +				IWL_DEBUG_WOWLAN(trans,
 +						 "Scratch 0x%08x indicates device was powered off\n",
 +						 scratch);
 +				device_was_powered_off =3D true;
 +			}
  		} else {
 -			device_was_powered_off =3D true;
 -			local_bh_enable();
 +			/*
 +			 * bh are re-enabled by iwl_trans_pcie_release_nic_access,
 +			 * so re-enable them if _iwl_trans_pcie_grab_nic_access
 +			 * fails.
 +			 */
 +			local_bh_disable();
 +			if (_iwl_trans_pcie_grab_nic_access(trans, true)) {
 +				iwl_trans_pcie_release_nic_access(trans);
 +			} else {
 +				device_was_powered_off =3D true;
 +				local_bh_enable();
 +			}
  		}
  	}
 =20

--1D4eVuRo4sJCH0bO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmodm3wACgkQJNaLcl1U
h9DHiQf7BiC+WEgVa06zZQqZBMlBOT/6QyFRNxRYJ3kxroNNyFbaVwTHaJgd5NyV
kWXB9z85mkpPwZdPnu9omhazkbbzS+byi43AJ1V8aHVdn+kpmLy9EL1zilzxtrba
aEPb7Eco8TWono3DS2qkdYCVGUJYGuA8JTnNsUYVO0hEkkng4qsvWxlDrBldP8Yp
ce4ZwzyrZbTZzvKI23aGHi8yjvibgauY679jagCoB4sS7XEJE8k6OxO6TZ9JYTD5
0yJQyFUS52Mlj82lPV2Nyynzrhq3mvAnnmUhcPAQUnWDR0qWXUYD6z+GkHOfbURX
iM1lHi11hgfJiG+WpCWXUOYQH46PfQ==
=ut/T
-----END PGP SIGNATURE-----

--1D4eVuRo4sJCH0bO--

