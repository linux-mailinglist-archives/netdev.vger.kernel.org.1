Return-Path: <netdev+bounces-256607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIE+ETb8gmm6gAMAu9opvQ
	(envelope-from <netdev+bounces-256607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:58:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BB0E2DF0
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 908373018599
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE738F245;
	Wed,  4 Feb 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUobRJSn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD1738E11F
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770191917; cv=pass; b=WgYFOb9p/hxHLXPXR1DQxsK86pVk2A7b4ggB6sT6VQ+GyOR6iZAIyWZtoAVmL7w8tBKgOaVF4K6vU5rVSZGFqPCKzcjNUvckTeid4uPMdl5Fxh2E/jTTvKqBCdFv8fxmOr0e6LkBvldJ1rT+RLCnCRVOuzswXCwfOEd/1oV8B1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770191917; c=relaxed/simple;
	bh=7PD2ebfj/pl4/monO6Ko1cl4ogxJpIFc3JvtRWit9lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFYsnE1+o/AreN3P52VaXrm78oVmi6LGwi2YcWqY2QLIpdozGCWwUUptwp3aD5CsgG4dTfp8M36L9/Hv3ADMQ0CDDrVoPxdcu4dna5TF4QHHaY81VLJw+HBmjGHq2G7r9oBmDl+ubvx5s8LyoVZoKShTz61sD8S8BKRiUH7TVe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUobRJSn; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-124a1b4dd40so1876880c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 23:58:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770191917; cv=none;
        d=google.com; s=arc-20240605;
        b=FtaSWE1pBni/iyVSVD/YJwqwLMlCpP7DHEm3bJKdXRepYXbd4jicGchUNA/e+Pmrrp
         5h+RSbFz1muNAD1D3vR65xqsBcwsmV20fzavH+F09wZo8/2PGpiOl2BPsJs+rlIOhCiF
         6G4xalQSn4sGqlBgoaRkCun/WE91koYk7Rv2Dzgq75YEH7Y4y86cGnAhdoZBTqtedw1w
         KPIebGDsZ7lWXzv3geu4nrgjvSFEDZ2f7NYWkW37GjHaBH7ecAKHWfYO213wKyVEFgHq
         tVGlmruv/c2kp7cGFz5KRrZhEF80div90T2eFpVTXyb6T3/0+/dg0boVQxCJKZOoScjM
         AsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=56aehhe+EuiZHUtdEUR7+weTIsrC59CA2iqo62pBWpo=;
        fh=ArFiXpePlSSs2YkDCyKbkJHLQpvBwqnmKI+/VdVQE4E=;
        b=dWUtElRH2Su/Z5gl1A4zJoBiqaheQu4ycS+qEmf41Adk3aG2CNpI1nU+0R+bm1Vbtj
         Ayx25fScBoCifb2w2EBWzZ9PhfUOvWc6nVe7MnSsGYqdVawpYe9akpBoA1N5BkmjiCcf
         sWgFdvu+0/Om3aLZsA6DKsJhJovnuc7z4D37pkHgA30DZNrZ5tzA66XYQfyWNEMOqY19
         e4xXIILNihTA7PNwA2TFIAI/Bw4cpZWRgkMhLO4ZGOrjecRsjb9xRepJjxtItoydculQ
         NEVBEvVOrHTosHaU86Rv3xT8No7ShtoJOnVyz5i32GhHtpGCLWRIykYtFci2mb8blyz1
         taKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770191917; x=1770796717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56aehhe+EuiZHUtdEUR7+weTIsrC59CA2iqo62pBWpo=;
        b=BUobRJSnumH9LH2y6mwqLOWKucJPN5akUrT69zU3lu222qYI+2wZZDV6gJw77WUD1t
         hm0oeSSOj7uoLaKlaxlB5iUUTdLPQBvOVArHcDDL6y4AkaIcWeUqhFR2SXpZSYOnp1k5
         qaMV92jJk4a5bkhJVquw6pnEZFDc4nQxZYXHxBXJ4JD3rxbyTxvA5w2wcrPgzwl0BJps
         JYsT+VR8JJCwFsn+YIakcVionYfuJVVjMbwvHct21W+qi6X7raxvAqAiVOIf7yl7MoV/
         qngWCz0s7+SJAEhAYrQTU9gIvchCYSbAa8h7Je8Fjglk8MDf52JNhMiWYfKtyBLa+Ii6
         2IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770191917; x=1770796717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=56aehhe+EuiZHUtdEUR7+weTIsrC59CA2iqo62pBWpo=;
        b=Fj8wY8coPw6WFgPlRcFuEncysf/el8X/Nqf2XY2Y2bBqENeilZyiVt5DI/avJwDd7C
         xYsQwmAROV4/0aP3B25JQNhouJMUnnrsN8zybs4wjfUs/wqkAAHK1U0vrZuTw0LVq7J6
         rq7mA620VCMJGZDFvOlHRtScW8xXOqHtNQC9E2W/ysCBGEUKmhzcXP7awAOkheUxEUYD
         SItN0W/RyfRUxjXBp/bHHZf9GKsd6ucrjK/9AdArkyBrWzb60RtPPOe1g+qiBM8FxT8S
         G9IE3yI66pUPQdELx9jXKjL6d3RMSDYNrHv9N5Rf8wV2foGwSw+Y/qMc3IS2HJ3WYEgl
         iFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0OdAOLspwuevC8w762yPaFWuh/SxHjsUGj+Cd0oCGpVa0PescTrpZVSnrFX8NNd+15xVQb/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUfC4Lc/bc9Q+nFIlaZBR14WKT/ZGP0UdZjmPgROK15FjMFqZg
	Ir1CRln5MHSixtYb5sC3ZmaAjBaStQnjQrADjiEMEypWDekeQyNuJI+Tt7it43oqUoaLwLYOo0v
	AvNm5g+BDWVrRHtD4mA99z5uIPwMnmZ3GPybeMqVy
X-Gm-Gg: AZuq6aJXY53hDo4IrOYdY2rx5fJ2Qr4HaWOfhCrjY5dEGgx1HZbIJ/UrU2qaufTEQ/I
	zF44GwcbgcLb1AoFHSbXaL4wMCdCo2u47YBicd8LoaHzqI3zFjM0YQtiO/G0xeDuO9BBrP8n7WF
	W55e3wERAh1p5dQsefS2Nsd75JbFkeAcsP1L6LlppQClmglhjp0mixIf+S99XtHvoVa4kd54soz
	eyWhHJ4YUILfZdWbIIYh+NBOUVHob026fgBFVAMoDo43EvSF0G0VtxLMfDshZ33AiaKYIm4V/nc
	jBQ3xPjqRCvT5jISJWCOqSCvE0o+oVVJp+B4hVSPUcuY01+7S6MArSd2IkRh
X-Received: by 2002:a05:7022:2496:b0:11b:2de8:6271 with SMTP id
 a92af1059eb24-126f47cfc0cmr978187c88.39.1770191916262; Tue, 03 Feb 2026
 23:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co> <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
In-Reply-To: <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Feb 2026 23:58:24 -0800
X-Gm-Features: AZwV_QhLODnmt_mJ-te5vlOzU-7R3Ad38OYPgt109s7gbd2Gj9Toa0ioFZVUzUk
Message-ID: <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: mhal@rbox.co, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256607-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[rbox.co,vger.kernel.org,iogearbox.net,davemloft.net,google.com,kernel.org,cloudflare.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D3BB0E2DF0
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 11:15=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/3/26 11:47 AM, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Tue, 3 Feb 2026 10:57:46 +0100
> >> On 2/3/26 04:53, Martin KaFai Lau wrote:
> >>> On 2/2/26 7:10 AM, Michal Luczaj wrote:
> >>>> In related news, looks like bpf_iter_unix_seq_show() is missing
> >>>> unix_state_lock(): lock_sock_fast() won't stop unix_release_sock(). =
E.g.
> >>>> bpf iterator can grab unix_sock::peer as it is being released.
> >>>
> >>> If the concern is the bpf iterator prog may use a released unix_peer(=
sk)
> >>> pointer, it should be fine. The unix_peer(sk) pointer is not a truste=
d
> >>> pointer to the bpf prog, so nothing bad will happen other than
> >>> potentially reading incorrect values.
> >>
> >> But if the prog passes a released peer pointer to a bpf helper:
> >>
> >> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
> >> Read of size 1 at addr ffff888110654c92 by task test_progs/1936
>
> hmm... bpf_skc_to_unix_sock is exposed to tracing. bpf_iter is a tracing
> bpf prog.
>
> >
> > Can you cook a patch for this ? probably like below
>
> This can help the bpf_iter but not the other tracing prog such as fentry.

Oh well ... then bpf_skc_to_unix_sock() can be used even
with SEQ_START_TOKEN at fentry of bpf_iter_unix_seq_show() ??

How about adding notrace to all af_unix bpf iterator functions ?

The procfs iterator holds a spinlock of the hashtable from
->start/next() to ->stop() to prevent the race with unix_release_sock().

I think other (non-iterator) functions cannot do such racy
access with tracing prog.



>
> >
> > ---8<---
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 02ebad6afac7..9c7e9fbde362 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -3740,8 +3740,9 @@ static int bpf_iter_unix_seq_show(struct seq_file=
 *seq, void *v)
> >               return 0;
> >
> >       slow =3D lock_sock_fast(sk);
> > +     unix_state_lock(sk);
> >
> > -     if (unlikely(sk_unhashed(sk))) {
> > +     if (unlikely(sock_flag(other, SOCK_DEAD))) {
> >               ret =3D SEQ_SKIP;
> >               goto unlock;
> >       }
> > @@ -3751,6 +3752,7 @@ static int bpf_iter_unix_seq_show(struct seq_file=
 *seq, void *v)
> >       prog =3D bpf_iter_get_info(&meta, false);
> >       ret =3D unix_prog_seq_show(prog, &meta, v, uid);
> >   unlock:
> > +     unix_staet_unlock(sk);
> >       unlock_sock_fast(sk, slow);
> >       return ret;
> >   }
> > ---8<---
> >
> > Thanks!
>

