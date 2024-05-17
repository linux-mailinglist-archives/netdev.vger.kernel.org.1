Return-Path: <netdev+bounces-96920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E178C836B
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210A61C227C5
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A369219E1;
	Fri, 17 May 2024 09:27:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EF636120;
	Fri, 17 May 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938020; cv=none; b=UfKUzPkw9Y4csZjQszm4p3q18nfr45e3ZMLGELx/8bVCqHTFpLKB0m0WtBGjy6tqUYJDM3g8ABYl8ggcf8KWqv3k5Lw6rzl4j+/bFRd79m/COeMsBwSuhccl1PAwyFcf9ElUnFtZSK+2INia4LY2iDnw56WL41MhnE6Ym7fDuBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938020; c=relaxed/simple;
	bh=dDE02QwcEJgIaN7EsPYpJ/E8ZjuShWfIOgaAUYFyGrI=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=a98cMfGdPPq6D2zLx62mfYil3PiSSrytH6ifJgnsiZM3XI24+hADVXAe/uSW2SSaXhGXOLCuNsS/5a6iUtHwrFmSl33YlRvqCXZYPMeYM8P3RUcyNoUNF0lgrjwZj0O5nV/sIQD9EYlBepKlDeMg0pLXZYC04sPfInKoEy8Q+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VghRs6vrLz5R9kB;
	Fri, 17 May 2024 17:26:49 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 44H9Qa5F065180;
	Fri, 17 May 2024 17:26:36 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Fri, 17 May 2024 17:26:39 +0800 (CST)
Date: Fri, 17 May 2024 17:26:39 +0800 (CST)
X-Zmail-TransId: 2af9664722cf5bc-59194
X-Mailer: Zmail v1.0
Message-ID: <20240517172639229ec5bN7VBV7SGEHkSK5K6f@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <davem@davemloft.net>
Cc: <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <corbet@lwn.net>, <dsahern@kernel.org>, <ncardwell@google.com>,
        <soheil@google.com>, <mfreemon@cloudflare.com>, <lixiaoyan@google.com>,
        <david.laight@aculab.com>, <haiyangz@microsoft.com>,
        <ye.xingchen@zte.com.cn>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <zhang.yunkai@zte.com.cn>, <fan.yu9@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0XSBpY21wOiBBZGQgaWNtcF90aW1lc3RhbXBfaWdub3JlX2FsbCB0byBjb250cm9sIElDTVBfVElNRVNUQU1Q?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 44H9Qa5F065180
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 664722D9.002/4VghRs6vrLz5R9kB

From: YeXingchen <ye.xingchen@zte.com.cn>

The CVE-1999-0524 became a medium risk vulnerability in May of this year.

In some embedded systems, firewalls such as iptables maybe cannot to use.
For embedded systems where firewalls can't be used and devices that don't
require icmp timestamp, provide the icmp_timestamp_ignore_all interface,
which ignores all icmp timestamp messages to circumvent the vulnerability.

Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
---
 Documentation/networking/ip-sysctl.rst                   | 6 ++++++
 .../networking/net_cachelines/netns_ipv4_sysctl.rst      | 1 +
 include/net/netns/ipv4.h                                 | 1 +
 include/uapi/linux/sysctl.h                              | 1 +
 net/ipv4/icmp.c                                          | 8 ++++++++
 net/ipv4/sysctl_net_ipv4.c                               | 9 +++++++++
 6 files changed, 26 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bd50df6a5a42..41eb3de61659 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1441,6 +1441,12 @@ icmp_ratelimit - INTEGER

 	Default: 1000

+icmp_timestamp_ignore_all - BOOLEAN
+	If set non-zero, then the kernel will ignore all ICMP TIMESTAMP
+	requests sent to it.
+
+	Default: 0
+
 icmp_msgs_per_sec - INTEGER
 	Limit maximal number of ICMP packets sent per second from this host.
 	Only messages whose type matches icmp_ratemask (see below) are
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 9b87089a84c6..ed72f67c8f72 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -38,6 +38,7 @@ u8                              sysctl_icmp_ignore_bogus_error_responses
 u8                              sysctl_icmp_errors_use_inbound_ifaddr                                                
 int                             sysctl_icmp_ratelimit                                                                
 int                             sysctl_icmp_ratemask                                                                 
+u8                              sysctl_icmp_timestamp_ignore_all
 u32                             ip_rt_min_pmtu                               -                   -                   
 int                             ip_rt_mtu_expires                            -                   -                   
 int                             ip_rt_min_advmss                             -                   -                   
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index c356c458b340..7364c469e7eb 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -113,6 +113,7 @@ struct netns_ipv4 {
 	u8 sysctl_icmp_echo_ignore_broadcasts;
 	u8 sysctl_icmp_ignore_bogus_error_responses;
 	u8 sysctl_icmp_errors_use_inbound_ifaddr;
+	u8 sysctl_icmp_timestamp_ignore_all;
 	int sysctl_icmp_ratelimit;
 	int sysctl_icmp_ratemask;

diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 8981f00204db..ef8640947f4e 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -426,6 +426,7 @@ enum
 	NET_TCP_ALLOWED_CONG_CONTROL=123,
 	NET_TCP_MAX_SSTHRESH=124,
 	NET_TCP_FRTO_RESPONSE=125,
+	NET_IPV4_ICMP_TIMESTAMP_IGNORE_ALL = 126,
 };

 enum {
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index ab6d0d98dbc3..6fa5c26cf402 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1152,6 +1152,11 @@ EXPORT_SYMBOL_GPL(icmp_build_probe);
 static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
 {
 	struct icmp_bxm icmp_param;
+	struct net *net;
+
+	if (READ_ONCE(net->ipv4.sysctl_icmp_timestamp_ignore_all))
+		return SKB_NOT_DROPPED_YET;
+
 	/*
 	 *	Too short.
 	 */
@@ -1469,6 +1474,9 @@ static int __net_init icmp_sk_init(struct net *net)
 	net->ipv4.sysctl_icmp_echo_enable_probe = 0;
 	net->ipv4.sysctl_icmp_echo_ignore_broadcasts = 1;

+	/* Control parameters for TIMESTAMP replies. */
+	net->ipv4.sysctl_icmp_timestamp_ignore_all = 0;
+
 	/* Control parameter - ignore bogus broadcast responses? */
 	net->ipv4.sysctl_icmp_ignore_bogus_error_responses = 1;

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 162a0a3b6ba5..b002426c3d9c 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -651,6 +651,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= ipv4_ping_group_range,
 	},
+	{
+		.procname	= "icmp_timestamp_ignore_all",
+		.data		= &init_net.ipv4.sysctl_icmp_timestamp_ignore_all,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	{
 		.procname	= "raw_l3mdev_accept",
-- 
2.25.1

