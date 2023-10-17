Return-Path: <netdev+bounces-41642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CF17CB81A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E4DAB20E85
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2613F4402;
	Tue, 17 Oct 2023 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kgg0qC0y"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317317E3
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:47:28 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD5B0
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:47:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cfdacf8fso47672387b3.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697507246; x=1698112046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hW4XrzzTok1rHk8xKHWgdAm2sWcbPM9T7dz4Kpk4io=;
        b=Kgg0qC0yPRPJWO2YMiLRM0gt7CrgTM9jKpjChOLJhiOn2xklutK+2pDdFbOFgdRRuY
         QNLbBh5QnqShRaqMdKD1ZADWJiwq3nRbfBFa5nWZn6fLq2LGWk8Oq2C2zY9efL8Xaaj8
         xjt3qBoBZEJ/BqCBLg2TCJfIUwqtPO6848HWJy9ScFG9oAEoW5OsfTrKrjmasuVegQAM
         L7Ai+YQ2gUda3NsN/Q3p/Ssqg2bFH8k07qOTNxSKX3j2nIAOiJH8lt766Geb0tF60gCO
         kcZeacQbBurJqmdaZTKwTdopfgBlVOBInf5r5hA4bpOiK5QS/FuiwDsR+aMYkenkgXhz
         mR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697507246; x=1698112046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hW4XrzzTok1rHk8xKHWgdAm2sWcbPM9T7dz4Kpk4io=;
        b=UtsmFT8IzkBwNdksn15ULF8Z6Mc8CNNdbgbgqhhv/NmbDYCB3J32F+NlZe3oxiUWW6
         ouikqMDWGYfaC8rOXzltZw4ya+MBkIETzwfDr1GI6QAezdSqJmRPpZDCekjWtTm7J33x
         6VCGhtIQk6Ek8+4XAUKZb0AzOdZ7G6Vye3bw4xsDsq/spXUxXyjz0+Zl4OG/sem7rjHU
         CUdcBN6dRoaehC3d/iYW4fBeV4+D0vPeu/vhqiAm8wyqJKjnB7TmgR88XRnNMkIlMBNP
         Ce8zkWcmjO/TpqYmQvgxaMFmtEm+6FFqR9Ng5mgGznXPsnMJ3idY5IaO/aquABSlOpyh
         3P2w==
X-Gm-Message-State: AOJu0YyiXVpQmgDRIMxFGSyZ6xosG2oZgIP2M6hOn207na2pL3U61mN7
	nXBoJRDVtMVRev3dBn2bZSrQ/t67FwouCLU=
X-Google-Smtp-Source: AGHT+IF3XNhN7b31uaUKuWAxowUGWRYgud7MiJnMNz19ik/vwxNFL07nzyP+gXpbHLo3QzNUN2cjknrOa2dItbM=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:6902:b16:b0:d9a:fd4d:d536 with SMTP
 id ch22-20020a0569020b1600b00d9afd4dd536mr13998ybb.3.1697507245844; Mon, 16
 Oct 2023 18:47:25 -0700 (PDT)
Date: Tue, 17 Oct 2023 01:47:13 +0000
In-Reply-To: <20231017014716.3944813-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231017014716.3944813-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017014716.3944813-3-lixiaoyan@google.com>
Subject: [PATCH v2 net-next 2/5] net-smnp: reorganize SNMP fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
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

Signed-off-by: Chao Wu <wwchao@google.com>
Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/uapi/linux/snmp.h | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 26f33a4c253d7..aefb39edb87c6 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -169,7 +169,28 @@ enum
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
@@ -185,14 +206,9 @@ enum
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
@@ -246,7 +262,6 @@ enum
 	LINUX_MIB_TCPREQQFULLDOCOOKIES,		/* TCPReqQFullDoCookies */
 	LINUX_MIB_TCPREQQFULLDROP,		/* TCPReqQFullDrop */
 	LINUX_MIB_TCPRETRANSFAIL,		/* TCPRetransFail */
-	LINUX_MIB_TCPRCVCOALESCE,		/* TCPRcvCoalesce */
 	LINUX_MIB_TCPBACKLOGCOALESCE,		/* TCPBacklogCoalesce */
 	LINUX_MIB_TCPOFOQUEUE,			/* TCPOFOQueue */
 	LINUX_MIB_TCPOFODROP,			/* TCPOFODrop */
@@ -262,12 +277,7 @@ enum
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
@@ -279,10 +289,8 @@ enum
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
2.42.0.655.g421f12c284-goog


