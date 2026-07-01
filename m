Return-Path: <netdev+bounces-303560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hYD8ELPiRGpv2goAu9opvQ
	(envelope-from <netdev+bounces-303560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:49:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A306EBBB7
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:49:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=XACDvwdp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303560-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303560-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5272E3050417
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF993F7899;
	Wed,  1 Jul 2026 09:45:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3873F7A95
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:44:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899101; cv=none; b=FuURn/pXTUWOUY8FSlVOvmH+9S5PmytUJBbCjUkk9FZPKuYV3HZ1Z5y7K2c20NSFkwIKzIL9b7Nks476JNLmaT2CVqLut/aBZ7KyGef0kkrFYjprc+Nyb6y7IiK97UxJkTZwyR+zn5vm30U2sVey+jK6DYO174QdUaD5eNMJkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899101; c=relaxed/simple;
	bh=R9hFtEKgYS471ndT+08iOQmnZI/274Kw2I1LXOyop3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEP0ce6ZOnRAnmMB1CAXnwwcNzJKf7tnGhjuGamu3dEZT+XTmVZa2f+0KaTs1MtvoK7tf8bjvO2Kk2JdN72D0VW7Z/qawOyCmfrJ46g3pqPdf1CXcGdqvTmr514u+9nZTFc6XkiJ9v3yywQoIJX/TQq+CN/8EZNDhZwF1ah1SsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XACDvwdp; arc=none smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782899100; x=1814435100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R9hFtEKgYS471ndT+08iOQmnZI/274Kw2I1LXOyop3Y=;
  b=XACDvwdpwm5Pt5s+tUNUp/YCBdK80EHI0aWxqX+EjqsH+KawDi6qO1av
   0xiH70ZTQmNOjZKB3hYLoEonAPEriFoQ+C9DCqMnc6MRbPNcF6gsEm4jI
   eOiCl0uPpIDNN+60K9SJkS6OzYxvkrRakvt4EoCK7357mZi6P/z3OTQ95
   UXQTY8L7BJRBOheIN21oQ4fX6rzdWuN1J1acuBQfMha8xoBg2F2ipMBJY
   B3aofkV+n6c/7xXxTR06Pjo2C68rJ0HJm9BPGiXKm82skA7t1m8WpzZ9B
   pFVkSvk4LvMu3q5BW/i1xsNyeDR/GdcPGu880g3FRdHBQYkZoGnc34Y7w
   w==;
X-CSE-ConnectionGUID: ZTjQhHo1TSC2mZbyMBt2aA==
X-CSE-MsgGUID: V/aQ+e03QyyO6olqbhHzMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94781521"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="94781521"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:45:00 -0700
X-CSE-ConnectionGUID: h+SKyAf4Sgysm53Tfai9Zw==
X-CSE-MsgGUID: ViEjRa2ISH6GFxpvtHxWgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="248541521"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:44:52 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	kuba@kernel.org,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	maarten.lankhorst@linux.intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Riana Tauro <riana.tauro@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: [PATCH v4 3/3] drm/xe/xe_ras: Add error-event support for CRI
Date: Wed,  1 Jul 2026 15:14:13 +0530
Message-ID: <20260701094409.129131-8-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701094409.129131-5-riana.tauro@intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303560-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:aravind.iddamsetty@linux.intel.com,m:anshuman.gupta@intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:kuba@kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:raag.jadav@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:riana.tauro@intel.com,m:michal.wajdeczko@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93A306EBBB7

Add error-event support for Correctable errors in CRI. Report an error
event to userspace for every component that has crossed the threshold on
receiving an interrupt.

Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
v2: add warns for unexpected values from system controller (Michal)
    send an event at most once per component for each interrupt (Raag)
    use correct parameters for get_counter (Sashiko)
---
 drivers/gpu/drm/xe/xe_ras.c | 75 +++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 44f4e1a3455b..b71d51285954 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -77,6 +77,18 @@ static u8 drm_to_xe_ras_severity(u8 severity)
 	}
 }
 
