Return-Path: <netdev+bounces-241433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4DC83FE5
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70CD44E3C95
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6422C2D0C64;
	Tue, 25 Nov 2025 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ru9Lz2ZW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fAc107OA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561129B8D3
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059645; cv=none; b=QTGYWbjTI56Q/63tGu7EeMBC70rkNawQ73JU+EUKirkTxefLF1/8Zr5/D274VrHatm4+Vpz4Dc5SaJWYEH0wpCyEpv5VMlW1eszmExKuN63ryIozFY7VfBRKqdLPNvQonYJ5bgATv/ct5qal4Z3lMa+XkZ1ffkZZ3fRxeuDk38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059645; c=relaxed/simple;
	bh=Ae1CPKP+xBxCglEbrpge43O/fims8vio58fFNmUJ8ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFdAXHACfNPCnNnHNLZbwq2Q5d9vpJc5SDhPfjCaSWigPQi3ooJs7HDf2AffKImxAZsVzmEuvtfsBSwtt7pZI03PPI1xzNFwiZI2MvVBfwCH9LskUpcFqCordZ4yDVYDw+bLjyDCoEK+aVwcJohQIWip2dc+AHXS3b2/iQJx3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ru9Lz2ZW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fAc107OA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2gfY81820690
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1HuTVZV0zOwiNRmWH4P6b323jWmP7HMng/IpPHgTUz8=; b=Ru9Lz2ZWzQO/3M89
	PNaJxhXxMyQM6nquajPIPWRPBcOanxCi30DQVoyRAM3Hgepcc1oP5YzlEIpvgPgn
	H0SuZ/+K8Aa0UYIQb1Kp3V+VP2dd7fNMAsRUjFp+799nOTnQYfwm4qkUvh4dzldY
	MkIMjRMLdmSOHSQ9fOmMrqEsd5bi6VmW/M96/5l0TK79N0+aG5eJ7j52zlEGZG4X
	pB6qAO+eZeUEfpfxLgpyXQkMCJqbWidkXp1y5oD6juHLzJ8RNNjmms3vdEXTfmGQ
	ee1EG/mXLb11f0Ag9Q7QxJW9TNxbG9vVC1u5Yw1rTIFyehKaIBcyN19dCGe/rhE8
	foebpg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amp6h3cpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:34:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8a1c15daa69so355693185a.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764059642; x=1764664442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HuTVZV0zOwiNRmWH4P6b323jWmP7HMng/IpPHgTUz8=;
        b=fAc107OAJiqCCRIQzxollCplXQDVHLBu8HjyT6VCThhZCxik+qD6ToIJPrwrc5NOcY
         2cgyxHH8WrKcEoRwX2jKjq+jv+m6+Dl1moiSCdPw1v8tJzOtTqveAVLrpssmu+Fb85vP
         MT25cvSZu7SmPfnUPwGGbtllpeW2STzZ+OUsNK+AHneLaJZGKWeBBN69Jtt6kkVEYeus
         VoVfggvejtcKJv3ZDkDW+NRVRtZbl5kIGf/mhMgpajz2UdBa+bESRC1Unut6sKwwC5Mc
         TQDiRJdosKkXm/D2s0KJLY0jdsCb4KX6K3unlBFgxFyF8IY/ehKcwBcEDjrlF/TktdWP
         5+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764059642; x=1764664442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HuTVZV0zOwiNRmWH4P6b323jWmP7HMng/IpPHgTUz8=;
        b=ZqdbgctE9IwwZTUE360sRt1SsEJm3nEXXpXQM7k+R1ztivrRw9g1iEoSRy68E6NUoS
         1I83YA6sDbWsdUQsYUdaxL2cRJx5WRkZ1pvX+FF7XtzOBuVs2vTZDUzHgk/cDT2zw+06
         YF3MDSWm90jsYk+LuBFouCyX9sEM6XVdlbTimvitmjFgViAsSWPCKDEuE9+n+hb2lQld
         nZ5wSxRQLnbIZzJWa2QDsfZVT06YgY8hCWhsWXLkKhc5jLxHWohP3ag7r0zsNl5beafA
         WENqtaDSvMBuIbxBE31t+ur+n5S+IrXhM5oUQWygorFDEOSkRaxaNKVchhHtQNiLS2pU
         yRBw==
X-Forwarded-Encrypted: i=1; AJvYcCUxHlMhf7I9yfs7J4G61KuVMqkzfb7OuQWVmyL8OCC6+428MDsEStUNAAMf251ABHx25ULMylk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ataSUfKSjw5kdh3Br4dC51jyeZwvnsCsIJrNSIWN23u4crfu
	1dj0xkVCFk6ddDT2ziKLPCWOu/8D3EYX4KbENwYYGSaj6gGxJIo5dkszwvHFDq7BDNxqs0xussA
	jqocU1i4sm6uztNnTz2SSmZDymg6AdsUMJ7tynIF9yT2e9Dr/0NftTKVXFQCh+q7swQNgJxtFcD
	V9A9wACeh5D+eiu120X29RTfxag04tqBoqmw==
