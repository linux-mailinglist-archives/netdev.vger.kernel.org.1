Return-Path: <netdev+bounces-264945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMglEjxSq2n3cAEAu9opvQ
	(envelope-from <netdev+bounces-264945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:16:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AFC228448
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E64BB303742A
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068334C14C;
	Fri,  6 Mar 2026 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SfSjst4G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jF49rd7q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C71234F462
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835379; cv=none; b=LeJbs9hUifzqI7M0lgFRzzf1NP9p7IGh5ADj01UfnTlBfOpq/099hKwCFx1DyLRjxJj686yEcfDcsmRLfuv/MJTIDecnUgwfwlfc12cYM7my1hGNuRcTeVEqCn7iryUpINQ0J/PliUJVOLU1pmBucNFz05SvHwkqUI2Uuui89hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835379; c=relaxed/simple;
	bh=ozp5w2u9J7nebog4KwPAIQaw9Q3GF+gWT8k1KRnFxn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiuE7HltefNkHnFchEm6NQAYYsh9Xrog0adCyqaaaT1jaYFt2ewESa2D3IY7JoXEOY8I6wTJ0o69X6Uu5ravCsjw0CIQ9O8IVLq8ahCZOJXBeSpjwObJIESNuQDgIJix9dgDbyUN35DuVFVw3tiUkfRhUWl7x+9TLOs1FPo64hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SfSjst4G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jF49rd7q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626KWYCe3193036
	for <netdev@vger.kernel.org>; Fri, 6 Mar 2026 22:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i8xe+5eaNei8a3fpTPt0x8f/YBdZqjrjrkxNfSV82tg=; b=SfSjst4GB8hij3Ya
	xumyToC4COQ43yIm2aQSarzCnpo0ypGv1UWid+nyf1aAiMF0Mu+lt8Jlnh6wZEzC
	z4nAMHqTQKPfGzFi4Ldw17z950DNAf03OiMcQDe7wwE/yO+WD8U5uSjNlAz+xe+E
	DI126rXVobs/QALLHK6ZUrp94YQkgg6+6YV5FIgosf83knfO3y+5DeVGfbKpw505
	0N1VQxl+B1ZgE5cgBtv5aVouUiY6VafcBs3QVFZGcpXdHBxf4sdQkDacB7oeO5Xn
	213NzZUpLBiKTugTF1ByolEGCHvJCbJb5CxMg1cmT9VYtIEhF2oy8+NVVw03lLlg
	Bzz1rw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cr2utrywr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:16:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so958403eec.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 14:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772835376; x=1773440176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8xe+5eaNei8a3fpTPt0x8f/YBdZqjrjrkxNfSV82tg=;
        b=jF49rd7q2ZFEmPlzUtEXVMtsVd71tthuDah3VBfRdNj5dkOEUXgcBzUmEIHUgZViHV
         uSx2oDYIHD0C4uwTWJ2eu1Urmkw6GWt9dxclmVFoPMvzEIW0vjz1CQx2x7gbtv+bxz8T
         ajCgPBNmypPdmEaxp9eaWxrugLJc0qkixnsbSSl12wov94kNZP30uSmINFyhi5zJ1Aj0
         MzPLwiPk8uBD9/e7lrM7s61QBufpsrXxoQ6HX8qsoVe9isBuFGhcZGbMmqabduaS1C2Q
         nZkpIg5wIlmrgQt19HujdEHnAhXGKae0XGtd4VadDY+Yv6X8ykmN0rUkSwDFnNfeov1n
         HyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835376; x=1773440176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8xe+5eaNei8a3fpTPt0x8f/YBdZqjrjrkxNfSV82tg=;
        b=eeTsw0D26O4F/lUg2owIK54kNEneAkKSAtiduiOzZJmdVYycLkRYC0rEOgyi9OEXYF
         uE/6EIiScULN23jV6VGGwdpBBsMOA3t9UQ+HhojmrJyM0c33O3FVXoP2yi7uimbWEWK4
         yUvwlj1ygYuN+a4M+0qS5z27fY6/kMMbMIeJoJ9xDuIK+D3IcvUFP/qhkpNytOFhXq1G
         UgHHJWrSO3gxohPtKkmVXTpkmBkzpMSf4ZtvQ0/plWgp1mkp847itUnF1fLF9igBneA7
         0N+me5noURKTT7YK24bUFciJ+Si8wx4einNz2Vso4rJtX4gdXi5ZCVd16pVoIS9ZC6kS
         dOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5PwTzJts+bl5tGz+Z28ZiF65Exx2CVraqq27dntEMVcmqPtnP6MyGzETXepUrj8mf4lLeAos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpFt8fVrDpvHzDczNyU4gimSZaaIv+SvHjFzWzv/eZtyxODL5
	zQwQ4L/bfrRc33xBeLlF9uuz9Jy+b1EyBoPmAs7xpsEZDdsXSNO7KVapivKuvetnRacIavEeMhO
	N15JFXfHQgtrDLCRS9i8VnQHPdHfLupdUp9KMkkSu701SfUQ4zu/M7NwUpIk=
X-Gm-Gg: ATEYQzySepkw9imsTM715olgNFKoqFb2U76GjXLV3sK5FWFUXKJuu7JDEnBJ7hpOZcL
	THSQkpdO6IP3pkgAWOljiKg87R03JIIdKSQ7W3DkeAtkSqgNqG33LiRnUWm8NddqVs8p1MMnVsU
	g/ebL/7kt2+32a+gl+QwZ/Q8+GJfW8Fx4NwSeDkkQtSFPi9szF08LjZrJANwnCc8/jfvDq6DCiQ
	77BUL+kBJU9Yx348tbE/fRhJ07bRVG2+Ko4cSs/Sp5L1MqmOvAJM7K5xFqoSLvmb4ecKVLUE4Jl
	WKnjgYzV/OfJnE4rnwPq7aD3i+FJGuWZcVyGa55PgEbBo8JrXffjZzOAGh9mxv+NSg3mZw50/ri
	rATQh/fkdm7OKWxcNgUSBngKiRZ/5SaWbh8L2Hia/vNVFrHGn+PApMqCCV+uuNSWDYjNqQXKZrn
	7KgiJy
X-Received: by 2002:a05:7300:641d:b0:2be:1b95:2400 with SMTP id 5a478bee46e88-2be4e0655c8mr1446291eec.23.1772835375699;
        Fri, 06 Mar 2026 14:16:15 -0800 (PST)
X-Received: by 2002:a05:7300:641d:b0:2be:1b95:2400 with SMTP id 5a478bee46e88-2be4e0655c8mr1446255eec.23.1772835375083;
        Fri, 06 Mar 2026 14:16:15 -0800 (PST)
Received: from [10.134.65.116] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f94823esm2301765eec.20.2026.03.06.14.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:16:14 -0800 (PST)
Message-ID: <f825ae05-6285-4d10-9d66-578fb1221495@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 14:16:13 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
        sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
 <e0a86461-c136-4371-99cf-c0b0d31443a3@oss.qualcomm.com>
 <13091f47-938d-43fb-a8c0-4b081818b557@oss.qualcomm.com>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <13091f47-938d-43fb-a8c0-4b081818b557@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=N8ok1m9B c=1 sm=1 tr=0 ts=69ab5230 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Js8INul6CuAu6eKS1T4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIwOSBTYWx0ZWRfXxyYqw1RS+k2Z
 fYAbeBNCiXPyG5GYtA3W28Gaqq/38FC4Pyfns6c0WExoMNM4VrwqAvFijL7UAfwoRnfZTgezAtg
 05wFAi888mihFXNdCoZihgA72FCKWX+UNnmqfwI1WTJ5LspFLk+38a0ej2NoXxKHjrPI1nMVsDn
 K9GGq3JpVpDgm+deypAdlFqa8RiAZZ8aE6/xK8jrMfOLUZyJedtr5rH0a89uJ82eZsySW133g7r
 GI9bxeFF6Nx5Y56qEvq6ePlOH3gxKBdT1OjE15qqZSL7mXNcYObtY7un6eFjOgjVdEb+oXRIxKX
 mZsmL3jSQHo47wKvDO56whtw0nQHN3a6qgyYupo1vJNSb/3BurFTYtO6Cb+5e03Y1PfzHR4Lswi
 vDnzd1WsLU/LCf++J8WtVCD65bhqwcCiQt4guEz3ttDuarQdvMn11Rc7lmjGCacem6xbPKcMJpy
 ZjBeqn54zru+gu15jog==
X-Proofpoint-GUID: fna0lSDyRLmMhCSW_gwT4G6fz0lF57lb
X-Proofpoint-ORIG-GUID: fna0lSDyRLmMhCSW_gwT4G6fz0lF57lb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603060209
X-Rspamd-Queue-Id: A3AFC228448
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-264945-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trilokkumar.soni@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/6/2026 2:00 PM, Jeff Johnson wrote:
> On 3/6/2026 11:47 AM, Trilok Soni wrote:
>> On 3/6/2026 2:50 AM, Sumit Garg wrote:
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_AUTHOR("Sumit Garg <sumit.garg@oss.qualcomm.com>");
>>
>> What is the convention for Qualcomm authored drivers? In some drivers
>> I find that Qualcomm doesn't add MODULE_AUTHOR. Can Qualcomm community
>> clarify it here. I prefer consistency here for the Qualcomm submissions. 
> 
> WLAN team was told to not have MODULE_AUTHOR(), so ath10k was the last WLAN
> driver that had a MODULE_AUTHOR() -- ath11k and ath12k do not have one.
> 
> And in reality it is very rare for a given module, over time, to only have a
> single author. The git history contains the real authorship. So just for that
> reason I'd drop it.

I agree and that is the same guideline I follow for the drivers we write
downstream. I just want to make sure that we discuss it here. We may not be able
to find one single solution, but I prefer to get consistency for Qualcomm
submissions. 

---Trilok Soni

