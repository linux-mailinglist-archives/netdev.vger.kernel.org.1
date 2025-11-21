Return-Path: <netdev+bounces-240762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2206CC7916A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D6E722DA78
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7733BBB6;
	Fri, 21 Nov 2025 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SS0lX0Bj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MFBwn/kE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406033971F
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729861; cv=none; b=cVTePm8boz8ooUkCa6d6UkX9mOj5xAEAc4x0VnUNGi0O2VSy/zfGbtDapbl5eeCl6HHler3OSgIiECV5ayvlxayTPqyk65r+e6e0Mi9DbKS6kXIg1ubY8jKAyby8gxl4Otc5wkH6ZJscfdgdBjVuEoxTTtuxrF6s20VS24CxJeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729861; c=relaxed/simple;
	bh=6aQths3UmkYeqC5k0bvtNslIGIZrT3MXFPVLiSxAQ34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQX4QBncWy7buTuCEczK61/UeRZcqOSBjD+q2gEfg5bHo1IThiNZMuUiurGMM/myzkLB5SfOItNAwBMDSbJXuc/r/Pc4wlOaxGY8V2VICuAgx0Kp87b9+2VD1COlSEQpzWyMmdKFZq6Y2mpfPcTPnLMSEOgXINQi9APXXfUEZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SS0lX0Bj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MFBwn/kE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL9SY8C3541419
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DwmKzsHMjYB0IXHlncQwCvx4h47JoPSJMRH17NG9iWU=; b=SS0lX0Bj8ywQlvzJ
	UltRimJwEsucxXYmff9kSHHdoO00WKOFAEZhI0YD8MVG5K/bQOnHmOvqWryMxvkN
	SsRGtRrRUV17ru/rNKxTySixprTlj1MfHIfj8kWBO7ZhatB/8wLUEpKCOok+lWkD
	HKWFfgy+ZdsQw1gO0GWMoWk/OTch6GZKiVcvwWjUYVKmE1lLYMyJVAIRlC1i6Hjd
	X5BeHynoIlr/Lq88SCrwYVLV9qvFN0cuumcH4PrkoAyqo8sEk3oMd5OmPSogKtlk
	CFUDZWjI3dj1l5c9bpaAU/N8++Ylevq/Tqt6yZ8DwcbvSdkG4ATZT+DvGNgW/dbX
	bYaxQg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ajng00kbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:57:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b29b4864b7so270712185a.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763729839; x=1764334639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwmKzsHMjYB0IXHlncQwCvx4h47JoPSJMRH17NG9iWU=;
        b=MFBwn/kEb86jkRM7EcFH6XsdcnTIA1iM9qzfczQxYHrp65w+e9rvzSKVwwMcdvymgO
         apoXZDFlcQ9UppXtyaAlysTZlpcmB/SbC6XX7p6HGZi2IlNx3BhA3WyoY3u4zHN2UpXH
         UaN524yyoPQksSN8L3LjI/mYr49+xbIHlmklKzkiSSzT8/ZTlaQlzz5VKXZlhEOc5Ed6
         QghstGdbIk9yVd8IGE/GrcxS6cIzmx3eK9qe9K7KsiTBsgmjXZBfDyvY5UxG0TVVxGzy
         wYpIQE+22WUaKqubgHspKpaG9Azj0EvssxaVMkaUl+UB5UAg26c2kP5jRChfngZIMjBk
         JSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729839; x=1764334639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwmKzsHMjYB0IXHlncQwCvx4h47JoPSJMRH17NG9iWU=;
        b=uJUzJUn4JHNGywrY/mQ5mziBFn9zIXIzHz7JHrMY4NJBfuJkHcnhz5J6qIeT2w3GrE
         lL4HMmpH6ABdPzDYWxgs4kYfqQ+rO8szB97xySbix0hX8v6BlJFvsDf7QkuHORkTNSN1
         Cw1q/uLy3/AlWLJ2CgikzkX0ffn0LfWWIzSFWUX7RJJHff7gW6jdhnA9KWMP4OWmOsoC
         sodhkm6EkzYdZrpXhh5RkqLZIaF185crxInefSU01taLbmIwC93+l88XqSybyHwjOW0i
         1UJSFBrP1VUfvhiXPI06/bNB6aI1n50RMWYiisuxdVo4xdEwYkt7TFADjJiAPGmQ5djx
         XzNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/AEp2ZkGfbV3/fR2bKupRASvcgCHSRGQc/8L2iHrBZiRjw00uhmf4njilv1n80ZIk3Nzh7rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznchGAQMhVlYU1+4izwEQSLsTuhhicadzoA7/9r3+Z0MkTZJJr
	Q6NU9ESk4OE2hoUDkZ9qaBoWhRMu/5bmn7cNmRTTYLk2TK2NWBOH05bf+ucrIxfQYNRaaead0m9
	vvvYscVi7ybUto/1ilfzXUvUBxPlj21QI/ZE3U+Rv3KV+cLP/N/TzZoKU8FF+1BG5f+rYyd70c8
	qsoVwapEdSRe6Pw2xBWUdT2uN29edMPQHqFbv0mPfT62yY0O8=
