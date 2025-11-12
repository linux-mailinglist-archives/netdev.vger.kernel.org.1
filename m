Return-Path: <netdev+bounces-237829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E7DC50A9D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3133B546F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 06:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074D444C63;
	Wed, 12 Nov 2025 06:00:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612D2DC32B
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762927246; cv=none; b=WAIlIC8L4cQIm6md3IacOyrWpvvgbPeBoyAf6XZcC1RXjpOgm0EEbDKSllmL5E71pefR9reWHAP1sdq76BXZZwLS3V1w0xWY5olf9h8V/I17YY0fLaoXTENcBo9sYlMHmipRaaCkNTwLBGa+m6hx5S8SLvTmJSuAbIURNdoeUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762927246; c=relaxed/simple;
	bh=FOqucUdCZOS1mtJHwwlxROkUBG+hwnKLo48NNKdj1zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P1TX/L1d7+VFwNxunJ2eN+2aqIw1lfEXoIfQUaMgpt9YQnyQvMon5Jeb6xV9jhlKb1WTOp+gopA6VZFZkVoRXLqAmrqbVBqvGUMnNk8/z8Mw4O/9xmPwG8GGxXzWnN7X4EyKhIAKaf5M8tH00TQNWafLFveAtpzWTDJrwRYqtP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz9t1762927128t1a8cf690
X-QQ-Originating-IP: jvgVDsjHT7pmwgRnG1y/IgeAbbAG9jIQmDb+3P/Ii2w=
Received: from lap-jiawenwu.trustnetic.com ( [115.200.224.204])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Nov 2025 13:58:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14455159067176419765
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 0/5] TXGBE support more modules
Date: Wed, 12 Nov 2025 13:58:36 +0800
Message-Id: <20251112055841.22984-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M182XWJxg1fqYEJ+C2Qo6jK3GJlPbj82hHJuNWsG+JZpyCGY+jZ2WdKS
	4ex/Y8BQqvwyL9hYEBy98xQ1sFzLWLSvqsKwl0OtbcrHq6KHJfwogC9kGaHPMezakwjF5gJ
	qEUKCYzrunn1222Z3yyrjdcBpcW7S/eKjPNEvwfpAHru9Vnmke8JcAqXMXDxpzCukILfj3F
	N8zZ6jbOvM0Dwhw8vod5XFwcXbLaVkFmqrqpmPPn4SXlXBhJp0Zuujr7ADKRzkhHkeSfg8g
	q9uOm29ERXLAYrn1+E7ljl33ScrEhiJu3qxg6yGhNjngrDOyNpoCXyo5Y3jiLJhKII+Ycuv
	2wG+k57ICyiUrZeK3UrzXBh1+Y2eH9IA+NoZ4medRdtL2kxtCtZPjOSAVG5WP3q3MoGjXKp
	BsLfW4/Up7089KR2T4BfUJF6g7g+PspnjvRc1x5e/ApZlJesRHuH4SHkgcXmaiuIO0qw3It
	LzlX3kMCSzLOmmsGzAb0LBN2e2Oqhk9T/qalaofZH57y2xQ4s0aGufkwyM50h02qU1P1q71
	+CZmoETmXJdrfZmLGtLP1JLJJet293lfq2Jq9D0Mi2ds8lE5XKSzqNEACueozZFEyjq7vM9
	ZqmpnypsZC+XDNhuA0nmSUDSOHoNQvzr0Op90hPciXH5Gr3PGMxBwpq55Lpldr+hdtjxslG
	oo1tv8pthjYE9Re+5GEftH1WIIme1PTDiCchcE3xkP8vQQird75wvI/aPUBuF3DBwhYDl4R
	JowHcQwC1FabXay83AtQx20X7TBZeztSpeGXMSAaCnWqaVnzkgxV0mp5xxaIZJuIs3tl8ty
	OvOlBG4pzo7o79zt61PDWi14vZTtszLCqUar7W+yLv0O6BPYbezN8oriVM+DN83VPZOCfAR
	nyqnuspteS0Tgs9mqdQ5PpnDMOEVCX2OQawwB9D4BvkyWMiG0Vio/qySIE20sG9zG/+E1RE
	Y14agehHF88g90Kq2ROKiqkPKmWmeJTyE20g89E4jvCpvhZlabfqt04nmCHJiy02gcfxywv
	Sztb3vfqMUt4rOgIIRJ4RmGZMBTcJ2vcABQSHJcA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Support CR modules for 25G devices and QSFP modules for 40G devices. And
implement .get_module_eeprom_by_page() to get module info.

Jiawen Wu (5):
  net: txgbe: support CR modules for AML devices
  net: txgbe: rename the SFP related
  net: txgbe: improve functions of AML 40G devices
  net: txgbe: delay to identify modules in .ndo_open
  net: txgbe: support getting module EEPROM by page

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  12 -
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 264 ++++++++++++++----
 .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |   5 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  38 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  10 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  23 +-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   2 -
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  34 ++-
 9 files changed, 294 insertions(+), 96 deletions(-)

-- 
2.48.1


