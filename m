Return-Path: <netdev+bounces-46451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7537E437B
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 16:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A7CB20C4C
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD763159B;
	Tue,  7 Nov 2023 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rkt6p8Gy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115FAD52
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 15:31:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AEA3589
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 07:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699371086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7AEBVghQW447KZQKO5L8SRKW+vAc5UygEoFswNXMXA=;
	b=Rkt6p8GyzG/MhDV7zqCfhlR7/YLTlYwpaCTnQNLcvl168hGb9JKyJeEJAABhOoa/Ry6RR9
	gyNS50ICW/2LykL9E3dBCRRFlkR9DaTR298zx5noQU+E0xGIOx51fsaDu5ObfkakUn3oZH
	prfZC18h3C5lyFhG58nHwsoh4bSa9nk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-pjpoIfsYNKGGWityzb6hEA-1; Tue, 07 Nov 2023 10:31:24 -0500
X-MC-Unique: pjpoIfsYNKGGWityzb6hEA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9cf3fad5baeso417192366b.3
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 07:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699371083; x=1699975883;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f7AEBVghQW447KZQKO5L8SRKW+vAc5UygEoFswNXMXA=;
        b=WbwDvZ2pszQxpnGinh0+8KmpttJqudLu+Hbk2qL5fWqOuIl8PD+WtckMUVt0c61/sq
         DDANPyxyrFENvCgJ3+4/iB1UsnX9Qhs0A9IFro+/x4fg8/fJPijhZ8UHxYRCakZWojlB
         09WuZ6/jqqcRGXosv17MeKztf3vRYNNO/oolkeHIBEiAzqgt3QDyy/NI0dvDJMngorZy
         QTqKWyfC9VvFNy2DB88EiBqNWWuowPqIhptX5bKSWvxFsIYkxNS7FXBKuhAdt4c717QT
         MGSmq0jvJNgETeL8ZFRnvx1TppD8UazI1lFGkMu12z0vBcn5zy8ylfeUEcq/5vNVOvn9
         t62A==
X-Gm-Message-State: AOJu0YwybRJIxaH2QOYDpMkaDsh0BsKWy+sgiaeatxw1tOUEX3bZTuv2
	wCGm/fcYVBG7foBUh/hWO/ze+EladI6VUcLlJpo7Ka+5dwl4gTJXnmPJiM75Rl11hakXRNvl4Mu
	R+DFgJY1Zv7VrpMs2
X-Received: by 2002:a17:907:845:b0:9d3:608d:cdf6 with SMTP id ww5-20020a170907084500b009d3608dcdf6mr16431426ejb.19.1699371082749;
        Tue, 07 Nov 2023 07:31:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzsYnkK38UDeIKBZ889ENeSWldS+qH42DHXAMdFwo25beCAbY5ow+9LOMNJV0L2bxReSI6yQ==
X-Received: by 2002:a17:907:845:b0:9d3:608d:cdf6 with SMTP id ww5-20020a170907084500b009d3608dcdf6mr16431397ejb.19.1699371082370;
        Tue, 07 Nov 2023 07:31:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bx7-20020a170906a1c700b009c5c5c2c5a4sm1150061ejb.219.2023.11.07.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:31:22 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 93B01EE6C2C; Tue,  7 Nov 2023 16:31:21 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, Daniel
 Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Subject: Re: BPF/XDP: kernel panic when removing an interface that is an
 xdp_redirect target
In-Reply-To: <e3085c47-7452-4302-8401-1bda052a3714@amd.com>
References: <e3085c47-7452-4302-8401-1bda052a3714@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 07 Nov 2023 16:31:21 +0100
Message-ID: <87h6lxy3zq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Nelson, Shannon" <shannon.nelson@amd.com> writes:

> While testing new code to support XDP in the ionic driver we found that=20
> we could panic the kernel by running a bind/unbind loop on the target=20
> interface of an xdp_redirect action.  Obviously this is a stress test=20
> that is abusing the system, but it does point to a window of opportunity=
=20
> in bq_enqueue() and bq_xmit_all().  I believe that while the validity of=
=20
> the target interface has been checked in __xdp_enqueue(), the interface=20
> can be unbound by the time either bq_enqueue() or bq_xmit_all() tries to=
=20
> use the interface.  There is no locking or reference taken on the=20
> interface to hold it in place before the target=E2=80=99s ndo_xdp_xmit() =
is called.
>
> Below is a stack trace that our tester captured while running our test=20
> code on a RHEL 9.2 kernel =E2=80=93 yes, I know, unpublished driver code =
on a=20
> non-upstream kernel.  But if you look at the current upstream code in=20
> kernel/bpf/devmap.c I think you can see what we ran into.
>
> Other than telling users to not abuse the system with a bind/unbind=20
> loop, is there something we can do to limit the potential pain here?=20
> Without knowing what interfaces might be targeted by the users=E2=80=99 X=
DP=20
> programs, is there a step the originating driver can do to take=20
> precautions?  Did we simply miss a step in the driver, or is this an=20
> actual problem in the devmap code?

Sounds like a driver bug :)

The XDP redirect flow guarantees that all outstanding packets are
flushed within a single NAPI cycle, as documented here:
https://docs.kernel.org/bpf/redirect.html

So basically, the driver should be doing a two-step teardown: remove
global visibility of the resource in question, wait for all concurrent
users to finish, and *then* free the data structure. This corresponds to
the usual RCU protection: resources should be kept alive until all
concurrent RCU critical sections have exited on all CPUs. So if your
driver is removing an interface's data structure without waiting for
concurrent NAPI cycles to finish, that's a bug in the driver.

This kind of thing is what the synchronize_net() function is for; for a
usage example, see veth_napi_del_range(). My guess would be that you're
missing this as part of your driver teardown flow?

Another source of a bug like this could be that your driver does not in
fact call xdp_do_flush() before exiting its NAPI cycle, so that there
will be packets from the previous cycle in the bq queue, in which case
the assumption mentioned in the linked document obviously breaks down.
But that would also be a driver bug :)

-Toke


