Return-Path: <netdev+bounces-279701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO1uOXMD5mmBqQEAu9opvQ
	(envelope-from <netdev+bounces-279701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:44:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9737C429727
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F2A309B1EF
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7760839C009;
	Mon, 20 Apr 2026 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="hohBeM6h"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3F399341;
	Mon, 20 Apr 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681688; cv=none; b=W0lol6zn1g+M3ODDnhwn13iKCH6JN+PdI4rT6pRACMbU5vOcHDuUx/HNNx8JX4cW9r2zSQs8SsM7MJPi+jgB/2IJtYJuBBcTflpiHvT2OlSXzrwM/dWqCQ/9IK5ZSB8wymgK4qCfPJzm3tu9L8WB4/cZM4TtNQS/rbapcVLDDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681688; c=relaxed/simple;
	bh=XFWP+yYv7Op8pTwYC7BBgS2sMG2E6wOzSttnqri0ltA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akH1+0pyZfrYl7nYZTao0UNcLgWGo4fFlgwASUQry4DRn5/y6iA91ixusdp1zwl3QvMYOEFUixxVdzGRZn5NoGkcSNCQwUqfdBAOmmkLPH5qU2aRqFHA4JtNxidrv6WEnarQop9z+h7PI3jujOo/GjdJQ8bSqHhB6ka4LYC/oj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=hohBeM6h; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 63K8vPhS657275;
	Mon, 20 Apr 2026 11:40:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=QXb7xAciK
	CGZeYHiKlYr17f4TzTjwyCF6FQFa6X5U9k=; b=hohBeM6hT3QPDHWagq5bfe8Mh
	XILV20/wHe/gSm1lC28z06T8KUfTmFcGq7q4V+wGCMNyKGfPsrxFETJhnMt8JMte
	uiyE9F2J2//3Qe0OPltO/crZjADm1dkF042JQsBny7ecmy4eSOmllqvKhnRVlU6R
	/Di02uJZeNvTnfc626iMzcxFAHJuhsbFW07LN4MVTqBgdkoSwDwd+spEUrwlmyTA
	JA6nt+rv3pEqtE4oNsCGU6UwHoPVpaWIuys8iZV9aETlZgtlVN655zuXjVAv0TqF
	tH7z+dVWW/AJ9n/3u+oR9Osy+d+gg2q4im4+y1dRDpvcTu9alzsIl5jw4I9zA==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4dmmv6cgng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:40:56 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63KAQpdb031261;
	Mon, 20 Apr 2026 06:40:55 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4dm59tqd1t-1;
	Mon, 20 Apr 2026 06:40:55 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 2366183;
	Mon, 20 Apr 2026 10:40:54 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] bpf: name the enum for BPF_FUNC_skb_adjust_room flags
Date: Mon, 20 Apr 2026 11:40:46 +0100
Message-Id: <20260420104051.1528843-2-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420104051.1528843-1-nhudson@akamai.com>
References: <20260420104051.1528843-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=725 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604200101
X-Proofpoint-ORIG-GUID: zaDoNk88NgzksFO9UxK_9KgnwAq7ULTJ
X-Proofpoint-GUID: zaDoNk88NgzksFO9UxK_9KgnwAq7ULTJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwMyBTYWx0ZWRfXyirsSUZcYooJ
 iFlPSiELMB8/Dxa5Kq/4/efOlhFDH21Rlpq2I4dmbn6LfRh+dMLcd8VsEAmPlVBuDjrFTj9KikP
 0hmuKgan++2AC4mp96rHVOlIKUKesUKW06sg4SzUX1aBNseCP+2fGaJoREHDA+MLf7Wonk8sXRW
 C5DA7L52L2XvHSS/RISfuxZd+0WPVNHVGfmWq1EcKhqstTYJy8D6uc5Z+DzwPdeHLUEKN1Iqfc9
 smhgLUWmT6FyFEgDKCBGfxV6xOlsm90PfFvy2ld+X3qyGLd8twhaMIw4cnHm+Viq5DpD4hdDejd
 ABjdEL+39I1+vJ2kK3A5pgm95wJrXRvCnzuwgceOU7Mo/01czTDi4IN225sMxG4DtGO0WzPu6/8
 VOeNWB0EkR7MVSjByImzATA5fu3oixpbd3Wbh6+Z2HPL5vmjzXxswnjEcHsVeseh7YuNvqOJQG9
 iX4V2dWHNvY9KhFJjIA==
X-Authority-Analysis: v=2.4 cv=bYtbluPB c=1 sm=1 tr=0 ts=69e602b8 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=KDzEjHMMTas96-nIEKpj:22 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8
 a=TMHggaePV_XZxh6C_gsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604170000 definitions=main-2604200103
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279701-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9737C429727
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
named to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
Run Everywhere) lookups in BPF programs.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552bc5d9afbd..c021ed8d7b44 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6211,7 +6211,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 677be9a47347..ca35ed622ed5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6211,7 +6211,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
-- 
2.34.1


