Return-Path: <netdev+bounces-240592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 722E5C76BD5
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2BF962DBB2
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B6B221DAD;
	Fri, 21 Nov 2025 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lShi4Jk2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1E20E702
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684360; cv=none; b=fZrGrKHnnRQYwuntPh/ADssmv7pLbX3oyJjLqxawLuhywCHMpEgPdWDMQLpcz2CcYuWXDHPvWg6ap6mHt1/7TdUcVDF+qbSSSX7DDbYJUQEEP5aZ6TJZiFK2d+f/oCYOj59dpyvB/f4oyRwqmyfOeJR2d7jsnCsM/CNWJy4tols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684360; c=relaxed/simple;
	bh=ac+SqF+nclpj0220XqgkFGA2lonSr+pAqOAfRRXyCyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qJaUZzf7GRT9NmR1Ao3bzHySpd+Dpsp42khc9HiApI8FVclDM7xWyu8SnJ+EHZvBQev9nzyu58El1ujELVZaBEO39C7ylNKPJHWzcL1JdM6ZUxttaQHyq+SQP+NO3ZijuRDX/nU0tfSHbf/prtV3yMBYV59Is5O5eMn2tgPlZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lShi4Jk2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763684359; x=1795220359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ac+SqF+nclpj0220XqgkFGA2lonSr+pAqOAfRRXyCyk=;
  b=lShi4Jk2wm5/j7SJZphzso+4gPB0ZcxzgiXp7FKFKnQukgrU38NVTiDm
   r6npbycSVzHSLlnOnx6HBYio3nOdw6CZBfI9Vwsrar8XdqkdWxlN67tuA
   kK4aZdm/3X7uL/Rcl7oaTriY37MgCPfcX2dvUUugyPGovX2bCIjrtFBV7
   s8HMQ7eGUoJQwzcNghN69kJuWaCcxsVgf2xdogMF1GmbYGUTT2EMeIO5F
   qevN5iHZFtBMaX+LpUq0XTRyErjRX3IHwTo7IZ9uYuKvpypcQrhxqgBwY
   Au8LceTOXdvV0uzvA9jut6Y0u4ZtYgrekaCIxezIKoeBfA2cR1VOPiQht
   A==;
X-CSE-ConnectionGUID: hrIcsV2LQkyZ77auph8+tg==
X-CSE-MsgGUID: JcWX69z6Rmec5BmWjCetnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65704068"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="65704068"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:19:15 -0800
X-CSE-ConnectionGUID: 9patfTSeSl+wYjuBlrU3vQ==
X-CSE-MsgGUID: F4qIXi24T2evqRHr5rP5dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="190815179"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa010.jf.intel.com with ESMTP; 20 Nov 2025 16:19:15 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	iamvivekkumar@google.com
Subject: [PATCH iwl-net v2 3/5] idpf: fix memory leak in idpf_vport_rel()
Date: Thu, 20 Nov 2025 16:12:16 -0800
Message-Id: <20251121001218.4565-4-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20251121001218.4565-1-emil.s.tantilov@intel.com>
References: <20251121001218.4565-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Free vport->rx_ptype_lkup in idpf_vport_rel() to avoid leaking memory
during a reset. Reported by kmemleak:

unreferenced object 0xff450acac838a000 (size 4096):
  comm "kworker/u258:5", pid 7732, jiffies 4296830044
  hex dump (first 32 bytes):
    00 00 00 00 00 10 00 00 00 10 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00  ................
  backtrace (crc 3da81902):
    __kmalloc_cache_noprof+0x469/0x7a0
    idpf_send_get_rx_ptype_msg+0x90/0x570 [idpf]
    idpf_init_task+0x1ec/0x8d0 [idpf]
    process_one_work+0x226/0x6d0
    worker_thread+0x19e/0x340
    kthread+0x10f/0x250
    ret_from_fork+0x251/0x2b0
    ret_from_fork_asm+0x1a/0x30

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5c81f52db266..5193968c9bb1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1105,6 +1105,8 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 		kfree(adapter->vport_config[idx]->req_qs_chunks);
 		adapter->vport_config[idx]->req_qs_chunks = NULL;
 	}
+	kfree(vport->rx_ptype_lkup);
+	vport->rx_ptype_lkup = NULL;
 	kfree(vport);
 	adapter->num_alloc_vports--;
 }
-- 
2.37.3


