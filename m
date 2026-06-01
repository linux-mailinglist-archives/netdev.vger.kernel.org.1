Return-Path: <netdev+bounces-293573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NEeGIYmHWq6VwkAu9opvQ
	(envelope-from <netdev+bounces-293573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:28:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2161A298
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68133301751F
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61EE346E6C;
	Mon,  1 Jun 2026 06:24:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC113346FB3;
	Mon,  1 Jun 2026 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295099; cv=none; b=cEdcWG+EdBizzhZN9PmxdNAkwh0mDkf57Nz25DtgG8D2YuKo0ijhtUO/Fm0f/imIecoYEZdkgWGtDOiP9l7oJEv0GPOFtXTHjDNMRnppFbzhysxlPI8I8JAig+Dz/dZMHjN3M/fqCPQCCyM+9PZDWT3wk2jiif334vuU+GvsQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295099; c=relaxed/simple;
	bh=Doi08I3OodChG1dLhKeDyfNQ0vyi7tETBhPcvcUeHRs=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=t2VMT+pwlmPlFYg9KB5NP8CFbdqc5mbafw9G/nlUVbgyc8euysbk3rq3zDX8doTS6X4qw/WDX7Zv8fGAbPZO7EVHDG8eDUoWwKijreFEHu8gITsTFZgzcswhVcZbkUM5/QsM7Bu6K7X6QNJ+qz34ChFylKppC9BXAzmlXam9IcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gTP7y39Klz58fdK;
	Mon, 01 Jun 2026 14:24:46 +0800 (CST)
Received: from njy2app03.zte.com.cn ([10.40.13.14])
	by mse-fl2.zte.com.cn with SMTP id 6516OcnZ028295;
	Mon, 1 Jun 2026 14:24:38 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app08[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 1 Jun 2026 14:24:40 +0800 (CST)
X-Zmail-TransId: 2b006a1d25a844f-01f7f
X-Mailer: Zmail v1.0
Message-ID: <20260601142440024x-1sx0cQucoMxTHjm7ps3@zte.com.cn>
Date: Mon, 1 Jun 2026 14:24:40 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY1IDAvMl0gQWRkIFpURSBEaW5nSGFpIEV0aGVybmV0IFBGIGRyaXZlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6516OcnZ028295
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 01 Jun 2026 14:24:46 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A1D25AE.000/4gTP7y39Klz58fdK
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293573-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[han.junyang@zte.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:mid,zte.com.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,checkpatch.pl:url]
X-Rspamd-Queue-Id: B1C2161A298
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Junyang Han <han.junyang@zte.com.cn>

This series adds initial support for the ZTE DingHai Ethernet controller,
a high-performance PCIe Ethernet device supporting SR-IOV, hardware
offloading, and advanced virtualization features.

Changes from v4:
- Fix sparse warning: add __iomem annotation to priv pointer
- Fix Clang format warning
- Use "dinghai:" as patch subject prefix
- Ensure proper patch threading

Note: Sent manually due to temporary git send-email unavailability
in our environment. Will use git send-email or b4 for future
submissions. Apologies for any inconvenience.

Changes from v3:
- Merged patches 1 and 2: 
  Combined initial framework with logging infrastructure
  for better code organization and reduced patch count. This was done because
  the logging infrastructure now uses Linux's built-in dev_err(), dev_info(),
  dev_warn(), etc. macros instead of a custom logging system.
- Removed unnecessary variable initialization: 
  Fixed "don't initialise variables".
- Fixed variable declaration order: 
  Applied "Reverse Christmas tree" ordering with variables
  declared from longest to shortest line length.
- Code quality improvements:
  Fixed all checkpatch.pl issues (alignment, formatting, etc.).

Changes from v2:
- Address maintainer feedback from v2 review:
  * Remove meaningless initialization
  * Change dh_pf_pci_table to static const for better encapsulation
  * Simplify MODULE_DESCRIPTION for brevity
- Coding style improvements:
  * Ensure all lines are within 80-column limit
  * Use kernel types (u32/u8) consistently throughout
  * Improve code readability with better formatting


Changes from v1 (addressing feedback from AndrewLunn):
- Update copyright years to 2022-2026
- Remove DRV_VERSION, MODULE_VERSION and related boilerplate
- Fix MODULE_AUTHOR to use person with email address
- Use module_pci_driver() instead of manual init/exit
- Remove empty suspend/resume callbacks
- Replace char priv[] flexible array with void *priv + kzalloc
- Switch logging from printk wrappers to dev_*() based macros
- Remove dh_helper.h and dh_log.c, simplify to dh_log.h only
- Fix variable declaration ordering (reverse Christmas tree)
- Remove unnecessary NULL check in remove and pf_dev=NULL in probe
- Fix indentation and remove unnecessary type casts
- Use kernel idiomatic "if (ret)" style

This is the initial submission and only includes the PF (Physical Function)
driver. The VF (Virtual Function) driver will be submitted separately.

Junyang Han (2):
  dinghai: add ZTE network driver support
  dinghai: add hardware register access and PCI capability scanning

 MAINTAINERS                                 |   6 +
 drivers/net/ethernet/Kconfig                |   1 +
 drivers/net/ethernet/Makefile               |   1 +
 drivers/net/ethernet/zte/Kconfig            |  20 +
 drivers/net/ethernet/zte/Makefile           |   6 +
 drivers/net/ethernet/zte/dinghai/Kconfig    |  34 ++
 drivers/net/ethernet/zte/dinghai/Makefile   |  10 +
 drivers/net/ethernet/zte/dinghai/dh_queue.h |  71 +++
 drivers/net/ethernet/zte/dinghai/en_pf.c    | 629 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    | 132 ++++
 10 files changed, 910 insertions(+)
 create mode 100644 drivers/net/ethernet/zte/Kconfig
 create mode 100644 drivers/net/ethernet/zte/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/Kconfig
 create mode 100644 drivers/net/ethernet/zte/dinghai/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/dh_queue.h
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.h

-- 
2.27.0

