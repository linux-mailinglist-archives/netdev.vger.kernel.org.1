Return-Path: <netdev+bounces-193512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4C0AC447C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 22:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A5618984D2
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 20:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB271DE3CA;
	Mon, 26 May 2025 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UZJdhkdU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A73594B
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748291895; cv=none; b=ZICCK1uzMGuwL5GWiOs1x1bYJGMGnqHTc1sJLG16HqWL2CKJs4FhQuo8gIVkLJlGpyuWWk5DmX9pHLSLhErVLM88O1CS4kCSaJE00ZcqzLS/hcS8gJfUuXZ1hWwwjGrhzmKxJO/cHiF1CA3SQv7F4IxwmysvwWSOKdA48C5PWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748291895; c=relaxed/simple;
	bh=42gFM/JvxDkIVW05H3wy5pgExqQrCdMxqnJ15B52Ab4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VH2EtUL59oGGlj6n7sPJ6z0FxlkpzcuEJ+TG5coyxHn2Ek9VqDK1HtxW7Zm4Daql/X9UgInTV9OVrzhfEaCVKitjfbeMmsh/bUYdGYQpZ09ary+19HpR/S+go0ICsTZGHkyF9S2aoFufwfPAp5hEFdIinKCA19wW4DjlcHugNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UZJdhkdU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QASjgT019819
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 20:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	42gFM/JvxDkIVW05H3wy5pgExqQrCdMxqnJ15B52Ab4=; b=UZJdhkdUS0rVTnXz
	q18anJqwGFhLK7+mFGjzOeXGspjd0UVtZoIcuklvE+DrOY9Px+dSqbX6WDqVDnls
	I6TB8suXsp5VJSOZhxtwMQhjJGbXqyzcuo3Nt+lJF3jNJWdjzgTSgC+0ntLJTOgF
	yEcJeXYbz3XZGenOUt0WIqKB3iU8hplqf/ITzISoT47g3onTcnymUNTgJ+yp652/
	c/cvxu4xO6Ta1eNpfMCeKgnlgGM9lWbB1zgDFOPqsSuvxdOsP4lzva2k/VA0FWcn
	AfqD4bGxJPm9YOP80mx7jOh/8tIxrWMJaKCGXh9ISosu45lEmTiN0JItOhEf4ceN
	yya4GQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ejvygg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 20:38:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4770cbdb9c7so54775061cf.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 13:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748291891; x=1748896691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42gFM/JvxDkIVW05H3wy5pgExqQrCdMxqnJ15B52Ab4=;
        b=XnnD9fj6fzP5dyYFK9NvSIDETbVbZEGotjctJZy87jdbUDleLTel+bJU2zeVGdkRvs
         7v8CkyfhpLVxEELBGgC4k8CPUuQe0zPYEuyDFxGusnCtj8oXf7sOJK1np9bg+I2tPZL5
         Trvf3wz1apbJeiVSTed3ErT7/ti0iJxlQHsd+3Tv3kbAeClY1CuFAp25OXR92r1LM4jo
         6yMhQRrZzYtABxTNaVmQSqX6c8uhWSWgB77nqgZI1CVfi0p72nJSf9UNk86yB/wKHLIp
         y1Llo4yDUmatXrWXz6u2FbXJApHjtfo8JHLLqoQQ+KQVOc9BPM7TpyTqqdJ9uAYeJu1U
         XpTA==
X-Forwarded-Encrypted: i=1; AJvYcCVTBSAWjLxuv1DuiZQrz7obG1Tv2cEdmsievdk4Db/cRLwsXVYlzeKg1pc64WOkhckWyy5vYYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6+tfiHyPHnlBl7TKK55jSHW6Sdu5yxfp3fQ/dG6AUAftUoVK
	Tqr7F3je+SJ7hzBeYjorVY+txMlSFS2oeozRVIbdK1qwRmHGZj/BWpHvdxFAo94qP3AHsal0OXV
	XwJi/rkvdEzmDGPI+8xeLzus5h4XGQYuyGMSGrfUQd/33ZfrLobk8K8YDPscxi36U/PfggkyWZt
	nFIQ6Y1DDqUL9YCUo0eNc24rGdxAJawmO1nw==
X-Gm-Gg: ASbGnctzcBiUN9j3mELt+3K5z+kiM2dF1nabwdmmrl7N24D+BOUVGMXvK1V4h3ja8vq
	Up+wcrMqGGR1qXnuDbJuSSK6h6cwds29K850qgRwEDm81Yn19Ax9MPv0gOykQ3hreIQfVsVQ=
