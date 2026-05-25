Return-Path: <netdev+bounces-291342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNASCTldFGqPMwcAu9opvQ
	(envelope-from <netdev+bounces-291342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:31:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 049895CBC18
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E526E30074D0
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D288C3F1661;
	Mon, 25 May 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJSc8cMz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E73EE1DA
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719466; cv=none; b=YQX5Kxi1ntl3xgB1IjO3MjJaLc+tySDAmAhOfWmV3O1+MTg66E/I/clpq1P72AGJA5LOdDVz/TewjjNiZ+IKLldQ+voJ3wa8ko2f/oyBPv6djLiiPRhqiTBO1tPNX7le/48zQXdYGS7YPCAwuwK1DTA1LbDXqEUsb0WnOXftlGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719466; c=relaxed/simple;
	bh=ONyXu8YvQ7Y3SvfZEeARqxmes4iIVztw85lvdr0HjNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP6NtvNB4TGp3rzblh0/7LxeEdh59pbIUkHMxf0VYa+cmm/bpZMDDI18SpdW+0D4SAB/uhqU/5dmNXvGLuaE7axLH9k905LjAGwGWT2+gn7uIR18OYLWjbqEs3uToLAYlRhwfDe4O2dcBmhRRtu6QG3ZsFZvlYI1QvXBY9tNEMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJSc8cMz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779719465; x=1811255465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ONyXu8YvQ7Y3SvfZEeARqxmes4iIVztw85lvdr0HjNg=;
  b=AJSc8cMzfWYpWJMqjqGYLn9t5/MsnQEw8l8FHX05XUJ9MhdAVarNUUj3
   dG9ZeWIZlI5SzJtjgJ+IMX4jKvng8jYCF0NjW07dGiNotSgnmDugL3zi0
   lNWS7r9amL0oKCJ5ADQVl7If7WcShIH/9BD7wfeYsUW9HSTDbTtcs8PgD
   E2tO9WEFwBr6snNzQfG/xTBK6PckcHWdzRkqXk5LgFbVvw9zzY7OPcwq0
   sykY2K5cCx/NxQfJKF7q3GtEMuXAscJZ08eXGaKLSyjtNY1OA1NehlgCv
   u0DLEpfxeeMKjtfEGdJSzgidweYu7y7BR4yKemG4yRBTihj+QsWA7Masi
   w==;
X-CSE-ConnectionGUID: c1iLG/r5TcyvJULc7SC8lw==
X-CSE-MsgGUID: OwAvsQHdSmai5bdyWACisA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80596724"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="80596724"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 07:31:04 -0700
X-CSE-ConnectionGUID: ncwv4LK+Qday4YJibI+sxw==
X-CSE-MsgGUID: c8P9fUtvRhy2foWiNnr0lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="237189237"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa006.fm.intel.com with ESMTP; 25 May 2026 07:31:03 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [RESEND PATCH iwl-net v2 2/3] ice: Zero out the PTP control PF pointer at ice_adapter cleanup
Date: Mon, 25 May 2026 14:30:59 +0000
Message-ID: <20260525143100.2758251-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525143100.2758251-1-sergey.temerkhanov@intel.com>
References: <20260525143100.2758251-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergey.temerkhanov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 049895CBC18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Zero out the ctrl_pf pointer in ice_adapter when the control PF is removed.
This prevents potential dangling pointer dereference when accessing
PTP-related structures from other PFs of the same adapter.

Fixes: e800654e85b5b ("ice: Use ice_adapter for PTP shared data instead of auxdev")

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reported-by: Frederick Lawler <fred@cloudflare.com>
Closes: https://lkml.indiana.edu/2507.3/01388.html
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Frederick Lawler <fred@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 732964fd7c78..7d9c0775fd79 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3106,6 +3106,18 @@ static void ice_ptp_setup_adapter(struct ice_pf *pf)
 	rcu_assign_pointer(pf->adapter->ctrl_pf, pf);
 }
 
+static void ice_ptp_cleanup_adapter(struct ice_pf *pf)
+{
+	/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
+	 * is being removed to prevent any secondary PFs from accessing
+	 * it after it is deleted.
+	 */
+	if (cmpxchg(&pf->adapter->ctrl_pf,
+		    (struct ice_pf __rcu *)pf, NULL) ==
+			(struct ice_pf __rcu *)pf)
+		synchronize_rcu();
+}
+
 static int ice_ptp_setup_pf(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
@@ -3386,6 +3398,8 @@ void ice_ptp_init(struct ice_pf *pf)
 err_clean_pf:
 	mutex_destroy(&ptp->port.ps_lock);
 	ice_ptp_cleanup_pf(pf);
+
+	ice_ptp_cleanup_adapter(pf);
 err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
@@ -3414,6 +3428,7 @@ void ice_ptp_release(struct ice_pf *pf)
 	if (pf->ptp.state != ICE_PTP_READY) {
 		mutex_destroy(&pf->ptp.port.ps_lock);
 		ice_ptp_cleanup_pf(pf);
+		ice_ptp_cleanup_adapter(pf);
 		if (pf->ptp.clock) {
 			ptp_clock_unregister(pf->ptp.clock);
 			pf->ptp.clock = NULL;
@@ -3428,6 +3443,8 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	ice_ptp_cleanup_pf(pf);
 
+	ice_ptp_cleanup_adapter(pf);
+
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	ice_ptp_disable_all_extts(pf);
-- 
2.53.0


