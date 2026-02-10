Return-Path: <netdev+bounces-258092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPOmDTo8i2neRgAAu9opvQ
	(envelope-from <netdev+bounces-258092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:10:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2A911BBB1
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28D7B3013AA7
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24E733F38A;
	Tue, 10 Feb 2026 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w2mXbjWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDD328B58
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732599; cv=pass; b=Y5KMkGFyusu9aR91NDA7Cht/7m0tP8lpl8QBBuGETBWTdc7O5+kt31Tc7iFm1nH7jOsVRD9mXAG5ZUuYiVgPhzOHL2UmfrzXJ/xyxDx3lme2lTn2pdW7WVPjey/BZWViH19OpXNpfbZI7gvSerkGYoM0u5tXdxt68ibwhDtORJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732599; c=relaxed/simple;
	bh=U0S6um2BGKXJ5w8oWqxAyyA5kDxKGinL3PiswODAyP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHpTFxwCUZWER/WYbXSy/4lrSzflBmsmxAftVrFui8TzCbZR/VYQAimzlUz0NpPzeIwHrSUl/k6+cM/HmQF/t9/kEYycKWJIeWbGyIV4AgjId6AXleaRBRIznrk3RfEgfBeDY6nG0FTVIBDzADtsXtLXHmHWgWZ0lbWUmF2Crrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w2mXbjWu; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5013d163e2fso46182121cf.0
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 06:09:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770732597; cv=none;
        d=google.com; s=arc-20240605;
        b=Mw3Wwuhe+WX/MY3eWatTjQVJU7o6C5lsZG+eevGOdStszj3tQpgsAFkmn538/AF009
         pT57t8keQFOu95eHWoZEdqivSrD+HOI1gEZj99OGePguWmV/zvOWZkXAyysqEVC+xcbL
         iCgb+Z0/6B0/cuAHncJLmcnviSp0LGgzhvDcd5FMhL2/sBvsSf/SoxqBE4+FiZjGK9XG
         Ex7/C2WGrUprz0ATYtGDDwxC/wg4tOHaQcl1Hw8uP/OK4x49hyh88gs0pb/5G5g958k7
         hUYWxZ21/JInyu1zmuzzljenBxFUKhCobZooihIzYfYe5QjYdZ+0HSPnOK/ZZD/QOdU7
         G6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rmx582iaWtPkn7IFMcFxUhlXGix/2+MlaaO5Gy71L9E=;
        fh=lNeRDVq5jmz8xXlLZnZ50jntotOqdVNPWr6vw8pxTn0=;
        b=WMFXMuJesRHcsngSwpC9N4fluJ8xjaig+Uwiqxbrf5xroaHupleCn2cIgwUOvaYS0y
         C7XkZbdJHqqweeIFSaAOSIKxjxl+gGsCCtD1bAvBX9wOaD3AVO2O/TW3NDMVeexeLTrI
         dxIdOFyRvHj/eAaAUQ+oYoZDvtCXv3CCtYpmhprd/pqFgxsAwPY5+AseOdx/GSnPeh6L
         1ie5ZRKfZqw4td3ACwEVxiTW3+zK1D3TD4UYOtv52SB+ug6kAdkSXQuHAFr5+WlYTLWy
         s8ntRzwbgEDUqhjepUZhwid0dAvfYODeQ8xq0HI2e/e4a2PGm4Wrn9kCUGl9LDa71tMm
         6JnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770732597; x=1771337397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmx582iaWtPkn7IFMcFxUhlXGix/2+MlaaO5Gy71L9E=;
        b=w2mXbjWuymE4iVykw7hERwQ9AULYAEaCViSrvWBuXxcEybaiB9RHMM3Ft5kG8kixGe
         krwTbKgiMtRUXDit+zx7g/vMFe5Hbipzo2KmfJzKze6ldcT4RJ3QBnPie2r6XXIOvArn
         1t2Uoh03p0bLfC+IRKxFkGPCCkLFyHKT89za3N73mRXUdibud/G5ZU0MVcvOoldldUG7
         3ltf+KV5qQ3bN1f0NnCjQuqyLlHAkfu0QjSIKawZblmJrG5uPmvQYXso/hvJ0oB8vzIj
         2E+RpWZdqMTpannyB9bVOewW2gpQDz5y+Lf5EhdpFtol5gUZc/9UI6KkpV4AjlZkCkwD
         yjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770732597; x=1771337397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rmx582iaWtPkn7IFMcFxUhlXGix/2+MlaaO5Gy71L9E=;
        b=WvSDs+kFdMIYkf21A3oOBeQ3Y89hV/jlhYSfQVC19agyku7QttmPY0M4WaerSeP/i2
         IXCd96e3EVzAE02KNCQ447XjGqdU3rJ4LvyxWCJyoqtJPGxD4USfhOcWeRTMyKHvqVh/
         X0gz44bz2J2Z2yk4ERI0RhHdUw70iu8N7+UB8fp/rRP4SLawBqazebV/bqLbvNzsxgu1
         3AC6cotN6X22P/z7VkNj07+UXZSNCmv4bvZVsN74NNFYCOHZ4O8dHarkVtDAFaUlvZD6
         q4DliEpq+ED1Q7yYDdP+tLW3r8hdymEg6CxwpqntQhbhWo4lpRtuoVQA8U2m4Pcm0u0o
         F65w==
X-Forwarded-Encrypted: i=1; AJvYcCUr2MKd3/K7sbXZVHrxwhj3z7Al2hWnBWIJI8Npz88HkppX8RV2l2ZpZIkxrSLAXelLzwrRPjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8IqzsSCoyNKCesynKInYrarAO9giZ5en79o4UQRMdwwP+D4nR
	9peS2BhEo/Ln02RLiiIJzSHwDpGGnaptdlMWGGWEWm3pdGWDLkCzEQFsWmVuqL73IAIvSoEaHLd
	ickNe44NCD4AnVkg2BR2HqsXn7IBAwUAPPiWdHaZj
X-Gm-Gg: AZuq6aLYmPF1VSCp/62f10K7xZ3YIjBVCfVa/OQqvkn+7FHV5d/8aIavZF/OEid5YA/
	TrhN5DFoFejmy+rWwWHH75NcNextWlB6e+lCdl9wctPOwcyIbYTaewchVjvwroAQVhnsVet5hrb
	efgz1d0uiR2yrcF7a1aqCUf7WiRku0cc5LNmp3MqIjzT6A4O8ryo58YSrML7rq5Qxzuu09XvnW8
	H4OBWxLSCD6KcTk2Ucc8RXXBEpA4pao16j41LG3btJXanFHUE47kClCy8cDXZZoxGH9V4LiDuuz
	oQeEIw==
X-Received: by 2002:a05:622a:1a89:b0:502:9a98:34cd with SMTP id
 d75a77b69052e-506399112a9mr199459531cf.22.1770732595305; Tue, 10 Feb 2026
 06:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203144053.83193-1-edumazet@google.com> <20260203144053.83193-4-edumazet@google.com>
 <20260203092636.20c6bb6e@kernel.org> <CANn89iKaHErtov9nnzQQ56XHGdrM--n+H3k2JEBM=v7MwyV-VQ@mail.gmail.com>
In-Reply-To: <CANn89iKaHErtov9nnzQQ56XHGdrM--n+H3k2JEBM=v7MwyV-VQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Feb 2026 15:09:43 +0100
X-Gm-Features: AZwV_Qjqy41xqWvqIRxhV-uTCUXpogQ3hjBoePQfzhDJ_B9xVId9VoaqzJlctGc
Message-ID: <CANn89i+9SaDWFt_9tjAiybrC7QbUoyJnk_qTcLTvDPKSC8+OtA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: make tcp_v{4,6}_send_check() static
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258092-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A2A911BBB1
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 7:18=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Feb 3, 2026 at 6:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Tue,  3 Feb 2026 14:40:53 +0000 Eric Dumazet wrote:
> > > tcp_v{4,6}_send_check() are only called from tcp_output.c
> > > and should be made static so that the compiler does not need
> > > to put an out of line copy of them.
> > >
> > > Remove (struct inet_connection_sock_af_ops) send_check field
> > > and use instead @net_header_len.
> > >
> > > Move @net_header_len close to @queue_xmit for data locality
> > > as both are used in TCP tx fast path.
> >
> > Seeing this in allmodconfig:
> >
> > net/ipv4/tcp_output.c:1482:13: warning: unused function 'tcp_v4_send_ch=
eck' [-Wunused-function]
> >  1482 | static void tcp_v4_send_check(struct sock *sk, struct sk_buff *=
skb)
> >       |             ^~~~~~~~~~~~~~~~~
>
> Silly me, I will squash this in V2 tomorrow, thanks.
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index fc9f096dff313d14b96a4d7d2724f9740aa55d61..0381112f05e6d48f70f4941ab=
c3af6e9b6b148d9
> 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1617,9 +1617,8 @@ static int __tcp_transmit_skb(struct sock *sk,
> struct sk_buff *skb,
>         if (likely(icsk->icsk_af_ops->net_header_len =3D=3D sizeof(struct=
 ipv6hdr)))
>                 tcp_v6_send_check(sk, skb);
>         else
> -#else
> -               tcp_v4_send_check(sk, skb);
>  #endif
> +               tcp_v4_send_check(sk, skb);
>
>         if (likely(tcb->tcp_flags & TCPHDR_ACK))
>                 tcp_event_ack_sent(sk, rcv_nxt);

It seems I forgot to send a V2, this will wait ~2 weeks ;)

