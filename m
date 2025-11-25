Return-Path: <netdev+bounces-241461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F175C841B3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96C58341CBE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE42FF149;
	Tue, 25 Nov 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XO6lU9G5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CBEYguBl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079BF2FE07F
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061093; cv=none; b=P6L/OGNL0c0D0RSfV3aKbvRux8HBZ3s/wUpNZv2H1Ub5CX7C7eP6oh4L2bApwdBrS31lmk9arpqNcAmeP0XoUqOtNZt0rEDhoRocmLOYQXjh5WHUfKfM2l5ln88qG1fI9gH8/iiqiT+dqT8nGBEgtzX9TQAhSz5CFtaH57U9Xoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061093; c=relaxed/simple;
	bh=3CkzgVToI8tAh4aqVjwhzkg+marDrkmywFCMriDDUTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECTG1SbUUzAf/uV03mDFdZ/kIrdV9DicWRes1P5r9RmFgmTOVjnSaYpPhiD4N1PbetFBwKpxEAW6bfQO5GS3ttnXHnFmWalB29w/NRmO/Nm2TCuuALEhueVvwMDx4U/GJCkJ2GRYVlXBT+FKyYj9v/bus8Swo7ZcaCYQkRn9Q5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XO6lU9G5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CBEYguBl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2gcJH1232119
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n/ykNYYWp6SwDDQYYT1N/2x+yvjNjlWRoB5Io/QnAqQ=; b=XO6lU9G5QjN6Mwy5
	m2jC2b+ZdrwCmP78XDYynYq/G42b1cEC4Mw5/zUMG4TZbMJgg6Jiw8a9PWJZ8qBU
	4YUSf09TKzk8VvcohFNnGWWeFD05PS87PsHe8Xe8lO9EINO3cr5H5WI/a8DLOlo7
	v/dcY4V6DXqTAKAL3ynXovPQ6sO4NC9ndHGB2z/rnpVXmoESWLxkPGHv5R1hez40
	YPiIT6k198jD0d+spkEwhj2LDMzAUWrjxvqfq7pzLSYGGgq4aAuDw8MTLecyZaAe
	+4hFhSP2C9yyBxLDLfBtqA2iaXD0zLd6uDuzFMdMVfQ4S/3SdzDb/S/gTw9YMp6C
	9CyB2w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4an0xyhfyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:58:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b24a25cff5so1287320385a.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764061090; x=1764665890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/ykNYYWp6SwDDQYYT1N/2x+yvjNjlWRoB5Io/QnAqQ=;
        b=CBEYguBlC27xSICTMuUO1aNh6+ROiERyAZ2Wopair9I2WaWAX+sW7ho0xsJw1JIrIS
         OWnRvE5NYPcEsUfDQqONxM5o8Fa0Kv7RUIBX2bXNryMnXsLuU+goTuHqbuxGWcTgaN5o
         02OEkcHEbRargDd61TuAaEhMTYLsGIcrVlllzhvXm1hZbWl0FGAMfWhAm57R37tFtq21
         24B9zjDxJhsKTMwY0KGDW4FNV5I0AJtd6qaQRRGy/IrUMycpusvYsU3PSyG6kym+9HfY
         bgrNt9lDRymFrTGsQMKnrqZJWLEWofBJxqwWNRkUuEYqe2Wfl0XKM/cfj7qDhzz6ik4R
         +yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764061090; x=1764665890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/ykNYYWp6SwDDQYYT1N/2x+yvjNjlWRoB5Io/QnAqQ=;
        b=VQjO8U+NR6OsZ4GiprvYEPlz7cpe+1BvUZy8wMARjsL/m6nY+MiBagJVDgUWfTVDI2
         237rYJXcDGLfdltpM0rK3XpBvJUbjOPEXG0ycyfqamZCWWSlzS9rkEcWfgBquY/ZdAAg
         7gkR5jkSaLqb8Cvh0fxcrOGOO6V4E6TRac7yTAHThjs1AABtRrIUoITjOhrVYuv3QS49
         Oxyut2BjknEu2EdmC+jUGkEt1TDcectdNA3tCgvFnhGXg12IUgthLpKkOn2rtaJ6+jyC
         HtZqeliNKrXkdJVy09yPFRgL1djFPIt9caId/SV66pua/sdE0agcb0vV0eTvlEwv6mGZ
         awOw==
