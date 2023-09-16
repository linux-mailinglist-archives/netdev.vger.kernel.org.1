Return-Path: <netdev+bounces-34209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363077A2CD1
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 03:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5876285989
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 01:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFACFA2A;
	Sat, 16 Sep 2023 01:06:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AC1FA3
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 01:06:34 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FDD90
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:06:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81c39acfd9so1580273276.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694826392; x=1695431192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5/2TmJW7TVwMUwjqWehrqG2jW/DfGV/DuHWQqCSgfA=;
        b=q5JA2egAEt5Me/lAE7ikq6k0EcZr8shShUDP+cfF42+LORK8lsizE/FB73B9iLhh+a
         Bp2fjnaB6LAD0nQMSgmyCanaWLlaFScZV8tfw3QBNLjkpW3O94ggUD99pk3aoSHrhfp7
         Is7+6LT3rJDfUGC9qnJK320f4KB2GPHMXROozMRODDzAnN1A+2vKEPwKUjBXcu193FQM
         pr4OVbkdZkK/m5nDr8tyvB2cRn1RSPE6YSr2kbuN+rPQ6dO7a2ZxzCd+Kwsg++BS46VX
         /LmZlBBdf0Ra32h7Jw07QfzSqr2aYPLfckrE/tAbCebL4UC0zlfuGcX10jLN6fT3QM5q
         0xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694826392; x=1695431192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5/2TmJW7TVwMUwjqWehrqG2jW/DfGV/DuHWQqCSgfA=;
        b=Hl+DCZZSzsnWAfl1jt5GmbiYFPNk0KFzEM4E90gq6Rme6sJAgPr+rZBoRq+QtROlAi
         FPZOUcyMp8KYkQYxmiyXLNRapzXchF/Iyd8nfnq6aolNOV58Pdbc9r4HFrLXCGRCRECO
         1MQX/QW+hDUr5HKwKM6pUWN2plHjy1DNxgXsVF9z2nyDamvffCRV36wV/8iAScfrgF4s
         jg+Zl77kXnKzVnanH2xtfl5xv3e7DnyGwlIH/5nOBmsPtZlLhmSy30s3WIMBXxD6eLaJ
         JYmvdm7EctAhjT2BuXNOl7q+mBfkSEDGP7YhutC1r+ne0O7dAstw8VhOhMqdnT/AsBZS
         R8FA==
X-Gm-Message-State: AOJu0Yw916SC+AicJTjltPVMTHdAU855mzWooF+wzix5pnuSiRonIVLE
	MDMfImcLP/Fcz46h8Zy8xg5ucYqk43R2yNQ=
X-Google-Smtp-Source: AGHT+IHMOEsWTT9B2EBBIZws3RB/c5o3xIzsrGtTuc0l45TXM6EofOj3QnIb9zkstuKDe2Os6C/QP5J5Ik7FIag=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a25:7796:0:b0:d07:e80c:412e with SMTP id
 s144-20020a257796000000b00d07e80c412emr76262ybc.12.1694826392014; Fri, 15 Sep
 2023 18:06:32 -0700 (PDT)
Date: Sat, 16 Sep 2023 01:06:22 +0000
In-Reply-To: <20230916010625.2771731-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230916010625.2771731-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916010625.2771731-3-lixiaoyan@google.com>
Subject: [PATCH v1 net-next 2/5] net-smnp: reorganize SNMP fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Chao Wu <wwchao@google.com>

Reorganize fast path variables on tx-txrx-rx order.
Fast path cacheline ends afer LINUX_MIB_DELAYEDACKLOCKED.
There are only read-write variables here.

Below data generated with pahole on x86 architecture.

Fast path variables span cache lines before change: 12
Fast path variables span cache lines after change: 2

Tested:
Built and installed.

Signed-off-by: Chao Wu <wwchao@google.com>
Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
---
 include/uapi/linux/snmp.h | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 26f33a4c253d7..a414985c68bf9 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -170,6 +170,22 @@ enum
 enum
 {
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
@@ -185,14 +201,9 @@ enum
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
@@ -246,7 +257,6 @@ enum
 	LINUX_MIB_TCPREQQFULLDOCOOKIES,		/* TCPReqQFullDoCookies */
 	LINUX_MIB_TCPREQQFULLDROP,		/* TCPReqQFullDrop */
 	LINUX_MIB_TCPRETRANSFAIL,		/* TCPRetransFail */
-	LINUX_MIB_TCPRCVCOALESCE,		/* TCPRcvCoalesce */
 	LINUX_MIB_TCPBACKLOGCOALESCE,		/* TCPBacklogCoalesce */
 	LINUX_MIB_TCPOFOQUEUE,			/* TCPOFOQueue */
 	LINUX_MIB_TCPOFODROP,			/* TCPOFODrop */
@@ -262,12 +272,7 @@ enum
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
@@ -279,10 +284,8 @@ enum
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
2.42.0.459.ge4e396fd5e-goog


