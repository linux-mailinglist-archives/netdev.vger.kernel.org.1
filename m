Return-Path: <netdev+bounces-29057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBD3781841
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8A5281B7B
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E901C15;
	Sat, 19 Aug 2023 08:11:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27224ED0
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 08:11:09 +0000 (UTC)
Received: from sonic309-20.consmr.mail.gq1.yahoo.com (sonic309-20.consmr.mail.gq1.yahoo.com [98.137.65.146])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94C619F
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1692432663; bh=yZlxb67YxQ05+BNzviKsC0qXM3c0kTm174EVaqNUEZg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VKAAhKpulkouLhZw744eXwSXec+lnLkU238lhZGIIzwuuiZJo/mkRCBp3q42tIyQdshVLHqeff9GvrppsRqCWKIApM70vFGIHrcW+619QxFQDQmXs8EEEmTR7OMfgdFzb0E4kY7NxZ1eiNUSHJVyubZelp6FRoRM3xUdXQQ1ZRxMeo9LG25/rGw/Ft7MGh60taVdsykD+BsBnDM5jPShoQA+zy8FmI5xbg5LPm+K7k3TJCNLLVuEr6wj//Omv3YrnbnTtC5PEGQmVsjOW1AXr57+dNioom3x40eoaznhLfQcy3jZ+D8SfaESO4YI/a9Z/05btkb/QHnZvH/KAGd4gQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1692432663; bh=4RcbK+DuNlnZ1XkIjxJ9vyJiOMsXWBJ1/U2POT/0ZLx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JjCyNm7F4iX0oBRfFKD9RqijckpCh4e6SH1foAM++hPzx41jV+yhWkAbXIhKOPIzWQRLhAEgXJSEJBuCx2oemuvGednQLQ01EamnMSRrEcf1kA7hhf+cXeJHvxQhllkbwA+M4COjJksKV+qRJ/QV9wu46rDrFnayy3W4YqIaNBdL1lBrEAniEsLwRRuO9e7+tnAHROtGTCCRtI6EzQQJt64Fo+wQRK2/EtsRRfE+2VRF25BayZauKHax75mpI7+HP4k1zon8UiB7FclUd7p3g61qtm0tW58vE3UtRhbkrCRo8nK5Y1VdfjYbhTs/kRpScZs8qLJPCiC4HnmBHkMIaA==
X-YMail-OSG: hXoHxZcVM1nxLdP9NN_iXTc2CvyCmjRg3H0uZ1kDTq9M9AywWLE97yUv.LE4Nbr
 GPqSkIwHU.Tm_8tz..dzPceNTxkdcJhkAZDzi6H6TdltmIXDKw8VpSB1YlvHgDl8AwWNyv1GLtJK
 wLJoalxLB2VE0HVMKk9erTgpmJE5Qz..NoK9Fp3Ay0U5N3ZXXcYM5KGo7ajQw7kb3IcuZFbjNKPk
 MWzbsRNsye8ii.GssJroaBJxHkdlOzc1n_s9D0HcXtZYowcRgZubh5EUXTDDkkIgkFmjHz.UMpMY
 XWx3O3Gvgm_USqZTkZW5yNR8m5026h3sp.tctEfnsBx_YGGoMUYPeXa2DTADBBG.00Z_tKirPQqh
 b0QjLEas8uR5mntaCQyku5RPDxUIGU.oxU2.7l6_g1nZv3Os9Yk.45VOYdgKpOI1Ggout4CbcXqE
 l3DWDPgaLncPitGlw5xf1CcNCCSOepeFHONx14hg4m1B4FXfZji180TRR_Sagc0lfi7gkbcAlD7j
 lbtn6DHiuqFUREVY2hKtXtbcYvfzbeg_lfjbGrBUphjJI4eQXZzppkVw1vy6kYB1xfu.mVy__Rm_
 68aP_YiT3wf9wLJzD9vh3rthgu3o82Fe9mfiiuLqEXMNCvCVRMTSmrBhxOOndANN_eIajhOPfGYV
 DEESlkFrAyJrEqF3AQqQa5lHHWJ4tVhxS_Z9sSF0Qo1suAI5xLkiIKj3ykPAgwXt69UXe9Dh6_IK
 Hkm3u7z9NEAPokTnMC4q2ldIvB51idwAfD8XPFQ4QciGJQqELOiTH4CEcDdlCvoRRCEkHSUcZaID
 cFJt0Uq8Y5DWs.8_Zo2yajrw6FzUFyNT7dPcx0hNkznZz1d30ATJIkSg894f7l5O4qvnCPxdFT0j
 OvxwqsqiBO2oEmkI39lYfpsIx0UWu_GPv.sir_MYjO86j5Fw8Hol5JQI.dOYKaCK9ErO61NdmbJ7
 ymthxKA1VSCbxCVVXDcNrchP.zcLu7D0tFJ3XnPRXEeIOOneiupRgQAyducwJsOqfXIzymI23awT
 TFLvTid0.2RhYzXxfan2j7aV0h_bEHLFp_7LwS4zLjz8.MkZcS7glet09c.VGF_5XKzlWifk5DoZ
 Se96q7kzVjxTdd_CFwGg9P3voanEGvH_kvh_qRjbj0_LRSbwbSS3gSMefWgRYnSVAGPWgOcSXYck
 mJ2T7SeRFSZ2k9t7C.sXxG8bdWpGy23IM8DtPIBv2HrnoC20alJHdyfb764E5ql2QKlYvFJ2Vo4L
 f0euti.IomUJ9O0du1KaAKwdVl4f2cdjHw50zhxbZZTDrLxJTf72Z6iKNA6RUUJYH2znJHBF1567
 VEdRmEwhP_Va_OKjtlTNsOcDtFK7cUeoVCGElqy7UF8CcFUVUtFv3NJ_qGNvFJzI8J7W9OrBOh13
 hMcjao7TZilD2wmn8G1iJO3cYwGTJmno3acZXKSn6WlFi1i.MxgImIBbjWQ0IseTlwwWxZf5J9_w
 CNIQ_oix5IJpTo0XLUwX0vhFAsvpVPA3i8861oafthzyMR0tVmHvzWr8BnWTIyE1NNKfr2AZ7UGU
 TDnwBGhfjzd.CP5_6_SoFAZTmSq8P17t1Qa6GU1RKhKODT7z8pcF41sNy54KiHQdihhLKg.cdFgF
 8Kjtk0JC0g6YsdvGbF9zlqPimKlifgcp_ph5LBCqRpNTJh147FFgmZzRSuU2Xzlpypjtp2zk8QuC
 1.l93_LkaAphNYnRPo86reKBIbs5ESmOIFJH7S_oS.P4FDkaGfMp9_FsPxbj1tgGm3EXBEBhb9AE
 GjdWp1Swyf2jYrfhtbLfHSuAMNnJ_HWfQfwYJoHKc5CVaGg_nEJnQFznsNexXi8FO4Gw8lTkcxBl
 7sxHUVtoCvX4tD657tepBH8IGg5bQRJY_bVVNCQakIKMOmArSOkt3igwl2G4XcL.WdcPXR.ex9ta
 zZ8CvN2TNpEmxAaYAXfwvaX8GNjmUMO.k9V4seutDkICYR7QIsdm.rbGCMjbUew9UiOfQPwm7R10
 OnYsa.ZLzZ8LMc74u3D5ECzaQM19YSXmwVXfmVpHgejHS.kDiWaN7GnnQ5PmsSL0YSUSfZnLylBK
 sehQmF8oH6ystVjUiFt4fXiWHTsrxUkImIh_8iEFZ8dtzFhZoV5e3YmLB5B.j6l_oWmk2lad.bwR
 NA_XfQO.laFV6jg_D.tP9WPQomuTtSkGv96z4JYBBwjnqONhALIgjuKNSTx1xS1vRNwTiDZNvNzO
 tz1RVAbw6XEF3SJ6LI8dmIw4wBrM4XmrfDJ1_Htg-
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: aae89fdf-f5b6-4f6e-8180-58cc6d04aeae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sat, 19 Aug 2023 08:11:03 +0000
Received: by hermes--production-gq1-6b7c87dcf5-rj56s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 86923299112c9f4d4ee777d306e9d8ee;
          Sat, 19 Aug 2023 08:11:01 +0000 (UTC)