X-Received: by 2002:a05:622a:1e92:b0:494:b1f9:d678 with SMTP id d75a77b69052e-49f481bebe8mr193336551cf.50.1748291891483;
        Mon, 26 May 2025 13:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpHoK5px/Mf0v7qPUPYvj2c6D9DEsYJ5SW6CoL5EZfTigKfwUz4ehJotDTAgSWASUCE4u913eJQ80qyP+Gog8=
X-Received: by 2002:a05:622a:1e92:b0:494:b1f9:d678 with SMTP id
 d75a77b69052e-49f481bebe8mr193336191cf.50.1748291891156; Mon, 26 May 2025
 13:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526130519.1604225-1-dnlplm@gmail.com> <CAFEp6-06ATV_rh_KWvjgNoiw67WPvAE-gF_gU-DJdcycDiYVqA@mail.gmail.com>
 <CAGRyCJGESxV2M9e34dJw89=0NFt0+hrXCOCW=MaYdVfn42DZTw@mail.gmail.com>
In-Reply-To: <CAGRyCJGESxV2M9e34dJw89=0NFt0+hrXCOCW=MaYdVfn42DZTw@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 26 May 2025 22:37:59 +0200
X-Gm-Features: AX0GCFuQ0kXJY74x70A7zxllWDg4rvPSX-cDVaLq3dASTlhOQEVTBngtFiR9uj8
Message-ID: <CAFEp6-1nB-hiJb+W3zmnCSy9XaNfgbW7AqMeJ3LKa4+St-AqJg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: wwan: mhi_wwan_mbim: use correct mux_id for multiplexing
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Slark Xiao <slark_xiao@163.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=6834d134 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Uvi8EiTe67lG3krw1XoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: WHifpbBCGSjV-lTsr2zPBhaVzlTnCpfv
X-Proofpoint-GUID: WHifpbBCGSjV-lTsr2zPBhaVzlTnCpfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE3NiBTYWx0ZWRfX/jqkffr+4tTC
 j7zKCO9nWK783apbT7Np4kACuThI3aSX88TDaglASvSm2BaV3LH8JO5PiX1O4iom3ggweP2yUGx
 SK7KybWik+tATwj3m9uUIxRdaRWKd2/TycALJQnt3wfjcQLp0I69pjXEiWUWhuygAfJDpDbOkua
 os8R2wG/n32JTtSV5GoRn51xgGoOjx5TVe/NmTVvZkdakiCzWQzDjJfhdPgKk7rdVIIlfm37Wpb
 CWvT/fo07eb3ZegnLzt/5pa7Afxbc3y73Rzvjo5N6nr8gnvx2irs2/o3H6tVD+2Qa4AdWf1oCWg
 mCYrDZuOCYuAUUfFozDZlyKhwCmysq/RhY72hzU2PXjjxIPqaYCjjnECgcgGvrsd13FKBeaEqrU
 VV+m5KInU9/lraL5FgppbgymlaupOel0VuJhLnaopnLxgI91DpxowV0RERyMCtf1CgXyZfO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_10,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260176

On Mon, May 26, 2025 at 4:19=E2=80=AFPM Daniele Palmas <dnlplm@gmail.com> w=
rote:
>
> Hi Loic,
>
> Il giorno lun 26 mag 2025 alle ore 16:06 Loic Poulain
> <loic.poulain@oss.qualcomm.com> ha scritto:
> >
> > Hi Daniele,
> >
> > On Mon, May 26, 2025 at 3:19=E2=80=AFPM Daniele Palmas <dnlplm@gmail.co=
m> wrote:
> > >
> > > When creating a multiplexed netdevice for modems requiring the WDS
> > > custom mux_id value, the mux_id improperly starts from 1, while it
> > > should start from WDS_BIND_MUX_DATA_PORT_MUX_ID + 1.
> > >
> > > Fix this by moving the session_id assignment logic to mhi_mbim_newlin=
k.
> >
> > Currently, the MBIM session ID is identical to the WWAN ID. This
> > change introduces a divergence by applying an offset to the WWAN ID
> > for certain devices.
> >
> > Whether this is acceptable likely depends on how the MBIM control path
> > handles session addressing. For example, if mbimcli refers to
> > SessionID 1, does that actually control the data session with WWAN ID
> > 113?
> >
>
> yes, quoting from a QC case we had:
>
> "There was a change in QBI on SDX75/72 to map sessionid from MBIM to
> muxids in the range (0x70-0x8F) for the PCIE tethered use.
> So, if you are bringing up data call using MBIM sessionId=3D1, QBI will
> bind that port to MuxId=3D113. So, the IP data packets are also expected
> to come from host on MuxId=3D113."

Ack, could you please include that information in the commit message?
Also, we should consider renaming the mux-id macro/function to make
its purpose clearer.

Regards,
Loic

