Return-Path: <netdev+bounces-297086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M4cdGxYpKGo0/QIAu9opvQ
	(envelope-from <netdev+bounces-297086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:54:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E4B661627
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:54:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=b+bzFh5l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297086-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297086-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B24F31DE6C2
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79D346E7D;
	Tue,  9 Jun 2026 14:38:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCEA341068
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:38:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015904; cv=pass; b=Olu3PUmNsHw/KWwQuk4/82XCDfHC9rSNDxPzKk+eNSxpbvdWZaqaIVhqAye2/WDtmjreBDZSIKNQN/hd/SgI74XAe+MPKFf1pSphxKoU+1rh3wk1QmvS+arTny0H537afOAJ7EpOvdjnZRnX5BGhlliHbrIxwjaO61Sp51BP/gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015904; c=relaxed/simple;
	bh=y3AzoKCQuHgd+PJJX0Ml7tfsX3S9F63aRJW3c7mG6Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMfOtJQQkWTXEp7duf+sdc9FS3h5AyykelfXiK7Fltv2RD+t4uYBMEfnIlZx40rw8sy9SEOBBBEC4bqxiBnFwol6jqlJO/4aMzUUcNfn/FK5zYBfucX1a1NFiejX04ZX9P6ChGKHRONqZLhUQAEOSFDz5Ad+vL6bxHJvm52VnbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=b+bzFh5l; arc=pass smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658LW9Ld2456422
	for <netdev@vger.kernel.org>; Tue, 9 Jun 2026 07:38:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=A9sFQHsXqHrMgAiwxXHw
	qbtJi56QK9Hsrm8AczETl1g=; b=b+bzFh5lZdFG6ZMxUJUlD8Yt1iTFLbUkN44J
	0sEYOv5io+R4jUYJbE8CO/8bzyHasyD/fqldbu1TQANBQ68ej/P1D7bCh0Be/t9t
	77ignPYiVT73nQeplrY12DpT/Cb+rEjERmUU6TVCa6V7eUZ7JLMt94G73fGvajze
	zyUZleQxuZvCbUUSXYPL/gojMV01wKZCDt1r9+IxqZGQ1f29Qp3i37UJwt+6Vg4s
	mCO5U7LHFg4UrHlCu+BS9DH360ffxI9Csawy+GcEYer3nQpVrv42nRoVOUC7IsxZ
	e7IvZ+NUUzgTwRET8EbK90UUlwI9PBNVSniNuv50nJRdR5rglQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4en5a5ne18-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:38:21 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e71e43e89bso4367990a34.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015900; cv=none;
        d=google.com; s=arc-20240605;
        b=FQ4YgEwJMZfoyVAsShAeZH5cpyAbIYjfUvtXgSCIZUtQjlZcDxIrwL2NrFLVe+ZoPm
         T+ll1FWPvCEqo70uYTLNxQ/B14nLO762AL1NwrjeZZVQWI0BtU+U3m2uA/1acjkogBBN
         M1ypgZ49AMvO2giW8ZxF+usy+fQ2aHK5bZdw5ptPmQehrBJJ2chHOvcSke/PLqqlGrp2
         9NgeGxf1DKI+Uedy0zXIdhEECD9oOlAGT0Gbg5QmR0eBtn7owiOTzlgvyZiC6g1q4BjU
         vjdatTu4YVcjcAyKu2yUjyiwxQjd8CLNbWaj6M4L5vZlQtWB37yj+GmztGwAJY8mAuFg
         /G4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=A9sFQHsXqHrMgAiwxXHwqbtJi56QK9Hsrm8AczETl1g=;
        fh=bb+3btlTB0u+U6uKqGJDWDh8A9FK0aoBsrYijIfQZ+4=;
        b=iaTU/tp51hN5tyd3qhpIPnhmm3Ip2E/zI154+kTU+OF29xowBBfsUNvMsNR7pNh1nT
         76ZRFewSAmi43wv3Dym8d2Y5jJblH/I1GDshSg1rP8Wbsv/hmUZGcgRyQxresY49r86K
         1fYUqdG3GhEw3SwIDmsFwsfeBDc4WT93sk41NTWOYw/xRFkFsjCJ5yPuwgRGIeO2BdRM
         jFzGayshSlfFLCYxcMMhC8QDKLm4PuNoyixJJ5Te1M+f4GexvrX3H9ZDjCMuJlkSOIRr
         eLU1nYwGKjCDh0RjHloNUru2R0vWrACaZRsFGflSmSqRhJEuK0NW61xJl4ftFqnld+9t
         EApA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015900; x=1781620700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9sFQHsXqHrMgAiwxXHwqbtJi56QK9Hsrm8AczETl1g=;
        b=W3v1TUvrwtZFJUre26EH4P0mhJLUpYSLhwyTwgsKDKc1+92tfXneCqf+E4B4io4BUt
         xTXd1rQK/Kc2CbDZiRg76X/FPH5fi6A4+xVZt3GOgSNGbBvH7IESUp9Xr1ZnTDw/MMB+
         OKKC1UP6BTivyMhUj3AzVBVus+AzNebyqnjYqdde4bMYn9FOQc2OLno0umq4nz1+1KMv
         top7Q9T7CDNykyq131XJrwjST03V9kFcoV/JKonM7WmDZKXc20jjTWkiqwXu11Hvy3Yi
         u/oz0UwhZje6jgp39zPGt5LvA3JXDA9+JPgO5+xLJSwo1ZacGwHVlnXnlGmbnHzDx9F6
         2EMA==
X-Forwarded-Encrypted: i=1; AFNElJ9hKAmWqY5Vzj605zboJb8rbzbVP2ex+pQhbVybEPCpCOn3+yig+7z7XQUql489y+GUw37e+jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvSQa2i28LdF/9CoTCF6MY2sFt/5/NChNXcFPbPCOgNVLXvEuz
	bWX4x0QMJFV/3T30NoinkST2L729lnGCtODcmTNSoh4YrPvtOJARC4apaBRHDYhgGsguzDbMJm0
	/9JEbYz7hk++Opgs+gWRx1kvDcMzSrbp1O49RQHIclFVqjRU9vpUcEp+8LliGxAOV3Ni3NZjQ/K
	Nj7ZINEUxdSbi7eFgyk1tKEvSKc79Ln4I=
X-Gm-Gg: Acq92OGUSLtIJOypasp8/i2Z92XdveghVbXeA3wcKTT87sojsHmWTa7rdgP1sP8iQBX
	4nlgM3zBZOJ8nsOmQC1sk//wlPJ4z1E0Zut5OeatjDQF9VDfYdfhCnmQ1dOIfDqVwyqAKxXdviT
	RCZTz1JY82We6AevgaeIfYeDO9A2Sz9DJDui1VOtGnN9vNlZfsNBSHYxi18lOcF3AzjD2Fs2n2K
	jWr+3N0v9rCWV1/BhckMvd/a2yWinbRiykUF51fT0XbQ320mp0=
X-Received: by 2002:a05:6830:6a96:b0:7d7:fb03:f6ba with SMTP id 46e09a7af769-7e70ca51cc9mr13515124a34.21.1781015900257;
        Tue, 09 Jun 2026 07:38:20 -0700 (PDT)
X-Received: by 2002:a05:6830:6a96:b0:7d7:fb03:f6ba with SMTP id
 46e09a7af769-7e70ca51cc9mr13515095a34.21.1781015899753; Tue, 09 Jun 2026
 07:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com> <20260608185646.4085127-4-zhipingz@meta.com>
 <40243782-e4ff-435c-ae40-3ac1c7c4815e@amd.com>
In-Reply-To: <40243782-e4ff-435c-ae40-3ac1c7c4815e@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 07:38:07 -0700
X-Gm-Features: AVVi8CfGCq2wYUK9zUjDs8_E_dqHl5wHKtBE7B2eSNCP9pHNCaJrScoAmctUT8I
Message-ID: <CAH3zFs1eE2VrxOZA9FoowJ9AKeBkdZE5P6t1cH0bxXq0iY6AhA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] dma-buf: add optional get_tph() callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: Sy_yDtlbAYp_dzMwAV4J7-hD-j0gGi8e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzOSBTYWx0ZWRfX4+FHmcj6SeBg
 qM43NlavNE1UCZC146nO++2jtmpp1JUMC6xQtovroo4miCvzFRo+kh5mzUDySEX22fgMykrHmhi
 P2WJFmr11VssT/dA3swiBXaWujaJtqVidsoO7PPblhT1Yq/4Tle9UHp00t0CyM/3JiN269PiFRk
 LF1/KbnBRSGXESC3K9Ub/NfcrWGdKsWpMeKrGSx9i9KghbPUzWoitdwvHr0xG61uzpCpYnpFg2Y
 6B0bKJfrbHSHVALJWazWNbCpIpemLCabdd6QG6+3QzS/VfLuhc3DkPqfvawiNjeE/JoVxdeTpdF
 eycJmelZGLR4Jko4u8srF9qndGU0Eg9lVjT6Lhhb/uQr171y0Matc8jFs3wrDM+XdHFBp2VcvBT
 5dNABAzxBbS3oREAoA9wo8v0AEdnYjDPtpgAiWNHztZOO4rIj484ZLroduwscMQt7xZfJZn3/mX
 A1qP32jbklnjruv8q3A==
