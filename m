Return-Path: <netdev+bounces-33359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B0179D8AD
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3731C21052
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3FECC;
	Tue, 12 Sep 2023 18:31:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FB9A957
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 18:31:52 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1108189
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:31:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad8d0be93aso29115866b.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694543510; x=1695148310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgXwpENACfjir3blDXw2c+FcmWuRsuHOwCw+L/su/zs=;
        b=YCdog3xDynanRZWqCIWgUYGj/Fag8yrjd/NA1u6dZ1SZDjoJvLIP+OenYsPXoaSoeD
         4IRhyqdn+MRNgoolRSmTzV3UnimYO46XwOvYB+cHAYaKiODUlgAeWgb7Ffoeb7hY3OBY
         Ms+uJq2eeROppPosA6uQ/x9c+sRMV04/5sHH6WCvCF1i7/QnMFfW4MbB4kcv46omsm71
         NdlvFaTsyLSrAD3/rDvD7O5ymqX4gQEsIb/jLlLTLalOMgiPl0QNPPRK2Cc8LMJUZmE6
         LP2MvOgVBCgFp1PCguEyIm247nIHdRim5tr9UydtNJsT99VPrwC5STKVPmdemHDX7xmS
         B0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694543510; x=1695148310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgXwpENACfjir3blDXw2c+FcmWuRsuHOwCw+L/su/zs=;
        b=lU4Ruemw2qeUJL2KGmKc28slHqsi5fC0mKmJ+t2DBQXvsBypWupQNoSouVSZqOOaPR
         mb0RbncFWxKlJaUF7O5hBlSbUTgmDkjmQorauNtXS6buQsGxs6wfwnj+JtsTX6L/DHSL
         nAWW2DRtKCHPPY/vbwsDWUAtCnBKdSFKs1GlyQFvyWE2drPKqkTDEEuZPyE/RowrmmGs
         cIvsgyA6ZG8EW00VhAo6uSYZpdAHZOpKwaGKTi3/2v/t7bVQAX4/s5/KcBkQwTGM3Csh
         KXJj1BFIO7LRjWSBE0fvdUcl0pW1ym5q+kTTiWf6dHQAt02Axz295r7ZxiKler4vbflA
         wBIQ==
X-Gm-Message-State: AOJu0Yw4UBeLrHXCrH4AtU0dyEEKc2XZU/2WmngRAIYCUdd5o/PNemcT
	0E4SqflpXxI4Bz0+H8HeMUe7+GPELYEIJmHwKxZ6Ew==
X-Google-Smtp-Source: AGHT+IF12p0bwUdxypLQtlRjoaOqldYCb/BKFcyesXVCeDweunMQey7DP3eyRJGJDyk7sB/pv9Pjck8zT6t5/r/ppg8=
X-Received: by 2002:a17:907:2ceb:b0:9a5:d2f5:c76 with SMTP id
 hz11-20020a1709072ceb00b009a5d2f50c76mr696667ejc.5.1694543510163; Tue, 12 Sep
 2023 11:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912013332.2048422-1-jrife@google.com> <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
 <1ca3ca8a-6185-bc55-de74-53991ffc6f91@iogearbox.net>
In-Reply-To: <1ca3ca8a-6185-bc55-de74-53991ffc6f91@iogearbox.net>
From: Jordan Rife <jrife@google.com>
Date: Tue, 12 Sep 2023 11:31:38 -0700
Message-ID: <CADKFtnTOD2+7B5tH8YMHEnxubiG+Cs+t8EhTft+q51YwxjW9xw@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> These should probably call kernel_connect instead.
> Similarly, this could call kernel_sendmsg, and the extra copy handled in =
that wrapper.

I was considering this approach initially, but one concern I had was
that there are other instances I see of modules calling ops->connect()
directly (bypassing kernel_connect()):

- net/netfilter/ipvs/ip_vs_sync.c: make_send_sock()
- drivers/block/drbd/drbd_receiver.c: drbd_try_connect()
- drivers/infiniband/hw/erdma/erdma_cm.c: kernel_bindconnect()
- drivers/infiniband/sw/siw/siw_cm.c: kernel_bindconnect()
- fs/ocfs2/cluster/tcp.c: o2net_start_connect()
- net/rds/tcp_connect.c: rds_tcp_conn_path_connect()

and ops->sendmsg():

- net/smc/af_smc.c: smc_sendmsg()
- drivers/vhost/net.c: vhost_tx_batch(), handle_tx_copy(), handle_tx_zeroco=
py()
- drivers/target/iscsi/iscsi_target_util.c: iscsit_fe_sendpage_sg()

which (at least in theory) leaves them open to the same problem I'm
seeing with NFS/SMB right now. I worry that even if all these
instances were swapped out with kernel_sendmsg() and kernel_connect(),
it would turn into a game of whac-a-mole in the future as new changes
or new modules may reintroduce direct calls to sock->ops->connect() or
sock->ops->sendmsg().

-Jordan



On Tue, Sep 12, 2023 at 7:22=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 9/12/23 3:33 PM, Willem de Bruijn wrote:
> > Jordan Rife wrote:
> >> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
> >> ensured that kernel_connect() will not overwrite the address parameter
> >> in cases where BPF connect hooks perform an address rewrite. However,
> >> there remain other cases where BPF hooks can overwrite an address held
> >> by a kernel client.
> >>
> >> =3D=3DScenarios Tested=3D=3D
> >>
> >> * Code in the SMB and Ceph modules calls sock->ops->connect() directly=
,
> >>    allowing the address overwrite to occur. In the case of SMB, this c=
an
> >>    lead to broken mounts.
> >
> > These should probably call kernel_connect instead.
> >
> >> * NFS v3 mounts with proto=3Dudp call sock_sendmsg() for each RPC call=
,
> >>    passing a pointer to the mount address in msg->msg_name which is
> >>    later overwritten by a BPF sendmsg hook. This can lead to broken NF=
S
> >>    mounts.
> >
> > Similarly, this could call kernel_sendmsg, and the extra copy handled
> > in that wrapper. The arguments are not exacty the same, so not 100%
> > this is feasible.
> >
> > But it's preferable if in-kernel callers use the kernel_.. API rather
> > than bypass it. Exactly for issues like the one you report.
>
> Fully agree, if it's feasible it would be better to convert them over to
> in-kernel API.
>
> >> In order to more comprehensively fix this class of problems, this patc=
h
> >> pushes the address copy deeper into the stack and introduces an addres=
s
> >> copy to both udp_sendmsg() and udpv6_sendmsg() to insulate all callers
> >> from address rewrites.
> >>
> >> Signed-off-by: Jordan Rife <jrife@google.com>

