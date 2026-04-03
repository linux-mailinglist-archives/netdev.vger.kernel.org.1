Return-Path: <netdev+bounces-274893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLyIMn9Tz2kCvQYAu9opvQ
	(envelope-from <netdev+bounces-274893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:43:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6DF39129C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB5B430222D7
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 05:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8F6308F1D;
	Fri,  3 Apr 2026 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFWcgdek"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B4272E61
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775195005; cv=none; b=Isv5ODz/qkJrjxhJiSwjsGinIvgqppNh5UZdcdfGcikykyuTfvIlvVOnAS+Y1Dh0FMq5yHrY824BmJpzdAwbBQLl29PZuDb9Q/3etn7aB4x4VDF6yE9Ix5Z127UP5TggTB11kz5OOjEpU0DYIKt6VT6PwZZY2IOY4iQ2F7qye08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775195005; c=relaxed/simple;
	bh=F7mmVxPGICqRnePglmcXewjWAjCpBMiS2f/TuIVGVQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKul4YUSfig8YMh6FNQrKQiNbDE6VYMAa6+S0JXjm016k06Tmf6SOt7Ycf6rcu+vRV2ZQIOUzKXRz3q1GcA5E3HAvIi/mQTH9WBLkT5y+4wHYaUi8CAHSqPcWW3I1M9kJ9C/TWpMAmMIiwNRF1j5xuwaKylUKVobr/jH+2wV9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFWcgdek; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775195003; x=1806731003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F7mmVxPGICqRnePglmcXewjWAjCpBMiS2f/TuIVGVQc=;
  b=JFWcgdekuSAKcpmlRGrTUl2pCJ8sAafqbs5ydGgpqzsudctLCiN2fX+3
   26/y63SwpMcnjcuUSA/vpVrApDUC7TJG39i+YSoG6WZ2aySTZYbz4T9Vp
   prIKL/JBHqEtNCbbb79LAx/NZN6EzJkSO1AWJlk07oiZqNfKDzm61w18f
   Sh51liBQ3HDUA0TdIqmTkPvR93E+G/dS8ihqaRbj9GRhgvEUfcIzUTtXK
   UXbgh4KdwmjMlf4TTcht26wHZaiuJCnmxxPgovec2EfU9LtrJPj89UgYK
   JP/koQzqfVYuDVxCV2zTjfsGvmVIXH4u1n7SwIUGQIfK0VF2s8tyFcxqG
   Q==;
X-CSE-ConnectionGUID: sDPAQ1HPQpiiUbb+IW4lrA==
X-CSE-MsgGUID: UAXghGjjRnqMpeux2ZsZhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="87713711"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="87713711"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:43:23 -0700
X-CSE-ConnectionGUID: wX1So50NRyCynhQQao17iw==
X-CSE-MsgGUID: dCf2kjxcQXel/bXyIweq5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="220534463"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa009.fm.intel.com with ESMTP; 02 Apr 2026 22:43:21 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Leszek Pepiak <leszek.pepiak@intel.com>
Subject: [PATCH net-next] iavf: fix kernel-doc comment style in ethtool ops
Date: Fri,  3 Apr 2026 07:43:21 +0200
Message-ID: <20260403054321.3791392-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274893-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C6DF39129C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leszek Pepiak <leszek.pepiak@intel.com>

iavf_get_channels() and iavf_set_channels() use the legacy `**/`
comment terminator and embed the return description in the body text.
Convert to proper kernel-doc style: single `*/` terminator and an
explicit `Return:` section.

Signed-off-by: Leszek Pepiak <leszek.pepiak@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 8188dd4..425acbb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1846,13 +1846,13 @@ static int iavf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	return ret;
 }
 /**
- * iavf_get_channels: get the number of channels supported by the device
+ * iavf_get_channels - get the number of channels supported by the device
  * @netdev: network interface device structure
  * @ch: channel information structure
  *
  * For the purposes of our device, we only use combined channels, i.e. a tx/rx
  * queue pair. Report one extra channel to match our "other" MSI-X vector.
- **/
+ */
 static void iavf_get_channels(struct net_device *netdev,
 			      struct ethtool_channels *ch)
 {
@@ -1873,14 +1873,15 @@ static void iavf_get_channels(struct net_device *netdev,
 }
 
 /**
- * iavf_set_channels: set the new channel count
+ * iavf_set_channels - set the new channel count
  * @netdev: network interface device structure
  * @ch: channel information structure
  *
  * Negotiate a new number of channels with the PF then do a reset.  During
- * reset we'll realloc queues and fix the RSS table.  Returns 0 on success,
- * negative on failure.
- **/
+ * reset we'll realloc queues and fix the RSS table.
+ *
+ * Return: 0 on success, negative on failure.
+ */
 static int iavf_set_channels(struct net_device *netdev,
 			     struct ethtool_channels *ch)
 {
-- 
2.52.0


