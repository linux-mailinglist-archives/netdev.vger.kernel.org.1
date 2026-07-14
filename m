Return-Path: <netdev+bounces-307408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dJaKBQUBVmocxwAAu9opvQ
	(envelope-from <netdev+bounces-307408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:27:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63944752D5D
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:27:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VzSaTue5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307408-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307408-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADB8D313F4A6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6107C43CEFD;
	Tue, 14 Jul 2026 09:23:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90513F1AC0
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:23:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020983; cv=pass; b=sm2khYv4JNs4KVz4exlV/6m1xkUASpbWAlr3A3I7ukNe1fLHvRxCmq9qry3eHPJeG+cC785Hlz2GkO7l77cppGVm0ERdjEp0Qy5DzOGCgOAUwfaMiPz/UOTy2lpKXyHt9tr3pSnqinhg3x2x1+KopWP1OX6ZI1Xl1cHeZs7uHSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020983; c=relaxed/simple;
	bh=kq9BpiaMu64ayuqtT2xYYrv+mWKCPV7p7LohTLRn0uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EA/AC9vzsNWgceAVp5tB32iIG8LzjtK5wP4pMkrkJmCxOnnppPwhwTRcHA0CCnxO/x0x/D/glerT/LJIL8wJjiOKDT0YgWkiYmxanqpJ31wk/ZpWqhnArsRXSICGWwbmntkkTf+jg8X+EP5SFiXB1hDdxYj0UxebUQN3mJi81Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzSaTue5; arc=pass smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cac59f8b64so44930285ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 02:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784020981; cv=none;
        d=google.com; s=arc-20260327;
        b=cnXVpy1ZygHMKH0/Pb61En6EwkVrBBJy7RpzHdU2kQyAEoKRCLnYIE+xoqG+qKKPza
         +P4bV0qhaLy1sSjWr8XPK/lfKXJM5b2x0xEcHEjA1oOjb/EVbYC3iQCYeK4TEMtLqBEf
         FvNYdvihJBNJ8oYSqZ0yhMt2R2PISjiafRLYSjoVWjWBNWXiLgjzX9WDEWR1XHldKa79
         9SZh8XjnepCvWartcJhuQIMlYUDdrctwRT49k34edRYab5dEyQ7TA0lLVCpiQD5y4sEw
         uNiEALJjZsQsjszxHAXC+ZfOCjMBkQPWLJBDIblLz3lwCTsJmmltEYCcrOlMejAVghz+
         UmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Ffx1jovQ60HIicFzCljXtq6wI+0UH0XgdbovnzHgcY=;
        fh=5c4/8cyaTWjwnd805SIwMhRQhJB+g8h0GXGU0fC9GvY=;
        b=diXA/XKGrVRPkCfF1AfIlJg+VEtjF2NBkxLC7UIOn8EryJY3Wu5K3Hi9VTqTc7ML0b
         6MDLyJIY+KHCSCjh7NySoEJk8kRw182JR1Y56sDolcBZCkbZmH10x8RGvDwxeYSQ5n20
         yFumENZOrpi929ssBUFHj3g2NmAYYXRUDyRoOcwNTJHQm9T/QiqXwx2RT8jtipGpZojy
         RbJuMiKutqT+j3dC+tnjnax1Bf2vENFhx62UK7MV6OT5g11v528ysZDcN4MXpe8P7dAq
         nT2lQh0B3y/hv0T8dMvQBlrQeA723a00iZvaU9arU8vWkWr7r3in6SNNc36yWlZRHiKG
         xHSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784020981; x=1784625781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Ffx1jovQ60HIicFzCljXtq6wI+0UH0XgdbovnzHgcY=;
        b=VzSaTue5q1OdEkGPxN/ipeKU/lFF53V4ZXD8TE+OKu7OChxvPyklnk5Jn45voSjZal
         ctjolybYJ2uK+J6sQ/C9A3VKcFp3WFIafzh5yjcX7npnn5/uCFORphOvl4Ml0WR8dTon
         YC8iN8Af2Lzjvr9P1KhMhmkssxJORLHfRpiO87FPElC9qmp3qILQKf787F9OrKBub7eQ
         b+P3WCEBXK5rBimkq/CxN9U6GSQJ7ANnsNE9j7O7nSPzIoeuDiDG9+qIohN5dtVUg7Mw
         QpKjo7W268UNug1yeYwqBmG4H0W+eNVtx0EIEQOTdU8XWqOb96PqOHws2HDLWUF3viZs
         dmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020981; x=1784625781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Ffx1jovQ60HIicFzCljXtq6wI+0UH0XgdbovnzHgcY=;
        b=GToQJZFRBJLW+4KgaW05zwRl1v/V2XEU9bJ/svX0e4rCVTXlmof41cp2lQc+1+8kys
         tdZjISRNGnoF2/u/GDGlMUG3M4FfNRy+BqlGZMR4SKvzVfTrE6QUGfdDO8fuUJm00IoL
         Qdtw6rXTwHwlato3j2UBc1ATRB4Q9ltIMJ7T1/Z0xasOMcsrzJnNPtgJftUmyEQaGvL0
         KeQWOY2Zl1TPu7+KImbPZJFTbdoTz3u5/RMrRdN5B8DMkiT6dEpAe1rwqvvd0uUEVhRG
         F1jDLhjApVJH40FvUTGKfTTgPc3F9bkxKq32c6WXX5YPfiwBF5nHanlm2YKno+e4pJeE
         ol4w==
X-Forwarded-Encrypted: i=1; AHgh+RrAbFm4fu8PDm+XVP6JAqpp//+186Q6iqIBKeGv+AfFT52Y4KbZlK/scKARDvPCM2PIjP4df9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcArg+GuBQCtLHi29obgRyzBx+UF7n5WiORJrJspcchVxmeDI
	70axtMY3+ilGaYzrJdEqisQgeu+EM9Fm141SFHgg4hzlDA/CX4Wj8r29BaaardN+nC5/9uBhDJz
	LEC3ZvSnM2ZF0d26xf7OW79m+ItzBGCftF4ZwLH4J
X-Gm-Gg: AfdE7cn8lZgierDbl0IFjzm1jZ3CmFb7sYye1HUkim8FDFsP9kuYBQjszU7TLh79acy
	gyP5l1RNFgv+ZcWhUKTbuK/ith07AWat+nhhrTTfxAAAP0tAl+uSSH3LQecLyHGBntYv7Bwl9K0
	vV+0OofY72aW88Xtwr0Ixgj5MfoLD0WE349umN68Z+B/aL/8xI1eAC/CzlQuRJtwCKfL31odkd1
	1bkaU64n6xalqyNu8jrvWfiT2gNFaDOTbr/mMkm0OL45PcBwOhV+FGDitANjNqPupUT7xd4Eg3w
	/pRgTXhmRmzoYNB5aEfX9vLrDjmVaCzGj7G7d4q5X7im2JnvOu+sRmt+tyTeDIvk5d8NPXRHQpb
	lfzE6pd3r2hg=
X-Received: by 2002:a05:6a20:ef03:b0:3c3:373f:e82f with SMTP id
 adf61e73a8af0-3c3373febc5mr6365502637.8.1784020980740; Tue, 14 Jul 2026
 02:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl> <20260712192958.1631672-4-jkoolstra@xs4all.nl>
In-Reply-To: <20260712192958.1631672-4-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Jul 2026 11:22:47 +0200
X-Gm-Features: AVVi8Cc_JhE7Jh-3tzGwanDA4IvEQcjam1JNFpxbhnHSnWak-LhE8J3Bk2heG4E
Message-ID: <CAAVpQUDMVo2+V+NObF8vuPu0AcO1ZcSLeOWk84czPGgT+8QoyA@mail.gmail.com>
Subject: Re: [net-next v5 3/4] net: af_unix: useful handling of LSM denials on SCM_RIGHTS
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:cyphar@cyphar.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307408-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63944752D5D

On Sun, Jul 12, 2026 at 9:29=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
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
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  2 ++
>  arch/mips/include/uapi/asm/socket.h   |  2 ++
>  arch/parisc/include/uapi/asm/socket.h |  2 ++
>  arch/sparc/include/uapi/asm/socket.h  |  2 ++
>  include/net/af_unix.h                 |  1 +
>  include/net/scm.h                     | 13 +++------
>  include/uapi/asm-generic/socket.h     |  2 ++
>  net/compat.c                          |  4 +--
>  net/core/scm.c                        | 38 +++++++++++++++++++++++----
>  net/unix/af_unix.c                    |  9 +++++++
>  10 files changed, 59 insertions(+), 16 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/ua=
pi/asm/socket.h
> index 5ef57f88df6b..946a5fad2691 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -155,6 +155,8 @@
>  #define SO_INQ                 84
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      85
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi=
/asm/socket.h
> index 72fb1b006da9..f1641dde135f 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -166,6 +166,8 @@
>  #define SO_INQ                 84
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      85
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/=
uapi/asm/socket.h
> index c16ec36dfee6..f3a3815c7dc2 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -147,6 +147,8 @@
>  #define SO_INQ                 0x4052
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      0x4053
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/ua=
pi/asm/socket.h
> index 71befa109e1c..7907f3b1f0ee 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -148,6 +148,8 @@
>  #define SO_INQ                   0x005d
>  #define SCM_INQ                  SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC        0x005e
> +
>  #if !defined(__KERNEL__)
>
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
> index c52519669349..86ae6bc109ec 100644
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
> @@ -107,13 +107,8 @@ void scm_recv(struct socket *sock, struct msghdr *ms=
g,
>  void scm_recv_unix(struct socket *sock, struct msghdr *msg,
>                    struct scm_cookie *scm, int flags);
>
> -static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
> -                                 unsigned int flags)
> -{
> -       if (!ufd)
> -               return -EFAULT;
> -       return receive_fd(f, ufd, flags);
> -}
> +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> +                   bool notrunc);
>
>  #endif /* __LINUX_NET_SCM_H */
>
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic=
/socket.h
> index 53b5a8c002b1..84ea7b92936e 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -150,6 +150,8 @@
>  #define SO_INQ                 84
>  #define SCM_INQ                        SO_INQ
>
> +#define SO_RIGHTS_NOTRUNC      85
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
> index a73b1eb30fd2..f0d44ecdb11f 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -351,7 +351,31 @@ static int scm_max_fds(struct msghdr *msg)
>         return (msg->msg_controllen - sizeof(struct cmsghdr)) / sizeof(in=
t);
>  }
>
> -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
> +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
> +                   bool notrunc)
> +{
> +       int error;
> +
> +       if (!ufd)
> +               return -EFAULT;
> +
> +       error =3D security_file_receive(f);
> +       if (error)
> +               return notrunc ? put_user(error, ufd) : error;
> +
> +       FD_PREPARE(fdf, flags, get_file(f));
> +       if (fdf.err)
> +               return fdf.err;
> +
> +       error =3D put_user(fd_prepare_fd(fdf), ufd);
> +       if (error)
> +               return error;
> +
> +       __receive_sock(fd_prepare_file(fdf));
> +       return fd_publish(fdf);
> +}
> +
> +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool not=
runc)
>  {
>         struct cmsghdr __user *cm =3D
>                 (__force struct cmsghdr __user *)msg->msg_control_user;
> @@ -365,12 +389,12 @@ void scm_detach_fds(struct msghdr *msg, struct scm_=
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
> @@ -542,8 +566,12 @@ void scm_recv_unix(struct socket *sock, struct msghd=
r *msg,
>         if (!__scm_recv_common(sock->sk, msg, scm, flags))
>                 return;
>
> -       if (scm->fp)
> -               scm_detach_fds(msg, scm);
> +       if (scm->fp) {
> +               struct unix_sock *u;
> +
> +               u =3D unix_sk(sock->sk);
> +               scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc)=
);
> +       }
>
>         if (sock->sk->sk_scm_pidfd)
>                 scm_pidfd_recv(msg, scm);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 3d256255085b..e7b3aab2f176 100644
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

This should be inherited to the child sock, after setting newu->listener
in unix_stream_connect().


> +               break;
> +
>         default:
>                 return -ENOPROTOOPT;
>         }
> --
> 2.55.0
>

