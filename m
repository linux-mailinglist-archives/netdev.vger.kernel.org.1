Return-Path: <netdev+bounces-250377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A3FD299CC
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F24F301C38B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699B33343A;
	Fri, 16 Jan 2026 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XsSt1uPO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PaCIV0gM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417E333739
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526833; cv=none; b=g2u3a/RDwBgNgVZI/JKOB9fqou54ggOm9yTG/2PZ6Ygzm26FWBCBwIA0EfralEF5URhZtVKG2c/p8solMX6UeMiOxmze/hgBsbKTp2w3wompFDnrHYlNf4ZVkpD5R4hhe99kOXkewCmLDuLjCLh/vnT460LuI+jeDXnzhWHQDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526833; c=relaxed/simple;
	bh=c18PT218zlbEm4Uf1EIJ/xM7Xc5fuBgFc6eIL0xSpqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SkqVYsyTOjeKxOf12QVDf4J8LQtj0eoqGrVtw6FzK/+561Oo0S0zZcZeCczSrFnqcPoI2lDoXZpxNp7tstktQMuLG9aE+yPqmIijm5oT6RmF1FrD3YRkgeI75oUQ9QNqknxxvY7ysQTb04uVFjJXjRj10ZFezADEDWrV4bLSl+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XsSt1uPO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PaCIV0gM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMbZov3596324
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q5r+1ARJQu5gUlQETHqn0rU/JGMzmWYJZbk5E4xekuY=; b=XsSt1uPOQw2ivXsq
	UcWvAaOioKUkcgXE2WO5k5ule/8Clt6Eh+tzjEPfwmqb5pCLOZuQIanr80kuNztg
	NHNZqCS697eXAGXnZZLrmzgZdD6jBY9KZ/kIMc11zPtLlCIV19og8eN3qEKM6+kC
	T3wxrp0yBY7WbTIcETh0/nJR4wiDUDNT9zAi2gwE+dHTkfLPzoMb3A9+K27dUWGs
	WGt1lmTLSqIYT+bwG0+f8IVHd7lXdAyl3Ck1dGMbPmWsM5UyAPObU0apAj7/izV/
	ANO0gVDaBb1p1Purre1xJQjex3mSOtHRZ7rq8+ROYr5n4vT/QeiB/TERvXDW3sZn
	Vtidvg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96rrb6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b6ba50fc34so90753eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526815; x=1769131615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5r+1ARJQu5gUlQETHqn0rU/JGMzmWYJZbk5E4xekuY=;
        b=PaCIV0gMZz3HXLdXKYdabKC/iiqaExWliI5Jp0YZByeMN/O9jB9K3MkqzjiB0JZhpq
         Qh82iuErHk+VcW3upvYqHShvSQTG8hzr+8nxkUu719nqMPdZzhIQFsuKkojc/GIlcaNg
         ZG4KIBVi/9LyeaxHWklxkI7jDwk2BLGPhWGovwMlTjmG0HHnvcCeSp1cOw4msbYs1tEP
         S4cDuhIMPg05GEToExaDfe3W/0Ntf+EaURwSMbBwrc+r3EsxfiFvWb2IUslWsF/0rcjD
         CfVEiIBAJ7bhCwLqvUXhYqE2A+y7OiVSaESlG4CcS8yv3XlHG2EhJfKPmlfEm+UIPKYw
         BfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526815; x=1769131615;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5r+1ARJQu5gUlQETHqn0rU/JGMzmWYJZbk5E4xekuY=;
        b=a4GiZRQzNEz6b9/hcgHJphbQ8/8MT0XArOjrQ04lozQZNlptn+cEP9UnlyCyuIuX7Y
         ZVAhYZO4vYJqwZMhxxbeFqDOi4DSWxkC6sPTOWFUmQZC69VfA80vFaYvjqViZQcMA2IC
         9sM4Tjg/wYHMqdiXsH97El0/vLis6JXYQZY0S8jZAYW8oWEJoKhJffrpNV6gHZ7sXFjY
         PF39lOb9P3jQp+MvlD9k3hXTQc3QiMhB0WTk4138tBVOAoZ6UIK/1ioD/JADmz0IHqkl
         q6qc4OGUINeM5nOvW+Ux90wKEqIrdGPw6NgiLyUewNgGDDkHcrDAxy9onK19UsAGT1Wv
         QMXg==
X-Gm-Message-State: AOJu0Yz19ktrwIlKZosmdprk7sY4IqCr60LVXsUAJ32+pzmtq82kc3Uw
	TCNhN8pWWYXrCZ9QcleJov3n+ceTlxQ+ZnmVxnuW2/shOvSRv24DfVfJpOP7L1nWXCdmrGaBrsV
	l1d+jw8u98EFXsy0Kif5rdu47A4/s1v5oRfrxpFwGcLP+QIpYn0y/mZMkbYA=
