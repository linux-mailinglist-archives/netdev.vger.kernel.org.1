Return-Path: <netdev+bounces-170915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C3A4AA32
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 11:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A07173268
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 10:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AA11D5CFB;
	Sat,  1 Mar 2025 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wFEEFKU2"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0461C1F21;
	Sat,  1 Mar 2025 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740824318; cv=none; b=NUTBNqcAIDfpd+bg/i5mwniDtQMVOt64VKMH+ad6KmNbtRrP/vsIO9TDS4lBRWQIwk0hxdEsu/0eNesAOZ36UQmMDFmMIjU1DLGEVqCD+4LXSHZ6bswbMnCsT1nMJXwXkyklnj1KxnQuUmneiBbcLu9BAA4DKT4tgiLw5V0MsBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740824318; c=relaxed/simple;
	bh=Tih7/m1jCU6zo9dbLTjV9xhUlYXnOFqFkJ/TPENNJOs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=C8Qhs4OzNqR6/Xu18EtodO/f07/Od9wFfqyEU6wt1smPdcf1q0v8xvKW0jRUiyer7kvwL2bH48uwcHq7NBmjOvfCI6NIaAlpdpbC6dd7lOpjgCDMeHTvh8/q84kvWafHjjrbEdStnDN078dI8XHsu0l++yVUmkytr8jr1K0kqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wFEEFKU2; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740824314; x=1741429114; i=markus.elfring@web.de;
	bh=JqgvWhDeBxn3+761cHTwCzYRQ8hleuaweJ38cwLMrf0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wFEEFKU2thEBQiFzEdHl8tSvuoTMkCt4bE7IlLwC5/aw5mYmakxzlTGLctD/gH/+
	 V+um6iDS0uxVctT6lrXfnaF396XIgNe+DvcV6+kWjgfkcjp8qiGTvNdgPcYa3lOr6
	 F3aEEzGX3Gl7zIiV9reYkvarbvIVd233PqFV7Q8RszxUV5CxFr0WchP738yWW9EAW
	 Js4YhG19aZ9uqQ9Qwse7DngX+3nOs7jdwY13qNSp+P9j80sR+jkfy8GnOkXnBtN47
	 w/hXnkx0CeRPsL7ip8I7Q83xJYg57YUULq9wzgA2/yo4tBFODCfhZRAlUhYWCLvYe
	 AdEzBQg16Ltv6ZR/iw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.42]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZnl-1tIXmj0VbR-00hdl0; Sat, 01
 Mar 2025 11:12:44 +0100
