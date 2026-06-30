Return-Path: <netdev+bounces-303301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id erxoOTXzQ2oUmAoAu9opvQ
	(envelope-from <netdev+bounces-303301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:47:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4011A6E6988
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:47:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=NypgtcyR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303301-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303301-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCD16302207E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0E03D6CC7;
	Tue, 30 Jun 2026 16:44:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8F63C2BBA
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 16:44:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837845; cv=pass; b=FXYZ0VNlynVEFosbtFWhlOVtXR3tvrZoncfRBYIgC59InQ2W5yvLUTtvxij8IootyeiJbPe9sL+rq5MFUljUXo0fcX4Jf4HY9+yIl8OycaZ1x0UNue6q9ll7X7eXJiF3zO7+c+KVw4Ryj6tzplbmTHQcmNK/GHi1gl65pb1zts0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837845; c=relaxed/simple;
	bh=v/OcWx3LYLBx0KlspHhgb4R6jpCaa2+fiCx8LKjOQhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/2M67MWL3aDRWXXISztR5GUC0CoCr91V2ayCM7N7hfRgYmmVVrLG6BcamVFlQHhVrO4KmMRlcg0zGCl5xVctEloSKrF1cl0m65YFS5q1/URWP1o6CzdsvhgLMRTKGO4z407PwS9emWfUD5Yq7AfgGgFyVkPms8sTv1XJ3mLPpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NypgtcyR; arc=pass smtp.client-ip=74.125.82.50
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1390f75d8bbso9486331c88.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782837843; cv=none;
        d=google.com; s=arc-20260327;
        b=hQ+yLqhlDlauuUOpuuSnf65X42zuwkiFjocSHFaCobkpc4yVDCTs5UtkmlSXwFHUVq
         Jj7L1Ov9LlCwfaZNQWb0uMreyk7nMb/fVW+GxljaWDuSR7G16Ztywy1EPDDb3OMMUaa4
         brVkixDY5p2gtB66+lE0fmjOBIPzqRoU3oHhsZRtsvBJY4RuI2OY5f8DlIkNXHtkrL5E
         YVNL7dauJ+JwLg94CF+RJWQTvFBMflfcBlKPi3jg5mAYD8UTBEKXcr+1yTrLr3GdOJrF
         034XiF1WzwX762EasltAHk0f7M65vIjWdoWz7N4SWt7A+42yHeFhsiG8yy1XT7aJluVM
         +hSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=603x+vbEytdZ550OAdNYJC+Z9vxOv/z6ypcG3r0EpNE=;
        fh=rMNnoFUUbyzCIBXAD9Wy+qal+R/iy05TcDSr89Sv0Lc=;
        b=Aq7sSmi1XBqGBae4EGZML3R3Hg0GyKs2gpkOAwAa92wTBO6lDlVQB5iMLHE5V8bd0t
         tD677zC/j5vhF5wAUTM+5RAGnUlkdXZHmRhndXcKJiPwD4WPC0BeQq5Vsqqym8kYtlkH
         ZuoiUB083zsTQ6sGspBjHhct0DQ0Fcg5BrrqOemplCcfuTB3Ntom5u/PSaf6faeizdfX
         6BU/ztE54tdv2oQWtUeGgF04AVHynfZAx1gvsJ9n4XkqMfk9MS9xl7kpXqaHfb69Mmmd
         cmNRhBu+Wgxg1Zc/tjQaKBdxQtCaZ7I6P/7O/RYuAr3zAZC+kGZUwUH2HZuzQSA9nOZg
         2Z5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782837843; x=1783442643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=603x+vbEytdZ550OAdNYJC+Z9vxOv/z6ypcG3r0EpNE=;
        b=NypgtcyRac1p+m/Q+Rzoe9y2EBHtO02VxKrCpbLnh7jrpbVCLR+nWqrrjXQJp8Rwxy
         GZT7XqtJ5KgzVVmExnJYW9xCwm2q76sKXMJ02OI/msDuiI6B6y0H+/KhQNWRVA/iJgW2
         Ovo0BF+hs16iKmcebuphhYntq7qoMGDEEocmMlYz+59LljkKnARA//FqKDvUk1ijhygN
         Plz/sqAj2lkhxtdGwMe9T/4FlxV7jnJIbOexykr++UCv69CesvLslaZ7IHOV+JEIoJQj
         aTGCoNeTQCkD2CMqhOOMem5uM2DJyJPpTsbvA9ioVhzgsgg6srzA/qQRsBKV9+mtmuFl
         0XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837843; x=1783442643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=603x+vbEytdZ550OAdNYJC+Z9vxOv/z6ypcG3r0EpNE=;
        b=lEbgRzcxZyf3QMmg1/okiPH7LFsevRy2wcgFA4o1hzDBQbKNGXKli9AiNEFAFmcniT
         LBB6tm1w8QPvBTp606NZrLbkXkhPCnruBUA29DRTKQGWmkE/VZqxrwBGBu9SC07cC854
         84opy+0CimI+AofXYVI6CHIFqGGqYT79xiYTIHx4bhfcNlcyGCsF6sKvWoTv/uCnAdd7
         zqvChMhwO0h+zQuIQWa0M2J0Xa1TNBBuziAEPk4vr+kf0T7V+ifKq3ZOu1VcFHgxAB8b
         h+D2a9ZSIyaa73yAdXs5EvZEnoLWf5gs+lMVYTh9YNlUYzWc7L7BXdqV91Fr69qwnb2j
         9LoA==
X-Forwarded-Encrypted: i=1; AFNElJ8rXXAvgdeCw7evCEY0qqVH0F784qBSW3uWkpFnRSFfx4dDnAJm8EeL7sJ/wX09q+KYGmcyEuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhbrsUwIXj9STXzMil9O9za5D9jLqdBeg1Q7/kaA6/9ZkIDj/
	pdZBV0ImTsEIYmDPoA3hVZ3TL2U4/9O50s2K6w8KmXIzeSipDUqAO00Pzzya0GLeZf2uWm61XPe
	D90tQbnHl3NVxFONq6Q8ZplJGR7032fldtm8ijOAR
X-Gm-Gg: AfdE7cn5w4YFTyBS8XK7dzKPjN1fV9vl895dTIYfV0/YbEvJOLfNznPpwUmCdA2ujFq
	p+EMcQiM7IBP5XQsKL85qIb1GnmfTuGcq9DpzFB9C2OzNwaxmyJasyoYElJlRlx1Ecx7tuPfIQY
	ZQAx4TuN60hrIuSMHNWgDu4zBoIOmsNEyEggkaF4FGBaq6o4RCja3USimh0WU4cB3VZsl8MaeC7
	1N1165uPxh2mCnwTEV9VxapMCAtsfvO64mmK0hRqOz/f8tuqgBS9h8BPGm5DOR6DaLQjYvyb3DP
	TNjtuZ6vP9SDKcYFEQSNF2UWav1RJSLH6CVyxG33K0LAnZ5GAAg4m0EsgpS0YRapfOwZwAmGp7Y
	UBxwbEzkTkw/uE1grjmO1GTe9JcK8XZ7Fi/oJFw==
X-Received: by 2002:a05:7022:fa5:b0:139:ed5d:3b3 with SMTP id
 a92af1059eb24-13b2a1d25d6mr3161157c88.44.1782837842011; Tue, 30 Jun 2026
 09:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl> <20260629194327.2270798-4-jkoolstra@xs4all.nl>
In-Reply-To: <20260629194327.2270798-4-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 30 Jun 2026 09:43:50 -0700
X-Gm-Features: AVVi8Cfg-jGOSmM0AyC_veTlwOcXtiFvZmVGHLWJZaxOaynBoRDq8uW1BKdMGmA
Message-ID: <CAAVpQUBFJXv2FK=7DmKgWms7JROJGWp=S+AOBS__hxmgbLbUkA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/5] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303301-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:cyphar@cyphar.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4011A6E6988

