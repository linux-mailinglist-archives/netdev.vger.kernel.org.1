Return-Path: <netdev+bounces-267394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHNCL0vps2l6dAAAu9opvQ
	(envelope-from <netdev+bounces-267394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:39:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC628194C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32B6F3012BD6
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87239022D;
	Fri, 13 Mar 2026 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ianYR3tF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d372kwgy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCCB38F646
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398331; cv=none; b=sc0Z4tPflRngWhVf7df1poqgA+AlYeVODeXlETSguDNQmkd/AiqBzvNo3WKWCHLnZFqeMQnN8Bje1xAV7LFZblkeOoqNTZWixfSv7z+TfaO2Bnj1HlnQvhOOSGCmwFn148EhU4pAQjWZHeEYusFhesp+g3d98Mcgvo21I4KGnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398331; c=relaxed/simple;
	bh=hCXR55fCmPiRCyQqGTCJojtheFC9upkm3+wmoWyQkc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNpIChpB+vF97VDy+kI4tWd7jsjpxpiaDmWre7ex1lO11X4o/+SMffoeB8kiLrbdyG+a/zx7Ba2dhJ8y+1TullVrl1ICPvJ5g6EJ09/hkrurd09b9YbtDG6M+UhRHl1zoktUHpI9k8u0Oi1vMd6t4oC98EVbXbA5N0HYtIwugWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ianYR3tF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d372kwgy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5ti833230023
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vNi1JDgqv33
	27PJLD+mby9dxes6qBefe5To68tI2NvE=; b=ianYR3tFHT+5TrOJOSUesq1FUGA
	GVq3oaOBrRcU4rAM9ZqC4BqU2b6EUXQqJgdL11/mmeBeDPKv1xZT/gyji5/gjeyq
	TSV4dx3XrSZIPAhx7nSEHLKQ46z8QztkP4rGHZ9dx1RBu/GOyZcZDyzS+H9fazHm
	BXk4n8XYGeIlWCIY0jors7P/MJ0IbHyg28dehT/+/5Y3oUeZGLDrEqEPSeZzC8eC
	xR5hpoeIXm+hKLziwugJKjD6qfSslhtxKtyOcXfJHqtX6IbLS2gQygSfyxiLu1vi
	agkjpz9YWuj6KXIG2ZiRobR3gks0L4mJXn+bhYq5ZoRbv39TfGnmaSeFUHg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7hrys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd722c1a69so1218636785a.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773398329; x=1774003129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNi1JDgqv3327PJLD+mby9dxes6qBefe5To68tI2NvE=;
        b=d372kwgy19m7eGQwgym7sTjYnbJlUSxYHsPJa52wrFWgxXictKCdKJJBRhZh9RTjfC
         TrRuqD8TADP4zDzjMIX+lu7y+wG6qU904vnNmHn2ujbVUr1/Yg7mK3ETu4f7dYXoXszQ
         OHZzgotoIj7mQMT02vsAXvFy/sTgckT6HeflcnAuCA0HhxugJLHe5bTnflMLSchSQc+4
         379E8kjdSCbDgbq331VnKBdNDuJOg8mbzztC0R9BPIGWv75fh/jRRAOFGQeWVor/OQAx
         dxZYTn2rlIEmkyEuJnJkvWQd7Xath2Rp5NIxZi7rdNmr6AO92NQikCjX83jU+zjUnJjP
         8TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398329; x=1774003129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vNi1JDgqv3327PJLD+mby9dxes6qBefe5To68tI2NvE=;
        b=Q49AYlIs1G0iY1ICovPz7xTR6IKzgKHrAEcA6c/ekLJ0AANnBGVxMxjCylIX2P56KH
         kUw5P4r7Z0ypSw1EK4bGpSkHLyoSfhGqzAg0GXU5QfWWSaAedtPYFk22D8Yky16kgIKl
         fwOupHHtcvtTaPXYf/MFpqpRnHWt3y+7o1KlXSqbNly9JiB0bfH6mIyVfks+DDXphMhn
         h+cNt/TkHVufBaScK8mcJxCIV1HoZFTXtpJ7H8iFJo4ZjKrWl7yLhEtbgVu8KnBbkiQg
         XfgyRJZl6Xku4A7vezDv9VY4iG+U3GiJR/sBgVrMvkFZZK4p1eE8KvLEzDK91huxdxXA
         c4kw==
X-Forwarded-Encrypted: i=1; AJvYcCUha7UK7myGtG7kEJUG8UiUlHfsVbBlQFAUf5USWV9jT7IxlMeEDN8V5MmCnr0t9BA2ShdEaKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHou/HSKLEK9ixmeXrstqMqcH2I4Drmd5IeLdQOro1T3t5gMc
	xQ/tDS2Q69rPdTbIiCX+GMYuxeuaBzzZkkfNln6nvYOX+/J58DoMx+fl4UgrCyTquHh8ePDJ7JM
	Dqk6NmQ0gK1ZHqIPwO9SuLY//RhjaJI77yNtO41dbyJAFQFPZzk9/hidrOGw=
X-Gm-Gg: ATEYQzyC7R+rW/njgiOvwpoQsDLaT7GHoNyJo/RBhReraidgaUzVl4F+eh3RKqedccz
	NKw0mJPuxlYGUJUwzeTOtziziflyy6VcPT/5rRvbn5RqUeyBsiIAIR0gm+oIwACZwXw086slrgb
	qf4T6yp5r2745naIHGGulrnVJ2hCwt5Htm3G89pv8hjwXiwW/8Sb346O+5J3vA6usCCfhioIkqN
	YMwJTLEsZgjVkff2T+CVJbMGp1pD/CeLMq7oSdnq5IZpo6Gfl5bmj2clvsAuVMpsXbTjwjyi9+Q
	+xz0mqur0E0OzgalLv6G6k64h4CplWNlJVyFTmI2Y7vZXdLuWMPG7glc6jBJ4zXyKkubQ0TxHcC
	zoT+iGw6f0+fauxdoLFFNpBgva3jPHqXqLnvglpoYNxqfNoAyQAKgtOc=
X-Received: by 2002:a05:620a:4510:b0:8cd:79aa:6931 with SMTP id af79cd13be357-8cdb5b6f77amr366771985a.58.1773398328791;
        Fri, 13 Mar 2026 03:38:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4510:b0:8cd:79aa:6931 with SMTP id af79cd13be357-8cdb5b6f77amr366768585a.58.1773398328377;
        Fri, 13 Mar 2026 03:38:48 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556426be9sm20183445e9.9.2026.03.13.03.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 03:38:47 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, r.mereu@arduino.cc, m.facchin@arduino.cc,
        geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 2/7] arm64: dts: qcom: monaco: Add missing usb-role-switch property
