Return-Path: <netdev+bounces-265906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ONpGSHLr2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:41:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAD3246834
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B344C3027954
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847313D7D76;
	Tue, 10 Mar 2026 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXVrHKTx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D803E95B9
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128476; cv=pass; b=nBx3rW3Dkt5WBp21fPtxOzpMMVM4ejB/VEyXLy+LSw32MLngPmdHR1IQdOjaEn46fHO7gd0PBSugyCQgb+D2sR+pBeIx6HxK34EeIaZd56qSo4yuPaIPuIe6fi7IQ1skqEl+Rvu6rhK+vvYlXZMHrVOS7bG/pJkbiJdqBlRbezs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128476; c=relaxed/simple;
	bh=7cTgaURun945ZBxkV8bmKWLaXe5u+DBTf6pF7YLrF4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWtgtKZd/jSGt9l12EmXOJpLEDD0Difnugj+N1S3JlRmtQByiF5POEDozD/3rkfQ+epfV2kJ1AmNFl45HarZyqYCQ6eQUWY+KHQhwyg3tRUY/mqQKRNI/tYpRHSE7L86xqeWz6oxjkojBFykRqQ10Pzif8LZvwuUBQ0CHAkxFQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXVrHKTx; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50917e02532so25458881cf.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773128469; cv=none;
        d=google.com; s=arc-20240605;
        b=acw7Pds2QQUA953w6t6GXSJWLQUcRlzz3AitIFFMOWsf8uJsWAKa1Bjp2s9b9/m7Jt
         IGveKkrXmWMabQJvrteVf+A5u9xnF94S5OM72IOsMmFEpilF+ZBYm4xK++Dg5TxnviJT
         UMOFeWoIAMHyVHAK7Flqm6LPdbkkX89GxRFwDzhkNNDtWyQfDccjp6MnNkwt6YMMtqO/
         X8BlFeJjnqM+BvgPcrL9g/vBpBUFRXhaHPee3bUj+F8yC9xy1orBDpOEvvmVMiQPZCNW
         0PjiZtP1B4RZ726qRgyyeROFP5uFek2xLs8gcIEdqSfevfTvUQRUhbiaNdxQ4OZnO797
         0l7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rcMzOrru+dNP0H3b9Nuh0ONkl84RLF9HUfefvP22L6g=;
        fh=AU/+lTBjqOEyzlgbhoc002RwWtzEVOEA8m+7lupOh3Q=;
        b=DwnpaeCz0dn4+BCEDpgM9Y7jwQLn8DFkU3cS5NdkxBkcGW0ynthLQqSuMD0uSvOI/2
         dy/ZH+La/+YkAAbpekbCqi0jE4RJYU+NIUH0fSwmwyfj/byluKStDCV54opImdXJSZYD
         /QIWZS3fm/c2tygVHsQRwqOATANcOH24higM03cDnquJek/wOPnxIvY758VlR+RjrDOZ
         yjVOHQ2bDMClvJRDe4J5PlkgXCIhmWGVKcZVX2NPGnSzh7ezyrypbp01Qk7Wy8qASv7c
         7K7v89sAdaQBBey3wm/ruSvTS2gj2KMDJsqfTciJNcrQM0p1hIc5FsS11sgykN0mPuBu
         0b1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773128469; x=1773733269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcMzOrru+dNP0H3b9Nuh0ONkl84RLF9HUfefvP22L6g=;
        b=aXVrHKTxHQAxiU/zPZOLkC1z6p8cJocbwkVWQbLD6aegwfelc7y3aC+RRkXHga1Sie
         XCo3HdWFhKcXWrm1LIqa7cF35EwGqzbRq6neMd5gF8fCGZg9WEgfuYEbiviOPDj6oZ18
         aIgsniUYS25+4tBcFH4BilSRm72bCzdY0Y7JClg3yh3YudwyR/dsVWyssX/yVopGxAGV
         xNkahW+xAZ1ImQkuJn3O1GCcLA5V0WY4ced7lwzOF83Gza94gSykTR2rsbgT/NGlVk1K
         OWHRnNlj74CwW06+xvfUd/gfN+GHVQEaosZy49zX9VnwIZq9L0MRBp8yiUYqAX+vzXYb
         KFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128469; x=1773733269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rcMzOrru+dNP0H3b9Nuh0ONkl84RLF9HUfefvP22L6g=;
        b=A1VsGKsoDdcIe6jbVO1s6+3OVDVd7gmsIvDan9X56FzStRh0jZjST+L+/Uq4Qx+B0P
         HPfjJSu/aHZXNeh1QHLh0b4aQ2RJSTFG+iAHdyXFQGG26ZVtsaECSW29y6l4eRTnMUf0
         cXfb0fkqCHoM97IEUfwEltQ/sGTVAbSVRECHajUV2zAqf7Dkonv9EJBGvz3TyFVF0/fl
         mKsjX4+L4sGtpTKNXXzTj3zI7juLVxd/4rrP/KRhONU4VRjgy1kV8SQZJdVvLSxVzzXJ
         /EREyuccMwDj2RkXQ9f/Jf6QQOqjL3Xf1jo/pNWxSRg5DkOKdvWW+kFJLKObDySxiBpd
         H1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnmSPhAYy9BA6EcvE4BWyq8tLT8k0H/S61kUPhsmQttdJu9jyffHJOz9OjOvYySLSRqf3GAIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0zr2wbBdLu4JvonVqsrNuRsc3CQ7ePrOstTU3qjhY0zEGiq43
	1uGCZOI/2FagXvTdROKJIVRQ822r071huRnephUsyTNwOehTwujXHWPExmD1IcLJTfe0XGd26jt
	D7tdOrAHo9DWqhPjvcoK3OxhOqj/136Bn+6OqPA3N
