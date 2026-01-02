Return-Path: <netdev+bounces-246556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56486CEE278
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 11:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5660C3007CB2
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304182D9792;
	Fri,  2 Jan 2026 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Gn52lJeU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835E215F7D;
	Fri,  2 Jan 2026 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767349174; cv=none; b=qkdPwHohHXMBnP0TmpOq/BXebrSB3WpjHIzCNf+f13JlxPORN2eK2R2KrFdYYMYtKKZZrbPr1mveF6mrH4VJQg9npxk9jpWWG4S04gMRThWcPIOB/1N1DAY66lrwQkmraOa43QIRk84vG4Ff6oCrTPuLFrImSlHTQjBDDLhr+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767349174; c=relaxed/simple;
	bh=ajTWQQ+q5aAsOe+jXvHdnyff4T9nCaiiQ2anKx0DmFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k7v0WUeL+ROfIR2metmU1kwFZUCxpt7G3DsSsN/4ZwKg7bdAdEr2WvvL4pCR+L9ndbwqx3PRcgIJ/vdFaPXo+F5gi7GM8wPRaSCXmD6llGDdMvC6f/IxoCQiqgt2pBmJY2YFYjH39IMgt3c+G+u5hI+1Q0ESmLu46K8ROsYRABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Gn52lJeU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6025sCeK4036863;
	Fri, 2 Jan 2026 02:19:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=5B3HZ7MSyvayqUbr22rW0pc
	9f+R2/53Dpzl0nElB6T4=; b=Gn52lJeU1wpQwZBWz2mlI6UShLjNwet1MvA/lb6
	yrOyKYKetAMGmGyHvq5/QfOAZkgIaHRRyzFDH8LiRTdgElgclVgCW1mIqoIoNoBm
	lJPyzieDN06Af6G1QS2uwfbqpH3DfgFtxNBDx7s3/zv78ibvJJEy80znP5+ZM7i2
	Hye+9Tv616bEalFqM23YwOmmenhROgxNos5YMBh9OLhtISTLfXSCxy97//pZThd9
	zPM4kiWqkif3Dhm0TT4SNL5HbJXlSVBg/yJv6hdP54ddXQ26LFxReLAmviw4WSMh
	RlkIUpD0zaTc2zO5yZip0r7TZNz9MSw15HOO3lYyYKA/tTA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4be89ag9hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 02:19:06 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 2 Jan 2026 02:19:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 2 Jan 2026 02:19:19 -0800
Received: from 5810.marvell.com (unknown [10.29.45.105])
	by maili.marvell.com (Postfix) with ESMTP id 6A62B3F7059;
	Fri,  2 Jan 2026 02:19:01 -0800 (PST)
From: Kommula Shiva Shankar <kshankar@marvell.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <jerinj@marvell.com>, <ndabilpuram@marvell.com>, <schalla@marvell.com>
Subject: [PATCH net] virtio_net: fix device mismatch in devm_kzalloc/devm_kfree
Date: Fri, 2 Jan 2026 15:49:00 +0530
Message-ID: <20260102101900.692770-1-kshankar@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: LHT1r8lqNWcei800b7K696E1KRi8T7Hp
X-Proofpoint-ORIG-GUID: LHT1r8lqNWcei800b7K696E1KRi8T7Hp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDA4OSBTYWx0ZWRfX11k+mHdgBJl6
 v/lOWsVBmSDI0y74vNuCCaloBCVQFsIHWAYBh7gn3pIlSydNYuyBri+Mc3HxzbSCUKD4RXHE4bB
 aZDl8Uq+q6CbDn+P+gzyHVg9s/mFzyh+5eILthsXgSjkt5sWEdwufyQ0+mrQYj8aGtV0m5XO7QV
 Wp4YLcQET6OrOknC1hOuV5IRafBJteaIFT+ogW1dP1meRcUyUqUmuvpQYVOvY8BwMOnQZGYvqZt
 QQcoe6JIxyKYnwvn1YHajL9ONYHyYDTl/BnCAaoihB1tTqihOg+SbZB9yn3HsiZnpvRVzFjR2x7
 iO017tvhMTYctmnBP6tp9Cl7d/r8pXYqoFbbIckso+2rp5ygflGEC+2OgBiNhouZ18rjdlA5jAn
 /MPzP96PQvcEr5OLxw+B6AxBl0j4L7cF2fEPRDkRy5K0AfLipHaMKsH27inQCPV75IF2sjCpPRh
 wWPrMQYT1HQY2sfuDcw==
X-Authority-Analysis: v=2.4 cv=ZbcQ98VA c=1 sm=1 tr=0 ts=69579b9a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=AcOwvBPJr7tEbDvczk0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01

Initial rss_hdr allocation uses virtio_device->device,
but virtnet_set_queues() frees using net_device->device.
This device mismatch causing below devres warning