From: Ziqi Zhao <astrajoan@yahoo.com>
To: arnd@arndb.de,
	bridge@lists.linux-foundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	ivan.orlov0322@gmail.com,
	keescook@chromium.org,
	kuba@kernel.org,
	hkallweit1@gmail.com,
	mudongliangabcd@gmail.com,
	nikolay@nvidia.com,
	pabeni@redhat.com,
	razor@blackwall.org,
	roopa@nvidia.com,
	skhan@linuxfoundation.org,
	syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
	vladimir.oltean@nxp.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Ziqi Zhao <astrajoan@yahoo.com>
Subject: [PATCH] net: bridge: Fix refcnt issues in dev_ioctl
Date: Sat, 19 Aug 2023 01:10:57 -0700
Message-Id: <20230819081057.330728-1-astrajoan@yahoo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000051197705fdbc7e54@google.com>
References: <00000000000051197705fdbc7e54@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the bug reported by Syzbot, certain bridge devices would have a
leaked reference created by race conditions in dev_ioctl, specifically,
under SIOCBRADDIF or SIOCBRDELIF operations. The reference leak would
be shown in the periodic unregister_netdevice call, which throws a
warning and cause Syzbot to report a crash. Upon inspection of the
logic in dev_ioctl, it seems the reference was introduced to ensure
proper access to the bridge device after rtnl_unlock. and the latter
function is necessary to maintain the following lock order in any
bridge related ioctl calls:

