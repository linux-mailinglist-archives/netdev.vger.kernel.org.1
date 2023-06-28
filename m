Return-Path: <netdev+bounces-14410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F27740BD4
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 10:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5C12811C9
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D967474;
	Wed, 28 Jun 2023 08:51:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2557EA
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 08:51:21 +0000 (UTC)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFB9F0
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 01:51:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6687466137bso3171170b3a.0
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saviah-com.20221208.gappssmtp.com; s=20221208; t=1687942279; x=1690534279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vZJ9KZ0nORDwUa8rVOPplQDUftdsKPRXoJD7pWWR6w=;
        b=ZOr18CgDS7iAPXjfKCD67Vd6O0PRJdvitrvl6bv2E6OPbSWSPfkpB8RjenKKMW3YaE
         OPaqIY68K4uurf/0ymdUsafRkohJGtySAizEuFBzl9ncZ4EDUpi8sXlS9NQspqTk8vYD
         69xt4u1xbIEU/Pktj/oxLY6Qg9uwa1fvKWRRNb5dEusy02xqbcXZhH+2Ar4oN+yrZhqX
         Zi3XFRUTxdN3w+fVhzPl//0aexBxB9nJJB45+LWUNAi7KDY0D5/6H1CPKUdvx9U3EazA
         gfebVRKc9fCsfRRqfnrNlfs4WXDYMGWf9rJnnF/Q7n4ZIEFXXTMOqfS0qyR0chicbW8a
         hnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687942279; x=1690534279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vZJ9KZ0nORDwUa8rVOPplQDUftdsKPRXoJD7pWWR6w=;
        b=b7x/1+iir3EvnkRuwYgtpDOIjlqtFJqDN68cMNuUW5V/3e5z7YKdKgM+Phtpb9o17F
         kt/Qgg4IMx/k/F+/ZhJrYtjfIgaTU54UK1E6/CSvqYs2ubWuoHDNXcWrnAzWtV5TBGui
         PqDXbcIDZJdfUTQk7kM4osY+tS8oIIikR/oH1my3MhSU8ly1TRygLSYz1poKwP/YXw7V
         GeuOSIb8VgUCALm2yoo2u3qXaVGXDBOLzayT9ZS8OjcqPaZZwZy+lzQYHkNvSEN3tum1
         kFdR6aoy5t5/57GrDVSs9mDH+/ySgbt7AE4BIkP7XxZxfQcYZnuo+OKyA/U2414X5Xov
         3ZvA==
X-Gm-Message-State: AC+VfDx7DvHqt/WEx4uYyoI63EPB9OoacF+gB8WG2Ujgj0Fmn/Wz7NaA
	GGbyY5X9Kt/yt98T4IqW0x6kXA==
X-Google-Smtp-Source: ACHHUZ5XIlLdxi7pC8cJXFTN1+imiG3XKOQHdumh9hhxiPOzklzqNxuEyCBs6PfPRxTMRrODCAqglw==
X-Received: by 2002:a05:6a20:914a:b0:10b:8e96:561 with SMTP id x10-20020a056a20914a00b0010b8e960561mr26391135pzc.62.1687942279331;
        Wed, 28 Jun 2023 01:51:19 -0700 (PDT)
Received: from localhost.localdomain (NCTU-Wireless-NAT220.nctu.edu.tw. [140.113.136.220])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001b80e07989csm4244899plb.200.2023.06.28.01.51.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2023 01:51:18 -0700 (PDT)
From: Ian Chen <yi.chen@saviah.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Chen <yi.chen@saviah.com>
Subject: [PATCH] Documentation: networking: add UPF (User Plane Function in 5GC) description
Date: Wed, 28 Jun 2023 16:50:49 +0800
Message-Id: <20230628085049.83803-1-yi.chen@saviah.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the content of User Plnae Function (UPF),
which was defined in 3GPP specifications since release 15.

Signed-off-by: Ian Chen <yi.chen@saviah.com>
---
 Documentation/networking/gtp.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/gtp.rst b/Documentation/networking/gtp.rst
index 9a7835cc1..c02aa34c4 100644
--- a/Documentation/networking/gtp.rst
+++ b/Documentation/networking/gtp.rst
@@ -31,12 +31,12 @@ payload, such as LLC/SNDCP/RLC/MAC.
 
 At some network element inside the cellular operator infrastructure
 (SGSN in case of GPRS/EGPRS or classic UMTS, hNodeB in case of a 3G
-femtocell, eNodeB in case of 4G/LTE), the cellular protocol stacking
+femtocell, eNodeB in case of 4G/LTE, gNobeB in case of 5G), the cellular protocol stacking
 is translated into GTP *without breaking the end-to-end tunnel*.  So
 intermediate nodes just perform some specific relay function.
 
-At some point the GTP packet ends up on the so-called GGSN (GSM/UMTS)
-or P-GW (LTE), which terminates the tunnel, decapsulates the packet
+At some point the GTP packet ends up on the so-called GGSN (GSM/UMTS),
+P-GW (LTE), or UPF (5G), which terminates the tunnel, decapsulates the packet
 and forwards it onto an external packet data network.  This can be
 public internet, but can also be any private IP network (or even
 theoretically some non-IP network like X.25).
@@ -60,7 +60,7 @@ payload, called GTP-U.  It does not implement the 'control plane',
 which is a signaling protocol used for establishment and teardown of
 GTP tunnels (GTP-C).
 
-So in order to have a working GGSN/P-GW setup, you will need a
+So in order to have a working GGSN/P-GW/UPF setup, you will need a
 userspace program that implements the GTP-C protocol and which then
 uses the netlink interface provided by the GTP-U module in the kernel
 to configure the kernel module.
@@ -162,7 +162,7 @@ Local GTP-U entity and tunnel identification
 GTP-U uses UDP for transporting PDU's. The receiving UDP port is 2152
 for GTPv1-U and 3386 for GTPv0-U.
 
-There is only one GTP-U entity (and therefore SGSN/GGSN/S-GW/PDN-GW
+There is only one GTP-U entity (and therefore SGSN/GGSN/S-GW/PDN-GW/UPF
 instance) per IP address. Tunnel Endpoint Identifier (TEID) are unique
 per GTP-U entity.
 
-- 
2.38.1


