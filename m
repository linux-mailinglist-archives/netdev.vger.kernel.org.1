Return-Path: <netdev+bounces-250376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F9AD299B4
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9918630935D7
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9E3358C0;
	Fri, 16 Jan 2026 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EdAgnLc9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nf3G+Y6D"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBCC32F74B
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526828; cv=none; b=VgpzCpLI6JhVMsqrOdSUlbl/AWZf4wabTf129uawWh2cN9irIsbSXnEqyBp+UpJudJXRESjC/4fJEjwHhl54XkcmHQ8ioQoMTwuD1+pzKEtv0flKR7yqE84lp7NgzxJt8RtIeNmdVPsfvbFUn6vvscnzQvE5PU3cv5/I2gD//EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526828; c=relaxed/simple;
	bh=weLV4S1JNlA0Bpx7zQILsNWg2M7k2nPqf+NA0UlIqFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U2h+GnlMrIOgxScJfcFUqzx2gd5ngL9heVCkBsizJ6q3RoV4dC60bImkBAMA0mdB0PGNlKE3FvDA56qxFGCVSyTt69F9DhV2/qU1DXQ3MPLxFZzyk50NMi7zulhj9xLdWejpNrjS/yogN17b79viWqXWe5r/xRObqqYXg5uxMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EdAgnLc9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nf3G+Y6D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMcqKd4100940
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LpQvFuAlM6RvgG7r1OildI3WSwOslhvFGZrVKlP0tNQ=; b=EdAgnLc9cXPTwcN7
	yUAkxvGN+RqljO+l471gjGeaiiIuh0XR0mg+gs9fIykR+e6SHWSi1sPTlv889AC7
	tW/phnGwJwW629MJ2sflFH6qlTnsFJbyman2lz6PhUUeDjF53WCYW4PX8Tn2A849
	u1UyvLCDh9lzJLrvGkWaxrk41tfiTtq4LiYH8EI8n1AQ0tUrFJ4IyvXz0y90Sl1o
	GF4+opSo4gjtC5vrhpjrSQCAe4dKFhHXNkdoi2BaaUmqdwm5cg0P4QXpW2Qte0/d
	wXl8SMoXE5VHfECJmMiK3m05VQw4dXFQlf+VmfVbbcIvypnHBoA6pj2Mv3uFjt7e
	KB9SsQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9750atx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 01:26:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ac39bd5501so1559256eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526809; x=1769131609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpQvFuAlM6RvgG7r1OildI3WSwOslhvFGZrVKlP0tNQ=;
        b=Nf3G+Y6Dw5DpuTC6+Bqt/20rTWz9omLFAJY5lGDmWDd2c3uIlRT0QDhInOeOSfpynn
         yEtD4UAtZWFckHDnIRa2ST4Au9drBmEquh26o4OLIv7ErGJWRkwfbb7gKXkEbatQhfha
         RcijNtOCPh7ffuCFjuYVjgJvXmp0bngHGIDSBQoOrer04EF1kYekaUsnIC2arLAdofKU
         lL12DPOpvbT2ujtQJ59RO6jIctHJNiQrB+aGgp2V6oe1of+8nGS4ddKH5Nvitct0LuKr
         3ZKp1cebMrA8HwIlkjjVZyfhS0a1K805kc6uBmO6bSACbs2MDHYgqXWqdyE5/u5H/1sK
         IpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526809; x=1769131609;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LpQvFuAlM6RvgG7r1OildI3WSwOslhvFGZrVKlP0tNQ=;
        b=N2nOUqdyqsbBhqp8F7VjJeM/Z6oK6HoblN5iu7JbXmqkmcMi0OqkSqSzG0DuDECWtY
         fsYs3pYQWTkEkfHmxAASbWyorRKbBINa2eQxjzP7QQm7IoW47lH5sLII6fQ5FNJOtu2D
         VNQGipMXc3i1bmk2N4+yy3ZtEpuwjzDym2CpqIU2Q+aKTQwralTuFP+Fr06eiPSSIODn
         N2S3YukBgM2szGS+ChbXfW10VLjp8vGJyr71+IucQc4znSHBg4fp4JONgfv3ZQ43GW2D
         /voo47RITRqibWCIhB8r5fb/EjDW4MtyTe+KZWIxv/i0h7B8mc3gU724fhd0SICLgsGl
         YHmQ==
