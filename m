Return-Path: <netdev+bounces-306349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PNmWM+HzT2osrAIAu9opvQ
	(envelope-from <netdev+bounces-306349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 21:17:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3675B734DC1
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 21:17:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=JSpUAkba;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306349-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306349-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BA25301A29C
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 19:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8F63B2FE4;
	Thu,  9 Jul 2026 19:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DC53ADBAF;
	Thu,  9 Jul 2026 19:17:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624669; cv=none; b=Haq9bR27jpcla/Yqlh98YX2rIQmxRMWWVf2U1Me7JeBZ5pphkXBGPOplFKU9rQCgDGnbF4IhYb6gGixyxzeznBJ+hSS2XEX2KjNv4iL1+BGT3/b2I82sg9fsdOHwKQ6acBJFoQfntpBK2SW+abhPxLis9sxFGnHlx6MGbG5ExeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624669; c=relaxed/simple;
	bh=Yk2/WyUvGKiE19ekfgRZRBIVFr/IXq405T6qgGjhObU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jH3JkskDqaeTDIXRVjUgmZv0U68pXDAagYUmCH8Q+1U6Lys6c4zoU4C86kjkr1PDYV7enykirW6Qq4l28jgBbTTShJDSoTo8kaGY9s35/VQkLlDK/d7Y/3yK4DwaQt8qYHcK1hIh35srQw/gh2pOYtLhO/XZLP/qoKgXkOtf2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JSpUAkba; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HmKRL2623385;
	Thu, 9 Jul 2026 19:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=iM0lLaDqCbZFq0pzTAGAUTnhVO0+hIDxT5C/jc/ce
	hk=; b=JSpUAkbaOUz2oxeygM/U42pZNCkOe1uaWbhe4QXL2ifreBCItQjJehZYH
	6OqKzPc7cNDaD5r0OSVwa8i97lQxP0kerjgRABPuPqZsZEeiqKOt0ggxAJonh8ca
	XVpkSPup4AhqZ4uB9/DfT1HlvYVklhOXEVtLByq7dC4zgO+6eq28kWw2l6zZtov5
	CJcv4UR81lJL6bcTk1KstdPTOxXzyrSjU3P8XvKT0kPFr8lvKNwrz4v6Aa3wN+Wj
	Tks+Ei10NPpCx5OsUoP1Q/O0HG8TiumLoEC6JuAe29F4evwvJhviv4NNEl70WbvM
	aOdTYSmL8LIE9V2kM6RFIW7wK5y/g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw53arg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 19:17:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669J4cHF026662;
	Thu, 9 Jul 2026 19:17:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hph50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 19:17:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669JHXMl28836466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 19:17:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5126720040;
	Thu,  9 Jul 2026 19:17:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17E1C2004B;
	Thu,  9 Jul 2026 19:17:33 +0000 (GMT)
Received: from t83lp68.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 19:17:33 +0000 (GMT)
From: Hidayath Khan <hidayath@linux.ibm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: horms@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        hidayath@linux.ibm.com
Subject: [PATCH net] net/af_iucv: fix NULL deref in afiucv_hs_callback_syn()
Date: Thu,  9 Jul 2026 21:17:32 +0200
Message-ID: <20260709191732.124092-1-hidayath@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: NXn5DVpO6ueY8MIWNudF1jYm5CA_wQxP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NiBTYWx0ZWRfX29HCDHg2IVxC
 o9gaWQhb5U4TuDx85U9OuTp84RQMSW9fQLZNPS1XrsTFmrmay2CUye8134/cnt3pa8srk0Qtgpp
 lTSrtewQ6XpYdq4kVbjXgQA4ubAkVcGQ50Sgn7YaSeO9Hg3o5fMovj6HEUrHu3wycyx8wjAecrX
 eIUlBphAGP9r+d90Ej0lChmnwkdJjHOgfKoL2iPJ8ddn+iiXc/yhJRLmXWbfLlmeGmDu0xFlmQY
 Kt6ePMkgEnYVHVu6V3eYd6uEUJ3nEQ/xGvZXZPV80b3+vomrGs+yfQBUv2iRtpWBMlssQGv5ubL
 87f+IfNmCk6vWrQxH3kucm7U6tmz1/3bnBRuqwLpiGa2BksVzsXuymQBbYytAhiwhOTkFOhLYff
 ynNxl/vE29LRj0qvrcMzcVITTdlWIuN4mbny395v+IOjwx9No+vsqXgHhgKCQqCsJQbE4m+NwIH
 wEirXL7taFFn/Yr/xPg==
X-Proofpoint-ORIG-GUID: t6Rv0bnmOeQZ-znRcVDm_Wu4v1o-AOMv
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4ff3d4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=lZ-7vaNzbJThIC_oh1kA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NiBTYWx0ZWRfXwsuPbVwRX4Jl
 ZWFaDxco1XGBqQCSDnBAmp/YBLjHLhxqKv+FAYRbIb14XXulYuMW71JjoUYPPsB2szZDn38L8ka
 S2BK+kBqzEJdH5kYSs+Ok1T+7aLBnYs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090186
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-306349-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wintera@linux.ibm.com,m:twinkler@linux.ibm.com,m:heiko.carstens@de.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:hidayath@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hidayath@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[hidayath@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3675B734DC1

afiucv_hs_callback_syn() allocates the child socket with GFP_ATOMIC.
If the allocation fails, nsk is NULL.

The connection-refused path is entered when the listen state check
fails, the accept backlog is full, or nsk is NULL. The code
unconditionally calls iucv_sock_kill(nsk) in that path.

iucv_sock_kill() does not accept a NULL socket pointer and immediately
dereferences sk via sock_flag(sk, SOCK_ZAPPED). When nsk is NULL,
calling iucv_sock_kill(nsk) results in a NULL pointer dereference.

Only call iucv_sock_kill() when a child socket was successfully
allocated.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Cc: stable@vger.kernel.org
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
---
 net/iucv/af_iucv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index fed240b453bd..f5b1ec44b6ae 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1872,7 +1872,8 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 		afiucv_swap_src_dest(skb);
 		trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN;
 		err = dev_queue_xmit(skb);
-		iucv_sock_kill(nsk);
+		if (nsk)
+			iucv_sock_kill(nsk);
 		bh_unlock_sock(sk);
 		goto out;
 	}

base-commit: 262b2eac463d880a664cf92af1107b4f9d84ad37
-- 
2.52.0


