Return-Path: <netdev+bounces-306064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /gYoBfNDT2qbdAIAu9opvQ
	(envelope-from <netdev+bounces-306064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:47:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D9672D53A
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:47:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="ZXy1r4w/";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306064-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306064-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 344F1307F58E
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5513D7A0F;
	Thu,  9 Jul 2026 06:42:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682D3D902D;
	Thu,  9 Jul 2026 06:42:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579366; cv=none; b=Jplldqi4BB4hoyc+VYuFeUyAxbw5nhQQR+IundlF/R4JqQSQPX0t1J6oKvi2hj3LUjB5bI7OmWCB5Mv15XXMVDjKZ005J5JmxOPUVWnWSa/SGNJt1uJNv92ZGGk/5DotODxkvdPAbtTEaOZWw56poefkn6pT1SJJGg1bKU71xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579366; c=relaxed/simple;
	bh=bGBazfBaxIINbA6KbVooTSYyJeoFBZk7o9o2KB5QKDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HH9hIYQyXCRHHbrnjotBCyBRIoMXlDGCzEEkhkNyW5gT76u2FgAOOA+iUq93d6Ls5LlobR7/TzXDUKdBwzOTn1DzcRw/3bBWLKioZCAa6fFlGxxNNP9yR4/bRZu2e6rGW/tx2ke65q7RcS7i5y3iLXqlMg6GrjbruBFS1A4CAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ZXy1r4w/; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783579334; x=1784184134;
	i=markus.stockhausen@gmx.de;
	bh=UaWuu9dtL3vDt91uGr6iD55VTW+AtBtHh2AqwlfB+TA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZXy1r4w/qnC/QQ0z8MajL70es0yOxr3Zk4YUSh4xjgbpdtK8VWX3l3XwUbC7qRCl
	 CDFMQ9S6lyFd6Heq9sTl1QlHAyhfbduMhg5gr8VbjPnxEtBEEKm+7r4GcDB9MR4Of
	 so7JPE5EpykWH6FZzjQzT/2j4D5nC3SQXLTMsec88ApsK3c+KRIMiGsVDSO/gWWVt
	 w8LfzC+C+ymmxYxNkEZVWKNOEsaZ3pPCspw0KBKZznmolVv5B38aXb7ZbxP0/Ihjv
	 xFq1mA+7aclvwuI6yf27k+FryIuoQ8EKNOGliRR6IxSVeVPgFQdswc6x++3N99MEJ
	 WFp2pwe0Kqy30eO3ZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1xGDzx35ZD-00fGoP; Thu, 09
 Jul 2026 08:42:14 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v4 6/8] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Thu,  9 Jul 2026 08:41:55 +0200
Message-ID: <20260709064157.2865063-7-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
References: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OijSNJDXsAo1SUXNo7n71z3x1NJbMI4mY9nhucPg/HILk5a9wns
 i6O0Z6b7th90CF0ut7J8DF9ZjB+VNOnqESS1vKEx3+fTCW+iLTIyt17G46rS8uvti3/NaCC
 H2To0Jg0mPpy8Jhyo8F6Du/p3Nu4SuErYvS7OwYVKFYkDPYz4lQMAHBLd9Idt6CmBb8QBC0
 x3kvfLRmMwAx2KupMxtIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LAQe4zzzW5g=;9cTL46qjS4/OOo9R7RA+0wBqlcX
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306064-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86D9672D53A

RTL838x devices with 28 ports produce PHY access timeout errors during
one of three boots while waiting for MDIO command completion. This is
currently set to 1ms.

Background: Access to the Realtek Otto ethernet MDIO bus must wait for
a free slot between two hardware polls. The polling sequence consists
of at least 17 commands on the RTL838x devices. This delay can be nicely
seen when disabling polling completely. The following times are measured
on a bus running on the default 2.5MHz. Time measured is from the last
register write that sets the command-start-bit until the hardware
responds with the command-finished-bit set.

- average c22 read with polling enabled on all ports: ~380us
- average c22 read with polling enabled on one port: ~380us
- average c22 read with polling completely disabled: ~180us

For this bus frequency the bare hardware runtime for a single command
(32 bit preamble + 32 bit data) is ~25us. So the hardware adds quite
some overhead. On top of this comes the fact that the RTL838x devices
are low on resources (500Mhz 4Kec core with 16K cache).

Increase the timeout to 10ms to be on the safe side.

Remark! In a future patch the bus clock frequency will be made
configurable with a minimum frequency of 1.25MHz. Setting this
(e.g. for debugging purposes) doubles the command run times but
will safely stay below 10ms.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 9141918e7c01..97fb151d8b36 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -268,9 +268,9 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 	u32 cmdstate;
 	int ret;
=20
-	/* Defensive pre check just in case something goes horrible wrong */
+	/* Defensive pre check just in case something goes horribly wrong */
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 10000);
 	if (ret)
 		return ret;
=20
@@ -310,7 +310,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 		return ret;
=20
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 10000);
 	if (ret)
 		return ret;
=20
=2D-=20
2.54.0


