Return-Path: <netdev+bounces-241464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F2C841F4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8183A4439
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCA3287511;
	Tue, 25 Nov 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iHVMJoRF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AaEr7CEF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12B418A93F
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061349; cv=none; b=HEax7lgHbNnTVjL6QPHdi33yYFNa101Gp/yztzyAOrI6nI4CDgDQTbTt6i0o/gPocSqdEAHBO8tKJTwet0x06JVbIsnRv8Mp3sAZPd/GsBnxNJkKTBEABkBMXAhGTHVw5fNlmloH7dtzN/WHw4UVOm4BnD5GPMr/55eVaMKXSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061349; c=relaxed/simple;
	bh=oMTdwsFJtb/KK2NtcV7ei1s40i9qNvwO3sOS+Vb65JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oam6DfB2m+cF83hi6wFOeT+jMGbkW4sTFvoxsxM7/1gU8zk5Zw466b8QBOfGBvbSxPxeRvyOzaJXBk1GJCc4uUbrrhPZKq7eWVujA3Afg4L1Q34611Xy6/Cg/3Y7KyU+MuXJqTayMe+f+5R4cmU1fPSX3jm+ydhlOcWA/EHut2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iHVMJoRF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AaEr7CEF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2geSu1847616
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7ZY/IfwtAxSUBaJ8/ZvIDPydrBQb47el3GrCA4Bbk+4=; b=iHVMJoRFHG3QNENJ
	diQGagpS0axX1A73s1jPrjSmLBXQhYRkZXUNsIF8oy9GVCS0zrSjM3+i8FJirNpn
	vCIpMfBHtjUUyFtrLUTbfQyIDumjbDdGfXAjclGm8Qn/8BdNWJQ4Hn66ascVYVVG
	MfH56PSvA/LZj4FreOvpxwM461XN5R/cbGXQBZ6443B9HQZgcLbFY/cyJGWQCQRK
	rH+TfiTt1N83wXlNAXnLGmRXMj6jM6GjvlW5e4Y7gqc1RCqFaomqkWdh5eWZ7E0i
	/NdSO3t3aToKed6aZ11svrzrrkH835V4XErJh49QnRg6b6OcBcbDkBrR+ZSo2W0j
	SdgIZA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amu6qaehq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:02:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed82af96faso115880771cf.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 01:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764061346; x=1764666146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZY/IfwtAxSUBaJ8/ZvIDPydrBQb47el3GrCA4Bbk+4=;
        b=AaEr7CEFNAuMUda7YbmduBfi1fsIVoBoo0vrpxJFFcml+U1Kf7nPUUQk5DL7RP4muZ
         U1N9FD65PAOw8Yl4gYikjR+46qpz+DEOpH9Z+SYyN8zyDEFB9ednYQRofzM7fM+9cJUs
         C/mv2Dsv1Us4StoJCAMzySNI3Dk3Y7oUvXFS8HGhZoJL9h1zU/Rb1aXr5mTCgeehGQ3O
         aKgGmqltMNAF0E3dGaIASvai0ScKswvWX5JSzcutxmFMCEoqv+3r108SGKNoov7xFMPI
         zIv6Ei/esh9m9+jeliIGF47ZGqPQ4y8h0ctQPa3JRzpfhlaawAjKxAVA2IvPHVtCnKb/
         4fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764061346; x=1764666146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ZY/IfwtAxSUBaJ8/ZvIDPydrBQb47el3GrCA4Bbk+4=;
        b=a8cWcxeob0TZG6nIiX0TwAIyaeaGgnDHSprA+Yu/5TvCJ+SbU6974I/omwsc1kQxjq
         CXgOhB6GZEVr5qS09pxRuYxtq3vTZeIdSEJ8R5hJxe5jziUGARnIaEijmKYpb201zFTP
         8FiKinm/9nE19rTu+vEmDlfxopQRAT9yoBxwY//YCsKAEC4eG3sfCA3cGygiISsb+avH
         6Nvoowbt+uoqjI62FSXAbhLdYKWxis7uCUsSjxdsPBFRNWVOdmV34XMWOz6pXbvH4NEC
         Y2I9UpmmnR7JMHuFNjQkezIRC2A0uFFIQsTFgGlev9bANXtrV2BooghdghW3/zeeQjVz
         C/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVJrXvzkA5o5BTe6BxS52AIhBgq7RGPlmF2KYoG4jNpHsaI4lAly3uGWqx9g47KMsA5IAuRCyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQCSt8q9KPrJxNRMSkqaJmAf/bms3m9nn+z5tY2OfzxI8YJhQm
	ZAy8WHx+aXHiOPjhN0d9MNg6eRVV7brS3jdfjh5DOm5IOAe4pm3A4Dr+teIKF1zjiyUg/jtk76y
	qaelxEqAtCtA9DryVqh/r48WxdxKKYYN24vK3FGgiD4zTpBeAUQbT9DTtzlgAg+rLeFCyPTzR+F
	7Cnffv8Wdmxe5fudaRAcG3k6Dxd0kLvM5Gxw==
