Return-Path: <netdev+bounces-292555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Va3UBdXIF2oyQwgAu9opvQ
	(envelope-from <netdev+bounces-292555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 06:47:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B555EC905
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 06:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2ECFC3007BB6
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F01DE8BE;
	Thu, 28 May 2026 04:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="GLBUdznC"
X-Original-To: netdev@vger.kernel.org
Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01193438B2
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779943632; cv=none; b=LAgHOFTpMPA7qak0xa2+EPpj0WTGCwTwQy3A91gDXb+27vrDjfT6l/zLQbZ7/Zk15cxm2pKeat2B2E4Z9rwFcvIBVCW/Uj3L0WMofeDVSSOzmCK2pKUeO2komy5XwYYzH91cx1YqXIcPSoKLhvvGHcMBraJyKnB0Fj46H2Yoeis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779943632; c=relaxed/simple;
	bh=dsFjl1mS6Xi/7O3wRpuZD+cTj0HWAt3aoIAXWRM0I/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BpZUkAe7IRJyGddZAUsZ33T7yxJy4T4HWlILOA+60tOffw3ePYO4zthlTq5mYISWhzu24vSQgLpT7KAx5v8t+CouRW6B0K93VhLq9XrUQU+AH7dLY0ubFJ59YYp2xYUsIt+X7XgV3XvKNaLA+pKMbzCUDyFQz7YtBinQOkCnURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=GLBUdznC; arc=none smtp.client-ip=173.38.203.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3302; q=dns/txt;
  s=iport01; t=1779943631; x=1781153231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g90itd9TgsC15zDBlt8rxIpYyEdh7zc3KR8WqzuGN4E=;
  b=GLBUdznCsdKzjk4c87OUiDA7pygugyToq198H8nzue7FzZKtn3g6F/4N
   rRI8lxT2rekmdDjo7xVbKHNXfrRHDL7cBK+8HDsL62sQXqnfJl0tD4PPN
   OfJTiAnVkGjBVERElTiGnTBA/AnDdj0LDGPjJH0uZ0V5LxzMjuLuLSvyl
   +UDOFXAbzzXc4V/kZu9hgRz3bWhRwiC0AxKHtC9M0miqxSD3O9zRSPcfk
   5iSdXY/0VWxRcmZMm+b3ymHdy0M136qkxx6HORcTine9hbMD60s2JxRLF
   nnYjAiZ1HwcKrwxVbXEsGAHcd9zt7bfiSApB+mzgSo4FMK6TDtsfvwokQ
   g==;
X-CSE-ConnectionGUID: +/f7KUIgQo6jKpBUhByAWQ==
X-CSE-MsgGUID: bvU620ILT2Khj5TjOc7THA==
X-IPAS-Result: =?us-ascii?q?A0A+AgArxxdq/8pK/pBaHgEBCxIMggULgleBUUKXFJhAh?=
 =?us-ascii?q?V6Bfg8BAQEPUQQBAYUGjTQCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBA?=
 =?us-ascii?q?QIBBwWBDhOGXIZdKwsBRoFIgwqCdAOyEIF5M4EB3kGBZAELFAGBOI1cgQ+EY?=
 =?us-ascii?q?CcbgUlEgRWDaIsHBIIigQyPGEiBHgNZLAFVEw0KCwcFgWYDNRIqFW4yHYEjP?=
 =?us-ascii?q?heBCxsHBYFLdnJqgQWFGCMmA06BLYF/cAMLGA1IESw3FBsEPm4HjVo+gltUR?=
 =?us-ascii?q?aUooRGEJqFbGjOEBJQWklABLodlkHOjahVZhGiBaDwrgS4zGggbFYMjUhkPj?=
 =?us-ascii?q?i0W0Ak8cgIHAgcOAwuTZQEB?=
IronPort-Data: A9a23:Z/Xoe6hc7016o4JsG3s0b82SX161aREKZh0ujC45NGQN5FlHY01je
 htvD2GOOPneYWHwfIp2Ody18BwEusCByNNhG1FpqylhFCljpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeDULOZ82QsaDxMtvjc8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqVbvegoIlxv+
 sUfdjIudjq+h8in6Y2CH7wEasQLdKEHPasWt2slyXTSCuwrBMiaBa7L/tRfmjw3g6iiH96HO
 5ZfM2czKkucJUcXYD/7C7pm9Ausrnn2fzxIqU69rqss6G+Vxwt0uFToGIeFJ43QHZkK9qqej
 mjYwjqjWjA+CIa8yTjYznCLjbDzvQquDer+E5X9rJaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkAcRzRMbt0OrsI6RTU2k
 FSOmrvBAzFzvLCLYWyS+63Srj6oPyURa2gYakc5oRAt6tT55YV2hRXVQ5M7Sei+j8b+Hnf7x
 DXiQDUCuoj/RPUjj82TlW0rSRr1znQVZmbZPjnqY18=
IronPort-HdrOrdr: A9a23:kEr2kKA0IFcOZOflHemY55DYdb4zR+YMi2TDGXocdfUzSL37qy
 nAppomPHPP4gr5O0tQ+uxoRpPgfZq0z/ccirX5Vo3MYOCJggaVxflZjbfK8nnHBzD08PJb2O
 NLdqhzD8C1MH1B5PyKhTVR170bsb66GGfCv5a780tQ
X-Talos-CUID: 9a23:rPYSUGBS8R+Eoej6E2og+hE3J+EqS3qDzlTICXK4I3dAd4TAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Am1ruEw7jJrY3xAjhchlM3exbxoxi/ZnwUhgstal?=
 =?us-ascii?q?cmMmGaBByHDzCsBSeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,172,1774310400"; 
   d="scan'208";a="58592047"
Received: from aer-l-core-01.cisco.com ([144.254.74.202])
  by aer-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 May 2026 04:45:59 +0000
Received: from bgl-ads-5123.cisco.com (bgl-ads-5123.cisco.com [64.104.134.251])
	by aer-l-core-01.cisco.com (Postfix) with ESMTP id DA279D6F04;
	Thu, 28 May 2026 04:45:57 +0000 (GMT)
From: Hariom Dixit <hadixit@cisco.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	etmartin@cisco.com,
	hadixit@cisco.com
Subject: [RFC] net: soft lockup in netif_close_many() during namespace teardown
Date: Thu, 28 May 2026 10:15:56 +0530
Message-Id: <20260528044556.26628-1-hadixit@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: NONE;bgl-ads-5123.cisco.com [64.104.134.251]
X-Outbound-SMTP-Client: 64.104.134.251, bgl-ads-5123.cisco.com
X-Outbound-Node: aer-l-core-01.cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hadixit@cisco.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292555-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[cisco.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cisco.com:mid,cisco.com:dkim]
X-Rspamd-Queue-Id: 97B555EC905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

We are hitting a reproducible soft lockup in netif_close_many()
(formerly dev_close_many(), renamed in commit 88d3cec28274) during
network namespace teardown on systems with ~1700 network devices
and 30K-65K fib6_nodes.

The NETDEV_DOWN notification loop iterates all devices without
yielding the CPU. IPv6 notifier callbacks perform full FIB6 tree
walks for each device, resulting in O(N_devices * M_fib6_nodes)
work without any scheduling point.

The bug exists in current mainline (v7.1-rc5) at net/core/dev.c
line 1803 in netif_close_many().

Crash signature (from 6.6.84, function was still dev_close_many):

  watchdog: BUG: soft lockup - CPU#13 stuck for 26s!
            [kworker/u32:1:6737]
  Workqueue: netns cleanup_net

  Call Trace:
   #8  asm_sysvec_apic_timer_interrupt
       [exception RIP: fib6_age+20]
   #11 fib6_walk
   #12 fib6_clean_tree
   #14 fib6_walk_continue
   #15 fib6_walk
   #16 fib6_clean_tree
   #17 __fib6_clean_all
   #18 fib6_run_gc
   #19 ndisc_netdev_event
   #20 notifier_call_chain
   #21 raw_notifier_call_chain
   #22 call_netdevice_notifiers_info
   #23 dev_close_many
   #24 unregister_netdevice_many_notify
   #25 default_device_exit_batch
   #26 ops_exit_list
   #27 cleanup_net
   #28 process_one_work
   #29 worker_thread

  CPU utilization during lockup (every 4s): 100% system, 0% idle

Analysis:

netif_close_many() dispatches NETDEV_DOWN for each device in a
tight loop. Two IPv6 notifier callbacks trigger full fib6 tree
walks per device:

  1. ndisc_netdev_event(NETDEV_DOWN) -> fib6_run_gc
     -> fib6_clean_all(fib6_age): walks entire fib6 tree per
     device. During teardown, fib6_age finds nothing to expire
     (no RTF_EXPIRES routes), so the tree stays full-size across
     all iterations.

  2. addrconf_notify(NETDEV_DOWN) -> addrconf_ifdown
     -> rt6_disable_ip -> fib6_clean_all(fib6_ifdown): walks
     entire fib6 tree per device.

With 1700 devices and 60K+ nodes, the total uninterrupted
work is ~102M node visits, taking >26 seconds -- well over the
10-second soft lockup threshold.

Proposed fix (against mainline v7.1-rc5):

Adding cond_resched() after each device's notification dispatch.
At this point only rtnl_lock (a mutex) is held -- all spinlocks
and RCU read-side critical sections within the notifier callbacks
are acquired and released per-device invocation, so sleeping is
safe.

diff --git a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1803,6 +1803,7 @@ void netif_close_many(struct list_head *head, bool unlink)
     list_for_each_entry_safe(dev, tmp, head, close_list) {
         rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_UP|IFF_RUNNING, GFP_KERNEL, 0, NULL);
         call_netdevice_notifiers(NETDEV_DOWN, dev);
+        cond_resched();
         if (unlink)
             list_del_init(&dev->close_list);
     }

Testing (on 6.6.84 with equivalent change in dev_close_many):
  - Without fix: soft lockup panic with 1700 devices + 65K routes
  - With fix: no crash with 4000 devices + 65K routes

Note: The IPv4 path (fib_netdev_event -> fib_disable_ip ->
fib_table_flush) also fires from the same NETDEV_DOWN loop, so
the single cond_resched() covers both IPv4 and IPv6 scenarios.

Question:
  1. Is cond_resched() the right approach here?

I can send a formal patch if the approach looks reasonable.

Thanks,
Hariom

