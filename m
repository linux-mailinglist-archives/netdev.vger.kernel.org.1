Return-Path: <netdev+bounces-240753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4253C790E1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 123EA352E8D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C542C3770;
	Fri, 21 Nov 2025 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HAXUntXg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eGlUMxUh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F172378F20
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729244; cv=none; b=HWCj4dQxr5W2HefEI2RIPWEiIN+seZVc5iC6YOfVAj2IeOkxi2WzhhtfbTDLuCXy4CisA3b70fxPrVzQqF9XDws7fPvN0DOxwmZhX+tA2RC23jS+F56xx6m8v7j8v034D1g8/8LYEcW/SzmBmi4BfNiJYDYMWQtpiIqXJMZMz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729244; c=relaxed/simple;
	bh=h4WOJ62pfL6IHlZQtCDyGCDMDpVkECvsZ4GVjHlxSY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ev1jLjHORcyyubRX26/SSjnU/pijbAz2rYckZZPBmU6G7Cnyres06IFKtzpgQd795u5XCDEQRw3OevHmrlejVEcnqutECZ/j9SWNpP6KMkTyMOrhNYzNtli2qmjlqKxfmHODnG+gfR1HVbr5YBR9sh4nrlv6w4wgubCcGowrG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HAXUntXg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eGlUMxUh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALC1aGl2756656
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OvmALCvQ5ptZCSB2+jI5QTgm/ZHNVohRruEciGYDcd4=; b=HAXUntXgZq04+sEg
	khidx5SQO1ch/IyDR0NYVIwKpj2owzOgB52QIBea3j1J6gTpCKzvPFOyJvL94KAU
	2wlG2p7d6H0EbmR+5XaGxfMbCOKWakQ8CoHh0PPELgxQoPkSsqskTzkwZAVRmaOM
	nMBaIDqTpYMU45yZdrBI+j4OPCLqxbatAZUN2CtBYSJ+fJq8ZnhRt+5Wib3QoRl3
	rPP5Y4JZsxCIY2y8D+gvxy/O5pXS76FDRy7cae+GiuiyF3XG4N1sSZ9HKgSq3UyG
	pD+pd4kJjDHQf5/iByEZsd7CNDxXXUbb1gxxQh1i6PQlG6zSm7hyDRFlBKSe6cmu
	hPDODQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ajhy61ec2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:47:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b234bae2a7so591031685a.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763729226; x=1764334026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvmALCvQ5ptZCSB2+jI5QTgm/ZHNVohRruEciGYDcd4=;
        b=eGlUMxUhv1Ab9aX53e8cutLH6kOgPHxqk23vRzFc5nwHhxFqmLvIscWXAadTk+Wqnh
         X1nLEBv/T2Q7RP1sl1YD7gCbOzL0r39khzkBCW9r8Rm9nBEq81BLhTHGKqsnZ8I5W+X8
         hcO/auvy05PHPz+gLPcXtjVm7dbyQNqWqUFG4Zevp7Ag0EiAjnwxdZjhAW2JiVQiUa+y
         YMiyagvljj+jH/9ikpmf37gp1CyJ+xZDh6F2gpU2ef6rujv/llgTOHEwv1265rM0z7WB
         Y1fwdaUN7I4dFa38lyBRUoRjvGZzY4pW3Tb1y3o6Hq9SI/8hOgH1fQDHpQKNx0gMsTi0
         3wRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729226; x=1764334026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OvmALCvQ5ptZCSB2+jI5QTgm/ZHNVohRruEciGYDcd4=;
        b=b8rKXP1NWPAV5AMu876lrpapvTO+7U/5yPSIJQDcsu89Qop+lUSef6tARFXW8nuJdz
         O4vOMYfircv8me26tTJEtQg4hS8nnDNKBqcCSvV5OxPu41GK7ggj15pjkKNGrCguLd2c
         uxWQOdVhMCqIvAs2+XDEc6qUuW5Qp15BjFYcaMXzElp9ELmkqlQVYgXbJ4hde7pfGfuR
         fNshHv9uI7oJqR1dAKf7409jCKjeZGGISUS/0LsJdiFAfGgvNxpq+eJsQrg3zVUVr+4z
         ziZbBHFYMt2peKU/BL87rDK/E4k8BiIB+7Yp1wRdGst4DC7dLNBvftpR4njSrAJGf8OY
         iX6w==