X-Gm-Gg: ASbGncuNsVf+i2p0WsKT81C2dUcY1NU2o5JWgIRGvd+CKY9zM6Qz8CW3BveVuFoqQa0
	pSVkdD/C2SS/qk9MnfDcvz7+aiUTDSJ/oMAppfPZ3F/wP4suWvmjkHBhj8fInNja7MULkg/2kns
	D6TcrfJ2XRkRVBH5rl7qgiIViHCpsO8LMpnvt6caT6thhBuNfXOMeli2UoV2jt6tosmJGZPBjig
	dV6oN3QG9wVFmmmsseYYLKr5Os=
X-Received: by 2002:a05:622a:613:b0:4ed:717c:966 with SMTP id d75a77b69052e-4ee58ae6253mr202070301cf.62.1764061345625;
        Tue, 25 Nov 2025 01:02:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgNO04crj5KPtXBNB2GTCQnzOWwXSlLmFbB9HBsjXeGE/RsxjJFOKEaDk5gga4uJ16ZjaolLnfuP1P6sNC+yA=
X-Received: by 2002:a05:622a:613:b0:4ed:717c:966 with SMTP id
 d75a77b69052e-4ee58ae6253mr202069581cf.62.1764061344942; Tue, 25 Nov 2025
 01:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aSUwOtiDMYA8aSC3@kspp>
In-Reply-To: <aSUwOtiDMYA8aSC3@kspp>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 10:02:13 +0100
X-Gm-Features: AWmQ_bmBdWVVS0O7w0IRa8ze3H8LgHCse0bZGE-WwkdnsPBvKRj41xo3XDO1Ygo
Message-ID: <CAFEp6-10WCGvGrRMh0q1DKYK+C+qm9yh-C7bGgdEFccM9TUbdA@mail.gmail.com>
Subject: Re: [PATCH v2][next] net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning
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
X-Proofpoint-ORIG-GUID: nGn12uwdvQwperNZdm7nSrT-TA4E6J4H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA3MiBTYWx0ZWRfX/cJ9/W8pZaj0
 lKFFXhF4u8TgIVYj41MIWVkjeLPooRvBUOD7gMgbmOFiTG3OxpcBMFbikjwL0pt/ZxCpLRKCLgY
 prosiLnzd4/p3chqveEYW9odob6jH3fqbVXGONE6Qox6s8n/iSv1ByjEYe9LjOewPkQOeIh0ddb
 jjl1j8rO/neZc47yvGN5at/TiaEFwYwCXaN/uxitHBn/XNuR7iBsvpBIXuvvv+uKKeuKl1sUR5m
 ZCeeGR2WdEkv04VbekirlqmDN/K/Ok1yyW2SfgnnuMj+l67Vx3mwCjmGmAVXNKS6RBX08DvG2Xd
 7J5gP9lRquayiPV1nQ/xVnfjzN9XMtNB/AVpG2MtgguK/JbRkEJOmYxnuM3YVKx7vXaFRbKVdmW
 gTlwrKvxda3p2FB1M+hIu0+njX1L0w==
X-Proofpoint-GUID: nGn12uwdvQwperNZdm7nSrT-TA4E6J4H
X-Authority-Analysis: v=2.4 cv=S6PUAYsP c=1 sm=1 tr=0 ts=692570a2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=rlrsP_yrQl_0TFvyRE8A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250072

On Tue, Nov 25, 2025 at 5:27=E2=80=AFAM Gustavo A. R. Silva
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

I just noticed there=E2=80=99s a V2, so:

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
> Changes in v2:
>  - Add code comment to prevent people from adding new members after
>    flex struct member `struct usb_cdc_ncm_ndp16 ndp16;`
>
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aSUubvYfGJ-BIeDq@kspp/
>
>  drivers/net/wwan/mhi_wwan_mbim.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index c814fbd756a1..313dc5207c93 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -78,8 +78,9 @@ struct mhi_mbim_context {
>
>  struct mbim_tx_hdr {
>         struct usb_cdc_ncm_nth16 nth16;
> +
> +       /* Must be last as it ends in a flexible-array member. */
>         struct usb_cdc_ncm_ndp16 ndp16;
> -       struct usb_cdc_ncm_dpe16 dpe16[2];
>  } __packed;
>
>  static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_conte=
xt *mbim,
> @@ -107,20 +108,20 @@ static int mhi_mbim_get_link_mux_id(struct mhi_cont=
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
> @@ -133,12 +134,11 @@ static struct sk_buff *mbim_tx_fixup(struct sk_buff=
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
> @@ -584,7 +584,7 @@ static void mhi_mbim_setup(struct net_device *ndev)
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

