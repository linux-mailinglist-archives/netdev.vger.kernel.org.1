Return-Path: <netdev+bounces-171030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F055A4B397
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 17:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BACF3AA505
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D271EB187;
	Sun,  2 Mar 2025 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XdzUaXjZ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD21EA7F6;
	Sun,  2 Mar 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740934580; cv=none; b=P7q9uZJSVY71YUzLKd8ECkN6TuSqf1KwrZkYr7VAKdNb/ADY69ZiHjrdQ2q3u5IQMujCvKRCt4npXMFhYyLlr8D6FS+pJobHebnOy8AEV7vzonzayCJXZ3qsugbsNRu+sdFpLLF2Y4HInRz5FM9JuDrV7GAc/jsHvv5ntMPiOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740934580; c=relaxed/simple;
	bh=zYywJCVtJuklrYtbGMy/JBlvWUZv/76NSRkF+5wLn3k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XbebEZvbksKwIkZ00SrYU0L+2JvPzrQgeDiBKKAGtK/pNm1lZ2cMDZ0/LOASn8xdfLk6Rq0p7CJaTXr9WIwd9YgpXhZxE8/ommZ5R4FIUWxgLMDOM7/8wKG/HJr2SGazgywZqJ1ju9vNFojyDN2UjKwRgWwZ6c7ALQV8WG0hsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XdzUaXjZ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740934543; x=1741539343; i=markus.elfring@web.de;
	bh=OU70rd853VAcdlpDiqSxh9lW2ODS6NpOS12MEJLpx78=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XdzUaXjZ21ruL/326togw+dIydUJDotygPeRXgmOgwxOfijdEUclF3oLUuLMcSAa
	 jPjzGZ2BFRxqv7X9ZRHN0uXEuLdworveUheTQIJepjAPDNUjMwXpZD5ZG7I5Q02hW
	 +37hEIdo7HADoL6Qnt9EFPsxuFBbxRNHwSsgk7Hp8Fh5dBNbE7JRhEtmZw2/9dNS7
	 CS2jrTp5qObNfAyA1mhBxnZJE0DHp+nO23QQazB+DyfToXHtWk7MpvTHZWwueb1nP
	 O8H/LlrDo78qIbBuM7+ieQX6lDh7aXGWYz20kjCBiqRgsx5YVf6IVcMF/1xfzbDpF
	 9azDGU0zsJabPMq9Kw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALiZ-1u0dNM3Enj-00FPx8; Sun, 02
 Mar 2025 17:55:43 +0100
Message-ID: <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
Date: Sun, 2 Mar 2025 17:55:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] qed: Move a variable assignment behind a null pointer
 check in two functions
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ariel Elior <aelior@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>, Ram Amrani <Ram.Amrani@caviumnetworks.com>,
 Yuval Mintz <Yuval.Mintz@caviumnetworks.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