X-Forwarded-Encrypted: i=1; AJvYcCWi8mvpUu2xnk9aFrhJ9bq/13EeBQ4l1eGt8msfyDIw02zN9iR9+As4yd/ev6VPqoAk1+is/+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYOwH01CPXm10MunIrFoacj/zWCwOvLV4y6+8FLXpiwZQ3LIx
	+CmusvwIWmC5mb3O7weNdNqnTCAE//Y9SoMDWUoThjexDUp2aPaG9tSoBhp2F5PEtxj3CP/4ee7
	Spb7CPJNg5cCz7/zUsuvSXtaiTOSgitFVEHG8C7phw7/UWtb9AzXB1j5Mbul8NsXf8hRol/BEtw
	5wZTMQm9999Pm9jg3r+f129cOz/+3aZoSejg==
X-Gm-Gg: ASbGncu8Q8vjfJLTmzdQK7R5DOupzdQmBJi6iJDR6aD53gfhFWO7waftD1fuYkZ8FQB
	GVmO69AtjQssPG/gPwl4++DsaH94OJsL3G73or+VLw830ImJbxoqqKdfIc6XO6vx0BWR1xq+Ui0
	MSMNEjFG0ja/GvMCVNXYCkL2DFzTHujSwCHXpAFE85yqHT959tZihzs9jxMMtSx/ebKcg/5ON1A
	hIGZpZJh8r7Lk2z1gNTOox007w=
X-Received: by 2002:a05:620a:701a:b0:8b2:1568:82ce with SMTP id af79cd13be357-8b33d4680b0mr1753254685a.37.1764061090136;
        Tue, 25 Nov 2025 00:58:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjmwOo4q0j0FT01kB1fhXSU/eSAk+WF/NFlQD95PU4H5bKLPsKAN6ztRi99MIvSZ5Rr8JOCm6eNwgmg9rvIB8=
X-Received: by 2002:a05:620a:701a:b0:8b2:1568:82ce with SMTP id
 af79cd13be357-8b33d4680b0mr1753251785a.37.1764061089582; Tue, 25 Nov 2025
 00:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aSUubvYfGJ-BIeDq@kspp>
In-Reply-To: <aSUubvYfGJ-BIeDq@kspp>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 09:57:57 +0100
X-Gm-Features: AWmQ_bmTQcRkrlh5LC9CA4L2bhdCPeDV-xOAtBvRFXjiAj_Q-wt_cPxteId94bM
Message-ID: <CAFEp6-2qCu-S3Fcw6k7pD_UMD3M2rZqJPKA458cTJ3vN66Ae9w@mail.gmail.com>
Subject: Re: [PATCH][next] net: wwan: mhi_wwan_mbim: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=S+bUAYsP c=1 sm=1 tr=0 ts=69256fa3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ICYLl7Pk4l7hwN0V23EA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA3MSBTYWx0ZWRfXxu1CG3jFaFws
 /yCW4k827CgOeVWj3x8Qy2f7LV8amrSsn9pFfI8QoBh7m/H0GlRH1WNRb9DYvbl9Y4nlxvOl3Lb
 MYIzrVlU5KJOSIumYcBu7xcE1D+yggDyiAUx70YCMd/eFuVxDctntGy1xYlQYNBrLC5lb4iMGWD
 sGwwX22fUxahqZt2qhzx04a8Lt4Vxr8bvpRdyS9VwbpQ0LOnG3UoMGvLBSx2klmUyhbwMLSxWPO
 y4FQrRxrG2VQ0mlvXtYFyAS50RU+XJV/FXfULwJ2/1kcIzdw3Wns707idyckaj19FQDBktGRjM7
 QnPM9VlRmNKzCcj75OHUSGZIv2yfu7E3XO1PGwq3c7wftmjqUoNQkEbjnIcCqRyramzG5SsfP5t
 s6fh+aXR2gr4QZ6JNqBOrI5+QRApbQ==
X-Proofpoint-ORIG-GUID: vl3aUvYugUatZyveDIgNWfLSbhhQuNUY
X-Proofpoint-GUID: vl3aUvYugUatZyveDIgNWfLSbhhQuNUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250071

