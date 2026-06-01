Return-Path: <netdev+bounces-293595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAJmGo01HWoqWQkAu9opvQ
	(envelope-from <netdev+bounces-293595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:32:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA88B61AEB4
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F312D30547DD
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371BC384CEE;
	Mon,  1 Jun 2026 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTfl+NJ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A133845BC
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298814; cv=pass; b=WH46iqSULrfYxbrmqDIRdv9moIqNjq+fmBDUbGjp7Xa95vcCuSy+xO6NSkPIkbEsQUD8Y3kQn5wZp0zttIbQBAgVzUu0EMsRuBCN2UKO0VCQSf/JIXx0DJBt7dCBBrsLa5cr095XHwQBv90y9/4HoC60J79ZpzYuErQHe+IAmlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298814; c=relaxed/simple;
	bh=oZo0Gies88mOxdZUi76BlAfTbLB1IyaI+zeIseUnRZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqBi04MEd66eQbV5e8xLm9xww7WgBBg39ytEQSxQwukSTtfEwelWatMjlPT02Yvcpa62sBzfPccNGPqX4q7E8Ol4dI4HVUI+NFvBbHI24jjxyC2m6eNdgsuJYQkIr1pGj1RSiyq6oqUQZ5y9Rhfg8dZ8Fd+j2ppba8PPiOBZkuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sTfl+NJ9; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-516d15ed2bcso92216981cf.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 00:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780298811; cv=none;
        d=google.com; s=arc-20240605;
        b=IkiLkEb1+5i+FZskEHZ7ERZO++MHlHTXhsKlV/25R3usSuXTjxTaLUN9rxhqQB8Aku
         Me1sIX/emGDIKLuyi7XAinV85jwNPnAC3I273BKq7OikRB55v+a5Lyms8WTAyei9uZlj
         3T48CAIk34DLsfXU+seUQljV35tluEoc3oIu2yt3cTFsIzbpnBfOYCULIKtH5mIeIKdt
         R5LtcWb2Ep6cuaBNbbxO0o51o4MOj7eX6Ne+f5BP3GUKV9rNfArfJ5mXGIceniS1BlQk
         JwKpsho5LV8ZcyPb6/klWaQUKR5vqdTcIo4i/sii8XbWeTBoz3SoDKwNqW3ByLckzo4D
         dR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0j2fQXrURv2vHABUn/uvXXmbgLtu4ew+Ljyj3acdU54=;
        fh=HvTETiZgcctTTssaqq9LxZhqwFNWaplZznJv0Eeqs7Q=;
        b=O7e5KVN+QAkfnzkMCMunhuc8wonxD7hWt2V+hOhfFhnjvg8qheJNd6CKWcywwLB03L
         x3L9T+8eVsh7ejfM3ACt26CU0MCvpn24BaXoHcEypVhNjEgCIPyd1D/qM5jY+6YpEiN7
         EwhA4l23NpMi4zBWN7oJ1Qhh5SM9Oxa9OJ6vDTJyOSGuOywGXox92uH6yueqsWXACBBE
         jqr8haIXAzbSYmCmXjIh5fzZLnEcACXnL0QMIAGMxSMuv3RPNFmKhYbTpwNbVrHCwQkV
         f8h5raBYINRsV1YCgZGjHg3dDM/IsuHIbVhy/X5wqqYwW82P3LB9C2ftLfh8FtaYJ1bS
         7oDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780298811; x=1780903611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j2fQXrURv2vHABUn/uvXXmbgLtu4ew+Ljyj3acdU54=;
        b=sTfl+NJ9lJNXb2F9RcUcGcmVn2VBwo4aD4oJesYrvvb/0Xtn4QVwkZM8L6D1PXV+fk
         hJq738+Y3AcHgU9/s8VVo1uXoInuGzQpyJmMCcRxRwrOJ0dmYS7lGrMkytvJdPaTUBYG
         usVyhlzvKcXzYy9Dkxf2Jv2emevMLrWsjmA5RDxeFmkhKzc6mhjgZNjh2dMHhJu9AC2m
         4Ck/NdTkHWGXSvNTA2K8a5GbVMWnwJ4ueEdxC5BR4E0OKPYOwkgbueQqeJwgdcPO/l+G
         DhJtfI0k7TVK48VjkOTXftplGlfj8zhTKiJRxxJDV2bLNx67SohnDae0nIvyXzS0UEtL
         6EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780298811; x=1780903611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0j2fQXrURv2vHABUn/uvXXmbgLtu4ew+Ljyj3acdU54=;
        b=Y3SGIdDPQAdddDhcJOtuEQ7Vl1Y86f/x7KU+5oCWF/AmoNWSpcYcLkBEKBIkFQ/9co
         uKadJVyrsTpuO9te+Q+ZJSGCCHUqPbmT6f+R5lBGm8vW16QVWzkrLoWjpzxkiXKLwjx6
         xNB96uCVaJMsaSiU5qanYNDVLdmyQ1x7vPxTKgaTLRjW5kzX3hNDYZh+/+LRCkVHPmrM
         030aqYvMxD6HHiUksdXwj75lRFScj9C6+JeIGq1KE9lOyEFsu32c0QZctzavfcMqwfsB
         ryWmGpse9HpvnjTrNjUMPKKu1Yo2KrDgL3+/A5QniiStbEGQsPCLGyPyUYgxOkFuHAxL
         bEqA==
X-Forwarded-Encrypted: i=1; AFNElJ/91/DNSx9QGAKiJuCJ2TFTso6tZfmDIdTP3LsCG2ruaSguEjNDQgWj1sqCsvNUM0Z9toSgwWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtAyg8c14qQok8duN3lzI6l0jXmKFj2bcTvzcw2dWYIxP4i2BT
	EecIkSmrCMHKKemaGexvY6M4TIJLaqVHxK+QYGGAq3cKiCpmNVSB/3RUWcuCEFSGzUkfweoBiPV
	mfHvFwoTz+8DqxGQQRnrxNwc6Nxvv2Ef3xEScTcAC
X-Gm-Gg: Acq92OEOyIPSfaaidQGy9S8NpGO/M0AAG5w25AYyAfcyEHF/BbYEuLWTD8ErN9EACdF
	3gDgJFDMR2HigXyYoSMQg8Vdtdj/aV+0QOGRjOYFx8wti79L+PiueJM9oQkf7+f/bwrDSZraIOB
	veK0pyOLtcx4uLqUmCxn3bozrs8yNqDVmXITJ8FUEYPZH1hn2NJWXB6o+TQwKcxCCX2hlX5QKcY
	sdiK8PAlP2A8jgeP2CGX6idNY8hOPsLvWafC3G7KQsMy0DKdwVGX5WsJLoFsSUE6zYHAMfdlv5H
	YbiTqBVt4DzDcPhTNoxaLlpqId5m5osnVHf/stordkwIg6ds+9BWubkIWjmcGI50bqp9uXaWU+M
	N/laLi+6D58vOqe2Y2T+4fe5UekJaDA==
X-Received: by 2002:ac8:6f08:0:b0:516:cd8d:c7fa with SMTP id
 d75a77b69052e-5172dd0622dmr162730461cf.39.1780298810418; Mon, 01 Jun 2026
 00:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
 <20260601-net-next-mptcp-add-addr6-port-ts-v1-5-4fc25dfef62e@kernel.org>
 <CANn89iLdwhhwLyO6zRjWMEY3t9g60ZE8ZhOVx33ucg_uRETbmQ@mail.gmail.com> <1f3aea3b-1bb0-4584-8f6d-af14d73df81d@kernel.org>
In-Reply-To: <1f3aea3b-1bb0-4584-8f6d-af14d73df81d@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 00:26:38 -0700
X-Gm-Features: AVHnY4KvZ2b3I2Huj1-TUxuXz92NDdjpsYdkctVUOdNphLvQcjd7YsWKT5SPwr0
Message-ID: <CANn89iLBh-tSEzDuZce5G2dmC6An1agoJ9UNq2qwAAC0+oTuPg@mail.gmail.com>
Subject: Re: [PATCH net-next 05/11] tcp: allow mptcp to drop TS for some packets
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293595-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vmlinux.new:url]
X-Rspamd-Queue-Id: BA88B61AEB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 11:52=E2=80=AFPM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Eric,
>
> Thank you for the review!
>
> On 01/06/2026 16:04, Eric Dumazet wrote:
> > On Sun, May 31, 2026 at 10:25=E2=80=AFPM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> >>
> >> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
> >> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
> >> this case, it is then not possible to send the address signal.
> >>
> >> The idea is to let MPTCP dropping the TCP-timestamps option for some
> >> specific packets, to be able to send some specific pure ACK carrying >=
28
> >> bytes of MPTCP options, like with this specific ADD_ADDR. A new
> >> parameter is passed from tcp_established_options to the MPTCP side to
> >> indicate if the TCP TS option is used, and if it should be dropped. Th=
e
> >> next commit implements the part on MPTCP side, but split into two
> >> patches to help TCP maintainers to identify the modifications on TCP
> >> side. This feature will be controlled by a new add_addr_v6_port_drop_t=
s
> >> MPTCP sysctl knob.
> >>
> >> It is important to keep in mind that dropping the TCP timestamps optio=
n
> >> for one packet of the connection could eventually disrupt some
> >> middleboxes: even if it should be unlikely, they could drop the packet
> >> or even block the connection. That's why this new feature will be
> >> controlled by a sysctl knob.
> >>
> >> Note that it would be technically possible to squeeze both options int=
o
> >> the header if the ADD_ADDR is first written, and then the TCP timestam=
ps
> >> without the NOPs preceding it. But this means more modifications on TC=
P
> >> side, plus some middleboxes could still be disrupted by that.
> >>
> >> About the implementation, instead of passing a new boolean (drop_ts),
> >> another option would be to pass the whole option structure (opts),
> >> but 'struct tcp_out_options' is currently defined in tcp_output.c, and
> >> would need to be exported. Plus that means the removal of the TCP TS
> >> option would be done on the MPTCP side, and not here on the TCP side.
> >> It feels clearer to remove other TCP options from the TCP side, than
> >> hiding that from the MPTCP side.
> >>
> >> Yet an other alternative would be to pass the size already taken by th=
e
> >> other TCP options, and have a way to drop them all when needed. But th=
is
> >> feels better to target only the timestamps option where dropping it
> >> should be safe, even if it is currently the only option that would be
> >> set before MPTCP, when MPTCP is used.
> >>
> >> Reviewed-by: Mat Martineau <martineau@kernel.org>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >> To: Neal Cardwell <ncardwell@google.com>
> >> To: Kuniyuki Iwashima <kuniyu@google.com>
> >> ---
> >>  include/net/mptcp.h   | 3 ++-
> >>  net/ipv4/tcp_output.c | 6 +++++-
> >>  net/mptcp/options.c   | 3 ++-
> >>  3 files changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> >> index f7263fe2a2e4..000b6593bfa4 100644
> >> --- a/include/net/mptcp.h
> >> +++ b/include/net/mptcp.h
> >> @@ -151,7 +151,7 @@ bool mptcp_synack_options(const struct request_soc=
k *req, unsigned int *size,
> >>                           struct mptcp_out_options *opts);
> >>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> >>                                unsigned int *size, unsigned int remain=
ing,
> >> -                              struct mptcp_out_options *opts);
> >> +                              bool *drop_ts, struct mptcp_out_options=
 *opts);