On Mon, Jun 29, 2026 at 12:42=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl=
> wrote:
>
> Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
> that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> highly problematic behaviour, because it leaves the receiver
> wondering what happened. As per man page MSG_CTRUNC is supposed to
> indicate that the control buffer was sized too short, but suddenly
> a permission error might result in the exact same flag being set.
> Moreover, the receiver has no chance to determine how many fds got
> originally sent and how many were suppressed.[1]
>
> Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> handling of LSM denials when receiving SCM_RIGHTS messages: instead of
> truncating the message at the first blocked fd, keep every fd slot
> and store the LSM errno in the blocked slot.
>
> [1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm=
-denials-on-scm_rights
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  include/net/af_unix.h             |  1 +
>  include/net/scm.h                 | 15 +++++++++++----
>  include/uapi/asm-generic/socket.h |  3 +++
>  net/compat.c                      |  4 ++--
>  net/core/scm.c                    | 16 +++++++++++-----
>  net/unix/af_unix.c                |  9 +++++++++
>  6 files changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 34f53dde65ce..bb1b3dee02e8 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -49,6 +49,7 @@ struct unix_sock {
>         struct scm_stat         scm_stat;
>         int                     inq_len;
>         bool                    recvmsg_inq;
> +       bool                    scm_rights_notrunc;
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>         struct sk_buff          *oob_skb;
>  #endif
> diff --git a/include/net/scm.h b/include/net/scm.h
> index c52519669349..761cda0803fb 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -50,8 +50,8 @@ struct scm_cookie {
>  #endif
>  };
>
> -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
> -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
> +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool not=
runc);
> +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, b=
ool notrunc);
>  int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cooki=
e *scm);
>  void __scm_destroy(struct scm_cookie *scm);
>  struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
> @@ -108,11 +108,18 @@ void scm_recv_unix(struct socket *sock, struct msgh=
dr *msg,
>                    struct scm_cookie *scm, int flags);
>
>  static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
> -                                 unsigned int flags)
> +                                 unsigned int flags, bool notrunc)
>  {
> +       bool filtered;
> +       int error;
> +
>         if (!ufd)
>                 return -EFAULT;
> -       return receive_fd(f, ufd, flags);
> +
> +       error =3D receive_fd_filtered(f, ufd, flags, &filtered);
> +       if (filtered && notrunc)
> +               return put_user(error, ufd);
> +       return error;
>  }
>
>  #endif /* __LINUX_NET_SCM_H */
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic=
/socket.h
> index 53b5a8c002b1..c5fb2ee96830 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -150,6 +150,9 @@
>  #define SO_INQ                 84
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      85
> +#define SCM_RIGHTS_NOTRUNC     SO_RIGHTS_NOTRUNC

