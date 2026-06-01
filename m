Return-Path: <netdev+bounces-293592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM/gEtE0HWoqWQkAu9opvQ
	(envelope-from <netdev+bounces-293592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:29:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AEC61AE26
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB958302926B
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D7F384CC6;
	Mon,  1 Jun 2026 07:23:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575637FF5B
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298624; cv=none; b=l8E/6RXGlPDtXDIp/nlRqeBcibCQlqS2zmDAqwY/NdQOPaoAcaPMKRTfxRQ2g0prHtuV3VBn9zkgE6IJvXAjPJR+RV0epX7Hw/1cvEoh2AzFdVweyE7JPW3jKeFlIRw+evx4gGcgk/pN35sPndp3sAA3H2rKKsncHMqxEtLaJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298624; c=relaxed/simple;
	bh=p7cFibFj8DIJQgp68bepAyzmMWNk+ygCvuzHZTGCL4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MlG0id3jFmmlHH7nIKkUIaT/7s4mCi7/3RG+FAZZzy4ysGWjmLA41pz9m13B+iA++7svxHxU9rnr+D8dDUHS/8kjW2nQ/dbpW5jjkiZp7LDXiiGIGto8zaOo+yZ+ne53CSY7aM5bQA28DFVk01bPU3Fwqb6zzceCIuw4K53oP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz14t1780298547t05820be0
X-QQ-Originating-IP: ZCZu4Hdzssx4Fd+JNdF89fILZqPXFYmoJ1tS3MIY7F0=
Received: from lap-jiawenwu.trustnetic.com ( [183.156.95.204])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 15:22:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7705541218113009584
EX-QQ-RecipientCnt: 22
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 0/5] net: wangxun: timeout and error
Date: Mon,  1 Jun 2026 15:22:16 +0800
Message-Id: <20260601072221.2952-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nl7eTg5yGHnwRsD728uwrttA7p9DSWW5UUQfocLeEtRkCGZxth7XWgyR
	NixcXKldu/PX2eZpQTVTIq7k87u8rLS1HcqNyXp2jOX/mYdvfcObvyPnGcoV5NexGuHnvU7
	OxYu65zZTPMBIkUg/mOS8JUP9ZchtWcehb3Rl0Wccvs3PJ429quYtx5vAxgqSh+NuCJDXTf
	+16fyK+384So7nziIQjDaL0ngCfKydVm3QAvg3dEdjnNM9DFRPC7YOpaZHFP9l1s9rQIxmn
	VnMBD4Gf0Kwx2Qni9COHI7tk2u2OJF3CZp0JSC5RmAgPxy8I9UvCxgtRlcpBQ9Uh0mLHdbZ
	fFc5d0dgbd7oFpLbNInOfRRVHYZaUhziEwIOyDvHX9EVVpmAADM4BRLoJL0AkIxr1jU1RTw
	WdY8TPuT3w5uTKAxInm2DwDdYWfWdqc39CbZBs9V4dpK0/XFV/ezP9+S5gd45Mowce0rnom
	LDtS9c9/ZSuDmsLPeUr0vhTdczaKlVDXhaNtKPUAlHw2Iwhl3aAroppAoLjA+gefhWX5QL7
	0nk7KPEYB3T1ozZi1eJ1YXZqGrol0E5aTI+xnyt8EzwozTtHjcXt3Ga1UDEslLEg6eFzccq
	ybZ7sHivRmwXt6Z+r6EoKWSEtrzfVKCi10uGpMGgkHweMO8H3tdk2rt4Je+Bt3DVEjf/URP
	rMMnv8mezcHhtD71lHpAlm6VU224vLB7FjUtMuIdpThgmXLd3er8bp3ZSAXtnPCRefjdmGS
	16tMLjW8OZvrw/Rix35YS+e6uOkhUBa8bnhZ6V4R3Pyyzbghr1zHZZj9LG22q77iUCHBs6b
	kdVfoM20PB5rfwIEmeaTmt+6tj6dkM0AS8y8TXI0Ve4iLI/4QJRdV8cS9DeBXcsXyQ9qeF6
	8kycqVobFpQ4GC9K1J0VUN35UlCkgBp8eXbwXAC+h/P9KiJXq0pbEo6Mj//gaYQFm46oH8D
	5akZcJJ1fN+ayh+qtR3KTuGZ/GXCOoDkNbr5dPMB+DnMpcPEpEYpdoIoBm2FDVewK0a4/dU
	JR8y7rtgyQd7fw/8lxq9LPgKvwUe4aIbJJ0o3LyXbSzE5GbVUBeEvG5gZXD5Bo2DQNiYxku
	Ts0HV35Y03wpoJoS9SMHCopVMPY1sfiqw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net,trustnetic.com];
	NEURAL_HAM(-0.00)[-0.927];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 98AEC61AE26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series is a split of the previous series:
https://lore.kernel.org/all/20260326021406.30444-1-jiawenwu@trustnetic.com

It is about adding the Tx timeout process and pci_error_handlers.

Changes log:
v4:
- Create a separate work queue for the reset task.
- Gate wx_watchdog_flush_tx() on netif_running().
- Add rtnl_lock() around wx->do_reset() in wx_io_slot_reset().
- Change .close_suspend() to .soft_quiesce() to avoid MMIO when PCI
  channel is frozen.

v3: https://lore.kernel.org/all/20260509100540.32612-1-jiawenwu@trustnetic.com
- Merge the multiple string line into one in wx_handle_tx_hang().
- Remove the redundant warn messages.
- Use test_and_clear_bit() instead of checking the flag bit then clear it.
- Drop the Tx hang check in tx_timeout.
- Call wx_update_stats() before wx_check_tx_hang().
- Add Tx flush when link lost.
- Move wx_ptp_stop() into wx->close_suspend().
- Drop V2 patch 5/6 because WOL packets are handled before DMA ring.
- Check wx NULL pointer in wx_io_error_detected().
- Check perm failure before hardware teardown.

v2: https://lore.kernel.org/all/20260430082517.19612-1-jiawenwu@trustnetic.com
- Add the missing rtnl_unlock() at early return in wx_reset_subtask().
- Replace ngbe_close() with ngbe_close_suspend() in ngbe_dev_shutdown().
- Add a patch to clear stored DMA addresses.
 
v1: https://lore.kernel.org/r/20260428021156.13564-1-jiawenwu@trustnetic.com

The changes from the last full patch set V6:
- Add 'else' handling in ngbe_do_reset().
- Acquire rtnl_lock() before checking netif_running() in
  wx_reset_subtask().
- Use test_and_clear_bit() instead of test_bit()…clear_bit() to avoid
  losing another reset request.
- Change ‘u64 tx_done_old’ to ‘u32’ to avoid data race between
  dev_watchdog and NAPI polling.
- Check the return value of ndo_open() in wx_io_resume().
- Drop pci_save_state().

Jiawen Wu (5):
  net: ngbe: implement libwx reset ops
  net: wangxun: add Tx timeout process
  net: wangxun: add reinit parameter to wx->do_reset callback
  net: wangxun: introduce soft quiesce callbacks for AER recovery
  net: wangxun: implement pci_error_handlers ops

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 281 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  18 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  41 ++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  23 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  83 +++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  48 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   2 +-
 12 files changed, 500 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0


