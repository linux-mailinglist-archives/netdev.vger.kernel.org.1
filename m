Return-Path: <netdev+bounces-29487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC79783714
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 02:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBA7280FB5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 00:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84FEEA5;
	Tue, 22 Aug 2023 00:38:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B2195
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 00:38:52 +0000 (UTC)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB61183
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:38:47 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7a01d654111so1286266241.0
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692664726; x=1693269526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Eb2VmWOcd2EXNsdTGvQ7S1Za5I/CfmSMaUfHYEq4Iw=;
        b=K+XzC8HSHLkVUtd47d6DZzdo4Nvqu62D/90zwB18ykfkup6G286ETjeX3ZAcVEvKCo
         sX6rVX0nLbuqdK6UQjDJ90MGOb4JG3Njavs7yUSShDh5cccrHmcOiorJhsYybTjbNBM/
         ZjGzEIQi8F+N2GvAUVV240y6HLIZRUah5SktIPbSnJoLK42cPiJzy718wlCF0gxW/Qnx
         puqZJC1CRw/90epb8gy3AKf96HUibSOuSj4eS/+yiH62t7+hxGO2qMxZ5IZ16nIc3JlO
         CDBNgXMbC9/TPYrhK5SKvY51lMusi17K5m0UbEUA2SxoFScyIJDUb30i0Tz/7AV83t17
         1DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692664726; x=1693269526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Eb2VmWOcd2EXNsdTGvQ7S1Za5I/CfmSMaUfHYEq4Iw=;
        b=Q9FzjWWTgO8ldiMAn5w6hFefOwbMAQImEyJTS+TMgoRJ+oGB6TA2jMbnhiQAzaFDtw
         YJdh6fWgDNWbqs0UgB7ey7yeFcTTmhWlbvbn4iWGM8WkWOvUjKBR5AkbQhPmOYJMNPPz
         QZvCEdkDvzi5Y98vwnIpBtLmqEAj3JP2w32fcO0LDT74RqEdZ4X/ykZGZlEwglGSk7Tw
         fwmFLAaQUuzyUekN/SBQhohkK9ijZfoR0jEpmfAPqw6hwQoAh5P7aCN+cX8AKFKEzg/n
         3I+KiPNgJjHCVdq+LmbDg9xS0CX4a2YmSEN0lSMGgV4v70hM2wSeMxSg4DdPEYHPkKSi
         sqDg==
X-Gm-Message-State: AOJu0YyY04MuZ7N3ZajiBnCpZTflG1GTsWeoAG13mWdvlhEsLX2AQDRc
	1BiQwtB3Dp6Asnuw8qciUcrmdLcLLJEt+WyaWSKALt+22Wk=
X-Google-Smtp-Source: AGHT+IHgKrq01E4sokw+JeA4jK2rnY1Tqamotv7zHsYAavOJjwo4xb/sbyuwBKbm0gWMl9D4GMDSX8H9BGeVIuHmcWc=
X-Received: by 2002:a05:6122:3116:b0:48d:1c55:f754 with SMTP id
 cg22-20020a056122311600b0048d1c55f754mr4841468vkb.9.1692664726380; Mon, 21
 Aug 2023 17:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810015751.3297321-1-almasrymina@google.com>
 <20230810015751.3297321-3-almasrymina@google.com> <7dd4f5b0-0edf-391b-c8b4-3fa82046ab7c@kernel.org>
 <20230815171638.4c057dcd@kernel.org> <64dcf5834c4c8_23f1f8294fa@willemb.c.googlers.com.notmuch>
 <c47219db-abf9-8a5c-9b26-61f65ae4dd26@kernel.org> <20230817190957.571ab350@kernel.org>
 <CAHS8izN26snAvM5DsGj+bhCUDjtAxCA7anAkO7Gm6JQf=w-CjA@mail.gmail.com>
 <7cac1a2d-6184-7cd6-116c-e2d80c502db5@kernel.org> <20230818190653.78ca6e5a@kernel.org>
 <38a06656-b6bf-e6b7-48a1-c489d2d76db8@kernel.org> <CAF=yD-KgNDzv3-MhOMOTe2bTw4T73t-M7D65MpeG6vDBqHzrtA@mail.gmail.com>
 <20230821141659.5f0b71f7@kernel.org>
In-Reply-To: <20230821141659.5f0b71f7@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 21 Aug 2023 20:38:09 -0400
Message-ID: <CAF=yD-J5RR9w6=DzxaGT=CeKBWZEiiR3ehAkuNeJvOe3DvMH2g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, sdf@google.com, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 5:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 19 Aug 2023 10:18:57 -0400 Willem de Bruijn wrote:
> > Right. Many devices only allow bringing all queues down at the same tim=
e.
> >
> > Once a descriptor is posted and the ring head is written, there is no
> > way to retract that. Since waiting for the device to catch up is not
> > acceptable, the only option is to bring down the queue, right? Which
> > will imply bringing down the entire device on many devices. Not ideal,
> > but acceptable short term, imho.
> >
> > That may be an incentive for vendors to support per-queue
> > start/stop/alloc/free. Maybe the ones that support RDMA already do?
>
> Are you talking about HW devices, or virt? I thought most HW made
> in the last 10 years should be able to take down individual queues :o

That's great. This is currently mostly encapsulated device-wide behind
ndo_close, with code looping over all rx rings, say.

Taking a look at one driver, bnxt, it indeed has a per-ring
communication exchange with the device, in hwrm_ring_free_send_msg
("/* Flush rings and disable interrupts */"), which is called before
the other normal steps: napi disable, dma unmap, posted mem free,
irq_release, napi delete and ring mem free.

This is what you meant? The issue I was unsure of was quiescing the
device immediately, i.e., that hwrm_ring_free_send_msg.

I guess this means that this could all be structured on a per-queue
basis rather than from ndo_close. Would be a significant change to
many drivers, I'd imagine.

