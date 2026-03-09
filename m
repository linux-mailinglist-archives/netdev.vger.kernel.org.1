Return-Path: <netdev+bounces-265421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNwtMJSSrml0GQIAu9opvQ
	(envelope-from <netdev+bounces-265421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:27:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25623625D
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19DB430626FD
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B0D3793AB;
	Mon,  9 Mar 2026 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fexixnws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082FB378802
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048173; cv=pass; b=avq66NOCQt5j/xi8kaBURqx/XDpzqGqojIo3GDEqlLi3VOaMzjyliBmHg++CicYiksdzkWg02RLHxap2G7Ucua2FZgFM7oXpdHp95LYF0CO4AghZCB5g0j4Lmso5hwiUVP2+amZKczNNl+Jbz1ROdDyoMSotIlDZubFz2jEcTns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048173; c=relaxed/simple;
	bh=upio09NojrFHMRimK65FKWysiVde+qA9+o9ztExC8qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUmqyA/4y0Xm3D7Ayk/BBZr5cilwEKy6ja7dAfVlK8YQKc24bXEVHHNLqaICxm1boCs6j0CGZl3uYc5Dt0h4uUXVcUYewIsWfh80PSOYnvSaTS9lVxrVt736Xe9mBp6wnYr/onkQK1l71pMc7vkHhcYdjzHJCzcqsQqEaGeGZJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fexixnws; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a747448dso102119651cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 02:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773048171; cv=none;
        d=google.com; s=arc-20240605;
        b=cqv55Vw51tTscOVloEaxKApLrhQ4vPUT9wPRZdA/B95vlef5nb9XtVKLXLwKOO3B2f
         k3pGxY97QPd501ZdCpjuxpahBfAyIl8J9r7zjvHJ4CM2dzlKrr6feWN4MeNhc0ZeR9ze
         ott57+w3Gs+jmgibHpFFMulI0tH1Zz/w7nu5paqNELMRwLOKbY2vE1aBxNOhsrrnI9AX
         QbamSstSnOosXcZQuHPjv9nfP9Xd8QDP+1MiP4u1ce167njzhRIrMrw0x5cAnvxbgRG5
         jiiInH2Nk51qF8Uhvbt+sY/wNR6ttyZLTObOVko0JFR7b9vpWzIqux1+CHD6WOZAiuKY
         9oRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N7fC3bjKwQcF/Me1NQG71BV/tCAMZf7S0tDB0ddNnBM=;
        fh=6mNe/Pjj4YaM+2peoPL1+h3eOme+i3QCNe7VOf7U//E=;
        b=YA6yzT1e3bKO+4mTTG1yUZfUMHOuHWDy9d08TqmLnkxDEURoNO1ltN/lbDy4Nuph/E
         wWTyReZsaOWL44GI9SEDJq+Ivkc6shk7qnUsjfqDDdZTithBpVb50Gtr1WdlTK/2B5Az
         NCNA3tb6uazvW5tIrAn+hr6VLIk1HVL85+GsNdEcbteQf7zgMlb4hXURfipvmGDebtGk
         31bgjF47HYO08mlrAQTzoS+YmxVYSVW65pehKv3WTTq/B4TUiZpk7PddpdlT0Sk5a8Ky
         DVQatoctbk+UiFeCt1n9qeguGeqjU1zZj+ltYQtIRxNCDSM/xwH5nnybas66RFV47Zwh
         yvDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773048171; x=1773652971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7fC3bjKwQcF/Me1NQG71BV/tCAMZf7S0tDB0ddNnBM=;
        b=fexixnwskWyap/xV0vuQW1vre2lrsKvrlUl4bS1mgw54DXmcLrk0oZJimMGz8kIarm
         Q3ELG5dzOKm6C5zpFk+F5FrL5QJFHGhnDCU13/B0yhT2a8HHxfZdOsbSRnyxhoxB/S0D
         yllytPkipre5Wq8gYM4/c85/LFZQS03gacEkv6bbKbQlyp/u1c4E/Ze0EbH1Oy/6i2Sy
         jeZiBBTSt1G8SRsAwldNqm5V/4Cebb0t36JrukuhrGTxwKAUc576eJXoYXIrEFAXM3l/
         Ba2HHiCLRMVQou9gdxUyP9Vpzh8HzjcDumT2c8HlRaCLamc/1Sp2sIrSQBmKd3860kcW
         DCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773048171; x=1773652971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7fC3bjKwQcF/Me1NQG71BV/tCAMZf7S0tDB0ddNnBM=;
        b=G4Pw4hynUBlLLjzXhpgJIhwkbtABlx/k96x3XV6O9JM383FosRB5Yh1lyd4JIwVkoi
         M3b6XTdYdUvN6LcAqIOxO89Ug2XJ/MEDn+fsKnN2iEqAjvtNhFd8ETRH/bf3BkadskCc
         s4ikB+AKLVdrhwViz6eEYbB4KhtdxDK2c0pKvjLOav2sJZgZCxANW2ZdJS+ningbCqPG
         lOCVIOPpfZmypwIKB7y9HblW8k/SnDlBvkGrLFjKoQe1J7svWOjt+wUvv/+eoO+x8tLk
         sAVNw+n08xNSzz3kQO7jKrcb+21pxPH36hMWvgnP9Rk5742jYzl9NxINXIu0gwy4ICW8
         h6sw==
X-Forwarded-Encrypted: i=1; AJvYcCUHrF3FJjUvZKdIO/ULwJClT6QgqITOju2jnvjBrumhSiS5RwQNM4tcgRImGxCDi3Li9NgNxVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYmw3jsuM70ajbY0B0/XUgQy5JfX2BdMb/0pSFLlF3w9Io1pd
	mnwBBlc/cRsNQIPIbIPcTTNDN3oMfamub79eJiJVP5NBa8xGQv4TalF5eH4olfpgX5ZUSKWAVy4
	efm04pjcaVU6ZVFhtcNtBuoHioUfQoZVunLkii4G4
X-Gm-Gg: ATEYQzzdSokOb8I3Q1yohz6M61no/Fk+ec5zexfP37glGDv1TKlFRg2J2oziLn5vTP/
	sVhfgdWsN4kwtMFmL6E950lmt6dPwrn6P5S4v0Lf1h8LdUlYGtMmj998nO3ZMLhsSlI7Y6Yb2h4
	SoyboUBdSoejKxx0Zp9/FML3BzLTHOP+XIqVruCfhIBYNvm0AlI/JVTSTYTvP/VPHIAM7hN9/wl
	Hp2pI5WvVDZXPEJe8jpzKi+0DFI0aVYptJ1Eyozkh19MsIB/fMmbC2bBTUi8PCqwMrxY4uEdywE
	hC21H2kdG+cfIrE9rQ==
X-Received: by 2002:a05:622a:7c91:b0:509:882:9e72 with SMTP id
 d75a77b69052e-5090882e153mr50961191cf.1.1773048170529; Mon, 09 Mar 2026
 02:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 10:22:39 +0100
X-Gm-Features: AaiRm515VzWer9rfQTDKEwoECAFtXOyO-47wB6RLAYk2qz4MnRNOLIFCZe96lfc
Message-ID: <CANn89i+38t+PpB5duS_-FX_=PwyCQaN2HYohocJBAvZ7Cd8-KQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/6] tcp: implement RFC 7323 window retraction
 receiver requirements
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1E25623625D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265421-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 9:03=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> By default, the Linux TCP implementation does not shrink the
> advertised window (RFC 7323 calls this "window retraction") with the
> following exceptions:
>
> - When an incoming segment cannot be added due to the receive buffer
>   running out of memory. Since commit 8c670bdfa58e ("tcp: correct
>   handling of extreme memory squeeze") a zero window will be
>   advertised in this case. It turns out that reaching the required
>   memory pressure is easy when window scaling is in use. In the
>   simplest case, sending a sufficient number of segments smaller than
>   the scale factor to a receiver that does not read data is enough.
>
> - Commit b650d953cd39 ("tcp: enforce receive buffer memory limits by
>   allowing the tcp window to shrink") addressed the "eating memory"
>   problem by introducing a sysctl knob that allows shrinking the
>   window before running out of memory.
>
> However, RFC 7323 does not only state that shrinking the window is
> necessary in some cases, it also formulates requirements for TCP
> implementations when doing so (Section 2.4).
>
> This commit addresses the receiver-side requirements: After retracting
> the window, the peer may have a snd_nxt that lies within a previously
> advertised window but is now beyond the retracted window. This means
> that all incoming segments (including pure ACKs) will be rejected
> until the application happens to read enough data to let the peer's
> snd_nxt be in window again (which may be never).
>
> To comply with RFC 7323, the receiver MUST honor any segment that
> would have been in window for any ACK sent by the receiver and, when
> window scaling is in effect, SHOULD track the maximum window sequence
> number it has advertised. This patch tracks that maximum window
> sequence number rcv_mwnd_seq throughout the connection and uses it in
> tcp_sequence() when deciding whether a segment is acceptable.
>
> rcv_mwnd_seq is updated together with rcv_wup and rcv_wnd in
> tcp_select_window(). If we count tcp_sequence() as fast path, it is
> read in the fast path. Therefore, rcv_mwnd_seq is put into rcv_wnd's
> cacheline group.
>
> The logic for handling received data in tcp_data_queue() is already
> sufficient and does not need to be updated.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

...

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index f0ebcc7e287173be6198fd100130e7ba1a1dbf03..c86910d147f2394bf414d7691=
d8f90ed41c1b0e3 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -293,6 +293,7 @@ static u16 tcp_select_window(struct sock *sk)
>                 tp->pred_flags =3D 0;
>                 tp->rcv_wnd =3D 0;
>                 tp->rcv_wup =3D tp->rcv_nxt;
> +               tcp_update_max_rcv_wnd_seq(tp);

Presumably we do not need  tcp_update_max_rcv_wnd_seq() here ?

Otherwise patch looks good, thanks.