X-Gm-Gg: AY/fxX481pzSO/p5Pn1JMD2ZKpM7Xb8WS58C6iQNIZVB+q4tHaU2t0zMvmmBTYvcKkq
	TIv2btMRDSMEWf1LGhV4VZb9V2UgF2+3UpevTwhWqN/S8jR8i0YYFv6OXFdMtxiXzDD9/w0To+8
	Fw8TTTazVUeGmPEEfZBqEy6a2DHkalAGA7LCTJlCmpMKqVdrXMx4B0E1X5jG17zZ4wDKS43XeQ/
	3qrVxll5uD/ZLF5RQtJr56zP8lzmPAN2GtU47nWIk8udf4gEpTiS1uoCi6eWYgN3i/wFBAhOCvk
	UK7p0CFfmb24FWSHxLgu2Tt/ENUgaidS4aXOxR2+zFcylR1wV09cWMpE1BMkQjxUNlH7e5SumBi
	uQHvTwVhEUV6ymThVLi08kN9mJmuznWb4kVb9lpq6wB5hgG2qCbp1BweLJW4m8F7Q
X-Received: by 2002:a05:7300:3246:b0:2b4:700b:3d8b with SMTP id 5a478bee46e88-2b6b40f4c86mr1458957eec.37.1768526814927;
        Thu, 15 Jan 2026 17:26:54 -0800 (PST)
X-Received: by 2002:a05:7300:3246:b0:2b4:700b:3d8b with SMTP id 5a478bee46e88-2b6b40f4c86mr1458936eec.37.1768526814405;
        Thu, 15 Jan 2026 17:26:54 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:54 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org
In-Reply-To: <20251128010401.546506-1-rdunlap@infradead.org>
References: <20251128010401.546506-1-rdunlap@infradead.org>
Subject: Re: [PATCH net-next] ath5k: debug.h: fix enum ath5k_debug_level
 kernel-doc
Message-Id: <176852681382.1143034.6647397811619355969.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfXzAMad0xsu8Ll
 cx3DdXXWrBxls9cI1+9e+BUuOjautmEDbdJYVPY9JfWb+qsC8QxTLvfCAAXEznwSIW4eDI66gyx
 0gOyE+J/h3FGF1T+V8cDSwBJ8ESiIIluFXVwSbFJTb/xJe+N7juEKCiqNLNB4rGf7fRJ+MQMBuZ
 IIvpPwXxbJi5OwGy7roA5xZ2ZzU+aPvab+Frbvu5oi8/1nrLoB3iPV4Hlzu6c+Pt3mG697pgaiQ
 BoQENZwhV88xWQK50TpiJl9p6KIra1rCC/hv2lCWr/e8P+FYpPX2TvDKtb9lSCix0lZQOYMBPXZ
 TQ1jegD1V58oGwMUXFM6I2DLjMdaedhAtW02HdZ7j8Rfsk5B6RL71ACwVRlyzm/kXKXURPxpxLI
 xuQqiKkpZ2fKPWb/BL3sZTvKrczmtj/zVVGcovGa7uYM3+PiHIUT7x+jpMwBE65ihxnzJ3xy6Yf
 Gmr3MKpMjyVonaI6UxQ==
X-Proofpoint-ORIG-GUID: k1eIMLhNXWwrHhT0KWgap_NL_HzLe88h
X-Proofpoint-GUID: k1eIMLhNXWwrHhT0KWgap_NL_HzLe88h
X-Authority-Analysis: v=2.4 cv=TsTrRTXh c=1 sm=1 tr=0 ts=696993df cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=nC4M4cfXRv_Zwgs_cF8A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601160010


On Thu, 27 Nov 2025 17:04:01 -0800, Randy Dunlap wrote:
> Add a description for ATH5K_DEBUG_ANI and delete the descriptions for
> 3 undefined enum descriptions to prevent these warnings:
> 
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Enum value
>  'ATH5K_DEBUG_ANI' not described in enum 'ath5k_debug_level'
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
>  '%ATH5K_DEBUG_DUMP_RX' description in 'ath5k_debug_level'
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
>  '%ATH5K_DEBUG_DUMP_TX' description in 'ath5k_debug_level'
> Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
>  '%ATH5K_DEBUG_TRACE' description in 'ath5k_debug_level'
> 
> [...]

Applied, thanks!

[1/1] ath5k: debug.h: fix enum ath5k_debug_level kernel-doc
      commit: b1e542b6f0775d35bf546f3de33644b4f761fc3c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