+static u8 xe_to_drm_ras_severity(u8 severity)
+{
+	switch (severity) {
+	case XE_RAS_SEV_CORRECTABLE:
+		return DRM_XE_RAS_ERR_SEV_CORRECTABLE;
+	case XE_RAS_SEV_UNCORRECTABLE:
+		return DRM_XE_RAS_ERR_SEV_UNCORRECTABLE;
+	default:
+		return DRM_XE_RAS_ERR_SEV_MAX;
+	}
+}
+
 static u8 drm_to_xe_ras_component(u8 component)
 {
 	switch (component) {
@@ -95,6 +107,24 @@ static u8 drm_to_xe_ras_component(u8 component)
 	}
 }
 
+static u8 xe_to_drm_ras_component(u8 component)
+{
+	switch (component) {
+	case XE_RAS_COMP_DEVICE_MEMORY:
+		return DRM_XE_RAS_ERR_COMP_DEVICE_MEMORY;
+	case XE_RAS_COMP_CORE_COMPUTE:
+		return DRM_XE_RAS_ERR_COMP_CORE_COMPUTE;
+	case XE_RAS_COMP_PCIE:
+		return DRM_XE_RAS_ERR_COMP_PCIE;
+	case XE_RAS_COMP_FABRIC:
+		return DRM_XE_RAS_ERR_COMP_FABRIC;
+	case XE_RAS_COMP_SOC_INTERNAL:
+		return DRM_XE_RAS_ERR_COMP_SOC_INTERNAL;
+	default:
+		return DRM_XE_RAS_ERR_COMP_MAX;
+	}
+}
+
 static int ras_status_to_errno(u32 status)
 {
 	switch (status) {
@@ -131,14 +161,41 @@ static inline const char *comp_to_str(u8 component)
 	return xe_ras_components[component];
 }
 
+static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
+{
+	u8 drm_severity, drm_component;
+	u32 value;
+	int ret;
+
+	drm_severity = xe_to_drm_ras_severity(severity);
+	if (drm_severity == DRM_XE_RAS_ERR_SEV_MAX) {
+		xe_warn(xe, "sysctrl: unexpected severity %u\n", severity);
+		return;
+	}
+
+	drm_component = xe_to_drm_ras_component(component);
+	if (drm_component == DRM_XE_RAS_ERR_COMP_MAX) {
+		xe_warn(xe, "sysctrl: unexpected component %u\n", component);
+		return;
+	}
+
+	ret = xe_ras_get_counter(xe, drm_severity, drm_component, &value);
+	if (ret)
+		return;
+
+	xe_drm_ras_event(xe, drm_component, drm_severity, value, GFP_KERNEL);
+}
+
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response)
 {
 	struct xe_ras_threshold_crossed *pending = (void *)&response->data;
 	struct xe_ras_error_class *errors = pending->counters;
 	u32 id, ncounters = pending->ncounters;
+	u8 sent = 0;
 
 	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
+	BUILD_BUG_ON(XE_RAS_COMP_MAX > (BITS_PER_BYTE * sizeof(sent)));
 	xe_device_assert_mem_access(xe);
 
 	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
@@ -154,6 +211,24 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 
 		xe_warn(xe, "[RAS]: %s %s detected\n",
 			comp_to_str(component), sev_to_str(severity));
+
+		if (severity != XE_RAS_SEV_CORRECTABLE) {
+			xe_warn(xe, "sysctrl: unexpected severity %s (%u)\n", sev_to_str(severity),
+				severity);
+			continue;
+		}
+
+		if (component >= XE_RAS_COMP_MAX) {
+			xe_warn(xe, "sysctrl: unexpected component %u\n", component);
+			continue;
+		}
+
+		/* Send event once per component */
+		if (sent & BIT(component))
+			continue;
+		sent |= BIT(component);
+
+		ras_send_error_event(xe, severity, component);
 	}
 }
 
-- 
2.47.1