Date: Fri, 13 Mar 2026 10:38:17 +0000
Message-ID: <20260313103824.2634519-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6teVuufSxMz4yiVL0DrBVVCKqAM-QIUP
X-Proofpoint-GUID: 6teVuufSxMz4yiVL0DrBVVCKqAM-QIUP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MyBTYWx0ZWRfXzK++8NQPuKb0
 PKaUBLf+ilIYBGifzw17AY4+GYd4C6j41Kuxs0zOgtog6o1VE+kgS85dchO6XYvkzkThNEkzESB
 +cm/UGNv/6qTe0UvOpD8zZrkPekE9gowGFuXtHhwGj2GTfFkTOh+SUO7UxoBjiwHHy7CbvCrOlR
 Kv9rw9C6lK8m0Vwz+shum3xvLiV3k7cniHx4qCts8HSgLRJXYhm0skuUe6urAOH4zyXyiFjPuWh
 B6iXQg8CXbGXgZYNwsuGbYmrSKYRnXTNlUUd6EcpoLMe0tTMOhYJmbeFaTe6Tcymt8cMT8Qn/NJ
 hupzcRP3tNbIiZvshp28MLWMEd41CAmvJJvlQxH1v1uNvKpjyLWu7INrKF9hr/f8Ps03G/ONnEt
 r9waGyiC+WtNeeZh+hsL+k1kEkt5IN3dG+NKrYep6pAfMqOKOaT55oRJcyV/Hl7rwinHg6cGrcI
 rsQzXz8AZVXaEBey7dw==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b3e939 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=7wbTcNuVWEeP-7GWRuIA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130083
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,arduino.cc,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267394-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7BFC628194C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing usb-role-switch property to usb controller node.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index ce1565c7cc3b..b3a2bca58a73 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -5177,6 +5177,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			snps,dis_u2_susphy_quirk;
 			snps,dis_u3_susphy_quirk;
 
+			usb-role-switch;
 			wakeup-source;
 
 			status = "disabled";
-- 
2.47.3


