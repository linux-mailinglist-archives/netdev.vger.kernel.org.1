Return-Path: <netdev+bounces-282002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB7HFcfq8GmBbAEAu9opvQ
	(envelope-from <netdev+bounces-282002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:13:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EBE489B63
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D751C30F35F0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18D233D6D6;
	Tue, 28 Apr 2026 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FZz8Do6k"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316933BBB1
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395503; cv=none; b=epyo5dzxMauASlnH9jCc7V97DZTmYjLqVTReH8blJMq5BIE/qTqC/FGoMobLXRVMls99vUTi+MiIqE3wulNg/9rLhDdxYRQX+HYmXped4Z02rDUDJPxsTN4NFInZNRyE+v6K0hVxjVZhNQ9uM3yPhPtQgrkUG458iYZjpMoPO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395503; c=relaxed/simple;
	bh=/dTpzmkZyWHnlgGcUYC/4QWQzSm362ukIfQOXyZRdTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nw1F/Zvuebo2r6Jgw/dNwFkSGYkxo8b6eaSRr+u0+3bBcQweu7FpgG7eHrQYdp1/v6w22r8kSfHmJ6b02tS7KsAjKtG56jPKYHtrNID+C9zKf52hzP6CtpVdub9/nx/QM3NKlaARnWqBdevq8ALWmWcCvBHbgouUBU7M6BIFBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FZz8Do6k; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777395502; x=1808931502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fWOAAnFub8AMT7FdRtKJc/Hk8Pxdbj6VVKcyAdlo/Ys=;
  b=FZz8Do6kGlE3f1IhA2XU0OCwzonfMTG45BDbV2TU13/8xnHsVDKpY9GN
   jNhM5jUXay4dmzU3WaMmVc9NuuIhVaPfL3TiAX89Qy4hTST3Klgm+A1ky
   gLO67NXjBFLlJgTfMrOkcVW2w/dgiKJig7BJPNspiZLSEwpmuDAK+h6ie
   PPlNTUObw0hsR40CM4EoJHEL7FkeucTj3gG7MGMlp+9ZfXRwgE6SzzsT1
   Uq6kEtpCbtpgwx0hM4Gtwwf1o6HXJsgjrW+b5QTrrm6p5qBi1XJak+W+G
   ToA0qPywE0HEpXaygk0v08pB772+yV1Ycg8zS5SzrOfhklKEsPi9VGKR9
   w==;
X-CSE-ConnectionGUID: zCmlRBNnRBCGrZkAs59Dnw==
X-CSE-MsgGUID: VBK5E5yHRbOjMSJR0C5Icw==
X-IronPort-AV: E=Sophos;i="6.23,204,1770595200"; 
   d="scan'208";a="18410142"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 16:58:22 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:12642]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.10:2525] with esmtp (Farcaster)
 id 59a506eb-9b85-483e-a5dd-8d8f269e7c42; Tue, 28 Apr 2026 16:58:22 +0000 (UTC)
X-Farcaster-Flow-ID: 59a506eb-9b85-483e-a5dd-8d8f269e7c42
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:20 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 28 Apr 2026 16:58:16 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, "Woodhouse, David" <dwmw@amazon.com>, "Sarna,
 Yonatan" <ysarna@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>
Subject: [PATCH net-next 2/8] selftests/ptp: Extract print_system_timestamp helper in testptp
Date: Tue, 28 Apr 2026 16:54:20 +0000
Message-ID: <20260428165659.2811-3-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428165659.2811-1-akiyano@amazon.com>
References: <20260428165659.2811-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: C0EBE489B63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282002-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Extract the repeated switch-on-clockid pattern used for printing
system timestamps into a reusable helper function. This removes
code duplication in the -x (PTP_SYS_OFFSET_EXTENDED) output path
and prepares for additional callers.

No functional change.

Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 tools/testing/selftests/ptp/testptp.c | 70 ++++++++++++---------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index ed1e288..d3bcfd0 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -153,6 +153,28 @@ static void usage(char *progname)
 		progname, PTP_MAX_SAMPLES);
 }
 
+static void print_system_timestamp(int sample_num, __kernel_clockid_t clockid,
+				   long long sec, unsigned int nsec,
+				   const char *when)
+{
+	switch (clockid) {
+	case CLOCK_REALTIME:
+		printf("sample #%2d: real time %s: %lld.%09u\n",
+		       sample_num, when, sec, nsec);
+		break;
+	case CLOCK_MONOTONIC:
+		printf("sample #%2d: monotonic time %s: %lld.%09u\n",
+		       sample_num, when, sec, nsec);
+		break;
+	case CLOCK_MONOTONIC_RAW:
+		printf("sample #%2d: monotonic-raw time %s: %lld.%09u\n",
+		       sample_num, when, sec, nsec);
+		break;
+	default:
+		break;
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	struct ptp_clock_caps caps;
@@ -608,46 +630,18 @@ int main(int argc, char *argv[])
 			       getextended);
 
 			for (i = 0; i < getextended; i++) {
-				switch (ext_clockid) {
-				case CLOCK_REALTIME:
-					printf("sample #%2d: real time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				case CLOCK_MONOTONIC:
-					printf("sample #%2d: monotonic time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				case CLOCK_MONOTONIC_RAW:
-					printf("sample #%2d: monotonic-raw time before: %lld.%09u\n",
-					       i, soe->ts[i][0].sec,
-					       soe->ts[i][0].nsec);
-					break;
-				default:
-					break;
-				}
+				print_system_timestamp(i, ext_clockid,
+						       soe->ts[i][0].sec,
+						       soe->ts[i][0].nsec,
+						       "before");
+
 				printf("            phc time: %lld.%09u\n",
 				       soe->ts[i][1].sec, soe->ts[i][1].nsec);
-				switch (ext_clockid) {
-				case CLOCK_REALTIME:
-					printf("            real time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				case CLOCK_MONOTONIC:
-					printf("            monotonic time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				case CLOCK_MONOTONIC_RAW:
-					printf("            monotonic-raw time after: %lld.%09u\n",
-					       soe->ts[i][2].sec,
-					       soe->ts[i][2].nsec);
-					break;
-				default:
-					break;
-				}
+
+				print_system_timestamp(i, ext_clockid,
+						       soe->ts[i][2].sec,
+						       soe->ts[i][2].nsec,
+						       "after");
 			}
 		}
 
-- 
2.47.3


