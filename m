Return-Path: <netdev+bounces-47380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1977E9E3A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 15:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E531F21582
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A081520B2E;
	Mon, 13 Nov 2023 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jysqQTd7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4222031B
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 14:11:01 +0000 (UTC)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C85D5F
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 06:10:59 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4ac45927974so1995431e0c.3
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699884659; x=1700489459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgkwJXX1qr+S09dQpN5T+X4NS0++EZQcUD0oK4877bg=;
        b=jysqQTd77H8Mz5A3urAz4uIuRBHIFgfkGGBqjNXOBwLWCp9tbaFaZwPrAQp9lPv6Sf
         mqciOpBGTwwWj2uwzxGMuR5jgVl/oXORSFMR3Kw5j3rz0BO8qPFeSYRC8eHtn2lzDeaP
         7xln1IMe7fIwcRVPWr/hk1VzTTmkv5w+G3veJGOxgeq+DhEXzAfLZTV1SuuxWu1t6pGJ
         Idl02qRa55UuDOgbjNCptxyAieeAceL3tYrZluvhOysAkjNOY07y4QVBW2Gvka6ZHk1+
         3Gucw+/YqMRplw0j4phItqTTlc/qLXPb6dMjjFWx5NBrB7j7dBg+UbxzzjchtS4TLEYc
         JZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699884659; x=1700489459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgkwJXX1qr+S09dQpN5T+X4NS0++EZQcUD0oK4877bg=;
        b=EXeKZDLsMWIy8f/8MCwC2dLpV9z02IRoqmB6nvUgqMRLvUike9BR0Trqpl42dM9WYs
         56E7WGr9WMw27JT1s6O517Pt5A0L6SpgkPMZrooMvnjMPzwc3bfzEbgSsPGEsSywJpwG
         Ih9yOiEjX8rniMb8MKh00WPVJVnlgii5/HUGC3d+DtK/1yUJxOl+aj5QljQfnIQGRHYQ
         MjTBINeI1rgyQ0XzfCD+FbV4PXq1xUMN1Ldv2Komjaom6D+Bp80lpk/CVg1LCdVke7cJ
         ttYLKO3TE7ZLZTyyU5T3JMF4MfYrrl6EwVjo4sFvLoZIh7g/1SqLqI3yPjUW/bo6znBx
         fQmA==
X-Gm-Message-State: AOJu0YzG5eb4+KFqH21+7y1zH6Bys2fyvd8zG8QxDzKUheja2PTgdS4m
	CVugl4fjLK6Nw3D0+lDO7C7Rt82n77FDCZsJr+nGyQ==
X-Google-Smtp-Source: AGHT+IHgD3MMK0xSpB/Hu+wLHSaaGcEt7m/hhwjZNbiyq/jI6uWj3tZuNrmn4WrE9GCMj2OQ+APvCxx1bgD0YN4+nrI=
X-Received: by 2002:a05:6122:180d:b0:49b:289a:cc4a with SMTP id
 ay13-20020a056122180d00b0049b289acc4amr6877585vkb.3.1699884658679; Mon, 13
 Nov 2023 06:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com> <20231102225837.1141915-3-sdf@google.com>
 <c9bfe356-1942-4e49-b025-115faeec39dd@kernel.org>
In-Reply-To: <c9bfe356-1942-4e49-b025-115faeec39dd@kernel.org>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 13 Nov 2023 06:10:45 -0800
Message-ID: <CAKH8qBtiv8ArtbbMW9+c75y+NfkX-Tk-rcPuHBVdKDMmmFdtdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 02/13] xsk: Add TX timestamp and TX checksum
 offload support
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 5:16=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 11/2/23 23:58, Stanislav Fomichev wrote:
> > diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> > index 2ecf79282c26..b0ee7ad19b51 100644
> > --- a/include/uapi/linux/if_xdp.h
> > +++ b/include/uapi/linux/if_xdp.h
> > @@ -106,6 +106,41 @@ struct xdp_options {
> >   #define XSK_UNALIGNED_BUF_ADDR_MASK \
> >       ((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
> >
> > +/* Request transmit timestamp. Upon completion, put it into tx_timesta=
mp
> > + * field of struct xsk_tx_metadata.
> > + */
> > +#define XDP_TXMD_FLAGS_TIMESTAMP             (1 << 0)
> > +
> > +/* Request transmit checksum offload. Checksum start position and offs=
et
> > + * are communicated via csum_start and csum_offset fields of struct
> > + * xsk_tx_metadata.
> > + */
> > +#define XDP_TXMD_FLAGS_CHECKSUM                      (1 << 1)
> > +
> > +/* AF_XDP offloads request. 'request' union member is consumed by the =
driver
> > + * when the packet is being transmitted. 'completion' union member is
> > + * filled by the driver when the transmit completion arrives.
> > + */
> > +struct xsk_tx_metadata {
> > +     union {
> > +             struct {
> > +                     __u32 flags;
> > +
> > +                     /* XDP_TXMD_FLAGS_CHECKSUM */
> > +
> > +                     /* Offset from desc->addr where checksumming shou=
ld start. */
> > +                     __u16 csum_start;
> > +                     /* Offset from csum_start where checksum should b=
e stored. */
> > +                     __u16 csum_offset;
> > +             } request;
> > +
> > +             struct {
> > +                     /* XDP_TXMD_FLAGS_TIMESTAMP */
> > +                     __u64 tx_timestamp;
> > +             } completion;
> > +     };
> > +};
>
> This looks wrong to me. It looks like member @flags is not avail at
> completion time.  At completion time, I assume we also want to know if
> someone requested to get the timestamp for this packet (else we could
> read garbage).

I've moved the parts that are preserved across tx and tx completion
into xsk_tx_metadata_compl.
This is to address Magnus/Maciej feedback where userspace might race
with the kernel.
See: https://lore.kernel.org/bpf/ZNoJenzKXW5QSR3E@boxer/

> Another thing (I've raised this before): It would be really practical to
> store an u64 opaque value at TX and then read it at Completion time.
> One use-case is a forwarding application storing HW RX-time and
> comparing this to TX completion time to deduce the time spend processing
> the packet.

This can be another member, right? But note that extending
xsk_tx_metadata_compl might be a bit complicated because drivers have
to carry this info somewhere. So we have to balance the amount of
passed data between the tx and the completion.

