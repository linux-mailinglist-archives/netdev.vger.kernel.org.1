Return-Path: <netdev+bounces-227011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 179DCBA6DFF
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 11:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA7574E05F0
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F3C2D6636;
	Sun, 28 Sep 2025 09:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E1298CA4
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759052473; cv=none; b=Q9F1sw9l2FxypSFl+RmIIL0UxWKEnvFNZX+QHft+fkENw5L5wDbWMzO1CQCKJmO9web5a10Hh0czTM72rqn8vj7p7GjgxuFpKGGRc+CTrn5DjIjBIdAJgi2Tsit9EBRwVfbEY0y27beH1LVHY3f9GyUo6ME389ojkIjhzVFtCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759052473; c=relaxed/simple;
	bh=zxWj32avZExS1tw2SyLgeX/kHceIkgtpT+OeM0Jy7U0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HyLzpQmWwU1aEIxRZ2BlsKOrUzOmaNPPbpCyTx7hPMA7DsCjgBYPinnRv+UUWnBkOuVswgTGS4y9ofT8ABnZ6U4rbBCiOivjLVHCQOZheXA+5qrdmd3t96w4VdHdHXlYJZWR/jmkwJc7KGF/GuUcaiwR5vO249d6Q3PFomG2KcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1759052370t05b9b0ad
X-QQ-Originating-IP: hbfx45qwpWhSZhdgNkzIvzLUjqNnqkgceTV5/v+S7Ok=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 17:39:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17010562721259606880
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 0/3] TXGBE feat new AML firmware
Date: Sun, 28 Sep 2025 17:39:20 +0800
Message-Id: <20250928093923.30456-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: N/EN6P+BmEafCy/1keUGfUTmpgzKdOsNFzEHxHvbeJwdsrucTfoOkA/Z
	UL4EVtwVjtDBttXnSA9kht38FOWDUlTDdWgK4WcyBV5OMaJYQb5PX0FqxdZZaWBebHiI/7G
	Tt6IJUyB3UNESPnf2Z0DU3WGvF/YlubiBsu9NJATJstnSFej40Dh73njxA6RDvXGoD1uQ7+
	pt9AQ3CvEX0j4s3A1rt9qIQxKOeQctJnuzil09JAB/hxcwkQpERFG8u42JrMgA9VTc1lo8l
	+rOESJMjuMVFtj66SKgY76PmDJsleL2Wfe4LDCCVWG/EC9Xb+0bvyl0hYy0AtWCyuHuF4ir
	pf3Vw2yKVEVdmnqgkQFSV4o8rPnWRD6CA8q1+ZhYOEZO/EkHQlDQQaKfEzH1s377fsHZ6PX
	mFN6hwxnUT7NeFtxsfpb040Ecyw707zpdR5Hgxp2Sv3nRLl0J6ojJEBrD8fbt7Ukiksc++3
	kL+6EvFziFkb2302rO7WEzgjnDjzC/zfx54YhzSp04sUBDqwqICQyUZD6DVEmjep3Q9rB0g
	giAndqKrYgV6YDPEgLKTLlQrK8kyB06WLObB5ReVYr9YEJUL3/lh+NKKlJVILUzskZ+tniP
	9MeAAd4/Xww77PpMAu9XLFcCbkkbRgwa3i3TspU8pvk+W0S5hV9yf8GVWy8bboAnPsVx/6c
	QHwwmozyFEEcbyrv67g2yc9Pt3dH+ksUbIMEUw7Sr7Q8JEKUYEnPePc7JKC1s0kbu56ByND
	Iwbw2wSZhLOvzESbP5dnLz+Yn/8e8j4YDhJKBCHWvnKvYvw9uWpLdQrCRJNHuftlivBNewg
	+tvaYZHIJXhhVdDbH8g9vFe0vwlffSEB2Olz4avNopsy34Jf98FrFP2zYK2kV5CATiD3jbK
	GlcHxnmiSsv7ksNvnT5hltWSSyWULpAVtjieRz+sYbO1MIDeepclEc1/xbjXNI5Y9Mh6eA9
	TbeW/JLa4VggLupFPjG9esqu+fe0H2NXr+ZY8p+2vDFqB9rEu8Mh91aH41HquIZXnxfAiPf
	rcGVGCWAqCGw7XuBXu2IuHEdPUWT6hV8r1wvu+0A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

The firmware of AML devices are redesigned to adapt to more PHY
interfaces. Optimize the driver to be compatible with the new firmware.

Jiawen Wu (3):
  net: txgbe: expend SW-FW mailbox buffer size to identify QSFP module
  net: txgbe: optimize the flow to setup PHY for AML devices
  net: txgbe: rename txgbe_get_phy_link()

 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  2 -
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 54 ++++++-------------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  5 +-
 3 files changed, 20 insertions(+), 41 deletions(-)

-- 
2.48.1


