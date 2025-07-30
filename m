Return-Path: <netdev+bounces-210981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5230B15FD9
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 13:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E627A7299
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50023295DB2;
	Wed, 30 Jul 2025 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mx2is+/0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99089293C4E
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876632; cv=none; b=oP9msjpo0qeNaBGg6EOdPRFllUISKDM8yYhp7pJ7pcULM33BFMH8LBdVPJHbH0tIyUI1IfOPIv0vuJek2VangT7PIxV+/FumBRCCIO1oYEERGmiEmHQsVcvZBC487qrf4u3PgrO6GncOeVEoE7738DsEMpX0DrIfW/AlR9XctTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876632; c=relaxed/simple;
	bh=+eRDzekTqZXJk8PBWToJk0rTOuC+gK36unHXlpT7R3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHKwcyA+BxADFCprUxFwKaxOfMVxFP8xHLBRdXQW7jC42ig6OgTXe/6cKztoQJnWipp4YpWq/4JHrc/OGrZ7OrKaqxC1ZZWMXdv66CDV3lfkcRjLPvg/w24pqgNNhqz6UdCjcbgXzJk9ZDkjy64bsq2uRLsWArs+kdG7Y4tW1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mx2is+/0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6ooC9018856
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 11:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mIcjeDS7h8ogUXxvg4ORZjBG3hxtqpSdWr0+tiwbntc=; b=mx2is+/0fcYAIXjS
	K6AjbVbXpF6WdJTnlXVg0K1oy6kkvtcj869yStnAx3zvac/0hyyPFlQgrq346N5U
	JRkVtHpyrS8xU4HXYEWrv9qJxutLAjQpGJZi/qLiP3sFF9VmvXXgYHe5PgEtNHBs
	dws3DB49dUks3+pH2uAc/ssZxy+hdxKDV+MjPb84BgB2FoXjXeKrLzc5uiu21qDL
	cAwulemQGW7FQl5txt667736cbyWU5QNiKpUWq3hJvYfi3SBQDidee8YHINbis/q
	WKrlyGog8ZA00f2T+1ruOcORKbSfupyl0vx+LtH7pnCX/Xv3ijooEl/kf1z0dgHy
	ZNH9kw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q863tjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 11:57:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e34ba64a9fso49866285a.1
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 04:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753876628; x=1754481428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIcjeDS7h8ogUXxvg4ORZjBG3hxtqpSdWr0+tiwbntc=;
        b=o9TwxI4RR82GH6lLbFXh6zhj3KqPVUKJ91kaQNxH2zOmZ3Y87ufN4xf8Bv9G2+ks6c
         l79sl02qwN1yCS4HKC6Rw66gTq+aslG1wHmNgSwUSjtK9flv+SSLYTctiwpmgQm/rSeg
         Sm/KKwLwT4/eZ/EUprNhzCX2VxkOJD1WYkV+NalFnOIXsayxd5iLVo3LL3MSF3p7kYse
         4USAEviXtXE5GlPME9N3kiQvrFe9j/txcwKTzj2LDjjHd/e4qoOhKbU1AP4K/DD5cbEi
         RWggeiAUO4ghqXLrqLUOeWQ/Z4ioBHEA+tFxOTkksxnSFM2nTJxDaeG3hV5Rpq1GDKV8
         jIKw==
X-Forwarded-Encrypted: i=1; AJvYcCULs9zYTAKd2ZorV00asZVi/uxY6eKinNLNlauIa1tt+Jhw/qqVhvGoQm+hZxgKXJ7PmTjcOEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxtZ6DtQsk3Lyl+aDQQMgRVU4dUN9b/gQ0pZXRxnOaDkRpqwG
	xRH3I09xhtJVMfYpER5O4fJQuaVYNap+jPui1zQ4dew6B8aCkaaskr9LyhIPpjrDfAIYe6gH6o5
	D5DgpOGhp8JVbOcoInsvw/OjNOGcYQKPEl5N+rMIhKEzwOd9mgt0zMVsCXUc=
X-Gm-Gg: ASbGncuIEJYxaVz/n3XQ/Crf7xQZNap+8x0HoMowYGSiZndBxAFIpcfCMlonVJY01Mg
	JPm+6fAlSvSbb46PGEI1RfXtsfW5CphOJcUdcuUq3gxU5d5SOIsWqA7K4R7PISMczTYUOvRBp+i
	+vv9Fq3EZYx5wAPYj1+mkYADtpi8GTKW5j9roYz0AzbN6PWHxebFXzoiK5GTq3Bkr6AkQ/t51qX
	NjJx8OfKf5GFh7b4b1wjuVl0PkLO6lfnLkPjxbwXuMEqY898frzSeAzGAhnCWaH4TQMu7ftqwMk
	4mmuSFz/nj0mjyw1xcTMC8KtCu83QsM59xtqz7fCwC8o0DdtYGlBG9qOfxETIeT7e7wMl+dJRuk
	W4dbmPcA8hh9wG0Mlbg==
X-Received: by 2002:a05:620a:424a:b0:7e6:28a9:db0d with SMTP id af79cd13be357-7e66ef809d0mr222332185a.1.1753876628422;
        Wed, 30 Jul 2025 04:57:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZwDA7UZeel7Rz4M2kn1nFFS9iWCkYbP4GPLBRHIUG1gQp3Hpc/hlmL7J3fAcf+IqUnB0SfA==
