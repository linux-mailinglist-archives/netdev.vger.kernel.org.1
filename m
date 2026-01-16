Return-Path: <netdev+bounces-250375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADA2D299AB
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F4063023A24
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCEB3346B5;
	Fri, 16 Jan 2026 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9He1gNQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rn6BeU1f"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CD9331227
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526822; cv=none; b=R7bBVae5XKySP2MXRElDXhbCefywFhaYbeapVgcQ2ZBYnSKgVthRwtofb+t7YWzI170wQR8Lolq++a71mvf+APCIUzP9RBXCFDqlJNQEEAY798WlOKAsw/3Jn8tMFm2W8Bqf+cJxoEZQRThfyEAcnq7eR1/VTfsD2L7vrPShXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526822; c=relaxed/simple;
	bh=sMAy7zd1opS4aRD2kuBC1Ma54D/PCB2a7vbQKVzJk6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cjGIO1DUEStVa3MZb1kSbLFEAZaorBFOnlYgeqJl+7CCyE4T2ybZv1lL/pkp7LJzE5EP95PAhJKL7XlVaXjLhbntbxNzh4hb1l0pOwCCgAb7cZnllRXv0L6E4cN6CrhiqMvVF1tREzDOie5JA3WzEwHQuf/8seFaGc3/V4peVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9He1gNQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rn6BeU1f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMbLrq3714147
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VrFT9VL98gSPuEHlJELHA6Ht46ZpQXK+BcHkeUKmXTI=; b=T9He1gNQPvr1SvtW
	weanQG2zWEbClhyd892rK626vUhoDmmmhUHG96ATZK0h+Y/Ku0CSqtI0GkMkk1lE
	4LPjGmSTmptb5LrMHyaeHsMtxAauNXL8XWgLbSVLjKZQgkS62VY4u76Wa3qmdPMr
	ebvMMrFa4ILHH3FItlIImQsK4GSRkWFmg3W3onH8fA2tgislmEMNkiDo85P0nQ1M
	rcXpOjx7gVwYltmm9dVJiWMceqwqbkkp2ue6n4a24vkANqbKuZNomVpD2d3m8c0v
	rY9FC2eM5nX4S/cLjUysL9V0cxJaWrJkqCTM6PNKUOcVGTigF9ANAmm3lYtFuNUM
	PGR3eQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96p8b4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b6af3eb78dso3359413eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526808; x=1769131608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrFT9VL98gSPuEHlJELHA6Ht46ZpQXK+BcHkeUKmXTI=;
        b=Rn6BeU1f3trSbEdFY+1mubFWZQT4YvjibN90efq/DGQJFsR64fAoOo4g8QUAvbElTC
         1M0UvEHVFxsFcET8a17o/fYIb2XFXhx7MeIis/Ulvb/DmBHgyOiRY6o92iXXiLbAYRTe
         pXZ5pwV0/SVl3vRgVNXiPOnJIAI+PLXoy4zxdUZnvJQ6ldSXV4kvWPVOqKj40ETUHoL9
         l9hqUsZgYgXbkI5y22+3quIo8T2Apz83xY99H/vR9l0hlFCh09m2f3WIMJ4grxR+2R4i
         UmpKT/mrO9SMlhUM8dfFHdMADQ3Dmb8B9bqoKPUHAPP9VBUS5diBtTcknYyBhi7EA6jg
         dR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526808; x=1769131608;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VrFT9VL98gSPuEHlJELHA6Ht46ZpQXK+BcHkeUKmXTI=;
        b=hqxtUwuioMxoh48g9kyqudxR6mecXKoLehakhfzt7X12gxp7gYFORsj4nHFLJZxyDu
         ON9KW9G5GHcAnRhMiyNsNkfy2W2dR6/Qph+eonPlDS5x/aSZJROUzWwW56bqWD2PSta3
         SkGFwyBBGpdEGHW+wqRELPR/WdHTp0KWvic0bojD2hjvOcFIycY40kLCFY9lJapM7VQf
         rhosH8rjjZ6twW1O2Lqmzc+8LLytHZDxc+tF8LcfydvM/1UTyY79NTzm14gDbg5HxAQB
         WymPC8QoZvpAyvpjttcfja0ooHq3qJhI3kyfykpy4hP2I9IfnO5nuV/zHTqluXI1V+F7
         AZZg==
