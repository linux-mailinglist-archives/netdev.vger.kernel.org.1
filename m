Return-Path: <netdev+bounces-240532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34264C75DEB
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 19:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 18BE62B46E
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D60F33B6F6;
	Thu, 20 Nov 2025 18:13:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0833E341
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662382; cv=none; b=AJyrL2ZavKOMqxb/AF5wouxn6PoJKkxQ5glDs57n5WaVc0Y8b80EcY60LYePnK57434a0zBGBgz6TFuNycvKsSkFxlj4xPtoCvHmdg3+fpHNIrQ6hemwgRoRutz4XjdPWH3yeWcxXHBooti95aOa/mcU87Ph63U7onzEV4YwzD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662382; c=relaxed/simple;
	bh=HwAR7G7Z1KkjbTw8M/YrSYnmjyOzDOeh4R3srcn20tc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSw9itz3iiTHWGPuzpmXKGkMnwYN/Aa5rhx+j331/e33R56j6xWQSl5OjBPe6QXgcj1u7HmC5NGFZN/ApNuHiSDB1VxBXDs1ZJiBYV7292ovxYn6/x7PkwW3p2bvZ/B69/uugLwCUnOeuRRUyu5GI5yEzWTDM6PFBmzn4jDGrvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5zV055mzHnGf4;
	Fri, 21 Nov 2025 02:12:22 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 339661402EF;
	Fri, 21 Nov 2025 02:12:57 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 21:12:56 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH net-next 2/3] Provide man section for IPVLAN and IPVTAP Type Support
Date: Thu, 20 Nov 2025 21:12:47 +0300
Message-ID: <20251120181248.3834304-3-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251120181248.3834304-1-skorodumov.dmitry@huawei.com>
References: <20251120181248.3834304-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)

A small section about ipvlan/ipvtap link types.
Most of the phrases are taken from Documentation/networking/ipvlan.rst

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 man/man8/ip-link.8.in | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index ef45fe08..def83184 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1652,6 +1652,62 @@ a multicast address will be queued as broadcast if the number of devices
 using it is greater than the given value.
 .in -8
 
+.TP
+IPVLAN and IPVTAP Type Support
+For a link of type
+.I IPVLAN
+or
+.I IPVTAP
+the following additional arguments are supported:
+
+.BI "ip link add link " MASTER " name " SLAVE
+.BR type " { " ipvlan " | " ipvtap " } "
+.RB " [ " mode " { " l3 " | " l3s " | " l2 " } ] "
+.RB " [ { " bridge " | " private " | " vepa " } ] "
+
+.in +8
+.sp
+.BR type " { " ipvlan " | " ipvtap " } "
+- specifies the link type to use.
+.BR ipvlan " creates just a virtual interface, while "
+.BR ipvtap " in addition creates a character device "
+.BR /dev/tapX " to be used just like a " tuntap " device."
+
+.B mode l3
+- Default mode. Layer 3 mode: Packets are routed by the host network stack. Slaves do
+not receive multicast or broadcast traffic. Provides stronger isolation
+between slaves.
+
+.B mode l3s
+- Very similar to the
+.BR l3
+mode except that iptables (conn-tracking) works in this mode
+and hence it is L3-symmetric (L3s).
+
+.B mode l2
+- In this mode TX processing happens on the stack instance attached to the
+slave device and packets are switched and queued to the master device to send
+out. In this mode the slaves will RX/TX multicast and broadcast (if applicable)
+as well.
+
+.B bridge
+- Default option. All endpoints are directly connected to each other,
+communication is not redirected through the physical interface's peer.
+
+.B private
+- Do not allow communication between
+instances on the same physical interface, even if the external switch supports
+hairpin mode.
+
+.B vepa
+- Virtual Ethernet Port Aggregator option. Data from one
+instance to the other on the same physical interface is transmitted over the
+physical interface. Either the attached switch needs to support hairpin mode,
+or there must be a TCP/IP router forwarding the packets in order to allow
+communication.
+
+.in -8
+
 .TP
 High-availability Seamless Redundancy (HSR) Support
 For a link of type
-- 
2.25.1


