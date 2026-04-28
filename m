Return-Path: <netdev+bounces-281638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMasKt9E8Gn2QwEAu9opvQ
	(envelope-from <netdev+bounces-281638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:25:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E844547D8B1
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D79F304FFB2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7662B3314DE;
	Tue, 28 Apr 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BizOmTUc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706E31F9AF
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353804; cv=none; b=V8J0ViX97aMEnJCCCbDOhmHj9oFji9CtJs6kMNQfLtYOkaA2bqc1C537uWGOeMUw8UnjmBTbCcWebf9tieCK88sQ+yWwtFmXo3KQumR2rUEJpy3KskwStVO/k5Bq4O2CzI0GOOGKGgA5T6MQw2c+pnvWh/XLnf2zwLP3pRQKy6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353804; c=relaxed/simple;
	bh=xHjOoXII3woC0umkN+H+dZdQAwzvJVslYS+0BgdECsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dML5INr7+y7rN0qKqCfU14GHAXB2nWBYN1YoLd9A2Pb/g77fyF53r3eNkvDNLM7shkrFzEWnbygT4+nrBv66fPkzhTWBELOG9Cw2e4sR7616ounVk+aZsrF/LsDEhA7ePrG8bj45U+VQFeYCusNuyd0ExUGDGRFCikaguxF49Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BizOmTUc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353803; x=1808889803;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xHjOoXII3woC0umkN+H+dZdQAwzvJVslYS+0BgdECsU=;
  b=BizOmTUcL7TORGVFeXRAFkllrwJ1fPVhTry1uJ5Attvkm3L7wdYHRKc0
   BhnIf9oaMj2Xk6jIP89ozd4eFFBS1x/fl6GZOdzMDiGxp7evh2NrzlNrL
   OW7FtvILtDPBprEG+N8rGao8yqFNnZnOg/GFEIYrFRIJL2zi0R6lKSzYC
   aB2MMDNjDoUJlmRLMYrwuWxt+4BgnbOFrmWRwsOo3U+ktquDChpRBtTeb
   4Q8Fnw+HZ5g9Go7g8EnSjpFSxc5Xj4M6sQiFhFzMVQyr12Kp9lDepV0uY
   uR/DEoY+7/fZu9g5VzUj6GR2/oklZqzlyblAP5AUmNC8fhlG4WSsi+TOG
   Q==;
X-CSE-ConnectionGUID: bSmK3F56T3SB3OrregB5VQ==
X-CSE-MsgGUID: 7NLr4gYQRhuwkAyM4CtvWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100910566"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="100910566"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
X-CSE-ConnectionGUID: eyAChkAeTF+PM+gfK+94HA==
X-CSE-MsgGUID: 1sQWvBACQd2Z0/BBPJMuyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237800219"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 27 Apr 2026 22:22:21 -0700
Subject: [PATCH net 09/11] dpll: export __dpll_pin_change_ntf() for use
 under dpll_lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-jk-iwl-net-petr-oros-fixes-v1-9-cdcb48303fd8@intel.com>
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
 Ivan Vecera <ivecera@redhat.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Petr Oros <poros@redhat.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2633;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=SMbrKDBZ2Rr1atw6pBdrJQRW3s8nYse+onA1vCvbkkU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswPLk72tQyBb3/wWV/U25luO+1P9svzkgJLOxZ/1ROv9
 Ht9NGNzRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABPZ/5Lhn9b+S/uEU1njozXf
 Z+/9+obhMEf4rLOGPerOK459VbwqG8rIME3IlCu7yDCwIsDYoVY08Y7TDMdLukfM/sVsZ2A/ujG
 IBQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: E844547D8B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281638-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]

From: Ivan Vecera <ivecera@redhat.com>

Export __dpll_pin_change_ntf() so that drivers can send pin change
notifications from within pin callbacks, which are already called
under dpll_lock. Using dpll_pin_change_ntf() in that context would
deadlock.

Add lockdep_assert_held() to catch misuse without the lock held.

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/dpll/dpll_netlink.h |  2 --
 include/linux/dpll.h        |  1 +
 drivers/dpll/dpll_netlink.c | 10 ++++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.h b/drivers/dpll/dpll_netlink.h
index dd28b56d27c5..a9cfd55f57fc 100644
--- a/drivers/dpll/dpll_netlink.h
+++ b/drivers/dpll/dpll_netlink.h
@@ -11,5 +11,3 @@ int dpll_device_delete_ntf(struct dpll_device *dpll);
 int dpll_pin_create_ntf(struct dpll_pin *pin);
 
 int dpll_pin_delete_ntf(struct dpll_pin *pin);
-
-int __dpll_pin_change_ntf(struct dpll_pin *pin);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index b7277a8b484d..f8037f1ab20b 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -286,6 +286,7 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
 
 int dpll_device_change_ntf(struct dpll_device *dpll);
 
+int __dpll_pin_change_ntf(struct dpll_pin *pin);
 int dpll_pin_change_ntf(struct dpll_pin *pin);
 
 int register_dpll_notifier(struct notifier_block *nb);
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index af7ce62ec55c..0ff1658c2dc1 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -900,11 +900,21 @@ int dpll_pin_delete_ntf(struct dpll_pin *pin)
 	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
 }
 
+/**
+ * __dpll_pin_change_ntf - notify that the pin has been changed
+ * @pin: registered pin pointer
+ *
+ * Context: caller must hold dpll_lock. Suitable for use inside pin
+ *          callbacks which are already invoked under dpll_lock.
+ * Return: 0 if succeeds, error code otherwise.
+ */
 int __dpll_pin_change_ntf(struct dpll_pin *pin)
 {
+	lockdep_assert_held(&dpll_lock);
 	dpll_pin_notify(pin, DPLL_PIN_CHANGED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
 }
+EXPORT_SYMBOL_GPL(__dpll_pin_change_ntf);
 
 /**
  * dpll_pin_change_ntf - notify that the pin has been changed

-- 
2.54.0.rc2.531.gaf818d63126a


