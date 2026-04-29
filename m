Return-Path: <netdev+bounces-282271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK49MXK28WngjwEAu9opvQ
	(envelope-from <netdev+bounces-282271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:42:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 375744909D8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E4A630078A1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1993A544A;
	Wed, 29 Apr 2026 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/z50MRc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293733F595;
	Wed, 29 Apr 2026 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448560; cv=none; b=mV41lUTo7Ds6pp3reCgplzyWQ+Q/XiW/ttBIkZxD1yenm5l6uzJZEZfMeBW3vuJ6BwGVvYOEy7LNe1Q7elJsAznF266t1Yg1HE1se/cjRVZnhvDAJ6wZxlDaQKC85PIzXZRcx/3IHyMT6Zgg3ZnAnr7PkfWqneOHaxzKySnptD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448560; c=relaxed/simple;
	bh=Cr0vQaNUqcHT5qkJDPRkR29t4xZtKhdC8p1BUKcPsvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MckWfqsT1a0V/HttIOy5JCql6x8mTLYMFDdLtEWxnwX7+tQTFofL4UQ4utjyY8CyD9q8mDqeyp2WncQFr5yYXUsZ7XT3mZyblCzS0bsFTpQBROCALiR+o3Kfuqlr2B6BozyUJXsLfbbmx5syN42Ht64fg6c0ZWssel07XFzoXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/z50MRc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777448559; x=1808984559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cr0vQaNUqcHT5qkJDPRkR29t4xZtKhdC8p1BUKcPsvY=;
  b=i/z50MRc5q2gQA6wuQLdhj5dGsVknE5cJHbKtL1pnYfD+F87QKbE83FQ
   SCo8CKimzyx5r6T6BvYMZD5uyjoWTB7sKjSPa0QKd1CoOLmK2VObPAZLG
   jASbeew4pA59oEfZH4UrgqW/f6k6n8ozHRDd1vN2HoU2uPHTO0bM+Kf8T
   Y1GWIByLlD0W2njhwJN7ndkzyIMhwSeFepUWcBdcY/wCuNagNAJlQyFzx
   A5vGgf2TuyGTbGpxVTT60t/7GTZgL7w+4ssSATGaroBSqLZfP+7sO2Ob6
   huVwSBef9P6+zilPmykd7GQQr7zPF1Iskjd3dZsts0UQn3HbUtrzc4EN5
   Q==;
X-CSE-ConnectionGUID: gRVlTk6kTxqR7JDR6118CA==
X-CSE-MsgGUID: j7VumaU9S+y4/NzqOqkbRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89833758"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="89833758"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:42:38 -0700
X-CSE-ConnectionGUID: 8EIVIcpZRqitLPI+BaAevg==
X-CSE-MsgGUID: CeyFazFEQhSIaQZgcZd+ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="235968120"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 29 Apr 2026 00:42:35 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0A62A27BA2;
	Wed, 29 Apr 2026 08:42:32 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Alice Michael <alice.michael@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH iwl-net] idpf: fix RSS LUT memcpy size
Date: Wed, 29 Apr 2026 09:42:30 +0200
Message-ID: <20260429074232.180528-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 375744909D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282271-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]

Based on the following feedback from Sashiko (received for iXD phase 1
patchset, but valid for the net tree):

 "Is the bounds check xn_params.recv_mem.iov_len < lut_buf_size sufficient?
  Since lut_buf_size only represents the size of the array elements, should
  this check instead verify that the payload is at least
  sizeof(struct virtchnl2_rss_lut) + lut_buf_size?

  [...]

  Does memcpy copy the correct amount of data here? rss_lut_size stores the
  number of 32-bit entries, not the size in bytes. Should it use
  lut_buf_size or rss_data->rss_lut_size * sizeof(u32) instead?"

After inspecting the code, it was concluded that RSS memcpy size is in fact
4 times smaller than it has to be, since a single array entry in a u32, and
rss_data->rss_lut_size is clearly used as an array size. Required Rx buffer
size is also too small, but this is a common issue in the idpf code.

Use a full buffer size (lut_buf_size) instead of the array length
(rss_data->rss_lut_size) when doing memcpy of RSS lookup table.
While at it, increase required Rx buffer size to a whole flex-array
containing structure instead of just the array.

Link: https://sashiko.dev/#/patchset/20260323174052.5355-1-larysa.zaremba%40intel.com?part=8
Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index be66f9b2e101..a97d2e9b54d4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2916,7 +2916,7 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
 		return -EIO;
 
 	lut_buf_size = le16_to_cpu(recv_rl->lut_entries) * sizeof(u32);
-	if (reply_sz < lut_buf_size)
+	if (reply_sz < lut_buf_size + sizeof(struct virtchnl2_rss_lut))
 		return -EIO;
 
 	/* size didn't change, we can reuse existing lut buf */
@@ -2933,7 +2933,7 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
 	}
 
 do_memcpy:
-	memcpy(rss_data->rss_lut, recv_rl->lut, rss_data->rss_lut_size);
+	memcpy(rss_data->rss_lut, recv_rl->lut, lut_buf_size);
 
 	return 0;
 }
-- 
2.47.0


