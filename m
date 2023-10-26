Return-Path: <netdev+bounces-44410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A66407D7E5F
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D6EB21409
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82121A5A9;
	Thu, 26 Oct 2023 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QumY1cDs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BD1A58F
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:20:18 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375D8CE
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:20:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cb79eb417so495249276.2
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698308416; x=1698913216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPSnH5IdsOychGCLHjfmwJT4EW1gfglkruQYuYmuFAw=;
        b=QumY1cDse1pfZZclidt/8CFBHQOC2Ua9mwUxvOkiJVn2Ni2yZePUZmOMBWwhY0coga
         HXomvGMYDNw1BUWqPylAPT131sVvY7RuSNa5haIVIpbVPm0oh5VCDsJ89DA4BKpnz9L7
         twkvbhlM4kuRvEMBGhdINNQA0l4arLdVnugMhQmdk3JkhTnAFYIEUnbMFDJiV/QvTrWT
         OSc79hpFLIq+9ad5H0LKamK+X5uOdo7lEessWXocyKYb37+Rf1G9PQU/EgdQcCVLyu4K
         k8v74CjvMGfse9R4lJR1gVi0xNsJdj3IONh+wxdegeufLtpQYSYWHCeNBlhtxCWbBrS6
         drMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698308416; x=1698913216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPSnH5IdsOychGCLHjfmwJT4EW1gfglkruQYuYmuFAw=;
        b=Sb86ZNtcVJIbvI8tupRmuPNzxKHb+c94ShGKtU29/qkssBPBJvrD5H9rx8bsD6Io9W
         EmYnV32XOUiWwZRzK1ZigWKHrdUmj9ixdAZLAP+ZWL4HYQ9D5mXR4sFap20U1nHfV22e
         pXlJ8NnfYZ9ycBjnWLsm63QD0Kk/Y1ia4EdAOPwYWLac8PoM17XOmu/zbru/gb+a7gfC
         /e5no8FaPJgkoPLr3NC+L0PTNvn4NwoNuo8otCV4vc/XFacPQqCYtG0akGIx6OqxDwkH
         2nzxVo1I0elBtajNfqEED41CHWGutIJ2RmpzgiVTPAWsJuqFcwxYP21JnE9D4Ku3uSrU
         cwOQ==
X-Gm-Message-State: AOJu0YzwSVczCGp/+qyujxVZxWldTneCtCtlZCf4HFiA1yJWb0q1ZW/E
	AQypM1Z+SgRVqUD7mvcyqKhmSxoYiJDPcm0=
X-Google-Smtp-Source: AGHT+IGusD+jlvh/sWi/ZqVfPR9odNaS/02FaprtbNvJ3BXjnA/3azs1KQl7CAW2jogrpAxbPnKSHJiG1GKbel0=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a81:57c1:0:b0:5a7:b8d1:ef65 with SMTP id
 l184-20020a8157c1000000b005a7b8d1ef65mr111984ywb.3.1698308416436; Thu, 26 Oct
 2023 01:20:16 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:19:56 +0000
In-Reply-To: <20231026081959.3477034-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026081959.3477034-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231026081959.3477034-4-lixiaoyan@google.com>
Subject: [PATCH v4 net-next 3/6] net-smnp: reorganize SNMP fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Chao Wu <wwchao@google.com>

Reorganize fast path variables on tx-txrx-rx order.
Fast path cacheline ends afer LINUX_MIB_DELAYEDACKLOCKED.
There are only read-write variables here.

NOTE: Kernel exports these counters with a leading line with the
names of the metrics. User space binaries not ignoreing the
metric names will not be affected by the change of order here. An
example can be seen by looking at /proc/net/netstat.

Below data generated with pahole on x86 architecture.

Fast path variables span cache lines before change: 12
Fast path variables span cache lines after change: 2

Signed-off-by: Chao Wu <wwchao@google.com>
Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/uapi/linux/snmp.h | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index b2b72886cb6d1..70be81c1fdb6d 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -8,6 +8,13 @@
 #ifndef _LINUX_SNMP_H
 #define _LINUX_SNMP_H
 