Message-ID: <cbbc2dbd-2028-4623-8cb3-9d01be341daa@web.de>
Date: Sat, 1 Mar 2025 11:12:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Brett Creeley <brett.creeley@amd.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shannon Nelson <shannon.nelson@amd.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH net-next] ionic: Simplify maximum determination in
 ionic_adminq_napi()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Qasim Ijaz <qasdev00@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iAZ5wQXshMe1auUfVTMOjSnfhKROyESDT79eO6OuARkv2ggeQ7p
 +3J7+DAdHZZOHg1Gufq6YUBoZZSyZpqvkPlcUzpVDhNv3vyT5SnSarfmOkbmzrcDM6S+yGL
 2suFLHJOTPMXsEuNNRtjvACJuDX810LCHyiLLt32NCJZARpKZtKfZLPldGXFhld3xqGGxGd
 hKpHlT36i5IFJ3IV+CpiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1RdTme0JumA=;zJ7GmkLyjP0ZpFdUxYl5KacwGZk
 fyCTfDztGHJ3Iis9Xpdlwpi00SkJ6h0VLeVIXOo0mRpPd3yl53AyCwbYpNVP/oSwOcpNwkZtN
 uIXXf4efz7/SkhSyB2UVnOpRsxN4DW/sPlJg/dnDdamTVudT6UiPzebbIGKPT16/HKDCSzz7E
 A8i4H8nKAJA2qQWlIowbzm4LLT91Zw0Zus0Uv2IoNb+seBQrO3oQHxuj9+X6G7xW0C0IXzCnc
 7oAYcKHoC/f40b+Rs/FJPLN1AfBBjRSxCPYmck+yoquyBI8FMCnHejiBtwmASR7zDWVi1BEyI
 XhZ/WhC81zR38+WA03bTSDM0EauaKqmwo1N6t52+CSe9L7P9QKpvjeS6OUgxgEd0K3LkTZQkj
 LS/KYpQa1FQuQ0kKyLaYPDXK6MDY6pbExgf7xV3IUXxWqkK02uxjMSXTJbyXWIzTVi5afDuGy
 NZfBXzbFV7bmNtdtaEVluSIC9+0sKEMKcVRmVb04Vk/iWYGIKPB78HqUekKqUwJ+NfCM9q28J
 4uOrijAWYTQ7TmATwoC98HkADkoAaLAtCJMJzAMYs46hMZkCg2CumnWpKSx9tcTogddL8vjWK
 X0+DXdIRgeTCJ1oKgoDtxDmTVQgTqaSieHtrUt80UymLv+kkCQeeLykpEerjEPLund4Mw/oJI
 u8AOsk5cdh3GDinjDKMuAZ4AS/tDAur/tMRJoV/Z1vfKKspmX6+J2P4yCVl1Zfxs9qJEoHHvD
 XqBU7LSKycjsIN8ghdX0/kTw03OrZR1tC1CzTINu4p5k5jYPyuFzRDFr4ee33udfM+WXtbBaL
 EgnVcKSQV+Vh6rYtig1Uxb1FZTSA56oz1O8lYhbhXM7DoDuc4dw0qx4HSCdgH7gWtoS9hG5K+
 WxpOkz1mNEmd/ouy0bhuGlSxTneyfad8EWPFu8DHv6K1yORXUezI5Me/KfY8X7oWDEFOekdpB
 MsQ0Zw7FvzwUZIlbx39gmHV8aF7UL130bYW5qLBPp/Zu0UCYe/ikzVXlWG5yK+m33Rwjf5euy
 lZI6NSxWVVAq3pA/HhJGog/a4dS4VHe9qQiNWR6mJTQdbGC/V76ro4z1iEP2hIHQ41BZV5vRL
 UYPBiqWXid2TRtUYHYwd2C6BJCZkteSscrD/IXhnQgpV0p1HAR+uBk/6StGeXDsuZw7+iFpM3
 dGMTCUAAagqUuBH3WlAquJmzrprLezi/RXauFB27rdKUl6ZnNOAygcPAJIrzTVxGT4ulQq328
 mzbEWfYzG+j4hsmnTmzu9p/KQWClTwLRzPozq5NYc3Itbh7r5+1qUkjJwP/b9snb27hZTFRgd
 w5aCCI9g3H9x9/inkqdDsuz9DfcbxOixuebb4tntFQnQX7UuOpqre64KQHrQ0BNzbxrg9+2aM
 sLoKyWcGsAhkiDdZPadFi25ALJv8TJheeYe7d02I+Q/RG5F3If5QpF3EFtb3PYaYctzDwDcy0
 IvWciIA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 1 Mar 2025 11:01:28 +0100

Reduce nested max() calls by a single max3() call in this
function implementation.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net=
/ethernet/pensando/ionic/ionic_lif.c
index 7707a9e53c43..85c4b02bd054 100644
=2D-- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1242,7 +1242,7 @@ static int ionic_adminq_napi(struct napi_struct *nap=
i, int budget)
 	if (lif->hwstamp_txq)
 		tx_work =3D ionic_tx_cq_service(&lif->hwstamp_txq->cq, budget, !!budget=
);

-	work_done =3D max(max(n_work, a_work), max(rx_work, tx_work));
+	work_done =3D max3(n_work, a_work, max(rx_work, tx_work));
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		flags |=3D IONIC_INTR_CRED_UNMASK;
 		intr->rearm_count++;
=2D-
2.48.1


