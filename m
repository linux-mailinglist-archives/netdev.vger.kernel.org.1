Return-Path: <netdev+bounces-92084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A18B554E
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42C01C21E3A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6C39FE0;
	Mon, 29 Apr 2024 10:27:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708BD2940C
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386466; cv=none; b=jKM0a+KxhG8A6xrNPEmtmXGvfVRs6r1GpXIpt2C3LbuQetBGKtD1z8AQHZw3kh4Ppi+Z44Ozr17FQ5+nnYOJzf+AKRWFc9sX85wTtUpwH0qGz2LA+U2lJAuEhgwYSqDFROVqYBB2skrDLQWZdHpyJWNDRSpwDGM166qq5Nq6KBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386466; c=relaxed/simple;
	bh=Q33MPfpUb3L4IkgHt9XEDWAQNMhubzsBGR62iZs+gIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOYK4aGmsIyygIVdl6ecq+I7T+CHsuubAR3CIDsHD/7C0uqf95z3XBkiw9VZBt7x3gFjkwxtayYHdSZ7YftAKC/aep4wxbNXm/5G2M0ugHA94Yl1QuvAsdfetnSb49oUHk0iwcKnqa1fUdYXCrgh1pjnwbnA/T872Su0nN0nr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz15t1714386335tv9jhg
X-QQ-Originating-IP: AL9LQXGd/TYgL+5+GIcXQgDP87CeeSEP27Q3XxWsZf0=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.150.70])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Apr 2024 18:25:33 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: QityeSR92A0tKna+fKjvdPp3o8jYrMuzUcxQ9KCRbZ+AUNYjDN6XJ3Etlh7QS
	72gYYS44F8Gs7kksAktCpr/6EdMlz8ktTY80aMLVQ2qQ07WSbrbxNJ6kDqMTMOWyYReag96
	0u3/ntxLylTa47uQe6uIrJJktY589EG2DnfAZmHURQYzbtcwYBAersKDmcdUDNiH7LIYwmx
	VrEmimREaN2Wpk2kXF2zkuqVVGUNwvpNfuf7goezHAPoInuIyvmwn4FmrcPNTCzqlZPcaUc
	gax8+kbnml3j0ZM11TRTpXdbFt56OQsRKpavlO1EE2ffa1LksFzj5ZLcnOqg6bAF4GVlY8g
	7X9iONdOqj6ADi1qvJS8tR4jzazV4g2SQ/oyAiVWkhmJnTDQiO7gOi0szqZazxvQLXSHJhK
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17754811842953559949
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 0/4] Wangxun fixes
Date: Mon, 29 Apr 2024 18:25:15 +0800
Message-Id: <20240429102519.25096-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Fixed some bugs when using ethtool to operate network devices.

v1 -> v2:
- Factor out the same code.
- Remove statistics printing with more than 64 queues.
- Detail the commit logs to describe issues.
- Remove reset flag check in wx_update_stats().
- Change to set VLAN CTAG and STAG to be consistent.

Jiawen Wu (4):
  net: wangxun: fix the incorrect display of queue number in statistics
  net: wangxun: fix to change Rx features
  net: wangxun: match VLAN CTAG and STAG features
  net: txgbe: fix to control VLAN strip

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 23 ++++----
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 56 +++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 22 ++++++++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 18 ++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 18 ++++--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 31 ++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  1 +
 10 files changed, 148 insertions(+), 26 deletions(-)

-- 
2.27.0


