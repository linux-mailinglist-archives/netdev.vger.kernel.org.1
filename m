Return-Path: <netdev+bounces-281639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJplOQVF8Gn2QwEAu9opvQ
	(envelope-from <netdev+bounces-281639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:26:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6038A47D8B8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6344F301D075
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA02F12C5;
	Tue, 28 Apr 2026 05:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5MfIuC6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FA340298
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353811; cv=none; b=DwBOPvMeSCfyil9B8mKw5cZGgV3ekSr1vvF1z6OhSQ8tUaEw2gM1rkl8Ss9BX194Rs8IJvLCxnd4A73hB2CzpVSPcJOFl2V8W0Oyi8hvEAJfcX1rhnfY+E8CGdGzGmqDYgoRstldWi5L3qSrVhXK2/InGQiQ6BCCb9EC/wJAAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353811; c=relaxed/simple;
	bh=DUIP6hE7Sbg2WWd/iGWzwTfHvmeLBELLnPdgWBnnWYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pgiyBqLrVtAlFDRLt5lYrMSNqytaT9QS55dT6iON2S/V+Myf2x3Sa4AQiMFmGvBAd/D9DBNV6ifI6bOVyBLMBm0KLhc93VprmkLk3qtNFxbS4rdRjhTZTJOv58OpSIA/HQsD7OdpiXrPlziUEtR5WL7LYiZ3rCDqLNgsWMaW8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5MfIuC6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353803; x=1808889803;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DUIP6hE7Sbg2WWd/iGWzwTfHvmeLBELLnPdgWBnnWYQ=;
  b=d5MfIuC6Eno3oCHtI5PgUbVLkpx0l7syUJEcgYCDYXDVLf59Qdc8mDRJ
   14Hlxt5qcgBl1DRFMLWe75HVpfTI4eAx8j8pvJUQc60ZHVWr73tF9TbIN
   gbRjlXgpLGeLdxbafzWBF8Oq3obwrblPxo5JLwLgGU3Hb141ZHhTtyJoK
   nFVD89tSUIrAv5jDEQ1HpIQ1mtvx3hoC7rr4lU10TaJsX7O1O25odrpm1
   1rotgLGBbSFC828zGbhdCQQ7UBUD2xEpFlc9hOWtwx4Lyr4iNtGHBze1b
   aHsXo2vympFsrUZuqNtCsjsd5RJmTrdb/09tZQeSstAl+QTDJQGx2IZZi
   A==;
X-CSE-ConnectionGUID: 3PkX1AT0RjmGSOrP+K0ozg==
X-CSE-MsgGUID: EZnZIzdWTd+5ffH0+miLQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100910561"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="100910561"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
X-CSE-ConnectionGUID: +R+kI0/hS+iaXon3f/dAcg==
X-CSE-MsgGUID: VMSA+t9tR+mCVBMDKlw9gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237800216"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 27 Apr 2026 22:22:20 -0700
Subject: [PATCH net 08/11] ice: fix SMA and U.FL pin state changes
 affecting paired pin
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-jk-iwl-net-petr-oros-fixes-v1-8-cdcb48303fd8@intel.com>
References: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
In-Reply-To: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Petr Oros <poros@redhat.com>, Alexander Nowlin <alexander.nowlin@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=4838;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=NTS5yytC0mSYm1Ki4bxMALc5JlYK6eBqfl+CY2PaRHY=;
 b=kA0DAAoWapZdPm8PKOgByyZiAGnwREKigDvhbZ0rcll0MSzqYCR7X/0GqVbDRbqPnT1ICo1Dt
 oh1BAAWCgAdFiEEIEBUqdczkFYq7EMeapZdPm8PKOgFAmnwREIACgkQapZdPm8PKOj5fwD+MKSD
 LyPfVdT5I5N06gGp02pkeZsHVJ4D/hUD0OoaB1wA/iLE0/YjD1mohe0B2u/K6gtFvE5SVsg4GV3
 zNrbiq4sA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 6038A47D8B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281639-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Petr Oros <poros@redhat.com>

SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
SMA2/U.FL2) controlled by the PCA9575 GPIO expander.  Each pair can
only have one active pin at a time: SMA1 output and U.FL1 output share
the same CGU output, SMA2 input and U.FL2 input share the same CGU
input.  The PCA9575 register bits determine which connector in each
pair owns the signal path.

The driver does not account for this pairing in two places:

