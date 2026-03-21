Return-Path: <netdev+bounces-270199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLpgO/l5vmnpQgMAu9opvQ
	(envelope-from <netdev+bounces-270199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 11:59:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6952E4DC9
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 11:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 936F63021D18
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B436A01A;
	Sat, 21 Mar 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="uiuj5gJn"
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71562E36F8;
	Sat, 21 Mar 2026 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090743; cv=none; b=h8rKBh0O4KMzmuttTYNh3BpBd+IuAc6WKn7h8GdTH3McsbC/TBA8zkqZmgYmxKzN9djVkqQ/SQBe4ki3RtCOtQabkmGQVR1/Ev/VT625S/FxPYf5+KfccODK6dlWvkOKERK1et3cS3aJpyxLgYpVtZNV770pDKcAnO4s7rwc6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090743; c=relaxed/simple;
	bh=KsdXqX1kOxxmB5a/Cg+3C/JOFCSKlf+J6VeRfyzA0Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYcrO4aXw71eHqkW0Qcfde4FT01M+TOIx1YFC/VMvP8MwlZmbxZQP9sUE41Z1Z6gFIuex2cel1o98CcsKtOB91A97g8cySVVEOeZ6UTCaoSSJ+NEvhR3B6aSbQNczj3zduaJAnnpiDkcj8prvPjDE1y/dmVfYQSYOQtPPc/4ubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=uiuj5gJn; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090712;
	bh=eqAyqeTqI9tW77At+0KENVsKp4K4ZhJUfHlWcQDIO8I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=uiuj5gJnPtvAn7RJf5H5L57EnW6uep99kOlzMnKssVRg8wSSInxaNBEDd40YXWBkN
	 ciDBatpKzk9bmZc6Z9FJl0QEWz4lTIE9IgJY1+c1bI5+uLGeFe8DjTdEznwU1g9/bJ
	 2awd+rGLdBipbOD4GjARfqGscoq0U+7ce41c3e4M=
X-QQ-mid: esmtpsz20t1774090709tf548b294
X-QQ-Originating-IP: VIScFZS5PHi90zs142j97mvmaooRkR5YzU+3umxrAHU=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:58:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8588313914025312170
EX-QQ-RecipientCnt: 14
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] net: phy: update outdated comment for removed phy_package_read/write()
Date: Sat, 21 Mar 2026 18:58:25 +0800
Message-Id: <20260321105825.7221-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: OeDJTi1d75hd2JBeI8ymIo58/omwOrMZZidPZo5NAdndH90BY1pCdcCX
	ysQbQhUUNbjlSbMEs30h67Hng+sbjyGYuuI6A4x/NS3IWSWpYtbApn366L++9J9ws4dpE/f
	yWtjPMEBgseMjvOn0vDBqgUhz6pcr7y8I5W27cb8jbc0UoDFKXI2yh0m1o52bMlHUHTLLUm
	XCbd338SKSwvFTMgS/lQ7M834Cid3wHxSKv864w8EGoS92OV/3EAesbcwJ0HIYf6iBOZccH
	LIcnUAXKtllN4LG5JxpbYmAfPbcR7clEkeLApCbX9UlqLbCp9BbVHWPiMafvf1lVQTkDLAM
	+mIQEkbVUVuSWMuXzk8rzsSm5fgnqEiOp7RA8hiAG3ijc7geSSWCgpaoLiFOKSuykrBlEs4
	hFeMZI5TN4zP87tywkFbgEGpJgq/7W+QigYy0z5BdPEgFT1AWVNW2yQOTWbTsRNORqW2Ksq
	3WOInh5uA5q7US93LRbzZ2wHFpQImXCXzVG0P7EXXnwDDi1NP9WNd2MZc30RPGPp9SFIUMa
	bQs+Ls72q8t46JYh6dAwJnkhZHKPQm1iZiZsFY8Tx97bM+7WNH3F137LJ8U63KHFsjGLUZf
	UHYpVPaPVM2XnPDHpjxuC7dCBJ8UGUeJj5ebLVF2YdTcUhL24ondJfK/CGmxQBNzEhaVHU1
	ktqtuRE32JZmfUA/gTrnDBalYT91arrD0ovJub6pfjRhcXCAHMwXP4S5TaMQqNo0bqtnTmE
	4J7snepKeZAoy3s7UQcJ+AZcpNgh0OPXisvysYQfM4xD+nZ0uTd/FCSxqRIs8p3sEMnh06k
	2PWvfq7TTY+g7rgddnfkNzVBRvqwMU9azox8fUxstXOSJ0nPx8fw1y7ziPv+q87qjkTcU+G
	ADbfAJlV+Dw5DjU9PL+hXDugIdAReD0kte4GIKZUa3+NxlIbzHYwZH+oNnAo2eULHe2bzd/
	U+NaUcF8d8dX2xfw7wMTQzs+qb3JjkDC/f7TOO7Jfx2Xl+0zopUs579cgnSnK0BBJmDInyG
	fjWw02a94VRxHqc6nZKAtl+nIoz9a+VIAdb7nX0tnQUecucGjt++7Hpuax/UKDlKd8Uldfc
	fCw1+6xtEBAU9CwcYacbD4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270199-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nju.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smail.nju.edu.cn:dkim,smail.nju.edu.cn:mid]
X-Rspamd-Queue-Id: 9A6952E4DC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The locked convenience functions phy_package_read() and
phy_package_write() were removed (as they had no users) by commit
e7f984e925d2 ("net: phy: move PHY package related code from phy.h
to phy_package.c").  Update the comment to reference the existing
unlocked counterparts __phy_package_read() and __phy_package_write().

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/net/phy/phy_package.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_package.c b/drivers/net/phy/phy_package.c
index 63e4f862f731..16ae8d1c1f89 100644
--- a/drivers/net/phy/phy_package.c
+++ b/drivers/net/phy/phy_package.c
@@ -194,8 +194,8 @@ EXPORT_SYMBOL_GPL(phy_package_probe_once);
  * for offset calculation to access generic registers of a PHY package.
  * Usually, one of the PHY addresses of the different PHYs in the package
  * provides access to these global registers.
- * The address which is given here, will be used in the phy_package_read()
- * and phy_package_write() convenience functions as base and added to the
+ * The address which is given here, will be used in the __phy_package_read()
+ * and __phy_package_write() convenience functions as base and added to the
  * passed offset in those functions.
  *
  * This will set the shared pointer of the phydev to the shared storage.
-- 
2.25.1


