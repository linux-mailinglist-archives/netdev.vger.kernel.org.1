Return-Path: <netdev+bounces-259628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDkPJliul2nO5QIAu9opvQ
	(envelope-from <netdev+bounces-259628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:44:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 142BA163F05
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64EA9308AFC4
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DC01B0F19;
	Fri, 20 Feb 2026 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQ/8OfIR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B938212FAD
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548044; cv=none; b=mXE48AuLmK7GWbJqTt5sFAnNLaK1cjcHHOD1chTfpBWuKtABpYO8yV0fhnqO0yv72E17hjVvYtPNaSbv/Sp4Myz4dpaV1MvJF4D2CBXuplquyTeGgaqbKuQkpHbJJLHVpA9n9hJDOn/uKb0KjJOSJQuHCBkhCv4z5sZm0Ty1XJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548044; c=relaxed/simple;
	bh=pB8B+KtdnPJUz+lsnXATs/26XzETnrdZQD9rBj5oCGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6BAH1IGBJYgS9NStlHeE5NzEun7Fqk8w1fnrp6cp8znIulmYJW0CVe2nfy47LiYdwT23wTVc/Bubrnij0RZatJN8NqxAQe2ZQ1TUVdOxdR3p7EN0VguRKNtJa/VHK4p/78WgdYUiz68k7YAVSkFMA96hdNTYmYrSL4h3s4eD2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQ/8OfIR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771548038; x=1803084038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pB8B+KtdnPJUz+lsnXATs/26XzETnrdZQD9rBj5oCGU=;
  b=IQ/8OfIRSdsFLUyk2kiEGr4lVs4q38A3fNA1tHCOLNCk6CoJp6o8VuHA
   scr+OkppKrEaOciM9EPsOG3qfbDadgqvYi+seitEBE22WqmGtnyZXXSbJ
   bXApb2TaYKdXeFPfWc9i8q9FXnDo6hpjnMrWUr60N1piiXAXxe/JKHJVi
   hwS9qXhCunrMtAFS8QX87ytFYZpchvOWgXg81M4Ok6YJeLxn0BKbtAPLN
   IaKrjfy3VFxGCA1jF0KI0TfgH7A8okzGPObIpXkT5vHdgNGYgwVAB2wml
   1t28SMVy3+OpcfoEAnGtmppi96J32CLrdBJvm2VCUeAeA79dTYBw16jqx
   w==;
X-CSE-ConnectionGUID: T6IqAy7oSySl/9Sq7JeBeg==
X-CSE-MsgGUID: o2fpZisKQzmUUD5xI3Wwug==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76484203"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76484203"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 16:40:34 -0800
X-CSE-ConnectionGUID: 9KtDXmQjTyO4IITjAebxbA==
X-CSE-MsgGUID: vOcQ4uemQp+WNZ8RMne4Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218850478"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 16:40:33 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Sreedevi Joshi <sreedevi.joshi@intel.com>,
	anthony.l.nguyen@intel.com,
	sridhar.samudrala@intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net 06/13] idpf: Fix flow rule delete failure due to invalid validation
Date: Thu, 19 Feb 2026 16:40:18 -0800
Message-ID: <20260220004027.729384-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
References: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259628-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 142BA163F05
X-Rspamd-Action: no action

From: Sreedevi Joshi <sreedevi.joshi@intel.com>

When deleting a flow rule using "ethtool -N <dev> delete <location>",
idpf_sideband_action_ena() incorrectly validates fsp->ring_cookie even
though ethtool doesn't populate this field for delete operations. The
uninitialized ring_cookie may randomly match RX_CLS_FLOW_DISC or
RX_CLS_FLOW_WAKE, causing validation to fail and preventing legitimate
rule deletions. Remove the unnecessary sideband action enable check and
ring_cookie validation during delete operations since action validation
is not required when removing existing rules.

Fixes: ada3e24b84a0 ("idpf: add flow steering support")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 1d78a621d65b..3275b0215655 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -307,9 +307,6 @@ static int idpf_del_flow_steer(struct net_device *netdev,
 	vport_config = vport->adapter->vport_config[np->vport_idx];
 	user_config = &vport_config->user_config;
 
-	if (!idpf_sideband_action_ena(vport, fsp))
-		return -EOPNOTSUPP;
-
 	rule = kzalloc(struct_size(rule, rule_info, 1), GFP_KERNEL);
 	if (!rule)
 		return -ENOMEM;
-- 
2.47.1


