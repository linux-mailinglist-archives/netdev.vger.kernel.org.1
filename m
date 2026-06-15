Return-Path: <netdev+bounces-299336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NUb0IPGgL2pUDgUAu9opvQ
	(envelope-from <netdev+bounces-299336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3315683EFA
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:51:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299336-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299336-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E670E3001FE5
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31302395AF1;
	Mon, 15 Jun 2026 06:51:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED62E1722
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 06:51:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506286; cv=none; b=PiGqhfrG0nP8wlcxKof+u96TvMLe+wVrENucsDrgBTy938vwAeNo7Nz0XQNO6V2qNxC5is+C8igiJIq7CVl96er1g5Xj0J5yDNI86ujeyWmOEki2HNVQ0FRtE2ureVDLx9LF2ZzJhNyXapjlhvm7th2N9fz6R7sFARhd+0cG9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506286; c=relaxed/simple;
	bh=cjj22J8nsFnxKKJWrzOP89pdhWDhG4LiLkp+uOar0rI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BvBXkaGT4AlBNNKFCEbWaWtxP/m3VT3u1IiX9tnZynthmIdd8BJMZWZ1WuJKX9L6L+d0AHusKk0YYo+pfp01s5dwV0/Z2SPhUzLQjNEtPXlg4FnQV7N9uTmowkOmEF+NOw0G1VNDWmKEXj+1bX8uebY4X4VsU5i9Ug5MCu2JQIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
X-QQ-mid: esmtpsz11t1781506226tb66e7c12
X-QQ-Originating-IP: xPKdC069Qo30UdY7NXYX8vE2h6wB84izS6QM+0s9tWo=
Received: from lap-jiawenwu.trustnetic.com ( [183.157.22.210])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 14:50:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3320718098820883919
EX-QQ-RecipientCnt: 21
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 0/5] net: wangxun: timeout and error
Date: Mon, 15 Jun 2026 14:50:11 +0800
Message-Id: <20260615065016.21672-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: N0fHFfxtkpsjBMLRvmaiQMfLRG2aCukvwCGPtGhqwt2/HHC8lQppU6es
	MsFiGkYvAQrth4Aw8FvvN6MPARBAOElePyZ606vOaXwtMPuwSw0o6nNC/QhoWvNHWfqg3GQ
	xFYGUOH/BlimXVC49iXo1jVDkd+N/pzuF9XWE3nMk+V9xoKDmp2atQNt4FChyxjEXJ6bCLv
	1Q2uh4Kr88PWidrJymVYq1rray5SOuELIaAY/HF92fzsxmHtv4qIqXQ861IJ+BvZDuFaHcN
	xkaJVzsWLsppHqc6Tzg5NNLr5iyvQSUGaU2wEMA2liE4Q11Qaj5IZwq+XULGrbPcpgXQVR8
	1ei5jZLlGjGfgKizPmrXQubrSKHhRKtkn2dggs5YWgxJEf+izVTEuElzvb4TiX2sPzqGSZd
	g4SrfyOH38nS2zsf+dWVlDdqaBzuTWvaygQid6+vaDvWbpxeNdWuaq8FXgeCsqMs0s+YXhB
	IahZx0wM8OyzSa+k/07wszzAJTTQYcEbzvRiywLrX1zixlpsp+F8kHuS9e/zU5x0XN/tw05
	u/inLuSws4ev5Z3sHFnzlDTSVe99v0KRgVcenspgcsSJT5k9bV5QuELQfoh2XtKQMStH9Sc
	VQABVnqQ4ZWpb3+947twgQm1cfvEcnmbqRUPycKlwGKEdeKs9fNa143yciQxg+tELaauxHs
	DtwhTZZoEN5KP5Mi7Y7sbf5CNefFwPMI9U3XLbivvIPKN5tkm1A3TItN1v24hignl9rr2gi
	2uXxyP6X7AI0OC26MPWBzpvpLf6Cnl5zuGP21JYF7jjvN9hcgHsErXfmm3wlbQQ53aWXyRt
	Xlqut76B147vqc/kqmXlJpgj1SHUIxi8A/I2o6X235vAhca7ddxlYyKnL+R82ytpQb5RcjT
	/OSm6Y7TIQNrNEtX+SWVobH5g9aLi0mnvU8jhKaFayTVfJ5WCM+d6J0U1PX7ajw8po8Hfi5
	89MnxJNQmxkC18WW2bWlJn+XXeDicBfxXQ7uZ9JBSSgkMi/2FahLLK2IrsFVcbkxfZgyuwI
	DbOtTQ5w/XuG0CfF59GP1mXb/AvVrdTlbfn/Mn18/HOjkSwLdk9twAQHqWym8zxLeRFfwGj
	gxn/KuuykEykCtgck7BRf0Uhn1/uRcmtw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299336-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:gregkh@linuxfoundation.org,m:tglx@kernel.org,m:leitao@debian.org,m:larysa.zaremba@intel.com,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,linuxfoundation.org,debian.org,baylibre.com,trustnetic.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,trustnetic.com:mid,trustnetic.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3315683EFA

It is about adding the Tx timeout process and pci_error_handlers.
When a PCIe error occurs, the txgbe device is able to recover on platform
that support AER interrupt. And for Tx timeout, the txgbe driver can
recover the device by reset process.

For ngbe devices, due to the absence of the current function, it cannot
br fully recovered once there is a PCIe error or Tx timeout. Its
function will be completed in the future.

Changes log:
v7:
- Move ptp_clock_unregister() to be executed before free wx->ptp_tx_skb.

v6: https://lore.kernel.org/all/20260610060917.23980-1-jiawenwu@trustnetic.com
- Move the check of device status inside wx_soft_quiesce().
- Reverse the error return of txgbe_disable_device().
- Add PCIe error check in tx_timeout.
- Add WX_STATE_RES_FREED flag to avoid double-free of resources.

v5: https://lore.kernel.org/all/20260604085631.12720-1-jiawenwu@trustnetic.com
- Avoid the same name on two functions.
- Encode the device identity into the name of reset work queue.
- Change pr_err() to wx_err().
- Check WX_STATE_DOWN and WX_STATE_RESETTING at the entry of every work item.
- Implement wx_ptp_quiesce().
- Add netif_carrier_off() and netif_tx_disable() in soft_quiesce.
- Move resource free operations after PCIe recovery.
- Return error code in down path.

v4: https://lore.kernel.org/all/20260601072221.2952-1-jiawenwu@trustnetic.com
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

Jiawen Wu (5):
  net: ngbe: implement libwx reset ops
  net: wangxun: add Tx timeout process
  net: wangxun: add reinit parameter to wx->do_reset callback
  net: wangxun: implement soft quiesce for PCIe error recovery
  net: wangxun: add pcie error handler

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 321 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  18 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  59 +++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  21 ++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  25 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  84 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  56 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   2 +-
 15 files changed, 592 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0


