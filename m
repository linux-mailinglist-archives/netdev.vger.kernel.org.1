Return-Path: <netdev+bounces-239985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88EC6ECC0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FD4C3A6309
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825753612FC;
	Wed, 19 Nov 2025 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aufVFN8K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QG1bur70"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D253612E9
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557731; cv=none; b=Z8auz3SpDLyTDYtr3bhaJJy/s+Y+pQ+affOBcXEInarA6XSgD9MrHIo57SE1CCUM9leoTp9I+7JGponpklWYQG0raBzcIj/DXw6u+OCl+pEB48VBgx1R3VE5g1EWa233F3dHAYcMekwoTAE7GCtjc0OgZytDpgf94RC9hz20MJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557731; c=relaxed/simple;
	bh=zfEQUt4DhWAUXc5x6ce3fvEtypuCBnBXH7OVSLBJQLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuYjja7zAFuYXbfZOubaV0Ew1m4ZJSG6s2P2yXXdgto72cg3rri49aZGwuIiZHFJGaaWg432jsVFWadczp3NIIcNybIgGKPBjEUhwSbQ2f2SpZgZ5gddg0GcWnhyE7fCIGZHao6iIWdWSPYnfqMCtFyZrSy7Gv44P5hIq5dCK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aufVFN8K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QG1bur70; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJB6Gwe1982214
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l9lECUAFdYVI6sCIVSOz3LRlNh/O8By86XnvozCDqms=; b=aufVFN8KDVdSv69a
	hRT8GTNwJnTqUhoUVN0GUd1eHfFPuDuEXpteVMBRqQmbkLV+9JhrVq/4f3PPqsQK
	spfIbRLn0RBJyWlFxIOKhGcaoRy3quZ/Ixko412pkSEOsaZmMOa2gY9hxHKyNwLd
	NnQO77kYkz+sasGlbwDvbIZ6hiHAfv0Drj/6dVhTDG89cO21LJ8N8lACunR8cW02
	RUlJvAwTWm9LW8xqVGt4tq0fZGsAN3FJsptioNFnfTmpfKS1belXodN/SSvBorDJ
	9NI/1SpAeY0Hc8QAegSbTv+eqUsyDUa4jZZjV0nxiXmVEY+ObCpM6Mk6y7tJESgn
	ZWXUfQ==
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahcqng9yh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:08:47 +0000 (GMT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-949056882beso368510139f.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 05:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763557726; x=1764162526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9lECUAFdYVI6sCIVSOz3LRlNh/O8By86XnvozCDqms=;
        b=QG1bur70EJbE8Miaf653J0h0J66izu+6gpxuJV+KQKYIJnXjp0PW6Bopd2BO/oSQWt
         lUUB/HIE0QbUbusWw+XL6KxaB4d/4kvtBKFJJu4Em3yWc+SPf9q5PXkqOXXTuqvicuZp
         gi9Zm2Q1NR7RzlVmD0s+jqKBKZtpGo0phWk9f06lJKQYP5B406ShdxTtDbbKSOCLJlhl
         tzxObncoVPt1TmDUEkp7KvtldftPVSdO1Sb/BbWx0ifhzKalvZVxhYTD6McWq0K2Gzy+
         4UxJVvPYndIcVYOu3UjqsABLUDkKXRRmw2u/32c9mYW7p2oppeTn/XMi4fxanot2fO9J
         pmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763557726; x=1764162526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9lECUAFdYVI6sCIVSOz3LRlNh/O8By86XnvozCDqms=;
        b=BOVwkDpIJde9hDtvxzT00Q9obcHBdTj78w8iJ6kT02gszFuLm9TCCzPNbKbJQCawaN
         KmR8X6n+GXYTupH39alrdpBSBmpCE7tB64hcbRNNDdU3Rp0OiFUTknnBA4/SIWorBdu1
         ZQqd6ZIQOVs+hLWG8UTMjOYjoXRqOxE2n1FrolYaBpdjLgyK1lDd1fG8DN7P9gPptqnw
         H/YeQm3/AtK9ZHy3XMnw3Jjvi7Seu4P62jduMZ3DuAauuT8oYd32r8TUCJeUppaUdV5Z
         o3wNddH8Ma6RJ3zYlC+WsZPq3H71E/SYHEIysVTFnjNyFA9Trmq0Xplvhlf62ptQku67
         jAaA==
X-Forwarded-Encrypted: i=1; AJvYcCUMYCtU5C0ZE+VgULsUuoIFiQ5Rc1w3/jP6QX9g6U1zyMWUj1vmVFQ/4EEDFtBRfQSEg51gomc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxlJBTmJhM8u78vcd4kBX/nS+FH9CrVR7366zdNaHYVjD4cjAL
	mbxuFTavgcwW36mfO6x9eWGdbpyF4Nf3Enb2BM2ED+fyuS6KttSM3KJjr4yrwWpv+bnA+INosSf
	9oM0hzdVUIGCLnLWe1l32NPuHwJ+NlLzUuUH3u5mweOuqaqnRPrULnGen4sUro7+KwebOfU54nT
	mxJIq5LlYRK0uZtIQnKDw31vqb7eAciz5+Qw==
X-Gm-Gg: ASbGncvsnOlQX7GwUte1bQTbTTZV8UI5mMPrZ9dfCze2XxE/lT9YhgtfLULOUhmvzie
	r1NydeHsfhUAN312ufLzi6YqajNlBMdpgUyH81IYmzEX4ZJV9XvLz08r39OIkiSd/DNRM1sEX97
	YugUYOFdm1YjQNIT2LaDrMs9CbsJD7dLzN/KLiqmVZgmytu0cFcgZJ/DcgJFl1RvONSMa1Kzs87
	stIHoqpQ/TRkK+ULeVOGCgzXFZe
X-Received: by 2002:a02:ac16:0:b0:57b:66fe:15ef with SMTP id 8926c6da1cb9f-5b7c9e0370cmr14450842173.19.1763557726430;
        Wed, 19 Nov 2025 05:08:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY+j1dfzf8Batt7FHNQwSvu4wncs/IYd0ddz7VrhrJ0xKu+nxGk0DEyzi1ENK6CVZeNWF9cPj4TuK3qu0VzgI=
X-Received: by 2002:a02:ac16:0:b0:57b:66fe:15ef with SMTP id
 8926c6da1cb9f-5b7c9e0370cmr14450812173.19.1763557725952; Wed, 19 Nov 2025
 05:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119105615.48295-1-slark_xiao@163.com> <20251119105615.48295-3-slark_xiao@163.com>
 <rrqgur5quuejtny576fzr65rtjhvhnprr746kuhgyn6a46jhct@dqstglnjwevx>
In-Reply-To: <rrqgur5quuejtny576fzr65rtjhvhnprr746kuhgyn6a46jhct@dqstglnjwevx>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 14:08:33 +0100
X-Gm-Features: AWmQ_bkdfqVA1rkVLtELKfbA7SfWdvWWr7jj-_NBBRnuiF2JhyyUFR7jNOrf7ls
Message-ID: <CAFEp6-18EWK7WWhn4nA=j516pBo397qAWphX5Zt7xq1Hg1nVmw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net: wwan: mhi: Add network support for Foxconn T99W760
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Slark Xiao <slark_xiao@163.com>
Cc: mani@kernel.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEwNCBTYWx0ZWRfX5bBVXE/ju94L
 eZ5vIibeAYUypeibTMoLo6PF3BohXKpSIBl3Qo8kgm4haASdhLQXhl8dWH2zN0qm+LRC+fUBsMl
 /x4rVYMsKqAz/NkrMwnOvbJwrMkMG78FoOgx11jZGT+HEGiAHPjEQXaaGFDs20rDCkzQwVuMKGx
 S8ncFUIveFDcNTiV/2gNEdaRi+ZGmqmhKEhOPZjRK3BdEHzTPaVTIqb5CDXvIZQ8VydxLJIoQ6s
 WpKxrvyXlMS23vEvjoQj8zW63eR80A2nfHcEkRpixz0q9ZEtz53W/iq2G41Aq3oQZaWaMaA+BET
 PUJ3i4rU8JynayGwRbBjDBk79fKKVKjirmY+VAhG3GHz0CAAoqAVENHSsGFDG5EivfPcEt+2USK
 fJj+vHDKK7X/zcPl15bPdQ/212Szxw==
X-Authority-Analysis: v=2.4 cv=ApfjHe9P c=1 sm=1 tr=0 ts=691dc15f cx=c_pps
 a=7F85Ct0dzgNClt63SJIU8Q==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Byx-y9mGAAAA:8
 a=8dE3Wk8t88_o15qU7OwA:9 a=QEXdDO2ut3YA:10 a=LKR0efx6xuerLj5D82wC:22
X-Proofpoint-GUID: OnM933UgHbbyA4oyyKa2ztMFrg2GE2Pc
X-Proofpoint-ORIG-GUID: OnM933UgHbbyA4oyyKa2ztMFrg2GE2Pc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511190104

On Wed, Nov 19, 2025 at 12:27=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Wed, Nov 19, 2025 at 06:56:15PM +0800, Slark Xiao wrote:
> > T99W760 is designed based on Qualcomm SDX35 chip. It use similar
> > architechture with SDX72/SDX75 chip. So we need to assign initial
> > link id for this device to make sure network available.
> >
> > Signed-off-by: Slark Xiao <slark_xiao@163.com>
> > ---
> >  drivers/net/wwan/mhi_wwan_mbim.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_ww=
an_mbim.c
> > index c814fbd756a1..a142af59a91f 100644
> > --- a/drivers/net/wwan/mhi_wwan_mbim.c
> > +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> > @@ -98,7 +98,8 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(st=
ruct mhi_mbim_context *mbim
> >  static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
> >  {
> >       if (strcmp(cntrl->name, "foxconn-dw5934e") =3D=3D 0 ||
> > -         strcmp(cntrl->name, "foxconn-t99w515") =3D=3D 0)
> > +         strcmp(cntrl->name, "foxconn-t99w515") =3D=3D 0 ||
> > +         strcmp(cntrl->name, "foxconn-t99w760") =3D=3D 0)
>
> Can we replace this list of strinc comparisons with some kind of device
> data, being set in the mhi-pci-generic driver?

If we move this MBIM-specific information into mhi-pci-generic, we
should consider using a software node (e.g. via
device_add_software_node) so that these properties can be accessed
through the generic device-property API.

Regards,
Loic

