Return-Path: <netdev+bounces-275848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBa4DJpy1GlquAcAu9opvQ
	(envelope-from <netdev+bounces-275848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:57:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 842263A9440
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7D9A3004DE8
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0A1372691;
	Tue,  7 Apr 2026 02:57:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1611474CC
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775530647; cv=none; b=KViuI7o5jSpUbntsaLDTWfFA3GaBSdyMbH//A7ggMQDFfYBQPHqKi/Whny/kXTlzP5e2XbJ9Djuzsnb2TWgKBzT22VcIQCWUswVc2J9sA1/eRmJTqUsolTYTgfTalPEdHICbTiNZUJYMJKEXYQaztNc3IcaPSWWLK8tqfYHa7tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775530647; c=relaxed/simple;
	bh=i/OgHkSU3jjEy7OV9IqUpuSSx/2kUc+pyImprSLflrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hhMfsMUD+ry4NHdkljSMps3T4NgQR+oMPeEr8E0RozbSf92szkkIA26B5Y3GGGRm47j5rAw//GguBM62XfaP1IoZf1xqTk6TBkYwefY7rRzMIh/9eKBeddn9pPafFD370T0i6KDPDtb4HjRNhLOoDRH6F4Vhued7FQufyEFB8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1775530591t3b09fb30
X-QQ-Originating-IP: +FE+jYRq/pVZEGnvBpFpOd5AvrGuDAtJk0djjX4+0Q4=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 10:56:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13124595242704030276
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCH net-next v7 0/9] Wangxun improvement
Date: Tue,  7 Apr 2026 10:56:07 +0800
Message-Id: <20260407025616.33652-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NpfbsqbTlzxU9vxAeQ8WSUn1MNUvhYb0hB1k0A5ZxWRNPBPeJCXIo0gW
	3hoz9n2NjPbqWtzqgc17lnoo3MoApdOWtlmOqWT0lOcAbkdgu3OXlgbNh7X9DLBwB4mEX/X
	GsDhl+S5fQ9u4mpWcJWhDrPw0X6fv8/Qt4CYfquVE/6dPXgcSlGkIT6TxFo/isYVuDgB83/
	uMRTnfNGDntbODdYUU6DxOUasnoQkG3gmwvJo4Zh9AgLFkagY+OOT3ihs3dese0JJ2l7Ai5
	OMQfJvV0g/gjP6RRoxKwYT6Vq8vVCtyCUL1uNw5DzR3xHBkgfdeWq7ZI3ln513Rv7X2vlcs
	ELsJUYORvchcdWrpXe176fHprdPf1yR9vLj/SgbQqk49P0Rtr8clSaBP+LXKPqhyXq6CShm
	vH/zVdlOPmNlrJrPeVAEBymv4PwUUKupI0+KAS3mwNYau4t3u1+/o1G4i3VJaBUyBJ0rs8f
	oCyuLrmROVc1Z2TSguZnNfEODNS+9PfmYqOFWAz7Fx9aL2ayv8Aw+gqSw4CQSZISOow+hqL
	lbh8tiyeCe91y/6UE4ETfwlwznlSkq8l9Rlg7kHFlb8GggcLtJqyhAIh8hnV74CajI4o4nZ
	6TeWYyvyP8MP2MsP9aBFdiPPRz3mLfoku3Kkpxdy/gMF9UL7UAAMywOXsTJZh6IAANSA4Wm
	AxjFWexhMlISczPHWuaYnMiyjrF4ljdCUQkb5SoisQFjD/japsYEX+HJgItCsA6FdYgKIZd
	/a5PF4E5QGmnkCKLmxFJwg3XYEuEyqaxEIIaMKraU6jUbhIAhQBvsnTH9u7qAOhz+3runGM
	hAcD32JI5dVTIz8/uQeL57PysS/m3gz69TSYSbUGtcgY3v/3gnfCO8yS2KSpNpzGta8kCZX
	wmUcm5gVycHcJMxTpzNuMHcjdpz14xm3oKDOxmz56IkvsPhQnE+tU7BWaUmgWUsRyhtcqTN
	thIEbrXv9LpqfjfB6Onu5phe7T5UwnLTfeT6qQtKw0UlHLqsmt5a1iMY6sLDdhULvPr2dX7
	UPGFGyhgkLIJSIdgKcNVILvIvB1F+MV3GOUuPsf5lK5Mdk1BPwwTQauC2sLcY=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275848-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,gmail.com,debian.org,trustnetic.com];
	NEURAL_SPAM(0.00)[0.366];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,trustnetic.com:mid]
X-Rspamd-Queue-Id: 842263A9440
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series cleans up the code and enhances the implementation.

v7:
- Drop the patches about Tx timeout, pci_error_handlers and ngbe reset.
- Replace busy-wait reset flag with kernel mutex.
- Reorder timer and work sync cancellations.
- Add spin lock to protect wx_update_stats().
- Enhance the reading of the registers which are not clear-on-read.

v6: https://lore.kernel.org/all/20260326021406.30444-1-jiawenwu@trustnetic.com
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

Jiawen Wu (9):
  net: ngbe: remove netdev->ethtool->wol_enabled setting
  net: ngbe: move the WOL functions to libwx
  net: ngbe: remove redundant macros
  net: wangxun: replace busy-wait reset flag with kernel mutex
  net: wangxun: move ethtool_ops.set_channels into libwx
  net: wangxun: reorder timer and work sync cancellations
  net: wangxun: schedule hardware stats update in watchdog
  net: libwx: wrap-around and reset qmprc counter
  net: libwx: improve flow control setting

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 37 ++++++++++-
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  4 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 66 +++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 53 ++++++++++-----
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  9 ++-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 57 ++--------------
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 52 ++++++++++++---
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 17 -----
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 21 ++----
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 16 ++---
 10 files changed, 200 insertions(+), 132 deletions(-)

-- 
2.48.1


