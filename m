Return-Path: <netdev+bounces-307100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EZHNEaSrVGqtpAMAu9opvQ
	(envelope-from <netdev+bounces-307100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8742874925F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:10:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lQX+kF5d;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307100-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307100-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C525300B606
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9583DC87B;
	Mon, 13 Jul 2026 09:05:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219E3BED30
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:05:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933534; cv=pass; b=GBb5dwdHL/HC/0CKFXDYgs+jwYS6JN10HnHzszaa4P8YOyX/BPqor4lq8pzLWoX4CXNKz//1WKN/jsU2mt4psauLLxnEs/WuC8pxFxQVb0acNusnHYpmdWxNJKyLBF3jbaSUNd9ZQ04X/Je8/CGkSkZeQo2Qzc0pVZ0ScyIxaXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933534; c=relaxed/simple;
	bh=auMZdWe1zpPrfohK8rnEb1n2d++1ZQoEuP34TJKygyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmFHfovHk5XLpdwDFv2IfDQreyqNXlqHsX4PbwouHNrRvYVF5tVyJRYJAiIZsO4AYQvWPxyiuepKTnRaS4ll0aLv+HUNRBpdJaeXEKyaHklqEPwyiCBH6CsD8e0v5IfgSbjdFGxY53ZWOzr1WjI/aYBrlo8iOE4LUjV0BsV/vuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQX+kF5d; arc=pass smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c15a5b265so357581cf.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 02:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783933531; cv=none;
        d=google.com; s=arc-20260327;
        b=JFAar3wzbaaXF51VYMYb9LsVPjD549DZEBp8Txx7OxPCNB1BKkR0OQUv1KEGcql3O4
         rgzRD2LpajqQcea2xAMAdMjhioLwxSSh7CaCL+jPzo3dybKNbkOD2mO8c4iUEyuPtgKd
         4xPF1Pd5aI2fW0fQ9M7dCpiOEOLwu1W2ixDvVUy8INL2IV61mtWxnPF42CTz7UtiD0wJ
         OLfD605EMrYRJ3n2Cf7GrijFkLFjb6C8fhFSN6AT4COKiEvmoElXeB4Z7w7+jlOdPfux
         ckkHZFgPN2mGMdj+y6tVf218BWMK65zIAsrZGdrm6LNrW4NAjoSWFmMTuJdkXSKaDAce
         9IBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AJ5PzOhHCuJUpnI86QVi4NQ+FC15w4PgaoBYaYUGBbg=;
        fh=oe/yb0ClPAOaKd5TvCi8rVZtYYWITc6mbK5c8eEE95o=;
        b=r38bu2qazwKGWa/nVN8GSoFX8MXuR7PpMITNysLAsgmipPhUzuSeUkKZwgRCiS+541
         fQx9cJtlfbmQgyJACUCdi5ivsI0z7r7zf8BQBDt400IpVWA70d2ygNvt9dW0YGHCmwu8
         detSfENXykerB9JQ+RYO6NNst7MlZV+qmtTPOmJThSggaVX1U6ZSffaW6zkoyJKf8OaY
         MxsqyqI5hP3/pCHupAfedzZkpEmVkOWeBeTqgR5C9KFide3AOb6znQK6sp3dr1TdRZoi
         H7o1+QJ1wTvNs6rvggmPE4jT3ZoQNVS6B6IDcBgX5rinNkB2tGk2eA/DF/U5lmnRrTDI
         oQPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783933531; x=1784538331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AJ5PzOhHCuJUpnI86QVi4NQ+FC15w4PgaoBYaYUGBbg=;
        b=lQX+kF5dDd+PCBBMQFFybsW02E6QNoJ4VJT5W+Pd1zWyuOpZGvEWZZHsZRnkdPjILU
         xEpKO/VNa81lROSmONW5DdnI5lcOIDFs1ZGXsXK51ZXBd4Na3NTZN7hBWrkFkMANhANP
         XqZaiKe4ZsMQAIOFj9REQagSVznV5F/Hza750zfZtBKWZXXc3jUGND38+HKtC1FWdWFP
         1NDnx/p/yIbn6c+l9lunBSmpkuyfT4u1Qoh3ZMNjGWfMFrN8ibukgr2yBDJkH9v/6JvF
         1RD2jO1w9OXpXDC6nDzCpdd3rS8yO6al2XDlBrgeDkc8aMxCv4qRcGnocHI7FoeoO2nx
         5G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933531; x=1784538331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJ5PzOhHCuJUpnI86QVi4NQ+FC15w4PgaoBYaYUGBbg=;
        b=nHbNUz1uMe6goWMnFQaxQWuydmwGxPQE4qXh+M/C3SU0dmVYK8gQuNHfyNbC6UdRqo
         Y6R9xnnT1eDh76l4xcTKeYOxxNWFeoWJrB+22rvRT/RIBudOxH4ViyEKARHtTy8E33bC
         L4c+8aDsOvrPgVfIJS1RNCstjshYDZUC7W3w91HLL0D4avCQGpWNhkF3A6rFN3PHAiQM
         90uJ0YSXPuN8W+gz2D93KVuRY3d/Cnego+ctLF4k+JmRJoLH/m4JLSEbUyOXfZZgxGjy
         JkPJiBfOrw5jT/n1gJyIzELss4N8x1F3fEq+WGB1hZl9YFs8yVmo0MfoO0PYAk/rAqZA
         vdWw==
X-Gm-Message-State: AOJu0YyU9S6cYuLItNjR6X9lbqxhkNT6qWXNVCp7MZTFL8TKoi6mPAox
	5bUiHEcgtd2e5Q17ByMQoiIUjZGagtd3hRp0Nb/miBomykzcjzgQnvu42BO9IxCE2r6wHZ/mLKU
	C2psSQ0mwnrh/Ononkz1jYGZqP9m7VK3MgmJvnBlnPkQpoAY7WX1ap1o+QXk=
X-Gm-Gg: AfdE7cl1DKuD8hkQPOZm44Flplcg7T4LKzrT5bWUbmJDS37LB04S36/woE1oNuuyF3Q
	wtihWXAkfqP/GcDDrYWdB7riY2GL3pLTZYl0qNNJhfQ0IE139tprSdbHwXuYU0DQOD/0DlF+DBp
	7iHwHQUGAR+ORL1xT8gBaAIxJCOJybd/IIoo7D3JfAsdDOCPOFqolY8a54PmrHT2p3HFFN3erQP
	RHVaPxLl+WrNZTFWdeOLf9pmcr0AaVHRjkPAZxZynoiFWnKLRnlz9RAp+rIfad/HQCKJXT/HxY=
X-Received: by 2002:a05:622a:5598:b0:51c:7a90:a799 with SMTP id
 d75a77b69052e-51d8385acdemr597941cf.25.1783933529929; Mon, 13 Jul 2026
 02:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713081606.950892-1-maze@google.com>
In-Reply-To: <20260713081606.950892-1-maze@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Mon, 13 Jul 2026 11:05:17 +0200
X-Gm-Features: AUfX_mwpxsSzMZv_dMp_HZkiNHms7pfHKNqWVdACO4R0V0r0rgF0Pu8q5dunz3c
Message-ID: <CANP3RGfhR5F8wM1D9ek6gQVUasUNgUMpbT0rtf_dsVZrgxOMmw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] net-ipv6: ipv4 emulation support
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Fernando Fernandez Mancera <fmancera@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307100-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenczykowski@gmail.com,m:netdev@vger.kernel.org,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zenczykowski@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenczykowski@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8742874925F

