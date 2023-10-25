Return-Path: <netdev+bounces-44065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CF17D5F79
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D60281CAF
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243EB1FBF;
	Wed, 25 Oct 2023 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3OOffmcx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB7185C
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 01:24:24 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC13310D5
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:24:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7fb3f311bso65774957b3.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698197062; x=1698801862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfCOoZwHA0bPVH8otxymIWQnUtN4Qp7tZ0RF3hltEfE=;
        b=3OOffmcxnaaq93BGzkNosgtKRww1uBjg+1ZypMbwMUGzfZUkuMaYE4BbxZPL0LP8ct
         e05hwEjaAzPfB9OD7jrDy9zJJSmgk04Cy7916Rh1l9s3NIr1PX9IDkAkIn2qRE4I0/KX
         mgeRZr3YIb2EGuMxGDAa1KbS+3xhheqQJCR4Zu/xGSi+TLB2NA3LqLMZlOiohcKhoQIH
         G44hjMXHukTaGWO8ZTGKWpoGwGW8OUEBq2P4sdiAN/cHW8bC+1fCqJ8sluy8YVj4AMX9
         5Mdyl739G9u6V5VONUxTjmzxTLp0Bi12EZuT/oLNMQHlZIy79Yu1L28rjawDQzbUW5fr
         FblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698197062; x=1698801862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfCOoZwHA0bPVH8otxymIWQnUtN4Qp7tZ0RF3hltEfE=;
        b=nqnt/pMQ1VAUszrgfQMNg9W7nXtfiBCxsri0RsQn9yg+E8v68e7+gpiMdn4v1yXV7Y
         jeGBK1mTYoVLSKYZWsUIdSU/dNEz0OH9XYptE2rMGYHfG6yAGQ1K31XlTZo+0nfzCwOe
         KTCmfYquDYUM8aZXlP5OOv3+OonSFTUiAi+++svt7L7jrLQTXBXVSElm7HMLAjCxqtQS
         7wWE5OK1PwTiTtoM/PbHsgahQfimb358kVDSyy1BEjEDwZt2yKLxT5HVSHJHowuKEkV4
         QfhxZKK4bvNN7jWezOdZZE8khV0xKFQWYfH44xbUH/UgHRAZhEG02OYptRkR/iUuGDQY
         gazg==
X-Gm-Message-State: AOJu0Ywfjs2hNQdJDtXcXUke7y3PaI9OYW3nFTPedUEEk0hpw3RQufJg
	3whh/5IDFT9LZGbu+GXC0pC66Bx0VMqVHAs=
X-Google-Smtp-Source: AGHT+IGjIsWi0r8/ghp8ZVu0xgtZoQGST4SewUS/1BWLOsJkAfakpbXdy2U1ebdabQ2LYRM3ZKolh/HY2aE9//Q=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:6902:1083:b0:d9a:cc6b:cf1a with SMTP
 id v3-20020a056902108300b00d9acc6bcf1amr364358ybu.8.1698197061989; Tue, 24
 Oct 2023 18:24:21 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:24:08 +0000
In-Reply-To: <20231025012411.2096053-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231025012411.2096053-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231025012411.2096053-4-lixiaoyan@google.com>
Subject: [PATCH v3 net-next 3/6] net-smnp: reorganize SNMP fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>, 
	David Ahern <dsahern@kernel.org>
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
index b2b72886cb6d1..006c49e18a3f5 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -8,6 +8,13 @@
 #ifndef _LINUX_SNMP_H
 #define _LINUX_SNMP_H
 
+/* Enums in this file are exported by their name and by
+ * their values. User space binaries should ingest both
+ * of the above, and therefore ordering changes in this
+ * file does not break user space. For an exmample, please
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


