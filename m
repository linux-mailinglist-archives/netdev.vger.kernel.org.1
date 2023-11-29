Return-Path: <netdev+bounces-52175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C22D7FDBAF
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0532CB20BF4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6386F38F87;
	Wed, 29 Nov 2023 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgeUQPKf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B167D46
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:40:11 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so14590a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701272409; x=1701877209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxYkHtdOX9fFahgNSjqo5pa5Ie1lUIySBQE6LUNOuh0=;
        b=MgeUQPKfARn/dEYXe8Ek2e0zwAOxNkUZlimZiEa5p3ad0AYDcUM41jGcgFxr02nwjK
         cBHR2cMrEeOZHC1Ba0ncURhnCYgI5RFsl5eoxPSnxXEJDmoAg4R/roi3nPYx7yXC4UsU
         D/j9jy/fmTSa0PAfbMRddy9/znaJ5BC9+0Bwtbi0sne0h7/8gE0cjZ9yg3QU/MbJoncS
         5u+OSTlxQB98zux7YGDcf6uNH00mc1CkZysw5aWPqe4JoGQ6mOkOTW25uo57MgjS1GRS
         n9brqSBrufquZiD4p1bXUwp5fV7PCJOBJP3tflmMG8DEPUDdDbVeOaxYXcE6uoFL30MT
         9ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272409; x=1701877209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxYkHtdOX9fFahgNSjqo5pa5Ie1lUIySBQE6LUNOuh0=;
        b=EhsyKpAfOcra1b6Rgutf4yOwOvECqtWMXrgOLtDNWZMvTpxYnof6rZ0aWOeIKE2RYN
         s+/jA3GmFt+tJZMMYU92+Se0Yy9/RJcSIRNtZ6cQh5MFGm8LP9dMuF9RsOeE0Hl4+mWd
         0ZGgOPqkZVUCvK+3DGSrF50ccn9b58OZNJnSRGLgqf9zBHhJR6xEvTcctsbu7DWWprZt
         qRYoAujL/JVS+PVSrCRMld9GTEWPqmDWQT/SXbiRtwh6oulIpCFkrJ0+9S5QWAF35mET
         nZhMV01MzR9KqpadMvZVDlbEroE6MoL67oZ5QiLDrHgcyf9ZeECQOHdJi+ZSZAdreZAM
         K54Q==
X-Gm-Message-State: AOJu0YyWY67sp921lT6sGxDfZJSS80FPb93gNKwGlKoa/+POKlv5+03V
	hN1CpKxRigIS0R+rm9N445ArdzpZbaAUSuTnVYwNH3r15s7P5afRXfCaTw==
X-Google-Smtp-Source: AGHT+IHuH7+KTMO9L/OlASjqCcltc5evQDZYuFDe7Tynhb2MXpbgjwmoSSJhcu6ofWowwdkr4exDrTB0Tm86KU0it0o=
X-Received: by 2002:aa7:d983:0:b0:54b:8f42:e3dc with SMTP id
 u3-20020aa7d983000000b0054b8f42e3dcmr434550eds.2.1701272409267; Wed, 29 Nov
 2023 07:40:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bfb52b5103de808cda022e2d16bac6cf3ef747d6.1700780828.git.gnault@redhat.com>
 <CANn89i+sqG+T7LNxXhB-KHM-c7DU2v__vEbiV1_DJV7tkuEaGg@mail.gmail.com> <ZWZnQL1tnjJ9R8Er@debian>