X-Received: by 2002:a05:620a:424a:b0:7e6:28a9:db0d with SMTP id af79cd13be357-7e66ef809d0mr222330685a.1.1753876627944;
        Wed, 30 Jul 2025 04:57:07 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63589cab0sm728955766b.38.2025.07.30.04.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 04:57:07 -0700 (PDT)
Message-ID: <4e9ec735-1278-4475-8898-1e12ccb94909@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 13:57:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 03/14] net: ethernet: qualcomm: Add PPE driver
 for IPQ9574 SoC
To: Luo Jie <quic_luoj@quicinc.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
References: <20250626-qcom_ipq_ppe-v5-0-95bdc6b8f6ff@quicinc.com>
 <20250626-qcom_ipq_ppe-v5-3-95bdc6b8f6ff@quicinc.com>
 <4556893f-982b-435d-aed1-d661ee31f862@oss.qualcomm.com>
 <e768d295-843c-431d-b439-e2ed07de638e@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e768d295-843c-431d-b439-e2ed07de638e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4NSBTYWx0ZWRfX7SQjnl50X3Rr
 DSTw4FSFRUIfYuN6Ava5xpxrZnyLWczu4USvPtdkoEsJ9+gkeYYV+++pdb5dc9Nr5eRXPhPaQOw
 9x3qyMaql/TQin54T6WIvKL1cN0KvAs25RFbUlouEtb50obk9yuYNr29/UIFUrVKggM6iDPGIou
 2T42Jrm+6Yx56x381UCrXOzlv3sTOztGVc+pqYAcoB9DgrioBTF2g9XwEYcqnTWfadvvRTA739w
 S8UkPCW4rdGXBpB5P3vkpCmbUCqByXDcvvSFcVoHy9cw1zFTbIU3h576Y4b7IfgQWYsZnW1blc7
 ll4eERfvI9IJL0ghFmCBoI/OFOYBpsVb+PZUFWaeIwMDZDaj7fOnZnzpOvJrxtvY+LLKtcqHR5S
 Rik5W0TGLKNxVXvrChk19Jm6MFYkhCdjfkRoIyHCwCkxlOsdMGB4ge0IhYtI4Mp4YfL09k3X
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688a0895 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=hn1M32U-3FIS6ASJhmIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: yDPsbgFJ6G6vloJz68ehsQ6AWj0FWq2a
X-Proofpoint-GUID: yDPsbgFJ6G6vloJz68ehsQ6AWj0FWq2a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300085

On 7/1/25 2:24 PM, Luo Jie wrote:
> 
> 
> On 6/28/2025 12:21 AM, Konrad Dybcio wrote:
>> On 6/26/25 4:31 PM, Luo Jie wrote:
>>> The PPE (Packet Process Engine) hardware block is available on Qualcomm
>>> IPQ SoC that support PPE architecture, such as IPQ9574.
>>>
>>> The PPE in IPQ9574 includes six integrated ethernet MAC for 6 PPE ports,
>>> buffer management, queue management and scheduler functions. The MACs
>>> can connect with the external PHY or switch devices using the UNIPHY PCS
>>> block available in the SoC.
>>>
>>> The PPE also includes various packet processing offload capabilities
>>> such as L3 routing and L2 bridging, VLAN and tunnel processing offload.
>>> It also includes Ethernet DMA function for transferring packets between
>>> ARM cores and PPE ethernet ports.
>>>
>>> This patch adds the base source files and Makefiles for the PPE driver
>>> such as platform driver registration, clock initialization, and PPE
>>> reset routines.
>>>
>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>> ---
>>
>> [...]
>>
>>> +static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)
>>> +{
>>> +    unsigned long ppe_rate = ppe_dev->clk_rate;
>>> +    struct device *dev = ppe_dev->dev;
>>> +    struct reset_control *rstc;
>>> +    struct clk_bulk_data *clks;
>>> +    struct clk *clk;
>>> +    int ret, i;
>>> +
>>> +    for (i = 0; i < ppe_dev->num_icc_paths; i++) {
>>> +        ppe_dev->icc_paths[i].name = ppe_icc_data[i].name;
>>> +        ppe_dev->icc_paths[i].avg_bw = ppe_icc_data[i].avg_bw ? :
>>> +                           Bps_to_icc(ppe_rate);
>>> +        ppe_dev->icc_paths[i].peak_bw = ppe_icc_data[i].peak_bw ? :
>>> +                        Bps_to_icc(ppe_rate);
>>> +    }
>>
>> Can you not just set ppe_dev->icc_paths to ppe_icc_data?
>>
>> Konrad
> 
> The `avg_bw` and `peak_bw` for two of the PPE ICC clocks ('ppe' and
> 'ppe_cfg') vary across different SoCs and they need to be read from
> platform data. They are not pre-defined in `ppe_icc_data` array.
> Therefore, we use this format to assign `icc_paths`, allowing us to
> accommodate cases where `avg_bw` and `peak_bw` are not predefined.
> Hope this is fine. Thanks.

You're currently hardcoding the clock rate, which one of the comments
suggests is where the bw values come from. Is there a formula that we
could calculate the necessary bandwidth based on?

We could then clk_get_rate() and do it dynamically

Konrad