Content-Language: en-GB
In-Reply-To: <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:840eoo6DkjKy4RTYNIFXWIlVoRLfM38HMfmnnMhpnnFYTE6SfG9
 63QIVRt2N4x6mV6tuwRl/lAso8CCdePd8PJJbvlTmUqX2xziF+cW9cL5q5imhZKp8dRAoi+
 al3YLFfZCCNyXud1Ulztgcp56MjHCWQ7tTmqE4OfFF6YmnWN0+LSMu8imWitChuXiMRfeLi
 QW7cJtKXwPaORxjB7cscA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:90OwU40suZg=;xgiasFkG50p7P04e9n/yTUcSWvE
 /B0pQ5h9MAGXiYs7hO+VsKUMSq31KJHluTJ9N9fgHGYdozn6Ev2BEZjmOy7bLy2pIuOpVC3g/
 2Sj/gKAawGmD0auXaRNbZzh2qGMhjAxOQU/iYblGr+26Cy0U4uLAXBae2DnQ/cvc1HLqb3gYq
 GlERCDRtXnIWtzgn61MbCsvtWYFwNkOy3WcyiSt8k/xZ7GlrwhUbStQel/T13+Lb5vxEzGLlK
 unDoYsGzQTfvSUDXoAL5GJbMQCS6mxFE4QcY25Ffp3JR4i/3xma6lYgsDuRYc95upjtMdT9fH
 t5pryuA1B08pYb9B+A+dQbB2oYS2EOfEx3vD6G8V/Tw7Z9PYIcSLsX1Q7A8raANJV+bIGOFzj
 2Hw+2LTT/zd+wH3AGrffEJLWJK6zjdgHwqqQo7RbD5aLL7kCxO9YqhKiBF08McPVCLJCu2zEb
 Zn3Q3YTD0y4OLd2lUihYj6C7K3G61imj7/YMRv7DCnI3jXNA0BNoZ6ngEY1UAs6UuKnDKD5ML
 GO4XLgPzL3rWs4ToL6GCdyk0iZ3FdDF8/zrd7rhqKkHe8PKXyGbV3/PSV1Njxc2NsPPYMrYLR
 UNBIUb9ONWAcOpdlG3z05DzzZAO1B6HoVZbZPvDeBeE9rhc+RvbjIAzsfxqDhHpWc31GQT+XN
 rXGcW4Tz38Pg8PhyDzXg2NCUW93u7GY4guGtUsGnRoHIonhyY5zfCs+ewP8AqyQFtmJtevYtZ
 V7YR2ctSHYZp6v3PG6ZUtaph+6CK/V0yzuGk/SlBEHCE35pa/PGqoCtH+mVnMeF/C7pXGuGKn
 T5Wi1QFpIw3LXM47yvMHLyjHhe2HGDiNL/dZHJjUSbh9abLVnoOkABSIHEqiQOsPNCSM4CPQf
 evdDWTFbYvvq1jmj6ySyXfwYjrsuNRpDG/f5RXf7fvoDQdizZ1bh6s4omowfqdjos5UICauJh
 AyGueezff6k+O7kjl3IoqIWkg5FuUejzDU6tF26FwwZiidEPFuk54xjV0gAMsH40ZeAApaVWh
 L8DROOZ7z7RrS6xEMaZCYL6wIyMVMHbOUUG5psx2DRxBOVvesUG/4JZ8mAqAvBJlIa7Df5eSC
 MUWuKbaXXR0IiOcj8S3P+0aFG3lDcZZzbxUrizBVYL2au1Zot/iiCPlNSU3wY94ZIvZeBFzpO
 YDgWFLtX452J6vq/ZCfvCdNoK/mt1W2FJPst06uDzVp1NiFP/MK1qloiltZyn235kmBh3/Sfn
 X+PLLGY3vIWv6FyeF/pObj2Mpcqw/Wv4SbwYuxCHa+/9jAHl302JvfJtL9C6hP+LiWIX9s6Qd
 hpRXYHslA+mSPWKPgNJbzSwYEuX1ME/dZvtfCSbVFMujOcfgARNc16Rb1HeFYxW0VDiwW9Yoq
 nWEpKPfcHIbZg7fsL3OvG14uHN/cWQujW/6TkIuJLLruXUZiEsHLmH5XXN3uE5Zq9kUt/nKku
 2CIvzSw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 11 Apr 2023 19:33:53 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the functions =E2=80=9Cqed_ll2_rxq_completion=E2=80=9D and =E2=80=9Cqed_ll=
2_txq_completion=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variables =E2=80=9Cp_rx=E2=80=9D and =E2=80=9Cp_tx=E2=80=9D behind=
 the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: 0a7fb11c23c0 ("qed: Add Light L2 support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ether=
net/qlogic/qed/qed_ll2.c
index 717a0b3f89bd..941c02fccaaf 100644
=2D-- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -346,7 +346,7 @@ static void qed_ll2_txq_flush(struct qed_hwfn *p_hwfn,=
 u8 connection_handle)
 static int qed_ll2_txq_completion(struct qed_hwfn *p_hwfn, void *p_cookie=
)
 {
 	struct qed_ll2_info *p_ll2_conn =3D p_cookie;
-	struct qed_ll2_tx_queue *p_tx =3D &p_ll2_conn->tx_queue;
+	struct qed_ll2_tx_queue *p_tx;
 	u16 new_idx =3D 0, num_bds =3D 0, num_bds_in_packet =3D 0;
 	struct qed_ll2_tx_packet *p_pkt;
 	bool b_last_frag =3D false;
@@ -356,6 +356,7 @@ static int qed_ll2_txq_completion(struct qed_hwfn *p_h=
wfn, void *p_cookie)
 	if (!p_ll2_conn)
 		return rc;

+	p_tx =3D &p_ll2_conn->tx_queue;
 	spin_lock_irqsave(&p_tx->lock, flags);
 	if (p_tx->b_completing_packet) {
 		rc =3D -EBUSY;
@@ -523,7 +524,7 @@ qed_ll2_rxq_handle_completion(struct qed_hwfn *p_hwfn,
 static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
 {
 	struct qed_ll2_info *p_ll2_conn =3D (struct qed_ll2_info *)cookie;
-	struct qed_ll2_rx_queue *p_rx =3D &p_ll2_conn->rx_queue;
+	struct qed_ll2_rx_queue *p_rx;
 	union core_rx_cqe_union *cqe =3D NULL;
 	u16 cq_new_idx =3D 0, cq_old_idx =3D 0;
 	unsigned long flags =3D 0;
@@ -532,6 +533,7 @@ static int qed_ll2_rxq_completion(struct qed_hwfn *p_h=
wfn, void *cookie)
 	if (!p_ll2_conn)
 		return rc;

+	p_rx =3D &p_ll2_conn->rx_queue;
 	spin_lock_irqsave(&p_rx->lock, flags);

 	if (!QED_LL2_RX_REGISTERED(p_ll2_conn)) {
=2D-
2.40.0


