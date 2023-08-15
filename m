Return-Path: <netdev+bounces-27819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5177D5DA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 00:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93FDB1C20A82
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 22:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FA5198A3;
	Tue, 15 Aug 2023 22:18:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2D19885
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 22:18:55 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E151BFF
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:18:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68879fc4871so351484b3a.0
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692137934; x=1692742734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEDQaPk+lRz3fKgsk7r3JuIROatHtqntWb1gBwAZF6s=;
        b=XT6f6wbnXFGhIW7dJT3pJ1jflCmvMtGNjweSmdsLvLBZ13aUjccKa/koaHbIFzg5XJ
         mxP4T2FBuQwqtee8VxD1BFsZnPuHf15OYW6YIV1T69qn/QVzpmvLScGaXef+NM24+DBv
         qVpIS38vK95ZS8Fur4y01aJo17qqOB2LRhjQI1Q7LdJpRzYB+0UBGDpX7IYTchmpzIiR
         0PvbA5Q85IhLOgIbOsRrXilMFd+x6eMMVhKBMxs2K8Gafd01rgUy/v/SLjGENNs3YM+c
         twkLX+2WDA8gZ+I4jr3xei1YSqgOxrzYT3IOpQjvqs+e31Tam7p+nYLuzlgGuORJC4SN
         Zexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137934; x=1692742734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEDQaPk+lRz3fKgsk7r3JuIROatHtqntWb1gBwAZF6s=;
        b=KH4P8UvKHQii/ESUAOERwPteZBqoJexO5DbZmg/xzCcd88SwnlNoeH2fzOAReAyje4
         FO1ARQT8Epi4Q3IT5nbSoL7y61yko4pSeC7nW4okR91jwzXAIuXs2pcbUDaPhZEE+C8D
         0hIbovJrgXlPVXPIwnlXS+8XRmnpGZdN2oGxewyzBhbXHP8Pn/vtqbapKAAKssZE4IaM
         sCMu2QF4Omyxv47RFziJb25exTXrSVxQzlGIsgn5djj8i7c06uy96AYu6P8Ao0XSbtH1
         tqbeOjR9FiHGZFNZH5arFrzEjDKVjhSWkgxo+K3lS1evkPbnJ9puRDysDZJVYtndld9u
         81bQ==
X-Gm-Message-State: AOJu0YyYvvSCY16oR11pTNOUXOs6BXvIHUTuvARC6HjevUyp5MiBXZfK
	5NxeXG3wqUlIPbxJNO7ReCm+zRpCss+p7Dq3fH7ZbA==
X-Google-Smtp-Source: AGHT+IFt6UtCk7PTLSdYC94JIv3Bzne27v5e3zHZQ6I4IBaoEHMnrXx1wRps7iuthOVxUsNgOYUS9w==
X-Received: by 2002:a17:902:c40e:b0:1bd:bba1:be7e with SMTP id k14-20020a170902c40e00b001bdbba1be7emr198403plk.52.1692137933645;
        Tue, 15 Aug 2023 15:18:53 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm10061079plb.265.2023.08.15.15.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:18:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2] man: remove old kernel references from ip route man page
Date: Tue, 15 Aug 2023 15:18:43 -0700
Message-Id: <20230815221843.8390-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is less confusing if the ip route man page does not
include references to no longer supported kernels.
Kernels before 4.4 are end of life and we don't need
to keep caveats in documentation for them.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/ip-route.8.in | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 7a97d7447c6d..ce448efb0a12 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -334,7 +334,7 @@ to real (or internal) ones before forwarding. The addresses to translate to
 are selected with the attribute
 .BR "via" .
 .B Warning:
-Route NAT is no longer supported in Linux 2.6.
+Route NAT is no longer supported.
 
 .sp
 .B anycast
@@ -511,43 +511,43 @@ seconds and ms, msec or msecs to specify milliseconds.
 
 
 .TP
-.BI rttvar " TIME " "(Linux 2.3.15+ only)"
+.BI rttvar " TIME "
 the initial RTT variance estimate. Values are specified as with
 .BI rtt
 above.
 
 .TP
-.BI rto_min " TIME " "(Linux 2.6.23+ only)"
+.BI rto_min " TIME "
 the minimum TCP Retransmission TimeOut to use when communicating with this
 destination. Values are specified as with
 .BI rtt
 above.
 
 .TP
