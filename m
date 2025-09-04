Return-Path: <netdev+bounces-220092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F56B4471C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AC51C86FBA
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64C7280014;
	Thu,  4 Sep 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GStfmUu1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD5277C87
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757016993; cv=none; b=ST4uUOV0r0HhhnV9+ZhVxHtRGSrc6IkmqSdzTKpzxyWQKpvs7WnTbOhsU7GYQ1Zff++DjQ2IODU8elJ/plqElk8NeqEgyI6+5Xk1t0Pkwk5rEwxufKaMtxsUD+34Wx1UGSR3uSp7t1YoaQfCm19j+ugT7UahmlOtrsfscpzRjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757016993; c=relaxed/simple;
	bh=wsHd20AsJfMa6Wx3AXg6obGKYV4i2kU1t40Rvld7cXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPmXARvcF1/pYqfOYfG5q6SpCBwMYw4O0Ssm84i3XfjVpyFseMBieqZRN5d003oqsOqf68sej/r3cw+IWqojO7XkLqrWLG17GpzhpVxb96hL/C49l5WWZlftlXsM96BwSTyQ/fIGm1ksw8UanW3Yb/8wphrCKVgvRiYH4UIAtB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GStfmUu1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584HeMc8013631
	for <netdev@vger.kernel.org>; Thu, 4 Sep 2025 20:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xOnQOwS+L47eJqdD2xfoBQRC
	L3cjvg9aVuPwvzZvFpc=; b=GStfmUu1CrqwzWdKY7Agp7+Uzmd0qtGHDw4NUVYC
	MVcWrDzMS6HJONHQZEbkOc1UB5oXYafzqviDkUY7K5m+wkbOElxM/kxi/zUvBlRn
	CKQl57xbcP5wYydUNyv2JJjp+T7DtL07vAMQV4mmghTYfz/avXx2loISPf8hxJwx
	cJcu5dbQpKUP/yyFVILniN/BfFTywgX2tTwajQ6pdWL8GOcyPqti5EPyvlqgxtOt
	4nnx4XncqRZF27YeNlD4816PWjUHS8MVkYAhhCJk+KvOth6nGuGHLP0mRztd0xk+
	+RXZ4T2R8xy2eyxaniRNefn3uvYgkzSGBVPALAcurDFXDQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wycqhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 20:16:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b34c87dad0so28842031cf.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 13:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757016989; x=1757621789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOnQOwS+L47eJqdD2xfoBQRCL3cjvg9aVuPwvzZvFpc=;
        b=v0YvNZYKm564st6+M52miU4o6wrefdvwd8phc74Jc5hhyzeW+8J6ldOnE45Vv/BXCV
         mQ7JGJqLAE48HIjAbaoUj3PlopREikgh+SGyu4tkeY51DqAG34xU15T7agrIuPYZ/vdF
         XXPq5cCPXWadb7LJCAfzLQmPWlpVmWqOn95y+ZP+8fdFAtYtyMAxc/meNQSOlk8P2oIQ
         KHSWFvstwgRufVGD1r7bDqyljppllBsoPI7yEqWBuYx3iM6IvPaYWkI+akYXyQTrNlep
         C6VKssUSXDoVEN3ffJ8QlxOZ6Zp52gb5v60a8pkfdQEyFjnYbJd8sLkImbRVYyuS+s8d
         h5lw==
X-Forwarded-Encrypted: i=1; AJvYcCXjUOIPCsIlQwuP//RIkW+Gq19EIVAgKj4hA3tXRNvS8NLsnmje9jh+IDfDPdpkxUJ885j9t/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6f3qF4vl2XOZEuORVJTMPI0p1xTrUBWSdtcnomyk57/f+XHhw
	ReqlJs1hJnnKtG11tciKgqmXpge7vsOH7WpL+YJYCUhxzxFZZPp4yj6m25mp53P5xi1nMXgzuCO
	3wWJrFemaql1WW3XWsCdIHn5jGzo+NsEtHlVfJVO2CfBCvu2FQjoVplgIEgE=