Note that this is absolutely ancient - it's a patch from March 2012
against 3.18 ;-)
But maybe something like this could be pursued?
From what I (vaguely) remember I was able to boot my linux workstation
to a working GUI with this.

On Mon, Jul 13, 2026 at 10:16=E2=80=AFAM Maciej =C5=BBenczykowski <maze@goo=
gle.com> wrote:
>
> Change-Id: Ibab1a59f4730f3fd0a7d14fffc5100a02a170ac6
> ---
>  gconfigs/Gconfig.net-configs.ipv6 |   2 +
>  include/linux/ipv6.h              |   6 +-
>  include/linux/socket.h            |   5 +-
>  include/net/compat.h              |   2 +-
>  net/compat.c                      |   6 +-
>  net/core/iovec.c                  |   4 +-
>  net/ipv6/Kconfig                  |  19 +++
>  net/ipv6/af_inet6.c               |   5 +
>  net/ipv6/ipv6_sockglue.c          |   8 +-
>  net/ipv6/sysctl_net_ipv6.c        |  26 ++++
>  net/socket.c                      | 211 +++++++++++++++++++++++++++---
>  11 files changed, 260 insertions(+), 34 deletions(-)
>  create mode 100644 gconfigs/Gconfig.net-configs.ipv6
>
> diff --git a/gconfigs/Gconfig.net-configs.ipv6 b/gconfigs/Gconfig.net-con=
figs.ipv6
> new file mode 100644
> index 000000000000..9eb5694bae8e
> --- /dev/null
> +++ b/gconfigs/Gconfig.net-configs.ipv6
> @@ -0,0 +1,2 @@
> +CONFIG_IPV6_IPV4_EMULATE=3Dy
> +CONFIG_IPV6_IPV4_EMULATE_SYSCTL_DEFAULT=3Dy
> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> index ff560537dd61..8bc5306094b5 100644
> --- a/include/linux/ipv6.h
> +++ b/include/linux/ipv6.h
> @@ -157,11 +157,13 @@ struct ipv6_pinfo {
>  #if defined(__BIG_ENDIAN_BITFIELD)
>         /* Packed in 16bits. */
>         __s16                   mcast_hops:9;
> -       __u16                   __unused_2:6,
> +       __u16                   __unused_2:5,
> +                               ipv4emu:1,
>                                 mc_loop:1;
>  #else
>         __u16                   mc_loop:1,
> -                               __unused_2:6;
> +                               ipv4emu:1,
> +                               __unused_2:5;
>         __s16                   mcast_hops:9;
>  #endif
>         int                     ucast_oif;
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index bb9b83640070..4ae959a3443b 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -8,6 +8,7 @@
>  #include <linux/types.h>               /* pid_t                        *=
/
>  #include <linux/compiler.h>            /* __user                       *=
/
>  #include <uapi/linux/socket.h>
> +struct sock;                           /* from net/sock.h              *=
/
>
>  struct pid;
>  struct cred;
> @@ -312,8 +313,8 @@ extern int csum_partial_copy_fromiovecend(unsigned ch=
ar *kdata,
>  extern unsigned long iov_pages(const struct iovec *iov, int offset,
>                                unsigned long nr_segs);
>
> -extern int verify_iovec(struct msghdr *m, struct iovec *iov, struct sock=
addr_storage *address, int mode);
> -extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sock=
addr_storage *kaddr);
> +extern int verify_iovec(struct sock *sk, struct msghdr *m, struct iovec =
*iov, struct sockaddr_storage *address, int mode);
> +extern int move_addr_to_kernel(struct sock *sk, void __user *uaddr, int =
*ulen, struct sockaddr_storage *kaddr);
>  extern int put_cmsg(struct msghdr*, int level, int type, int len, void *=
data);
>
>  struct timespec;
> diff --git a/include/net/compat.h b/include/net/compat.h
> index 3b603b199c01..b9ee7aa5a31f 100644
> --- a/include/net/compat.h
> +++ b/include/net/compat.h
> @@ -41,7 +41,7 @@ int compat_sock_get_timestampns(struct sock *, struct t=
imespec __user *);
>  #endif /* defined(CONFIG_COMPAT) */
>
>  int get_compat_msghdr(struct msghdr *, struct compat_msghdr __user *);
> -int verify_compat_iovec(struct msghdr *, struct iovec *,
> +int verify_compat_iovec(struct sock *, struct msghdr *, struct iovec *,
>                         struct sockaddr_storage *, int);
>  asmlinkage long compat_sys_sendmsg(int, struct compat_msghdr __user *,
>                                    unsigned int);
> diff --git a/net/compat.c b/net/compat.c
> index bc8aeefddf3f..f66bd6552204 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -80,15 +80,15 @@ int get_compat_msghdr(struct msghdr *kmsg, struct com=
pat_msghdr __user *umsg)
>  }
>
>  /* I've named the args so it is easy to tell whose space the pointers ar=
e in. */
> -int verify_compat_iovec(struct msghdr *kern_msg, struct iovec *kern_iov,
> +int verify_compat_iovec(struct sock *sk, struct msghdr *kern_msg, struct=
 iovec *kern_iov,
>                    struct sockaddr_storage *kern_address, int mode)
>  {
>         int tot_len;
>
>         if (kern_msg->msg_name && kern_msg->msg_namelen) {
>                 if (mode =3D=3D VERIFY_READ) {
> -                       int err =3D move_addr_to_kernel(kern_msg->msg_nam=
e,
> -                                                     kern_msg->msg_namel=
en,
> +                       int err =3D move_addr_to_kernel(sk, kern_msg->msg=
_name,
> +                                                     &kern_msg->msg_name=
len,
>                                                       kern_address);
>                         if (err < 0)
>                                 return err;
> diff --git a/net/core/iovec.c b/net/core/iovec.c
> index e1ec45ab1e63..a7a393cae2a7 100644
> --- a/net/core/iovec.c
> +++ b/net/core/iovec.c
> @@ -35,7 +35,7 @@
>   *     in any case.
>   */
>
> -int verify_iovec(struct msghdr *m, struct iovec *iov, struct sockaddr_st=
orage *address, int mode)
> +int verify_iovec(struct sock *sk, struct msghdr *m, struct iovec *iov, s=
truct sockaddr_storage *address, int mode)
>  {
>         int size, ct, err;
>
> @@ -43,7 +43,7 @@ int verify_iovec(struct msghdr *m, struct iovec *iov, s=
truct sockaddr_storage *a
>                 if (mode =3D=3D VERIFY_READ) {
>                         void __user *namep;
>                         namep =3D (void __user __force *) m->msg_name;
> -                       err =3D move_addr_to_kernel(namep, m->msg_namelen=
,
> +                       err =3D move_addr_to_kernel(sk, namep, &m->msg_na=
melen,
>                                                   address);
>                         if (err < 0)
>                                 return err;
> diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
> index 438a73aa777c..69924a6c2257 100644
> --- a/net/ipv6/Kconfig
> +++ b/net/ipv6/Kconfig
> @@ -21,6 +21,25 @@ menuconfig IPV6
>
>  if IPV6
>
> +config IPV6_IPV4_EMULATE
> +       bool "IPv6: IPv4 socket interface emulation support"
> +       default n
> +       depends on IPV6=3Dy
> +       ---help---
> +         Whether to include support code which allows using a kernel IPv=
6
> +         socket from userspace as if it was an IPv4 socket.
> +
> +         ie. this is a userspace-kernel IP address translation shim laye=
r.
> +
> +config IPV6_IPV4_EMULATE_SYSCTL_DEFAULT
> +       bool "IPv6: IPv4 socket emulation - default sysctl setting"
> +       default n
> +       depends on IPV6_IPV4_EMULATE
> +       ---help---
> +         Default value for /proc/sys/net/ipv6/ipv4_emulation
> +         The content of this sysctl file determines whether userspace as=
king
> +         for IPv4 sockets gets IPv6 sockets with IPv4 emulation turned o=
n.
> +
>  config IPV6_ROUTER_PREF
>         bool "IPv6: Router Preference (RFC 4191) support"
>         ---help---
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index e8c4400f23e9..4f08abdf06e0 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -476,6 +476,11 @@ int inet6_ioctl(struct socket *sock, unsigned int cm=
d, unsigned long arg)
>         struct sock *sk =3D sock->sk;
>         struct net *net =3D sock_net(sk);
>
> +#if defined(CONFIG_IPV6_IPV4_EMULATE)
> +       if (inet6_sk(sk)->ipv4emu)
> +               return inet_ioctl(sock, cmd, arg);
> +#endif
> +
>         switch (cmd) {
>         case SIOCGSTAMP:
>                 return sock_get_timestamp(sk, (struct timeval __user *)ar=
g);
> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index e1a9583bb419..2e97c6d55b62 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -857,7 +857,7 @@ int ipv6_setsockopt(struct sock *sk, int level, int o=
ptname,
>         if (level =3D=3D SOL_IP && sk->sk_type !=3D SOCK_RAW)
>                 return udp_prot.setsockopt(sk, level, optname, optval, op=
tlen);
>
> -       if (level !=3D SOL_IPV6)
> +       if ((level !=3D SOL_IPV6) || (inet6_sk(sk)->ipv4emu))
>                 return -ENOPROTOOPT;
>
>         err =3D do_ipv6_setsockopt(sk, level, optname, optval, optlen);
> @@ -888,7 +888,7 @@ int compat_ipv6_setsockopt(struct sock *sk, int level=
, int optname,
>                 return udp_prot.setsockopt(sk, level, optname, optval, op=
tlen);
>         }
>
> -       if (level !=3D SOL_IPV6)
> +       if ((level !=3D SOL_IPV6) || (inet6_sk(sk)->ipv4emu))
>                 return -ENOPROTOOPT;
>
>         if (optname >=3D MCAST_JOIN_GROUP && optname <=3D MCAST_MSFILTER)
> @@ -1297,7 +1297,7 @@ int ipv6_getsockopt(struct sock *sk, int level, int=
 optname,
>         if (level =3D=3D SOL_IP && sk->sk_type !=3D SOCK_RAW)
>                 return udp_prot.getsockopt(sk, level, optname, optval, op=
tlen);
>
> -       if (level !=3D SOL_IPV6)
> +       if ((level !=3D SOL_IPV6) || (inet6_sk(sk)->ipv4emu))
>                 return -ENOPROTOOPT;
>
>         err =3D do_ipv6_getsockopt(sk, level, optname, optval, optlen, 0)=
;
> @@ -1334,7 +1334,7 @@ int compat_ipv6_getsockopt(struct sock *sk, int lev=
el, int optname,
>                 return udp_prot.getsockopt(sk, level, optname, optval, op=
tlen);
>         }
>
> -       if (level !=3D SOL_IPV6)
> +       if ((level !=3D SOL_IPV6) || (inet6_sk(sk)->ipv4emu))
>                 return -ENOPROTOOPT;
>
>         if (optname =3D=3D MCAST_MSFILTER)
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index c5c10fafcfe2..0ab6a8d5aa57 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/mm.h>
> +#include <linux/module.h>
>  #include <linux/sysctl.h>
>  #include <linux/in6.h>
>  #include <linux/ipv6.h>
> @@ -18,6 +19,20 @@
>
>  static int one =3D 1;
>
> +#if defined(CONFIG_IPV6_IPV4_EMULATE)
> +static int zero;
> +
> +# if defined(CONFIG_IPV6_IPV4_EMULATE_SYSCTL_DEFAULT)
> +bool sysctl_ipv4_emulation =3D true;
> +# else
> +bool sysctl_ipv4_emulation =3D false;
> +# endif
> +
> +module_param_named(ipv4_emulation, sysctl_ipv4_emulation, bool, S_IRUGO|=
S_IWUSR);
> +MODULE_PARM_DESC(ipv4_emulation,
> +                "Auto promote PF_INET sockets into PF_INET6 sockets, wit=
h IPv4 API emulation.");
> +#endif
> +
>  static struct ctl_table ipv6_table_template[] =3D {
>         {
>                 .procname       =3D "bindv6only",
> @@ -73,6 +88,17 @@ static struct ctl_table ipv6_rotable[] =3D {
>                 .proc_handler   =3D proc_dointvec_minmax,
>                 .extra1         =3D &one
>         },
> +#if defined(CONFIG_IPV6_IPV4_EMULATE)
> +       {
> +               .procname       =3D "ipv4_emulation",
> +               .data           =3D &sysctl_ipv4_emulation,
> +               .maxlen         =3D sizeof(bool),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D &zero,
> +               .extra2         =3D &one,
> +       },
> +#endif
>         { }
>  };
>
> diff --git a/net/socket.c b/net/socket.c
> index fe20c319a0bb..e7d2f5281ff3 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -101,6 +101,7 @@
>  #include <linux/netfilter.h>
>
>  #include <linux/if_tun.h>
> +#include <linux/ipv6.h>
>  #include <linux/ipv6_route.h>
>  #include <linux/route.h>
>  #include <linux/sockios.h>
> @@ -178,30 +179,171 @@ static DEFINE_PER_CPU(int, sockets_in_use);
>   * divide and look after the messy bits.
>   */
>
> +static int ipv6_promote_ipv4_address(struct sock *sk,
> +       struct sockaddr_storage * kaddr, int * addr_len)
> +{
> +#if defined(CONFIG_IPV6_IPV4_EMULATE)
> +       if (!sk) {
> +               pr_warning("ipv6_promote_ipv4_address: no sk\n");
> +               return 0;
> +       }
> +
> +       if (sk->sk_family !=3D PF_INET6) {
> +               //pr_warning("ipv6_promote_ipv4_address: sk_family =3D=3D=
 %d\n", sk->sk_family);
> +               return 0;
> +       }
> +
> +       if (!inet6_sk(sk)->ipv4emu) {
> +               //pr_warning("ipv6_promote_ipv4_address: not ipv4emu\n");
> +               return 0;
> +       }
> +
> +       if (kaddr->ss_family =3D=3D AF_UNSPEC) {
> +               //pr_warning("ipv6_promote_ipv4_address: unspec\n");
> +               return 0;
> +       }
> +
> +       if (kaddr->ss_family !=3D AF_INET) {
> +               pr_warning("ipv6_promote_ipv4_address: addr is %d\n", kad=
dr->ss_family);
> +               return -EAFNOSUPPORT;
> +       }
> +
> +       if (*addr_len < sizeof(struct sockaddr_in)) {
> +               pr_warning("ipv6_promote_ipv4_address: addr_len =3D=3D %d=
\n", *addr_len);
> +               return -EINVAL;
> +       }
> +
> +       {
> +               const struct sockaddr_in * kaddr4 =3D (const struct socka=
ddr_in *)kaddr;
> +               struct sockaddr_in6 * kaddr6 =3D (struct sockaddr_in6 *)k=
addr;
> +               __be16 port =3D kaddr4->sin_port;
> +               __be32 ipv4 =3D kaddr4->sin_addr.s_addr;
> +
> +               //*addr_len =3D sizeof(struct sockaddr_in6);
> +               *addr_len =3D 24; //SIN6_LEN_RFC2133; /* 24 =3D 2+2+4+16,=
 ie. without scope id */
> +// Why not fill in scope_id with 0 ?
> +// One way to avoid the magic 24 constant is to use offsetof(struct sock=
addr_in6, scope_id)
> +               kaddr6->sin6_family =3D AF_INET6;
> +               kaddr6->sin6_port =3D port;
> +               kaddr6->sin6_flowinfo =3D htonl(0);
> +               kaddr6->sin6_addr.s6_addr32[0] =3D htonl(0);
> +               kaddr6->sin6_addr.s6_addr32[1] =3D htonl(0);
> +               kaddr6->sin6_addr.s6_addr32[2] =3D ntohl(ipv4) ? htonl(0x=
FFFF) : htonl(0);
> +               kaddr6->sin6_addr.s6_addr32[3] =3D ipv4;
> +               kaddr6->sin6_scope_id =3D 0;
> +
> +               pr_debug("ipv6_promote_ipv4_address: ok [%08X:%d]\n", nto=
hl(ipv4), ntohs(port));
> +       }
> +#endif
> +       return 0;
> +}
> +
> +static int ipv6_demote_ipv6_address(struct sock *sk, struct sockaddr_sto=
rage * kaddr, int * addr_len) {
> +#if defined(CONFIG_IPV6_IPV4_EMULATE)
> +       if (!sk) {
> +               pr_warning("ipv6_demote_ipv6_address: no sk\n");
> +               return 0;
> +       }
> +
> +       if (sk->sk_family !=3D PF_INET6) {
> +               //pr_warning("ipv6_demote_ipv6_address: sk_family =3D=3D =
%d\n", sk->sk_family);
> +               return 0;
> +       }
> +
> +       if (!inet6_sk(sk)->ipv4emu) {
> +               //pr_warning("ipv6_demote_ipv6_address: not ipv4emu\n");
> +               return 0;
> +       }
> +
> +       if (kaddr->ss_family !=3D AF_INET6) {
> +               pr_warning("ipv6_demote_ipv6_address: addr is %d\n", kadd=
r->ss_family);
> +               return -EAFNOSUPPORT;
> +       }
> +
> +       if (*addr_len < sizeof(struct sockaddr_in6)) {
> +               pr_warning("ipv6_demote_ipv6_address: addr_len =3D=3D %d\=
n", *addr_len);
> +               return -EINVAL;
> +       }
> +
> +       {
> +               struct sockaddr_in6 const * kaddr6 =3D (struct sockaddr_i=
n6 const *)kaddr;
> +               struct sockaddr_in * kaddr4 =3D (struct sockaddr_in *)kad=
dr;
> +               __be16 port =3D kaddr6->sin6_port;
> +               __be32 ipv6a =3D kaddr6->sin6_addr.s6_addr32[0];
> +               __be32 ipv6b =3D kaddr6->sin6_addr.s6_addr32[1];
> +               __be32 ipv6c =3D kaddr6->sin6_addr.s6_addr32[2];
> +               __be32 ipv4 =3D kaddr6->sin6_addr.s6_addr32[3];
> +
> +// please use ipv6_addr_v4mapped()
> +
> +               if (ipv6a) {
> +                       pr_warning("ipv6_demote_ipv6_address: not mapped =
[1]\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (ipv6b) {
> +                       pr_warning("ipv6_demote_ipv6_address: not mapped =
[2]\n");
> +                       return -EINVAL;
> +               }
> +
> +               if ((ipv6c !=3D htonl(0)) && (ipv6c !=3D htonl(0xFFFF))) =
{
> +                       pr_warning("ipv6_demote_ipv6_address: not mapped =
[3]\n");
> +                       return -EINVAL;
> +               }
> +
> +               if ((ipv6c =3D=3D htonl(0)) && (ipv4 !=3D htonl(0))) {
> +                       pr_warning("ipv6_demote_ipv6_address: not mapped =
[4]\n");
> +                       return -EINVAL;
> +               }
> +
> +// Really avoid those magic values...
> +// Since I doubt this is performance critical, just do the whole struct =
clear at the beginning:
> +// memset(uaddr4, 0, sizeof(*uaddr4));
> +
> +               *addr_len =3D sizeof(struct sockaddr_in); // 2 + 2 + 4 + =
8 padding
> +               kaddr4->sin_family =3D AF_INET;
> +               kaddr4->sin_port =3D port;
> +               kaddr4->sin_addr.s_addr =3D ipv4;
> +               memset(kaddr4->sin_zero, 0, 8);
> +
> +               pr_debug("ipv6_demote_ipv6_address: ok [%08X:%d]\n", ntoh=
l(ipv4), ntohs(port));
> +       }
> +#endif
> +       return 0;
> +}
> +
>  /**
>   *     move_addr_to_kernel     -       copy a socket address into kernel=
 space
> + *     @sk: socket which is receiving the address (or NULL)
>   *     @uaddr: Address in user space
>   *     @kaddr: Address in kernel space
> - *     @ulen: Length in user space
> + *     @ulen: pointer to user space length
>   *
>   *     The address is copied into kernel space. If the provided address =
is
>   *     too long an error code of -EINVAL is returned. If the copy gives
>   *     invalid addresses -EFAULT is returned. On a success 0 is returned=
.
>   */
>
> -int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_st=
orage *kaddr)
> +int move_addr_to_kernel(struct sock *sk, void __user *uaddr, int *ulen,
> +                       struct sockaddr_storage *kaddr)
>  {
> -       if (ulen < 0 || ulen > sizeof(struct sockaddr_storage))
> +       int err;
> +
> +       if (*ulen < 0 || *ulen > sizeof(struct sockaddr_storage))
>                 return -EINVAL;
> -       if (ulen =3D=3D 0)
> +       if (*ulen =3D=3D 0)
>                 return 0;
> -       if (copy_from_user(kaddr, uaddr, ulen))
> +       if (copy_from_user(kaddr, uaddr, *ulen))
>                 return -EFAULT;
> -       return audit_sockaddr(ulen, kaddr);
> +       err =3D audit_sockaddr(*ulen, kaddr);
> +       if (err)
> +               return err;
> +       return ipv6_promote_ipv4_address(sk, kaddr, ulen);
>  }
>
>  /**
>   *     move_addr_to_user       -       copy an address to user space
> + *     @sk: socket which is generating the address (or NULL)
>   *     @kaddr: kernel space address
>   *     @klen: length of address in kernel
>   *     @uaddr: user space address
> @@ -217,7 +359,7 @@ int move_addr_to_kernel(void __user *uaddr, int ulen,=
 struct sockaddr_storage *k
>   *     specified. Zero is returned for a success.
>   */
>
> -static int move_addr_to_user(struct sockaddr_storage *kaddr, int klen,
> +static int move_addr_to_user(struct sock *sk, struct sockaddr_storage *k=
addr, int klen,
>                              void __user *uaddr, int __user *ulen)
>  {
>         int err;
> @@ -225,6 +367,9 @@ static int move_addr_to_user(struct sockaddr_storage =
*kaddr, int klen,
>
>         BUG_ON(klen > sizeof(struct sockaddr_storage));
>         err =3D get_user(len, ulen);
> +       if (err)
> +               return err;
> +       err =3D ipv6_demote_ipv6_address(sk, kaddr, &klen);
>         if (err)
>                 return err;
>         if (len > klen)
> @@ -1249,12 +1394,19 @@ call_kill:
>  }
>  EXPORT_SYMBOL(sock_wake_async);
>
> +#if defined(CONFIG_IPV6_IPV4_EMULATE)
> +extern bool sysctl_ipv4_emulation;
> +#endif
> +
>  int __sock_create(struct net *net, int family, int type, int protocol,
>                          struct socket **res, int kern)
>  {
>         int err;
>         struct socket *sock;
>         const struct net_proto_family *pf;
> +#if defined(CONFIG_IPV6_IPV4_EMULATE)
> +       bool ipv4emu =3D false;
> +#endif
>
>         /*
>          *      Check protocol is in range
> @@ -1283,6 +1435,13 @@ int __sock_create(struct net *net, int family, int=
 type, int protocol,
>         if (err)
>                 return err;
>
> +#if defined(CONFIG_IPV6_IPV4_EMULATE)
> +       if (sysctl_ipv4_emulation && !kern && family =3D=3D PF_INET) {
> +               family =3D PF_INET6;
> +               ipv4emu =3D true;
> +       }
> +#endif
> +
>         /*
>          *      Allocate the socket and allow the family to set things up=
. if
>          *      the protocol is 0, the family is instructed to select an =
appropriate
> @@ -1328,6 +1487,14 @@ int __sock_create(struct net *net, int family, int=
 type, int protocol,
>         if (err < 0)
>                 goto out_module_put;
>
> +#if defined(CONFIG_IPV6_IPV4_EMULATE)
> +       if (ipv4emu) {
> +               inet6_sk(sock->sk)->ipv4emu =3D 1;
> +               /* we need to clear ipv6only, since it could have default=
ed to true via sysctl */
> +               sock->sk->sk_ipv6only =3D 0;
> +       }
> +#endif
> +
>         /*
>          * Now to bump the refcnt of the [loadable] module that owns this
>          * socket at sock_release time we decrement its refcnt.
> @@ -1532,7 +1699,7 @@ SYSCALL_DEFINE3(bind, int, fd, struct sockaddr __us=
er *, umyaddr, int, addrlen)
>
>         sock =3D sockfd_lookup_light(fd, &err, &fput_needed);
>         if (sock) {
> -               err =3D move_addr_to_kernel(umyaddr, addrlen, &address);
> +               err =3D move_addr_to_kernel(sock->sk, umyaddr, &addrlen, =
&address);
>                 if (err >=3D 0) {
>                         err =3D security_socket_bind(sock,
>                                                    (struct sockaddr *)&ad=
dress,
> @@ -1646,7 +1813,7 @@ SYSCALL_DEFINE4(accept4, int, fd, struct sockaddr _=
_user *, upeer_sockaddr,
>                         err =3D -ECONNABORTED;
>                         goto out_fd;
>                 }
> -               err =3D move_addr_to_user(&address,
> +               err =3D move_addr_to_user(newsock->sk, &address,
>                                         len, upeer_sockaddr, upeer_addrle=
n);
>                 if (err < 0)
>                         goto out_fd;
> @@ -1695,7 +1862,7 @@ SYSCALL_DEFINE3(connect, int, fd, struct sockaddr _=
_user *, uservaddr,
>         sock =3D sockfd_lookup_light(fd, &err, &fput_needed);
>         if (!sock)
>                 goto out;
> -       err =3D move_addr_to_kernel(uservaddr, addrlen, &address);
> +       err =3D move_addr_to_kernel(sock->sk, uservaddr, &addrlen, &addre=
ss);
>         if (err < 0)
>                 goto out_put;
>
> @@ -1735,7 +1902,7 @@ SYSCALL_DEFINE3(getsockname, int, fd, struct sockad=
dr __user *, usockaddr,
>         err =3D sock->ops->getname(sock, (struct sockaddr *)&address, &le=
n, 0);
>         if (err)
>                 goto out_put;
> -       err =3D move_addr_to_user(&address, len, usockaddr, usockaddr_len=
);
> +       err =3D move_addr_to_user(sock->sk, &address, len, usockaddr, uso=
ckaddr_len);
>
>  out_put:
>         fput_light(sock->file, fput_needed);
> @@ -1767,7 +1934,7 @@ SYSCALL_DEFINE3(getpeername, int, fd, struct sockad=
dr __user *, usockaddr,
>                     sock->ops->getname(sock, (struct sockaddr *)&address,=
 &len,
>                                        1);
>                 if (!err)
> -                       err =3D move_addr_to_user(&address, len, usockadd=
r,
> +                       err =3D move_addr_to_user(sock->sk, &address, len=
, usockaddr,
>                                                 usockaddr_len);
>                 fput_light(sock->file, fput_needed);
>         }
> @@ -1806,7 +1973,7 @@ SYSCALL_DEFINE6(sendto, int, fd, void __user *, buf=
f, size_t, len,
>         msg.msg_controllen =3D 0;
>         msg.msg_namelen =3D 0;
>         if (addr) {
> -               err =3D move_addr_to_kernel(addr, addr_len, &address);
> +               err =3D move_addr_to_kernel(sock->sk, addr, &addr_len, &a=
ddress);
>                 if (err < 0)
>                         goto out_put;
>                 msg.msg_name =3D (struct sockaddr *)&address;
> @@ -1871,7 +2038,7 @@ SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, u=
buf, size_t, size,
>         err =3D sock_recvmsg(sock, &msg, size, flags);
>
>         if (err >=3D 0 && addr !=3D NULL) {
> -               err2 =3D move_addr_to_user(&address,
> +               err2 =3D move_addr_to_user(sock->sk, &address,
>                                          msg.msg_namelen, addr, addr_len)=
;
>                 if (err2 < 0)
>                         err =3D err2;
> @@ -2042,9 +2209,9 @@ static int ___sys_sendmsg(struct socket *sock, stru=
ct msghdr __user *msg,
>
>         /* This will also move the address data into kernel space */
>         if (MSG_CMSG_COMPAT & flags) {
> -               err =3D verify_compat_iovec(msg_sys, iov, &address, VERIF=
Y_READ);
> +               err =3D verify_compat_iovec(sock->sk, msg_sys, iov, &addr=
ess, VERIFY_READ);
>         } else
> -               err =3D verify_iovec(msg_sys, iov, &address, VERIFY_READ)=
;
> +               err =3D verify_iovec(sock->sk, msg_sys, iov, &address, VE=
RIFY_READ);
>         if (err < 0)
>                 goto out_freeiov;
>         total_len =3D err;
> @@ -2258,9 +2425,9 @@ static int ___sys_recvmsg(struct socket *sock, stru=
ct msghdr __user *msg,
>         uaddr =3D (__force void __user *)msg_sys->msg_name;
>         uaddr_len =3D COMPAT_NAMELEN(msg);
>         if (MSG_CMSG_COMPAT & flags)
> -               err =3D verify_compat_iovec(msg_sys, iov, &addr, VERIFY_W=
RITE);
> +               err =3D verify_compat_iovec(sock->sk, msg_sys, iov, &addr=
, VERIFY_WRITE);
>         else
> -               err =3D verify_iovec(msg_sys, iov, &addr, VERIFY_WRITE);
> +               err =3D verify_iovec(sock->sk, msg_sys, iov, &addr, VERIF=
Y_WRITE);
>         if (err < 0)
>                 goto out_freeiov;
>         total_len =3D err;
> @@ -2280,7 +2447,7 @@ static int ___sys_recvmsg(struct socket *sock, stru=
ct msghdr __user *msg,
>         len =3D err;
>
>         if (uaddr !=3D NULL) {
> -               err =3D move_addr_to_user(&addr,
> +               err =3D move_addr_to_user(sock->sk, &addr,
>                                         msg_sys->msg_namelen, uaddr,
>                                         uaddr_len);
>                 if (err < 0)
> @@ -3159,7 +3326,11 @@ static int routing_ioctl(struct net *net, struct s=
ocket *sock,
>         u32 rtdev;
>         mm_segment_t old_fs =3D get_fs();
>
> -       if (sock && sock->sk && sock->sk->sk_family =3D=3D AF_INET6) { /*=
 ipv6 */
> +       if (sock && sock->sk && sock->sk->sk_family =3D=3D AF_INET6
> +#if defined(CONFIG_IPV6_IPV4_EMULATE)
> +           && !inet6_sk(sock->sk)->ipv4emu
> +#endif
> +          ) { /* ipv6 */
>                 struct in6_rtmsg32 __user *ur6 =3D argp;
>                 ret =3D copy_from_user(&r6.rtmsg_dst, &(ur6->rtmsg_dst),
>                         3 * sizeof(struct in6_addr));
> --
> 2.55.0.795.g602f6c329a-goog
>

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