+/* Enums in this file are exported by their name and by
+ * their values. User space binaries should ingest both
+ * of the above, and therefore ordering changes in this
+ * file does not break user space. For an example, please
+ * see the output of /proc/net/netstat.
+ */
+
 /* ipstats mib definitions */
 /*
  * RFC 1213:  MIB-II
@@ -170,7 +177,28 @@ enum
 /* linux mib definitions */
 enum
 {
+	/* Caacheline organization can be found documented in
+	 * Documentation/networking/net_cachelines/snmp.rst.
+	 * Please update the document when adding new fields.
+	 */
+
 	LINUX_MIB_NUM = 0,
+	/* TX hotpath */
+	LINUX_MIB_TCPAUTOCORKING,		/* TCPAutoCorking */
+	LINUX_MIB_TCPFROMZEROWINDOWADV,		/* TCPFromZeroWindowAdv */
+	LINUX_MIB_TCPTOZEROWINDOWADV,		/* TCPToZeroWindowAdv */
+	LINUX_MIB_TCPWANTZEROWINDOWADV,		/* TCPWantZeroWindowAdv */
+	LINUX_MIB_TCPORIGDATASENT,		/* TCPOrigDataSent */
+	LINUX_MIB_TCPPUREACKS,			/* TCPPureAcks */
+	LINUX_MIB_TCPHPACKS,			/* TCPHPAcks */
+	LINUX_MIB_TCPDELIVERED,			/* TCPDelivered */
+	/* RX hotpath */
+	LINUX_MIB_TCPHPHITS,			/* TCPHPHits */
+	LINUX_MIB_TCPRCVCOALESCE,		/* TCPRcvCoalesce */
+	LINUX_MIB_TCPKEEPALIVE,			/* TCPKeepAlive */
+	LINUX_MIB_DELAYEDACKS,			/* DelayedACKs */
+	LINUX_MIB_DELAYEDACKLOCKED,		/* DelayedACKLocked */
+	/* End of hotpath variables */
 	LINUX_MIB_SYNCOOKIESSENT,		/* SyncookiesSent */
 	LINUX_MIB_SYNCOOKIESRECV,		/* SyncookiesRecv */
 	LINUX_MIB_SYNCOOKIESFAILED,		/* SyncookiesFailed */
@@ -186,14 +214,9 @@ enum
 	LINUX_MIB_TIMEWAITKILLED,		/* TimeWaitKilled */
 	LINUX_MIB_PAWSACTIVEREJECTED,		/* PAWSActiveRejected */
 	LINUX_MIB_PAWSESTABREJECTED,		/* PAWSEstabRejected */
-	LINUX_MIB_DELAYEDACKS,			/* DelayedACKs */
-	LINUX_MIB_DELAYEDACKLOCKED,		/* DelayedACKLocked */
 	LINUX_MIB_DELAYEDACKLOST,		/* DelayedACKLost */
 	LINUX_MIB_LISTENOVERFLOWS,		/* ListenOverflows */
 	LINUX_MIB_LISTENDROPS,			/* ListenDrops */
-	LINUX_MIB_TCPHPHITS,			/* TCPHPHits */
-	LINUX_MIB_TCPPUREACKS,			/* TCPPureAcks */
-	LINUX_MIB_TCPHPACKS,			/* TCPHPAcks */
 	LINUX_MIB_TCPRENORECOVERY,		/* TCPRenoRecovery */
 	LINUX_MIB_TCPSACKRECOVERY,		/* TCPSackRecovery */
 	LINUX_MIB_TCPSACKRENEGING,		/* TCPSACKReneging */
@@ -247,7 +270,6 @@ enum
 	LINUX_MIB_TCPREQQFULLDOCOOKIES,		/* TCPReqQFullDoCookies */
 	LINUX_MIB_TCPREQQFULLDROP,		/* TCPReqQFullDrop */
 	LINUX_MIB_TCPRETRANSFAIL,		/* TCPRetransFail */
-	LINUX_MIB_TCPRCVCOALESCE,		/* TCPRcvCoalesce */
 	LINUX_MIB_TCPBACKLOGCOALESCE,		/* TCPBacklogCoalesce */
 	LINUX_MIB_TCPOFOQUEUE,			/* TCPOFOQueue */
 	LINUX_MIB_TCPOFODROP,			/* TCPOFODrop */
@@ -263,12 +285,7 @@ enum
 	LINUX_MIB_TCPFASTOPENBLACKHOLE,		/* TCPFastOpenBlackholeDetect */
 	LINUX_MIB_TCPSPURIOUS_RTX_HOSTQUEUES, /* TCPSpuriousRtxHostQueues */
 	LINUX_MIB_BUSYPOLLRXPACKETS,		/* BusyPollRxPackets */
-	LINUX_MIB_TCPAUTOCORKING,		/* TCPAutoCorking */
-	LINUX_MIB_TCPFROMZEROWINDOWADV,		/* TCPFromZeroWindowAdv */
-	LINUX_MIB_TCPTOZEROWINDOWADV,		/* TCPToZeroWindowAdv */
-	LINUX_MIB_TCPWANTZEROWINDOWADV,		/* TCPWantZeroWindowAdv */
 	LINUX_MIB_TCPSYNRETRANS,		/* TCPSynRetrans */
-	LINUX_MIB_TCPORIGDATASENT,		/* TCPOrigDataSent */
 	LINUX_MIB_TCPHYSTARTTRAINDETECT,	/* TCPHystartTrainDetect */
 	LINUX_MIB_TCPHYSTARTTRAINCWND,		/* TCPHystartTrainCwnd */
 	LINUX_MIB_TCPHYSTARTDELAYDETECT,	/* TCPHystartDelayDetect */
@@ -280,10 +297,8 @@ enum
 	LINUX_MIB_TCPACKSKIPPEDTIMEWAIT,	/* TCPACKSkippedTimeWait */
 	LINUX_MIB_TCPACKSKIPPEDCHALLENGE,	/* TCPACKSkippedChallenge */
 	LINUX_MIB_TCPWINPROBE,			/* TCPWinProbe */
-	LINUX_MIB_TCPKEEPALIVE,			/* TCPKeepAlive */
 	LINUX_MIB_TCPMTUPFAIL,			/* TCPMTUPFail */
 	LINUX_MIB_TCPMTUPSUCCESS,		/* TCPMTUPSuccess */
-	LINUX_MIB_TCPDELIVERED,			/* TCPDelivered */
 	LINUX_MIB_TCPDELIVEREDCE,		/* TCPDeliveredCE */
 	LINUX_MIB_TCPACKCOMPRESSED,		/* TCPAckCompressed */
 	LINUX_MIB_TCPZEROWINDOWDROP,		/* TCPZeroWindowDrop */
-- 
2.42.0.758.gaed0368e0e-goog