ice_dpll_ufl_pin_state_set() modifies PCA9575 bits and disables the
backing CGU pin without checking whether the U.FL pin is currently
active.  Disconnecting an already inactive U.FL pin flips bits that
the paired SMA pin relies on, breaking its connection.

ice_dpll_sma_direction_set() does not propagate direction changes to
the paired U.FL pin.  For SMA2/U.FL2 the ICE_SMA2_UFL2_RX_DIS bit is
never managed, so U.FL2 stays disconnected after SMA2 switches to
output.  For both pairs the backing CGU pin of the U.FL side is never
enabled when a direction change activates it, so userspace sees the
pin as disconnected even though the routing is correct.

Fix by guarding the U.FL disconnect path against inactive pins and by
updating the paired U.FL pin fully on SMA direction changes: manage
ICE_SMA2_UFL2_RX_DIS for the SMA2/U.FL2 pair and enable the backing
CGU pin whenever the peer becomes active.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Petr Oros <poros@redhat.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 50 ++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 498ec2c045f3..3f8cd5b8298b 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1171,6 +1171,8 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 				      enum dpll_pin_direction direction,
 				      struct netlink_ext_ack *extack)
 {
+	struct ice_dplls *d = &p->pf->dplls;
+	struct ice_dpll_pin *peer;
 	u8 data;
 	int ret;
 
@@ -1189,8 +1191,9 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 	case ICE_DPLL_PIN_SW_2_IDX:
 		if (direction == DPLL_PIN_DIRECTION_INPUT) {
 			data &= ~ICE_SMA2_DIR_EN;
+			data |= ICE_SMA2_UFL2_RX_DIS;
 		} else {
-			data &= ~ICE_SMA2_TX_EN;
+			data &= ~(ICE_SMA2_TX_EN | ICE_SMA2_UFL2_RX_DIS);
 			data |= ICE_SMA2_DIR_EN;
 		}
 		break;
@@ -1202,6 +1205,34 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 		ret = ice_dpll_pin_state_update(p->pf, p,
 						ICE_DPLL_PIN_TYPE_SOFTWARE,
 						extack);
+	if (ret)
+		return ret;
+
+	/* When a direction change activates the paired U.FL pin, enable
+	 * its backing CGU pin so the pin reports as connected. Without
+	 * this the U.FL routing is correct but the CGU pin stays disabled
+	 * and userspace sees the pin as disconnected.  Do not disable the
+	 * backing pin when U.FL becomes inactive because the SMA pin may
+	 * still be using it.
+	 */
+	peer = &d->ufl[p->idx];
+	if (peer->active) {
+		struct ice_dpll_pin *target;
+		enum ice_dpll_pin_type type;
+
+		if (peer->output) {
+			target = peer->output;
+			type = ICE_DPLL_PIN_TYPE_OUTPUT;
+		} else {
+			target = peer->input;
+			type = ICE_DPLL_PIN_TYPE_INPUT;
+		}
+		ret = ice_dpll_pin_enable(&p->pf->hw, target,
+					  d->eec.dpll_idx, type, extack);
+		if (!ret)
+			ret = ice_dpll_pin_state_update(p->pf, target,
+							type, extack);
+	}
 
 	return ret;
 }
@@ -1253,6 +1284,14 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			data &= ~ICE_SMA1_MASK;
 			enable = true;
 		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			/* Skip if U.FL1 is not active, setting TX_EN
+			 * while DIR_EN is set would also deactivate
+			 * the paired SMA1 output.
+			 */
+			if (data & (ICE_SMA1_DIR_EN | ICE_SMA1_TX_EN)) {
+				ret = 0;
+				goto unlock;
+			}
 			data |= ICE_SMA1_TX_EN;
 			enable = false;
 		} else {
@@ -1267,6 +1306,15 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			data &= ~ICE_SMA2_UFL2_RX_DIS;
 			enable = true;
 		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			/* Skip if U.FL2 is not active, setting
+			 * UFL2_RX_DIS could also disable the paired
+			 * SMA2 input.
+			 */
+			if (!(data & ICE_SMA2_DIR_EN) ||
+			    (data & ICE_SMA2_UFL2_RX_DIS)) {
+				ret = 0;
+				goto unlock;
+			}
 			data |= ICE_SMA2_UFL2_RX_DIS;
 			enable = false;
 		} else {

-- 
2.54.0.rc2.531.gaf818d63126a