X-Gm-Gg: ASbGncuHzZKj2uxVREaLIh1jNvy/OAPunqlAtegkWFyS4l5IzDqdZ6w6h1cMXeIASf+
	9pE/rO9jqNOV3tSyLX3HLIV0HIyhccMyywc13NVhzURAOu43KpNoj3X+l3AR/IC8g4Z2f/LcTIo
	M+O2RZHM1W0FivCX61ri+kawP2mN0GBj+LSwg5fQ1qtbpWpsVol4fzJgmYDeDZI4ZOzitFo0dNa
	2QVkC8MOIb9gsoVE2uufS8ROjV9AcAXfn8zLO0v7cWwTMfY+/fPmfXHoA34MjEEzbyRFNUEjd/T
	4eXeMHSgNBszBsOef9SoerZOxUfItNRJjJPF7wPMEvx0O+l4lnskt52u3fuxN2okkFHeM951kP/
	1PBMiYep9LUGL6EV+BtoM7wuQlWsc42l8ke4ePv5vMEIT1ozL5A6/
X-Received: by 2002:ad4:5f06:0:b0:729:d2cc:9443 with SMTP id 6a1803df08f44-729d2cc947cmr38070626d6.39.1757016988741;
        Thu, 04 Sep 2025 13:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6ZBkThlXqQk+QXlZrohvU7MoDDoi4EYRmpkHcRkJ3x4qqQmgMU68HV5l9Kryo0ZsRp4157A==
X-Received: by 2002:ad4:5f06:0:b0:729:d2cc:9443 with SMTP id 6a1803df08f44-729d2cc947cmr38070086d6.39.1757016988093;
        Thu, 04 Sep 2025 13:16:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4e2e3sm1393356e87.147.2025.09.04.13.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:16:27 -0700 (PDT)
Date: Thu, 4 Sep 2025 23:16:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 05/14] dt-bindings: eeprom: at24: Add compatible for
 Giantec GT24C256C
Message-ID: <zedyu77se67b3s4zmuqcx2zslaasemllmtr6ua3k2p53cdspcc@ikpf7np6ugfy>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
 <qya226icirpzue4k2nh6rwcdoalipdtvrxw6esdz4wdyzwhcur@c2bmdwnekmlv>
 <aLnqZktduc/aT05R@hu-wasimn-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLnqZktduc/aT05R@hu-wasimn-hyd.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b9f39e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=q5DPIbX8LfODaG0eNlsA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: -rm1bqo67PxBFHsPAQtlYbUZXvASsesa
X-Proofpoint-ORIG-GUID: -rm1bqo67PxBFHsPAQtlYbUZXvASsesa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX2F9rT/+GyOPU
 rIZqUQ2FA+jd4XOqsEfHuC3mL17vlVaM0HOgJSbk8JAWySAjje30LmkqUgUEKTyA+zqSFurzeuR
 sCWkWgCYpFqEZP7Ou2yFztz0kAW2paxRObAOLV1Lp4ObeC2wZg+RjWTrBzGOQ/d9cV95Bq9C+6A
 o52Ld0ABucU8H11mCEJgYuEDTKnkuzp7Q4ECOEDppcfsdnAd/SKaM316FHz4z+TNHFm52UkvPmL
 cO3t8tfBk8HQVuqPdLAbW1Aahd+y9gn55pVFvTM7ifSNstbixRpz4w/mWDhLeEoh9ZgF4irzRLZ
 ZZWMfRXMrpzk9vI5Uua+QgVLDcC4inj1wldASCiafCeDWOLHEmTuKkjIIi1ixODcWRb8537vSyB
 uSdJDuUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On Fri, Sep 05, 2025 at 01:07:10AM +0530, Wasim Nazir wrote:
> On Thu, Sep 04, 2025 at 07:43:27PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Sep 04, 2025 at 10:09:01PM +0530, Wasim Nazir wrote:
> > > Add the compatible for 256Kb EEPROM from Giantec.
> > 
> > Why? Don't describe the change, describe the reason for the change.
> > 
> 
> Let me know if this properly describe the reason:
> 
> ---
> dt-bindings: eeprom: at24: Add compatible for Giantec GT24C256C
> 
> The gt24c256c is another 24c256 compatible EEPROM, and does not
> follow the generic name matching, so add a separate compatible for it.
> This ensures accurate device-tree representation and enables proper
> kernel support for systems using this part.

LGTM

> ---
> 
> > > 
> > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > ---
> > >  Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > > index 0ac68646c077..50af7ccf6e21 100644
> > > --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> > > +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > > @@ -143,6 +143,7 @@ properties:
> > >            - const: atmel,24c128
> > >        - items:
> > >            - enum:
> > > +              - giantec,gt24c256c
> > >                - puya,p24c256c
> > >            - const: atmel,24c256
> > >        - items:
> > > 
> > > -- 
> > > 2.51.0
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry
> 
> -- 
> Regards,
> Wasim

-- 
With best wishes
Dmitry