X-Gm-Message-State: AOJu0Yzx/qyNCP78/iuQqlVGdu5EN1ZFruoT0hFNszgPe98HjjzZR8Bf
	aYxAMHGbAVq+vjNsBEHTRw1xCpMtn/2IlrInqD0/QOuKioAAqKB5KZcsrugPWOjp5Z8rjUiKeZe
	Yu/JQqDLFsPKDDiiwltaA4OAdE9K4MkDnWVRlKkKLsVgWZiSVCTn4hoJPUtEyEHOMWHY=
X-Gm-Gg: AY/fxX4l1jtlTcX8nXsP+S0sWOATnRsI0pzM4Msp7UmjF6EZzWNaB6meVnMpxYAbONt
	shtBte2o9qf0zEybVQaWiu5eQtE9qBk+4rb4qdHARDnumPKVk9Ejj+4mq7yVqgs9G2qqPpxC6wP
	YHEqAR+7FtTcTthiZxzeAudS98Y+wAhDbDojxK3JIsQW4rXuNVctk572rlihHY9EoQ313OAsnSb
	MSwQMpoafntKDG6zLi5vv3YtYEmulPziZ8TKvBbq9WtmoSa4Z8eIW77o1Ofou5T+uTM5Ja49+xh
	hn3MQEOfU3T/2n4nNSDl5hmtYzrxipn9LQlZBBJzZW8YhXYYuXNnZfbJf7KVG8E1nyW5ntn1yla
	sNBZY4j6E6MAAdaLbFXiOMesgtk7LghN0EwrXV+dWFPtijobsPK8ZL+5ahPyFHaKh
X-Received: by 2002:a05:7301:6007:b0:2ae:5d9c:9548 with SMTP id 5a478bee46e88-2b6b40f0736mr1603742eec.32.1768526809358;
        Thu, 15 Jan 2026 17:26:49 -0800 (PST)
X-Received: by 2002:a05:7301:6007:b0:2ae:5d9c:9548 with SMTP id 5a478bee46e88-2b6b40f0736mr1603726eec.32.1768526808841;
        Thu, 15 Jan 2026 17:26:48 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:48 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
In-Reply-To: <20251117020213.443126-1-rdunlap@infradead.org>
References: <20251117020213.443126-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ath: wil6210: fix a bunch of kernel-doc warnings
Message-Id: <176852680841.1143034.6879269716030726256.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:48 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX1+jChSP0cI2n
 qkHZELuvK5Ziu+9EZsz5QH8UBdh63hi+jdxZD5s+VRizBUMu4BSeIFfWlT/AxFW8icrciFqppX3
 evjaakavMvI3slMmi+DXuggTUjDK71TKYPzSM+58knyohvQDLdYwk/lS9JtzisoTKcQZAp7VeNS
 7LQXfdW8QrskqEXTe5oD5/QcnaMygfGdSfYCxD32lugSTBP4GQGSZsFQXpBr4LhAIBGUaykS+7i
 JODFKnfRAEP7K0VAWGYU0TACEp5F3gVGbxgBeDoB5Zheb6OUkCAg3OzWTrYik3z3ldfRO1Z0RFG
 13JnEGn/TIZPDA5xH3Nk7Hxt4SKLchw3jr9rnFlcNNzALnVMKkM6h+ILZA1M1TXQquHmtp3eqWV
 wATzpMEN85ZCPj052mEqBHyQ7NGCM3l5c4xYVb+SQ9L9au2vzErAtx9ywcv6FL1NWutV8QyGvh2
 dkp2rpp9ySqXPFyuiUg==
X-Authority-Analysis: v=2.4 cv=Sv6dKfO0 c=1 sm=1 tr=0 ts=696993da cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=asl5HiX3r-lTlHJPCLIA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 3DjJrzy6XUJD3EDe-O8RwBt39Bwf39VF
X-Proofpoint-ORIG-GUID: 3DjJrzy6XUJD3EDe-O8RwBt39Bwf39VF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Sun, 16 Nov 2025 18:02:13 -0800, Randy Dunlap wrote:
> scripts/kernel-doc.py reports 51 kernel-doc warnings in wil6210.h.
> Fix all kernel-doc warnings reported in wil6210.h.
> 
> Several comments are changed from "/**" to "/*" since it appears that
> "/**" was used for many non-kernel-doc comments.
> 
> - add kernel-doc for missing function parameters
> - add one function "Returns:"
> - correct kernel-doc struct name to match actual struct name in 2 places
> 
> [...]

Applied, thanks!

[1/1] ath: wil6210: fix a bunch of kernel-doc warnings
      commit: dec6a3c6d6dfc6402118529de230e76e65df9a9b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


