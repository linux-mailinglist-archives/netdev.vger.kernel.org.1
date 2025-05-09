Return-Path: <netdev+bounces-189175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0ACAB0FC4
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B72A500BB2
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC826FA5C;
	Fri,  9 May 2025 10:01:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491EE21E08D
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784887; cv=none; b=Wl2Z2NAXggYRCtcnsDPTJK1o3qCVdhHBOlDuZH2l2flSBS0O9GyEWXCvzD49OtX9b3c4+Ae2Hl/fKv7x6ydQ6IIQi2HISOqNf450SfLfBe/IrP2QDaev29QO28ywOTQWNAh7ObmQMb28R18vgp0+4yUHva+/rw4lkKsZ/SmqrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784887; c=relaxed/simple;
	bh=bNigayTx/IxcqFgNZsBKJzZfsNtImXIKiMYK3bpJGsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/20bbqjT0cSZt1VZX+PmyGx+Rgh3M8V7ReNglRdkrxSP1sF9xwH4ATQa8LDaw+DASIZ5CjHpdAoDLfiGSQLKv9pS7tdXbee9K7r4vlTG0VRePHrpU6VCylVlc00w8QfMFmLtrU/x/kf/0x1oyE0Asx/BnUsBFQwb1m2ir7Ys38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1746784822td5d0dbb3
X-QQ-Originating-IP: WTtGdOJULMlPalsXCRe/TbEhh+dHgYifnOfACvRo8CY=
Received: from w-MS-7E16.trustnetic.com ( [122.233.173.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 18:00:13 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4441921246383831332
EX-QQ-RecipientCnt: 8
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net 0/2] Fixes for TXGBE AML devices
Date: Fri,  9 May 2025 18:00:01 +0800
Message-ID: <9D48EDC6DCFA9FEB+20250509100003.22361-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NahhPvJ71zx0UhRXed4Q2O1SKiA+N4ECrtGiH0WkL408v0WifwxxksxE
	ISh5JgbIZppJkDG7qg2020KpaCKxc41xh5Re1WGHyZbRgW7QrXuy1HkJPOjaIZrbhcKstxP
	9E25P0dfXhLw6pjU/8mHZkDaWvYQ82806jop+tTCQ93WRRmpdBJ9jnscVAtJk4hiISiaoZ1
	ADzC6RiJKnJYaiXZCHJeOBW5m8ACGTw4cIS89XfESOWbI9i8hf3WyrVekIp+0CMBIrjXnQV
	ybahKx9KTzT2v1pHrYjpq8rwbytF6HXKx0rOImSw792cPNYDJ//f3BIPOBYQcbgBDdS4s8t
	vv8BRacLFRoo/qEDCt4fZB9nC/s4P/my0Y5cUlRCD4buS2IO11XudNeOT4M/eshAMAgtoIe
	nylSNKPUNmbFL2zfWYyBLqgrAlF3r11o/83ynoCZA5k3lv97odQF7dfcHwA2V21RM1bCgAN
	2GWucaPPPJ8fcmJg1g3WC5tm9Nf8v5w/BAKt0sqXBxi5lC+bNwALk3xuFPmy8kdvnal2erG
	EKNj1RHddg1ljBmBQ12Cm1st8oWCchw1QaA8q+g8kSpKuMJxJnC2AO0W9RjkUkbjhOmQ1g1
	RJyjMx3tmLgxq/5avArioFqM0GhU6agM4euD1bTAFCRq6clE0Va9Lc2selOH1+lmIqe9YXM
	xYGlP5OY3SP4SC/NAsFQJt05pLqo7JeyZa1aa5LP3PGypQpSlKTWeE2y8h2cGxObLNRlIk5
	Zb7EIdnQixtLjhjrfgxsh3pf4pVKEE9D087AjbKEOU9TnDFeqWzVC2C0So+fCaKikyFIxm4
	S3Lya3xQZ6h544VqoiyptegFpq7W+0rqWVGNeZkQuL6EvWHIyfnfml5RQER62fupGIBKXL3
	SnpssR+Zad3T6l0KV8dloZLOfoBGQJF5i/VQxYgSzn75TVBXkPvLdYGOdlrNUqWaOB5xckS
	qCnj1ex1GKziGCedeV3jUt0G0I3DCZiWoBlH45qMeSBd2LAOo64hrb0sKffhqW/Ca5OWQNg
	TnRk7sn/fHXhByTnOaNYQO8XFGFK43bG3uckW2Wg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Fix some firmware related issues.

Jiawen Wu (2):
  net: txgbe: Fix to calculate EEPROM checksum for AML devices
  net: libwx: Fix firmware interaction failure

 drivers/net/ethernet/wangxun/libwx/wx_hw.c      | 8 +++++++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c   | 8 +++++++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.48.1


