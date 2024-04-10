Return-Path: <netdev+bounces-86595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2837389F41C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D132842A3
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD27F16E864;
	Wed, 10 Apr 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mudwSMDD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6915ECED;
	Wed, 10 Apr 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755275; cv=none; b=OyN/S2Dmnr4l9Eno62bt7tl6QUeZKSlGZa5YJG+dkBxeTzfMvx1fMH7qZ6lOPXKn+mRTWDGaQ8mcGZuLNXnhbxr0u/Cm71AZj/FwkTyUTWylEZeQzrrbJ1xwtHNob3grCT1F+Tx2N/o8U4JwgFByU/x5SoeX8+zLJA21EPPH5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755275; c=relaxed/simple;
	bh=YAzgDCWdkIBsZ1fHAcolnRWmStXC86uj6PdEJXdnM9U=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=vAB4A5IA/wjQr5wdQGNk+E6q45q6wJUObxaUOl3tqBMJ/qyxDuJsnkizDmzJBOtTPTnIeEKqrAeyiOJsndeXN9le0WruS1B9u/9RZJBis45h/5BMf1OQZlws6TmTnewoxfqbDam/5t2vfyswnW1YJY1Y4JmyhAbM2cXty987nc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mudwSMDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1354C433F1;
	Wed, 10 Apr 2024 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712755275;
	bh=YAzgDCWdkIBsZ1fHAcolnRWmStXC86uj6PdEJXdnM9U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mudwSMDDJ5SIHutOBL1WqNRiDYh2j2LbLb2wv0kUcSkdE8FP/01uf/hi8QOKw4XCI
	 JzSrh6KcJqo6iJb/mBy7JkMPNHY5HRcEaW1TmwlrJXdFmJNgmTIvxaDQacI8Td3mKr
	 lrzYZx1ooXcfTZHxOIK8FvRcuGYuiXuYwKSGpG2dPX5zdu7iI1KQ4fycVYpdS+JDI9
	 Cc1u5VyVgmxSRN2fHgcqnR0CkTdds/QOuCz62WmNjvR5pXaffY5CO0ERWdgqe7ycga
	 WMjNElgGr9D6rrAh5MQQ82oB0dkG2HtFpHGuwm4OoAqwgQYgd9FkFeL9lzlz+WygeF
	 d8xHGI31pRrmw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL+tcoCk_RTp6EBiRQ96nrdN7cuY1z+zxzxepyar4nXEJkAB9A@mail.gmail.com>
References: <20240409100934.37725-1-kerneljasonxing@gmail.com> <20240409100934.37725-3-kerneljasonxing@gmail.com> <171275126085.4303.2994301700079496197@kwain> <CAL+tcoCk_RTp6EBiRQ96nrdN7cuY1z+zxzxepyar4nXEJkAB9A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] rstreason: prepare for passive reset
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, geliang@kernel.org, kuba@kernel.org, martineau@kernel.org, mathieu.desnoyers@efficios.com, matttbe@kernel.org, mhiramat@kernel.org, pabeni@redhat.com, rostedt@goodmis.org, mptcp@lists.linux.dev, linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 10 Apr 2024 15:21:12 +0200
Message-ID: <171275527215.4303.17205725451869291289@kwain>

Quoting Jason Xing (2024-04-10 14:54:51)
> Hi Antoine,
>=20
> On Wed, Apr 10, 2024 at 8:14=E2=80=AFPM Antoine Tenart <atenart@kernel.or=
g> wrote:
> >
> > Quoting Jason Xing (2024-04-09 12:09:30)
> > >         void            (*send_reset)(const struct sock *sk,
> > > -                                     struct sk_buff *skb);
> > > +                                     struct sk_buff *skb,
> > > +                                     int reason);
>=20
> > what should be 'reason' harder. Eg. when looking at the code or when
> > using BTF (to then install debugging probes with BPF) this is not
> > obvious.
>=20
> Only one number if we want to extract the reason with BPF, right? I
> haven't tried it.

Yes, we can get 'reason'. Knowing the type helps.

> > A similar approach could be done as the one used for drop reasons: enum
> > skb_drop_reason is used for parameters (eg. kfree_skb_reason) but other
> > valid values (subsystem drop reasons) can be used too if casted (to
> > u32). We could use 'enum sk_rst_reason' and cast the other values. WDYT?
>=20
> I have been haunted by this 'issue' for a long time...
>=20
> Are you suggesting doing so as below for readability:
> 1) replace the reason parameter in all the related functions (like
> .send_reset(), tcp_v4_send_reset(), etc) by using 'enum sk_rst_reason'
> type?
> 2) in patch [4/6], when it needs to pass the specific reason in those
> functions, we can cast it to 'enum sk_rst_reason'?
>=20
> One modification I just made based on this patchset if I understand corre=
ctly:
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 4889fccbf754..e0419b8496b5 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -725,7 +725,7 @@ static bool tcp_v4_ao_sign_reset(const struct sock
> *sk, struct sk_buff *skb,
>   */
>=20
>  static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
> -                             int reason)
> +                             enum sk_rst_reason reason)
>  {
>         const struct tcphdr *th =3D tcp_hdr(skb);
>         struct {
> @@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *=
skb)
>         return 0;
>=20
>  reset:
> -       tcp_v4_send_reset(rsk, skb, reason);
> +       tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
>  discard:
>         kfree_skb_reason(skb, reason);
>         /* Be careful here. If this function gets more complicated and
>=20

That's right. I think (u32) can also be used for the cast to make the
compiler happy in 2), but the above makes sense.

Thanks!
Antoine