[ 3788.514041] ------------[ cut here ]------------
[ 3788.514044] WARNING: drivers/base/devres.c:1095 at devm_kfree+0x84/0x98, CPU#16: vdpa/1463
[ 3788.514054] Modules linked in: octep_vdpa virtio_net virtio_vdpa [last unloaded: virtio_vdpa]
[ 3788.514064] CPU: 16 UID: 0 PID: 1463 Comm: vdpa Tainted: G        W           6.18.0 #10 PREEMPT
[ 3788.514067] Tainted: [W]=WARN
[ 3788.514069] Hardware name: Marvell CN106XX board (DT)
[ 3788.514071] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[ 3788.514074] pc : devm_kfree+0x84/0x98
[ 3788.514076] lr : devm_kfree+0x54/0x98
[ 3788.514079] sp : ffff800084e2f220
[ 3788.514080] x29: ffff800084e2f220 x28: ffff0003b2366000 x27: 000000000000003f
[ 3788.514085] x26: 000000000000003f x25: ffff000106f17c10 x24: 0000000000000080
[ 3788.514089] x23: ffff00045bb8ab08 x22: ffff00045bb8a000 x21: 0000000000000018
[ 3788.514093] x20: ffff0004355c3080 x19: ffff00045bb8aa00 x18: 0000000000080000
[ 3788.514098] x17: 0000000000000040 x16: 000000000000001f x15: 000000000007ffff
[ 3788.514102] x14: 0000000000000488 x13: 0000000000000005 x12: 00000000000fffff
[ 3788.514106] x11: ffffffffffffffff x10: 0000000000000005 x9 : ffff800080c8c05c
[ 3788.514110] x8 : ffff800084e2eeb8 x7 : 0000000000000000 x6 : 000000000000003f
[ 3788.514115] x5 : ffff8000831bafe0 x4 : ffff800080c8b010 x3 : ffff0004355c3080
[ 3788.514119] x2 : ffff0004355c3080 x1 : 0000000000000000 x0 : 0000000000000000
[ 3788.514123] Call trace:
[ 3788.514125]  devm_kfree+0x84/0x98 (P)
[ 3788.514129]  virtnet_set_queues+0x134/0x2e8 [virtio_net]
[ 3788.514135]  virtnet_probe+0x9c0/0xe00 [virtio_net]
[ 3788.514139]  virtio_dev_probe+0x1e0/0x338
[ 3788.514144]  really_probe+0xc8/0x3a0
[ 3788.514149]  __driver_probe_device+0x84/0x170
[ 3788.514152]  driver_probe_device+0x44/0x120
[ 3788.514155]  __device_attach_driver+0xc4/0x168
[ 3788.514158]  bus_for_each_drv+0x8c/0xf0
[ 3788.514161]  __device_attach+0xa4/0x1c0
[ 3788.514164]  device_initial_probe+0x1c/0x30
[ 3788.514168]  bus_probe_device+0xb4/0xc0
[ 3788.514170]  device_add+0x614/0x828
[ 3788.514173]  register_virtio_device+0x214/0x258
[ 3788.514175]  virtio_vdpa_probe+0xa0/0x110 [virtio_vdpa]
[ 3788.514179]  vdpa_dev_probe+0xa8/0xd8
[ 3788.514183]  really_probe+0xc8/0x3a0
[ 3788.514186]  __driver_probe_device+0x84/0x170
[ 3788.514189]  driver_probe_device+0x44/0x120
[ 3788.514192]  __device_attach_driver+0xc4/0x168
[ 3788.514195]  bus_for_each_drv+0x8c/0xf0
[ 3788.514197]  __device_attach+0xa4/0x1c0
[ 3788.514200]  device_initial_probe+0x1c/0x30
[ 3788.514203]  bus_probe_device+0xb4/0xc0
[ 3788.514206]  device_add+0x614/0x828
[ 3788.514209]  _vdpa_register_device+0x58/0x88
[ 3788.514211]  octep_vdpa_dev_add+0x104/0x228 [octep_vdpa]
[ 3788.514215]  vdpa_nl_cmd_dev_add_set_doit+0x2d0/0x3c0
[ 3788.514218]  genl_family_rcv_msg_doit+0xe4/0x158
[ 3788.514222]  genl_rcv_msg+0x218/0x298
[ 3788.514225]  netlink_rcv_skb+0x64/0x138
[ 3788.514229]  genl_rcv+0x40/0x60
[ 3788.514233]  netlink_unicast+0x32c/0x3b0
[ 3788.514237]  netlink_sendmsg+0x170/0x3b8
[ 3788.514241]  __sys_sendto+0x12c/0x1c0
[ 3788.514246]  __arm64_sys_sendto+0x30/0x48
[ 3788.514249]  invoke_syscall.constprop.0+0x58/0xf8
[ 3788.514255]  do_el0_svc+0x48/0xd0
[ 3788.514259]  el0_svc+0x48/0x210
[ 3788.514264]  el0t_64_sync_handler+0xa0/0xe8
[ 3788.514268]  el0t_64_sync+0x198/0x1a0
[ 3788.514271] ---[ end trace 0000000000000000 ]---

Fix by using virtio_device->device consistently for
allocation and deallocation

Fixes: 4944be2f5ad8c ("virtio_net: Allocate rss_hdr with devres")
Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
---
 drivers/net/virtio_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..22d894101c01 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3791,7 +3791,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
 		old_rss_hdr = vi->rss_hdr;
 		old_rss_trailer = vi->rss_trailer;
-		vi->rss_hdr = devm_kzalloc(&dev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
+		vi->rss_hdr = devm_kzalloc(&vi->vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
 		if (!vi->rss_hdr) {
 			vi->rss_hdr = old_rss_hdr;
 			return -ENOMEM;
@@ -3802,7 +3802,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 
 		if (!virtnet_commit_rss_command(vi)) {
 			/* restore ctrl_rss if commit_rss_command failed */
-			devm_kfree(&dev->dev, vi->rss_hdr);
+			devm_kfree(&vi->vdev->dev, vi->rss_hdr);
 			vi->rss_hdr = old_rss_hdr;
 			vi->rss_trailer = old_rss_trailer;
 
@@ -3810,7 +3810,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 				 queue_pairs);
 			return -EINVAL;
 		}
-		devm_kfree(&dev->dev, old_rss_hdr);
+		devm_kfree(&vi->vdev->dev, old_rss_hdr);
 		goto succ;
 	}
 
-- 
2.48.1


