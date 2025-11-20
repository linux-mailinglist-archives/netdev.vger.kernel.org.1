Return-Path: <netdev+bounces-240311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9232C72C2D
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 09:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA7DF3498C2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FE72D7DEC;
	Thu, 20 Nov 2025 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VumFu3qZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mz8wCpUA"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939125EFBE
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626724; cv=none; b=Qf7mzrqqB/S7jMT/R8OeYmmWl6HVxKkuKBnf2pfo3PhaUuGSU3CBZoff1/+72/9pSnDsz70L1LJOdU7pPY4fbv8NpDEHrZfCvSFZ2YbDY18WflMtFCc1eB+hob/ck5xWs3Q2wOOiPGHGQQ1ZTJWbzVkYScxYPuFyZZ6+7bJltCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626724; c=relaxed/simple;
	bh=4zs6dQiUsbud0QNo8M/84mTmJeZFGcjU07Ztqhgvo+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LP105wnxN7dNUAmE7ltZJq3UpRfhX+qzR4g0ii2zbqPkGx6hP9rcWO+2F1DrQ9PSlpfj/Vn7Rrd4k+PQzmO5S8d9lrBxMFIe1Y/D+En8LNcUNKB+qdZOCqU4h/cLdcBwgk/67A59tBOBichlalRw++T2oCeu0JsIIfrZgnUHMEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VumFu3qZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mz8wCpUA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763626720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=53XnJLhHTCr1gL3u2Gkylmbe3ug+lFlZqtZzGJe+tzo=;
	b=VumFu3qZX9MIdWFzBmesbSnKGU3kz9RKUUv8bFrhdbwOjJolDmhnjDdfXIvQ2/IAxcJSbQ
	ea6cQaz8LXK1PA7gDdhbvggf/3CASRLGXzg+/Ecy6quDX0/sBIZ6w8xA7jHGC3XIPcEowS
	YKuny2NoMXE8919oN9Y308kReMzruIAsKIFegP4R7Uu0bSSqT2v0G5cxHnKdLee5BXID81
	ZeNc0mUmye9tXK7RDQfapsPM+uGY/P2/4UXFFxTIXXvPuP+f0kB6Zyy4Vr2JpwgSqbStJZ
	KmGOU3HQ3znuw/ZDf7KouvmfOAgB+2/wUtTVd/tA0jV4M6gqRf9Vs0+zSKDRaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763626720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=53XnJLhHTCr1gL3u2Gkylmbe3ug+lFlZqtZzGJe+tzo=;
	b=mz8wCpUA1ieY8oarKcmRXkWpfMaRhEt2TSXVDP9lWDP1V5pWpxmwPGZhxWFB9SBEB+x5yC
	4vaur7nEWi1ZwCBQ==
Date: Thu, 20 Nov 2025 09:18:29 +0100
Subject: [PATCH iwl-net v3] igc: Restore default Qbv schedule when changing
 channels
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-igc_mqprio_channels-v3-1-ce7d6f00720d@linutronix.de>
X-B4-Tracking: v=1; b=H4sIANTOHmkC/33NQQ6CMBAF0KuQWVtDB4rgynsYQ5QOMAm22CJiC
 He3sjLGuPz589/M4MkxedhHMzga2bM1ISSbCKr2bBoSrEMGjFFJGe8EN1V5vfWObfk+MNR5gQk
 WMssoL/ILhGXvqOZpVY/Aj04YGuAUipb9YN1z/TbKtf4Lj1JIkWIqlcpQx3V+6NjcB2cNT1tNq
 znihyPz3w4Gp0pQZYkmTVh/O8uyvAC4K1bSCwEAAA==
