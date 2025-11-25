Return-Path: <netdev+bounces-241579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5736C86079
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F4064E2880
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1536242D8E;
	Tue, 25 Nov 2025 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NkyrtaWK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QaOs8DyH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1228E218596
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089287; cv=none; b=NlxIRBaCp9awfejoajSuOjjde7A3MloMF+rUfSqOWcY5ekjMq9osgO7iaK/GvoGnC0+M7EGqQv9PMB2q8PofcbMjGaDDOKzOcVtbRAPFPdiYDZoQ+9Yn8EOQcCSLbX8mHzLUatnhvKt+oLFpkl7GZG9WWoU8Bw/Ew0u2NKaiDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089287; c=relaxed/simple;
	bh=r2DFfPpZ2i3kDSKtZaDOyK+wMS9Iax66aLaU3RTMlmw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=seJf2YYBStE4w3rTEwvH/KCqS1lMS472XcXw2ivetuCYUV9JfMYkSJ84CC6zDDI60OlXchZ6Ao2ZiOOFcfzbdJuD8e+uLVRDbFBl3BufpJ/A9YsfO7lXDFTmlvanvHOjV0e9+D0HFPxlJ05ji6cURGiNqXMJnTviATuXlDlCKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NkyrtaWK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QaOs8DyH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP9rtCt1979085
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	owFn4+22Dt9h0dvI5JhAaFVHZpEFy+gIYCPbJTU02SE=; b=NkyrtaWKHf3BksNV
	co4/ZHHxJhVoEF38sLym/5hqSiUzlEvODNp1Htw0MyKx51h6lriWRYpdBaNEA9qw
	qfAPLZDkTcLFO00YMIH0tIMpdSyrkTxBQAAc66UZ+9SvkA66g0+Hlmg5F5CVOac4
	5bwA9HAMGUrTmK4xG5HdZM6gGdOzReCNKyUrldKOkFMgz5O277T5Vqo0K1ZEjHvF
	OZfMJSSk03Cn0ha/HI52HePRwh84J7R3/QhqJ6cMVyxVrylbjdEQ+sNv4uPpsRxb
	+x2OIswkstWjmFDvPLSRPD63e1DcGNxoh+YaKvth9MM9Fg4lLJ0OIB3WngbfZyIX
	DqJUHg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amw9gucuu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:48:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7bb2303fe94so5843246b3a.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764089284; x=1764694084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=owFn4+22Dt9h0dvI5JhAaFVHZpEFy+gIYCPbJTU02SE=;
        b=QaOs8DyHAjFwWRdc61RTtjiKeTwfr4Mr5AdaZf7YTHc8YwdxHqkgqPmITdjkE2irHg
         TBMLDo9QOkubcwXmPZ2MnBqS5dDJRepGV7imKp6Hgu4Yr7BsRE9/DsWbVz0batYAszay
         nSqpTKFGP+L4CAJoRHhIXhQjdPyqcA4G1A55c83jICAu1SV5IFgNb9/AjNEKKBC/STSp
         ECxXi6i1UeFlaJkMWjlRoysdQsVq4I7Ekx6r1fW/OSVrYOE6b0aC/UO83wNwDeZtHvoh
         CfCuxmY/9DjL2jQQ9FEQNDYEdggt80vcunCXel3QYh6HbjYjB4Nc93vQpyl1yNVOjFSD
         vYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089284; x=1764694084;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owFn4+22Dt9h0dvI5JhAaFVHZpEFy+gIYCPbJTU02SE=;
        b=XaDljOM5GtWPYCIwoiRq4Ahznpo51pGom334vhOsxJuDkS12RMiAcylx4d0QJzZDEf
         ieh+hSthzZlXx9X8BCXOq1IyARVJXpeNJ+OxkE+Yo4he9THUqDXQOQlzEUuNO/M84F+l
         V2tOg1vEnP1pUjM3YdZSBmqKfoFMEYsKl/e5Vx6lBbWa0v54KPVQVRL3JfCOH4KWLhLk
         IAfcspTqG0ZNGR+/+ygxyHhjhdq3KPnt3sua0zOpYd5PfYJkhROigavOQa+Rv1IeyNjN
         7uYsgq+wphVVmNawwa0qYIoJjmJ6lOt8rznwWD/l3WEjlihZqjWNujNZ9gSnRJ/mOwwM
         2xHg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+2fmniAsg0eDdxTMwkaInCL+0iQ9+iArP6OSdvcOo+D9r5ZmzUuWFPR5TLZ7FxVwZ0eBgAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ74TEENhezMLjfxaHtjx4eks2L99Zus4L5gHf3RYG8eqCbTXn
	76E8i9qdkT1hj7yFMaYZZs5jgLpZNafpXffS13nKpX9q0sg884n1yaMm4LFm0q9+X7lNOnNjGlT
	hAKUaUOkM7GYwICZc5ZZ+1RD0MVzBZpab5uBLDLHaE9luJgq4o0Y3obSFNg8=
