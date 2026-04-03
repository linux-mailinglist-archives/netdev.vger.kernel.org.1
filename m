Return-Path: <netdev+bounces-275207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKYJHqIh0Gkp3wYAu9opvQ
	(envelope-from <netdev+bounces-275207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:22:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D63981CF
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4099D30090B1
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F403D810E;
	Fri,  3 Apr 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8tvSY/l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IiFAibC7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209793D7D71
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247775; cv=none; b=PqWbaX2xl6VKEUDruYr+ZQZU9sIvVV/nxOHEu8s4/vvbx5CsL/jcwU11hcffXogafHNmZ8WV0zHYG/BRp6jII+/mRqMfyLv2qJ2pCH9eoJC8rofWXGF4ktX9Uy2pXE57x51yuU8lbiHQaTMt7gAT+bXFIzhkoZSHgBsqEActvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247775; c=relaxed/simple;
	bh=izIZUsvbEAV/0fCfYRTbm3ulS6qw1DIy4b9hYSIb/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm+m1WcfToF1ZP9rCjzwNT+5VfmCQYk+1ppO1q/ZnSCIfY8oJe7f022HaoqKJgDxMYJH00C2C3JiGev+RUWrIuzXLdKRGg4fMkDLweBzs57YftxJkFp9vCDvYfvXThPGZwAnUs/ujhl19fxEgwuU/Qy/UYW8aRVS/FUD41VGkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h8tvSY/l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IiFAibC7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633C3dSv823112
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 20:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4yDt06DKkjZYPE2ZQ7EPO/ds
	rviXxjbdzSBRuroEz6I=; b=h8tvSY/lEIg5f86ErkOrj+54LUrEUnGRTm8GX3OI
	AAUUcIhu8IvXk5rEaV9Mz0DjE63F/e6IADsUHEEAseHO6R8cpxgvM/tVToCC6DKg
	NxjDr8V9GbiwXZ0u/dp4HjFIYLud4+mZgD8i3bp442Qd+jOR9mpYFktJ3orsnI+E
	oY4ya0ZUOOWFxAyntDISdkmTCxhkgIS7wG84K+1Bw9fwF0/yvNUpIA/Wr2K92cMS
	B1xk1Lr/e/tqbIcctUw7uoK+K0YPPm4+owErCqf6IFU6A9S9w9JsopYP5vtoCbWq
	R2VprTMMxxYcZmKDf25fBN4fPpxVrUPFtYF45Id4wvUnCA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4da673an6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 20:22:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b3544bc7bso30970841cf.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775247772; x=1775852572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yDt06DKkjZYPE2ZQ7EPO/dsrviXxjbdzSBRuroEz6I=;
        b=IiFAibC7oHHv4n9LsZLi1RCZ74CsSO9P/lLwrWom1tnpURTpo7ZqBZM0L7ZuuNk6CL
         7OsPr7/KOfegACit/QwZi27pqux2Z5XwnLkrB15QgYiwpPSyIYgqJZkpqQf1m6AM2LCJ
         rYiXYKyrO5uIBQWXbWRgmC0vVYGyzc57hFcdox7Cg7/of8m5Tp/Ne5C7exy6ULvokEYl
         /X6AjAKiOpU+NaCa4/FGfhPyQkWSRzvLisaa+KoHCi685JZBY0upjfO1UK23qTmSCIXl
         yMpf8bqdoQ2C39XjChWxPa4eWJDWAe5J3fBsBsY9J04wB+vMuZTi7xl3/ui/8wZKTror
         nIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775247772; x=1775852572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yDt06DKkjZYPE2ZQ7EPO/dsrviXxjbdzSBRuroEz6I=;
        b=Ipg7gSiX3pxclRbQu7Pt19N6HXdhDFZZCrTLoSFRTDtxacdLQLiLKCNR3yFP42MMz+
         g0ZbhZhUhjx+sCss7kmqvvTTf7ZQcvnJb7lXFeU4hE58IndimTiV/tM/mWlvWQXl5K6K
         qMvpxHmZsJs/Bm1+m6UeWjcY59SxpsnUFJxxsXaPWyRJdOEbQiVJboBcVwgtZNPSS3my
         uHwE45gmCUFd2fd2WIpVsJ1yyoTy4TCLPti8J/uoXovfW1ViOig3N8kK9r2pRNgjWjhK
         ktmOxKZE3n35de7HfRqtZoEcIM2vPTPQhmgTcEvA0b5u4O7vSdvA9oUbvgoC4XatL0j6
         cb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc3kOjeO4e3njAUvieYStEJmSLJfDBzNyDW5eOg2I5lSrjEskfbsiwghkbDi33Q3k0KD+HwkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWl3MNMiVlR+UJ1sV/glmZMNpBp9rPXlpuRBlzReyS7cgSLnlu
	hvNNVI7AmXvRNDE/NMntzhEOadsWGn9tK0RCDs1NW20HOeBqxi/lX5L/NRNEYJYmtvEWFjxpb4s
	Lg4R+LsDdiD4IyTegXDYJnEoWQdwB45BcsuTmBsv1MwIu8lV8yJ069L5JeOM=
X-Gm-Gg: ATEYQzzx4ETy+AI0q4aQCyUEukFf2HFGpO0JC/9YykaXFwGb4DvS3vtkhasMnmZTGsN
	2RADHa29qjnCNep5RDXNlSOxqjr3eBmN3pl1VMovsDtaYFsh4qGgZcgIeoLQ+y8FQRGLb26hTNH
	re/sv6UBVO5uZtVWTMCwYRPZUS5lT5kg3RweUNJHf6AmBvoGfXweKacMyunuSTWWoybcLUmMFNc
	wBbhr9QLZQEQCU91v9kJZO+FVvR2bl+1lLmV6uqMfJkmOHEFvDmSAhSpHDyBAy3uJ95Lc28WRrA
	c4n6C2W48/UVRB4XAhQJhCBNdOzuSE+dwQzgo3Jepf/oj8wiLhjL1t//8bbPx8C5sZTaK4v4ae3
	4w07njSuxb5vMqQD70z/2HHkO7lF3qOwqk2I6OuyPwx7rp7JcpquQ1VgJRBEiAMLflqMUsoqBv5
	6e4zJ8wt+KUcxi2CRvbaI7iDzxYZo8+hjzfIo=
X-Received: by 2002:a05:622a:5918:b0:50d:6baa:9e9c with SMTP id d75a77b69052e-50d6baaa2e1mr38237461cf.6.1775247772062;
        Fri, 03 Apr 2026 13:22:52 -0700 (PDT)
X-Received: by 2002:a05:622a:5918:b0:50d:6baa:9e9c with SMTP id d75a77b69052e-50d6baaa2e1mr38237051cf.6.1775247771565;
        Fri, 03 Apr 2026 13:22:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c97cd008sm1357566e87.27.2026.04.03.13.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 13:22:50 -0700 (PDT)
Date: Fri, 3 Apr 2026 23:22:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Prasanna Tolety <quic_ptolety@quicinc.com>
Subject: Re: [PATCH 5/7] clk: qcom: rpmh: Add support for Nord rpmh clocks
Message-ID: <fnugbpprfyhisikdxrimmmumf7u7frjatjs253flet7xu26nz6@d5wjpz4hchg5>
References: <20260403-nord-clks-v1-0-018af14979fd@oss.qualcomm.com>
 <20260403-nord-clks-v1-5-018af14979fd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-nord-clks-v1-5-018af14979fd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=erjSD4pX c=1 sm=1 tr=0 ts=69d0219d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=BqJ7pa9g7VlX8Zvc9WEA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: GkVoEu2yEi8yz0WTIPzRCptan_7HsOni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE4MiBTYWx0ZWRfX2Ta2rgcWycLM
 Ni6pe0p+dkxmQRGvo4ucoiolknnwBHDcT94znWaXzbb+unYapU/gvzjVR7yuQtVgRz+L9UEucgH
 r8WFcs8nz84UzBBwXJR79XA2JqtGMg5oucnH/iPGOtPHXEooD9h8jU+Fx8rERYnxbBQwgSdg7AZ
 fVytXfPS9MFKYjWQ7fU9ovmWHpwlfQpTNlagrM5HXDDJlM2LUaEP0uKR3Lb6GOfoBBW1fYwUZw/
 pk75dm0f1JxTqFHc7z2OgU3M3jDP6xrHPHl1LzlACuwzb1CTbVNlTxvkCSfmuLXjB7j1IrrnvBE
 HQ14kTnmvgftkkYipSv6utPxzzFbkljaAcJ4lOYJ8h/RnOcsg0tWTwZhIjclZkK1px9ZvWr7og/
 dRQtKgTIAjzDATAGPigK77uG8XABnf0EyglyO/JjQVQOJUyzE3nsSsCpxjhm1XAstkB7UzpDaTq
 i7CrhuZMAPiCg/6k9jw==
X-Proofpoint-GUID: GkVoEu2yEi8yz0WTIPzRCptan_7HsOni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030182
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275207-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,oss.qualcomm.com,quicinc.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 097D63981CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:10:53PM +0200, Bartosz Golaszewski wrote:
> From: Prasanna Tolety <quic_ptolety@quicinc.com>
> 
> Add RPMH clock support for the Nord SoC to allow enable/disable of the
> clocks.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> @@ -1054,6 +1073,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id clk_rpmh_match_table[] = {
> +	{ .compatible = "qcom,nord-rpmh-clk", .data = &clk_rpmh_nord},

I R-B'ed already, but then I noticed. Please keep the list sorted out.

>  	{ .compatible = "qcom,eliza-rpmh-clk", .data = &clk_rpmh_eliza},
>  	{ .compatible = "qcom,glymur-rpmh-clk", .data = &clk_rpmh_glymur},
>  	{ .compatible = "qcom,kaanapali-rpmh-clk", .data = &clk_rpmh_kaanapali},
> 
> -- 
> 2.47.3
> 

-- 
With best wishes
Dmitry

