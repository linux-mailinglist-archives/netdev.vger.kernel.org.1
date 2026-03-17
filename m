Return-Path: <netdev+bounces-268471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ARwLbsFuWmEnAEAu9opvQ
	(envelope-from <netdev+bounces-268471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:41:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA82A4FA1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42F3C300AD47
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE6391836;
	Tue, 17 Mar 2026 07:40:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-usa1.onexmail.com (smtp-usa1.onexmail.com [52.205.10.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA153491C2
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.205.10.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733241; cv=none; b=X3xZ1XDK0JzaUHrzrjehZcKKKcCSXPRFKlw7khej9YMPNEwQE1HODQCLp0+akRM2FjwZ+7PxOUnqmtySCzv4HF5ZWuPw64NT6lhQZSuMuHogpd8iHYsFSuBgtPkqVYlz12uKHK5g6DUBRPOLfQCfYASwWlmHQNLbaGO8N9FuNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733241; c=relaxed/simple;
	bh=3nfEkE9GQ6BITi05kTT/bquEgIbBdjP2FhL/8plCF2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mw07IhjJDZBw4DHBM1wqY3SNVmvR5nrYXx0tcxMgS7IpUcIgp6CcaelvFHEhWDzR3Qmuzpy8w+woMnqrhrp9lxE3cSFzNuN/yHVZc8u7GczbiWbxfqkZnU5aD0UM0rsac/xYqkOuPHs6fnaQ1Zn4jpC8IJkWVwk53tj51LOqkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.205.10.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1773733118t3b005b97
X-QQ-Originating-IP: a8DROfs7UPfM8tBb/q9mTIkBEuO5eR1ShK+Aucg5cSk=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.239.227])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Mar 2026 15:38:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15952872955884314217
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 00/11] Wangxun improvement and new support
Date: Tue, 17 Mar 2026 15:38:16 +0800
Message-Id: <20260317073827.4300-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OLEpjvZK0eXkwnTri2ybTgZjf27OdPoVAaSn4Ep5VciyTewIquS1JfVg
	OzZ1xTyxHRzNxQ1xznWzIF6nEQCBmW7J3WWLMKNNla5mx4w7ZKW7sKLgD9Oy0fLDZ8MlTnJ
	kDsYiahDuW2RLWU/3f+B1n08fUqtzBA/1fiyBhEbTdq6g4X0xrb9ZTSe9rB0aKcG/XIMiPh
	4ZN5QCv1FPNq6wJPnRe5gDoGXDyeJhEFSJEHduV9tgiYWhe4wNZx8t4nHWA7wEos8Zrg4VD
	NLM5LDYyXGZrkpkHN1iEQK3LXAykyftkblhk5GmeohOv9fgtxXow5Be427P3zv2TgiEwxYH
	12x8W1Ju5EIk24PtNf45iFKgl1uGgEN11YHOXfpAtqPlDADFWcUM7mwou7BeaVkqsL45Pj7
	bMC8SxJbZoMjsj9O2HpFKfboEhRqNmZiVzFsozC/M84Odnc+ABuACtD3lTW0iw4kQ8N7U7k
	xjCW3CUnP3sc3Rdqr2jrzLqE1Uv3jvSXRZCU9AtO+Z+2UhAA3sWnAW9o5ZLulb+yooP31Bb
	bVjXmjHOHp08l7q0t2fjbf44+gY/GlhbVr074fYI5ukogr47blHOjbPJmwgd/67ziZKYKO/
	Wu1ZEySS61OMeVXc359qbmVHVKKraYC8Nutv7CVo7+JWbf/2e6L/DVGz/l3E1jeZuPmIv8m
	Mv01UkkVjEsyM6PGCzVxliASyfVIcJzVwW+nFtTJdVXojMCJZCF/utKQtKxsYSI+UZBZnrM
	C33dA/wtLDgOFuGgN0N1H0L5Resg6/FoJUIxEnz7p+dmkShbziSpm59054ecMG2TKkI8aZ+
	r1i+cCrq+Wirt1hcbjvyw4+henWEvR4Hj0wqtddRxoYDg/0BiFS7jxiHe1ZyYed1+s0Drpj
	znOT9X8Ykc4Ozq/JjSmdM1BTtXJx8bTeSK+c8jJohGYrdTnwnpSi46bsn4dc6kJnc0cL4dj
	0urFVhL/Pn8Bezdxbry9ygVN4Tl8/1sJqlGF+bqoQdS5Bhwx0uXtMQcVSddvC7tBEgFe1Ys
	hOr6ffHii+yIqOGSbjkucx4oPVT8p7UlwBH3C1IMkee7NMc9HwYIgPCN9OSg0UmcxBMuzSZ
	+aob0dg++70
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268471-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.826];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trustnetic.com:mid]
X-Rspamd-Queue-Id: C5EA82A4FA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement power management function for txgbe. Clean up the same code in
the two drivers, to make more use of lib functions.

Add Tx timeout process and pci_error_handlers ops, to recover the devices.

v5:
- Add patch 10/11 to handle Tx hang check with pause frame.
- Clear WX_STATE_DISABLED bit in wx_resume().

v4: https://lore.kernel.org/all/20260306063211.20536-1-jiawenwu@trustnetic.com
- Add an initial patch to remove netdev->ethtool->wol_enabled setting.

v3: https://lore.kernel.org/all/20260303030331.24076-1-jiawenwu@trustnetic.com
- Detail the commit log for improving ngbe reset flow.
- Correct the process of stopping the work queue.

v2: https://lore.kernel.org/all/20260227073450.23680-1-jiawenwu@trustnetic.com
- Split NCSI changes from the WOL patch.
- Properly return and handle error codes.
- Fix the typos.
- Remove the check for PCIe errors and subsequent error handling, because
  aer_recover_queue() does not want to be called by the ethernet driver.
  The discussion link:
  https://lore.kernel.org/linux-acpi/001c01dc9740$c7722540$56566fc0$@trustnetic.com/T/

v1: https://lore.kernel.org/all/20260203075759.5852-1-jiawenwu@trustnetic.com

Jiawen Wu (11):
  net: ngbe: remove netdev->ethtool->wol_enabled setting
  net: ngbe: move the WOL functions to libwx
  net: ngbe: remove redundant macros
  net: ngbe: improve the reset flow
  net: wangxun: move reusable PCI driver ops functions into libwx
  net: txgbe: add power management support
  net: wangxun: move ethtool_ops.set_channels into libwx
  net: wangxun: delete service_timer before cancel service_work
  net: wangxun: add Tx timeout process
  net: wangxun: improve flow control setting
  net: wangxun: implement pci_error_handlers ops

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 228 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  39 ++-
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  56 ++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 141 ++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  32 ++-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  52 +---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 202 ++++++++--------
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  19 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  17 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  78 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   3 +-
 16 files changed, 657 insertions(+), 237 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.48.1


