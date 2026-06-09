Return-Path: <netdev+bounces-297051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r583EuUVKGq+9gIAu9opvQ
	(envelope-from <netdev+bounces-297051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:32:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD9066095E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:32:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NU83Q0qa;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=gua2nliO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297051-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297051-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 128C1305707C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46146383983;
	Tue,  9 Jun 2026 13:28:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA4275870
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 13:28:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011703; cv=none; b=eLu9VlpdyIRjvoNtLARW+/txx/SwmYvfMnTQIQCRYFbw3c1dqxC9jaRv4Dfxg9pca73mNWgPpjB5UeYO6sdR9LFLSOVD/Y+fxIgNDtPZQX5jvPZxInqTjMHS1fFKTnQuHzV/aL7ivm14eya4VgiCwMtAWgrVU3W8TeUb6ReYGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011703; c=relaxed/simple;
	bh=lh7VcJd5s9opK+qhKTvgPwy9qXS6LiR7Bvx1T8En7g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0BtD9A59+bniBabWsmmJXbYQImrqvEnGs13dKIc3kiLNCns5OjHdhz2gFu65oS2ZVDm9TXJKBj8a/BSaHjXMdnB15aEVUP30M/WLEU1BWBlfdab+zxHTMildkNhavMwDbAnL29lGVGktBLiIy6ux4dg22kiqe/tk2gDaAeeBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NU83Q0qa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gua2nliO; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClQuV2286789
	for <netdev@vger.kernel.org>; Tue, 9 Jun 2026 13:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PK8zmUvBTXUruM9Ga4dY+eCgp8SW/s+tzWaRTY5T1co=; b=NU83Q0qaGMsKOQ8y
	vjR3I6Hqytny9QBqb1i+qplpOH1MG8n2qafEW/cJBI8+O+Hy2MMuMlpnwD0c48oc
	FEYRpJfMz1ZoxRjhglZdSr243khOfc7Xj9J+kPh20u+VjdOEOGLNz+52sqJRN3Mg
	pLYhTA8wD2GUPA85QjD32TDu0jTyzen+sYgGqCtvQbhS6hUb5WZLDN56sNe4oIv5
	SGpx7juakN0kJSuapPq7ovhUrX9y+o6NdCcx51vJy2jqGlwWDFaV+UODsr4ZeEEg
	jibqbcRaqlUFrKD31i5zoMx8LcretX3HJfQV5I+6+oFcGZYY4ZdxCkj8t0yXBi3O
	SnrTFQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3js27w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 13:28:20 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6cfe512ea6bso226794137.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781011700; x=1781616500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PK8zmUvBTXUruM9Ga4dY+eCgp8SW/s+tzWaRTY5T1co=;
        b=gua2nliOmLV9232rI28au58p9+ELWLmZxBN+EwIO6WRCB5LM1kZOol4JUa5IzpXlfI
         /hKxkgl20Ig2kZ4aKdTgy3qeWrO4d8pWN9c0wH5n5DhmkTeUiiXelwoCkFDj8XQIuV8r
         iPvf/s7He2DdBBuHtwJyamHEZHywnfMqTmypWHm+ZVbgzVGznU+TXvC6d49orn6F30SG
         BUqAYIkRQITqt28sgIPyw57EMpuyw5+wOx2MFgGpobXJegvoPTK8C+qJYwspWNxGQpVe
         ROASZcYTP6GD/4sGGTgir5Ws7xnaPDXNB/sO/56g1H1UZvQUGDLxTO8QE844GCDYdsNv
         +Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011700; x=1781616500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PK8zmUvBTXUruM9Ga4dY+eCgp8SW/s+tzWaRTY5T1co=;
        b=JKodg2xYV/Xx860Zkm3D3Zvn0mqB1vBdj2KAMAetESogKcZdUSj2R2cBTh4v9bNXNq
         9csY69KR5Iwiy/JTdLRzEZv7VObipE+hr++envbJPqYIleHk3QRKyPR+zqL1K9lgzjqA
         DBzSjUfuAc8n1LB9tsiLcI7K09/jSoV8LzK8pUhny7jnEp/9CrNAYdu4TIAKU3OGNpCi
         rjkpQO3d4Cxexq+sMNvFHi2glh3+QgEGX4lnVZ8jLWlXhCQI6iTQ5Gu3sujNtHHt3jYh
         0P+uclaDaCDP1BS5WfQKe4IClMWLPIavQ1hOV1dCHtOcG7gEGLbH4ehUAga8WrYZHsN8
         GzZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wraRJiPbr3hxt66q3tUZU6Ke0rR3VB3MwqFNPVNqj4oPH+vl3K1XYXpeaxnJzxGD63QqACZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuXOwuwgaHjscA30SvY6epj4ro/J6riij/o4YfsR5bC6arg2qM
	b7WStQxTOnWtBNYRWcWoixKIkqXEZfLlfb3Ib1GcvxAg7Hu0YrDdVP82+ijnzn4meCJhYOLEq/L
	CU7cBf8Sp9dV65+cq4TBZfwPdah9GwdjzW1gpJW54rAwAkXZq1o8ojdCMfuo=
X-Gm-Gg: Acq92OFzet91SzDAec6K9hIgkxgIXZViawfugx2yRhrVrekXH/ey0OWU7zTV+dkcxG7
	sMPkhbFsDzHtklPjS4zyonSBsiRNvLZJ+3Nz2YftkKr8mwmQXG7UMCOt0xrBMqiAKQ8TyBg65o+
	OgrBipLi+eF0OWSTr0PnwxLEMKzTUwDPfNclupJdD+F/kjsmj4QbqzKPQ9lQN0nSw+yd8Mn87GM
	WajNuwp7ZUwHGXjbnngW1qLx/0dYa2+KacBYH7OvxKcQrdfLcNSYf0tH12CxrDTEpiAHRr36P1/
	gdY65RZ+4eNDw/HehwuqBmYtlWsRhnqpNfTHcOGF7r4JHqeY0LdjKabJPcIiaVUMY2R4pLmbI4S
	sYwkGDnShl+pGpRraqkojgbvBb7hgfTcGBrYNHLT3FC42ilRwdUgmi2hn
X-Received: by 2002:a05:6102:41a9:b0:62f:46c:40bb with SMTP id ada2fe7eead31-71925fa9013mr444767137.5.1781011699871;
        Tue, 09 Jun 2026 06:28:19 -0700 (PDT)
X-Received: by 2002:a05:6102:41a9:b0:62f:46c:40bb with SMTP id ada2fe7eead31-71925fa9013mr444753137.5.1781011699394;
        Tue, 09 Jun 2026 06:28:19 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307ce3sm1038231866b.43.2026.06.09.06.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:28:18 -0700 (PDT)
Message-ID: <f6fc66d2-b40c-48a3-9dc9-bae849353e74@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 15:28:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: Add gp_mn pin state for GP M/N
 clock output
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org
References: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
 <20260602-pdm_clk_gp_mnd_v1-v1-4-1522662b6c53@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260602-pdm_clk_gp_mnd_v1-v1-4-1522662b6c53@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wM2jYqYUbBD9f57RkDsOdoC2gpDjD2j3
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a2814f4 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=a9V9PMWcc79cobRO0OcA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyOCBTYWx0ZWRfX5I1bTWFUEIN4
 5C6exm25rqB5cDO7LYVNsJzM64IXNBRVc5m1jjp3jkdP92OQ+JMTAKtDW32n+ZcNEQF0k9pR3KS
 jqj/VTYI1hIoTx5biQBXKQbIeUPvvLgi+r3m0gaoRfKBo6ugtBBX74woPq5KKNtzbAQeHGw91fS
 oOBf379UjiTFMCbB2Dz0y0qqh3nvllDPUWt9dkrWbo9y9+Nm/3h103UAr1H1RJ9kv7XVM+s74nl
 OPQFm+VyOrkvrfRa0u3x0oAjmnxtS68G/rGNKGYvlKaZYksfYmGu/jvr7ZZlbTo5SPkPYwii6Mh
 BKiCK4qIImh1P/4G6M79I+JnQ9Y35aI3Jk62Kq+f3UA1LXd4i8JT4J8sh/htdKtaB8J9hJ4DIy0
 R5I8mC/orJF5QIqsnYnJfDK7Ne/fy6qLVmN4oZqtIJRRCcepr4IAOyv1lixt3sW2BmSHMP9suPX
 m9j66VUXRzvTXZ1wDyQ==
X-Proofpoint-ORIG-GUID: wM2jYqYUbBD9f57RkDsOdoC2gpDjD2j3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090128
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297051-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,baylibre.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:taniya.das@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linusw@kernel.org,m:richardcochran@gmail.com,m:konradybcio@kernel.org,m:ajit.pandey@oss.qualcomm.com,m:imran.shaik@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDD9066095E

On 6/2/26 5:21 PM, Taniya Das wrote:
> Add pinctrl states for the GP M/N divider clock output pin across
> multiple Qualcomm SoCs:
> 
>   wire it to the GP M/N clock controller node via pinctrl-0.
> - kodiak (sa8775p): Add gp_mn_active state on gpio35 (gp_mn function).
> - lemans (sa8775p): Add gp_mn_active state on gpio35 (gp_mn function).
> - monaco (qcs8300): Add gp_mn_active state on gpio32 (gp_mn function).
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Please squash the pinctrl addition and clock controller node addition
patches together (single logical change), and separate them per-platform

Konrad

