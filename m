Return-Path: <netdev+bounces-260280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULzTH1LwnGkaMQQAu9opvQ
	(envelope-from <netdev+bounces-260280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:26:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9947180392
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 802753102E3E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369AD213E89;
	Tue, 24 Feb 2026 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="ok3mUdK8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80ED21773D
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892699; cv=none; b=FFQccLaIVRUX8hNOh5K6+ZYqEBCkcsZprltVWjEuDYZpVzuPHs5YlQDhCW7ITRSmU2C3QPRWNqoHFdlRCAEOt+ohaPYX1CI6YICEIf09nFxjGg4ggunh/7PkJDC4m9n+8QJ+zNmF1vhCl+UUUsUHXLpByByUW/cKH3z3jqvy708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892699; c=relaxed/simple;
	bh=AC+UPhp34mlJW3ypzeQ2RigMAW6hvlVv7nobPEouPnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EL9VD9erRdPk4fGYDjeUjWSDeTWkDqiOIQ9qgxXuSRCG5Kw1IEAIt/Cn7lB8uDO5uJiVm7oO+Q8ZaSfkmt1BvQmuF46GrUkVTLt1o5lyz7LThEODlKTrk/4HgGIM1sFtDFmgdh/7k5vnSSW1kRnKRNLmOwK1CuP2S+o72ujAFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=ok3mUdK8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NKQKLh368010
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=NV6mzDBWuK77Mg5bwBPYznRENeVAfMlVIxHlmr6Ad4w=; b=ok3mUdK8T1/x
	bDCE8H4x+twrsi2652rY10/oyZ1PaplvDLRwFu+ycxfJrvO2b2f3jr9Kz0TmNdNS
	y0kgLcIJVBJ8ob9ZzTrMQHkM2n/XZ+k2D0gSilnRb3Yad9ValxaSZU9PjBkWOxvu
	jAWBQMHS/1EXelw7ja9vivG0E1FY2omtLt99gUZpn3+8Sd0gZgXwE9BcGPk7/SZx
	7DSWBcOeu9i9hPn01/HIGe7tSZwGjZXZ7j694jAcGdQFyo30dFn0USWb5ErkvPyC
	MEoaxHKQpG/7rpIvf3EpiB2zETagP++jjrma5VJW/EVCqWCugWXL7gLA4cpOGPER
	E3zeYshDOA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cgwxaj337-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:57 -0800 (PST)
Received: from twshared108583.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 00:24:52 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 0D8B365F7EDD; Mon, 23 Feb 2026 16:24:38 -0800 (PST)
From: Wei Wang <weibunny@fb.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC: Wei Wang <weibunny@fb.com>
Subject: [PATCH net-next 7/9] psp: add a new netdev event for dev unregister
Date: Mon, 23 Feb 2026 16:24:07 -0800
Message-ID: <20260224002410.1553838-8-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224002410.1553838-1-weibunny@fb.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8Eg0Q1KRpvgLuu5kNZABbk3PPAEb1sTX
X-Proofpoint-GUID: 8Eg0Q1KRpvgLuu5kNZABbk3PPAEb1sTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAwMSBTYWx0ZWRfX5n/EuolDG7Pm
 Cd8E7gj7fi4n/iBpFX5krQ1JPkrEJSKXCtt7/Q++p+nFphKp/+bAvR/jLaO3hrk27st68/koe/u
 wguzhgaHmRq73tAIGvETCaphs2+j2HG0r94tx2YPIiYd+3C7XKTAfEAk7+oo80bIWTxDY2TUzyG
 S9ttUeTF/S1uHpFcWia5M6s1ZpXLP6bnXkx1qxNPrr58C533KHAAkxukeGNXrT7o1txWzKSyCyd
 o6iflX1314HU8/crtIe2I6XN3O5gVu+AMv8oiV/qYzxaPobMj6l/lT6FDQ+0bmB+R9hHPdjX44k
 tYkOHC1GXm3dGFqqBpRYZgAZr/uP3wcoPWDmwfkl9NvaMauP4DHWCGxu9uNOcO5hD2SlF2+dhF7
 ybVLtjTWLr/GEIY1FhaBxNrcoUGNeGlyIIG5b0Fd+M6FNpIKZq5YpIHyzYmpRdUF6riQpSTdMDe
 rZwZWnGLoDlt01+jf1A==
X-Authority-Analysis: v=2.4 cv=JM02csKb c=1 sm=1 tr=0 ts=699cefd9 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=FOH2dFAWAAAA:8 a=-RvZIenZIDdK7zbSOTYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-260280-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fb.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:mid,fb.com:dkim,fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B9947180392
X-Rspamd-Action: no action

Add a new netdev event for dev unregister and handle the removal of this
dev from psp->assoc_dev_list.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 net/psp/psp_main.c | 64 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index a836bb905f1a..f111547c9703 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -334,10 +334,72 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8=
 generation, bool strip_icv)
 }
 EXPORT_SYMBOL(psp_dev_rcv);
=20
+static void psp_dev_disassoc_one(struct psp_dev *psd, struct net_device =
*dev)
+{
+	struct psp_assoc_dev *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &psd->assoc_dev_list, dev_list) {
+		if (entry->assoc_dev =3D=3D dev) {
+			list_del(&entry->dev_list);
+			rcu_assign_pointer(entry->assoc_dev->psp_dev, NULL);
+			netdev_put(entry->assoc_dev, &entry->dev_tracker);
+			kfree(entry);
+			return;
+		}
+	}
+}
+
+static int psp_netdev_event(struct notifier_block *nb, unsigned long eve=
nt,
+			    void *ptr)
+{
+	struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);
+	struct psp_dev *psd;
+
+	if (event !=3D NETDEV_UNREGISTER)
+		return NOTIFY_DONE;
+
+	rcu_read_lock();
+	psd =3D rcu_dereference(dev->psp_dev);
+	if (psd && psp_dev_tryget(psd)) {
+		rcu_read_unlock();
+		mutex_lock(&psd->lock);
+		psp_dev_disassoc_one(psd, dev);
+		mutex_unlock(&psd->lock);
+		psp_dev_put(psd);
+	} else {
+		rcu_read_unlock();
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block psp_netdev_notifier =3D {
+	.notifier_call =3D psp_netdev_event,
+};
+
 static int __init psp_init(void)
 {
+	int err;
+
 	mutex_init(&psp_devs_lock);
+	err =3D register_netdevice_notifier(&psp_netdev_notifier);
+	if (err)
+		return err;
+
+	err =3D genl_register_family(&psp_nl_family);
+	if (err) {
+		unregister_netdevice_notifier(&psp_netdev_notifier);
+		return err;
+	}
+
+	return 0;
+}
=20
-	return genl_register_family(&psp_nl_family);
+static void __exit psp_exit(void)
+{
+	genl_unregister_family(&psp_nl_family);
+	unregister_netdevice_notifier(&psp_netdev_notifier);
 }
+
 subsys_initcall(psp_init);
+module_exit(psp_exit);
--=20
2.47.3


