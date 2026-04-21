Return-Path: <netdev+bounces-280076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PKeL+5W52nz6gEAu9opvQ
	(envelope-from <netdev+bounces-280076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:52:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0B7439C46
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23BB9300EDA6
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE653BADAE;
	Tue, 21 Apr 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KsYIsRsD"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94823B637C;
	Tue, 21 Apr 2026 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768745; cv=none; b=Riv5W+OhadoBjtgEJKGG+XE0c44TEi8EZehnSK6KLnF1w+NNAnM1C/um7cyYPBFqr1wpKoXcZEvTBZIEYhJiiHUk/tgfYrMDyYdCeF3reIDwRyvIdit/5BaX7ilqtWm1MJ4S+bG6vuNih4QPSfNWtT2yp46WVIafXq2O1qt4DH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768745; c=relaxed/simple;
	bh=zXNR/I/IY9bdmR16CFL0KUSVsidGKifmSX+eMk/A1XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZZgWDs5yIcRVy3k7Vsk6czyp7Bdb2XElyQhgu0mRIBj+BMYQUJ8mdnl7MK07WxTicM0YcGvKaWAyUOt6EbNycU1CjT7ylAr6XinLUbSbQBrLtJ1lJaOCBalE7Phkf+6FhX8NwQsutCTv9Fb1XhC/sA8aNtCpAhvf13kHRDffaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KsYIsRsD; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776768726;
	bh=lL+zEKtbVR5HcKCyfIHHTKHz27BeW7pO9wdhMt2J/Q0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=KsYIsRsDwHhnWFJXImGnP1kr0F3H+r+IPU5zsS3e5tdrZG6D9T0XlvCt19jP9YG3x
	 QASISw4GZY60OnKNFdwwa/AeW0KRr7EnvtN3RuBX1yNGVUL7LaGXd58yXcCNpbkprG
	 ZxbXBZ3gH8CeDt7wDXX6V61Dc4ZnLzdeGkdj+9lo=
X-QQ-mid: esmtpgz15t1776768712t4fb74123
X-QQ-Originating-IP: l+5zUDunmVHcQ0UNNQ2Wy9A5LGsOE5WzCWoocJynVSY=
Received: from uos-PC ( [117.152.201.246])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Apr 2026 18:51:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9288592939298849306
EX-QQ-RecipientCnt: 14
From: Morduan Zang <zhangdandan@uniontech.com>
To: zhangdandan@uniontech.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petkan@nucleusys.com,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Michal Pecio <michal.pecio@gmail.com>
Subject: [PATCH v2] usb: rtl8150: avoid using uninitialized CSCR value
Date: Tue, 21 Apr 2026 18:51:45 +0800
Message-ID: <F20002D619544E87+20260421105145.11394-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <93FF85BB9F33CD2B+20260402070743.20641-1-zhangdandan@uniontech.com>
References: <93FF85BB9F33CD2B+20260402070743.20641-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OIT7mh5ZveFpy0OQp1SF8wiQDSXU+CIIhoCaXi1vgOz4PEaUmjfNnuRl
	a49baaDGDD07B97aiVOb6uy0AITJ4nALXaueROAyM0vxbYsiIzPzqVXLQZQ0Y+nvIr+804k
	JwWPJwVUc244Kl1e3iX5YOuB5sYF3SjOD1XJns8Y3SqHJhEqOy30vJRbCbJdGSrTEEKMnUz
	iRcNCWg3cUZ1x5vQpbiBxIaq8/ymKRwtdWDavwFBmgAzkZfNdxCQDTZvcYrNN43podhonxX
	Tzp+3pTT1nLwO/CJupCo1Bi9O2Au9I4J0TuoFFmXa6bqpTjTsCS0escWMcKnwJ6N0OeZtpi
	1oJDLVxV0x/A7+t+C/Lee6bGb0josCapnhWetTTe0T6KeU3onryj4xv2BITRPs93xv6AutL
	r11Db8e01oqTwNmAFokcvyGdWBA8n1bU2pZ2GhQz97t7nWrjMyWW5jO4P+xnoca0RPU06I4
	oyMOFEzEgtUvxl4IBM5in+PCeZP8TrRkMzFSDWVZfx+9ZZTk7K0DiwOJ1JsYOvI8yDczBbq
	gDAvTkjvoGSUaXVbH2xLr3/hC6eUhcOy9B73bPSIgn/mw3uT3mePpWaiRQJOUWZHdeu0sKq
	qsbhtLn7Lx2KZOE7Qix2ASmlxrumXYoSPowF9VbSUTs4qkhQr3AE1fqZNraN0FuigNf0bwu
	w9l9SbxVoqRmORJtwsbYRBbsXg234m53riSCqEKsjDQS1YErcxKC8QkeijXWV4PV8Mx0Fef
	qwMgVnQYDN639O1ErWQ0KXeJanA7/a7wb/eaAB2zlWL8XhtO3kDAJHIBTV4zBW97/SFuqAA
	lk33IhWnjT7WbyzTfonKKb13CwJ6UEGq6yNI2jfOsN2TvEcgxSpuMvHjHcsxRfq0jgi6kb2
	RWvgbQ/GF9fgzVIvObKpwx915qXPd8npuDOJXrXtafayewEtqxgDmU0TMzotY8uF7OhDn/a
	ZVR8amNGlg8aZtuAofIqQMbpjo3Kx19Ts3PIjZyRqd5NqJ4Vexef+KFeDKDFELS5TQ0g8DF
	JK4BR06hTNRcEOaOfBKQf3sWIPY0/h5jqHzArqo8w3DPTv6u64GdshwK60A3/grI6l5xzsc
	g==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280076-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,nucleusys.com,syzkaller.appspotmail.com,gmail.com];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: CF0B7439C46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

set_carrier() reads CSCR via get_registers() (a USB control transfer)
without checking the return value, so a transient control transfer
failure would leave the on-stack "tmp" uninitialized and then be used
to decide the netif carrier state.

Check the return value of get_registers() and bail out on error,
leaving the previously known carrier state untouched. A failed USB
control transfer here may be transient (e.g. EMI, flaky cable, retries
exhausted), so it is wrong to force the link down on such failures and
cause the carrier state to toggle unnecessarily.

This only addresses the uninitialized-value usage and does not change
link-state policy.

Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: Petko Manolov <petkan@nucleusys.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
---
Changes in v2:
 - Do not force netif_carrier_off() on get_registers() failure; instead
   return and keep the previous carrier state. A transient USB control
   transfer failure should not cause carrier to toggle.
   (based on review feedback from Simon Horman, Petko Manolov,
    Andrew Lunn and Michal Pecio.)
 - Minimal change: only avoid the uninitialized read; no link-state
   policy change. Petko's Ack on v1 is not carried over because v2
   changes the error-handling behavior.

Changes in v1:
 - Initial submission: on get_registers() failure call
   netif_carrier_off() and return.
---
 drivers/net/usb/rtl8150.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 4cda0643afb6..816759ced56c 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -722,7 +722,8 @@ static void set_carrier(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	short tmp;
 
-	get_registers(dev, CSCR, 2, &tmp);
+	if (get_registers(dev, CSCR, 2, &tmp) < 0)
+		return;
 	if (tmp & CSCR_LINK_STATUS)
 		netif_carrier_on(netdev);
 	else
-- 
2.50.1


