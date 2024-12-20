Return-Path: <netdev+bounces-153593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E079F8C55
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72B51889B73
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C974059;
	Fri, 20 Dec 2024 06:05:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EBC3BBC5;
	Fri, 20 Dec 2024 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674739; cv=none; b=dBkMWelaYmVm5eed+pAN9n9dX+TceW3CVK3I5cnlKMuKCWolLRwVHw/Uc+SW6q7le8sTRHdOFwE10sdtSmXf6Q9LW29N/vGuRCXZMCynT2zSJx4c5tLk+XUCUv/ND9SaCPsuwC1z9JsAnssHS5jTeEPH7o6alvrdP0TIvC+DmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674739; c=relaxed/simple;
	bh=xBdleAwdTVw76DYoTJBXmnZ53VZ1aTdYMwWZiAcUVqs=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=TwQf6722uk/ZyI1X2QhqJHVUDYb4V6J8RnieHGZipC2thLHdhrzRESirlfSX0oXYecFyW9ybWFftklR9CTN9QgqLCdo74VM7XnmY+YQ4yUjjEIWWP2bUhqeT1rj+hCclqypKluqh7U0G/4GINTNW2K/vlMp1IOBpgdVrK/dD8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4YDxjM5Smfz5B1KS;
	Fri, 20 Dec 2024 14:05:27 +0800 (CST)
Received: from njb2app06.zte.com.cn ([10.55.23.119])
	by mse-fl1.zte.com.cn with SMTP id 4BK65EmX024649;
	Fri, 20 Dec 2024 14:05:14 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njb2app05[null])
	by mapi (Zmail) with MAPI id mid204;
	Fri, 20 Dec 2024 14:05:16 +0800 (CST)
Date: Fri, 20 Dec 2024 14:05:16 +0800 (CST)
X-Zmail-TransId: 2afd6765091c639-989bb
X-Mailer: Zmail v1.0
Message-ID: <20241220140516563WDQ_X40bt0ZOch3Qte1YO@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: <hehe.peilin@zte.com.cn>, <xu.xin16@zte.com.cn>, <fan.yu9@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <ye.xingchen@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4IG5leHRdIG5ldDpkc2E6Zml4IHRoZSBkc2FfcHRyIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 4BK65EmX024649
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67650927.000/4YDxjM5Smfz5B1KS

From: Peilin He<he.peilin@zte.com.cn>

Issue
=====
Repeatedly accessing the DSA Ethernet controller via the ethtool command,
followed by a system reboot, may trigger a DSA null pointer dereference,
causing a kernel panic and preventing the system from rebooting properly.
This can lead to data loss or denial-of-service, resulting in serious 
consequences.

The original problem occurred in the Linux kernel version 5.4.19.
The following is the panic log:

[  172.523467] Unable to handle kernel NULL pointer dereference at virtual 
address 0000000000000020
[  172.532455] Mem abort info:
[  172.535313] printk: console [ttyS0]: printing thread stopped
[  172.536352]   ESR = 0x0000000096000006
[  172.544926]   EC = 0x25: DABT (current EL), IL = 32 bits
[  172.550321]   SET = 0, FnV = 0
[  172.553427]   EA = 0, S1PTW = 0
[  172.556646]   FSC = 0x06: level 2 translation fault
[  172.561604] Data abort info:
[  172.564563]   ISV = 0, ISS = 0x00000006
[  172.568466]   CM = 0, WnR = 0
[  172.571502] user pgtable: 4k pages, 48-bit VAs, pgdp=00000020a4b34000
[  172.578058] [0000000000000020] pgd=08000020a4ce6003, p4d=08000020a4ce6003, 
pud=08000020a4b4d003, pmd=0000000000000000
[  172.588785] Internal error: Oops: 96000006 [#1] PREEMPT_RT SMP
[  172.594641] Modules linked in: r8168(O) bcmdhd(O) ossmod(O) tipc(O)
[  172.600933] CPU: 1 PID: 548 Comm: lldpd Tainted: G           O      
[  172.610795] Hardware name: LS1028A RDB Board (DT)
[  172.615508] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  172.622492] pc : dsa_master_get_sset_count+0x24/0xa4
[  172.627475] lr : ethtool_get_drvinfo+0x8c/0x210
[  172.632020] sp : ffff80000c233a90
[  172.635338] x29: ffff80000c233a90 x28: ffff67ad21e45a00 x27: 0000000000000000
[  172.642498] x26: 0000000000000000 x25: 0000ffffd1102110 x24: 0000000000000000
[  172.649657] x23: 00020100001149a9 x22: 0000ffffd1102110 x21: 0000000000000000
[  172.656816] x20: 0000000000000000 x19: ffff67ad00bbe000 x18: 0000000000000000
[  172.663974] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffd1102110
[  172.671132] x14: ffffffffffffffff x13: 30322e344230342e x12: 33302e37564c4547
[  172.678290] x11: 0000000000000020 x10: 0101010101010101 x9 : ffffd837fcebe6fc
[  172.685448] x8 : 0101010101010101 x7 : 6374656e655f6c73 x6 : 74656e655f6c7366
[  172.692606] x5 : ffff80000c233b01 x4 : ffffd837fdae0251 x3 : 0000000000000063
[  172.699764] x2 : ffffd837fd076da0 x1 : 0000000000000000 x0 : ffff67ad00bbe000
[  172.706923] Call trace:
[  172.709371]  dsa_master_get_sset_count+0x24/0xa4
[  172.714000]  ethtool_get_drvinfo+0x8c/0x210
[  172.718193]  dev_ethtool+0x780/0x2120
[  172.721863]  dev_ioctl+0x1b0/0x580
[  172.725273]  sock_do_ioctl+0xc0/0x100
[  172.728944]  sock_ioctl+0x130/0x3c0
[  172.732440]  __arm64_sys_ioctl+0xb4/0x100
[  172.736460]  invoke_syscall+0x50/0x120
[  172.740219]  el0_svc_common.constprop.0+0x4c/0xf4
[  172.744936]  do_el0_svc+0x2c/0xa0
[  172.748257]  el0_svc+0x20/0x60
[  172.751318]  el0t_64_sync_handler+0xe8/0x114
[  172.755599]  el0t_64_sync+0x180/0x184
[  172.759271] Code: a90153f3 2a0103f4 a9025bf5 f9418015 (f94012b6)
[  172.765383] ---[ end trace 0000000000000002 ]---

