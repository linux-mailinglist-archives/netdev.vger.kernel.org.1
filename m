Return-Path: <netdev+bounces-228452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2FBBCB3F0
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 02:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8708341EF1
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 00:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD0C139D;
	Fri, 10 Oct 2025 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1CFJj0O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87734800;
	Fri, 10 Oct 2025 00:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054651; cv=none; b=X3F1PLFdiimcmDjEIuC832AXpgrQjXAFoh18EVd3ivDWDziV23/OTaOpB921lXP87ZEIssGxGdc2WcN8HjJV4rpdimYa3LQPcAPmks3qcP5w0JLSnVMuBUcMoKD82KBG17iq9U35fNJG0AGOzwUdcs5mvQAEJNlZAxQN63k2tPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054651; c=relaxed/simple;
	bh=GYcVpB/Rbd568LAIkFMQTYH7d1GIjnK4TTH3LzlrsF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRYYcJcpeS2oMzFjKogiaB6ZeQ2scuQnrPePAe4uLXd2oadAD6ZRT6Yj7EDweMmShFXXMZQcwaqApa5A/YgJkwlIGzfgNkk+zy5xCyF4JL3cIXYL1e5LvkxB6SRHdJipI20JudEKKU4QfAcPXb4KU65CD4owCoixw30SiCc3Mw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1CFJj0O; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760054650; x=1791590650;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GYcVpB/Rbd568LAIkFMQTYH7d1GIjnK4TTH3LzlrsF4=;
  b=i1CFJj0O9Hj0/Z5eO+HudocaTzsZZ0PADUloouexW/6hGZHO5/Sbqz/p
   jffpT7jKYF05pLmuv5emdynmEeE1Tpomnkr6BnF9J7MUDyO986ZuTdfxc
   w4FZPKKi72DaWnVaU/C9NdsFdmpgJmKDMx5vU7uupXojUrX1nmAxvM3Bb
   hfR4gMRDXrzLtnQrTuGJyEHOQwnGKpOrG/tUPx/KFb04KD4GHZBCcct33
   C8ZaMhq0n4X2Jc31/bMKeQPT2Nla60PehiEbV5UzqaPfeivvFBzGXvE87
   4ak1S9kYcz9dzGDw2YfwHKc43VrteUyX3OTjA5O6IW27natAWaPtzToeW
   A==;
X-CSE-ConnectionGUID: yovrYQhQRn2J8afcjFyauA==
X-CSE-MsgGUID: 4gb6tarXTw+VeWC8gnXbng==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="62316071"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="62316071"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:04:09 -0700
X-CSE-ConnectionGUID: lDoAXJc7T/ulA9mlgjL0Tg==
X-CSE-MsgGUID: KS72NxPUTZSyHGORJanoOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="180858268"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:04:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 09 Oct 2025 17:03:46 -0700
Subject: [PATCH net v3 1/6] idpf: cleanup remaining SKBs in PTP flows
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-jk-iwl-net-2025-10-01-v3-1-ef32a425b92a@intel.com>
References: <20251009-jk-iwl-net-2025-10-01-v3-0-ef32a425b92a@intel.com>
In-Reply-To: <20251009-jk-iwl-net-2025-10-01-v3-0-ef32a425b92a@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Phani Burra <phani.r.burra@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Samuel Salin <Samuel.salin@intel.com>
X-Mailer: b4 0.15-dev-89294
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=KTppvEjkGt0QXsvzcoJg6JlbsKXXXHH7KYc15giG5cE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowXvmXSORNj9yvtYv5zNsckObuNI8a1/cIxnhWftgWdY
 NJ9e/ptRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABNxU2L4p1ZZ8Ob1vMnvN21W
 /LBpm0W86r2yN4ULV/+SnBDt/97hwl5Ghmcrpk9ZWzqHx48jtmkOZ8qJ6plbi1nvpph94TuZ9kz
 /NDMA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Milena Olech <milena.olech@intel.com>

When the driver requests Tx timestamp value, one of the first steps is
to clone SKB using skb_get. It increases the reference counter for that
SKB to prevent unexpected freeing by another component.
However, there may be a case where the index is requested, SKB is
assigned and never consumed by PTP flows - for example due to reset during
running PTP apps.

Add a check in release timestamping function to verify if the SKB
assigned to Tx timestamp latch was freed, and release remaining SKBs.

Fixes: 4901e83a94ef ("idpf: add Tx timestamp capabilities negotiation")
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c          | 3 +++
 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 142823af1f9e..3e1052d070cf 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -863,6 +863,9 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 		u64_stats_inc(&vport->tstamp_stats.flushed);
 
 		list_del(&ptp_tx_tstamp->list_member);
+		if (ptp_tx_tstamp->skb)
+			consume_skb(ptp_tx_tstamp->skb);
+
 		kfree(ptp_tx_tstamp);
 	}
 	u64_stats_update_end(&vport->tstamp_stats.stats_sync);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 8a2e0f8c5e36..61cedb6f2854 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -517,6 +517,7 @@ idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
 	shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
 	skb_tstamp_tx(ptp_tx_tstamp->skb, &shhwtstamps);
 	consume_skb(ptp_tx_tstamp->skb);
+	ptp_tx_tstamp->skb = NULL;
 
 	list_add(&ptp_tx_tstamp->list_member,
 		 &tx_tstamp_caps->latches_free);

-- 
2.51.0.rc1.197.g6d975e95c9d7


