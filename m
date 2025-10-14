Return-Path: <netdev+bounces-229051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8734BD78D4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FA440314C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149D715B0EC;
	Tue, 14 Oct 2025 06:19:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F9A1A23A0
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422755; cv=none; b=NPq2oeukxKa1MCXKOc0wAqgFcYTGh6/VU2JaczP1/cuYVyfTz2trCu9BWOxSaM7Q/IPAl53/430j9KGS4oDcBiwFxPmxuMHYjRhJTmuK8NPVac3jMRirEjOoQf/f6XZH/pB7VgFxLDGus3mu1fzVU/q2RNJeDNlglOiHz++72Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422755; c=relaxed/simple;
	bh=KADnc6FYFhT+mAO5ecPEUZciFiQDrW5WoDtOvn/KKW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZfu/Vh3YlCuk/8CLYclaXMVkbBqWemZiL0AsPorf8d0NUMZwYI5PlqGR+VIjJKmxirJqtpfd3iTbe4WLFvzaNkg/62HSb4z7J2TwZzxwoOqhfG2BEGZ2g74Qn8GCruk+RlJBIWGJ9yaRlBeNk0aXqkXYfFuv06SdNYVrBVyvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz16t1760422653t009f0fa7
X-QQ-Originating-IP: 5fZZJH7c5gw42oYKPlVJ4FGJy4kp9eDSwLyLiG2qs4o=
Received: from lap-jiawenwu.trustnetic.com ( [36.27.111.193])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Oct 2025 14:17:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10539563720760952196
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
Subject: [PATCH net-next v2 0/3] TXGBE feat new AML firmware
Date: Tue, 14 Oct 2025 14:17:23 +0800
Message-Id: <20251014061726.36660-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MxpHmR/vpz48En5r9w2oW3CvpfUZ9ji2Qt1Ej+7OGgUVEyACdLSCdr8r
	XmUNzXqhNsSBG/IkbT6IrWXQlwILiuGIZg108K7XQ0GDczZc7zE9KoITvOhk9IRsnWHJXYV
	4+E1cjN7tcXHnmiagykPJzKVDfewoqzzzygeIw83ZS8MyFlgz93ui4oQZOahjs8teh+i4In
	7yi0SKCDop5yE7UfkpQ1KmVHGYDSJUHfLvdQxuHnkm4CtZQ3wIiQlC7osfmI9WpAwNIM3z5
	n1dlYvsJ5LSHfuEvS/q481iRWW24RRR7ojaKHrjOq2N+V1RW0Rncz2O3/HP/wobbyKXNMVk
	wbARWzeBOJ4IIBxyNONa3cnj030Folfw0sm+1jknoq9SQSZrukELNZ4Dan31TKgKkEWZIkR
	apk42eTF4kQ2E96xItciLL1nVQ+xd6z+wcEMfab3uUGdIjxyHEEXykRTh934lvdM5/H+6au
	pegkdD8HrZBrNJJWxLDq4CWvETX5qewYSfTKTztZDaqftktqlx4znJofZ4NwrwKfBkShHaH
	tCNzeb/KxVZUoCbzL6kUtUUgpM5unablMk7+BOhTd437BkRLrKmRWullzCuWeB2zKJ6+YeO
	ukjOqx4ih7lUt51Xsp1rzzyJsFkd8h+ba+/8VmT4tvwgesH4vBPTorZ17ktE9ld9U6n+MVb
	jVjpJ6dgqCnrv5AzSoEk2IfZ/pMKex8Ji1tWSYSm9lAvOcnDNoPR4MTMkxJeix0paDVwPVZ
	lCnbQzwsbSdz/BkwkvQkL51kRu9knQqKMMXbzQroRpjghfp8XhconxT04zhCx9JAs24XHkl
	dOLRI8+2j68nEV7WJl/snZvSYLUkM6R6LjIo0y3e1YRvQhzly8jFpL+USRLlBa4gox/22so
	J+cvR4FEGDxjPDWZacEsjcIXfrhN3OTHlX1yzQmkeXy9POZxDYh9uGjax8OyHN53SfI/4wg
	32Kguha9Bkq+JoZo9NWt6AxvJJqPSmNG6WNhel01IiJtG00uAmPaTS7cZohhgt4J+hdqZUF
	jVVRPZKEL2x3alxCAF1/lz7yDOaZjs9Gn5CGjFlazYcFkOZTZ82oIOUavHipM=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

The firmware of AML devices are redesigned to adapt to more PHY
interfaces. Optimize the driver to be compatible with the new firmware.

---
v2:
- Detail the commit logs.

v1: https://lore.kernel.org/all/20250928093923.30456-1-jiawenwu@trustnetic.com/
--- 

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