X-Gm-Gg: ASbGnctJUApAeOU8vckxZ5bz6vI1VlnQq8XTQxsK7rlOsxx78BzzfkCDyWoxucZ447p
	AfzlB4I7C6I6YT14/lvr0m0kFt62E4m470c04kKrJR4if60dvTM8Kl434l3RO7CcjOYcZ4PuEAP
	yIt2ZxDkLun4ew0TaUOjJyQ2DJB2+7JOiKS+G3VgaeBdHlC6Sw0045pPCZjSkNPRPTTZjoSEUX1
	H83yW7vL5th3Oae+B+WQhEVEZLnpHT6p+YQjH2slLdaN/bZ9UD+ThQUJRastUzrt6bF79633DsO
	DBqkuIPls6MxniBlzZrrDdWz3O6c1lzUnX581X7Um3BFG0QQxQV6FwfFGWeTCqiSrl/40oHpBEQ
	JUlC9nQThHsbVI6rn4PtwgKKWVKB3EOdlyWRTpX9uD1nf5Yw2Xm+d5OI=
X-Received: by 2002:a05:6a21:3399:b0:34f:ec32:6a4b with SMTP id adf61e73a8af0-36150ef8195mr16032890637.32.1764089283761;
        Tue, 25 Nov 2025 08:48:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPShcOIsEaNc3uW4NqPkq5KubUsXBKSz0C3elunNAPNo63sqiGW9+gfV1cqdAWum0P0h9A5Q==
X-Received: by 2002:a05:6a21:3399:b0:34f:ec32:6a4b with SMTP id adf61e73a8af0-36150ef8195mr16032862637.32.1764089283269;
        Tue, 25 Nov 2025 08:48:03 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0d55b71sm18841191b3a.55.2025.11.25.08.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 08:48:02 -0800 (PST)
Message-ID: <9627ce3e-9744-4250-9e6b-708771343c89@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 08:48:01 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-2025-11-20
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <20251120085433.8601-3-johannes@sipsolutions.net>
 <69b2d01e-38f3-4a6a-a7e6-5d94d42fe65a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <69b2d01e-38f3-4a6a-a7e6-5d94d42fe65a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE0MCBTYWx0ZWRfX4OqJPIPWXlvf
 jirCX46mbkBAS1AF3KlcrhFxXIpN5e9Xq/tZfcdVONAKSule9+Hbe4nLrs2xRD9b8Rp91LphnFz
 DFW1gP2NYcAkrDVYgLGvbF9nT8YCvcl82ueUlKrCewVJnDEPfeD46dMKFdVtA9Vp6VfJk+OovlF
 NbG6RoI9nPAd8kPxOx9krvNTY5mnkkD6Esyw2y5oYaqSlXs9TKLZKbVdmsfAVH35CA+IsxWiEjV
 WX5qF+gr3aNw9uber8E5cV9fPx3UTpHa2E8oXnzZhoWhqxt15jkCI8nENP33XAmPypj5E18fIlZ
 yfW+5s9NXj2lKtXvsp5G5TcMfE07slOWQDrEr6Nbg==
X-Authority-Analysis: v=2.4 cv=H53WAuYi c=1 sm=1 tr=0 ts=6925ddc4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9x0bo0beFLz6AYJxxT0A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: KCvsuJ_Psr0AEX1N1zVq2DBQk5bb9v0O
X-Proofpoint-GUID: KCvsuJ_Psr0AEX1N1zVq2DBQk5bb9v0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250140

On 11/20/2025 10:05 AM, Jeff Johnson wrote:
> On 11/20/2025 12:53 AM, Johannes Berg wrote:
>> Hi,
>>
>> Looks like things are quieting down, I fear maybe _too_ quiet
>> since we only have a single fix for rtw89 scanning.
> 
> Isn't that the way it is supposed to be heading into -rc7?
> :)
> 
> BTW internally we're finalizing the ath12k-ng => ath-next merge.
> It's a non-trivial merge of around 100 patches on top of around 60 patches
> since the branch point.
> 
> Current goal is get it to you next week for the v6.19 merge window.

Update: We are still validating the merged code and hence we will not be
issuing a pull request for v6.19 merge window.

/jeff

