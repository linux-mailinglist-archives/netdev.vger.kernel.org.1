Return-Path: <netdev+bounces-17551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B0C751F92
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768591C2127B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183131094B;
	Thu, 13 Jul 2023 11:09:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD610945
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:09:40 +0000 (UTC)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710D7198A
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:09:38 -0700 (PDT)
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 38A6FA0D67;
	Thu, 13 Jul 2023 13:10:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=bRUby+xwGOTp6IrpA10mSMmVElfrLrdBSx+7b9V6l50=; b=
	BIEOFh/2d0ud/gzH1fmDUv5sKm/nFZEQNPxekO4Dx8lRmXjz2A85vmKlac0Cr4y8
	tXqSV/OacpUGdKLJA9Yi3bvAO5Li1SYj73gxw2kh5aca9Vlt/d6Sl3BxCUHCcDf/
	XxiQTf76VopsgzA1XiU3RoVE0l/wS77afJRcRH0QMNbKArJw5J14deyoJpJxO0zC
	bTHkwU0kjh4Hnv+6juKLTIDy2pTsrxLBKymCNtuDh+dvPkCk9XIhC3+19eJNy83P
	W3Y3+quMW7PZ9Iwu2Jm6rjfUgh+FxV9yeGCEMGAb+VcoaJIjtiHKRCeXQYeH+hgf
	nNCIKwCTHWk28jP6NLdnV1E53/BIu59YcdMGVTcwe5DBnWbgZoPAbhelbOw88exQ
	8Y5FrriEARUksu+n+hrGRtuDJPI4ptwHcsQZ4l08i6I0aTJ9yh4PfzySuvEZr7sl
	MS9FTe7Jt/pl9tl9NmUXig4Sen/cIUUdqJmKL1xGZw4ceCDTsFjp+cVB2B/2G6MQ
	uMA6uyfJWVjxnmDdicu+4msvzDDJjwTh4mJAdiKuDEXNJgA0b3FZEXv/nqwhFn6u
	rnf0OZ7kJeNX2V0Nai0H6JLteszmU//EC3+kLgWTImW+Yykg0ue4WtoFkSn2iHlB
	fsJ7j2e9jgCV9Icym1qTg11ByPbl4wqWhv5/v9vVgR0=
From: =?iso-8859-2?Q?Cs=F3k=E1s_Bence?= <Csokas.Bence@prolan.hu>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, =?iso-8859-2?Q?Cs=F3k=E1s_Bence?=
	<Csokas.Bence@prolan.hu>, Jakub Kicinski <kuba@kernel.org>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next resubmit] net: fec: Refactor: rename `adapter` to
 `fep`
Thread-Topic: [PATCH net-next resubmit] net: fec: Refactor: rename `adapter`
 to `fep`
Thread-Index: AQHZtXSiNsnWKvzaREqu51YkE8XJDw==
Date: Thu, 13 Jul 2023 11:09:33 +0000
Message-ID: <c68ee91e04144f0e8aa5569613a73fd3@prolan.hu>
Accept-Language: hu-HU, en-US
Content-Language: hu-HU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [152.66.181.220]
x-esetresult: clean, is OK
x-esetid: 37303A2939B8C25B647263
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rename local `struct fec_enet_private *adapter` to `fep` in `fec_ptp_gettim=
e()` to match the rest of the driver

Signed-off-by: Cs=F3k=E1s Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/etherne=
t/freescale/fec_ptp.c
index ab86bb8562ef..afc658d2c271 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -443,21 +443,21 @@ static int fec_ptp_adjtime(struct ptp_clock_info *ptp=
, s64 delta)
  */
 static int fec_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *=
ts)
 {
-	struct fec_enet_private *adapter =3D
+	struct fec_enet_private *fep =3D
 	    container_of(ptp, struct fec_enet_private, ptp_caps);
 	u64 ns;
 	unsigned long flags;
=20
-	mutex_lock(&adapter->ptp_clk_mutex);
+	mutex_lock(&fep->ptp_clk_mutex);
 	/* Check the ptp clock */
-	if (!adapter->ptp_clk_on) {
-		mutex_unlock(&adapter->ptp_clk_mutex);
+	if (!fep->ptp_clk_on) {
+		mutex_unlock(&fep->ptp_clk_mutex);
 		return -EINVAL;
 	}
-	spin_lock_irqsave(&adapter->tmreg_lock, flags);
-	ns =3D timecounter_read(&adapter->tc);
-	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
-	mutex_unlock(&adapter->ptp_clk_mutex);
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	ns =3D timecounter_read(&fep->tc);
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+	mutex_unlock(&fep->ptp_clk_mutex);
=20
 	*ts =3D ns_to_timespec64(ns);
=20
--=20
2.25.1



