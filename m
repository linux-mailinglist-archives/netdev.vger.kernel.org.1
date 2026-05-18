Return-Path: <netdev+bounces-288811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cS2JGMRrCmqy1AQAu9opvQ
	(envelope-from <netdev+bounces-288811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:30:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C6564D13
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A71A7300AB16
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029FA231A23;
	Mon, 18 May 2026 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QbPTvKY7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hiIzrVfA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF94405C49
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067840; cv=none; b=esGcSMhquQ4C0TR8yMWmc1aXYz0dUKR4q9YQ5vn+lyZIGZYtuMW5+I5U/XXdqk9Fpguk+m9cmZ/RszSs1cv+LouY0/inaGEV4dXl+tzZfgOWVMY264KQBYqCHqXCWWhmrLxDv1COQGSeLki5DRYQlofc8xICS1EZBQNhSzDCsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067840; c=relaxed/simple;
	bh=hh9ilvQ9BN0QU368cGXI2oMTeMbGtV3oXAacHwkLfQ0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=J1a3TCRO6bP0whVqHMNPinMSr1HN6Mqdqd2HP2/76NcMohKX9w4JiI1kpN41M1EQkZRuUDqCX8ZT7qz+FonKtzLvgOJ9oi1zGR6sZ8O9SM0o1182ucN0+EmH6PQjOfugOl4p0q+kQPS4Pulgus29EAmxTjl3PW48Hwyo8qqm2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QbPTvKY7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hiIzrVfA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HAOngI3595488
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lnF/Ok45gY3a3A0tgLNaHq
	m862K8e+GRmlIWqlKn4kI=; b=QbPTvKY7cE38U9tlV6EhGAhjZe6l5ZfRdZ9iFt
	wNamyJ+En7vzPjI94fHCoPwHBI1GNLuctYTyBTWmctv8ehK9a71X19C2SI42rXm4
	7aHMCfjA6x9RQCjpsAkmwdmyCPs1R7aISj7FknNJlvWDjMpBXQBsNOwxdqWFgMuO
	If5Lo+s6UNB+NS+86jpg2dbn1O3U8DBYpr8jIAqsJuC5BWWNjZqGarfgV+5Ylhfy
	7+QYJifU9nd8EIkWNYrirIJTd3cDUaajuLY2hCX80DLQWDpES2d/q9+JO8pzo3se
	oidCQhZnL5aZsmX+4Iub/WO1FhILt76333BxjxYGMV9PppVw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h0qbyse-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:30:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30230e64087so2001490eec.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779067837; x=1779672637; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnF/Ok45gY3a3A0tgLNaHqm862K8e+GRmlIWqlKn4kI=;
        b=hiIzrVfA+FEKhfLIXw5v5164GNHsTXQENfeBxZYcWlUnWVyCNKOU6qR+qlnLJWXvlj
         0UXh+ZgYHsCYlPfzW9rq1rUiyk7QY6AJth7W4NEZFDDbP7myPrQ3U+C7UMWA8pUwrZ/U
         SS5if1XvCsYrjx0ZULCEXL3MUDcWGVCXc69bew1i8kMjbHB5EVQu10CTnmCm7O64kvko
         fPm8ZVK6Kkr0ZTyP/Q3wv4/Rvbu/rmHnqcam8AdtCKmM7to+I9sYWBb6ocVsxTxndlAY
         rC/hgm08qoRFY6BryCuzAngs8up+DcZark3gyzIBSMq0yC3WlwigOdnOVXSzk3vnQgC4
         DO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779067837; x=1779672637;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnF/Ok45gY3a3A0tgLNaHqm862K8e+GRmlIWqlKn4kI=;
        b=nnWeaPARciMekQwqjr3CxzPuP+n74KT9Si6BSBWvuWrUSmfaASHKXuJZRIxWuwjhxv
         Bx17t7/3fxnTl5Zc3pZqNhipkjgqRR3GlvQynCd+b5Gw8MdlV5fwaARp3xdvDKiXxOeC
         5B7p+rYh/x0swICGlnjnmmHeAN4gSd3iLDBwiQmS7Tp70Y4QdWogGnbnyuyucNW5ihxe
         VE5RnoE5I1U+NJw+ZvpNGvbXmLRQZ8wtpB5XGsIggTi5S/f3Ya47NRcqSm7iJhUeMp0n
         3EMOFohTvoy+puiZnJhunFR/OCQc+8sUn/ahbuMBVPMl9nxDpuXlWEozqFTu1FUePXag
         O8kQ==
X-Gm-Message-State: AOJu0YyyfqFY6p8NHIoAaxyxRxx0gLD2Q6sux/nmEkE9QOduiDuU/b2V
	xCQAA5QgfmHWy7PwnFXZZ3G/w4dW8LwiqyiG7ZKAxFiANzV6RZQjmb0C8uiLL8VUSWVHkmMYZoG
	CBd2V3ek/ZuQVyPc3fj778E68SLA/ed0LYHkQm6I4+VJLRubj5KV0dDivwPdFk9y48e0=
X-Gm-Gg: Acq92OFhn0fSHhRvIIHCFYpUywTgnQQe8hibwG5omNFlnx7rP45qMQJHWcMTsY/zy2q
	okqGnRTUrgCH+89KWSbFcfeF8WqofGycXTGTLrss1/9/n47AHIPdTSrxhObwsyy684x8CKAtTxT
	ZBMkvQ6TOrFo+zHUNSoCF6qhVsiCzaOZdPZDS5d8eXiejGfkYIXS2EeMrG7QrxKZrkon51xJxxF
	AiH6B+2WgFI93SRqIrwMSxsS8qi9eIgho7LA21/pwcSSYE4znCeLR85UhtIqjof6Ml5prymzIua
	ohohhyTQge8I1bNiGEo3a+hQ3A8niVqK/WJFgvQuPDSXOCndGYTeVsfsic9rI3UZipXI1XqaLnH
	L6YwHJjDiREn+uq+bH3m6sx2Mdkmp6rcbezAqhRUUu/5996EcLQw=
X-Received: by 2002:a05:7301:5809:b0:2f2:6dde:df50 with SMTP id 5a478bee46e88-3039868cba3mr6241665eec.17.1779067837067;
        Sun, 17 May 2026 18:30:37 -0700 (PDT)
X-Received: by 2002:a05:7301:5809:b0:2f2:6dde:df50 with SMTP id 5a478bee46e88-3039868cba3mr6241644eec.17.1779067836440;
        Sun, 17 May 2026 18:30:36 -0700 (PDT)
Received: from [10.227.174.152] ([207.213.33.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b1a79sm12702137eec.28.2026.05.17.18.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 18:30:36 -0700 (PDT)
Message-ID: <604ca54c-a94e-4ca4-83e7-4486d7392d71@oss.qualcomm.com>
Date: Sun, 17 May 2026 18:30:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, jiri@resnulli.us, davem@davemloft.net,
        Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org
From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: [PATCH net] net/sched: fix pedit partial COW leading to page cache
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0YzvaYQCnm5UW57QbvpJhqVp8x7w3_YT
X-Proofpoint-GUID: 0YzvaYQCnm5UW57QbvpJhqVp8x7w3_YT
X-Authority-Analysis: v=2.4 cv=fIMJG5ae c=1 sm=1 tr=0 ts=6a0a6bbe cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=0UO4LuSLTB0qstzv38KPpQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=A7XncKjpAAAA:8 a=pxxjg2x1fI-G0sRxPlwA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=R9rPLQDAdC6-Ub70kJmZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDAxMiBTYWx0ZWRfX2G1lQ5qcgmgz
 OGK8p4sNnqNcKGm/e8rhFqtLB0m58r0Gsf1jCYsJYEyKgPr6iY9Xa2uLnAGFtL0V6FjzV/iIl8Q
 wiBUxBpzooZTbE069QOq+QiO/x37UtEZdT0Ld4/+mkTtAwk2v85HpnDDn6IlHmR6BitwdYCTajw
 DMwqmjglgMlvMQhZ+zmROJYQshmic+bHUxPDCGUtAW3HW1qO3H3ZAgW0RDZLTmJnOQm5xof8hlr
 63U+YS4vtcRDccuZgv9yf8/7tdIHfS5ikJm08vHaDOYt4HwQBOWMhTc/ZKEV7QEp6r/+m1TP0ZD
 kG6nE5GjLEjGfd9iCm5G0Iw4WKC1axd1+KP7tTTpwo752ND6XB4CCZm5Vep3urxDiOlkbrUyGSZ
 q9yVKoFEkmQWu7CqvY6aNOOthW1lvxO5Br0eCAfkVfgsTGRz7+MxJjL4J1CyX4RoJOYyvLFlQQe
 iLx5Jyhct+uCiSUvyGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_06,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180012
X-Rspamd-Queue-Id: A85C6564D13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288811-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[rajat.gupta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From f12ea6484dbb75d1c13495e921d0595532317f2a Mon Sep 17 00:00:00 2001
From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Date: Sun, 17 May 2026 10:11:44 -0700
Subject: [PATCH net] net/sched: fix pedit partial COW leading to page cache
 corruption

tcf_pedit_act() computes the COW range for skb_ensure_writable()
once before the key loop using tcfp_off_max_hint, but the hint does
not account for the runtime header offset added by typed keys. This
can leave part of the write region un-COW'd.

Fix by moving skb_ensure_writable() inside the per-key loop where
the actual write offset is known, and add overflow checking on the
offset arithmetic. For negative offsets (e.g. Ethernet header edits
at ingress), use skb_cow() to COW the headroom instead. Guard
offset_valid() against INT_MIN, where negation is undefined.

Additionally, linearize skbs with shared frags upfront to prevent
silent data corruption when pedit operates on zero-copy pages
(e.g. from sendfile).

Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writable")
Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Reported-by: Han Guidong <2045gemini@gmail.com>
Reported-by: Zhang Cen <rollkingzzc@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
---
 net/sched/act_pedit.c | 52 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bc20f08a2..e077a2e82 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -16,6 +16,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
 #include <net/ipv6.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
@@ -323,8 +324,10 @@ static bool offset_valid(struct sk_buff *skb, int offset)
 	if (offset > 0 && offset > skb->len)
 		return false;
 
-	if  (offset < 0 && -offset > skb_headroom(skb))
-		return false;
+	if (offset < 0) {
+		if (offset == INT_MIN || -offset > skb_headroom(skb))
+			return false;
+	}
 
 	return true;
 }
@@ -393,17 +396,19 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	struct tcf_pedit_key_ex *tkey_ex;
 	struct tcf_pedit_parms *parms;
 	struct tc_pedit_key *tkey;
-	u32 max_offset;
 	int i;
 
 	parms = rcu_dereference_bh(p->parms);
 
-	max_offset = (skb_transport_header_was_set(skb) ?
-		      skb_transport_offset(skb) :
-		      skb_network_offset(skb)) +
-		     parms->tcfp_off_max_hint;
-	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
-		goto done;
+	/* If the skb has shared frags the user is likely using zero-copy
+	 * (e.g. sendfile).  Those page frags may point to page-cache pages;
+	 * writing into them would silently corrupt the page cache.
+	 * Linearize so pedit operates on a private copy.
+	 * If you want zero-copy, don't use pedit. 
+	  TL;DR if you want to use ZC, don't use pedit*/
+	if (skb_has_shared_frag(skb)) {
+		if (__skb_linearize(skb))
+			goto bad;
+	}
 
 	tcf_lastuse_update(&p->tcf_tm);
 	tcf_action_update_bstats(&p->common, skb);
@@ -414,6 +419,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
 		int offset = tkey->off;
 		int hoffset = 0;
+		int write_offset, write_len;
 		u32 *ptr, hdata;
 		u32 val;
 		int rc;
@@ -451,12 +457,32 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 			}
 		}
 
-		if (!offset_valid(skb, hoffset + offset)) {
-			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
+		if (unlikely(check_add_overflow(hoffset, offset,
+						&write_offset))) {
+			pr_info_ratelimited("tc action pedit offset overflow\n");
+			goto bad;
+		}
+
+		if (!offset_valid(skb, write_offset)) {
+			pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
+					    write_offset);
 			goto bad;
 		}
 
-		ptr = skb_header_pointer(skb, hoffset + offset,
+		if (write_offset < 0) {
+			if (skb_cow(skb, -write_offset))
+				goto bad;
+		} else {
+			if (unlikely(check_add_overflow(write_offset,
+							(int)sizeof(hdata),
+							&write_len)))
+				goto bad;
+			if (skb_ensure_writable(skb, min_t(int, skb->len,
+							   write_len)))
+				goto bad;
+		}
+
+		ptr = skb_header_pointer(skb, write_offset,
 					 sizeof(hdata), &hdata);
 		if (!ptr)
 			goto bad;
@@ -475,7 +501,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 
 		*ptr = ((*ptr & tkey->mask) ^ val);
 		if (ptr == &hdata)
-			skb_store_bits(skb, hoffset + offset, ptr, 4);
+			skb_store_bits(skb, write_offset, ptr, sizeof(hdata));
 	}
 
 	goto done;
-- 
2.51.2.windows.1

Thank you,
Rajat

