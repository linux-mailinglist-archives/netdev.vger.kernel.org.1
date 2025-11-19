Return-Path: <netdev+bounces-239872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F95C6D634
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A8F2352958
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E778032570E;
	Wed, 19 Nov 2025 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="niMfbMW+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dIsmg/84"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADA2EBBB7
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540321; cv=none; b=bq/08Jmy/1PjQJaZuca51J7EhiAOI33372RRFryiWt3swWletpvF9DJ9De0i5p6MvpUa9dLoBOm+W8bVw4c9vckZW7XzdrfPtOmg9wvMWKRr1+pL27tr3WvyPDR1LH8Nn6rf/aJr+pwbN9UrMLLCK/dqC3BNXeybt1nqepzzhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540321; c=relaxed/simple;
	bh=zh5VcahD+EvJkMkKldozFL8zmqblGb5A2OjPNjQzt7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+GAJcuOO0EZ/XSIpNm5XNP2XcTHNljyNXLvJT7cRP1s/q9wRuox9N/NZ5EPzPQIvVmWYtJPF/FykTkCRbP8yydZpbQPEf/DmntPYLQWdxsB2iVgIXSvsh6aZl6s4A4RbO/u6Fk4rc81dZG+UTjIVQwZfhKOsJHjeZfvJvbgLVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=niMfbMW+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dIsmg/84; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ4XgOS885024
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5hJNda7PPbyFFAigZjxkd+5Q6vs5av51VdJVvooGekU=; b=niMfbMW+8B68ok5W
	fuhGcUtwrG7Wf2cGKaTiF5wWY67/TD8Hamq4bAOdHX/rac+eu3p0jnCB0nCojH9+
	FpgIfA45XSObDUS2rtUqcaRZMqA4NSB8Kcm+V0k7dUJGF6r6YMmP21Vi8De5UQ7S
	3pD23U7F0kqHZhN5tnO0g+C8g3m/uJsN+6qYGWtoGr7SrJsmJI6dpy7bHeGZN15l
	p+aGdYOIrd649IsEpNFGGLhNeUvqTtEXGoWOcsQXxy4Yqob81SP3P/rUllYZwlfp
	BX30M3wbRRX0/Q6z3AEG6gU0AGXko4eqXjDjO88slAJ9WN9tLa5/eNpsU2mmhRAb
	r64+eg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah6yq8kgh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:18:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2e41884a0so1272651885a.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763540318; x=1764145118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hJNda7PPbyFFAigZjxkd+5Q6vs5av51VdJVvooGekU=;
        b=dIsmg/84hD9azZbTOQqkZx09sGqQJ9mNtAIFWqIvetA4LD8P5Vex5gXplGhpj2koKv
         WwyGhzYAyCQM/VXEA6Z5NPAGGUcAInOJSxpwmT2IjJTFMMzWHuuYzOZbH1Hej0I2uCKA
         SHbOmIzvqbvUs0mVjzFMP0LmLkHfydmZIpVBMlX29FakkIXs+AKO7H7kIiVuGgXz/0Gf
         JIARfqtS3lIDKTQpdad9/qoqQ+Ox+GD6uSe26SchiNw5c7EqsNQN9xV+XmzGntcGLWWn
         eOZIfycWEdcJKxCjKwfrWBkrGLCvwaQyShdx4OaXw6Y+IjnwrjV/OCaeSgY1N5GGga+9
         Kw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763540318; x=1764145118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5hJNda7PPbyFFAigZjxkd+5Q6vs5av51VdJVvooGekU=;
        b=cvVxidqOZOCRrQjSG0ExzL5460YNcm62BjvntX+YUXHRcDSr6/62nf2QQP6I+wKB8E
         ShW+e7lwr/Y41V3em7+nz88d77muUW4NWHTEtGrISKcIFmzrGgs+xFglDuiyJ0FcqmGB
         aElEqBZvtSzNFoKlN1f+KPYUYBNSVavmEROaBLT7ew12GTkb4C/cLGU28Dye16K3aXOs
         htIHvohioLc8LurQVDmUTdxrLKO6KT5d3wIVWKGM2j1WARwweIyRTUO7PdZv60+ndpFK
         AI0MFZr9PxdpeCIrMP8Us8Bc4053rO8OMpssjWMvSzbvZJkTnFeHCWrIgT7jO44XVCAa
         NVDA==
