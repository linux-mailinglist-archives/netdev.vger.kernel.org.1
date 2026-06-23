Return-Path: <netdev+bounces-301466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q0JnFi/fOmpGJggAu9opvQ
	(envelope-from <netdev+bounces-301466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:31:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C036B9B79
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:31:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Zw02IrmR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301466-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301466-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F4923031FC5
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489B638B7BA;
	Tue, 23 Jun 2026 19:31:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03801376BD5
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 19:31:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243117; cv=pass; b=hyyM0N1VFoCtuDYtutS409k3AC1ayYlmC3epQsXsMBXhEh7GAmdmxUlD0WiZUs6BVW86m5/r+Tlxmvh6Mz8mPV6Exyye/x0ulHG5OAh5pPRralpPg70+vGzDYjZtM0LlWZLCGajS82Irmk28KxM5DxADs8qUNCXIGDcSat01VSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243117; c=relaxed/simple;
	bh=YYV/g9hIJvV8ysqGi0tTc/m+i/fqrwPDVXz4yll3gXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uow9S0TGC+52WTzwUVyYxaSs4EnCxWxMFcl+EHLY+907nBpVlKWQECV96HHhflWMe5Z1niFLNVZNgzjLjRCIyFsns/iR/UYrfuA3tK8lPl1adTGlAga7+K4Hbj6bABr2kegalpF6NgZcF6Aod5a7cXOzuFAdQKNlCFT/r/gLb7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zw02IrmR; arc=pass smtp.client-ip=74.125.82.54
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1397e093f90so541314c88.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 12:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782243115; cv=none;
        d=google.com; s=arc-20240605;
        b=chqAHxuT5g7EYwptc0y6FQIS6Fv840bocd0xJIiBNVoE44/vIJ1TvZG8upcj7+7Hfg
         fuCm5URzs5ai47VUeoVu0pP/d19G6uuirWUxI4Sjc6lYYBWa4QqpSsvuP+VB5qlcY7Y3
         8G0bN7LLGxqwmujlnoEGJiJnhw4y8wNyRt8OS5H3EBymDxO0P21ssfJqNKZq9rjBCHwC
         x7Sh1GuM9USnzcnmAqa+MWyX5/T2VGLxlNe4zLVLdTF7Cg+bY8+oAk9SVTMdNpsyQWT8
         olv7uzGAL7Cvsb8q3qWx0bQjV/agwCPhUCAX+nUDpJqGH72ZjRNTpHdbQf0iPMyjreze
         nTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LiRXa3AUVgbFVOjg4pvQyLBN61LuQwPW9zXG1uly1ys=;
        fh=VdfW03JskabY+axPgpn7yGYMNUSz+D/4GP68Yvd8uHQ=;
        b=AdhR/FtV01Gw9jtuFbW8z8XvaM5sIopBaSW7KvEFAiiW0EXfewEsQKPsWfmYv/LG0k
         Z+FlsDQcBBGfgDt4OypAi2yiemrbA0uAMy6PxKD7GE+zjWMGsj2U81TZ6xr6WeM0ZGUE
         IDfUeGdCCLeNN74A2rZsEFAB4j9O9AIeAhnEYzp9/eFROvmTFFyK+6IxpJK0gWEDfbLy
         tyo2+/xY3jZ65LnM+cKfNbfQMRAuVq1km8Fu+S+V9THhhcRLqexKpxM0ZaVJjn2nuN35
         OwoWLe3KSOo/faA9vXD2fl4R2vVb8Bu76YtwGkpvSY19+9H5AA5CHNx+emnu4kzCRuOu
         2x5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782243115; x=1782847915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiRXa3AUVgbFVOjg4pvQyLBN61LuQwPW9zXG1uly1ys=;
        b=Zw02IrmRCcz0pgx5Sa2gqpe5R2mViIP/T+3gdQV3T9uIeGvmyvbY2sve7/CyBns36O
         hNx6LlajN1dOfJ/3M45Vx12Jc0fK6R+X48POQGfoWJ5ZWhncaRjgcYsHFNjnCY5rmUOo
         yjscuzLARBCDgVM/OX/O0N9oPWfjLE3XuKBDxT9pg+VjDSA9diVNU0wskzGmx0/jcESX
         Rq2iCj5Mp5/Rtc+S/1fG79iLmvEfbaAt9+HJsxDcFCO40GYvGIURnCsefZAq0PEAi8i+
         Mgt9BRHfKl/IRiPqIj7Lw4SluVOb/0Irgjj58aYjBd+M+bqMq3POhmPmNYzt4yMU7kGU
         AXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782243115; x=1782847915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LiRXa3AUVgbFVOjg4pvQyLBN61LuQwPW9zXG1uly1ys=;
        b=AWISsXbUABvOEQBoNCwQyddExdsubb5gaHbDTB1m3izhYls4c+ir+0P+IssY8ppdrc
         Ol5PN7iAHhLQeqgDAuTo0ShRychpeD8DKhn3RmdvC6a1Gtp+GtjGczcIT4Mu3sTKu2O9
         eMgE72Ol4fq6G++KZtsVFBq3ChXuKddiOUNzccj3PBhx3689Mb0RNqUFmC/sx3T2djNJ
         J8tp44g0UpRMEbtboYjYxvCdqDIsp2PP+gLi8LGPzN7TPP+9BBjEkOzXzk+tiOKeLEGX
         GE2cn+TAcucWT64k4CE37Yi2VvWwfG3Rl8SSLfTuULYM1PfB1pm3NzmCHCoyGCIMWupu
         zhtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9B6nYAPhX6jvULUbklukSgumyKnQnaqbXJ8xOA7Ce6Vt4sxLgUNf4OL5EDaZj+JVYhj41WT2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LtJknigQaCWUpu2bs3aBDizDr71DX2smF2Vr6FMwllATy53A
	kpzE/453spsQTEXfCmVOB+irk7zspSYzaJM0F1pZq09ZCDimxQgkBoEvnk8G5KDNOto3NkEhvln
	IFFAS8tql+Vk7YFDqcQkD8wudTffv3nc+YZb8q/q6/WT7zRN+RUUGN5aK
X-Gm-Gg: AfdE7cnOg52STYC49f/F4nG93ja65TALEKN+4XG5z3Ctqf6DeoRV7X4R9ZgPMeb/oFQ
	5QqA0JIVv8yf4BorZx4BTrnDJiJqgiS/KpZgYLXCtAF1HoI4FK9kfD3GuuPM0vd5HJz2+KxLyLp
	I9qJ9//tTI6g0LoCeKSpdKtbAjJ2OqO8eN6JZ3u3ESrfzpoiTiSPnH5emF+AlpZ2lhLxHhEbDqP
	DsRtcx9twQLi80Zy+WtSnUqqfallfWldvLphL/C5dYtI/rHoo2ZsqnzThYV83oVlMuIbIHdu4T/
	uW80JigPmKAsRImN3CezEwJvxjlKcKLG8MGndlZHeaNrrep/ewxSh2aj9EHjAG5i9Cn8MOhicOa
	dvxO/JsfWU1/I56izAQD7Yo4eBh/QMnkCGLTBDKU=
X-Received: by 2002:a05:7022:6196:b0:139:cca6:54e1 with SMTP id
 a92af1059eb24-139d0c06c48mr104435c88.8.1782243114416; Tue, 23 Jun 2026
 12:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
 <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com> <87v7b9ysep.fsf@cloudflare.com>
In-Reply-To: <87v7b9ysep.fsf@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 23 Jun 2026 12:31:41 -0700
X-Gm-Features: AVVi8CfuZZw17LEOEaWQQolrSVOcFnrMg6KA7Zb61QKHMEK4GXhNhK7MVne9oHY
Message-ID: <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cloudflare.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7C036B9B79

On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>
> On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> > On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@cloudflar=
e.com> wrote:
> >>
> >> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. When
> >> completed all code paths related to sockmap-based redirects should be
> >> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
> >> disabling NET_SOCK_MSG. The implementation of sockmap as a container f=
or
> >> socket references would remain under BPF_SYSCALL.
> >>
> >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> ---
> >> Changes in v2:
> >> - Handle prot->recvmsg being NULL (Sashiko)
> >> - Elaborate on the end goal in description
> >> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-unix-=
v1-1-d7e0cb7bb03b@cloudflare.com
> >> ---
> >>  net/unix/af_unix.c  | 4 ++--
> >>  net/unix/unix_bpf.c | 6 ++++++
> >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> index f7a9d55eee8a..84c11c60c75f 100644
> >> --- a/net/unix/af_unix.c
> >> +++ b/net/unix/af_unix.c
> >> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *soc=
k, struct msghdr *msg, size_t si
> >>  #ifdef CONFIG_BPF_SYSCALL
> >>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
> >>
> >> -       if (prot !=3D &unix_dgram_proto)
> >> +       if (prot->recvmsg)
> >
> > There is no reason to have this dead branch when
> > CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
> >
> > Let's compile out all sockmap code when both configs
> > are not enabled.
> >
> > Since AF_UNIX differs from TCP/UDP, it can take the
> > simpler approach.
>
> Okay, will put the whole file behind hidden config option like so:
>
> --- a/net/unix/Kconfig
> +++ b/net/unix/Kconfig
> @@ -30,3 +30,8 @@ config UNIX_DIAG
>         help
>           Support for UNIX socket monitoring interface used by the ss too=
l.
>           If unsure, say Y.
> +
> +config UNIX_BPF

Maybe UNIX_BPF_SOCKMAP or something.
bpf_iter is supported without this config.

> +       bool
> +       depends on UNIX
> +       default y if BPF_SYSCALL && NET_SOCK_MSG

