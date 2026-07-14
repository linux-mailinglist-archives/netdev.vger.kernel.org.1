Return-Path: <netdev+bounces-307463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +1N+I8I0Vmqn1QAAu9opvQ
	(envelope-from <netdev+bounces-307463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC9D754DD7
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:08:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b="ZlJMaY/V";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307463-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307463-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36DCE30B68BC
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955B346AF14;
	Tue, 14 Jul 2026 13:04:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA644BCBE;
	Tue, 14 Jul 2026 13:04:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034258; cv=none; b=Joa6Z92Piel2DPtKuhEJTQ8vNVyGQhBr+ogb6FcwQKJy0U9f1gU01jUkp6BblqTLY1VlptmJwaVWEG0p1d3PDEByxARTZbwh9KK5JAg/qA9fH9Sx1i0gd/Fr/ulpA59SEB6Zf6i+JunKOlIzNfj5LXp26V0Cm3ez4/Vk75nUNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034258; c=relaxed/simple;
	bh=krpboD18eUitLsEgWCt92V5+K0+EWjyngp/vI2NLkdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioEAARB7Jy2O6lddUdw3NSUjcZeT8GdUKRQ7s1FH32n2nX0Hyyy/smSnjwzAu0AZkDbu3J/GNoGCjETmT9rUU+91vl1jc1EnuWOgD6kEjuKoi8ljWXldJzearSLJT2VAZmZNf0fiI9I+oEGH/IOL93lUbsnCyUUo6EQ+eZtSPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZlJMaY/V; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBhmxw1134396;
	Tue, 14 Jul 2026 13:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=c6xzjMnDGSAN8o69Tu3esAwrmsfvm1yh474NIp4GD
	78=; b=ZlJMaY/VX3kxhz0JwOLANOxkHnf107ZMOnFBsd7rfFS9vZ5sqRYCYfI1R
	2FOI2q8aE5/4dNsYrfnbPX8XW2znwiI8no/jayioGh/Xxe0YqUWLfyB0pOL5oAtG
	1LluM8iORU+f9UXv5+rYLNC7BAnoY4fLJJyAiMdSkocJ6zCP7bVlV4TAM0YlcRr+
	rOsuDZklXU6yVmh6B6rx2KYF3vxVm2JPliVegYZMhJnbn4L2rtjCHxeZVIKzQoXM
	jUGnUwiXhYRakcSNT9PCCeeumfXRcjsQ7mtgRm4AEyU8kH+ZcpVaG3X7bgN4qUHI
	Ex34Win+tC7iM9CODZv46riwURRlw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwnqfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 13:04:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ECnafO031471;
	Tue, 14 Jul 2026 13:04:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhaspg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 13:04:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ED44Is49283522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 13:04:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EED920043;
	Tue, 14 Jul 2026 13:04:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AD7E2004E;
	Tue, 14 Jul 2026 13:04:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 13:04:04 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 3685B162592; Tue, 14 Jul 2026 15:04:04 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 0/2] Add missing facility check to ptp_s390 driver
Date: Tue, 14 Jul 2026 15:03:40 +0200
Message-ID: <20260714130342.1971700-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: dGuFf9A7L-5KVs8-TAfClxG991i00nBu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfXxJVFsYd4OR+D
 4NtiumAyKI9HrZ1wNVBCFCueQ4vdB1nFq3HalxS1XngjSdG/lJIdNaF4h8sKTdUps0EJermmUt9
 gRaUk0uTkc/K/sKZs8dXq7vnHtj2b0XEgE0c3E34Q2AKVNGgyvaXDvrk4JZ6vf0JB+TdeJZljU9
 RObabknDQxmHclfozZLOPD8YVfLS1Vlr0tt2gzRD8dZldiYPIv3BjZq+Xbx97YhrsExeSnOvxzD
 iKoyI1t8PMfj0BtS7yGaZj5yzmuH6LoiFk+DDQsy1ByiitqenHgR50P0JfR3KKjIY92r6PyAqqG
 hToFwgOBp2CQIxT5/yIVvNNd3D3ejJyhJCA2XmXs+K5wFvZDyWRTl2Yj+ueje64Mny60QXGfFl+
 D4pBMKfj+EcTQf5IIBzpku4pNWNHvSzGLkhrln+yn5tgM36QZgsh1fGkkVbTPLWkQ9bJ8U7gpqV
 voEd7KW/MeS97gP6RUQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a5633c9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=7setYLi1RpsTnzgNOcEA:9
X-Proofpoint-ORIG-GUID: L8XCzs02We_u4VHxOfkFsSWKs20HPG39
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfXwu4wdZVK5ret
 En7P5gsJfpf/kXS4D4Y4GJVZqt8xKBF/85+R9VEJDRAoLEj71guUDNLU9okEinCxRZIy6b5wpZE
 VVnBFI5BHrujOmBHSZk5ZSMiIz+Slm4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140132
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307463-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[svens@linux.ibm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[svens@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:from_mime,linux.ibm.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FC9D754DD7

This patchset adds a missing facility check and a check that the 'query
physical clock' (PTFF QPT) function is actually available. If it's not
present, no qpt ptp device will be registered. In order to use ptff_query=
()
in a module, the first patch adds a EXPORT_SYMBOL() to export
ptff_function_mask.

Changes in v2:
- drop CC check
- add PTFF QAF check
- add patch to export ptff_function_mask

Sven Schnelle (2):
  s390/ptff: Export ptff_function_mask[]
  ptp: ptp_s390: Add missing facility check

 arch/s390/kernel/time.c | 1 +
 drivers/ptp/ptp_s390.c  | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

--
2.55.0

