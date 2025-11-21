Return-Path: <netdev+bounces-240761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B65C79164
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99221346594
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C945A2F12D7;
	Fri, 21 Nov 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QK2QFgZd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rk98uZbY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760020013A
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729627; cv=none; b=Jd5I9oQkYKHWKRJHo1qHUPQMLZubPSwwD7kB2pZcwZ5Tpg4UX3czjImjtku2UsjBJTz9LlPE1IdkHzl3eo4q6OA2vo8LkBzrSc7KsF9oVvMBObLONNUv31WKpvLyynhqB5nwMSyvVve0cv+esFQ7HLAXDF5XHhAxyUm5vT6ZpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729627; c=relaxed/simple;
	bh=OdrCF76qfp03nCOmgAGzzFsyY9iwkH1W8MShjN3rNQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaOGeDU5OzSr8AunJ9hg+9L+zbet5ImHGuxTi0H6/ix+VD3kkGRxsO0S3y9mjiC9HkB/wzh+/8/dO7oY4I32Vi4Eh7i+l6otPRzyxw7Iq2F5lZeakMM867yGz6ztuIsnz1pnb7cBn8df2JT0DvNYkC9pvVn//Uhkzo+Wr/5wSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QK2QFgZd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rk98uZbY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALBkHLN3007810
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tO2up59Xfzo3hrd+f9iIn3/gwb1F0q11MRs+kjEbBWs=; b=QK2QFgZd1OHp06vG
	aISXYtvBYQbHoPOb3p70HJD1EeOUIMAxWgNbNDWwA2i/SvMjVdGuSQzap9YBSX21
	arhXq69m3cidm9NJD3+qQT8EcUp3jORAGO1fn/YrAOO2IGkw4vZPutBBDr/0Nj8T
	ySOhNuVl5Q2P4kMDr+l20E+pEA/S7WM9+9pj1j4HfsLrQB9iQ4yXTmgNHv/KQ5D6
	yPD3trHxTV5KPeUujLH3CIAvSYqbkJp+eUALn0CA2zmA2cc95DPoYoeoaYmjY5sE
	tGKTg+vcOY1JtyGDRoGjZxXNKDDN5uYVU05h4gK4yHQ/uNEx7tBvsPzoHuageUZL
	qbImYw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ajhkf1eun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:53:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee0488e746so44121291cf.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763729624; x=1764334424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO2up59Xfzo3hrd+f9iIn3/gwb1F0q11MRs+kjEbBWs=;
        b=Rk98uZbYjaESQnf/kRzFsx8T1xviJD6/v52UzhLZcGyRMNcGploX7Y+vcz6i1UVgMG
         EOP1AYq9YHhmSu8UTsFKeY05sGI5bjlOTSb28Dj9185iUqumREZjGhDjb25FZhj+C8yc
         ERzTn4eezrCTdjt3w4qG/pxLoiyjvr8293vBXS8HxdN5Nn5MfxuRn8U1jzsc8PCDoaqw
         qmzDBcptbqEnTYLVDrjNE6NHNX5QSL7a/RM4HXj4tG+aGiAjs4R0+GkspTLbmC78g6Sy
         zx4v4EAMUE6tElHz366tKkkCV7UeIWtBN3ul4mTJgYIIVA2MvYwjIM4u9U4AO+WaVNfn
         iADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729624; x=1764334424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tO2up59Xfzo3hrd+f9iIn3/gwb1F0q11MRs+kjEbBWs=;
        b=oaU6viu7DJO7/Hv0ZokizkDCS6xVplbtW/sDY2LHcLZG0THMeWJnTnqCQX089aNe+Y
         uH8yEZtqE5rbUkmSrJ+a2yTpNOAmLCxnudyjFsY9eLg70BDXRi1LJyWdyxClGCE5JEgq
         JijlecGaM7X3ynQZD1t6zKXioNQI9a1nAbXzUblwrzg8VvdaFE0roTbmqmBcsgNiQccS
         lZ6biqjNZcH0suBpb2n4hHVg/QRkc8cRNWaZx1rUT76tkg9v5GFk8TOiwJ27HRjC2t4Y
         lSlq9yYrNafy/NWKn1yDl/xdnycWvWW2X4EwZGc1I5rlfM2UcQZyZY8uo/e5RflIn3Uo
         eIww==
X-Forwarded-Encrypted: i=1; AJvYcCXl1YG9KOcvlWp3T5a9SqawYTpzKDisjKJ1sujtdxRk2lo1ur6MxBxW6T1ogJHUcgpkprtprSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQn5/uRzUQhKOhEXoScD/nWjqkXQ/kSBXBLlNrZC44Z2rI7vPP
	KwqIYNPUqkEtcVFFwf3zlG3KnYLTXoyVY4sYteSl7+MN9Bh9jOXusyovWOqqRG8hMPEp3FBcfXP
	p4RJ7FHx+NHYuAGk0iAAlLY+oXZVc+K9NpYMD2QrXfOuhfSMSLgsiAY0LaJhEG3EG4k3Ef55Fu4
	vgC4onMNj4h3kpiHJYq1FvsJwDO25oQrHxoQ==
