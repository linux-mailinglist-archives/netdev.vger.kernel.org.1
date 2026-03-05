Return-Path: <netdev+bounces-264515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN9HH9fOqWlGFgEAu9opvQ
	(envelope-from <netdev+bounces-264515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:43:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B921714A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA64C30AEC9D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 18:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A243EB810;
	Thu,  5 Mar 2026 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ITTrG15i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F9d0KlgQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0B3E716A
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736149; cv=pass; b=e+gIx9l0TsEFuBzLlYj7+l6mwiN54TEt1kJ6iRe/pcTe4Ljs595fXvT72q9rCPEkiqlhSIj6H3xBDSEita73Z4LZ/ANzyAYGJapGX///16ceZW3gLZS3AT5TUT85Ij2ujmS6N7pl2GuBBHkrws0daPCXYHf0uSALrODGizRvq0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736149; c=relaxed/simple;
	bh=i9Izei1XwJ8Q1sTIXJmaQw1vce+U37WeVXECS+wcmzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9VsSJ0wWEwhMMx3aul/G4YE35D98gWJY6mva0vd51vNQDOZDeiJiqapDXT2qxQn1oZoiU8hQ925z0Z+qG1HNDl1a+X7HkFs+COP+nuuD5EVlOqi6HVXNHL+ogRqTwRhmvZEiEIdLNl0osvbNqdWWTNfHmSAi4rAhzDW+pdPNtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ITTrG15i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F9d0KlgQ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625CN2r2720058
	for <netdev@vger.kernel.org>; Thu, 5 Mar 2026 18:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oAccB2uUdoK/BgZhA5QuQrRrRXm8vN4YCCEIrWDteBI=; b=ITTrG15iS/za5pvO
	l9K8+sVLqPSwuvMtS/XeWJgRfTWSKxNntLx2PNHF6QL9QDYlB97u0A4ZaAb4zpR+
	TzUn9gI+Zw0O0voILumM8LKTkF0Y1Ovy9yVgUPbxBWaEg6/eeTEtWFfGmptJ40J0
	MHlGpGM0aQxRSIB3orgYdtJE+YK7RU7wy5V3lL+y0/mqC8rl/rZii+d/sMVNVz6x
	O3Sg0+G0RSchkIJKxxdsIBzzT8mVfusoVufVRirR0JVz2cnLSNvhg92q2EmpHT/a
	Y9GdMAXXtPBJ1yB6WK17k5sh+sD+UWEv8oRgkTBHcGGtFpf7A55lmw0/2G9XyQWa
	OAUnbw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq9srha24-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 18:42:26 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-899edf0171bso434850596d6.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 10:42:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772736146; cv=none;
        d=google.com; s=arc-20240605;
        b=T81F/rzGgKCK1nFjKwHjOSydyMynCfw5gdpKzkWbwdkNGmeStPVZOlX5tOtDO80nEI
         joXtGbEhvKLYFkJ+1LI6SwtojTD+n/Pn+rZsq1pj5a7kTWbZJRi1qEoEKyauDTtzudcG
         sVahrkIE+Z2lfKr7IchM52bozMPnX2v/HDKkINvnEQrFMZ2PzUxL62Xe/ba2fn6XDOjf
         +CLJGerZozfvM1pNjxRY0ORo+MpYLgn3z9BMuZptrMFUon3cCnYHBn0Ta7F8KiQcxRIK
         WklwxT3AuroTbtb8sJ9odYLi03T76Qaoji7/Akd1vSubivWG4zs8WCkWPs/aIKWJGbJr
         G7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oAccB2uUdoK/BgZhA5QuQrRrRXm8vN4YCCEIrWDteBI=;
        fh=Wp27JPKZesGm5WH3iE42sQZM6k6BOGgYaB1ALa5mgaw=;
        b=Y0zOwLdfKDtpyLwqWoTkqzBDbLeHlXLpCS6yyv/K57J3Y7kzMo6ZYkigaDCywKH3L5
         OL13uOlDUemZUp3EfRLMCpmGsx8Mtg3NefTVvwbaw/JHTzJukm1VCLZQq9pKmTjY4IJz
         u7M7SG3u+hXv67G+70jmC143TXOcNTnvvFhd1JhDV3Bjaxy72PeqhUWl1d+FZ2HGi0qa
         3xH7nhT985YnYSEz5ATq3xfXplgKR55kFtJfx0maabJQOPdcYWh28bLs/Z/izD4nJA/9
         zEQd6/24sgwbgth5IbzxjgOG728o0H1oyhgTLSp6jViHCAlQFjsacerKUoV+PjEcuhPU
         QRdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772736146; x=1773340946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAccB2uUdoK/BgZhA5QuQrRrRXm8vN4YCCEIrWDteBI=;
        b=F9d0KlgQ1ZU1fH2LjFOulpK2Jywvqr6HJCy7cgTRBi5ABlMP5cCHFidShDwSyt9DYL
         H+xnTA0XMSiY62zM2FwvEfGqbHjf4QoE0R0fftIyFTSobJjX4qiYcnUotwDhbMyP2pux
         MGj7SXwxgCUU1V57agLLuCWsfCZrtYfhSq5av5MNMvwmv8BUlpJ1gAlExYYCKK1xLVLB
         qZRqKGYHa2leSKCUhbvXg6hhqV7mR5MQ3h84wQNtmXlFNxlNc/dLLrYNyOUcxD87lntw
         jv96y+2xFWUkUQsYBjsdMVYOPxJG4ONUIornNwhehcpm8k2Eqhfo3I5sv5zXDKQ0a8Nv
         rr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772736146; x=1773340946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAccB2uUdoK/BgZhA5QuQrRrRXm8vN4YCCEIrWDteBI=;
        b=p7TrHDR+JcY/I1H/Uz3ue8SFicIcuFdw0kDiufhofDrLbp6M8OV/9a9zwarmAHRLkz
         UE/k4UGvdg2DZ0V9Gavz5bA8DoBOBtp/Fsg7ZNkTeY1Cr/J0qsHZRktlIKRvTwC+eeGs
         XSAT4oVKgtVcMwO+BaZQ5vfyvZp/TbEXPTgJB0cYv+DQGdWIcMd5DLanZqqVmfh1KChC
         MckJUIOINWSZQ3P5dvzNpQNZz4g6i+0cDzwNDQgVw/AGNsGm8KuB3fnPFOdVTa+bqCgV
         N8xfxBFHA6o+peFDng+Ulbjh6b1HVET6hwSrJvl1DFCCd7cIXZdr836t417ljbfypQ1C
         asuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8o8Kw46ycJuY2W4m8F5yYtzsMIZcxuM/JvII5uivDam63XCH0Oxl7RSY1ExFMbQPLg9uAAAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfFLPsqiMhPZINrtKA7xGJbnp9oz2rkF18WHHALYtDqwXhHl0T
	E7LOPKjlES6qHzyhHOX+IHTHfl1U/Heq+2dYU7saBlVGD/cG5N+omlbjdC0r4YqMNRmgQL1iory
	mDRziqkZhuvScsy5TdXen8aZChloOaNjD81mRPZvYilI812MSijDgxWSJl6TKnkDwhmYD2XcZJR
	BLFwgUR5bwU/TM9gU5yiGrZK+njs33bIVYTA==
X-Gm-Gg: ATEYQzzO/KW2ItopRZKFK0C528jXVGdFufinGqiTrD07JcVq+NWoDVj02R/mQy0dSU8
	IFtO6SCBAN3KgLC3Is/vOeee7Nwqc2aI8mf3bSmhs23gWT8ysIQQKxvGknRyvJ1dO3FZ1bXkQEa
	VZRAc2KCUSnvIGkilQfIi/3kFmFT0JhCoUlTMco8ai9FvRQoO08QczZA9kIUC9qGt9tsrMX8FMu
	Vw5y8p3XjO9cXAXum2pDQD0kbScXYx6vEg+Va0=
X-Received: by 2002:a05:6214:21ef:b0:899:edde:c4d8 with SMTP id 6a1803df08f44-89a2df61943mr14307836d6.17.1772736145656;
        Thu, 05 Mar 2026 10:42:25 -0800 (PST)
X-Received: by 2002:a05:6214:21ef:b0:899:edde:c4d8 with SMTP id
 6a1803df08f44-89a2df61943mr14307436d6.17.1772736145190; Thu, 05 Mar 2026
 10:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305172806.3118806-1-dave.hansen@linux.intel.com>
In-Reply-To: <20260305172806.3118806-1-dave.hansen@linux.intel.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 19:42:14 +0100
X-Gm-Features: AaiRm51WfzowYdV0IhuByc57sDiKyQ2oI-VmNCLmFm4n9Dr8jzz7bONG9CbThvg
Message-ID: <CAFEp6-0O3zHWxcjuDE_=k_kYU0Bg7PkREBmZEe9F8WJNQ5dR8g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing T7XX reviewer
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=a/I9NESF c=1 sm=1 tr=0 ts=69a9ce92 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=QyXUC8HyAAAA:8 a=mpaa-ttXAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=stkexhm8AAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=05jm2FvKJAfSaMCx5T0A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=pIW3pCRaVxJDc-hWtpF8:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: eejmHsVf9pwMoXHAQsXOeggp94Xx-jfs
X-Proofpoint-ORIG-GUID: eejmHsVf9pwMoXHAQsXOeggp94Xx-jfs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE1NCBTYWx0ZWRfX+BxS3sKElW6W
 nKKeOqPWRYSFfxciJMBjSC3dhRdWBl8cbB+r5WpYuKU2ZFx97FcruvA11eIv5GPaYBgGh14nKQC
 D9qalxMxZNPt3D8QUIjLxDkNs18TgKDlQH52dQ6lwm29+cgfaJqLFJGuSkfsbk2tooDTNZ64WB5
 oQgtmsBpGcGJ09p8r23Nwa/cwg7PEu/BeZkvAHfX4ZVc1UJNUqOTZYb2IF6m8SuVekv/7hNxSGs
 Gdyuy1I/0dtt/vME2nuLhlrL6iIWeNE2e+QqInW+gU8jVE4538iBQetwskVtrEyVoTCQCVAdxDZ
 FjQj/6H5L5cmUItq9NDlbKPO5zbKDf9QAUr8fhzefTwzrhijv8LTrW+EahrtishxwSj4JverWZn
 b9LnQyah3sMnLVXD7Y7XcUGVNSorPyWobZ0j4LqpmyD1alspzEGqHeSfzPaRy/j0iYzfVrlmjXu
 fniC4qoo1yQyt7/Exdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050154
X-Rspamd-Queue-Id: D44B921714A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,mediatek.com,linux.intel.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264515-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 6:28=E2=80=AFPM Dave Hansen <dave.hansen@linux.intel=
.com> wrote:
>
> This reviewer's email no longer works. Remove it from MAINTAINERS.
>
> Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Cc: Liu Haijun <haijun.liu@mediatek.com>
> Cc: Ricardo Martinez <ricardo.martinez@linux.intel.com>
> Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 427e45e12762e..8f4f5190df166 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16366,7 +16366,6 @@ F:      net/dsa/tag_mtk.c
>
>  MEDIATEK T7XX 5G WWAN MODEM DRIVER
>  M:     Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> -R:     Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>
>  R:     Liu Haijun <haijun.liu@mediatek.com>
>  R:     Ricardo Martinez <ricardo.martinez@linux.intel.com>
>  L:     netdev@vger.kernel.org
> --
> 2.43.0
>