X-Gm-Gg: ASbGncutLRvPBNsuFH8l2kkByQ8nmIAudM3j+YM0icdzbshklzfnuPD+oIwcSklmWSa
	f/Y93FkEe05Pxiu75b2P+n3HkXsUK/Cz10jIVJQ/ZgcIWvgrYbhupzVdjxRikCF+FyIVuzm/eZc
	kYqNvIzJCOXreg6WihfsotvjzV6TMzHUrbZSWVvLVwPLGUpvwe8zlkfA3xnIlT0xMHQp55iWb13
	XNn+R17WTz5n3Cu2ecNJ1CAou0=
X-Received: by 2002:a05:620a:2a09:b0:8b2:3371:e9d6 with SMTP id af79cd13be357-8b4ebdbdbffmr283057585a.62.1764059641759;
        Tue, 25 Nov 2025 00:34:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaseWVAd751kOoaG8NHYwslj38Zrk6O8JLCJx+cvSt2cnr4Ko/CUvPRCyBqK18JpfM6MZSYZSfMgY4c9iswDM=
X-Received: by 2002:a05:620a:2a09:b0:8b2:3371:e9d6 with SMTP id
 af79cd13be357-8b4ebdbdbffmr283055885a.62.1764059641373; Tue, 25 Nov 2025
 00:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125070900.33324-1-slark_xiao@163.com>
In-Reply-To: <20251125070900.33324-1-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 09:33:50 +0100
X-Gm-Features: AWmQ_bkqz4KYJ1wn6Khm7G8j9m-uhXdl-_D171Xxib4-ZX3-5oqIogJjeWNSWco
Message-ID: <CAFEp6-3i1HdDvqgw3Ye7+rhz7QBLsxEL4dJnj9qctpbG8sq8Cw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: wwan: mhi: Keep modem name match with Foxconn T99W640
To: Slark Xiao <slark_xiao@163.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mani@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA2OCBTYWx0ZWRfXxx5EXay+4qo+
 bQJ3w7rKhPFv/VfoG4THk9L5N8HjY9wGa9xh/TMZd2xvsGure2bUr3kqkSq7eZoBMSMzcq48nSV
 NScZZbEo9wwIoqbD/OOl1e4EA18ee+H3Ezg/nQZ0X6UrW8ZdJQydHZjqikZ2SK0HgT1T4Trt690
 ssPmSd/WXNs4BZOKNIcYJr2ITKLSquZD/8QeBjsoYi9PUXUGGsV/4t+P4rLw8/4lUuZtG0VhQMV
 Z4n/UrFUMXFWc4p/x4XnTxSKosyl4Uzi77w80QptFg1p3j3k/bnrZN8ojwhQargRXH088x4jIEx
 t6NVTdWh83ZNVLDAFdpvWTndRSnX2zDphigz1gkTBVjK00JbT+MLIoWURU4aIhpjaNWaOdD1j61
 EP0/lX8tiY6unaf8bU+lttsYd2jorw==
X-Proofpoint-GUID: -Z0vDuXOw71_yUJ68r_AABaB4E92aVuI
X-Proofpoint-ORIG-GUID: -Z0vDuXOw71_yUJ68r_AABaB4E92aVuI
X-Authority-Analysis: v=2.4 cv=GoFPO01C c=1 sm=1 tr=0 ts=692569fa cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8
 a=rGU52pVM9EWxqS3BAjAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250068

On Tue, Nov 25, 2025 at 8:09=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
> Correct it since M.2 device T99W640 has updated from T99W515.
> We need to align it with MHI side otherwise this modem can't
> get the network.
>
> Fixes: ae5a34264354 ("bus: mhi: host: pci_generic: Fix the modem name of =
Foxconn T99W640")
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> v2: correct changes based on net base. Remove extra Fixes contents
> ---
>  drivers/net/wwan/mhi_wwan_mbim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index c814fbd756a1..f8bc9a39bfa3 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -98,7 +98,7 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(stru=
ct mhi_mbim_context *mbim
>  static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
>  {
>         if (strcmp(cntrl->name, "foxconn-dw5934e") =3D=3D 0 ||
> -           strcmp(cntrl->name, "foxconn-t99w515") =3D=3D 0)
> +           strcmp(cntrl->name, "foxconn-t99w640") =3D=3D 0)
>                 return WDS_BIND_MUX_DATA_PORT_MUX_ID;
>
>         return 0;
> --
> 2.25.1
>

