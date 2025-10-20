Return-Path: <netdev+bounces-230814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1686BEFF53
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F4A401B78
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD22EC56E;
	Mon, 20 Oct 2025 08:27:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050D2EBBA2
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948850; cv=none; b=FnuALzAtmsoU6Qt/jO9mfqh7AO7bw+dne+KFrVixXV/OyH5DwrWxwcPTnUjbyhe21l3BEozM7y20oOWLY19CwQb1/VFsgFrSAO+6rajleRZFZt0Lfa9TRT1N+I8N8SBwXVRgbxeLQHhLgaBInvWf8q2+FGc0dXblOV7rtcAgbwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948850; c=relaxed/simple;
	bh=ZwdRgbqcnFsWN6WfvE1g2b4QFqx9JONqLAPi6/2oWL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DgusY8CxhvbPZ1P9C83ed7edyDz2+wOOWJD6h/vBXzr5swEgYa6K809Qm7rPCkS1q6Py2LTOm91gvtO5JnkCNvOydg0pV/gBtXsGei/i2oqscwqAzIOsx0X1Iirn1x+BrAroX/SoMxw46sZbHvsYnucuIcmjXYON3DUmTCKurQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1760948777tce0773a8
X-QQ-Originating-IP: O86W0xd80Z18zhEVkdoAw9WfNKKjPcQxDpJ/17edr+4=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.187.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Oct 2025 16:26:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9669221615545520294
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 0/3] Implement more features for txgbe devices
Date: Mon, 20 Oct 2025 16:26:06 +0800
Message-Id: <20251020082609.6724-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: M4lPCacZ9YlevvQ98C/2wuMHwpR3av8ZiAMWZthV+I2h9HJZfsnQtC35
	ymwW8qrZRmLCylOLw9OmYcCSiutfHnxFbpEe85shXE1DTlAS668FLaPBSfA86X4dJyNhIpG
	IRK+p8PK7758ZRWJR++Lhw8m+Vfb1VcaOKZNcMLpiK0UGfe9PmQvRhqe6P8Ulp6TrEHTXOx
	VQeunPbEy+HIUcgLcQTYODGBeR0fE4iRXnPESF0ukwFqmRA/yx7vlmnngoj97vcjtJxo2xl
	qk8KHUkkSpUXCqnWOIrrk7NL2dbYubXBTRuDPI9QYgbWntpF+AR2otF9fjaEUG6LKUGWf/c
	VmG5LOIC5usn4DhI1S0xfsOhDOYOAK3PmiXKyaBRTDfUI0o2kk+SxvK5+RcfWSUlVtd3tzk
	K/0KUxGVwTgep5HYisxF+Ae4qLzfjUkUc6NuLbzNDiWRWE/KR7hda6o4WmYu+H61HOFU8rj
	mOibZ6Vprco9yNXjboKS6or5ETfOtLSdD1ZxGg6qCFiybtE66N175R1CHv6EF/E3coP7PKH
	yRZZqRkMXStoikAtYZmEIvVMm61FSBiJxOLnb4UjLzZkFgZXDIXAnWOR/cmjgLRFW2xyA8B
	coS4u9uV1qadYz4EDq+WoOUa9lFOhx86oHUAINLB8a03wQhynSJrMtIZYpqgzIiWM3BA4fA
	Ylc4II9OXVecfe6h5ycztDZC0DdvhgmVypzN6lATVxpRKgAYU3+1B+/phUMVLoZ0qhUpipv
	ER2Y8Z2izOylHA5/Q82QZU7FEIryb0JZ7ZpMDF8thiYwXVxPNVHdcCdAF+N5McixDNnrSPQ
	x4ab/9UrAeVeyHd64tF4DrT+v5HONbEIFWchamOvy0VdR2B45yesZgwxkVLwH0u2p+hSF0F
	+eB025xCs1ceHIxDkjbm9qIUgTW2LuaYI0T5+OsDprqpfxVyDeLsQ54+MRL4cI+BnHYTuz9
	j5Bhp77OYKsXGaRK5nJmhtNkoE2QuEf2zkHv5q9gO0FjNBV5bRckv9uNJcodLi6zuBmv7BW
	MYwnMPZ/ZIzi1FS3HH0TCqFdYmc4NY1aAawBu2oA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Based on the features of hardware support, implement RX desc merge and
TX head write-back for AML devices, support RSC offload for AML and SP
devices.

Jiawen Wu (3):
  net: txgbe: support RX desc merge mode
  net: txgbe: support TX head write-back mode
  net: txgbe: support RSC offload

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  61 +++++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  69 +++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 147 ++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  47 +++++-
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    |   4 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  12 ++
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   5 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  12 ++
 9 files changed, 342 insertions(+), 19 deletions(-)

-- 
2.48.1


