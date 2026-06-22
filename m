Return-Path: <netdev+bounces-301207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HVDRBuuwOWqNwQcAu9opvQ
	(envelope-from <netdev+bounces-301207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:02:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1006B28E7
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:02:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MUzB5wlz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301207-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301207-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3708D304ED4C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA2937B002;
	Mon, 22 Jun 2026 22:01:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A736EAA8
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:01:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165671; cv=none; b=p4Aa6ZIcrzls3MuTAljR57I5pbedkBfLhBdlrP9UrSP7X+h6vumXQpuaGgkF8mL1E5ZZWE0rMPNgT9/Ybzd9lHqmVE+t4v1OMaCuXOwsZsY3dbWiKoNuXiZJtJIyBAFl+GBH3JSFMlZ74AILO8NGdRbPaTmIhjuIcbzrNfLM5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165671; c=relaxed/simple;
	bh=hhJPtkwWzdgej5p2pcotsrPswsrK6ECzfn22qJnoGkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0kfJeXHd8anuU75zdIVT+6MDNL4Sz8NHeM5/f3NF6DJwym9aU/73AQpaIw3DLCL99Y29Pj58/J0nXj+Tn8bK9wCawQF5/C1giqyqJogscL+w5rUT7ZzGv70xD8GRdwJ/tQbQq6zobDkfvEAOePjel3peFiMXzNsq2zWPamaOCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUzB5wlz; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782165670; x=1813701670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hhJPtkwWzdgej5p2pcotsrPswsrK6ECzfn22qJnoGkM=;
  b=MUzB5wlzc9QrN2fPou0vdeQdFdy4ohVMbTR5pnFldYd65jd+UkhEdfRr
   9o36tPutCxO9cqt3ZHeFkKkR/9NizTmECciGFzFmscSccGbENYGNtOcbl
   zyh97xH+LesZg33V9EN/L8Rf7NUiSEOKsOiwCWyzcXs0aPIFkdH3f36b7
   uFHF7vj1FAbeCMN8FkLXGrNIyWu7h4dXqheESprIB0tNm/3iIWP0NzDhl
   1FcsnzoBiXBJryNo4BCqQkLn1NxEZ1a3GHibYPbdyl0dughx964csadeC
   n9pIiyBOeYI8JPnzTYgyrnSCfMBhwi2BTlmKuFt5ObwxuPNXVDk6v0ge/
   Q==;
X-CSE-ConnectionGUID: BuIoBn0oRqKmAWr0dPnP4w==
X-CSE-MsgGUID: JYem6SpRSjq3s3qWCh4IAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82675580"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82675580"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 15:01:05 -0700
X-CSE-ConnectionGUID: DRc3HyLyQQGcIkkpl3o3YQ==
X-CSE-MsgGUID: AWzXNGtxSTqkm5U8jtJnWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="248205721"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 22 Jun 2026 15:01:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	grzegorz.nitka@intel.com,
	jiri@resnulli.us,
	vadim.fedorenko@linux.dev,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 5/8] ice: dpll: set pointers to NULL after kfree in ice_dpll_deinit_info
Date: Mon, 22 Jun 2026 15:00:52 -0700
Message-ID: <20260622220059.2471844-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
References: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301207-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:zhaojinming@uniontech.com,m:anthony.l.nguyen@intel.com,m:arkadiusz.kubalewski@intel.com,m:grzegorz.nitka@intel.com,m:jiri@resnulli.us,m:vadim.fedorenko@linux.dev,m:aleksandr.loktionov@intel.com,m:sx.rinitha@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C1006B28E7

From: ZhaoJinming <zhaojinming@uniontech.com>

ice_dpll_deinit_info() calls kfree() on several pf->dplls fields
(inputs, outputs, eec.input_prio, pps.input_prio) but does not set
the pointers to NULL afterward. This leaves dangling pointers in the
pf->dplls structure.

While not currently exploitable through existing code paths, this is
unsafe because:

1. If ice_dpll_init_info() is called again after a deinit (e.g. during
   driver recovery), and a subsequent allocation within init fails, the
   error path will jump to deinit_info and call ice_dpll_deinit_info()
   again. Since some pointers still hold the old freed addresses, this
   would result in a double-free.

2. Any future code that checks these pointers before use or after free
   would be unprotected against use-after-free.

Follow the common kernel convention of setting pointers to NULL after
kfree() so that:
- kfree(NULL) is a safe no-op, preventing double-free
- NULL checks on these pointers become meaningful

This is a preparatory fix for a subsequent patch that routes additional
error paths in ice_dpll_init_info() to the deinit_info label.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 462c69cc11e1..3876ee7255ac 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -4645,9 +4645,13 @@ ice_dpll_init_pins_info(struct ice_pf *pf, enum ice_dpll_pin_type pin_type)
 static void ice_dpll_deinit_info(struct ice_pf *pf)
 {
 	kfree(pf->dplls.inputs);
+	pf->dplls.inputs = NULL;
 	kfree(pf->dplls.outputs);
+	pf->dplls.outputs = NULL;
 	kfree(pf->dplls.eec.input_prio);
+	pf->dplls.eec.input_prio = NULL;
 	kfree(pf->dplls.pps.input_prio);
+	pf->dplls.pps.input_prio = NULL;
 }
 
 /**
-- 
2.47.1