-.BI ssthresh " NUMBER " "(Linux 2.3.15+ only)"
+.BI ssthresh " NUMBER "
 an estimate for the initial slow start threshold.
 
 .TP
-.BI cwnd " NUMBER " "(Linux 2.3.15+ only)"
+.BI cwnd " NUMBER "
 the clamp for congestion window. It is ignored if the
 .B lock
 flag is not used.
 
 .TP
-.BI initcwnd " NUMBER " "(Linux 2.5.70+ only)"
+.BI initcwnd " NUMBER "
 the initial congestion window size for connections to this destination.
 Actual window size is this value multiplied by the MSS
 (``Maximal Segment Size'') for same connection. The default is
 zero, meaning to use the values specified in RFC2414.
 
 .TP
-.BI initrwnd " NUMBER " "(Linux 2.6.33+ only)"
+.BI initrwnd " NUMBER "
 the initial receive window size for connections to this destination.
 Actual window size is this value multiplied by the MSS of the connection.
 The default value is zero, meaning to use Slow Start value.
 
 .TP
-.BI features " FEATURES " (Linux 3.18+ only)
+.BI features " FEATURES "
 Enable or disable per-route features. Only available feature at this
 time is
 .B ecn
@@ -559,17 +559,17 @@ also be used even if the
 sysctl is set to 0.
 
 .TP
-.BI quickack " BOOL " "(Linux 3.11+ only)"
+.BI quickack " BOOL "
 Enable or disable quick ack for connections to this destination.
 
 .TP
-.BI fastopen_no_cookie " BOOL " "(Linux 4.15+ only)"
+.BI fastopen_no_cookie " BOOL "
 Enable TCP Fastopen without a cookie for connections to this destination.
 
 .TP
-.BI congctl " NAME " "(Linux 3.20+ only)"
+.BI congctl " NAME "
 .TP
-.BI "congctl lock" " NAME " "(Linux 3.20+ only)"
+.BI "congctl lock" " NAME "
 Sets a specific TCP congestion control algorithm only for a given destination.
 If not specified, Linux keeps the current global default TCP congestion control
 algorithm, or the one set from the application. If the modifier
@@ -582,14 +582,14 @@ control algorithm for that destination, thus it will be enforced/guaranteed to
 use the proposed algorithm.
 
 .TP
-.BI advmss " NUMBER " "(Linux 2.3.15+ only)"
+.BI advmss " NUMBER "
 the MSS ('Maximal Segment Size') to advertise to these
 destinations when establishing TCP connections. If it is not given,
 Linux uses a default value calculated from the first hop device MTU.
 (If the path to these destination is asymmetric, this guess may be wrong.)
 
 .TP
-.BI reordering " NUMBER " "(Linux 2.3.15+ only)"
+.BI reordering " NUMBER "
 Maximal reordering on the path to this destination.
 If it is not given, Linux uses the value selected with
 .B sysctl
@@ -852,7 +852,7 @@ Three counters are implemented: 1) packets correctly processed;
 2) bytes correctly processed; 3) packets that cause a processing error
 (i.e., missing SID List, wrong SID List, etc). To retrieve the counters
 related to an action use the \fB-s\fR flag in the \fBshow\fR command.
-The following actions are currently supported (\fBLinux 4.14+ only\fR).
+The following actions are currently supported:
 .in +2
 
 .BR End " [ " flavors
@@ -1060,7 +1060,7 @@ mode.
 .in -8
 
 .TP
-.BI expires " TIME " "(Linux 4.4+ only)"
+.BI expires " TIME "
 the route will be deleted after the expires time.
 .B Only
 support IPv6 at present.
@@ -1346,10 +1346,10 @@ already exist in the table will be ignored.
 .RE
 
 .SH NOTES
-Starting with Linux kernel version 3.6, there is no routing cache for IPv4
-anymore. Hence
+There is no routing cache for IPv4 in current Linux kernels.
+Hence
 .B "ip route show cached"
-will never print any entries on systems with this or newer kernel versions.
+will never print any IPv4 entries.
 
 .SH EXAMPLES
 .PP
-- 
2.39.2


