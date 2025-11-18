Return-Path: <netdev+bounces-239420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC64C68207
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8893F3438EC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2376D2FE06D;
	Tue, 18 Nov 2025 08:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA202D5416
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453126; cv=none; b=Thj1r2w74wtjFScsqrHmNNMcU08kUs7c97JETkYvMuEr39Ae0e0tZLpDaQ5IBchK0LdkzvS5L/xlHtNRKYlxpyc7jNXnPWP+5c1aF6abxy11odHgPHNy721rrbEUZ5xB4Ou9xo6gg3/lDWDaptgBc02eKIbsoWhpaxYHJRVtAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453126; c=relaxed/simple;
	bh=BHzPaYI30ZIGSfNHCykhCxTnSuMt9TFad1RWsd/INDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d+Lt0Dir4A+EY7czTDoho/mfbbgFP0UNFNBrxtCgEPWZH2bGvXgnO+9DqeN1Bqh+5ke6m154mG68BRyws+iJnBfLlrhmBRioZVeu/DRB3zKBo73NIvaQ7seIkfpdGKj++SW/1OnONqJiEbumVR6bm48jDExccrlUt6hCIhCqY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1763452995t49bfdc56
X-QQ-Originating-IP: WhEhDLSr9FOo7BHZcbbeoSb1ESzMrf8Qwfi4tNrtkn8=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.152.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Nov 2025 16:03:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9165256098943442868
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 0/5] TXGBE support more modules
Date: Tue, 18 Nov 2025 16:02:54 +0800
Message-Id: <20251118080259.24676-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NNwhR4tXr/lTWtVw45JKuumUSeBT/Typdr48v2IS7ZcBZe8PgLXxnKqM
	8B4myj84U3lxkwx59TSZ1ofkc7yHHk73Eh4e1nP5hNFLXupvrKF0mgwu3Byse9r6m0culIL
	H71yV8j9Jx5kxXPV5SkNQTgB3jFsKsU3VaaANraAQ3Kb9uk906onAb4BAoZ6RVi+qyMny3P
	cnqtxP5pq+78qY1B9pHZeUQuYW9vZCrtQaILu6mPCOkGUX7GMjM3dJNiYdnc0l6FhsoklZw
	+ZN4ljhuE1pWNBogfzTenHzghhYM+KgPRoBxfD1rNeHTIxZ7FubfTubi16NsQ2FAChuQIzG
	60a3h7H4W2bjrHFgIUMznqGRZb6rc8U2AcSrMivlFDTHuQm3dIHzLPm0MkvafdzFoiEJrCm
	MGZJCSigYLX5GbwhjpqzvuhNODwqBoEiZt6EULRotsiFgO0zTOklsNP5J3tWLWIqVxDdNKJ
	tAwwulU6rU+TVdZwBj/PDtJWKgkZtnGvm5tyNxYy1rjyiF87TXERDQdhr0Rsw1y+Sz6/8tb
	aVr2+poo2GFnGT32wZcOeht+T8z/z79Z4NQekgzaVmolVMYgS1sr/Fj5V125NXR+DYLsYCh
	wPzEuS+wLu5G9QBXb3YU1kYAlV2BH44zRJcxMguC1CObEoOYpiEy8zlZ+YJXxWnSevGNrx6
	xHL3x2K0pvLIDW6+47gQ0lMywUKM+JfuYv3ExEk1aDioFBFkyT/QdNqrW7pJ/gIAdlJ8LmC
	lK0ZDhChEX8/sGhIYKGc3AbOaCDzOJ+mZVTBABOUvaT1M+EY/28rY7DXQq9Ws4mp+muhvVw
	2vFSSN7vgh7cVxNEOWF/6h3y6Bp6mT20Yg5fcq2IiZv0j70TUPREYTztqMaR+8s7C49kRRu
	3Sku3Lzz/37mVsE7q00TXKLWncBmz0iRVpDi/Sx8rkmrJJ+Xce2OSc7LV2Np/8JkliKMk9i
	Awq9AebqLpv8aSKU761T3bKndy16ggsMbydAsZm02Z2lR29IyPVOFheJgJpurMQ9L+3KJOy
	ekta3c3vUqTxqfUX6llGLV5y74aNcqu/6kk7aaCVpfAmszx3/E
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Support CR modules for 25G devices and QSFP modules for 40G devices. And
implement .get_module_eeprom_by_page() to get module info.

---
v2:
- adjust data offset for reading I2C
- use round_up() for DWORD align
- declare __be32 member

v1: https://lore.kernel.org/all/20251112055841.22984-1-jiawenwu@trustnetic.com/
---

Jiawen Wu (5):
  net: txgbe: support CR modules for AML devices
  net: txgbe: rename the SFP related
  net: txgbe: improve functions of AML 40G devices
  net: txgbe: delay to identify modules in .ndo_open
  net: txgbe: support getting module EEPROM by page

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  12 -
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 260 ++++++++++++++----
 .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |   5 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  38 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  10 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  23 +-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   2 -
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  34 ++-
 9 files changed, 290 insertions(+), 96 deletions(-)

-- 
2.48.1


