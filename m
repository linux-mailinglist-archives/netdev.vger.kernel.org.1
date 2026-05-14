Return-Path: <netdev+bounces-288014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEfjAMDhBWqNdAIAu9opvQ
	(envelope-from <netdev+bounces-288014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E31B543837
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 988DD302AB7A
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC4F426EB2;
	Thu, 14 May 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="AaHT7Bd3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FE3AF664
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770099; cv=none; b=eV7huIfwAyCMtMsIaIK6hTAKAcGYCNnv1wKwvBeuwKS0xijLfQZOfTg13nP5SqfyLaFRoehC7em7HFFMygepPdl+N7R+m/Kn8wlTsqVe75jMTNsVSxmMj1PZdSPpMMgMJQs2ABcDoOMRS1yzGY/s+NCDM/FjRa0DEySxrCH33Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770099; c=relaxed/simple;
	bh=oyCK9Z0+mkp7gFkxWWn/84Ve4UaDyjypWlcWE7Ps/Pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iHjujXMtgBAXxYr3KRi6VkZIpbees2EfmoUI7GRdrwTqBehwdU1UgUqrwsXwa70u01ls6YsLRP68yBPqqy9LMtJwDZ+CPNgI7w22161qKD6f2IcmeE9EQ12DqsCLJuQxD8WFPaxPQRXVKwxRhrCj5qJu+vj7/Ig5LOXcY/nb/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=AaHT7Bd3; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d87610513so78022811cf.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778770093; x=1779374893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+/2TqOomNU4bUuQ41PSMNs66yR4SqXjNT1yAFXc6Ck=;
        b=AaHT7Bd35TNLdd74cmD/4lqN7mwNvC82PMCGneYs2d1FIRp3xAB37aknkktFOBY01J
         xEMVGnUEvqRCeRT2aQz6ff/QXnY80DlxZJkKMFBr/lWNRp1Yh4hG1SKN8WpWJa5e8+KP
         3QhoorGH0pZc3ldz7XJ62ISa4lhb/EBqhgpJdV+EZXSIOS3KvUm+wfvYvjiadYSJrBGs
         kxdQa1Q31Y2os0S+O/njX+2Xin/vmynRadZqbBrigFwObviwf9O0P7IuSDVqxdnAFXnV
         BHGOSeMoCJzLmlap36F+h5xlovCPS8aXGD3do7jVU21vGYmv4diCX9tmG/9Cx0/+bx44
         q0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770093; x=1779374893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+/2TqOomNU4bUuQ41PSMNs66yR4SqXjNT1yAFXc6Ck=;
        b=PmPIhxUgNv+QNtgqLzXbxvkSweJjU8JOMLvtYtef1CsdSA2DFmfzYHhI1zfg1x6nKQ
         uwyCubsFbK1QR3Dv9oQG5Hl6iqbqIL65CvBzHpfoCCWtKQ4rOt3oJ/hcRuSA0xADAdsE
         2VIZBff0jRKK7uN83tfTnnxe3QQa8KFrsrz4+8xVmdEAxxE/VjhwCar0+0oY9GJo6KqR
         QpZ5mRsplvjXUoFBSi6iBpo6NBADIbPVkWrcALT9F2tMPcMyTOya+9fl6oQ27vDDqyWM
         Uesj7AQk/oKelDXIz0zKD27r33iom8aGuuCzPYGC0kHk3cahQPRkkycDfq92AAdDwpHM
         KJkg==
X-Gm-Message-State: AOJu0YzfnzOQGG+wN4ULHraiW/Z9Un4Oid+Sr4LsjsIo2A0H86Lp0ATG
	wG+wP8NA9dvxQ7lBbIyUVpn+yhDBBVM3AL3NlvjrWauDoSDxrA5/NnncqckOIL4NKGLUwFNw+KJ
	FzfcUWw==
X-Gm-Gg: Acq92OGRx/N5w5H6IKBefzoidlNYX+ThTkJEoKZt+3bM0SF3/j+Nax8aJXxv5Q9vghV
	97reb6Ks1KltVNyO3ZFZqY6rBlEkzb8NBXPgXvMSmAUpisA56FHa6F581ns3OPEsLqsV4vQDUyE
	3IhTpDxAGYGu75XdEwscAvQIelT+Gt3uG1P7OA7r6mC4fBgTggS9encQsEMOFgZRAyg6jrUiRAR
	8NxX75EuFP48998zbOrUAMk2odq6+0fSNL3R6f4d5BMFEMOxD8ke8rzjhxFkeClwbpIKJUrykcF
	0A4VsdimH6WmGH+BUpHaCSzv6e2SQWPaa8YWOXdICDie7yBxBtmSodsP4VtOXiXlWloVBV3tk5V
	MFhg+l/B4CnHj8ZEXHpC509I1TP6Jd/cr97XvKyOjpci9u9XsHXD6OW5Y/fJ/dO+PF6JcLjQTyQ
	+ulY31jSJZy2i8z/ICqzh5BQ8KkeU=
X-Received: by 2002:a05:622a:511:b0:50f:ccdd:13f1 with SMTP id d75a77b69052e-5162fe5b853mr107212801cf.16.1778770093392;
        Thu, 14 May 2026 07:48:13 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm19125461cf.10.2026.05.14.07.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:48:12 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	savy@syst3mfailure.io,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	hxzene@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v5 8/9] selftests/tc-testing: Add mirred test cases exercising loops
