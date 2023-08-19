Return-Path: <netdev+bounces-29104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B77819F2
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A90281AF0
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 14:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9A6AB7;
	Sat, 19 Aug 2023 14:19:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD64C8D
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 14:19:59 +0000 (UTC)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F01B93FA
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 07:19:35 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-48d0b7ef29eso38464e0c.1
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692454774; x=1693059574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjOVC9IkT0MB1FDxlPUtjBJdqgqvAfiP6j2YnGrdafU=;
        b=VFk4ZKV2Lz6aRQlmTNeOhUx1ebG2gA9jDGBWMzvWpJeipAtY9itIScmB4UqNfn6xkD
         lVW2EaYU4ozDW2XwZ2t6vuII7HzGqHJhHmEyCqfeCniUg0iH25Fkm1pW0v6mwi5I2odl
         JvY2dnpjedOnpS/rnYc6vK/p46UaOpb1FkhXgIbQGs5bezCePknq8V2O9bILg2vC60zL
         Nq2fJl0OXMFiWqtOJV1El2CuDF1JnUvFfS6o+irOMuo91Y5yXJ1nF4xM06wI8A41GLhp
         zpSndDisNxBU2qy63hrMeeMz536mOCsVvW4P6xZ/NkRaacsMH12uTgN22fOlu3j3cmgx
         TE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692454774; x=1693059574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjOVC9IkT0MB1FDxlPUtjBJdqgqvAfiP6j2YnGrdafU=;
        b=Crneu5dtMBX00uZ5c816tB0hAMrbSrfMCZqoD9roMhF3s4fLGzCp0cjvh5jFxH9DSp
         WFbQ5kW1l/g3NrsXIrru4wd96ua3TM+l+Sp8C9bsMd+8qAkzCbGzjza5JySth9nMRWLn
         whatzsoWx1JCdOWnUWyboml5BleL06ATupAzpxnfGkn7qPoYJRc8hQ1rlaw1nGlQH3aE
         XxiRkUAL72ee3f85rkdwMzWH2AlHUTiextPU8PFcIBsxjn+YoO4Y81xUMB8+FTVAsxez
         jiPNDbn+0gBvIOb3UOEVVsGkv7sycR5u4s23cjD3ccFHZfN5ODDgPOzI2F+ZRmsdFmE0
         cy0Q==
X-Gm-Message-State: AOJu0Yya+ByMB5Ke0VhIG6yl017hO/lHLsBwfKyGqhW8jvch2S8T9Jv3
	H00iBQqYJDC3IyC/OSpIdZYosHXf1EBMO6yXl30=
X-Google-Smtp-Source: AGHT+IHq5uFyi15xGa7ufRt534sj7o6etpua9/f+5hI3qu06ovMkH26mwkNMAXmIzgr61oq0vAewrnigy/Lr4LqNi8M=
X-Received: by 2002:a67:fe0e:0:b0:447:6596:11d2 with SMTP id
 l14-20020a67fe0e000000b00447659611d2mr1011573vsr.23.1692454774241; Sat, 19
 Aug 2023 07:19:34 -0700 (PDT)
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
 <38a06656-b6bf-e6b7-48a1-c489d2d76db8@kernel.org>
In-Reply-To: <38a06656-b6bf-e6b7-48a1-c489d2d76db8@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sat, 19 Aug 2023 10:18:57 -0400
Message-ID: <CAF=yD-KgNDzv3-MhOMOTe2bTw4T73t-M7D65MpeG6vDBqHzrtA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/11] netdev: implement netlink api to bind
 dma-buf to netdevice
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>, 
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

On Fri, Aug 18, 2023 at 11:30=E2=80=AFPM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 8/18/23 8:06 PM, Jakub Kicinski wrote:
> > On Fri, 18 Aug 2023 19:34:32 -0600 David Ahern wrote:
> >> On 8/18/23 3:52 PM, Mina Almasry wrote:
> >>> The sticking points are:
> >>> 1. From David: this proposal doesn't give an application the ability
> >>> to flush an rx queue, which means that we have to rely on a driver
> >>> reset that affects all queues to refill the rx queue buffers.
> >>
> >> Generically, the design needs to be able to flush (or invalidate) all
> >> references to the dma-buf once the process no longer "owns" it.
> >
> > Are we talking about the ability for the app to flush the queue
> > when it wants to (do no idea what)? Or auto-flush when app crashes?
>
> If a buffer reference can be invalidated such that a posted buffer is
> ignored by H/W, then no flush is needed per se. Either way the key point
> is that posted buffers can no longer be filled by H/W once a process no
> longer owns the dma-buf reference. I believe the actual mechanism here
> will vary by H/W.

Right. Many devices only allow bringing all queues down at the same time.

Once a descriptor is posted and the ring head is written, there is no
way to retract that. Since waiting for the device to catch up is not
acceptable, the only option is to bring down the queue, right? Which
will imply bringing down the entire device on many devices. Not ideal,
but acceptable short term, imho.

That may be an incentive for vendors to support per-queue
start/stop/alloc/free. Maybe the ones that support RDMA already do?