X-Change-ID: 20251107-igc_mqprio_channels-2329166e898b
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3641; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=4zs6dQiUsbud0QNo8M/84mTmJeZFGcjU07Ztqhgvo+o=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBpHs7ghk/d7uaX8BpL30sKtTPZeJXoDq9pSVgvi
 0s6ha2wYvyJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCaR7O4AAKCRDBk9HyqkZz
 gtxSD/9rj7bERx6w5kGcV2DoR2ldR8lIq2GRyOPnLR6s5a80NgX4PHVgFFTKocvFM3tJ5M+fZl+
 Gf8/GbtfPYnJp/MFSg8Rae4R8Su9bNndgHXSMoCrxLmzxAjszMkWTwrz2dPZJul3Hyf8nbZi5l/
 mCrHrTwvcXflkReKGlEumAZVuvuqOBfFl9tFWPgXrTPwXt+i6qXa/6DQYLaKQlKIHURZm5weTUV
 9N2kMfb/BtxxcSMt6tfm5Qf705xVhzTsFPoepYCs3/Xj5a1mxbBeBulHYpq0EAKCoaDeEE6P2/g
 bWz+ysEpo54CYe+a7OFQJNXMWhcIqw2G0eGMKa54eiWSgh84L/uw+RB7+POEl81jaQrOC0YpnGP
 rYfIqbdbXZi1kK1SR22swQMsn6WLaXtcsIu8QjhN/WMe0i02zwn6BGsWN4Y4I5AkYfPzF4SAUto
 VeNbFghc1xYZEI8LmZg9QquF2YpjAwmPoxRhb3YTy58SMiSJIZXq2sM2KPXLOLNDIwmNRK0XUaY
 JmtG/0bmCZG/jPc7kUiEztNjdL2ZYk9fXwqe/q78wvtoDNtBE8NcNiHYjRg7G2xFP5youzgHdws
 lqkrpZMa6sWVN90WUMC8j17IZeMN52yZqxGNm/L/Yzg3E1UyhYi0/Ii1hPNmf4oEbmMk+MBoUpA
 wBt4MS2yrJ6qeEQ==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

The Multi-queue Priority (MQPRIO) and Earliest TxTime First (ETF) offloads
utilize the Time Sensitive Networking (TSN) Tx mode. This mode is always
coupled to IEEE 802.1Qbv time aware shaper (Qbv). Therefore, the driver
sets a default Qbv schedule of all gates opened and a cycle time of
1s. This schedule is set during probe.

However, the following sequence of events lead to Tx issues:

 - Boot a dual core system
   igc_probe():
     igc_tsn_clear_schedule():
       -> Default Schedule is set
       Note: At this point the driver has allocated two Tx/Rx queues, because
       there are only two CPUs.

 - ethtool -L enp3s0 combined 4
   igc_ethtool_set_channels():
     igc_reinit_queues()
       -> Default schedule is gone, per Tx ring start and end time are zero

  - tc qdisc replace dev enp3s0 handle 100 parent root mqprio \
      num_tc 4 map 3 3 2 2 0 1 1 1 3 3 3 3 3 3 3 3 \
      queues 1@0 1@1 1@2 1@3 hw 1
    igc_tsn_offload_apply():
      igc_tsn_enable_offload():
        -> Writes zeros to IGC_STQT(i) and IGC_ENDQT(i), causing Tx to stall/fail

Therefore, restore the default Qbv schedule after changing the number of
channels.

Furthermore, add a restriction to not allow queue reconfiguration when
TSN/Qbv is enabled, because it may lead to inconsistent states.

Fixes: c814a2d2d48f ("igc: Use default cycle 'start' and 'end' values for queues")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v3:
- Adjust commit message and comments (Aleksandr)
- Link to v2: https://lore.kernel.org/r/20251118-igc_mqprio_channels-v2-1-c32563dede2f@linutronix.de

Changes in v2:
- Explain abbreviations (Aleksandr)
- Only clear schedule if no error happened (Aleksandr)
- Add restriction to avoid inconsistent states (Vinicius)
- Target net tree (Vinicius)
- Link to v1: https://lore.kernel.org/r/20251107-igc_mqprio_channels-v1-1-42415562d0f8@linutronix.de
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c    | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index bb783042d1af9c86f18fc033fa4c3e75abb0efe8..4b39329e9e32bf34cef66e69b59d05b54cfeabff 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1561,8 +1561,8 @@ static int igc_ethtool_set_channels(struct net_device *netdev,
 	if (ch->other_count != NON_Q_VECTORS)
 		return -EINVAL;
 
-	/* Do not allow channel reconfiguration when mqprio is enabled */
-	if (adapter->strict_priority_enable)
+	/* Do not allow channel reconfiguration when any TSN qdisc is enabled */
+	if (adapter->flags & IGC_FLAG_TSN_ANY_ENABLED)
 		return -EINVAL;
 
 	/* Verify the number of channels doesn't exceed hw limits */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 728d7ca5338bf27c3ce50a2a497b238c38cfa338..21e67e7534562ccfa7bad8769bbafc866ecbc85f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7761,6 +7761,11 @@ int igc_reinit_queues(struct igc_adapter *adapter)
 	if (netif_running(netdev))
 		err = igc_open(netdev);
 
+	if (!err) {
+		/* Restore default IEEE 802.1Qbv schedule after queue reinit */
+		igc_tsn_clear_schedule(adapter);
+	}
+
 	return err;
 }
 

---
base-commit: bc41fbbf6faa9ffeaf0148019ed631077f7f150f
change-id: 20251107-igc_mqprio_channels-2329166e898b

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


