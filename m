Return-Path: <netdev+bounces-283780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULWnKrxy+GlCvAIAu9opvQ
	(envelope-from <netdev+bounces-283780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:19:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 283974BB9B1
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 908C2302011D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F62B39EF16;
	Mon,  4 May 2026 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="fqsQLHmb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62C39B96A;
	Mon,  4 May 2026 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889928; cv=none; b=rniWRX0ZVaIxC3lZ/ssh+NPNloo7krljCjuNnNt7jAZhIW8I9jF+cWzTnYsnZZId79VgiZf9ZkTSMl8fTkPJQAndY0pJgeIQ1sM57zl+rOj/KXsJQfsbj421mvZxdNtZCKNs30rRmy95CmtViXkX2B6UGZ0KgUazyHGXp3wxFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889928; c=relaxed/simple;
	bh=up8HdMowOwrVWTy3/nxPINu+7XrKlMSL4o08B0H/kBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUukaZjaflSt7YPtUMG+/vFiK5nm4HvGR3DNAX4F6sStIiqWKOuynDXGY2fJp9gopaENwNjtqxFNnXPhzL1rzM2HIeL4rVJMjd9dd+waX4A+I9ZEZXPuoFvPHrTfYeQgl/H31pg4oj6ABjUwChj8DScEWM4lLEB9rXEqoGq67oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=fqsQLHmb; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6442xK0I2521871;
	Mon, 4 May 2026 11:18:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=0yZzm5QkH
	GP595Y2/iBt2yR0pTexuk3pm1FkIIYty5I=; b=fqsQLHmbuvA1eMg7AtBAoUPwl
	kBNWLRzcXBZx3MigFTsSJgu/vxcPKzEPexWBFjFrxyXzHxL2fqF61B6tpbWwOJrQ
	Cxf4kMh4uXwFFx9Vy+ZyEG9rxn1A4M8BUISaLH7mN/6TMhUdN32fRWwIuNzWMvUB
	eNftCgKNLD9NAfYJlHxtVIJdsXW/6VXSuiJVe43FNH/oVTMUxiu7R8nQ5vmAdGu1
	VgAJedba0pF/tjCT9sgiRg9zidC7PFVvaHAADpSKdNeRnBjfQ/12O34t5MOoxt6R
	Mx/y1aaw7itYCsKQO+OWX7pUPeh3qkafatDW/ohnbNpe8UOQxFmNbWUtATaZg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4dw64s711w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 11:18:09 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 644ACMPl005971;
	Mon, 4 May 2026 06:18:08 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4dwckwq08s-1;
	Mon, 04 May 2026 06:18:08 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id B469C84;
	Mon,  4 May 2026 10:18:06 +0000 (UTC)
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
Subject: [PATCH v6 3/6] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
Date: Mon,  4 May 2026 11:17:56 +0100
Message-Id: <20260504101759.3319427-4-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504101759.3319427-1-nhudson@akamai.com>
References: <20260504101759.3319427-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxlogscore=608 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605040108
X-Authority-Analysis: v=2.4 cv=UulT8ewB c=1 sm=1 tr=0 ts=69f87261 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=VcQvXEo1OZcA_IiPcy3B:22 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8
 a=KfGVUnEDJfcTcdlxACkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwOSBTYWx0ZWRfX1MZ+z1MXANBJ
 Npefq0zhzvxUb73gzbbEHgGqt7EMHpbwTH869uhDPr5gVnBjeLoFBe6UKxiElrEve+koMqwxdTd
 qMtCdHPoMwenwyevZKA2amjwMzIEkRhCYaOUHehfd/+oJviWV543zMEEY1k2mrWHPesDR12Sj2D
 ERvOSBs4w0AX6L5kJ43Wn9by/9Amu1ZzOs9bSeHA1bYHiUZ6FO1xncc38zWgLbmqedFyenV9yfp
 BxoS3SHBctbDfL6RKbzduGuANA19k2AU9WLW37p/RIAyYCjBshaAqfQtNR8z+WCziUSLcI1IIfM
 89YxW57AuISSvBKF97YH+zkOp2U+adQxVRhQRxJOsLsHRYBxRGiD7gHel175nZEItvnnSHZLtne
 doMzO6InbABJmraTUxT//rvpZj8vMWjVUWY/9+jnogYD8KyKpbNynX73O0hFxYiY0bURKMNTftc
 3xDnP+jypW3GYZyrBhg==
X-Proofpoint-ORIG-GUID: e_yXvawwBzRrmS-I3P4Zt9_evSy_qy5t
X-Proofpoint-GUID: e_yXvawwBzRrmS-I3P4Zt9_evSy_qy5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040109
X-Rspamd-Queue-Id: 283974BB9B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283780-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,akamai.com:email,akamai.com:dkim,akamai.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

Add new bpf_skb_adjust_room() decapsulation flags:

- BPF_F_ADJ_ROOM_DECAP_L4_GRE
- BPF_F_ADJ_ROOM_DECAP_L4_UDP
- BPF_F_ADJ_ROOM_DECAP_IPXIP4
- BPF_F_ADJ_ROOM_DECAP_IPXIP6

These flags let BPF programs describe which tunnel layer is being
removed, so later changes can update tunnel-related GSO state
accordingly during decapsulation.

This patch only introduces the UAPI flag definitions and helper
documentation.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/uapi/linux/bpf.h       | 34 ++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c021ed8d7b44..4a53e731c554 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3010,8 +3010,34 @@ union bpf_attr {
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
  *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
- *		  Indicate the new IP header version after decapsulating the outer
- *		  IP header. Used when the inner and outer IP versions are different.
+ *		  Indicate the new IP header version after decapsulating the
+ *		  outer IP header. Used when the inner and outer IP versions
+ *		  are different. These flags only trigger a protocol change
+ *		  without clearing any tunnel-specific GSO flags.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
+ *		  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
+ *		  when decapsulating a GRE tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
+ *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
+ *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
+ *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
+ *		  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
+ *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
+ *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
+ *		  or IPv4-in-IPv6).
+ *
+ *		When using the decapsulation flags above, the skb->encapsulation
+ *		flag is automatically cleared if all tunnel-specific GSO flags
+ *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
+ *		SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
+ *		removed from the packet. This handles cases where all tunnel
+ *		layers have been decapsulated.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
@@ -6221,6 +6247,10 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
+	BPF_F_ADJ_ROOM_DECAP_L4_GRE	= (1ULL << 9),
+	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
 };
 
 enum {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ca35ed622ed5..f4c2fbd8fe68 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3010,8 +3010,34 @@ union bpf_attr {
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
  *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
- *		  Indicate the new IP header version after decapsulating the outer
- *		  IP header. Used when the inner and outer IP versions are different.
+ *		  Indicate the new IP header version after decapsulating the
+ *		  outer IP header. Used when the inner and outer IP versions
+ *		  are different. These flags only trigger a protocol change
+ *		  without clearing any tunnel-specific GSO flags.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
+ *		  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
+ *		  when decapsulating a GRE tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
+ *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
+ *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
+ *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
+ *		  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
+ *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
+ *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
+ *		  or IPv4-in-IPv6).
+ *
+ *		When using the decapsulation flags above, the skb->encapsulation
+ *		flag is automatically cleared if all tunnel-specific GSO flags
+ *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
+ *		SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
+ *		removed from the packet. This handles cases where all tunnel
+ *		layers have been decapsulated.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
@@ -6221,6 +6247,10 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
+	BPF_F_ADJ_ROOM_DECAP_L4_GRE	= (1ULL << 9),
+	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
 };
 
 enum {
-- 
2.34.1


