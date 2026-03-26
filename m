Return-Path: <netdev+bounces-271799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MqpEPqWxGnn1AQAu9opvQ
	(envelope-from <netdev+bounces-271799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:16:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 779F232E470
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 059D4300D76B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F122D7D59;
	Thu, 26 Mar 2026 02:16:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C831F1513
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491374; cv=none; b=O9CuKAPg9TaAKnomA9DOZ8wD3HQQ0QYjW6gkLdL1uy9jm9CBahDJmNZVRc1UrOhQFPp2W3dcto0FKrKs2kN8y7TOYodkGGM35NW8dUAgAHA2jeG/2YejmAVuHtPwT10C9IOENBk39897CljxtYwevgBMOe0fjTXbobPMFKlJQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491374; c=relaxed/simple;
	bh=rSFZyamTpyvqnVtxB87EBpbdeG5QDUjYT4QqnXC/2kA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hd01rIdEDiErOH5pMms9wk0gnR6j906N0awMJPvH3k3YpZvbyvpIape1xj5nj1fhuH6UYNZ5aScHHVZ7AeYi+l4PBCkk5qCviGawfJ5LSKyX6w46HDufr+xeWs2Cd83GiISkqLFXmS+X7mgNcy2v+/F+LAg01fEr9fkHrjrabuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz11t1774491298t7f30495b
X-QQ-Originating-IP: 3UozlLEp2T66kC0rKiVwiZLa4Ku3U/R9MYZAlPuY/6Q=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.44])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 10:14:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12737786789963682063
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 00/11] Wangxun improvement and new support
Date: Thu, 26 Mar 2026 10:13:55 +0800
Message-Id: <20260326021406.30444-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MSyoPQEuxKCukAz+MMz+SHbiGvqcN62NKgXl+KX9dFJa1oQHSbpI9h6p
	wCks5bnB/0aKWb3oBvNf7bDCZMxfdKWCBj8dDOcwPbRu3l07ZqVrXZ/ZtXv+x8mWZM6lEhO
	0uyAW+wOYRgJ7LreI+UU2pNyEjDFd89z0fjWFqMonJbWxBGLI/Wdnoz8Eq4Ie2w++qDOqzL
	KQEqBrJhKbtPQERsHljDKTIq+xiRANYkgQ4Mo++cMTV5qbaI6b+rvwIbD3KN1+Kz58wjcyw
	wmu8GGjU0a4KTGwrJs98+6s6/V1gu6tTvfaGEUV3KUaJ1pMcBChP8/ImzMXFI4bUMAUrzsc
	mZmEfJMlWG1vyy5c+mSTr4+fkWABi5vN25An46DHYPA8UlR4JGfereY+V75GBNgi1Phl9bQ
	v4s0FBawn20id/6Vk66m+oHjIiSaSqqTQLm4XtKIbF/iDQJV4TEN79daICbMW1S0RFeGs9c
	COdCu5k1zktz119ht/RVx9wdr2TDF6JwtvvW+lF3+MuSSlB8pHEAeeuOGgKQYE0YQ8mzTRD
	diEkSvHHGjqYpNnaY3qVmQHIpVNvPBfsZgE7/frnrYTT6eK8o24uEFWWJTkxYUT0P/OUGxQ
	3EpG9yRDB3sZOdbLHB5Qqg1idjVMUmyM5cNyqXtS9GFKXb4TXn/fNNtWs5SW0sfkzEe7sXb
	RmG75+QrxKzDxZeNTiMHmyKgkrcQiV3CoHmiHXqpZokD1IAAwSsD3pk0fpNOLll1jlQ7z9V
	BzURy6LDGKoJXsXlOToDzpw/rCaQmt9uUFw83Rsh+waruXJZLp2OMX9CpbueYVBe7/PHqFL
	VzY8i/zwhhTDIAjOgWJxY0awPlETNveJWfmq+EQIXBj0jXIzxythT4SOHP796thIoGtWOGi
	gwtBvNJRK6VQCd8sV3ITWma0eHxTTCZG4Qg9QY7QgTh51IAqo7USEagjGoAUqNnmhkchsTp
	NctIxdUp0YOPw/QDRCz/I4zOuzOMUmTxfIrqgyzxoLiH+OsB4jgl/iY4VRXXUPFRLKEKHVP
	xbAmbhz6877EwJS8kcQ1bLaHN9S99FqdOyAqndYXkIog9mcIW60BJR8NXuf3v9FDIKHY1Ae
	SAYUDF90qgK
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
	TAGGED_FROM(0.00)[bounces-271799-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid]
X-Rspamd-Queue-Id: 779F232E470
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement power management function for txgbe. Clean up the same code in
the two drivers, to make more use of lib functions.

Add Tx timeout process and pci_error_handlers ops, to recover the devices.

v6:
- Remove changes to the reset process in patch 04/11.
- Remove the inappropriate comments in patch 09/11, and detail the
  commit message.

v5: https://lore.kernel.org/all/20260317073827.4300-1-jiawenwu@trustnetic.com
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
  net: ngbe: implement libwx reset ops
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
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 129 +++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  32 ++-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  52 +---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 192 +++++++--------
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  19 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  17 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  78 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   3 +-
 16 files changed, 635 insertions(+), 237 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.48.1


