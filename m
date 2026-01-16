Return-Path: <netdev+bounces-250374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 744D3D29987
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E76D73010D78
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D551333343D;
	Fri, 16 Jan 2026 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GEOKre9d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dhdhb1QS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BAE330D29
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526819; cv=none; b=GQXVPH07eXDbUdAsUZ38UkSuLFQt6bbSPZL6p+Ez9UPb5w4gpi6wuAa7avPPEzohrDsdJXCrI9qEy65w/fw92/8qA/fWCNuzYFcuOG/9P3f2ptMagkFPKjuBkz7q8yuuqJyzEZlVOcBg36ZwXeFuQenD8Srr5Jo26yOExsrktJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526819; c=relaxed/simple;
	bh=jFEv4r2MshB6wePmIpYJFsvQK8DMRqAxq3m5JyCqHXI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N1cAbypLuDlGbUg/305s6IDA8e42FZbdO/Ya5iM1Hxy94YvjOuMkvM061rHgba0OsMVBym6d/C59AXyKVCtJcZztgNepHWrNlGfGD7ATVvbVadX4L6ofGItC4rPb//ddhO0iktUdJW4FeG/93jd3acO6HGsKSKW5cNlBgJOk+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GEOKre9d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dhdhb1QS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMkqc13582607
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PBgxiuAXPzWcnKnXjmT6ZLSdskE4wPWQ3nQiKjVtdEA=; b=GEOKre9dEnjiBaCS
	0orl3WNYbm98jeOUDJR0D0F35xPk+Gz+tAFHWqPkRess5eL0PSZOk5n3OaxHclO5
	FxWKZ8oDE0bvt6SG61nCjtAZCUIoxKIcbWiM2ZmoZt6dCGyfXB4OBzSSIzKp7oH2
	/7bM4l2i5YKVT5222vH71UZ9ALuG744+XddTKAiBjE3T8KiDlDVUfoutmzn0LhCd
	/Rm8mv8TBYONtALZwv36/5zUwS8gQA1Gw+XYZMGg4tVmXDQUSbJxvTy3eJh0Zqra
	oh9jtTwCOZ3rlwF80kST5JOUVSBUnR6EIcqrJlxOhLumjh5gDATL8uhaV9v3j7sh
	tLkZug==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9ayraeq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:49 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1233893db9fso5558879c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526809; x=1769131609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBgxiuAXPzWcnKnXjmT6ZLSdskE4wPWQ3nQiKjVtdEA=;
        b=Dhdhb1QSpWAeH4VORuKR8cfMsQO0JNOctyLRmDZBfcOzbPZIinG3jE1H7Aqvp/3rnc
         +Qk/Vb2v4fjYeq0ArYKyrMrhhoV7y+q6+RCoY5U+dGI/lfaedcC6sz0ZCtzp2Ptsio6i
         XArNI5Bu45EJsr4sbUUyiKgar4+oK1PBeYx2k94bJVkkBXzZdQ+iim8cpSbwXOXkP/M4
         E0bWz2Q3tMyIdeu/JMvkXF1pNIEP3OoHTuDwx/B9oLt2xryAdV9JVc73cjK0JE3leVE+
         ij60XrNDThAHmFEcuXZeQF2/dDo9LVqO8O+hCvtSVboqIKXp6ltXqe/pumPZiYgrOxRr
         2fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526809; x=1769131609;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PBgxiuAXPzWcnKnXjmT6ZLSdskE4wPWQ3nQiKjVtdEA=;
        b=KYWkuPU84oe9BMGxMsxHsQ07OSvN4eHvMgNnQyPDoX+5khzSRELGpTswE5HN7KPwQ+
         cLOR5P6HuTQGBIwOP/fx76sXt/ZH60m2N7vUeCa3BU3hXhdfh3nMifcewv5ZZwDa85Kb
         cMSAPLbmagBxWJDLWHU/a10OQaKBfox3RhBBSq8UtmKYN2RxeR3QODHS9pDuJMCKFrwp
         UXI56TwF8sKvxeNldv45x/DVbTa/rXvz9qWPy8dpHovv4sTX2zeroEt43RrC0ZveZy1N
         bXvUTeKIH/T/sn2mwm/sRiR1zm5fvr1jr5FvyF7NnezNwA3N9DGXnacw3J6/RgXIgmxq
         rA9g==