In-Reply-To: <ZWZnQL1tnjJ9R8Er@debian>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2023 16:39:55 +0100
Message-ID: <CANn89iLYsaZ+uDJA_4M-46XS0fbp0foiumhMdjtfw-Jg9bNq+w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Dump bound-only sockets in inet_diag.
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 11:18=E2=80=AFPM Guillaume Nault <gnault@redhat.com=
> wrote:
>
> On Tue, Nov 28, 2023 at 11:14:28AM +0100, Eric Dumazet wrote:
> > On Fri, Nov 24, 2023 at 12:11=E2=80=AFAM Guillaume Nault <gnault@redhat=
.com> wrote:
> > >
> > > Walk the hashinfo->bhash2 table so that inet_diag can dump TCP socket=
s
> > > that are bound but haven't yet called connect() or listen().
> > >
> > > This allows ss to dump bound-only TCP sockets, together with listenin=
g
> > > sockets (as there's no specific state for bound-only sockets). This i=
s
> > > similar to the UDP behaviour for which bound-only sockets are already
> > > dumped by ss -lu.
> > >
> > > The code is inspired by the ->lhash2 loop. However there's no manual
> > > test of the source port, since this kind of filtering is already
> > > handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumpe=
d
> > > at a time, to avoid running with bh disabled for too long.
> > >
> > > No change is needed for ss. With an IPv4, an IPv6 and an IPv6-only
> > > socket, bound respectively to 40000, 64000, 60000, the result is:
> > >
> > >   $ ss -lt
> > >   State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess
> > >   UNCONN 0      0            0.0.0.0:40000      0.0.0.0:*
> > >   UNCONN 0      0               [::]:60000         [::]:*
> > >   UNCONN 0      0                  *:64000            *:*
> >
> >
> > Hmm...   "ss -l" is supposed to only list listening sockets.
> >
> > So this change might confuse some users ?
> >
>
> On the other hand I can't find a more sensible solution. The problem is
> that "ss -l" sets both the TCPF_LISTEN and the TCPF_CLOSE flags. And
> since we don't have a way to express "bound but not yet listening"
> sockets, these sockets fall into the CLOSE category. So we're really
> just returning what ss asked for.
>
> If we can't rely on TCPF_CLOSE, then I don't see what kind of filter we
> could use to request a dump of these TCP sockets. Using "-a" doesn't
> help as it just sets all the TCPF_* flags (appart from
> TCPF_NEW_SYN_RECV). Adding a new option wouldn't help either as we
> couldn't map it to any of the TCPF_* flags. In any case, we still need
> to rely on TCPF_CLOSE.
>
> So maybe we can just improve the ss man page for "-l" and explain that
> it also lists closed sockets, which includes the bound-only ones
> (this is already true for non-TCP sockets anyway). We could also tell
> the user to run "ss state listening" for getting listening sockets
> exclusively (or we could implement a new option, like "-L", to make
> that shorter if necessary).

This exists already : ss -t state LISTENING

>
> What do you think?
>

We might need a new bit in r->idiag_state (we have a lot of free bits
there), different from
the combination used by "ss -l"  which unfortunately used ( (1 <<
SS_LISTEN) | (1 << SS_CLOSE) ) )

"ss -t state bound" (or ss -tB ???)  would then set this new bit ( 1
<< SS_BOUND) and the kernel would handle this pseudo state ?

(mapped to CLOSED and in bhash2)


diff --git a/include/net/tcp_states.h b/include/net/tcp_states.h
index cc00118acca1b695a534bd73984b9d1f1794db25..97238c0f64aa6643cf492a856e8=
d67ddcca1a729
100644
--- a/include/net/tcp_states.h
+++ b/include/net/tcp_states.h
@@ -22,6 +22,7 @@ enum {
        TCP_LISTEN,
        TCP_CLOSING,    /* Now a valid state */
        TCP_NEW_SYN_RECV,
+       TCP_BOUND,

        TCP_MAX_STATES  /* Leave at the end! */
 };
@@ -43,6 +44,7 @@ enum {
        TCPF_LISTEN      =3D (1 << TCP_LISTEN),
        TCPF_CLOSING     =3D (1 << TCP_CLOSING),
        TCPF_NEW_SYN_RECV =3D (1 << TCP_NEW_SYN_RECV),
+       TCPF_BOUND       =3D (1 << TCP_BOUND),
 };

 #endif /* _LINUX_TCP_STATES_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a62423360a5681525496f8840bfe1d37ea3dc504..c3d22edb9e95636723567501531=
67884c92eae67
100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6570,6 +6570,7 @@ enum {
        BPF_TCP_LISTEN,
        BPF_TCP_CLOSING,        /* Now a valid state */
        BPF_TCP_NEW_SYN_RECV,
+       BPF_TCP_BOUND,

        BPF_TCP_MAX_STATES      /* Leave at the end! */
 };

