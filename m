Return-Path: <netdev+bounces-241124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE417C7FBDC
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 10:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645863A6F78
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 09:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3622FAC0D;
	Mon, 24 Nov 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NYBT4fd3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hQRLm03c"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8C2FABEE
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763978049; cv=none; b=JgNs+Uwv42B25eHAgfy3K/o1UlpAO6Kza6R0yFQmW727z6oeTMT/WGbkeb4MoIuvfTDGgXEf3UIcaH8mwr6tkRMYqrsgDvDBKFIy0ra8rpuLBFAiIjtONoF9uayiOvxixrKGJb/iMnYs0Q6obyUXgaa+iPr5PXpgoK8DylMENLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763978049; c=relaxed/simple;
	bh=1nls/RefmDnsTbEZ8MH1LkewyDELPzxqoLUG6n+AhGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKXzUt+eaYUzpP16hqzPCQGRgr/XxB6RhwoLM6Xy7cjVdnku637eTanqJL5Ewm+NN3ybIigj0quACI1JR4gxfdd2Hzhd7mVMHVnUg+9bK/DJdMooFcMkut2FSfawCvL9Bf6eDiDym3SemX3logH/XmasaUpY/HgXDO1nRdPPw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NYBT4fd3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hQRLm03c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO8I3C62405698
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 09:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1nls/RefmDnsTbEZ8MH1LkewyDELPzxqoLUG6n+AhGE=; b=NYBT4fd3buqWkR5J
	Fs/J+SJ8l1ar6/iXSOE0xPezsH2j9XIOzvhGA2l48JkK3Lh1w81WuZaflOijYWqX
	iQjG3hUsD/0WquShRiDx7zMVQ0nkapjcKqhWzkdDAZ+Ezb41bejwRg29yPEB2W1m
	ZN7yOeEFfxnp/UBITrUiLNfxWaapJPdJfOuLU13QeBSNO2kautfDofQ5JCn9K7HH
	c7IERC1fgWGDaOIJ8Yhn6vTWvTFORN4oyzhw+aXEgu+j+KhanuPdkeE+k1dZNg6z
	t7lvXSvZ0tfC51eQKPNWN7j6FpG1Rkvu36YQKb8UbeaQ8U6rTqacwNxmZMKAQla+
	dOu/Sg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak67x4j51-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 09:54:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2ef6c8340so1149443985a.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 01:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763978047; x=1764582847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nls/RefmDnsTbEZ8MH1LkewyDELPzxqoLUG6n+AhGE=;
        b=hQRLm03cWvizPgjugwA08aBPwAhVJgUgDoFrvP/FF8cVB/dBgKUAa+8mY4MFTFi8cn
         cJbizcEVvyEP04ICJwviiPiBQqTUUVlkcTgmKq2fjqB4MtaBIa55cXTK2iGrQ/vX0u8Q
         5uNBnd4ktwNUIHtMYKRY5/mN9I03dpBfU1qUk3yCahx77LCwRmq+HdKsarKTMPxb/bBg
         Kh8OpH9VSdlKsdGZ494aPsDWGTYr6WVmMdk0KPAvJdtnJw+2wbOe2eBjmiJrpZABtG3m
         jYYUNU3lRzb1HdHS3Zswi5P6TKiExsKE+5imERLDH7sVFZSpFGcaNolmzqWzu6Kct4QN
         sLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763978047; x=1764582847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1nls/RefmDnsTbEZ8MH1LkewyDELPzxqoLUG6n+AhGE=;
        b=v5s015kHq0xFFmZIIvY6q+8p4DzwN/WjZlUiayjs5MmW+sbtK8sQfL70ducBgxjbPa
         B4s9naiSQzdfy3+NHaLN7QRnbG7BTq8ORUYPdvG4PDRGYQPjqjANFEl6UDdUz/rRpdTs
         mYecrBGp5IIsXdnvK1d+gIB3YSIJprCOFx15VvAyRlqEfy7XUFI8b42GHw0QDk56Wn8b
         bMzhmMMopsRtcxC9YK2qcBxqrFKS3NyY4AMH9g+CsKpMYxoq+3aI2VFXjvNZXoCAx8uF
         8U+PFad9wYj+3tuaSTYNQJ/NKOISyE2NHTuB+E+IjYGbZVu8loWzmQdGSqDSop+UcwAZ
         5VxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdflnsluAiMCql/7aLDl9Cr+PVT2AcJviHV4rIKQyWh8+zvJgT4qKvp8birv+/Z6i//OiXn/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhgoBWWus2qMJAlcDOW9/mRQX4sHxBIVmhY5OJi9kiWawt4rYA
	F9IBvGy2MBSgsLqCE1kukSoog6bpulJayKHWKvS9IOwL2Fkusxczqn3/uC6GHDc9yJmsv088XT5
	3QTRY29AOoPBEVJ8LRAhHeIe1RRln04vNV9NY4lIzuoBSRkkux2gqcCG4Ska4TLUL77vcV6dRvv
	N5ZJndC/hd4BBXMuQpFplwrQRtp9hdb2ckGw==
