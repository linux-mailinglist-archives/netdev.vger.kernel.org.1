Return-Path: <netdev+bounces-296295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8s04Gty6JWo1LAIAu9opvQ
	(envelope-from <netdev+bounces-296295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:39:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ABC651482
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:39:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=DQRasCrl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296295-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296295-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69DBF300DDC2
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16630595B;
	Sun,  7 Jun 2026 18:35:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DDC28488D;
	Sun,  7 Jun 2026 18:35:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857356; cv=none; b=rT4+/F/DsaQRrAcCzVUfWWVzxaU7qUAEk1gmtJz8BvOh6nk09JOAxkldX6CobS/Epf1jCIX6NEhM14wzbZTzux/LfW2IS1Rfw1QXyqCIO2r1wuP40xoOyxIxHrEh7XrubRrNYXu2nyWcN95X6Tj95CIkrBciN+4JRpTpj+ecJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857356; c=relaxed/simple;
	bh=koRmLbjpHuPzm/2NQMVrOJQo87jCXzC8O7hMggcIDO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icZB0DtO2iyfSbuyhE5k8xKwc/GP3d5FbaLTmPMSQ75fNdgIgVdtieHLEpp/K9D6PZqNkmqh5v0T0VnE0sEl277CUiCyvBnTwkr6or6ypzvJ+0qJWHw8qgRYaJeM5mzQ0tNf2xky3oFzwNUByjtMuw4DY/PZDITmWaVprPFsFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQRasCrl; arc=none smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780857355; x=1812393355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=koRmLbjpHuPzm/2NQMVrOJQo87jCXzC8O7hMggcIDO4=;
  b=DQRasCrlpr5xN29Y/YEkV/vFxjb4/kLnHvoOh0qj5fo4iiaCK3c5Fnsl
   Di+Iw4w24/GZpBXmOhn6QHIW051UNQqi/tpEjMvAZOCDf6CNK/7gremCJ
   RJC/kZ8vF9OfurMTZBt0ZGhHm2PGmPjfZyB+w7DueEbj/so9AhUxNFOaT
   nTVwVYN6AhYvqtr5giqiLPyNW11Wu21FN2lVBeojxXfz4Hn5KNGTepCns
   rFul3sMmRuOW0nZVeRZW7PyZLwd6CnD+gLDIC+L69/VZb6ZsriNrpiJzI
   O7AXAv+6bo7xmFqnbnQzQUa5CT8DpoD3rq9g44sBPq+o7TGIFpZgia6hH
   w==;
X-CSE-ConnectionGUID: oysA+z2cT2KrYHQq3UbuNg==
X-CSE-MsgGUID: PVMd2rmCRv2tDkCmzqjSfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81602087"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81602087"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 11:35:55 -0700
X-CSE-ConnectionGUID: kN4bIwhQQESQ/V3SHYmDsA==
X-CSE-MsgGUID: p/BsSjwHSKi2Xk0JgKC0qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="245171426"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa008.jf.intel.com with ESMTP; 07 Jun 2026 11:35:50 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v14 net-next 06/13] dpll: guard sync-pair removal on full pin unregister
Date: Sun,  7 Jun 2026 20:30:38 +0200
Message-Id: <20260607183045.1213735-7-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296295-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:grzegorz.nitka@intel.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7ABC651482

__dpll_pin_unregister() wiped the global sync-pair state on every
(dpll, ops, priv, cookie) tuple removed from a pin. When a pin is
registered multiple times and only one registration is being torn
down, this dropped sync-pair pairings still in use by the surviving
registrations.

Move dpll_pin_ref_sync_pair_del() inside the xa_empty(&pin->dpll_refs)
branch so it only runs when the last registration is gone, alongside
clearing the DPLL_REGISTERED mark.

Fixes: 58256a26bfb3 ("dpll: add reference sync get/set")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 58034be07080..ea45bb41376c 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -926,11 +926,12 @@ __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 		      const struct dpll_pin_ops *ops, void *priv, void *cookie)
 {
 	ASSERT_DPLL_PIN_REGISTERED(pin);
-	dpll_pin_ref_sync_pair_del(pin->id);
 	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv, cookie);
 	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv, cookie);
-	if (xa_empty(&pin->dpll_refs))
+	if (xa_empty(&pin->dpll_refs)) {
+		dpll_pin_ref_sync_pair_del(pin->id);
 		xa_clear_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
+	}
 }
 
 /**
-- 
2.39.3


