Return-Path: <netdev+bounces-272398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA5mDFswxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:23:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD26340525
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A18F5301227E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E7A3B8944;
	Fri, 27 Mar 2026 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWbu+1Lz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57D3C3C1F
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596169; cv=none; b=d+ZDUZVpLyFviwJ23lwNHpjkE1ufqMUFRT5XZFk5U1Mon1HsSZ6jYgPk/scypXE1ju3l5vM+gHzvcs/in+nTZV1mYK1WtvkZC0ow6VZIRw+kfXfbYE6EuxnSfbay4hJsjluaGuRrwvNJUmexfZo+ODfnxpvSaID6SrAw2plhRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596169; c=relaxed/simple;
	bh=w2upXb+/H60kPmK6DnYQqP0hkeIBg/73pYuChVl8Uno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzHMDCWmadmqrBvJ7PC5QdexVX7Vpo9Z7S9FiZRzk1pcMj/uBYa+LT6up4quHpvI2a/IEurFie5rJolEhHlFhOgoyUbweCE0vR17raLMHXJWQC6MHaad6RObKOTHWGbyP1Pcv4e3t5KoANfNg/HHQRtYxSGaBAmtL8Q0wcrZeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWbu+1Lz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596164; x=1806132164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w2upXb+/H60kPmK6DnYQqP0hkeIBg/73pYuChVl8Uno=;
  b=lWbu+1LzBgT4jBaT6CU9ldKKjIz/OeWaOYnFoSuwdnJJYwUW3grJJk8/
   iqOtFkLXukyyPmjLjlnWd6ixE9qNGAjyWgH1A3w1yVId2+1Pn4e3gA3KD
   qrOY6OcRVsMkj6ax22GDEhhUBLgXQTlonGG012In06CZGoH3ijxPk1cxb
   ZseL/KMT9ohv1ahFuDKFFtds4e4ToZjFNs8nMS0IehMO1kTDoqU1eAihn
   d2v6Bsbdv+rWPq2Gz+1aA+8YobUaPD9FbtXZXnr9EIYEKOwxT9UE45zdT
   waj4Nt7kMQ4xX2h+n6uVd4VfISWuoaEYRsmPuL25b6LE+M1t05YetOpt1
   A==;
X-CSE-ConnectionGUID: 6HaLFj6fR5SF//EdF4ZeWA==
X-CSE-MsgGUID: QsP+sR5zTa2UaqfFWWvZzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74848622"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="74848622"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:22:44 -0700
X-CSE-ConnectionGUID: fRdz4TeRRHCLC1x9Iuc8AQ==
X-CSE-MsgGUID: +3mJ6Il0QLyrFUxb1tDM7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="222359644"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2026 00:22:43 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@intel.com>
Subject: [PATCH iwl-next] ice: call netif_keep_dst() once when entering switchdev mode
Date: Fri, 27 Mar 2026 08:22:36 +0100
Message-ID: <20260327072236.129802-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
References: <20260327072236.129802-1-aleksandr.loktionov@intel.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272398-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 8DD26340525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marcin Szycik <marcin.szycik@intel.com>

netif_keep_dst() only needs to be called once for the uplink VSI, not
once for each port representor.  Move it from ice_eswitch_setup_repr()
to ice_eswitch_enable_switchdev().

Fixes: defd52455aee ("ice: do Tx through PF netdev in slow-path")
Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f096..c30e27b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -117,8 +117,6 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 	if (!repr->dst)
 		return -ENOMEM;
 
-	netif_keep_dst(uplink_vsi->netdev);
-
 	dst = repr->dst;
 	dst->u.port_info.port_id = vsi->vsi_num;
 	dst->u.port_info.lower_dev = uplink_vsi->netdev;
@@ -312,6 +310,8 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 	if (ice_eswitch_br_offloads_init(pf))
 		goto err_br_offloads;
 
+	netif_keep_dst(uplink_vsi->netdev);
+
 	pf->eswitch.is_running = true;
 
 	return 0;
-- 
2.52.0