X-Forwarded-Encrypted: i=1; AJvYcCXR9zmaBV19l484YaDDXJ35K9ptgS5TXg1c4XRAaP7xXo28yf/wR2jYGJTtG4+ZD+rzOgG4vH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQlMhi7XwGdbA5mqJJ4S98wR08i2gDMJWdicxGd8SPB0emTqg
	dCCEaP/VXKTR23rCcEgvnZ0HAJJ8JYa7NY3m0hFsajdEZjIzo6K243TwJp3v2v+m1vOfejk4ejk
	7sAirUstOH/dL1xNXuUiOYtqMJZnXbgiy9prwdQnJTmMbpajaj8WRkBCZm8VfOVRw7TqGALYKQy
	/RH24CtJ4hLDdbxuZsTUKeqGuDK+4NlTCOrw==
X-Gm-Gg: ASbGncuDi5pKfQxY0XQQDOSGL18cVff2Chr3rc8GaHH3peyqm1l8aLnF52twC/DWmL1
	ojvHqNKvC74sM1QZ34pS9ahX1Mgfkq0oLHutqzFEz7gDFsAWBYMke5xVF6wfWLVLEr1V5x/PynV
	Ac8yb8dauoAqo3nqpnAekpW+X1TBctzl+RkJyhqrT+JRryBcGBum7ymp+Si4IgOd+rQ/EHUo8pK
	Zz6stiM+zVQKOXKNIMZfgSdPlk=
X-Received: by 2002:a05:620a:4412:b0:8b2:f269:f8a1 with SMTP id af79cd13be357-8b33d468fdcmr219877785a.71.1763729226278;
        Fri, 21 Nov 2025 04:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWPiCIgHWVQUiYgEZLxcTEc4IYShOjsf4gp1DesTemBJOKI/fXv3roTF9QbBQJ6o5Zq2D4RL0UGbl9ep845Ns=
X-Received: by 2002:a05:620a:4412:b0:8b2:f269:f8a1 with SMTP id
 af79cd13be357-8b33d468fdcmr219875085a.71.1763729225849; Fri, 21 Nov 2025
 04:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119105615.48295-1-slark_xiao@163.com> <20251119105615.48295-3-slark_xiao@163.com>
In-Reply-To: <20251119105615.48295-3-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 21 Nov 2025 13:46:54 +0100
X-Gm-Features: AWmQ_bmuI9sNPf86QyN3uWHpPrHgwmugGLDFCp_d8rNLY1v-hjk-kGSjK1o7rSc
Message-ID: <CAFEp6-23je6WC0ocMP7jXUtPGfeG9_LpY+1N-oLcSTOmqQCL2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net: wwan: mhi: Add network support for Foxconn T99W760
To: Slark Xiao <slark_xiao@163.com>
Cc: mani@kernel.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Lb0xKzfi c=1 sm=1 tr=0 ts=69205f4b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8
 a=laIMyccDeTmSpVvBuxYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ThC210-KSMptcXi1-v0iTQR7sVXyw5NR
X-Proofpoint-GUID: ThC210-KSMptcXi1-v0iTQR7sVXyw5NR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA5NSBTYWx0ZWRfX2YXMLr+F8+Bb
 cM9jZQN8rI/4hlN0/jfkodTkMKZZL6qHPJBsctYsjmQCrAPAu5Du2zk7UCV2nCAGdTyhwj90flB
 1lua7Ud+eJJbXcHeFnttqdbZgiqaxk/KHs3Aps8LKy7CAmrYpvMn8hbFWqcZWFgFRYt4hIq8Om2
 EF4U1435H+wN3fDG8rnCNT1TsHP/GRKydQ+Fuw1bRvqoN7gUqU2KkA9UfF4639cL2zKs5wnNVe+
 g679cJMlCDhBqR9rLvaNEPFzwO+ZQW1PyDYdU4IeAy4UcFre/XxMpMMGigK4un7sP1BtamIxGY6
 A2rwjoDIPvhBPa9ZtTO/21y9bIc0kf5WFx0Ye00vgt6BHplWADQ1uSjJvPLo9vowyBjM48gHo3o
 BOZB7oUgrTm8i5zG9bwun+R9R4AN+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210095

On Wed, Nov 19, 2025 at 11:57=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wr=
ote:
>
> T99W760 is designed based on Qualcomm SDX35 chip. It use similar
> architechture with SDX72/SDX75 chip. So we need to assign initial
> link id for this device to make sure network available.
>
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/mhi_wwan_mbim.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index c814fbd756a1..a142af59a91f 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -98,7 +98,8 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(stru=
ct mhi_mbim_context *mbim
>  static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
>  {
>         if (strcmp(cntrl->name, "foxconn-dw5934e") =3D=3D 0 ||
> -           strcmp(cntrl->name, "foxconn-t99w515") =3D=3D 0)
> +           strcmp(cntrl->name, "foxconn-t99w515") =3D=3D 0 ||
> +           strcmp(cntrl->name, "foxconn-t99w760") =3D=3D 0)
>                 return WDS_BIND_MUX_DATA_PORT_MUX_ID;
>
>         return 0;
> --
> 2.25.1
>

