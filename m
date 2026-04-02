Return-Path: <netdev+bounces-274399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WATPLjIYzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:18:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E9938504A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86FE130E172C
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222C83822A9;
	Thu,  2 Apr 2026 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MbJ5ioau"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236838238B;
	Thu,  2 Apr 2026 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113873; cv=none; b=rqMpAU8IjRDSllSmnXc4Icjt+SJN16VP+UJ1VzMqxZWajvVdBrIOIqFWbhi4ZNb4444lYGaS6QEiLq3mibz4ZDyX16tKiPw8ZEq6BhIMC5czfGk7BNDmCBdeU/oTeSOS82qeVn+YeE1qj7d59KMBjCvlWmABaWUHkxWosAlR03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113873; c=relaxed/simple;
	bh=jm1FXZTjTqQIWmNHRIK8WBy9zxLiGDZ6rzNB+PBaij8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVIGrMHJRRIa3+OtwyrbWXf7+F1k2s58sz2n/xcszPJJ1ABGXAuYCuHMJfqTGt84GqMl0W+V2ze9RDE381CGYJzM4vqbyQC0XsLx7xIjsE5Unq9mfU2IU1SGuBEIoYR+WtSuKizNUbSPKMxQuuifjF7DaEjptws2fjad//wjzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MbJ5ioau; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775113694;
	bh=/EDF8vbCixDR+cQpySr1VFlA7poH9R0LoMtY1CfbwLU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MbJ5ioauu/hSgyoJmTr+md5djDL9oUSMZkYaFwzLfTX8PzWvERwQKxD/ly9H2nKCU
	 eSPFawESMIy4RzR9a+Vn7Uhwz7up4OZFq3SmGWwYPHJHr1aZq7JmGmLZwDR2EYzP1D
	 MJfnXvpQgWRemua3Tu9VV0UqEi9lGE0IgWJaA/qA=
X-QQ-mid: zesmtpip3t1775113674t15674a6d
X-QQ-Originating-IP: ll5hvArA3wb3VuAG7IYT6Y+aIU/WYiZFcoug7CkMRlU=
Received: from uos-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 15:07:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16583864949417679068
EX-QQ-RecipientCnt: 11
From: Morduan Zang <zhangdandan@uniontech.com>
To: Petko Manolov <petkan@nucleusys.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,
	Morduan Zang <zhangdandan@uniontech.com>
Subject: [PATCH] usb: rtl8150: avoid using uninitialized CSCR value
Date: Thu,  2 Apr 2026 15:07:43 +0800
Message-ID: <93FF85BB9F33CD2B+20260402070743.20641-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M3HmTlv+XDB5qhX4RBwbX2/d3enucYcZzM9v3c7lJP5nuLspKRhaHiN3
	6f2bk9rVeveDCDxc3EP6st3QhVhV9f2BXLe7vFRXPfD5OoOgtMbASMkhU0cRwg4VJ54svbY
	oankKDizLdyVknm+astZXUE10ZJrmKAeXo+520tQTcpBxfHoE1At0xFqC/slbl9ZqyVJJb+
	jTx00hGcna4TH8GmkFg0j+Wd5lC79wW0/99TlSiieHljruJZ0hMT4n/jWie4cLw/lXAEuhL
	4e89p1RCQFuHVGgmh/INXD3KoHp27F49rFE/nXvLginyiC1FYHwoX1yNZt9uCLHpsLZLoWF
	r5lyzVbCJ9cigys0UQFnOvNqmDx2790hjRxhLjz+1QP/R3lOoZ6YmSjOBA2mPqhh5XvKM36
	PnS06QTaRd9oeAWLKu2al2f3rymD027PCPsGWNjEKb1cKhp+4DbltaNGVeDOXiLwPzYztc0
	B2is2zdAUfQGC3TnxnnaO77J9LeYVUbhVN5REU2R8dm2b45hDxE8XC6IMHOvT3oELjhf7Qr
	Q6JglTlkU0smgx0LE43krmP6XAxlK/MQ0sRzamBTNs9D02j2x2AQnhTCuRGDVw7EkOOjH5L
	47auILhdxhEHyPuKU4cli3yXkQmlGj8AjEtcMV6a6jEyGXYOL2ulGIE7HdsbRI6RXJgeIly
	pnUDSwcnz4AYbERYZxNhYtcndmYeoVR3+h9DIsNXvSlihB4+EHyMOkJoPbRfPYIsmFe53RH
	88UiinQEllNqDBhB12ex3owNS+AqWBilQEn6hv9S/SctIfv0iNj2ZoHY8oXD4meDcCWe8E0
	IXHLh8uVsm92pU+Ul8oaqn1MNY3b8PJ2aekN4I/DtYl4bsCkdwnOQgG15LiPMJwCrB6Rxzg
	uDPamGAIuPkIC0bIlVIvfhk1wMAUAB8N5/tMWB6UsyYdpEmYWyCsDSNvrlc9g2yaDrywTGP
	E/Vy7sgoZJBSJNHWXEnI9VEciUvw7v/DRuWsOILlIQ9Er8vb4KiHB19JOzehlX7rjU511ys
	E3XOGBxRoXi9vrdAQ8elVQkT0pD5BFfI9D46Ii/g==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-274399-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 33E9938504A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Check get_registers() when reading CSCR in set_carrier().
If the control transfer fails, don't use the stack value.

Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
---
 drivers/net/usb/rtl8150.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 4cda0643afb6..7e32726d3e6f 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -722,7 +722,11 @@ static void set_carrier(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	short tmp;
 
-	get_registers(dev, CSCR, 2, &tmp);
+	if (get_registers(dev, CSCR, 2, &tmp) < 0) {
+		netif_carrier_off(netdev);
+		return;
+	}
+
 	if (tmp & CSCR_LINK_STATUS)
 		netif_carrier_on(netdev);
 	else
-- 
2.50.1


