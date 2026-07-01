Return-Path: <netdev+bounces-303501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sj5TLY/BRGp90QoAu9opvQ
	(envelope-from <netdev+bounces-303501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:28:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E99B6EAA22
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:28:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303501-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303501-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C88803098A4E
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 07:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7F3B774F;
	Wed,  1 Jul 2026 07:25:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12043B5318
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 07:25:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890724; cv=none; b=UqpkEUQOCbRE/yZi4DhrC7FFsTnYQFiJ4TT7FOQzAOmkraSRJGyelGlSmP9AM8lxzgR24ruXP5WGYTbnN4ZZMiFk2nE2czQe86SbnIH5BGJ3dJvljiY4qif/mADti4v99+xtVpuOyshRV5s5KYQGQ6qCUacHbRoi2RfbrL7/3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890724; c=relaxed/simple;
	bh=pb4Fx/8H1Icxd6Yr6ZmojxoeTRQaWxSFH/P+6pbOyKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JjIYQWSaUBWjHAVAkWkO3KKV7Zi7gBiyuw9k60AsTOq0mms9abG9VjPO+SQI5CwtxCsG/UQxv16muKIP4RBTr8NzUwVcfq633qFeroj9e4GKCNgXXVEusYlXQPsQQIPiGYoFMlhv3oEPxJaIaMaa3oDkdGDBqA9b8SVRhoTlrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
X-QQ-mid: esmtpsz18t1782890651tff96761b
X-QQ-Originating-IP: WQaHHfWJMzLAMwMjRNgF7y6Z1nucruFJErterYD29rU=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.190.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 15:24:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9945059236626048989
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v9 0/5] net: wangxun: timeout and error
Date: Wed,  1 Jul 2026 15:23:52 +0800
Message-Id: <20260701072357.33984-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: Ns4o82esMDegQY+P5B6tSGPhpXvumpE5jVfphH/4eP6XRR2HM2inkXgt
	qMm6Hb1zhr1sJULSpMyb1GTIMiZ901RzLYpbtyNXQR9ki9hdl2wHrEHGSOrlYKPMQHxGwxb
	OZV/LXQNI4PNfQMdks3z1Mv/kTWPRHOus53XRbnzufw54ILwf3eHU6sbJnSMR3cNU83PORO
	0UZfVWHtqNZHKrKZRJW7gGyeFTkYNS+8xcySkZWqW4NhvYeh5ZPeDUcQ8gHjCyxXK6IWv9J
	xXF4VDeiCdfJyLY8v0S0LnllMOHf35Iy9Vl2Z2oGzFn3OO8Ou6IBIX8zdkQXA0OXVwJ07iI
	rhDnCfAsaEosJHyRQ/pQ6A2fiOoztyPRtKwLDkCS5trxcop1WMTRhb+zhqVmdkagnu5m+++
	X40SZvNZOG0szLwoQTT8cgnrTCm+D0VMPR/i/ZKS6b4CbteL5Eg9ICx40XWIAZ71CO2ozHC
	GZH73ewboddSlrdKXCRwmg3pJ54AdhnrXbxUTjcpXHhK7Uo8PNS2HYUVNdASvMDPBFvcZqm
	x/BFq59ZwPJKTGyL85q+tkrlq4JsvyluS0ifEnTh7vRmUN0HymD1eJPQQGApql3THsfeavs
	ZRdAdNyBBKX28on/Op13A39/BKx3MKJ1wtoyRUMXoqBnQ54JbYyJlAcxOwZIrhEavUhmU70
	S2qLlZuo0bHB6g3/UBOPLnq2taI9crQoXFyxrK6WocRZGn3pJ4b1R9M39itwQTsy4w4rVVE
	KMby2aUXq6rgvi9fwSbKacFuxWsYTMf80Rka66D9ySUgtOy5yqxoxDsqhA8UIXa0lU5Hg4G
	HrjzrxL6ocs+F73JTaV/5U7LWL1CSfIqz3Y/zU0B4v16dDmKhoIDoI8YYzaPvPWwM0oKrAv
	Ir6MIfzarSwDuZC+3xhM/R60HRM0QMVFrkRY2TR8FNtaMFWTTyCPrUIHehT1hQ/r1xL+OKo
	hUeWlgPBHCuUIPAMFCWy/MjcMSmN4u6q+TaLfg7W7r6ZvrPQXW5GW5+OuydtSO64gLua/bA
	vnjVaitWC8O0+7yB70V0z1h8P51hnVXe0TsgwRmLAdTFrWLnjQf8fBt2rB+LeYO0euJ27TP
	PjyPgSbkd0KXOJXO6m3f8uPieECGPjZfA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303501-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:gregkh@linuxfoundation.org,m:tglx@kernel.org,m:leitao@debian.org,m:weirongguang@kylinos.cn,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
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
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,linuxfoundation.org,debian.org,kylinos.cn,baylibre.com,trustnetic.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trustnetic.com:mid,trustnetic.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E99B6EAA22

It is about adding the Tx timeout process and pci_error_handlers.
When a PCIe error occurs, the txgbe device is able to recover on platform
that support AER interrupt. And for Tx timeout, the txgbe driver can
recover the device by reset process.

For ngbe devices, due to the absence of the current function, it cannot
br fully recovered once there is a PCIe error or Tx timeout. Its
function will be completed in the future.

---
Changes log:
v9:
- Add calling ptp_cancel_worker_sync() in wx_ptp_quiesce().
- Fix the typo of 'out' for wx_control_hw().

v8: https://lore.kernel.org/all/20260630031016.19820-1-jiawenwu@trustnetic.com
- Not destroying PTP clock in wx_soft_quiesce(), and keeping the PTP worker
  alive but idle during PCIe recovery.
- Move wx_soft_quiesce() after wx_napi_disable_all().
- Use PCI_COMMAND_MEMORY and U16_MAX instead of magic number.
- Fix the leak of wx_control_hw() when WX_STATE_RES_FREED is set.

v7: https://lore.kernel.org/all/20260615065016.21672-1-jiawenwu@trustnetic.com
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
---

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
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  83 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  57 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   2 +-
 15 files changed, 592 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0


