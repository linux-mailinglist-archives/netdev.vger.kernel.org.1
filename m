Return-Path: <netdev+bounces-279196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pc1LwSF4WkiuQAAu9opvQ
	(envelope-from <netdev+bounces-279196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:55:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67310415E0E
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B80F4306ADDD
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 00:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872092116F4;
	Fri, 17 Apr 2026 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAVbRIij"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098B26B95B
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776387278; cv=none; b=BBG3qqa5SIXyD0oNh9YkyOecn6OhFLhvUJ1X75qAhW+qOJM7hD9bFp09wc54DGdAHg3Ck26zfVRM+31VqzX4vu+OfNR+BosjW5+twX+nkKmKNajaQt7bJs02RHcuY2J8nGiLBP6z7tia0sY6NQYmC7KV+6jg1lvHqMQikjMCCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776387278; c=relaxed/simple;
	bh=wcF8E4ALSAG2ZBa2kVoWBfAPIRI7e/jEZSirmnyxVMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUQr2jOuYzAIRhrnNPnYavPXMNy85QybEAIKTjhjGbqkV72kcNKFsy4IPdsCeQ7EnkK2P42KT/Uf5B3zT2S2hMGDbnmRX0ft0BZ3Z9gw6cMqj3o35/nKHf3maAGmq7njg+/4jiFZ30J7QGC6NBW/RAZp1WpeZP6o7wsbRUHzJhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAVbRIij; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776387278; x=1807923278;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wcF8E4ALSAG2ZBa2kVoWBfAPIRI7e/jEZSirmnyxVMo=;
  b=oAVbRIijbrIiA0S28NvzaWoLryQpFeUl+NXbJrL84qF3okw1bj8JJpjr
   qxtrFfzWqfoCo1v0jx0HD3KNM6Nc+Ke2d8NhEshUBAApuE5v+VPQta0FX
   Kbr6LKd2bbkxGW27VS6jCErMi97Q+btUJL4btfYFDVlSG2krsNN/eCCNR
   xCup0gS2cYWj3a3Qjgo0bieOtn3r4nRKpDjGAE5YGrC2+dZk+nTc27F/y
   L2yFzkE48rSg4t9+PBfdwRUrvWaMXTPn2SEsCy70pgcPJ7N7Xpoy/NnK5
   YUR/OhazXI8whdRq+h5hmYFo6YV+iX8ShoG0fpjnUBT8MRAGbEGBKvWXq
   g==;
X-CSE-ConnectionGUID: NR2hei0jSXiX11Q/3QhURg==
X-CSE-MsgGUID: eAfoBJhyTw+bNbZrZH3wGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81000588"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="81000588"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:32 -0700
X-CSE-ConnectionGUID: eUisYfYIQqKLfLB3JMs9Ow==
X-CSE-MsgGUID: qlDO8SHiS7yiqXiO1baUzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226539894"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Apr 2026 17:53:36 -0700
Subject: [PATCH net v2 12/12] e1000e: Unroll PTP in probe error handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-iwl-net-submission-2026-04-14-v2-12-686c33c9828d@intel.com>
References: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
In-Reply-To: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Matt Vollrath <tactii@gmail.com>, Avigail Dahan <avigailx.dahan@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=6pEF7CplN7uNtVpJNw7hFn3TsXDcvPXHuvtqM6k3aUc=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyHLYeP7Hn8p32lymMXpjcfZIteZ6x66HZbage/cxnjP
 C2jLyEvO0pZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZiIkyYjwwb/P1/UJFOPbezX
 CDiSnbAjxUKVyV3rvCjvepb25RWW8xgZLpheLzK+sqdcqdJHffe1u/zHohxfvP1VWS/xc1G/rA8
 XCwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-279196-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67310415E0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Matt Vollrath <tactii@gmail.com>

If probe fails after registering the PTP clock and its delayed work,
these resources must be released.

This was not an issue until a 2016 fix moved the e1000e_ptp_init() call
before the jump to err_register.

Fixes: aa524b66c5ef ("e1000e: don't modify SYSTIM registers during SIOCSHWTSTAMP ioctl")
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9befdacd6730..7ce0cc8ab8f4 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7706,6 +7706,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_register:
 	if (!(adapter->flags & FLAG_HAS_AMT))
 		e1000e_release_hw_control(adapter);
+	e1000e_ptp_remove(adapter);
 err_eeprom:
 	if (hw->phy.ops.check_reset_block && !hw->phy.ops.check_reset_block(hw))
 		e1000_phy_hw_reset(&adapter->hw);

-- 
2.54.0.rc2.531.gaf818d63126a


