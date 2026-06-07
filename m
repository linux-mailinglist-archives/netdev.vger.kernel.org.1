Return-Path: <netdev+bounces-296296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dUE6JRy6JWr8KwIAu9opvQ
	(envelope-from <netdev+bounces-296296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:36:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F72C65141C
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 20:36:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QiGtcYcg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296296-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296296-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F65D3002311
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 18:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E540E3128DF;
	Sun,  7 Jun 2026 18:36:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC601F09AD;
	Sun,  7 Jun 2026 18:36:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857368; cv=none; b=L+60fNqnXRB1l1u/u1ZaI3U+yVlxEVabsiuzalFB14d8lmCFv+wuSYS4AB6zTO5z6js0mgXpfg8OFjvK1xwfuqOwhmxZ1Xu8UKZPl5SokEqMMj54ERrEMYx/aSSyb1DcDe8xZgbzDrn4GmT43t/Z/jGcvdzPJo787wdzsPzwvp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857368; c=relaxed/simple;
	bh=fwCPDXwHX50TF2F6sSd9ftV4aMKEeCNes1mJGAuv0KE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxAVcWHxJ7+1Ul7n8o04wj441mPConHTUGBbI5mg+JH22LvBuTpXTc1lOJaQrr4kWyf8jXClaAguP9Wkx4UPfNaJ7f5JsSXkVuEhRp66nxXQYSAdYRRuiaR9af8ROaLOqLapWfn5QTq2YksHqS0xtZE8Lg+qXDKF1d82Fd3SOUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiGtcYcg; arc=none smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780857368; x=1812393368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fwCPDXwHX50TF2F6sSd9ftV4aMKEeCNes1mJGAuv0KE=;
  b=QiGtcYcgPp8CFgqBkhg+0WHClRO2PGO6Vo8AkveBdKM6MDcRnN6F8IBR
   MUCCImdq9+k2nd+j3LGebxC1JXLFpdLCorX8nZGBhWgxHYCrOowVaM76n
   L5ZIsV6cjIn2lvT80wbqNQc3caLvCstftuZII1l5eTZtVMlQaKJwWI8xc
   BbZs8e4xdNsCi/gG0BYEAbvLjWoshOctBfVeLd4y9TUemYdZi1gJq9eDj
   qlKM1Ms5y1xvAw0gNCbYeyLVPJ7Ixv5RhMQLVHuGqlRBQ/cewDkinOjKZ
   WE6ZCVuA8O4g19Iw+8CCKytIRkfvxZ9oljWuXoXV4V5ewLTcegTXywD5G
   g==;
X-CSE-ConnectionGUID: Mvk2rrGLRqy0auADrO+UNw==
X-CSE-MsgGUID: BMpPr+plSI+e72czu/miEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81602110"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81602110"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 11:36:07 -0700
X-CSE-ConnectionGUID: G0bckApxSPGY16CCQQxCtQ==
X-CSE-MsgGUID: iPgD75WXQA6PCGKwvcSMPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="245171448"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa008.jf.intel.com with ESMTP; 07 Jun 2026 11:36:02 -0700
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
Subject: [PATCH v14 net-next 07/13] dpll: balance create/delete notifications in __dpll_pin_(un)register
Date: Sun,  7 Jun 2026 20:30:39 +0200
Message-Id: <20260607183045.1213735-8-grzegorz.nitka@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296296-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F72C65141C

__dpll_pin_register() emits dpll_pin_create_ntf() internally, but
__dpll_pin_unregister() left the matching delete to its callers. The
counts then diverge on dpll_pin_on_pin_register() rollback and on
dpll_pin_on_pin_unregister(), leaking stale notifications.

Emit dpll_pin_delete_ntf() inside __dpll_pin_unregister() and drop the
now-redundant call in dpll_pin_unregister().

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index ea45bb41376c..1aaf62775408 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -926,6 +926,7 @@ __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 		      const struct dpll_pin_ops *ops, void *priv, void *cookie)
 {
 	ASSERT_DPLL_PIN_REGISTERED(pin);
+	dpll_pin_delete_ntf(pin);
 	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv, cookie);
 	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv, cookie);
 	if (xa_empty(&pin->dpll_refs)) {
@@ -953,7 +954,6 @@ void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 		return;
 
 	mutex_lock(&dpll_lock);
-	dpll_pin_delete_ntf(pin);
 	__dpll_pin_unregister(dpll, pin, ops, priv, NULL);
 	mutex_unlock(&dpll_lock);
 }
-- 
2.39.3