X-Proofpoint-GUID: Sy_yDtlbAYp_dzMwAV4J7-hD-j0gGi8e
X-Authority-Analysis: v=2.4 cv=ZKLnX37b c=1 sm=1 tr=0 ts=6a28255d cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=KaHoPmoT-FsTecDK8CMA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297086-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christian.koenig@amd.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,meta.com:dkim,meta.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2E4B661627

> >  include/linux/dma-buf.h | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..8437dbe4a83e 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,37 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @extended: false to request the 8-bit ST namespace, true to request
> > +      *            the 16-bit Extended ST namespace
> > +      * @steering_tag: Returns the raw TPH steering tag for the requested
> > +      *                namespace
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      *
> > +      * Return the TPH (TLP Processing Hints) metadata associated with this
> > +      * DMA buffer for the requested steering-tag namespace. 8-bit ST and
> > +      * 16-bit Extended ST are distinct namespaces in the PCIe TPH ST table
> > +      * and may both be present with different values, so the exporter must
> > +      * select the value that matches @extended and must not substitute one
> > +      * for the other.
> > +      *
> > +      * The exporter owns the completing address space for @dmabuf and
> > +      * therefore decides whether it can derive meaningful TPH metadata for
> > +      * that completer. The dma-buf core treats the returned ST/PH tuple as
> > +      * opaque transport metadata; importers that support TPH place it on
> > +      * outbound TLPs, while exporters that cannot derive a useful tuple
> > +      * simply return -EOPNOTSUPP.
> > +      *
> > +      * Return 0 on success, or -EOPNOTSUPP if no metadata is available for
> > +      * the requested namespace.
> > +      *
> > +      * This callback is optional.
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, bool extended,
> > +                    u16 *steering_tag, u8 *ph);
> > +
>
> That needs a wrapper for importers to call which also handles if the callback isn't present.
>
> Regards,
> Christian.
>
agreed, will use a wrapper in next revision.

Thanks,
Zhiping