Date: Thu, 14 May 2026 10:47:46 -0400
Message-Id: <20260514144747.527175-9-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514144747.527175-1-jhs@mojatatu.com>
References: <20260514144747.527175-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E31B543837
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288014-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,mojatatu.com:email,mojatatu.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Action: no action

From: Victor Nogueira <victor@mojatatu.com>

Add mirred loop test cases to validate that those will be caught and other
test cases that were previously misinterpreted as loops by mirred.

This commit adds 12 test cases:

- Redirect multiport: dummy egress -> dev1 ingress -> dummy egress (Loop)
- Redirect singleport: dev1 ingress -> dev1 egress -> dev1 ingress (Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dev1 egress (No Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dev1 ingress (Loop)
- Redirect multiport: dev1 ingress -> dummy egress -> dev1 ingress (Loop)
- Redirect multiport: dummy egress -> dev1 ingress -> dummy egress, different prios (Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress -> dev1 egress (No Loop)
- Redirect multiport: dev1 ingress -> dummy egress -> dev1 egress (No Loop)
- Redirect multiport: dev1 ingress -> dummy egress -> dummy ingress (No Loop)
- Redirect singleport: dev1 ingress -> dev1 ingress (Loop)
- Redirect singleport: dummy egress -> dummy ingress (No Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress (No Loop)

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
 1 file changed, 615 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index b056eb966871..d0cad6571691 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -1144,6 +1144,620 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY clsact"
         ]
+    },
+    {
+        "id": "531c",
+        "name": "Redirect multiport: dummy egress -> dev1 ingress -> dummy egress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 10 matchall action mirred ingress redirect dev $DEV1 index 1",
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 2"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact",
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "b1d7",
+        "name": "Redirect singleport: dev1 ingress -> dev1 egress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DEV1 index 1"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 egress protocol ip prio 11 matchall action mirred ingress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "c66d",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dev1 egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred egress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "aa99",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred ingress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 2,
+                            "overlimits": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "37d7",
+        "name": "Redirect multiport: dev1 ingress -> dummy egress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred ingress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "6d02",
+        "name": "Redirect multiport: dummy egress -> dev1 ingress -> dummy egress, different prios (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 10 matchall action mirred ingress redirect dev $DEV1 index 1",
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 11 matchall action mirred egress redirect dev $DUMMY index 2"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact",
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "8115",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress -> dev1 egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred egress redirect dev $DUMMY index 2"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 12 matchall action mirred egress redirect dev $DEV1 index 3",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "9eb3",
+        "name": "Redirect multiport: dev1 ingress -> dummy egress -> dev1 egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred egress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "d837",
+        "name": "Redirect multiport: dev1 ingress -> dummy egress -> dummy ingress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred ingress redirect dev $DUMMY index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "2071",
+        "name": "Redirect singleport: dev1 ingress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DEV1 index 1",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1,
+                            "overlimits": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "0101",
+        "name": "Redirect singleport: dummy egress -> dummy ingress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred ingress redirect dev $DUMMY index 1"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "cf97",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred egress redirect dev $DUMMY index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
     }
-
 ]
-- 
2.34.1


