Return-Path: <netdev+bounces-263438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENeBMpJYp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:54:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 509151F7CB6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86453309BBAE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897E14968E0;
	Tue,  3 Mar 2026 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSifjCNy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673BC492534
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574825; cv=none; b=WCzeYDZ0hNaC3pNIS555oRXtnMZ8Evn/juvUJ+MIxJSVUWYtgy0y6ITi3VASRla5n1kdi9Oy/+UxAI/NsHzvGF20TfaVI0c8bWNzJPPhgBa7LvjH3yHNnjcKaTevvyIzuePpAYDaXFk4/0ydrSyKnOR4mTsZrxJKgE5amlH6OeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574825; c=relaxed/simple;
	bh=sVzszHqOPrfpMfXFXpDZIMgd//OFtJeFvyqKzwQFsL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnS3VjiBpWDHuQLVT1/h9FXfz3ffHEeXaTRNMrXuv7mzP0coNuL0x63eGOgJJBKHR7bJjSmDorIH9WIXJoiPFyZYHdN35TwI+WqxDnKUrxBEuTA20i1HeDmK1tbtrF7pbNLvIAvkGmpXNNRpkjjVy3W1BHOYV4ary7naM5kyX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSifjCNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3230C2BC87;
	Tue,  3 Mar 2026 21:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574825;
	bh=sVzszHqOPrfpMfXFXpDZIMgd//OFtJeFvyqKzwQFsL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSifjCNy+nllmyfrmenpIEPsxHAudnjV/KfjVjEuKmrmHJBUiw+9WLKXlWWmsyOSz
	 IwzlLBU24DOitCrOWaJ+k/KQA413w+jmJh3ukT0b0JeRhMAfJX0bxXz7l8Lcs0Fg/O
	 rrsjcOBNBIA8B7ypUSz6SlPaxdgGDrT6jA2juYtAb7Z85ccAlMG4r8fM++dZ/+3Bx0
	 8so7Yb8kNknPDOXgvYewH9rJhfcx14MwqZrVm3/O9QaVhxv20SRHWXmGb4ckIEN0lA
	 P5dohrgKair0lNppqCU7DlV6fS4AVvFO8kF+Og+yXwlHj4RZT8zuITJ+cI/a0BGLmz
	 Hgoia0v8P+uQg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com
Subject: [PATCH net 04/11] MAINTAINERS: remove Salil Mehta from HiSilicon network drivers
Date: Tue,  3 Mar 2026 13:53:04 -0800
Message-ID: <20260303215339.2333548-5-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303215339.2333548-1-kuba@kernel.org>
References: <20260303215339.2333548-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 509151F7CB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263438-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email,lunn.ch:email,intel.com:email,arndb.de:email]
X-Rspamd-Action: no action

We have not seen tags from Salil for HiSilicon network drivers
in over 5 years. He is active upstream in other subsystems
(KVM/ARM64 vCPU hotplug). Jian Shen and Jijie Shao are active
in HNS3, and the review coverage is good (55%).

Subsystem HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
  Changes 69 / 125 (55%)
  Last activity: 2026-02-06
  Jian Shen <shenjian15@huawei.com>:
    Author 6d2f142b1e4b 2026-02-06 00:00:00 22
    Tags 6d2f142b1e4b 2026-02-06 00:00:00 26
  Salil Mehta <salil.mehta@huawei.com>:
  Jijie Shao <shaojijie@huawei.com>:
    Author 6a0fc0ea61bd 2026-01-27 00:00:00 19
    Tags 6d2f142b1e4b 2026-02-06 00:00:00 97
  Top reviewers:
    [30]: horms@kernel.org
    [12]: andrew@lunn.ch
    [10]: arnd@arndb.de
    [5]: michal.swiatkowski@linux.intel.com
    [4]: jacob.e.keller@intel.com
  INACTIVE MAINTAINER Salil Mehta <salil.mehta@huawei.com>

Subsystem HISILICON NETWORK SUBSYSTEM DRIVER
  Changes 108 / 200 (54%)
  Last activity: 2026-02-06
  Jian Shen <shenjian15@huawei.com>:
    Author 6d2f142b1e4b 2026-02-06 00:00:00 22
    Tags 6d2f142b1e4b 2026-02-06 00:00:00 26
  Salil Mehta <salil.mehta@huawei.com>:
  Top reviewers:
    [52]: horms@kernel.org
    [17]: shaojijie@huawei.com
    [16]: andrew@lunn.ch
    [10]: arnd@arndb.de
    [6]: jacob.e.keller@intel.com
    [6]: michal.swiatkowski@linux.intel.com
  INACTIVE MAINTAINER Salil Mehta <salil.mehta@huawei.com>

Add Salil to CREDITS as the initial author of HNS3.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: shenjian15@huawei.com
Cc: salil.mehta@huawei.com
Cc: shaojijie@huawei.com
---
 MAINTAINERS | 2 --
 CREDITS     | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49eb81ec3709..b9b8a7695ddb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11527,7 +11527,6 @@ F:	drivers/bus/hisi_lpc.c
 
 HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
 M:	Jian Shen <shenjian15@huawei.com>
-M:	Salil Mehta <salil.mehta@huawei.com>
 M:	Jijie Shao <shaojijie@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -11542,7 +11541,6 @@ F:	drivers/net/ethernet/hisilicon/hibmcge/
 
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Jian Shen <shenjian15@huawei.com>
-M:	Salil Mehta <salil.mehta@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.hisilicon.com
diff --git a/CREDITS b/CREDITS
index d74c8b2b7ed3..98aaf196567a 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2770,6 +2770,10 @@ E: merker@linuxtag.org
 D: DECstation framebuffer drivers
 S: Germany
 
+N: Salil Mehta
+E: salil.mehta@huawei.com
+D: Upstreaming of the HiSilicon HNS3 network driver
+
 N: Michael Meskes
 E: meskes@debian.org
 P: 1024/04B6E8F5 6C 77 33 CA CC D6 22 03  AB AB 15 A3 AE AD 39 7D
-- 
2.53.0