X-Gm-Gg: ATEYQzzIK2f1+k2g1a+bXdD7l+oqXhNQbP+3FwYKj1C9uq33fbclpjuepg6zX4b0I2u
	aTemH5ZX9N4HHXXO2L7gpJgUKDEQG+1JI4aAATAGd9Qda5rmxB+LU7BMm66lUXg3vgQyeL95KX4
	/izeQCGcfgDZFH/kc6ow/fUBP585XVUyCehSJj1jcRhbhJoaKFL3MZ2r/qAKR08l+UoyJ14blb2
	fGokMTbC+cTr5RUNjVtSI4UDQj/e2/UI/e2zh32w81BAMu++IbYMYiMv493tLLAL1pCH19nyMyw
	RYNePI4=
X-Received: by 2002:a05:622a:144c:b0:509:1d55:6368 with SMTP id
 d75a77b69052e-5091d556a83mr65534491cf.39.1773128468646; Tue, 10 Mar 2026
 00:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
 <CANn89i+38t+PpB5duS_-FX_=PwyCQaN2HYohocJBAvZ7Cd8-KQ@mail.gmail.com> <aa8S5pEbxXIG5oZQ@gandalf.schnuecks.de>
In-Reply-To: <aa8S5pEbxXIG5oZQ@gandalf.schnuecks.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 08:40:57 +0100
X-Gm-Features: AaiRm51UmLT8Xio3yOAS3_qG-3b3ZlXXtISzZ5JqQOuDaTGLlV85GE2K7N5HJFc
Message-ID: <CANn89iJeVSfU3_Ub023j5mo5g=bTxTw_A+5-dPw59DaXFrLmDA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/6] tcp: implement RFC 7323 window retraction
 receiver requirements
To: Simon Baatz <gmbnomis@gmail.com>
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
X-Rspamd-Queue-Id: 4FAD3246834
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265906-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 7:35=E2=80=AFPM Simon Baatz <gmbnomis@gmail.com> wro=
te:
>
> Hi Eric,
>
> thank you for the quick review.
>
> On Mon, Mar 09, 2026 at 10:22:39AM +0100, Eric Dumazet wrote:
> > On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> > <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> > >
> > > From: Simon Baatz <gmbnomis@gmail.com>
> > >
> > > By default, the Linux TCP implementation does not shrink the
> > > advertised window (RFC 7323 calls this "window retraction") with the
> > > following exceptions:
> > >
> > > - When an incoming segment cannot be added due to the receive buffer
> > >   running out of memory. Since commit 8c670bdfa58e ("tcp: correct
> > >   handling of extreme memory squeeze") a zero window will be
> > >   advertised in this case. It turns out that reaching the required
> > >   memory pressure is easy when window scaling is in use. In the
> > >   simplest case, sending a sufficient number of segments smaller than
> > >   the scale factor to a receiver that does not read data is enough.
> > >
> > > - Commit b650d953cd39 ("tcp: enforce receive buffer memory limits by
> > >   allowing the tcp window to shrink") addressed the "eating memory"
> > >   problem by introducing a sysctl knob that allows shrinking the
> > >   window before running out of memory.
> > >
> > > However, RFC 7323 does not only state that shrinking the window is
> > > necessary in some cases, it also formulates requirements for TCP
> > > implementations when doing so (Section 2.4).
> > >
> > > This commit addresses the receiver-side requirements: After retractin=
g
> > > the window, the peer may have a snd_nxt that lies within a previously
> > > advertised window but is now beyond the retracted window. This means
> > > that all incoming segments (including pure ACKs) will be rejected
> > > until the application happens to read enough data to let the peer's
> > > snd_nxt be in window again (which may be never).
> > >
> > > To comply with RFC 7323, the receiver MUST honor any segment that
> > > would have been in window for any ACK sent by the receiver and, when
> > > window scaling is in effect, SHOULD track the maximum window sequence
> > > number it has advertised. This patch tracks that maximum window
> > > sequence number rcv_mwnd_seq throughout the connection and uses it in
> > > tcp_sequence() when deciding whether a segment is acceptable.
> > >
> > > rcv_mwnd_seq is updated together with rcv_wup and rcv_wnd in
> > > tcp_select_window(). If we count tcp_sequence() as fast path, it is
> > > read in the fast path. Therefore, rcv_mwnd_seq is put into rcv_wnd's
> > > cacheline group.
> > >
> > > The logic for handling received data in tcp_data_queue() is already
> > > sufficient and does not need to be updated.
> > >
> > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> >
> > ...
> >
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index f0ebcc7e287173be6198fd100130e7ba1a1dbf03..c86910d147f2394bf414d=
7691d8f90ed41c1b0e3 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -293,6 +293,7 @@ static u16 tcp_select_window(struct sock *sk)
> > >                 tp->pred_flags =3D 0;
> > >                 tp->rcv_wnd =3D 0;
> > >                 tp->rcv_wup =3D tp->rcv_nxt;
> > > +               tcp_update_max_rcv_wnd_seq(tp);
> >
> > Presumably we do not need  tcp_update_max_rcv_wnd_seq() here ?
>
> When we don't update here and are forced to accept a beyond-window
> packet because the receive queue is empty, we can reach a state where
>
>  rcv_mwnd_seq < rcv_wup + rcv_wnd =3D=3D rcv_nxt
>
> I noticed this case when instrumenting the kernel and got violations
> of the invariant rcv_wup + rcv_wnd <=3D rcv_mwnd_seq.
>
> So, while not strictly needed (tcp_max_receive_window() would still
> be 0 as rcv_nxt > rcv_mwnd_seq), I opted to include the call here to
> keep rcv_mwnd_seq the actual maximum sequence number at all times.

Fair enough, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

