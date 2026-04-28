Return-Path: <netdev+bounces-281635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHsXL6VE8Gn2QwEAu9opvQ
	(envelope-from <netdev+bounces-281635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:24:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D18647D89A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 239043044BB6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76D31F992;
	Tue, 28 Apr 2026 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vx4ZGGl6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D43314DE
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353802; cv=none; b=i2+92Xd3B6RpnV/EjpKZiIBgy7Sw1auNW0vn1jdRLSfifgaBNDEo9tlLgScGFz9ILGI75Z4OkkRWsz5cHn9GRHJ48JdftDZKfRDF3Q+T5y90EMzWV/vkNZWqtiv+F7FHYxpDBohkzNBxpb9pefC0d5VEKuPgyjMDmNWVU/3mil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353802; c=relaxed/simple;
	bh=rxIUYceQHTvx8Y2hYttn11t6gXaatPIwNKCRSwNRSBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3/VCgryYfw6oiZuw1g6EKqDystbITW9X7wronqqg6nticeFRp1QoNN7LjNOE4Yh/xOOc0taPTK85PUnw6mO2VwJMre6+gH3vSxWF5fjeWZaJiaXyTtf3+nIPvn9+T9LdMYm68ogTd/peWmVzDiw73eGpgEgV5q215LXcVivGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vx4ZGGl6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353801; x=1808889801;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rxIUYceQHTvx8Y2hYttn11t6gXaatPIwNKCRSwNRSBI=;
  b=Vx4ZGGl6EHZO9o+STUhw4W2TgiqCN7TKWaZEi31E6+HITiRyVZxjm74/
   YrcPfh96kRnyY7jaQfi79GbkX8BU8oDNX5/p2/F1FcVn2O0NXtV4AiSyN
   ZMduOBL3BCNPd/KCIbWhaY+5ao+G17H14mQqJH/gb4hB2fwOydgLTH71+
   1TMyYRYc+WTdmqR3Qla59yAGoqtwhr31zgMAZXaf6VXQzQRQRwbEK7xbW
   Tf2TNQTFCqvX+1K6P6A8RitgHurgdtYnt9z+EDBUFmbNpKfclXsr9Epz5
   ZffbsOQS2VyfkCVja4K+zlHvaP1rYbD1/R+hboSRxMViLFvynIuW3xCU6
   g==;
X-CSE-ConnectionGUID: PVeWNCSHTtWHAIEezoE3gg==
X-CSE-MsgGUID: 9H4Y+PSrTie8ECR+QXUZ4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100910543"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="100910543"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
X-CSE-ConnectionGUID: c8e8HiaYQkasPGFg3ebJ2w==
X-CSE-MsgGUID: lSEHaUn5TY+o3srGPtgFNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237800206"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 27 Apr 2026 22:22:17 -0700
Subject: [PATCH net 05/11] ice: fix NULL pointer dereference in
 ice_reset_all_vfs()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-jk-iwl-net-petr-oros-fixes-v1-5-cdcb48303fd8@intel.com>
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
 Petr Oros <poros@redhat.com>, Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5328;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=izQ1IeWvkdpyQoEJmwIhodPDHwI9+CJGnPEwQf7SS9A=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswPLo7C0+XUL5+addpgJS8/65kf1UXJIUU8C/f7XjVnb
 n9jE7uxo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIn8v8/wPyQxiO9T8u3QBTfL
 ZfxOeR9gPjsrWLekUUT50yUF/QnMMxgZdmTsPpUo+U55V85fM9GdNvzzfy3fsTjZNLrhQkpGbtV
 xfgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 1D18647D89A
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
	TAGGED_FROM(0.00)[bounces-281635-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Petr Oros <poros@redhat.com>

ice_reset_all_vfs() ignores the return value of ice_vf_rebuild_vsi().
When the VSI rebuild fails (e.g. during NVM firmware update via
nvmupdate64e), ice_vsi_rebuild() tears down the VSI on its error path,
leaving txq_map and rxq_map as NULL. The subsequent unconditional call
to ice_vf_post_vsi_rebuild() leads to a NULL pointer dereference in
ice_ena_vf_q_mappings() when it accesses vsi->txq_map[0].

The single-VF reset path in ice_reset_vf() already handles this
correctly by checking the return value of ice_vf_reconfig_vsi() and
skipping ice_vf_post_vsi_rebuild() on failure.

Apply the same pattern to ice_reset_all_vfs(): check the return value
of ice_vf_rebuild_vsi() and skip ice_vf_post_vsi_rebuild() and
ice_eswitch_attach_vf() on failure. The VF is left safely disabled
(ICE_VF_STATE_INIT not set, VFGEN_RSTAT not set to VFACTIVE) and can
be recovered via a VFLR triggered by a PCI reset of the VF
(sysfs reset or driver rebind).

Note that this patch does not prevent the VF VSI rebuild from failing
during NVM update — the underlying cause is firmware being in a
transitional state while the EMP reset is processed, which can cause
Admin Queue commands (ice_add_vsi, ice_cfg_vsi_lan) to fail. This
patch only prevents the subsequent NULL pointer dereference that
crashes the kernel when the rebuild does fail.

 crash> bt
     PID: 50795    TASK: ff34c9ee708dc680  CPU: 1    COMMAND: "kworker/u512:5"
      #0 [ff72159bcfe5bb50] machine_kexec at ffffffffaa8850ee
      #1 [ff72159bcfe5bba8] __crash_kexec at ffffffffaaa15fba
      #2 [ff72159bcfe5bc68] crash_kexec at ffffffffaaa16540
      #3 [ff72159bcfe5bc70] oops_end at ffffffffaa837eda
      #4 [ff72159bcfe5bc90] page_fault_oops at ffffffffaa893997
      #5 [ff72159bcfe5bce8] exc_page_fault at ffffffffab528595
      #6 [ff72159bcfe5bd10] asm_exc_page_fault at ffffffffab600bb2
         [exception RIP: ice_ena_vf_q_mappings+0x79]
         RIP: ffffffffc0a85b29  RSP: ff72159bcfe5bdc8  RFLAGS: 00010206
         RAX: 00000000000f0000  RBX: ff34c9efc9c00000  RCX: 0000000000000000
         RDX: 0000000000000000  RSI: 0000000000000010  RDI: ff34c9efc9c00000
         RBP: ff34c9efc27d4828   R8: 0000000000000093   R9: 0000000000000040
         R10: ff34c9efc27d4828  R11: 0000000000000040  R12: 0000000000100000
         R13: 0000000000000010  R14:   R15:
         ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
      #7 [ff72159bcfe5bdf8] ice_sriov_post_vsi_rebuild at ffffffffc0a85e2e [ice]
      #8 [ff72159bcfe5be08] ice_reset_all_vfs at ffffffffc0a920b4 [ice]
      #9 [ff72159bcfe5be48] ice_service_task at ffffffffc0a31519 [ice]
     #10 [ff72159bcfe5be88] process_one_work at ffffffffaa93dca4
     #11 [ff72159bcfe5bec8] worker_thread at ffffffffaa93e9de
     #12 [ff72159bcfe5bf18] kthread at ffffffffaa946663
     #13 [ff72159bcfe5bf50] ret_from_fork at ffffffffaa8086b9

 The panic occurs attempting to dereference the NULL pointer in RDX at
 ice_sriov.c:294, which loads vsi->txq_map (offset 0x4b8 in ice_vsi).

 The faulting VSI is an allocated slab object but not fully initialized
 after a failed ice_vsi_rebuild():

  crash> struct ice_vsi 0xff34c9efc27d4828
    netdev = 0x0,
    rx_rings = 0x0,
    tx_rings = 0x0,
    q_vectors = 0x0,
    txq_map = 0x0,
    rxq_map = 0x0,
    alloc_txq = 0x10,
    num_txq = 0x10,
    alloc_rxq = 0x10,
    num_rxq = 0x10,

 The nvmupdate64e process was performing NVM firmware update:

  crash> bt 0xff34c9edd1a30000
  PID: 49858    TASK: ff34c9edd1a30000  CPU: 1    COMMAND: "nvmupdate64e"
   #0 [ff72159bcd617618] __schedule at ffffffffab5333f8
   #4 [ff72159bcd617750] ice_sq_send_cmd at ffffffffc0a35347 [ice]
   #5 [ff72159bcd6177a8] ice_sq_send_cmd_retry at ffffffffc0a35b47 [ice]
   #6 [ff72159bcd617810] ice_aq_send_cmd at ffffffffc0a38018 [ice]
   #7 [ff72159bcd617848] ice_aq_read_nvm at ffffffffc0a40254 [ice]
   #8 [ff72159bcd6178b8] ice_read_flat_nvm at ffffffffc0a4034c [ice]
   #9 [ff72159bcd617918] ice_devlink_nvm_snapshot at ffffffffc0a6ffa5 [ice]

 dmesg:
  ice 0000:13:00.0: firmware recommends not updating fw.mgmt, as it
    may result in a downgrade. continuing anyways
  ice 0000:13:00.1: ice_init_nvm failed -5
  ice 0000:13:00.1: Rebuild failed, unload and reload driver

Fixes: 12bb018c538c ("ice: Refactor VF reset")
Signed-off-by: Petr Oros <poros@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 772f6b07340d..b1f46707dcc0 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -804,7 +804,12 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 			ice_vf_ctrl_invalidate_vsi(vf);
 
 		ice_vf_pre_vsi_rebuild(vf);
-		ice_vf_rebuild_vsi(vf);
+		if (ice_vf_rebuild_vsi(vf)) {
+			dev_err(dev, "VF %u VSI rebuild failed, leaving VF disabled\n",
+				vf->vf_id);
+			mutex_unlock(&vf->cfg_lock);
+			continue;
+		}
 		ice_vf_post_vsi_rebuild(vf);
 
 		ice_eswitch_attach_vf(pf, vf);

-- 
2.54.0.rc2.531.gaf818d63126a


