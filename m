Return-Path: <netdev+bounces-251939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EVQD873cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:59:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F84659943
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FF38A4C43D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A3A4C0431;
	Wed, 21 Jan 2026 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UODvhtRk"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4123A7F58;
	Wed, 21 Jan 2026 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006104; cv=none; b=oIyV7/VKs+fnxudjjJGaoW/bHjtbddsGCB804SZ5mpm2+xqXOYPgw6eSpGG/sYaBOL8WsQGM4XbEm8v3jYHShTmFUKLXttXIwZaOqHp84nEnOMn8Kg2vqvFc8MwoB5c8hme1a5KInHf/5I2QpgObc9sMC8Wj3ncX8JlLSizSdiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006104; c=relaxed/simple;
	bh=4kTJcLmYGzRCj4IKX4oNLKlCTvwFwEiSzIa5dY7keno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psBlANAyqCPb/+Tdqsl2AVXmVE6w+MKuWliRgxREuhSvngff5IC109sAVer3oF7p50vErnffY6fkmQiLpSH/tn1rm/rIMVRf9eKAVRineXLazAx3eEWPI5tRdpyDuec4jeEIBAGyLIQXz4YiRFiyvjp1H4fB4CmvNabyZA2JdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UODvhtRk; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769006102; x=1800542102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0rhk6SMiUX4DX71gJT40pzZWSzRz9RPlP3yDXcP1Qj8=;
  b=UODvhtRk1GDZ5HXknWzBcUVt8lmZmP7r1Ik16hBfUU6OWkL3a/euCWsq
   o9e4e/rty55mMNAGSW7AVsjvkaCWE64yZhdjnVOosf8/NlnSjMzgsQgwq
   c5lo40zq+FeGCb3JU52gKNYFoPvZxkPpJPFRC7KHTskyb08f+dvguifVf
   7AlV6m2NER6HhDol3QqA0fUx2YdLs4dsqnzcZQI4fd/dsG4MJnx+RS5Bk
   o+HM++5DInuWMITDfrkwTVkcTRTWqTm/xXaAfHe2dhbhXPn05YqrW192p
   JPc4Zq6GKr0MX1TEpO3z2lZkSCAJiLVSBzHdWUx34m7LPxql3m0CMYNv5
   g==;
X-CSE-ConnectionGUID: XfwFkXjbQFi3pm5sENoVEA==
X-CSE-MsgGUID: +/0dyjK6QTuQ7fAQU9OwOg==
X-IronPort-AV: E=Sophos;i="6.21,242,1763424000"; 
   d="scan'208";a="11093535"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:35:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:18279]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.244:2525] with esmtp (Farcaster)
 id 40835c61-feff-4f8f-89b1-4b3d3f82deb9; Wed, 21 Jan 2026 14:35:02 +0000 (UTC)
X-Farcaster-Flow-ID: 40835c61-feff-4f8f-89b1-4b3d3f82deb9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:35:00 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:57 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <dwmw2@infradead.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.co.uk>
Subject: [PATCH v6 7/7] ptp: ptp_vmclock: return TAI not UTC
Date: Wed, 21 Jan 2026 14:33:44 +0000
Message-ID: <20260121143402.3092-8-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121143402.3092-1-itazur@amazon.com>
References: <20260121143402.3092-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-5.96 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251939-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,infradead.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[itazur@amazon.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[amazon.com,quarantine];
	DKIM_TRACE(0.00)[amazon.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,amazon.co.uk:email,amazon.es:email];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9F84659943
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

To output UTC would involve complex calculations about whether the time
elapsed since the reference time has crossed the end of the month when
a leap second takes effect. I've prototyped that, but it made me sad.

Much better to report TAI, which is what PHCs should do anyway.
And much much simpler.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 drivers/ptp/ptp_vmclock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 55ec3cda3995..6cf63a86c997 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -83,13 +83,13 @@ static uint64_t mul_u64_u64_shr_add_u64(uint64_t *res_hi, uint64_t delta,
 
 static bool tai_adjust(struct vmclock_abi *clk, uint64_t *sec)
 {
-	if (likely(clk->time_type == VMCLOCK_TIME_UTC))
+	if (clk->time_type == VMCLOCK_TIME_TAI)
 		return true;
 
-	if (clk->time_type == VMCLOCK_TIME_TAI &&
+	if (clk->time_type == VMCLOCK_TIME_UTC &&
 	    (le64_to_cpu(clk->flags) & VMCLOCK_FLAG_TAI_OFFSET_VALID)) {
 		if (sec)
-			*sec += (int16_t)le16_to_cpu(clk->tai_offset_sec);
+			*sec -= (int16_t)le16_to_cpu(clk->tai_offset_sec);
 		return true;
 	}
 	return false;
@@ -350,9 +350,9 @@ static struct ptp_clock *vmclock_ptp_register(struct device *dev,
 		return NULL;
 	}
 
-	/* Only UTC, or TAI with offset */
+	/* Accept TAI directly, or UTC with valid offset for conversion to TAI */
 	if (!tai_adjust(st->clk, NULL)) {
-		dev_info(dev, "vmclock does not provide unambiguous UTC\n");
+		dev_info(dev, "vmclock does not provide unambiguous time\n");
 		return NULL;
 	}
 
-- 
2.47.3


