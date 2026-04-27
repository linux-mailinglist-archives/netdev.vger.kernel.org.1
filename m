Return-Path: <netdev+bounces-281375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EReALty72kcBgEAu9opvQ
	(envelope-from <netdev+bounces-281375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:29:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 968484745BD
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B799300144D
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A620B3D3D0C;
	Mon, 27 Apr 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EUDXK0UB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E939A049
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300152; cv=fail; b=ATFGdi+rWDz1Ihvyt1bQF+IchYES6xCI9O8bCNpMbBOQ1Jk/yUbK3OsQ4aUKJIQytWBPUK8LiaLtETBqA533obg/cWzkAqpgxd+mh6L5TGsUCca5bSLUNwFEWXPBMHmKlYOpTaGw1cnqbM8a0tZoP2JXv6tXDVksDrvSqks8/6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300152; c=relaxed/simple;
	bh=cNz2WSzENxZIwe3ENOoH+tx49yVa0W2AI9rc1OJhwvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSn7/fdcpUxTpgRrAVsDhoWq1NdfPilHic+8W7DcIKokBhmK6wTz6CjAcqwqkj01S32E+xJisMu/sZl34RJhIRBvf349SS1Ggf5pz1Ul/7RCRzk2/ATlyQbBe9fAMen3EnDE6o/SeOZHMK+ALJ8hL5b/aiR0tZc/G8lFGtJ7rAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EUDXK0UB; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R3k31V876075
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 07:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=2UYvqcb6I1B7arRH3pzlLzPrPOKAEH8Y0SQKyqL2jag=; b=EUDXK0UBjzGK
	QKaoX5rIbqufWNaKZdxeAqfPQCkyeDJd2/wFJgapOGZ67xUUMlghtDbf4D/d1LxH
	5K8gn8+RpXX2sydNaWxkc5Fg5ZbqRGAsqwVsCp1OE3OWi5+yquLz/58V0qPoBIMB
	HhedRrHQtQxwKZTwXJUSL7FPjA3ZBGAKGlymgWIYr0yRV3XBk5s5Z4C1y8nt7KML
	jPg8exqznSgbfD7YbW/T/LWbR/ipKX7cSSMzAc4VFZlAkI+faif4DC/D2wB4c7UM
	RbXB1a99Y6RAwk67EGD4OMCuU6JKBc5xh1gQ4EhZCgV4Nyiw1GPLWPY/voT8hSRh
	Zbz3O5ycQA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4druea0m9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 07:29:09 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dcc9e6b772so16963469a34.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 07:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777300149; cv=none;
        d=google.com; s=arc-20240605;
        b=iLASIMsM+PCjrih7ZUQUl7BfKLoNo1+VMg6XQbtOI2qEDH5L8xbYC1wIyo5mPWSTpH
         IfRSyGA9yplaorVyYQi3GUiF8f4Lx+lNxJOR6N7uo+wXDoYXM7mTxttD6farqBYrBN1O
         5VJC4Iex4dAY1pwPpBI/n3l3NXEVmDZmxf6F27PaRg9SmoVViOeiAG7GMmmCVfcyH1T8
         PocYGx7iC2J9801oE7Tx+QyFin2+JaYM8UxGIYnm0loqZO8BMVYTGLmpdk9Ow5HIEWKE
         rE9DrgEXLIt9DVw8agUmRvbeJ9EbgGksSsA7sL6uLeT7kKNW+ayC3Kk/j3MSfi9Yn0u1
         4kKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=fc3CIGbC+cnKFtpvmB87XnJppPdvAQ5kyZjnAa4rMk0=;
        fh=kpp7sq6jDHcnCGOl+7e0kaNjErldM5iOgu3kOQFaTuU=;
        b=YyCfjjB6G5idFRJjmFLdj3WmPS0iYOeZPAgQPC0UL4gO0UESyuj3NMpUS271d2lof+
         iJoDE5OvlRcR48ICfgmvkgYnZFnPdK4UPZwIIYquzqALZ/QY4aDFZOLFN8a6OoVuzHG3
         8psN4DnLVVY3VdGHk4hjvHn//DkVRrv5IsXV2VfAX+evnOBFmvwQegUfd2r9zu5yz0/9
         vbRouAmF7xRDXJzdBbccsDEWzhewKzN0BdK4ZMtzGCXRzmYQZZFru3mjyo1YUWrZZMGl
         F4U+koHgXb+8TcotrvmF9WvtOKJK7/HJPDme7Lf/T47oNRmosSlRfxB2XlBEi0wRDDXe
         xglQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777300149; x=1777904949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fc3CIGbC+cnKFtpvmB87XnJppPdvAQ5kyZjnAa4rMk0=;
        b=jVeox+txeJdF5Hb/N0aVh2+2/r7ZNyB2ez74x6771ZuB/vkqEbasR/JHMTKx7PMzJX
         IPt2WHo0dS4rOhcIB/3gYhjb+jCHmnk4KsnFm/M9CznBuwpgkEgMe7hKDql5f1LRhEqf
         G6082GhrCc9xHQ0vzWQEnl//hmfxJqTOAQDY9ZT/wPZUJ8/5hS/JzgRo2FZ5s68KH60d
         Geg7CNlv1Y/tP9yl17SRJUYH+6jJLfZlkw7FWwfsNLr1DoMGe2sOerDF0ZMxvxy/evU/
         HXPoqdv5v1iy5b8lIssukYoOS2UiCLI1sAtYnAfGK2vWLIa1rWIr6dH3/4OCDPpJW6wJ
         FhRg==
X-Forwarded-Encrypted: i=1; AFNElJ9nBd5nCRa8kz5v93tXV/W52ovG65Ku42XffiWP3QC7VA6Ofzc+bQp49H3x59wU3C7NTEEYlps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBRhTmHweCL5Fx0ngkh4IIJS9bHriulDMB6f8FjSpPzniBSeAG
	PJdAekNhcU689u7aigE/n85hOBulQz21oRBk6jmKHaiAS1zJ4V/pj6n8ko7QStDKGlyifP0jmLX
	63pq77SCU3/TbpDL8DS1QYMyjcEGuMfUGm3zMdHAfL0xH9nSP1g4/wDPzc3ZH6WoBeqkvePtGw9
	Pwf2EnEirB2p6nrEMLG4l82eegq0pM56w=
X-Gm-Gg: AeBDievPJFFaDq3JvPCZdxBzWIfYFjw9mLAQBANPPfD8Fb2ydwG4ioAYJga2oE0TfGf
	zYtRXugkr/drT1QnuxBpKnn3vNo6sY0LYoBJpro9S0XQS2hJbwuaACnyMNd3S7fpm+tXb9U+7CJ
	cAuZlMFuKAGAp0udDHEqtwBf3KhxKwzSVlBDtY/9kfXhoFD2dRUD2bDG1QlK4/90nRGLLD59hqi
	rimGSN57jNSpbmX5VZrBpsnsvABHw==
X-Received: by 2002:a05:6830:82c6:b0:7d7:e3d7:e200 with SMTP id 46e09a7af769-7dc95525104mr20499561a34.6.1777300149176;
        Mon, 27 Apr 2026 07:29:09 -0700 (PDT)
X-Received: by 2002:a05:6830:82c6:b0:7d7:e3d7:e200 with SMTP id
 46e09a7af769-7dc95525104mr20499546a34.6.1777300148671; Mon, 27 Apr 2026
 07:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420183920.3626389-1-zhipingz@meta.com> <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org> <20260427133746.GJ440345@unreal>
In-Reply-To: <20260427133746.GJ440345@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 27 Apr 2026 07:28:57 -0700
X-Gm-Features: AVHnY4JY-sO0J_s7LFL2WwzvQxcK7s_leO-HiTQgItvSXPr8LTKeRFwdBSndRaI
Message-ID: <CAH3zFs2Sy0mv=QkK4VSV+MVR=ef_CdoxMhTFgzaqoZ+uSOpxoQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Stanislav Fomichev <sdf@meta.com>,
        Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=M7N97Sws c=1 sm=1 tr=0 ts=69ef72b5 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=jaC9V5GCrIjCCUt1bV4A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE1NCBTYWx0ZWRfXxUMUdI6nJqCg
 JUYZ049xXoMZt/FB8LGPoB7tLwDdEDJrWAGMQsdpns9KvIlDiBA+YWzic7iL04kvsAOEX33tnk5
 ea9Zd+JfB1FCmt7WZ7dybPS8owhj3Ag2HlK4D3uh4sWQwwcXliiTuRSlsOhvjwdaUCFPNB8gZGT
 QpfpLvaYBv4Os52G/ptaHYCgtmDsCEJjeuERPOdsCzSGuotevnqG3tQPiwg1rzPmzzROfjbNzoq
 xXzMEegDOfQyMZvZektbhV1GioZeYmQ4BH212PwwKT5OMNylWhz8YxNVCE680pGGpf5yqBAvn77
 zPGb5cC2hhnOsxqZZGBw+lPers+jFXdx11JSrhlIVPnkgRRnaBQsjHDU93OcXFRFGiXyn+qcj5G
 hGyk/FWQgWHws31HICJiT+ZePFTfUSC5xQDzmkJyIkLNQsB/ZdMQr9yIVtw6yDlOJGYvoygmh2H
 UIMhFgADvw0TiJ6pAbA==
X-Proofpoint-ORIG-GUID: a1RW_buuVIlD80yf4QRKsMW-VeIFV4hN
X-Proofpoint-GUID: a1RW_buuVIlD80yf4QRKsMW-VeIFV4hN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 968484745BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281375-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,meta.com:dkim,meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 6:37=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> > On Mon, 20 Apr 2026 11:39:15 -0700
> > Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > > so peer devices can reuse the steering tag and processing hint
> > > associated with a VFIO-exported buffer.
> > >
> > > Keep the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI layout intact by
> > > using a flag plus one extra trailing entries[] object for the optional
> > > TPH metadata. Rename the uAPI field dma_ranges to entries. The
> > > nr_ranges field remains the DMA range count; when VFIO_DMABUF_FLAG_TPH
> > > is set the kernel reads one extra entry beyond nr_ranges for the TPH
> > > metadata.
> > >
> > > Add an st_width parameter to get_tph() so the exporter can reject
> > > steering tags that exceed the consumer's supported width (8 vs 16 bit=
).
> > > When no TPH metadata was supplied, make get_tph() return -EOPNOTSUPP.
> > >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 62 +++++++++++++++++++++++-----=
--
> > >  include/linux/dma-buf.h            | 17 ++++++++
> > >  include/uapi/linux/vfio.h          | 28 ++++++++++++--
> > >  3 files changed, 89 insertions(+), 18 deletions(-)
>
> <...>
>
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index bb7b89330d35..a0bd24623c52 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -1490,16 +1490,36 @@ struct vfio_device_feature_bus_master {
> > >   * open_flags are the typical flags passed to open(2), eg O_RDWR, O_=
CLOEXEC,
> > >   * etc. offset/length specify a slice of the region to create the dm=
abuf from.
> > >   * nr_ranges is the total number of (P2P DMA) ranges that comprise t=
he dmabuf.
> > > + * When VFIO_DMABUF_FLAG_TPH is set, entries[] contains one extra tr=
ailing
> > > + * object after the nr_ranges DMA ranges carrying the TPH steering t=
ag and
> > > + * processing hint.
> >
> > I really don't think we want to design an API where entries is
> > implicitly one-off from what's actually there.  This feeds back into
> > the below removal of the __counted by attribute, which is a red flag
> > that this is the wrong approach.
>
> I believe removing `__counted` is a mistake. In my proposal, the intent
> was to adjust the meaning of the storage object based on the flag bit.
> The size of the array should still be represented correctly.
>
> Thanks

Thanks Leon =E2=80=94 you're right that __counted_by should be preserved. In
your approach, when the flag is set, the last entry in the array
carries the TPH data, so the effective DMA range count is nr_ranges -
1.

That said, after discussing internally, we're leaning toward
introducing a new VFIO device feature with dedicated TPH fields (as
Alex suggested too), to avoid overloading vfio_region_dma_range with a
union that changes semantics based on position.

Would you have concerns with that direction? I'll post a v3 with the
new approach.