X-Gm-Gg: ASbGncsaZyqtCoUW86uDkitzc7zhwC3RMXX39scqIMZ7qTudCTn3AfVTluWQbCU60nY
	Ts4ZU2/lumpSv1UYzlrht7He3McWmbZtqXbSB16zhv7G/HyWxkC1A7OCISxoMW6vgrYPi+lVmh8
	W9aG566mQiC+576WuLL20f+iXp1NZxnK2r8dmDqj+1Kq6Qg3pujnoQYZI66EAQIdSQsmM/Ug9on
	kWgAO2szIKCEvSALMyL7nI2zQY=
X-Received: by 2002:a05:620a:4443:b0:8a2:fbb9:9b71 with SMTP id af79cd13be357-8b33d4d2ec3mr190395485a.69.1763729839128;
        Fri, 21 Nov 2025 04:57:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/ImViTUKGOyfaFGnKSiyBHKsWibQeBK1VDYCi3x/4vyE5fzALtIrIGwuZ9tVkYhuvFrLluHf3M2gnd3PpP14=
X-Received: by 2002:a05:620a:4443:b0:8a2:fbb9:9b71 with SMTP id
 af79cd13be357-8b33d4d2ec3mr190393685a.69.1763729838809; Fri, 21 Nov 2025
 04:57:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120114115.344284-1-slark_xiao@163.com>
In-Reply-To: <20251120114115.344284-1-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 21 Nov 2025 13:57:07 +0100
X-Gm-Features: AWmQ_blXKjid85FNwGYBFWabbTi6weP_UdyHfIuSprbhW190IbkISzEzytYnTqE
Message-ID: <CAFEp6-17so5xAbXYBv3vPdOsxmo7_+ELnXHxcQb5zZj7apTjzg@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn T99W640
To: Slark Xiao <slark_xiao@163.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mani@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: nmUAtMQBUc3wvxVeUaoVInZp_EkCfcev
X-Authority-Analysis: v=2.4 cv=R+UO2NRX c=1 sm=1 tr=0 ts=692061c1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Byx-y9mGAAAA:8
 a=jTkqkXBVwd2mT_Iii2oA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: nmUAtMQBUc3wvxVeUaoVInZp_EkCfcev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA5NiBTYWx0ZWRfX37CueIqvhTYr
 WWD4BIh/OsINxenqI766V1haRwKE+ujwwFcowumTkyUhLEr4htxArTiN4zLSxo8uejkMc8XLYBv
 DgNfypR7Thj3uh5aWlhU9pA7N7yZcWIbqIcsl6cDE1zmfRts4FJgUB7/EFV1F5TDsJslDrx9oZm
 wt0u1AnIxRLYkSmOY13v7w79iy+t/X8xgYtkyV+GPdydkXds4wTePEEU8GgK4AKqCNxlDXWOMJ3
 M0+dctkl24VhuWr3gIxKa8sUOMrIZDQEhKhW+1lOEkng0yZdGkkEnHOcxEVR7Aj9T2KLhyODiUt
 +xEwPMybETt+JzfrKwgh0rrrmFVYf2n95xy69dnaGl+TpI34KFXq03wwAs6OVDnGkTEauHodKc+
 AGFqqOVW+013KE8Ouijf0yLQjhEhpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210096

Hi Slark,

On Thu, Nov 20, 2025 at 12:41=E2=80=AFPM Slark Xiao <slark_xiao@163.com> wr=
ote:
>
> Correct it since M.2 device T99W640 has updated from T99W515.
> We need to align it with MHI side otherwise this modem can't
> get the network.
>
> Fixes: ae5a34264354 ("bus: mhi: host: pci_generic: Fix the modem name of =
Foxconn T99W640")
> Fixes: 65bc58c3dcad ("net: wwan: mhi: make default data link id configura=
ble")

Only the first Fixes tag is needed, as that=E2=80=99s where the mismatch wa=
s
introduced and should be considered the point of correction.

> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/net/wwan/mhi_wwan_mbim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index a142af59a91f..1d7e3ad900c1 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -98,7 +98,7 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(stru=
ct mhi_mbim_context *mbim
>  static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
>  {
>         if (strcmp(cntrl->name, "foxconn-dw5934e") =3D=3D 0 ||
> -           strcmp(cntrl->name, "foxconn-t99w515") =3D=3D 0 ||
> +           strcmp(cntrl->name, "foxconn-t99w640") =3D=3D 0 ||
>             strcmp(cntrl->name, "foxconn-t99w760") =3D=3D 0)
>                 return WDS_BIND_MUX_DATA_PORT_MUX_ID;
>
> --
> 2.25.1
>

