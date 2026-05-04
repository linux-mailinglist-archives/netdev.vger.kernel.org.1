Return-Path: <netdev+bounces-283904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLf5KMyz+GmWzAIAu9opvQ
	(envelope-from <netdev+bounces-283904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:57:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4702C4C041A
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EF54302C825
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE7C3DFC93;
	Mon,  4 May 2026 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JFv78a2P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED843E0227
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906432; cv=none; b=f1gXpq2OOFj0k96G9lRFu4kRzVyvt8avgTS32T7HTw98nbmnqxsWcyYex9lgmNh5pVUE/VjhvrFWh8pIJfMgCNdfn0PgW9M4uMDLK3RW3KcMcaTThfpW9iNLogpyGWwsne24e+2x705q/1S/bUeGN4ZPdhBCnFxlyupeWQBXqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906432; c=relaxed/simple;
	bh=NHQizhHkJFek9eWTi5oYmtlX7dFb8feNSqydNnqPYoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hej1BdtzjtW0hPIprYmBIWlIn6MHUx507IjOICGrRUQB3JpMxaIUaqhFGSmBrrsNLxzzsDT70ouqbY+t68B0NkCX1c8u6UhJXsS+jVtKOmnp2ie1Obk9d+nYYW55Je6xiLIfsTd70lUEHuEvNjc7iMdH7qz/M9iTdIN8DnyQxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JFv78a2P; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-60f9604d76aso188431137.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906430; x=1778511230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHQizhHkJFek9eWTi5oYmtlX7dFb8feNSqydNnqPYoo=;
        b=FCI3CSNXaERsDKlqGMwjhgOqOcACj8ipEmB8rklADoysWJq/NHmP4LzZ9H8DnzFHAU
         /RJT9VmYNeC2PMyy8wlKmp1MEicRbZqX96drRUYzwh60vbRBWhZKt2lq/ZJUNonE0tAJ
         JRhoWEwIu6LyDAm3uHO/4Lad1VCI8exvhdIOCRPLAKCSyp1ZwE/Zeg8OtTOxxBuAgIJ5
         SAZdp2Ub9r67d56Oy8S0/dau+I3OZGmUiYKDcsCs/gdA8CyFpe54reRZOi6ucleZNEpQ
         1pUXrH2EV3KqUDaZ7cU8ZwRgF/unbECBQt76vEYrxi8tJW1qZuk2lUafXXaDh4TdsSXq
         bmiw==
X-Forwarded-Encrypted: i=1; AFNElJ+d5/G9IqSaEzBIEeh2TLfGicVEUYKQMVAxAJpbjxtd/pW3S3FIePwDmzTNWmipMir4yeL9t00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSIYgQZ8xUkAOvuD1v5m1UwM4Mbc1NLH7X31UprtnC70lPK90
	rZN1kanUc6qgoVhImCJLW1ZQKauVH0BZxamimE6cQxSJoZm/ajeGjVGTI6/JXmxqkCFmEaBVCYl
	lqntttjGMfETfJmJiSplr8Afqaeg0Vs/cvCAdWwvPZkV7SWOzuPCmIovs+Nmv1MsxhIW7lLYL4L
	ZsViRc3ZoyoTnoH8Ok65QXn9Iu/tziMIRQvKlQoFYLJToezBGD6rUG/sCyLf/GYznBQvK3J9qda
	aiZPJBm8+StwN0=
X-Gm-Gg: AeBDieuTFOnzoQqgRR7k2FL3tRDej2pHrnxq1MN5Z/w+R7OBdmkfR5X/6M9XCcp6Wx+
	na5qS6zJDdKmODhvvlrfHZGwf0sUYj0p7KUIas8tvTBiHS8EqOqQO1JNxuovPQrGbfIBG/HZvr1
	b4TUHO0/+DKX8YLnTFEj7ZsvWY4/iLRJ7dx84NVege5nIPBLAHLRPEkfr3Nfkxpxdacwbajhlu/
	aDhjMoLt4i0uNSVlylSL5Z6eQhxn6jYHFf7QuoUMO2m8tmGpbJ1/Rh2hVnVoL71eP7WZdm1pOZd
	5Wo/CTLby5De2bNxoqEZLqYwUw91QMaWi8AA4sAIezDvymE08LBGHusGBNfIwKC/nKqgS4k+5Bv
	QQFyhaTudD+qoZqheofUMqRxar02+hKi5gCv9tI3X39Ri931GGqARxysVYP/aMwNdnN8qwrcIAv
	cA3q3Rkqm8frpfy0MbTHgGsQd4Bp6BSvMdpHpn+SI0C0U/vYE/EMk1Jhc3XhrCPx8nrWuJ
X-Received: by 2002:a05:6102:5e2:b0:62e:7aac:cc57 with SMTP id ada2fe7eead31-62e7aaccd3dmr924078137.3.1777906430139;
        Mon, 04 May 2026 07:53:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-62f37a91d36sm224709137.11.2026.05.04.07.53.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 07:53:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb39de5c54so59400585a.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777906429; x=1778511229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHQizhHkJFek9eWTi5oYmtlX7dFb8feNSqydNnqPYoo=;
        b=JFv78a2PpDkIaHme3ck10Nit/5VwzBWCjaZgNBbnVbjs+P61VvgvHWjklObHY5UsXP
         i0nRUt78bmjxNx1Wy5lNmBPGn8oYv+YjWcVVDPl1gra+6aZA7bnhkr96igmKS9128Ukx
         yzBuQbAVxgj1+hMhr5/9md8y3eDeVzbaF6zgI=
X-Forwarded-Encrypted: i=1; AFNElJ9CXxAgK29FfiI5X17oUz5C6e+humhc5DsIL4ZI52ZYqK1mIK3/eVlImkWjCLGSznvFPP+MAJA=@vger.kernel.org
X-Received: by 2002:a05:620a:404d:b0:8ef:2118:aecd with SMTP id af79cd13be357-8fd127b737dmr1008301385a.0.1777906429094;
        Mon, 04 May 2026 07:53:49 -0700 (PDT)
X-Received: by 2002:a05:620a:404d:b0:8ef:2118:aecd with SMTP id af79cd13be357-8fd127b737dmr1008297585a.0.1777906428521;
        Mon, 04 May 2026 07:53:48 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91fb3bsm1046315985a.41.2026.05.04.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:53:48 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Ankit Jain <ankit-aj.jain@broadcom.com>
Subject: [PATCH net v2 2/2] selftests/net: add packetdrill test for locked SO_RCVBUF SWS
Date: Mon,  4 May 2026 14:49:45 +0000
Message-ID: <20260504144945.13477-3-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504144945.13477-1-ankit-aj.jain@broadcom.com>
References: <20260504144945.13477-1-ankit-aj.jain@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 4702C4C041A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283904-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Add a packetdrill test to verify that TCP does not aggressively penalize
the `scaling_ratio` when an application explicitly locks the receive
buffer via SO_RCVBUF.

This test establishes a connection with a very small MSS, then injects
small payloads. On buggy kernels, the payload-to-truesize memory penalty
drops the `scaling_ratio` to 1, which shrinks the dynamically calculated
window and causes Silly Window Syndrome (SWS).

The test asserts that `tcpi_rcv_ssthresh` (the exposed window clamp)
remains protected and stays at a healthy level.

Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
---
 .../net/packetdrill/tcp_locked_rcvbuf_sws.pkt | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt b/tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt
new file mode 100644
index 000000000000..96d3a0813548
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_locked_rcvbuf_sws.pkt
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test that TCP does not apply aggressive truesize penalties
+// to the scaling_ratio when the application has explicitly locked
+// the receive buffer, preventing Silly Window Syndrome.
+
+// 1. Create a socket and lock SO_RCVBUF to 32K
+0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [32768], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
+// 2. Establish connection with a TINY MSS (48 bytes)
+// This forces the kernel's rcv_mss expectation to initialize at rock bottom.
++0 < S 0:0(0) win 65535 <mss 48,nop,wscale 8>
++0 > S. 0:0(0) ack 1 <...>
++0 < . 1:1(0) ack 1 win 65535
++0 accept(3, ..., ...) = 4
+
+// 3. Inject 100 bytes.
+// 100 is > 48, so this forces tcp_measure_rcv_mss() to recalculate the scaling ratio.
+// Because the payload (100B) is small compared to the sk_buff truesize,
+// kernels without the fix will incorrectly drop the scaling_ratio.
++0.1 < P. 1:101(100) ack 1 win 65535
++0 > . 1:1(0) ack 101 <...>
+
+// 4. Inject 110 bytes to bypass the length jitter optimization and force
+// a second recalculation, driving the scaling_ratio to 1 and crushing the clamp.
++0.1 < P. 101:211(110) ack 1 win 65535
++0 > . 1:1(0) ack 211 <...>
+
+// 5. Assert the window clamp (tcpi_rcv_ssthresh) is protected from the penalty.
++0.1 %{
+assert tcpi_rcv_ssthresh > 15000, f"BUG DETECTED: scaling_ratio crushed! rcv_ssthresh={tcpi_rcv_ssthresh}"
+}%
--
2.53.0