X-Gm-Message-State: AOJu0YwW2xOO1qavKbUnSKIMb/KCJVE8O7Z1Rv7JvNiAWRqkS0gG2Q+4
	rzFmWrDJ4DOo+oAvf3kXLkAvKXWQbl0ftYiYND0BcWUOjYLBfFyzjkyNrQflFClw7bGxuubVTx/
	PM8JLGGpMfDHtG38Xu1bsLSyszr4cXYJ/CFUILot2ahytJvmNYVCNbS9fcGZf0rMoTmE=
X-Gm-Gg: AY/fxX5nIHjScfS/sV+3+K/fCJVClIAH6EzYNRIwp6WGTuTgyMM30LakZQy3vh3LoRd
	Es4IvU52/ZZqYzCBqEHnfFoVZZ3aljER0qLplE0bHGpOXvgmr53XDlH57h+7GWcGPMUs26VBsCm
	nNOUnhaV3Xp3JXiRO9f8Hx4y2sFnOI1jjXLJpbR5f3ZmDXzZYGkwvQRyGl7l6VeHzeX6lwYzaH4
	U7pg5MfkHH2HuIo+Brf3RXfo0434wP+Q+UUJ1S3gn9zKf5uxN1vtvACIrULngAw6epMZs62ssqb
	jQQKI2RPDBbDpmRQjYXxRiT3YXnxY2KWxl9hoEsyWQGc68O4D4B7Zn9ZtM3Mru031aql9XfK7wQ
	RiqLZDBfwM68tvsh5iqf+/tWc0HgKVRS1wSXA1GrhjKuYkGm06eCMqavuhGH+6HDE
X-Received: by 2002:a05:7301:3e0b:b0:2ae:5fb4:c5f1 with SMTP id 5a478bee46e88-2b6b40d9e2emr1295872eec.22.1768526808235;
        Thu, 15 Jan 2026 17:26:48 -0800 (PST)
X-Received: by 2002:a05:7301:3e0b:b0:2ae:5fb4:c5f1 with SMTP id 5a478bee46e88-2b6b40d9e2emr1295853eec.22.1768526807595;
        Thu, 15 Jan 2026 17:26:47 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:47 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
In-Reply-To: <20251117020304.448687-1-rdunlap@infradead.org>
References: <20251117020304.448687-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ath9k: debug.h: fix kernel-doc bad lines and struct
 ath_tx_stats
Message-Id: <176852680689.1143034.18235546514980577388.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX7P83i0Av2k69
 WrAjfPkN7jwTwWuyrfLvEupCZp8Lf+owrwluH+74KJe2wpc0zje75bhfNgf9XJYavq+/9NxQqj1
 ha7/4DG5u2oQ7/1iGpZUNvQplWpKOhz+pNY/OtFgyCvZiidQRbngnudGhneUkiXkk9NYdMN+2bY
 h1Us35IbYFZ73jI5vKyrm3Fv5pHzMc7wZxDqM1SbQO8fPF3+0xbXOhSo/Q1yHFnV1s9Rm+QzYTQ
 gZeayAVe8MyVIrblIdwaP2svPGa7g5kwUHJUClmUsQ531eDnpE0DiVhIXO46O3ns/sEcYXcSh/X
 YXruPjOAHbuHilDnjZIR9cf4mHLcE+d3VIMJDKsmo1A95tnynPd1bdosHRZCxC/GgWNMu0DLMWN
 gIsfF7k550A/WTTZCx4wA1SKM8VK2zWjAKQQycDlbYsFYYW4Ni7MxlZvN33xDBIyceoENll0CXh
 N4dfeWlHV61p56w/kVg==
X-Authority-Analysis: v=2.4 cv=M7ZA6iws c=1 sm=1 tr=0 ts=696993d9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bN4pwD7rly7kb_o33PIA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: jzhh0bpSlqpBZphI0jjNnRt4KSEPBE6i
X-Proofpoint-ORIG-GUID: jzhh0bpSlqpBZphI0jjNnRt4KSEPBE6i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Sun, 16 Nov 2025 18:03:03 -0800, Randy Dunlap wrote:
> Repair "bad line" warnings by starting each line with " *".
> Add or correct kernel-doc entries for missing struct members in
> struct ath_tx_stats.
> 
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:144 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:146 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:156 bad line:
>   Valid only for:
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:157 bad line:
>   - non-aggregate condition.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:158 bad line:
>   - first packet of aggregate.
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'xretries' not described in 'ath_tx_stats'
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'data_underrun' not described in 'ath_tx_stats'
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'delim_underrun' not described in 'ath_tx_stats'
> 
> [...]

Applied, thanks!

[1/1] ath9k: debug.h: fix kernel-doc bad lines and struct ath_tx_stats
      commit: c6131765a2c0052b2c5a2310ff92191ff33aec8b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