Root Cause
==========
Analysis of linux-next-6.13.0-rc3 reveals that the 
dsa_conduit_get_sset_count() function accesses members of 
a structure pointed to by cpu_dp without checking 
if cpu_dp is a null pointer. This can lead to a kernel panic 
if cpu_dp is NULL.

	static int dsa_conduit_get_sset_count(struct net_device *dev, 
                                        int sset)
	{
		struct dsa_port *cpu_dp = dev->dsa_ptr;
		const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
		struct dsa_switch *ds = cpu_dp->ds;
		...
	}

dev->dsa_ptr is set to NULL in both the dsa_switch_shutdown and
dsa_conduit_teardown functions.  When the DSA module unloads,
dsa_conduit_ethtool_teardown(dev) restores the original copy of the DSA 
device's ethtool_ops using  "dev->ethtool_ops = cpu_dp->orig_ethtool_ops;"
before setting dev->dsa_ptr to NULL. This ensures that ethtool_ops
remains accessible after DSA unloading. However, dsa_switch_shutdown does 
not restore the original copy of the DSA device's ethtool_ops, potentially 
leading to a null pointer dereference of dsa_ptr and subsequently a system 
panic.

Solution
========
In the kernel's dsa_switch_shutdown function, before dp->conduit->dsa_ptr
is set to NULL, the dsa_conduit_ethtool_shutdown function is called to
restore the DSA master's ethtool_ops pointer to its original value.
This prevents the kernel from entering the DSA ethtool_ops flow even if
the user executes ethtool, thus avoiding the null pointer dereference issue
with dsa_ptr.

Signed-off-by: Peilin He<he.peilin@zte.com.cn>
Co-developed-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Kun Jiang <jiang.kun2@zte.com.cn>
Cc: Fan Yu <fan.yu9@zte.com.cn>
Cc: Yutan Qiu <qiu.yutan@zte.com.cn>
Cc: Yaxin Wang <wang.yaxin@zte.com.cn>
Cc: tuqiang <tu.qiang35@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: ye xingchen <ye.xingchen@zte.com.cn>
Cc: Yunkai Zhang <zhang.yunkai@zte.com.cn>

---
 net/dsa/dsa.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 5a7c0e565a89..5eee0c436848 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1561,6 +1561,17 @@ void dsa_unregister_switch(struct dsa_switch *ds)
 }
 EXPORT_SYMBOL_GPL(dsa_unregister_switch);

+static void dsa_conduit_ethtool_shutdown(struct net_device *dev)
+{
+	struct dsa_port *cpu_dp = dev->dsa_ptr;
+
+	if (netif_is_lag_master(dev))
+		return;
+
+	dev->ethtool_ops = cpu_dp->orig_ethtool_ops;
+	cpu_dp->orig_ethtool_ops = NULL;
+}
+
 /* If the DSA conduit chooses to unregister its net_device on .shutdown, DSA is
  * blocking that operation from completion, due to the dev_hold taken inside
  * netdev_upper_dev_link. Unlink the DSA user interfaces from being uppers of
@@ -1595,8 +1606,10 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 	/* Disconnect from further netdevice notifiers on the conduit,
 	 * since netdev_uses_dsa() will now return false.
 	 */
-	dsa_switch_for_each_cpu_port(dp, ds)
+	dsa_switch_for_each_cpu_port(dp, ds) {
+		dsa_conduit_ethtool_shutdown(dp->conduit);
 		dp->conduit->dsa_ptr = NULL;
+	}

 	rtnl_unlock();
 out:
-- 
2.25.1

