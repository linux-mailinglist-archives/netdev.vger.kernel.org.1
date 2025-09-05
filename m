Return-Path: <netdev+bounces-220334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC99B45734
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8569F4874A2
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4C134A334;
	Fri,  5 Sep 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+az5kPI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFF92D595B
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073971; cv=none; b=BwBGUGslyN1xA4P2/1BJ8jSczCzwWwaeVuxm0RvhnHlzaHjKaXARc3gtbdwPsfSLiRRehF58fo3/P0ufitAMBgcSDv2PEEe+D2UrVb1KGaRCLWUbsiSI2GBP+0VR55tcYJ628yAJAz2t530WBdddAn89H+/CdX8Y/bvVNUymd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073971; c=relaxed/simple;
	bh=ldlxiteVjgDeP8xEo3N2AmqNAbePsfuqyTzaH+6MAcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+a/+FYfh/84svQkiXOZ4l8nxMQBf17L39k8es5YoUD9tUn2UVNIepr5PYxLy9HPzlsje33LvnyeOxTn2PWku7f9xP6vaqOyrlXlI5GIVhPFGkc/p8o68XJ3yzk9CHhj0m75GH/TjaXkCK9XRRLM9w6CS42mno16XvnBgKHxWjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+az5kPI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856vV4C007616
	for <netdev@vger.kernel.org>; Fri, 5 Sep 2025 12:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dIUWCEcqZtXBeXsUMytwaz17zqmex3UoROOIhHg+zWE=; b=g+az5kPI9X9pasaF
	y1g7Irqn9G/L3wLDcrG63AV1iuDyN+JhWgRrtSfkhZiT2mlDD0PTQ6TQxbFi7DKD
	n5xCwc6vd5QRrdgaX3bcYJzUc0+lNd98YxzUQKkHDzTSYxvJflEAeTE7WBMRb/nq
	FOwMtQTPsxCBQCohxjSlWQa7R4qSbJdRRpu+Y+IYBt1+KhQvu8vLD5T5XN0r2ckJ
	QfirlxHrePqRSDKVfzhFh04+XPymQE9jpDyOKg6T2NpbCKDkRv1jPmURDb7AdW9z
	YsPl/d8Ltuhv/xVl6XPf5886DHagCrHUsam//vdc7g5sGkhoPE3mYgWnOhsBzMZU
	XF6tsg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura92x50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 12:06:08 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-71f2e7244c7so779886d6.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 05:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073968; x=1757678768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIUWCEcqZtXBeXsUMytwaz17zqmex3UoROOIhHg+zWE=;
        b=c4h/LpazoNwIUTsOX1AJ2ANJ0qXNx+OUFl6thvT/a74qs/og5PDPUukb+Ri43nJNWd
         XoKMHeywIrzyDiK1UDvghqe6jrCYV96t01/z2V4oQzFjxpAqqk+SMUU2rQaEYvYjQd4U
         Lftj7HyeyYHI/gVQfStJco6r+tEdkz6DQH8K0sEd/xtiKI3+tHdSXgG71HK61gPoiJoE
         DylXKeceksaVk5esqGjkUwQJbkwgmOyJome0dHSMmcnsBg7M4fxVb01zcJ6UpGO42E9+
         3gyvFB/sHNU0GHM9SUq9ndrmMbNLQvV8PRQLwyrQ9DP3gpzynyHUB5Pt2fQmqCA76PNF
         Q17Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtuNZMDYNj607PlwYggaiQuM0Ylo6gblBz6pnTVRIt7/2/ZYiBVjAjeIuApNuuMdnUtZgwO18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQUHbYyFi78ryBXJ0lpO8gk26KBjaKLZG1yBV6Vjo64ZsJnP7
	fPeGu+aK/ob9QaAl1mkty1HPJgYYIdc8/JsApGn4/GA7laFKOialAUmIIoW4L83TbwZkFAlj4dO
	cC8dL+T0YOcFcBQU8j+SYHSBbkgqZ0MY5JW3g/97jsLvjQpsN0B+wt4lAoHE=
X-Gm-Gg: ASbGncvLRPhNQ2ws7IJYqveBaiZ6dIhRfjVe5fGy9/rZHRCPCmP9ptpFtEUponk6ORf
	GEJ1xy4iuNXgBW9/uI/FFZhlzUniOQJEE4MKg5239Kmo66eYcX1JKOBRaeZw/7qKfEQ9mzJptik
	5byVUTN8mTAPP0t6vc5HD1FzLU6qfaA7EOUoUk/pLhbkzgLt+x+x2nqL4yPO9VV+swTxrS1Qf8K
	979C34nT4PTuCbU5MnG1KPiUETKh7i6H5Q3EC4zM+rcIcmhU48uYw/oxfwMSXytOW/VkMLICjra
	vHSLbFDLgG4goIJnls7e03Uzv+724Nr8JDQtod03X6JPOviJCKbIgEzgcCITEbbLlWKiZCtNRlZ
	NEW2nmL7e9BNULye+dhBN3w==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr59876741cf.2.1757073967321;
        Fri, 05 Sep 2025 05:06:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbClop9hg8atD+aWFohh2CZ/t3jFlq5ci05mjat29SqiFLYOqxeot/a8+aYFeKlmRNuQXfyQ==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr59874841cf.2.1757073966067;
        Fri, 05 Sep 2025 05:06:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b045e576edbsm785026566b.75.2025.09.05.05.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:06:05 -0700 (PDT)
Message-ID: <b7d1985f-3c3f-4776-9990-42a343661c51@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:06:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-4-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-4-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JNGIGhyKw1nUO3mZupLQ1OHJP0Op4hBO
X-Proofpoint-GUID: JNGIGhyKw1nUO3mZupLQ1OHJP0Op4hBO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX07zLceayD4pE
 b0rniCpYCBXgMfss8Vz2U6yYM4CwPpq9shW7oai2De6EdyBlngYlssf7+ZiWD+ejQX/xYriD9nr
 dROrvQs+Y9PROHK590DT5xoAByR7nBpwePM8as2OXQCKPxw8h9znHKCN92lgIOHAIinpJPnHAG7
 pwLQvDDSBMUNrpWMXP22MyuEVSamU0YHnRFHhJxmoCa3QFG348JKhNIeR+M1P1Qcg+8/lFPIqkQ
 bgDHxs1kJNky+KKTyYUKBgkWZZ1MCu42wm1llD0ixWJyfCV0n+ODkroA5D5vpQkE2qpbXI2+//S
 WtBaSqxXkTBwmcxhz2NzxE7w9svVcDeJMX2nSxZnw4U3wB7j2teNIPemYzn4q2T4ReCKTQAisuE
 9iFEKFCs
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68bad230 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=TqwOrElcE3fYHNaCTFUA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> 
> Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> GPIO lines for extended I/O functionality.
> 
> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