X-Gm-Gg: ASbGncsq9DaoK8ZYAcEjvBRzr3Nd0pY4ZdKPg+G97U6ardAOESLunnH2OLPl98WnBJf
	ca78fJVhvi9aodrJANRV+kIKa3zgDGzNnJBViMymtIp3lA06GJ7xXE7Je6K2+mQ3C8xUvNF+39q
	eUZe/zMJeIv41Pi0Ww8vBC2ugzgxU6N15lUL45Y/HhcruaF5MPMudT9JJ5n+uBWp0IMvuYHZY+O
	BM2FCtpvsp43sXZuEujP0pVin8=
X-Received: by 2002:a05:620a:4087:b0:8b2:e8c8:671e with SMTP id af79cd13be357-8b33bde8dcamr1714035285a.29.1763978046572;
        Mon, 24 Nov 2025 01:54:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0sLPSouWba0/Y8jtzFGooroG+iEvQGcKr/cdERncchfOqSNhHxHvenYFc64m5DV9oQTCfu8lKHYtSPbToC7s=
X-Received: by 2002:a05:620a:4087:b0:8b2:e8c8:671e with SMTP id
 af79cd13be357-8b33bde8dcamr1714031985a.29.1763978046053; Mon, 24 Nov 2025
 01:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120114115.344284-1-slark_xiao@163.com> <20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
 <605b720.2853.19ab3b330e3.Coremail.slark_xiao@163.com>
In-Reply-To: <605b720.2853.19ab3b330e3.Coremail.slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 10:53:54 +0100
X-Gm-Features: AWmQ_bmV5ZM3g7ynutgYAMtFcF5oONpcL9tZKCke2z-Au7lcQHBCPjYWwbQ6Fd4
Message-ID: <CAFEp6-07uXzDdXrw=A5dxhNc81LN3e-UXyw9ht7iAJr44M9A4A@mail.gmail.com>
Subject: Re: Re: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn T99W640
To: Slark Xiao <slark_xiao@163.com>
Cc: Jakub Kicinski <kuba@kernel.org>, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, mani@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: R6c01Zf3aP8gnf4pzZlgLib17ju9Sn42
X-Authority-Analysis: v=2.4 cv=AcC83nXG c=1 sm=1 tr=0 ts=69242b3f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8
 a=ER2jkhS2Mdndj3aiIVEA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: R6c01Zf3aP8gnf4pzZlgLib17ju9Sn42
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA4NyBTYWx0ZWRfX7IlToLP2Fow3
 2ggtK3PmFyvWz7ZBTFz0mvlzfRtZK5NblOisEmD1uQ7K3STBQmoOAI/plnRmE9ZBcDqCxrRqRTW
 cGMuBOrUCQvIj+l7ddrotkrNzFMsCMpE0eo1Dn7mhf3e9u3hWGibRlfwrLeN3Pn6xmYHv9esYz1
 7Oop2PuXt+ft5i/WDL1rt8kudu1PTPlRNIINyzFVeO6IgACvnFiscPlbomU3CRisnWgoQt0FsTn
 NIZq1NkjK5EDO5DxCQJFM3AKNpsbtF5BCjHOa/J7y9spzPzpo4r4lpUshIJH4jQoBcx9d/+7BYe
 07HBz4xLV5bZLHUxXkL/jl8F7nQVw+TuATWonl6Dx5VMi+z9Ze5ibgqRBBJcJ3oiBJZxhOSuDWp
 yHgxXG9vSafNUaoJISdPPhIytngykg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240087

On Mon, Nov 24, 2025 at 3:31=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
>
> At 2025-11-22 10:08:36, "Jakub Kicinski" <kuba@kernel.org> wrote:
> >On Thu, 20 Nov 2025 19:41:15 +0800 Slark Xiao wrote:
> >> Correct it since M.2 device T99W640 has updated from T99W515.
> >> We need to align it with MHI side otherwise this modem can't
> >> get the network.
> >>
> >> Fixes: ae5a34264354 ("bus: mhi: host: pci_generic: Fix the modem name =
of Foxconn T99W640")
> >> Fixes: 65bc58c3dcad ("net: wwan: mhi: make default data link id config=
urable")
> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >
> >Doesn't apply to either networking tree :(
> I have cc the email address by the system command
> "scripts/get_maintainer.pl patch". Do you mean shall I remove
> netdev@vger.kernel.org by manual?

This means your patch does not apply cleanly to net.git [1] or net-next.git=
.
So you have to rebase your change on the net.git tree before resending.

Regards,
Loic

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

