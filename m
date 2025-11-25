Return-Path: <netdev+bounces-241443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EEFC84095
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D102B3A5DA6
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFFD2FDC5E;
	Tue, 25 Nov 2025 08:45:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC382DE6E3
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060317; cv=none; b=dLwHPyyzrQYH1x1XPzwWLsU13/I0tNLQ+hH1IstVPCDtDrEJinohEnCG7xZJlYfmY+G8+gFw7U70JRP+tGzGA6S4+tlWhe+yeLY9Ki1h2h1LMrSQeijpACcVt+83vIx8I2UlDkvig8Vsv3T0YIXFdHQrRZZzii6gvUfDMdsF/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060317; c=relaxed/simple;
	bh=XP8RIFKBxsnEHTTIqWJbld9IX1mc2KgJOrFzmSZOSXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NDsPxVH9vXzZqYFzUi8BmCXFwbR3jy261oTSYnegXMj4Fwe1C6nSXWErPYhxAlPNULlct+JvahdSE3fK4OLjrWeQrk8XBie/9xCaID9ajVw6LKu1PMnbdf08RRCbGORL9Nb64HW3JUn+GmPbvjz6fvjc3Q5az8vqN0C8B+k97yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz7t1764060304t6a07c205
X-QQ-Originating-IP: 4pPsIuytxC1N+IsyDgyb1sTiQYTaj/lu/mTqUyIdAsU=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Nov 2025 16:45:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5236084274655105625
EX-QQ-RecipientCnt: 2
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>
Subject: [PATCH net-next v1 0/5] A series of minor optimizations of the bonding module
Date: Tue, 25 Nov 2025 16:44:46 +0800
Message-Id: <20251125084451.11632-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mdc3TkmnJyI/QtR4o94tH0Ouwmwcg8zJl2AWZNTdGDuJNA+VPiuCdaKW
	tbQvkCQzFWKQ0roTtkpO0yAP12ubjz7AddtZGrMyn/aSRNlzPrpIayiL4uP70/O58uoMRyK
	LcX0XkZT5hDdt0XgVJkydKFx5lxxdnozW2tmJKLpcrrRrOqjg6ifrcSbu/ZWy51xhKd34Ed
	egSGlTfHSu/mH25RUp8E7iLCjGUmikYXmA4vLHudzHAVpg3pwMinMQF6KCymmrTuI2S8KAK
	YX+EULsvXzUbzLl3Zoa8Fa9bnePfHpYxc4Pnzm6PASYox6VKVKN73nC0YdDV7Rh5TDKZGWH
	AoV3JH0TZ6iWDdBHHoe9IfM0QcemQHsg0AdOdkKr+1e7V9TJjH7oR+OQvM1hJNiED9VK2fv
	ocJI8TbFe9dUz2TcydMbCRlxq07960yb/ZJ2jD2iN2qXsWszA7P2QSRF8hxcKBaoB+oIWIP
	izJj7tIIKlbH1kgziH8EumJ+D35SSHHHoXDLU+pVeNEf5XPnB9inIFM3QqGVZi6huJXFW7B
	yzyunVzm0Xvp1e8UM4nn3cN0b4UHJ13hI1F3nsRZTt+UJ+hbiL7Zn+2eoKfX0/cKpn1vFTl
	ncby31zkigc5Uvalb2USJThWyTGw0A1uPASUQ8vYVoW+6LvhysBiHccEaFf4VCFPY9opL8d
	fQrlqnkUv6c0Bh31kDqVv3Dn1Y9DDhVhKWghDeq3U3GRFxSbra+1bqibglUTMRxxwhbhyE/
	IsCmpzieK94C8fnf2DKzbd721Lytxo5gJSsk8Rz8YbpVpmJRrsUeY9bdzD659O7nwHllDQq
	1jFUETAbfRnaje7Y4wPfCJPZLJrNwErI/Z+xP8Ym/vrckZeQB3VTM8ECkJQknwzj50x0DEz
	LpeUxe0A8n4swrYGcVNu97zd5aENaqM8xBWwqsDi6x9wJhLqsv321cRlWD8UpDHANHjiE63
	fi27a/oI4UgiFBPnQ+esVsu4Om6uDObT2f5bzrd/GiVTJd1XSYtYohjxQfJJe/vSYcOwGr+
	7AT00kcbQKD4IalIa3
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

These patches mainly target the peer notify mechanism of the bonding module.
Including updates of peer notify, lock races, etc. For more information, please
refer to the patch.

Tonghao Zhang (5):
  net: bonding: use workqueue to make sure peer notify updated in lacp
    mode
  net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
  net: bonding: skip the 2nd trylock when first one fail
  net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing
  net: bonding: combine rtnl lock block for arp monitor in activebackup
    mode

 drivers/net/bonding/bond_3ad.c  |   7 +-
 drivers/net/bonding/bond_main.c | 111 +++++++++++++++++++-------------
 include/net/bonding.h           |   2 +
 3 files changed, 70 insertions(+), 50 deletions(-)

-- 
2.34.1


