Return-Path: <netdev+bounces-17941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A9753A29
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5F31C21661
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED7813708;
	Fri, 14 Jul 2023 11:50:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CEA13700
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 11:50:05 +0000 (UTC)
X-Greylist: delayed 141 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 04:50:04 PDT
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB72D57
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2LdjwDnNRZqkW70gTk4FV6wOXkNVB+OD2vJbf3BmwzY=; b=KfAZ5WIhusEeOrvB0OdZumb/3V
	jQFmvnbLzPUOtbe35OLt6xg66PD/ldw+KZkViC1h9G3nP12uTn9IyFACXeZtGqBV5ogdng6nJvZJb
	aEGIbb4UfDL9v7zD8pQPR6nU+k90Jckuaove9QCdzeW2sYgAxaRSMkyHLh5COWq4AdttG5T4DccYg
	/o+ul6RwVca8Aw4DoYrxdH/REtFeltYdP8Yj9NQFYyZ82jLvd2UjGhf7lHS9UY9fTuTfzs+koSD8L
	x6uuWH5Sk4WgO49OjvJwuregXR200jbn0ClkpFAZyqMkE6OISCERnUMDbdTCLabkC9du4hjQLdqUR
	J9QimTXw==;
Received: from [192.168.1.4] (port=8871 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1qKHGr-0007E7-0l;
	Fri, 14 Jul 2023 13:47:37 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 14 Jul 2023 13:47:36 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, Ante Knezic
	<ante.knezic@helmholz.de>
Subject: [PATCH net-next] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date: Fri, 14 Jul 2023 13:47:17 +0200
Message-ID: <20230714114717.18921-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fixes XAUI/RXAUI lane alignment errors.
Issue causes dropped packets when trying to communicate over
fiber via SERDES lanes of port 9 and 10.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 drivers/net/dsa/mv88e6xxx/serdes.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 80167d53212f..a8340b300c92 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -829,6 +829,37 @@ static int mv88e6390_serdes_enable_checker(struct mv88e6xxx_chip *chip, int lane
 				      MV88E6390_PG_CONTROL, reg);
 }
 
+static int mv88e6390x_serdes_erratum_3_14(struct mv88e6xxx_chip *chip)
+{
+	int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
+		MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
+		MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
+		MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };
+	int err, i;
+
+	/* 88e6390x-88e6190x errata 3.14:
+	 * After chip reset, SERDES reconfiguration or SERDES core
+	 * Software Reset, the SERDES lanes may not be properly aligned
+	 * resulting in CRC errors
+	 */
+
+	for (i = 0; i < ARRAY_SIZE(lanes); i++) {
+		err = mv88e6390_serdes_write(chip, lanes[i],
+					     MDIO_MMD_PHYXS,
+					     0xf054, 0x400C);
+		if (err)
+			return err;
+
+		err = mv88e6390_serdes_write(chip, lanes[i],
+					     MDIO_MMD_PHYXS,
+					     0xf054, 0x4000);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 int mv88e6390_serdes_power(struct mv88e6xxx_chip *chip, int port, int lane,
 			   bool up)
 {
@@ -853,6 +884,12 @@ int mv88e6390_serdes_power(struct mv88e6xxx_chip *chip, int port, int lane,
 	if (!err && up)
 		err = mv88e6390_serdes_enable_checker(chip, lane);
 
+	if (!err && up) {
+		if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X ||
+		    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X)
+			err = mv88e6390x_serdes_erratum_3_14(chip);
+	}
+
 	return err;
 }
 
-- 
2.11.0