X-Gm-Gg: ASbGncvgeKuywIyblKzPLauxKCyFPsx3F20Qw3oQxH0sk2OxDma6lryvZf9F+a6SNOO
	kYH7CROTmGzhQk9gq8CAjTfdFW4QyVz2B5qkbZ6aN9vJ+LsZVyGE5N9Pr6LxXuifz+zcEs0ZNea
	DXsNHUJGKPnfe/b7E7OBqyKP83lnUa8+wZlN7LOR/h7Xq0d7Zqhcuy5Or++Uutx0umlj9h+F+Kz
	iFL80LFKyj+KUFprpXPBup5Zg8=
X-Received: by 2002:ac8:5e13:0:b0:4e8:916f:9716 with SMTP id d75a77b69052e-4ee4b5bf82fmr84967141cf.36.1763729624465;
        Fri, 21 Nov 2025 04:53:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi7sWSvF6cI24HgsCm7kzJoTPxYqrQnPfezhkj4HikNvi/PNFPv3JtZ3ZoH629GhuzEIk5NAV/bQMytwTQ/L0=
X-Received: by 2002:ac8:5e13:0:b0:4e8:916f:9716 with SMTP id
 d75a77b69052e-4ee4b5bf82fmr84966781cf.36.1763729624027; Fri, 21 Nov 2025
 04:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120115208.345578-1-slark_xiao@163.com>
In-Reply-To: <20251120115208.345578-1-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 21 Nov 2025 13:53:32 +0100
X-Gm-Features: AWmQ_bkQopqDLgdwWx7LXFy6AzWKF8UE4fujb1Pwj1KbUpmItm7LETrhtD7qEr4
Message-ID: <CAFEp6-338P9-xvKaJdwoZx1bGM3OyiZG=E+tjOdO_poh1rjsfw@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: t7xx: Make local function static
To: Slark Xiao <slark_xiao@163.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
        haijun.liu@mediatek.com, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: R9B7ZO97QoxsWHk1OTLwBBwheC8Rhqfc
X-Authority-Analysis: v=2.4 cv=ApPjHe9P c=1 sm=1 tr=0 ts=692060d9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8
 a=n3u1Jso1Kkf-ApU8ncwA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: R9B7ZO97QoxsWHk1OTLwBBwheC8Rhqfc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA5NSBTYWx0ZWRfX0ucp3+N/lrWv
 NYf8ZhARH74iXnLC6vgsrQSWRgw1mwelCEhPjZTUp9OAw6v67yv/ovmlgwP4s8oSNg2oJBG+/KN
 CKzH67MVma61DU7wSANK+JnLW37B6V8Kw5c+LKruCiQECbqpmDengt/BA9Iw1bv68ugokfMCded
 U3jQfQbagKSMvnwnCvmVPUHI7VtW90xXw2zFcidUBCpevT9Z1piMrBs3xkBpvc3CDA57/s/aDft
 XSO5yS9ApeTb9HdsmE55oxVFacs/+vdPQ4DZq8WZJtlbPFKLta9IxTUF5MTqgA/OTRui0S2t6k/
 3aYF5Uj1i66aBbjrg7tq60EeH4Ks3+WJcQSG9lsA0Wli//CBFx8Dg1eZZta3fHo+lnszdMtC/6t
 TIItmhbW+X2qKfrjXTc6tdYK0MmgkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210095

On Thu, Nov 20, 2025 at 12:53=E2=80=AFPM Slark Xiao <slark_xiao@163.com> wr=
ote:
>
> This function was used in t7xx_hif_cldma.c only. Make it static
> as it should be.
>
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

I believe it would be best to target net-next for this change.

Reviewed-by: Loic Poulain <loic.poulain@qualcomm.com>

> ---
>  drivers/net/wwan/t7xx/t7xx_hif_cldma.c | 2 +-
>  drivers/net/wwan/t7xx/t7xx_hif_cldma.h | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7=
xx/t7xx_hif_cldma.c
> index 97163e1e5783..bd16788882f0 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
> @@ -899,7 +899,7 @@ static void t7xx_cldma_hw_start_send(struct cldma_ctr=
l *md_ctrl, int qno,
>   * @queue: CLDMA queue.
>   * @recv_skb: Receiving skb callback.
>   */
> -void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
> +static void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
>                              int (*recv_skb)(struct cldma_queue *queue, s=
truct sk_buff *skb))
>  {
>         queue->recv_skb =3D recv_skb;
> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h b/drivers/net/wwan/t7=
xx/t7xx_hif_cldma.h
> index f2d9941be9c8..9d0107e18a7b 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.h
> @@ -126,8 +126,6 @@ void t7xx_cldma_switch_cfg(struct cldma_ctrl *md_ctrl=
, enum cldma_cfg cfg_id);
>  void t7xx_cldma_start(struct cldma_ctrl *md_ctrl);
>  int t7xx_cldma_stop(struct cldma_ctrl *md_ctrl);
>  void t7xx_cldma_reset(struct cldma_ctrl *md_ctrl);
> -void t7xx_cldma_set_recv_skb(struct cldma_queue *queue,
> -                            int (*recv_skb)(struct cldma_queue *queue, s=
truct sk_buff *skb));
>  int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_b=
uff *skb);
>  void t7xx_cldma_stop_all_qs(struct cldma_ctrl *md_ctrl, enum mtk_txrx tx=
_rx);
>  void t7xx_cldma_clear_all_qs(struct cldma_ctrl *md_ctrl, enum mtk_txrx t=
x_rx);
> --
> 2.25.1
>

