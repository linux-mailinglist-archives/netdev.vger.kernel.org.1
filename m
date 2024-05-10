Return-Path: <netdev+bounces-95321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D37D8C1DF8
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585361C209B3
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A51527BE;
	Fri, 10 May 2024 06:20:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823F1494DE
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322001; cv=none; b=EeB3Gmupzny9xD4ij6/yxTIrhlihpf2dizKvq/szqiBTKZEHXt/zkt6A+VKa8tptQmz2jmQgCzXcSsqAUrY1qj7dV9qmhv5o+nrg7LupMyW8CnHi8xjg9O80Ck5t8HjyWI4Cu2BUVTJgNPLpT1Sk9TgAlw2+vJ17yVOklzhDanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322001; c=relaxed/simple;
	bh=HmaUrs11k3LumKWmjlitvpT07wfIBTCqRqIRRTgnBKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rr4T/vWQ9RE6qx+FBtqwCrKhyX70YTJk8QqYhReGFoLdVyorRJz1YoeWRgblQ47RHa4+rrOoMJx3XBkWCysFlDTW+SXpskBWbRG6/qApHdoLSXz9XprV1c8B8Fl5LsS8QkpqPIiG34RBPeNSGwkIrKrboS+CwUb5LbJghZ7wnjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1715321884tamjqn62
X-QQ-Originating-IP: hyH+TIcbeogxTH2zIIF0f2zKzC2oyMeKRoZUCAoVxZ4=
Received: from lap-jiawenwu.trustnetic.com ( [183.129.236.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 May 2024 14:18:02 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: mVJZl7SIEgj+j+i5M12A4DFp/czP2RLVXY9KPD6ltPcupW0uQph18k/v2l8Ss
	MTdz+4e1/J/R30N/MyzqHc0TchnXFUBUOEDofar9Vu6HI1yi6dkdsM/CEeqQ3JIFXjM1+K8
	Y9kIamo+AeXxU//p0meUD3+JQUIabwfZsC+8EBYI5zfSx+5y5o9hGY/Kqtyhr6FzLrq85Dh
	7k4dECL6slsdc8iP/iI3RXnmIAt03vi7wQ+eF1gJ49zYU8O2cqyfCcYqWYV6rVsF6s+TcKW
	0M++4CjrBjnfHrjHy637zzNbb/gy1DSlNRidChYwHQoOvHQk3DpiLYkMhAuoLjUxQmRJ1vC
	Zf8XEcG8wwchn6NOqa16qwy/XKDKOCHa8SJG5scgHif5sbThRs0uKAMppQyIg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7159787598339307279
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 0/3] Wangxun fixes
Date: Fri, 10 May 2024 14:17:48 +0800
Message-Id: <20240510061751.2240-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Fixed some bugs when using ethtool to operate network devices.

v2 -> v3:
- Drop the first patch.

v1 -> v2:
- Factor out the same code.
- Remove statistics printing with more than 64 queues.
- Detail the commit logs to describe issues.
- Remove reset flag check in wx_update_stats().
- Change to set VLAN CTAG and STAG to be consistent.

Jiawen Wu (3):
  net: wangxun: fix to change Rx features
  net: wangxun: match VLAN CTAG and STAG features
  net: txgbe: fix to control VLAN strip

 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 56 +++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 22 ++++++++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 18 ++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 18 ++++--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 31 ++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  1 +
 9 files changed, 137 insertions(+), 14 deletions(-)

-- 
2.27.0


