Return-Path: <netdev+bounces-231954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7533EBFEDE2
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06DA18C691C
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC8119994F;
	Thu, 23 Oct 2025 01:46:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590B19D07E
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761184016; cv=none; b=DDuEB9woSTeoCyeKEMYZZxi7vr2h1mqBBFjJy9mceZiAW/7NkAEgsK6BDJUTxy2VYTgGLP8MCn6wz3lVZQ29Ly2vetlGDzOVxl9ikPTrs/0yoE4HRk8JcljprbqefwnwZ4YwTHbIxyPOMsQSWwE92jw8OyN23aAGjO9/uNgHdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761184016; c=relaxed/simple;
	bh=yO5bZerKcVTXt7wsZaaGlUagMYSMi1Cea+iN0hZEum8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n2nVYGig2uf8WbHp/8dQMb50E4p7HZezcFwo5DCpWqOIw8rCaV89nQW6KrleBX5qv4CNvYdTr7Y5vmCJwWsm206DxCZydtaPRML08pgwfxBOgJODWuJmkLtdO9sFjYYIdfS27tNv+XTVOBKxNP7xYLt7h/kFXyqLFVTcqUxafOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz20t1761183943t745c6a2d
X-QQ-Originating-IP: MNFrDuW36nLpBB+oeuRyxeUiPenvq9KlSaF+5/4wO48=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.187.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 09:45:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12696974371602837095
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
Subject: [PATCH net-next v2 0/3] Implement more features for txgbe devices
Date: Thu, 23 Oct 2025 09:45:35 +0800
Message-Id: <20251023014538.12644-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MfQnJH+7WKv6FPyYUMxJb3FZlcorRuwKbpuuuJh0Eg4/YvwziO/8veZc
	/QNb4/2EpOZ773ZiSZ2F1480jAOGsnrG2XOZL14ML1cKDMRvqmCJulUk2oWaavP9Lr5Jq8+
	x2UX9BIS2DIpXzp2Z+z5L3/a19VXZsAPXwOpQxutbM+Gf8mZpr1bzEqtotX1kx61kPh4kPi
	sXYXPttF7HDhFlU7crtWP2PjRS78J/nIsDwqJ4FGO7mAB1n+18NHN7gjUTVvgcpF+yvxFO8
	xL+6v0VS4BaqqBJsZPkmkLbvtW6nTcL80mysxKRS5GWKqS51Ky5FyKFbpEbVniWplcbsAfY
	35ZEawTCdpYEYC4EyzrTORLe5PiMoAWGUPsW955S38zSyTfzlXthlyIsBbqlws7T4OdmEbh
	hGa8E0fKlG59UeY12g5kdqIj6Rp4sVGs7+Y4J0LTM/4awlSEtBIBtKCyhnpuII60dc6FxJx
	UCbI46vEveRhXnkdDbR41QO/2OVOMuGbNIrIOTwRklq39vJQiT7A6M8Oomlzbi1UFcEiHfq
	q+YcFxFY6IoNX5iICERJaswCb6K2GlbbxnTbbdWwZ/06gGPoQ/HwJYheXDLCku/QF1tuJCo
	mHp4rHqOV7k13om23aGGkh7zE/BUjfMW2Ib3IWCM4q9NSpcW4KUWV+nWxyW7c4PvtFkezvi
	w/hOwx/KNRuJ882l/CSvqTXwHSKL/Ng3xkg2r2FDVjnJU//hd6eZ+NCp+909M99mv/dI3dH
	kVY9H7mFj7Ae8J5YZb3HN9PGZ42A8tLKXJq3V2eWSLAYNP3sYzWBjlwSSnHEvjsANkvJzXg
	P7pQ1L8/PSOvrKgs+wWPoR7iY0t9aHMjrMkD77cCke3GKl5LwGQTRu2uCV3JfTdFKWgyzJO
	dEwy8c5wpogsx6/J8Czanlcqi31Yrkhg2tUTEyJVdxX+a7e1ZG5r0T9HlqXV+tHbOZUOjFv
	9z4RnC0ctLidmy4fXfEiCajLZ/bf4ZYzb+oeRYJGPk6Xi7c5aildhdWQE2Rw+BXLZNO72aS
	D34ijDenOfMz+Ud1v0PWyq4aC2OcBmAmXMopm9lJ9ZDSMLhjmZIKFb+2tgGM4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Based on the features of hardware support, implement RX desc merge and
TX head write-back for AML devices, support RSC offload for AML and SP
devices.

---
v2:
- remove memset 0 for 'tx_ring->headwb_mem'

v1: https://lore.kernel.org/all/20251020082609.6724-1-jiawenwu@trustnetic.com/
---

Jiawen Wu (3):
  net: txgbe: support RX desc merge mode
  net: txgbe: support TX head write-back mode
  net: txgbe: support RSC offload

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  61 +++++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  69 ++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 143 ++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  47 +++++-
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    |   4 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  12 ++
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   5 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  12 ++
 9 files changed, 338 insertions(+), 19 deletions(-)

-- 
2.48.1