On Tue, Nov 25, 2025 at 5:20=E2=80=AFAM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Use DEFINE_RAW_FLEX() to avoid a -Wflex-array-member-not-at-end warning.
>
> Remove fixed-size array struct usb_cdc_ncm_dpe16 dpe16[2]; from struct
> mbim_tx_hdr, so that flex-array member struct mbim_tx_hdr::ndp16.dpe16[]
> ends last in this structure.
>
> Compensate for this by using the DEFINE_RAW_FLEX() helper to declare the
> on-stack struct instance that contains struct usb_cdc_ncm_ndp16 as a
> member. Adjust the rest of the code, accordingly.
>
> So, with these changes fix the following warning:
>
> drivers/net/wwan/mhi_wwan_mbim.c:81:34: warning: structure containing a f=
lexible array member is not at the end of another structure [-Wflex-array-m=
ember-not-at-end]
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/mhi_wwan_mbim.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index c814fbd756a1..dd60e335ed8a 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -79,7 +79,6 @@ struct mhi_mbim_context {
>  struct mbim_tx_hdr {
>         struct usb_cdc_ncm_nth16 nth16;
>         struct usb_cdc_ncm_ndp16 ndp16;
> -       struct usb_cdc_ncm_dpe16 dpe16[2];
>  } __packed;
>
>  static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_conte=
xt *mbim,
> @@ -107,20 +106,20 @@ static int mhi_mbim_get_link_mux_id(struct mhi_cont=
roller *cntrl)
>  static struct sk_buff *mbim_tx_fixup(struct sk_buff *skb, unsigned int s=
ession,
>                                      u16 tx_seq)
>  {
> +       DEFINE_RAW_FLEX(struct mbim_tx_hdr, mbim_hdr, ndp16.dpe16, 2);
>         unsigned int dgram_size =3D skb->len;
>         struct usb_cdc_ncm_nth16 *nth16;
>         struct usb_cdc_ncm_ndp16 *ndp16;
> -       struct mbim_tx_hdr *mbim_hdr;
>
>         /* Only one NDP is sent, containing the IP packet (no aggregation=
) */
>
>         /* Ensure we have enough headroom for crafting MBIM header */
> -       if (skb_cow_head(skb, sizeof(struct mbim_tx_hdr))) {
> +       if (skb_cow_head(skb, __struct_size(mbim_hdr))) {
>                 dev_kfree_skb_any(skb);
>                 return NULL;
>         }
>
> -       mbim_hdr =3D skb_push(skb, sizeof(struct mbim_tx_hdr));
> +       mbim_hdr =3D skb_push(skb, __struct_size(mbim_hdr));
>
>         /* Fill NTB header */
>         nth16 =3D &mbim_hdr->nth16;
> @@ -133,12 +132,11 @@ static struct sk_buff *mbim_tx_fixup(struct sk_buff=
 *skb, unsigned int session,
>         /* Fill the unique NDP */
>         ndp16 =3D &mbim_hdr->ndp16;
>         ndp16->dwSignature =3D cpu_to_le32(USB_CDC_MBIM_NDP16_IPS_SIGN | =
(session << 24));
> -       ndp16->wLength =3D cpu_to_le16(sizeof(struct usb_cdc_ncm_ndp16)
> -                                       + sizeof(struct usb_cdc_ncm_dpe16=
) * 2);
> +       ndp16->wLength =3D cpu_to_le16(struct_size(ndp16, dpe16, 2));
>         ndp16->wNextNdpIndex =3D 0;
>
>         /* Datagram follows the mbim header */
> -       ndp16->dpe16[0].wDatagramIndex =3D cpu_to_le16(sizeof(struct mbim=
_tx_hdr));
> +       ndp16->dpe16[0].wDatagramIndex =3D cpu_to_le16(__struct_size(mbim=
_hdr));
>         ndp16->dpe16[0].wDatagramLength =3D cpu_to_le16(dgram_size);
>
>         /* null termination */
> @@ -584,7 +582,7 @@ static void mhi_mbim_setup(struct net_device *ndev)
>  {
>         ndev->header_ops =3D NULL;  /* No header */
>         ndev->type =3D ARPHRD_RAWIP;
> -       ndev->needed_headroom =3D sizeof(struct mbim_tx_hdr);
> +       ndev->needed_headroom =3D struct_size_t(struct mbim_tx_hdr, ndp16=
.dpe16, 2);
>         ndev->hard_header_len =3D 0;
>         ndev->addr_len =3D 0;
>         ndev->flags =3D IFF_POINTOPOINT | IFF_NOARP;
> --
> 2.43.0
>