> >>  bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
> >>
> >>  void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_s=
ock *tp,
> >> @@ -270,6 +270,7 @@ static inline bool mptcp_established_options(struc=
t sock *sk,
> >>                                              struct sk_buff *skb,
> >>                                              unsigned int *size,
> >>                                              unsigned int remaining,
> >> +                                            bool *drop_ts,
> >>                                              struct mptcp_out_options =
*opts)
> >>  {
> >>         return false;
> >> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> >> index ef0c10cd31c7..53ee4c8f5f8c 100644
> >> --- a/net/ipv4/tcp_output.c
> >> +++ b/net/ipv4/tcp_output.c
> >> @@ -1181,12 +1181,16 @@ static unsigned int tcp_established_options(st=
ruct sock *sk, struct sk_buff *skb
> >>          */
> >>         if (sk_is_mptcp(sk)) {
> >>                 unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size=
;
> >> +               bool drop_ts =3D opts->options & OPTION_TS;
> >>                 unsigned int opt_size =3D 0;
> >>
> >>                 if (mptcp_established_options(sk, skb, &opt_size, rema=
ining,
> >> -                                             &opts->mptcp)) {
> >> +                                             &drop_ts, &opts->mptcp))=
 {
> >>                         opts->options |=3D OPTION_MPTCP;
> >>                         size +=3D opt_size;
> >> +
> >> +                       if (drop_ts)
> >> +                               opts->options &=3D ~OPTION_TS;
> >>                 }
> >>         }
> >
> > Passing local variables' addresses forces the compiler to use a stack
> > canary in this hot function, even for non-MPTCP flows.
> >
> > I was about to test the following patch, which removes the current
> > stack canary caused by MPTCP :/
>
> Sorry, I didn't know you were planning to do that.
>
> Would that be OK for you if I use an unused bit in opts->mptcp? It's a
> bit "hackish", but it avoids adding a new local variable address. Or do
> you have another idea?
>
> The modifications in net/ipv4/tcp_output.c would then be limited to:
>
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index ef0c10cd31c7..f4edc9c4f3fc 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1181,12 +1181,18 @@ static unsigned int tcp_established_options(struc=
t sock *sk, struct sk_buff *skb
>          */
>         if (sk_is_mptcp(sk)) {
>                 unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> +               bool has_ts =3D opts->options & OPTION_TS;
>                 unsigned int opt_size =3D 0;
>
>                 if (mptcp_established_options(sk, skb, &opt_size, remaini=
ng,
> -                                             &opts->mptcp)) {
> +                                             has_ts, &opts->mptcp)) {
>                         opts->options |=3D OPTION_MPTCP;
>                         size +=3D opt_size;
> +
> +#if IS_ENABLED(CONFIG_MPTCP)
> +                       if (opts->mptcp.drop_ts)
> +                               opts->options &=3D ~OPTION_TS;
> +#endif

SGTM, but maybe the IS_ENABLED() is not needed in this block,
guarded by  if (sk_is_mptcp(sk))  ?

Also I am unsure opts->mptcp.drop_ts is cleared already before
reaching  tcp_established_options()?

>                 }
>         }
>
>
> I can also avoid adding a new parameter in mptcp_established_options
> (bool has_ts) by setting opts->mptcp.drop_ts before calling it, but
> that's clearer with this new parameter I think.
>
> > $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> > add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-92 (-92)
> > Function                                     old     new   delta
> > tcp_options_write.isra                      1423    1407     -16
> > mptcp_established_options                   2746    2720     -26
> > tcp_established_options                      553     503     -50
> > Total: Before=3D22110750, After=3D22110658, chg -0.00%
> >
>
> Good reduction!
>
> (...)
>
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index ef0c10cd31c71ff585a937fde37f2b08b1214b5a..594ec6ba02d5413d43842f7=
9aefbf4d8355c4f3f
> > 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -1183,10 +1183,11 @@ static unsigned int
> > tcp_established_options(struct sock *sk, struct sk_buff *skb
> >                 unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> >                 unsigned int opt_size =3D 0;
> >
> > -               if (mptcp_established_options(sk, skb, &opt_size, remai=
ning,
> > -                                             &opts->mptcp)) {
> > +               opt_size =3D mptcp_established_options(sk, skb, remaini=
ng,
> > +                                                    &opts->mptcp);
> > +               if (opt_size) {
> >                         opts->options |=3D OPTION_MPTCP;
> > -                       size +=3D opt_size;
> > +                       size +=3D (opt_size & 63);
>
> Nice trick! What about returning a negative number when the MPTCP option
> is not needed? Just to avoid playing with masks in the code?

Yes, that would work, thanks.

I can provide a patch in a couple of hours.

