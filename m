Return-Path: <netdev+bounces-264691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPHrK2V1qmnRRwEAu9opvQ
	(envelope-from <netdev+bounces-264691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:34:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F9C21C1A7
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EE833013FF6
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 06:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAAA371CE0;
	Fri,  6 Mar 2026 06:33:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6E43147
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778830; cv=none; b=B5LktMdZX9b17d5gMnchOVbsOn6UOFQyo/3uMAmTksORGWcFBo7LhUGTsjFxZgsvoQMZA2qlYGQtZ0beNCW5795Ucz/Jy05f7uSwto988YSMKZ0eL7HLqmQV7ZfJ2vfOh1LITNftwq6NPhTSCRQASRnf9SB4SuRMfrTV3N4GBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778830; c=relaxed/simple;
	bh=UleBc49gxIhuvTnaWPhPccyVLhutoLl4kohP6Nfmd3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NASvEMY9atI3p+FHU/uz5L79Rpj8Yqt8Hjr+TEsmOQvHD/+9EkO3s/fuXgWpeRgin5XEOI0URQ2RqEzRvZAVA3uRBT7r4iBMYefLvMdBEBu9P3m2sU5WLv6HN0CFkNaQj+xVf7m8p3CmkwzVy+19bqrlBbeEVn6lhgaUh21wgmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1772778760t8c2e605b
X-QQ-Originating-IP: H6LWyOshgHGvfOWLV4xGYDMnaKpTyYX9l1HA5gYR3tU=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.243.152])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 14:32:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13388362515324680328
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 00/10] Wangxun improvement and new support
Date: Fri,  6 Mar 2026 14:32:01 +0800
Message-Id: <20260306063211.20536-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NMeLRkc5NsPhT460xQQZ4OrBGHtndALAMg1HAFoOU0tAEC0jtbNJLNJb
	EzN1ufsdFpWLFct8rIrokLCtPHXd6TxIdCnYKwaidU0ZwylK+IgvJ6RmxgI6LSJ3zQsb4jF
	0lcTiLb0FozEuL2vkUVcd6aomjG6sOAIvgbOk7SjCVkFt0aMxKZAW2HTBPC6VayV+sc6+/B
	KIWT3gqhBGmwF5tEIj9BfWHO1f4/BDu3MLXDbvG+cWdqHs+m+tQ0yc6W3PF5m3XO7i1MulD
	7F/Miv1wYEpviWib1GA3gpusVe0g9pF3u2XOVbikAGGxiE4mnggBn1W6a2vZVIw2usoXWFe
	sgVSaNtAzAKRSDKJ36KfyV5bgy7dAWGw2P941LNP3Tvi7iu2LyblqvZHrZwjVqme4CyUwGr
	AaR/YE2lqbjh/bdnXY/SZSj87hJp4pGaX/pqVyrjSdp/Irb1jqn0IWlscjwdoQg6jJ3ddHM
	9hrc5TfROn5a11J0o/5Lvttf0/3EV4/wwKSljAohYRYdq27LYLddEovocCgdgp3B+gwRwtn
	YBtkPNRXc3JM2cOoQpI8DGXOYVhHX6qBQr/s70Oo/DI4KBwg5hRTBsA63bgLscQjxVuQMzd
	O6hf3CYcB3VKfWfsRDRu6TDu8YtEtkRQwVAFz/1+bXnDszoyx7X4NKjA6IpKigbOt/IIrUx
	pqNF99mjJoyY2UG21quflWA2owACaeXs5X8/edm7BTkSQKGdGjY9cr3/liLirdMu4TiOekM
	N6JWGN0rSiAtDvj2841Cm/RY14zcQzbT1vkTvJ7MVhK6ehXOlO37hDa0X+GokUAuSVXswsc
	VKLlDCUbx3pnmYsQbS8osI3RQoudPG7V6PVSGna+2g15gderfZ6l4KU8l8XtE+JFXL9fBFd
	p8WeL8F17Kv3OPZz3ujfUli1CRuWq8qPOMhz437RFXWg+aBN0Ya2Absddp5OLZ6sIog+B/6
	csD9fgludCGl/qs1TC/du+tLbcAGndAeoWiUfD4ah2puFbFVcA5FsRzLK9G7vejRsK29Tjd
	AXAUSXiIdnMHKQnhhtcu0JbhiC9oe+mWwfziRa9YCPJeLoMlhHDeiNwlOKW0ALQ6dBoeK6K
	3P8rYf8TifVGy2HgtOOw0Y=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: E4F9C21C1A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264691-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Implement power management function for txgbe. Clean up the same code in
the two drivers, to make more use of lib functions.

Add Tx timeout process and pci_error_handlers ops, to recover the devices.

v4:
- Add an initial patch to remove netdev->ethtool->wol_enabled setting

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

Jiawen Wu (10):
  net: ngbe: remove netdev->ethtool->wol_enabled setting
  net: ngbe: move the WOL functions to libwx
  net: ngbe: remove redundant macros
  net: ngbe: improve the reset flow
  net: wangxun: move reusable PCI driver ops functions into libwx
  net: txgbe: add power management support
  net: wangxun: move ethtool_ops.set_channels into libwx
  net: wangxun: delete service_timer before cancel service_work
  net: wangxun: add Tx timeout process
  net: wangxun: implement pci_error_handlers ops

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 228 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  37 ++-
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   4 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 139 ++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  16 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  52 +---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 199 +++++++--------
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  19 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  17 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  75 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   3 +-
 16 files changed, 589 insertions(+), 227 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.48.1


