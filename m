Return-Path: <netdev+bounces-302910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YJRpHrAzQ2rNUgoAu9opvQ
	(envelope-from <netdev+bounces-302910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:10:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C64536DFF9A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:10:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=zte.com.cn (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302910-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302910-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1584302D0A7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97122219A8A;
	Tue, 30 Jun 2026 03:09:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932203C8194;
	Tue, 30 Jun 2026 03:09:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782788996; cv=none; b=JeI6hZwMKgSy+EwM/9fq2L5lYYOArSi8oR9Vc9NCRuzsy9XAPPXCrq7Wu9uRhAJRRqKlS+6/VgASYELqck8s9VNAEM8hrIpphWpCN9JNsH+UsIZYJKJ6LZBi31W8NnYAnxSYc46DHptx3YLXeq5LfyHcP6TEFxvTRg23Z2AxGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782788996; c=relaxed/simple;
	bh=38HIykl4ZOs1/rvnvDCFJZX9X6oWINCTD7eLmWLpzbg=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=Kyeou0hFhvRHcQ6lHaUOk1SJRbf4fo7voUfEMF9hQ33JYprz8uK5jisv0OeHCRaH505ap5nCZHsNyAfzDVvqJdjQz5b32VxT/ikLiVbEf4vTGSZltk0IoSvMyQ+wHAQpOICzg5dQLb/bay9nH1dXZAPzDB2pNGRZAHt6SONxyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gq7Rc6ZvGz57HRy;
	Tue, 30 Jun 2026 11:09:48 +0800 (CST)
Received: from njy2app04.zte.com.cn ([10.40.12.64])
	by mse-fl1.zte.com.cn with SMTP id 65U39bM8020307;
	Tue, 30 Jun 2026 11:09:37 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app03[null])
	by mapi (Zmail) with MAPI id mid204;
	Tue, 30 Jun 2026 11:09:38 +0800 (CST)
X-Zmail-TransId: 2afb6a433372b05-02d10
X-Mailer: Zmail v1.0
Message-ID: <20260630110938458LNr_yEOENGtjGuNRow3RL@zte.com.cn>
Date: Tue, 30 Jun 2026 11:09:38 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY3IDAvMl0gQWRkIFpURSBEaW5nSGFpIEV0aGVybmV0IFBGIGRyaXZlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 65U39bM8020307
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 30 Jun 2026 11:09:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A43337C.000/4gq7Rc6ZvGz57HRy
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[han.junyang@zte.com.cn,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[han.junyang@zte.com.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:han.junyang@zte.com.cn,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,m:zhang.yanze@zte.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,zte.com.cn:email,zte.com.cn:mid,zte.com.cn:from_mime,checkpatch.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C64536DFF9A

From: Junyang Han <han.junyang@zte.com.cn>

This series adds initial support for the ZTE DingHai Ethernet controller,
a high-performance PCIe Ethernet device supporting SR-IOV, hardware
offloading, and advanced virtualization features.

Changes from v6:
- Clean up PCI device ID table (drop `, 0`, use `{ }` sentinel)
- Move dh_core_alloc_priv/dh_core_free_priv from header to .c,
  they don't need to be `static inline`
- Use `if (!x)` and drop the "%i, x" dev_err() messages in
  common/notify cfg init.

Changes from v5:
- Drop dev_info() log spam.
- Propagate the real error code from dh_pf_pci_init() in
  dh_pf_probe() instead of hard-coding -ENOMEM.
- Register devlink only after dh_pf_pci_init() succeeds, and
  in dh_pf_remove()/dh_pf_shutdown() unregister devlink
  before tearing down PCI/mutex/priv.
- Drop the "dh_dev->priv = NULL" assignment from
  dh_core_free_priv().

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
 drivers/net/ethernet/zte/dinghai/en_pf.c    | 635 ++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h    | 118 ++++
 10 files changed, 902 insertions(+)
 create mode 100644 drivers/net/ethernet/zte/Kconfig
 create mode 100644 drivers/net/ethernet/zte/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/Kconfig
 create mode 100644 drivers/net/ethernet/zte/dinghai/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/dh_queue.h
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.h

-- 
2.27.0