X-Gm-Message-State: AOJu0Yyc5j1Ty6INVuKl04uCxWcYCrQaMIa0L0LRpC4RtuEzwXlmaB3W
	5Qt4+ulIAkQxypqNAMeLmvr83Ua0GUDXRtbDCRbqKgtCOZ8j2nX9XdF9sUWTRfmu2lq1VmJ2h1i
	bYUiWPym31Giw6dfU0iDTOBnSvA1FIlb7yMKgp/SEqmgROeNADbKDc6u+yGw=
X-Gm-Gg: AY/fxX6d/8PT0VoadDPuQQbzscFdXeYrbh/WdbMN7wfw22SUXSVtVsEaCwFbVQzp8NH
	CXA3ITIIVqMLWPMsFGc2FzR+am6loN8UUTRkdIFg/rL2ZeYNcCID0gnI3Wy/bEE3X/UDjCPmgqj
	tySiVCgyxc4Oi2729dZaylZfayX42DO+XdCMrZu3C0nkkEIsrEswcJiRZDSfbRUTHHmY3iVe3ce
	JKJby4OEWMKR0mCY5mWCL4qRBR0ecMNBNC8Uq7T9Ku7P+1/pHupU9JhgE+wO/cp5NxbdmusdHvL
	9ClM10Z+EhN7WZKC9T51hjVI8kb1WzTh/BKUKWh9nMYli1taV2C3DN9gxGPISQrZWK6tFhaOauX
	m1r8l/HkyWL73afyGr/hBc4QPmLsMZU0Wjia2H+jxL11+qn+EiIwLY3HFiBfHp1I9
X-Received: by 2002:a05:7022:a82:b0:11e:f6ef:4988 with SMTP id a92af1059eb24-1244a768b4fmr1849084c88.36.1768526808741;
        Thu, 15 Jan 2026 17:26:48 -0800 (PST)
X-Received: by 2002:a05:7022:a82:b0:11e:f6ef:4988 with SMTP id a92af1059eb24-1244a768b4fmr1849068c88.36.1768526808276;
        Thu, 15 Jan 2026 17:26:48 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:47 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
In-Reply-To: <20251117020251.447692-1-rdunlap@infradead.org>
References: <20251117020251.447692-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ath9k-common: fix kernel-doc warnings in
 common-debug.h
Message-Id: <176852680775.1143034.16687864717347544330.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:47 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: ZvFtUL9vytRlQud-ZVu5OE8kTd1rliOH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX2V2M7nz/7iyh
 DPOjW+iEvlxNSa6f0jPIfTLERyQfwLkNZpclsTyqmHcs7Tb3J+zzEKOJqvSmhUksHjoadWIUGzi
 OXBr+2do8FB2IIXZncVXfjkcC/3F+HPxAsM6iGTixEhiWa6VcebuNm5J17MnbXZkFZ9Q8oCY/Am
 vUkbKIcagQ4H5ZT6MECtApmckXn5cjd9/wWceMkQJkQ2Rt9h6yCpqIOXKCBKLJ/unEbX9bpE5O1
 CENneW8zYbrwE25X6SrNUL53sFVxfXaojoz//OWRPDaqAzlnJSPfLavintS6HuUGXxeR6zmGH6d
 CYzZzxD1MH2afd288/s65yFWbjb/zsE4HulyxfNgMRq6m0uCFZLEDd2Mt7Zz3RjTkaThefSmJJg
 hmgrjsARzLVUZyFS84S7HQCV5WlVzfelZq0eQbxvYWG8YW9fP0z5GXeUKekkr7kpLRuFy3f+iCv
 P6DM+hgn6ooPaCxtBeA==
X-Proofpoint-GUID: ZvFtUL9vytRlQud-ZVu5OE8kTd1rliOH
X-Authority-Analysis: v=2.4 cv=NfDrFmD4 c=1 sm=1 tr=0 ts=696993d9 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=S9M0uSDcFDzX38LZ9aUA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Sun, 16 Nov 2025 18:02:50 -0800, Randy Dunlap wrote:
> Modify kernel-doc comments in common-debug.h to avoid warnings:
> 
> Warning: drivers/net/wireless/ath/ath9k/common-debug.h:21 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:23 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:26 bad line:
>   decryption process completed
> Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:28 bad line:
>   encountered an error
> 
> [...]

Applied, thanks!

[1/1] ath9k-common: fix kernel-doc warnings in common-debug.h
      commit: b9909c19965dc9e5a3a898fef09b437fcc3a9494

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