X-Forwarded-Encrypted: i=1; AJvYcCU3YRdBhSK57gweasOW6CmA8lxh/jghljKNI7jbVfwjbCJxGrtNi92qi2DJRBrNPkb1czuw/ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBSsFvELaA2qQ3yrsNGTNLY2voj8E4+a3woAonEYneXt7fnia
	yto4BPMe9wTuDKAD3nSsZgq20dzpQgRxq8R8mGTf42YLxvobdWLGWunZp92F4XBxkzVCedcI857
	XHY2yC0UZYjRyqGLhFbXiEx4qMKteeHKXi5nAKntYfD5whKa8KfzceCNGUcddcXOEb+0YMqseQq
	MdwNcBDIfEQjA5X2mAdZkk3CxkB7WKb68e2zleca36yDwlB60=
X-Gm-Gg: ASbGnctYC+QNldG+v6/N5QIHlYsAX7VOx18bkf4QBbnovQ1sdfXFi3RUwFSMSECp7gn
	JBfRNUnyYeyqWOFWHhQLZKje0fITw7CkduR8GVHpvn45Yx+62PwSzqlCRNgaupx7DGVoVesQqCr
	VZw3QJSFw871y+qsElaJJo8JygmHr7fDdtTBxJCvesSd4N2Fvv5Fzw4xitSH8H1LW242Q+Aeqw2
	FFoCiOG57kg66x6GMmbL0BAiF77
X-Received: by 2002:a05:620a:4113:b0:89f:7109:185f with SMTP id af79cd13be357-8b2c315f239mr2451077185a.31.1763540318167;
        Wed, 19 Nov 2025 00:18:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJOvBJ2k2WkiN0ddCAdza60PA1z3V6Q3GboHhLXVhVW3gvLVseQdpDrJIPWFCUbtXqUHnQfEPKF8iL3YVNGAM=
X-Received: by 2002:a05:620a:4113:b0:89f:7109:185f with SMTP id
 af79cd13be357-8b2c315f239mr2451075285a.31.1763540317855; Wed, 19 Nov 2025
 00:18:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119033917.7526-1-slark_xiao@163.com>
In-Reply-To: <20251119033917.7526-1-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 09:18:26 +0100
X-Gm-Features: AWmQ_bm5vJfHA2LeTDtgXpEwR43aKTczmYbaYmzkeFja82B4SBLuomcTnJBfmk4
Message-ID: <CAFEp6-0EQwmh2JfAwEdBM0514h+UF9q_eec5WNLCax9kdxFHhA@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: mhi: Add network support for Foxconn T99W760
To: Slark Xiao <slark_xiao@163.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mani@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Rse6YmHIZdVu0C4P5mrwXDyPODLd1Uwz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA2NCBTYWx0ZWRfX4mgw/vj9q5xE
 aa6dPqdGJFWzYa+MMenFBaWHZgxTTVNvhcynbwRr4Wlt8vjS2a87Yi0f/WKES8uGNfOFhuJJdvk
 AubL6cQx6eZnJcQ0HuEjQajNbg0neSvEh2ew8HHtZTOY90tyf9/hluPlzOt6qUtmjrPMEkJkdaB
 LEu36HYCQeUQLYsplRr5qAI58WPoYoLKwNvAOiuitAFOI33Q1nWX5d8Uub3bNB6DfSI6nHx8wec
 MLg0XRZWFPeXBT69DWvRYnLiCTfifi/s6RbHz/GSlcZMLa7cVQb1n6JCuVW3DMHosQr+MRJ8mak
 vhdxp7DKMR6hJpxoLS5P56qgwwMg4KUbR+NRkoA4WMxzACAwWFSuILIOX8r+awN4rYvQs+bRA25
 kILI1aeMLXdoi4F0Kq7drAE08QZhhQ==
X-Authority-Analysis: v=2.4 cv=Ut1u9uwB c=1 sm=1 tr=0 ts=691d7d5e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Byx-y9mGAAAA:8
 a=jTkqkXBVwd2mT_Iii2oA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Rse6YmHIZdVu0C4P5mrwXDyPODLd1Uwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190064

Hi Slark,

On Wed, Nov 19, 2025 at 4:41=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
> T99W760 is designed based on Qualcomm SDX35 chip. It use similar
> architecture with SDX72/SDX75 chip. So we need to assign initial
> link id for this device to make sure network available.
>
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

It should be in the same series as the patch introducing Foxconn
T99W760 into MHI/PCI driver.

Regards,
Loic


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