1) br_ioctl_mutex => 2) rtnl_lock

Conceptually, though, br_ioctl_mutex could be considered more specific
than rtnl_lock given their usages, hence swapping their order would be
a reasonable proposal. This patch changes all related call sites to
maintain the reversed order of the two locks:

1) rtnl_lock => 2) br_ioctl_mutex

By doing so, the extra reference introduced in dev_ioctl is no longer
needed, and hence the reference leak bug is now resolved.

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Fixes: ad2f99aedf8f ("net: bridge: move bridge ioctls out of .ndo_do_ioctl")
Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
---
 net/bridge/br_ioctl.c | 4 ----
 net/core/dev_ioctl.c  | 8 +-------
 net/socket.c          | 2 ++
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index f213ed108361..291dbc5d2a99 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -399,8 +399,6 @@ int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
 {
 	int ret = -EOPNOTSUPP;
 
-	rtnl_lock();
-
 	switch (cmd) {
 	case SIOCGIFBR:
 	case SIOCSIFBR:
@@ -434,7 +432,5 @@ int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
 		break;
 	}
 
-	rtnl_unlock();
-
 	return ret;
 }
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 3730945ee294..17df956df8cb 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -336,7 +336,6 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 	int err;
 	struct net_device *dev = __dev_get_by_name(net, ifr->ifr_name);
 	const struct net_device_ops *ops;
-	netdevice_tracker dev_tracker;
 
 	if (!dev)
 		return -ENODEV;
@@ -405,12 +404,7 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 			return -ENODEV;
 		if (!netif_is_bridge_master(dev))
 			return -EOPNOTSUPP;
-		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
-		rtnl_unlock();
-		err = br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL);
-		netdev_put(dev, &dev_tracker);
-		rtnl_lock();
-		return err;
+		return br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL);
 
 	case SIOCDEVPRIVATE ... SIOCDEVPRIVATE + 15:
 		return dev_siocdevprivate(dev, ifr, data, cmd);
diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..6b7a9df9a326 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1258,7 +1258,9 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		case SIOCSIFBR:
 		case SIOCBRADDBR:
 		case SIOCBRDELBR:
+			rtnl_lock();
 			err = br_ioctl_call(net, NULL, cmd, NULL, argp);
+			rtnl_unlock();
 			break;
 		case SIOCGIFVLAN:
 		case SIOCSIFVLAN:
-- 
2.34.1