SCM_RIGHTS_NOTRUNC is not needed as it's not used.


> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
> diff --git a/net/compat.c b/net/compat.c
> index d68cf9c3aad5..6bdf4a2c9077 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -286,7 +286,7 @@ static int scm_max_fds_compat(struct msghdr *msg)
>         return (msg->msg_controllen - sizeof(struct compat_cmsghdr)) / si=
zeof(int);
>  }
>
> -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
> +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, b=
ool notrunc)
>  {
>         struct compat_cmsghdr __user *cm =3D
>                 (struct compat_cmsghdr __user *)msg->msg_control_user;
> @@ -296,7 +296,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct=
 scm_cookie *scm)
>         int err =3D 0, i;
>
>         for (i =3D 0; i < fdmax; i++) {
> -               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags);
> +               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags, notrunc);
>                 if (err < 0)
>                         break;
>         }
> diff --git a/net/core/scm.c b/net/core/scm.c
> index a73b1eb30fd2..55bab203281a 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -351,7 +351,7 @@ static int scm_max_fds(struct msghdr *msg)
>         return (msg->msg_controllen - sizeof(struct cmsghdr)) / sizeof(in=
t);
>  }
>
> -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
> +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool not=
runc)
>  {
>         struct cmsghdr __user *cm =3D
>                 (__force struct cmsghdr __user *)msg->msg_control_user;
> @@ -365,12 +365,12 @@ void scm_detach_fds(struct msghdr *msg, struct scm_=
cookie *scm)
>                 return;
>
>         if (msg->msg_flags & MSG_CMSG_COMPAT) {
> -               scm_detach_fds_compat(msg, scm);
> +               scm_detach_fds_compat(msg, scm, notrunc);
>                 return;
>         }
>
>         for (i =3D 0; i < fdmax; i++) {
> -               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags);
> +               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_=
flags, notrunc);
>                 if (err < 0)
>                         break;
>         }
> @@ -542,8 +542,14 @@ void scm_recv_unix(struct socket *sock, struct msghd=
r *msg,
>         if (!__scm_recv_common(sock->sk, msg, scm, flags))
>                 return;
>
> -       if (scm->fp)
> -               scm_detach_fds(msg, scm);
> +       if (scm->fp) {
> +               struct unix_sock *u;
> +               bool notrunc;
> +
> +               u =3D unix_sk(sock->sk);
> +               notrunc =3D READ_ONCE(u->scm_rights_notrunc);

Does this build with CONFIG_UNIX=3Dn ?


> +               scm_detach_fds(msg, scm, notrunc);
> +       }
>
>         if (sock->sk->sk_scm_pidfd)
>                 scm_pidfd_recv(msg, scm);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f7a9d55eee8a..83274ce18e06 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -921,6 +921,7 @@ static bool unix_custom_sockopt(int optname)
>  {
>         switch (optname) {
>         case SO_INQ:
> +       case SO_RIGHTS_NOTRUNC:
>                 return true;
>         default:
>                 return false;
> @@ -956,6 +957,14 @@ static int unix_setsockopt(struct socket *sock, int =
level, int optname,
>
>                 WRITE_ONCE(u->recvmsg_inq, val);
>                 break;
> +
> +       case SO_RIGHTS_NOTRUNC:
> +               if (val > 1 || val < 0)
> +                       return -EINVAL;
> +
> +               WRITE_ONCE(u->scm_rights_notrunc, val);
> +               break;
> +
>         default:
>                 return -ENOPROTOOPT;
>         }
> --
> 2.54.0
>

