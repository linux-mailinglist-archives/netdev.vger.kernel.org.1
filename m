Return-Path: <netdev+bounces-112718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784CE93AC7A
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 08:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5981B20EA7
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 06:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A034D8A2;
	Wed, 24 Jul 2024 06:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B004AED7;
	Wed, 24 Jul 2024 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721801464; cv=none; b=IitvkZY6kyH5nH4pnmOiVA5YDLlCq/6LDiKxepjNlC3lnWEeVJzA6zN+Roc9zmTJ38pjp5JVI5w63CSLkjXFywIZQCecVM0DaFbSUp7kCajxBbA1qWDp5UBp2x8I4e4pOKa7E3AYgpC+fZK1MlzMD9wEPLPV/U3QOHS88TObhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721801464; c=relaxed/simple;
	bh=HhCRy0NtMYex6dM384FhqkxTFtMrBMW4/heteqMc5LI=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=iuotWC6AlBIK7h2W0X80fVJP/pg82aN+Iqv8dR38PCAb3F6EOh/vIgLdVOJKtT2JXlg28VECHr/j8mBtHphJsciw5xeKX2i1JiubYO17c5Z3UziuQehGo50dmYB+r51F0KxZ9GE6SLXmFGAKEl5VqNoF4jA2nEW30iIxuOKElA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4WTNl02JJJzKhn;
	Wed, 24 Jul 2024 14:04:28 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4WTNks4kVGz5psk6;
	Wed, 24 Jul 2024 14:04:21 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4WTNkf5Lbfz5B1Jc;
	Wed, 24 Jul 2024 14:04:10 +0800 (CST)
Received: from njy2app08.zte.com.cn ([10.40.13.206])
	by mse-fl2.zte.com.cn with SMTP id 46O63q1P072789;
	Wed, 24 Jul 2024 14:03:52 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njb2app07[null])
	by mapi (Zmail) with MAPI id mid204;
	Wed, 24 Jul 2024 14:03:54 +0800 (CST)
Date: Wed, 24 Jul 2024 14:03:54 +0800 (CST)
X-Zmail-TransId: 2aff66a0994a3a2-81e8e
X-Mailer: Zmail v1.0
Message-ID: <202407241403542217WOxM8U3ABv-nWZT068xe@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <dsahern@kernel.org>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: <jiang.kun2@zte.com.cn>, <fan.yu9@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <he.peilin@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBuZXQ6IFByb3ZpZGUgc3lzY3RsIHRvIHR1bmUgbG9jYWwgcG9ydCByYW5nZSB0byBJQU5BCgogc3BlY2lmaWNhdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 46O63q1P072789
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 66A0996B.000/4WTNl02JJJzKhn

From: Fan Yu <fan.yu9@zte.com.cn>

The Importance of Following IANA Standards
========================================
IANA specifies User ports as 1024-49151, and it just so happens
that my application uses port 33060 (reserved for MySQL Database Extended),
which conflicts with the Linux default dynamic port range (32768-60999)[1].

In fact, IANA assigns numbers in port range from 32768 to 49151,
which is uniformly accepted by the industry. To do this,
it is necessary for the kernel to follow the IANA specification.

Drawbacks of existing implementations
========================================
In past discussions, follow the IANA specification by modifying the
system defaults has been discouraged, which would greatly affect
existing users[2].

Theoretically, this can be done by tuning net.ipv4.local_port_range,
but there are inconveniences such as:
(1) For cloud-native scenarios, each container is expected to follow
the IANA specification uniformly, so it is necessary to do sysctl
configuration in each container individually, which increases the user's
resource management costs.
(2) For new applications, since sysctl(net.ipv4.local_port_range) is
isolated across namespaces, the container cannot inherit the host's value,
so after startup, it remains at the kernel default value of 32768-60999,
which reduces the ease of use of the system.

Solution
========================================
In order to maintain compatibility, we provide a sysctl interface in
host namespace, which makes it easy to tune local port range to
IANA specification.

When ip_local_port_range_use_iana=1, the local port range of all network
namespaces is tuned to IANA specification (49152-60999), and IANA
specification is also used for newly created network namespaces. Therefore,
each container does not need to do sysctl settings separately, which
improves the convenience of configuration.
When ip_local_port_range_use_iana=0, the local port range of all network
namespaces are tuned to the original kernel defaults (32768-60999).
For example:
	# cat /proc/sys/net/ipv4/ip_local_port_range 
	32768   60999
	# echo 1 > /proc/sys/net/ipv4/ip_local_port_range_use_iana
	# cat /proc/sys/net/ipv4/ip_local_port_range 
	49152   60999

	# unshare -n
	# cat /proc/sys/net/ipv4/ip_local_port_range 
	49152   60999

