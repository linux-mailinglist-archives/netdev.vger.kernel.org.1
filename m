Return-Path: <netdev+bounces-227534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5C3BB221A
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 02:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5795319C365B
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 00:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352C71DB34C;
	Thu,  2 Oct 2025 00:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxDMVcXm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841E19644B;
	Thu,  2 Oct 2025 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364239; cv=none; b=avCTbiZLN+VDeShsiKrzkfBu38aT8+XZGwTR8KMIut8d9/R1A4g2l6IKlv3vjEjO/ido3NWC3BdmC85by4PJbYWwVyKD4V0Td1s8emNVju+B0Pn5BKOslZBIWH3WRcqrPzrYxxEPNTXl+MYxsgrQj9kWWU1+Y6c2SJlyYIT9tQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364239; c=relaxed/simple;
	bh=2JhPnI8+IM65d83TQ7q4iLukhBoa+KxAgEa1700xAQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vuy0VxZMNxv1dxGCxZQ7QSn0XlzR276uCpe/14uDfZD4h0+q64v7GuuqUADkPwVBXti1IsvIYVlHH3W4Hl/zRfYbvswbT7Nk+MbxtfDhmfNVx+mOtpj//7opHhI2pyzH6kvHvqTk3fwCZnUFao1uZfGNcjK/Sfa4qYwiiYuRFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxDMVcXm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759364237; x=1790900237;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2JhPnI8+IM65d83TQ7q4iLukhBoa+KxAgEa1700xAQU=;
  b=HxDMVcXmY2UKXs8nss37pyDp4NaU2HEea7HhMQ8aZBMACWDsOpcsKYXa
   JRSOE38se5E0cYUpZh0tkyAi9Zy35jL4u2weERBR4HzLpuDSlwFTIrohY
   cMVzVH02ySoWQ2IEkV2/IZldevV/qpnnJo954VV0kot8BGm1kd5eLqyIq
   etwWl0sWSqee5F55mcPGdp0i+Lp5jTUeMzKRFAUjmKmDkOTABQRLSvdF1
   2IrtU6jhpXfgYB+IM8XTmkjKFe2rcAvYtk6wihNQRIAbuIF89zRos/JVc
   +4p448PzLdsNMceOu2bsCtbarxHvLZdmdIY/247fBB4JPsQudYItjPvQd
   g==;
X-CSE-ConnectionGUID: IKabezU/SlST0dokG5Ekag==
X-CSE-MsgGUID: 81aRdEPkTW+LvR6tLgom5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61561629"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="61561629"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:11 -0700
X-CSE-ConnectionGUID: p0EquOS+QH2za9TtScfVvA==
X-CSE-MsgGUID: 5mdtHNk7RhC9y85/v4u1yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="184105734"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 01 Oct 2025 17:14:18 -0700
Subject: [PATCH net 8/8] ixgbe: fix too early devlink_free() in
 ixgbe_remove()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-jk-iwl-net-2025-10-01-v1-8-49fa99e86600@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
In-Reply-To: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Phani Burra <phani.r.burra@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Anton Nadezhdin <anton.nadezhdin@intel.com>, 
 Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Koichiro Den <den@valinux.co.jp>, Rinitha S <sx.rinitha@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2539;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=aSMnYiD0CCq3nJNv4SE/LMIAQM/f6FoQSAZXNloPTO8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoy7R1qrTfSdjKq1i38FP7y73WavZ1zR4f8JzK9qKxTfm
 D9Vf/a4o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgInMeMLIML3b7cSXTSvcHj4o
 nizm33f+/IY/i4oXMJ2Oibyy6MHx61wM//T2XpXSFFa/ssX0UPm600WJ+y+78CivKby9yWXil68
 bVBgB
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Koichiro Den <den@valinux.co.jp>

Since ixgbe_adapter is embedded in devlink, calling devlink_free()
prematurely in the ixgbe_remove() path can lead to UAF. Move devlink_free()
to the end.

KASAN report:

 BUG: KASAN: use-after-free in ixgbe_reset_interrupt_capability+0x140/0x180 [ixgbe]
 Read of size 8 at addr ffff0000adf813e0 by task bash/2095
 CPU: 1 UID: 0 PID: 2095 Comm: bash Tainted: G S  6.17.0-rc2-tnguy.net-queue+ #1 PREEMPT(full)
 [...]
 Call trace:
  show_stack+0x30/0x90 (C)
  dump_stack_lvl+0x9c/0xd0
  print_address_description.constprop.0+0x90/0x310
  print_report+0x104/0x1f0
  kasan_report+0x88/0x180
  __asan_report_load8_noabort+0x20/0x30
  ixgbe_reset_interrupt_capability+0x140/0x180 [ixgbe]
  ixgbe_clear_interrupt_scheme+0xf8/0x130 [ixgbe]
  ixgbe_remove+0x2d0/0x8c0 [ixgbe]
  pci_device_remove+0xa0/0x220
  device_remove+0xb8/0x170
  device_release_driver_internal+0x318/0x490
  device_driver_detach+0x40/0x68
  unbind_store+0xec/0x118
  drv_attr_store+0x64/0xb8
  sysfs_kf_write+0xcc/0x138
  kernfs_fop_write_iter+0x294/0x440
  new_sync_write+0x1fc/0x588
  vfs_write+0x480/0x6a0
  ksys_write+0xf0/0x1e0
  __arm64_sys_write+0x70/0xc0
  invoke_syscall.constprop.0+0xcc/0x280
  el0_svc_common.constprop.0+0xa8/0x248
  do_el0_svc+0x44/0x68
  el0_svc+0x54/0x160
  el0t_64_sync_handler+0xa0/0xe8
  el0t_64_sync+0x1b0/0x1b8

Fixes: a0285236ab93 ("ixgbe: add initial devlink support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6218bdb7f941..86b9caece104 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -12091,7 +12091,6 @@ static void ixgbe_remove(struct pci_dev *pdev)
 
 	devl_port_unregister(&adapter->devlink_port);
 	devl_unlock(adapter->devlink);
-	devlink_free(adapter->devlink);
 
 	ixgbe_stop_ipsec_offload(adapter);
 	ixgbe_clear_interrupt_scheme(adapter);
@@ -12127,6 +12126,8 @@ static void ixgbe_remove(struct pci_dev *pdev)
 
 	if (disable_dev)
 		pci_disable_device(pdev);
+
+	devlink_free(adapter->devlink);
 }
 
 /**

-- 
2.51.0.rc1.197.g6d975e95c9d7