Notes
========================================
The lower value(49152), consistent with IANA dynamic port lower limit.
The upper limit value(60999), which differs from the IANA dynamic upper
limit due to the fact that Linux will use 61000-65535 as masquarading/NAT,
but this does not conflict with the IANA specification[3].

Note that following the above specification reduces the number of ephemeral
ports by half, increasing the risk of port exhaustion[2].

[1]:https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.txt
[2]:https://lore.kernel.org/all/bf42f6fd-cd06-02d6-d7b6-233a0602c437@gmail.com/
[3]:https://lore.kernel.org/all/20070512210830.514c7709@the-village.bc.nu/

Co-developed-by: Kun Jiang <jiang.kun2@zte.com.cn>
Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
Signed-off-by: Kun Jiang <jiang.kun2@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
Reviewed-by: Peilin He<he.peilin@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
---
 Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
 net/ipv4/af_inet.c                     |  7 ++++++-
 net/ipv4/sysctl_net_ipv4.c             | 31 +++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bd50df6a5a42..27f4928c2a1d 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1320,6 +1320,19 @@ ip_local_port_range - 2 INTEGERS
 	Must be greater than or equal to ip_unprivileged_port_start.
 	The default values are 32768 and 60999 respectively.

+ip_local_port_range_use_iana - BOOLEAN
+	Tune ip_local_port_range to IANA specification easily.
+	When ip_local_port_range_use_iana=1, the local port range of
+	all network namespaces is tuned to IANA specification (49152-60999),
+	and IANA specification is also used for newly created network namespaces.
+	Therefore, each container does not need to do sysctl settings separately,
+	which improves the convenience of configuration.
+	When ip_local_port_range_use_iana=0, the local port range of
+	all network namespaces are tuned to the original kernel
+	defaults (32768-60999).
+
+	Default: 0
+
 ip_local_reserved_ports - list of comma separated ranges
 	Specify the ports which are reserved for known third-party
 	applications. These ports will not be used by automatic port
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index b24d74616637..42b6bc58dc45 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -123,6 +123,8 @@

 #include <trace/events/sock.h>

+extern u8 sysctl_ip_local_port_range_use_iana;
+
 /* The inetsw table contains everything that inet_create needs to
  * build a new socket.
  */
@@ -1802,7 +1804,10 @@ static __net_init int inet_init_net(struct net *net)
 	/*
 	 * Set defaults for local port range
 	 */
-	net->ipv4.ip_local_ports.range = 60999u << 16 | 32768u;
+	if (sysctl_ip_local_port_range_use_iana)
+		net->ipv4.ip_local_ports.range = 60999u << 16 | 49152u;
+	else
+		net->ipv4.ip_local_ports.range = 60999u << 16 | 32768u;

 	seqlock_init(&net->ipv4.ping_group_range.lock);
 	/*
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 162a0a3b6ba5..a38447889072 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -45,6 +45,8 @@ static unsigned int tcp_child_ehash_entries_max = 16 * 1024 * 1024;
 static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
+u8 sysctl_ip_local_port_range_use_iana;
+EXPORT_SYMBOL(sysctl_ip_local_port_range_use_iana);

 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
@@ -95,6 +97,26 @@ static int ipv4_local_port_range(struct ctl_table *table, int write,
 	return ret;
 }

+static int ipv4_local_port_range_use_iana(struct ctl_table *table, int write,
+					  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net;
+	int ret;
+
+	ret = proc_dou8vec_minmax(table, write, buffer, lenp, ppos);
+
+	if (write && ret == 0) {
+		for_each_net(net) {
+			if (sysctl_ip_local_port_range_use_iana)
+				set_local_port_range(net, 49152u, 60999u);
+			else
+				set_local_port_range(net, 32768u, 60999u);
+		}
+	}
+
+	return ret;
+}
+
 /* Validate changes from /proc interface. */
 static int ipv4_privileged_ports(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
@@ -575,6 +597,15 @@ static struct ctl_table ipv4_table[] = {
 		.extra1		= &sysctl_fib_sync_mem_min,
 		.extra2		= &sysctl_fib_sync_mem_max,
 	},
+	{
+		.procname	= "ip_local_port_range_use_iana",
+		.data		= &sysctl_ip_local_port_range_use_iana,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= ipv4_local_port_range_use_iana,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };

 static struct ctl_table ipv4_net_table[] = {
-- 
2.15.2

