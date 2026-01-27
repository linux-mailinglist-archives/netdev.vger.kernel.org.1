Return-Path: <netdev+bounces-253714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHV+EH1YeGkNpgEAu9opvQ
	(envelope-from <netdev+bounces-253714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:17:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D03290553
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 177B1300C90E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA432A3F3;
	Tue, 27 Jan 2026 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4ICnLoB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933D2C032C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494558; cv=pass; b=bF3h8m+atmhGzQrd6ierl4BO51/dPqycdfeX0DqFtZPprGjuRUqoy14VC7QCL4xvmvXUzfaqC8U04tjuE0lZQ0+1JBosObtls4MsifUshfyDE2VE3ZG8JlQgpMjPlJrDGeLKnr9S/nvq5+tI6LK6gB3g+oLFLdzV82LcJg+M4Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494558; c=relaxed/simple;
	bh=+bQXktVfHGsci9bBhOpgpM9ZEByRxmxM33ZTUP+8EOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duZ+SaHOC7NfiNjBnP7Ev6zirwpHeMGSVF4M4tgwyVKdLa3O0LxBxslW1AynyDazT/sEHd3NWHyGS6++nLg3xXEV0lEu+go4xu6BFRj8d9YdH9yNshvY2T71hzBJrLtWw8N8VVmW2rJzy/8y9V+9UTp9lL7BOKlMvNkO7MZdbTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4ICnLoB; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-385baa8afaaso45946781fa.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:15:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769494555; cv=none;
        d=google.com; s=arc-20240605;
        b=XGBN/5ixuqykEBCYK4IzVvg/ZDNiinb1yL+V4gKNmBYZDmBjq90NzxOCjb1lyV+NtS
         iQzzj4XYlhiilc2CCovJ2OsehIa2U5h40x8/7gUshRgrfxek3h3Li0xKHhihxiUZiySH
         QQnpWkfbahe5DqZ6p1m6NOU9QtCW/GUTDe9Cqv3e/fVEKoO5b090EXgSf8sF611bnINd
         jQQ6syvLVsQgwgnHr4Dis7O6kAcefJTcx4BP4+LQUo7Y7L1AWMXBem+zWTKgrhxruGRr
         j5RZoaya9r9L0PBGP+xKo7cC4iNPR+UIYWeIflom26R0AkLsHtBPbyPv+OjAN8auFP8u
         4tLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JR1hVNa6OOhMX9vuMLKqEDuGIXjxLViNZK+hyszfFt0=;
        fh=uLQPDHIr5L8d/JkscL7OG8QfYqi8NJeOyINI/55YsN0=;
        b=ekJjN2FD+vXYLLfa5C/scDdLdBkw8ypclV++S62Kld4YxB9GJQfVN+kNmSBIGPQbv+
         BkpXprZFOGwnoGah5DvZGiQSDSVFadUB++CyyEZNqbZGULqJZ9yZdf12MreDnVIf9rBa
         CRY3Cs2KRW9lxNQDyLSKyeSDWop2zDo6BAP0H2V1ctzry+sdQyJaZs/BVjb/N32GM0rK
         XV1kATX36d6GfMgYJZU4rrFw+E49PRsj01ksLSAKbouXyFsTbXlMXksAS49j1tqQXW0H
         v2e7vow32ZbZsGMTrYRWwe3PuFXiPOtUXf7/tv9xpGjjf4GduIyHOL97d8xpehkeaGHZ
         rblg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769494555; x=1770099355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR1hVNa6OOhMX9vuMLKqEDuGIXjxLViNZK+hyszfFt0=;
        b=Q4ICnLoBNBqQuih4dxrcr9G0z6EHIcxqfU+FpT8hWB7Exm0OiiZ/XgunvDD4IQOfTb
         epFhAETTpj2xQ/oFdT4IRceB582YMWnvrMJqSQ57qzaU0Tp+0Le5CR7i8R2K3n00RbZl
         FoKu0Et7c1pJZBxVsVV+LIk96cUWCb3rhFkRyiTf4eML/6woDXJnkdExchTJBnovyz8+
         sIjt1AZjRbA4CwVDcEqBb3L86pnWBatCQgEydFtyLf7eI7j+uJSrT5rNP7pTJvmm5qrj
         zVguB87z38SUZuRodH8Ts9xaWJkyTqfkgdKmn/pDDcLyo+aNdGzzPKFoAz2/YHEfWldu
         lqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769494555; x=1770099355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JR1hVNa6OOhMX9vuMLKqEDuGIXjxLViNZK+hyszfFt0=;
        b=JJu7Z2riZq+IB630X1qvBDZ5JpkURAsWESniMS8P7rVx/3UQXb7R9OrAFSTuLr6s3e
         KtAqRToG6YwUXlBhHPYMmcTJWTVSy2q2Pg45FmHlmLl7tYvcd7UzsdL/GzQLP3MnK2OZ
         dY6Fq+H/aiNF9HeNRVpE+4tbcGuI1TOLEuIYV400ANJrOXSSlzff04B3CI0MYU8NPKct
         vPIuaICd5V0rfCrpdXqTJSN3ch5723XnCaDLM7bIp3fgOxL7G5mXkNd0eLxt2aQHNwQg
         0ndP9wliGjbc9Kgz7Y4ClqrsrjiSPKL46hb1nNGzwX5F2opCv1mBMA+vlfljhjOdjiVT
         jmFg==
X-Forwarded-Encrypted: i=1; AJvYcCUOT7cNJXIJUxmSogHgiomsZPwMz+IVeSvPQS+IMaEhvaIX7InSr3gf2yUoNTR3UnB9ReJdXtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrUsNX1Y4831FjWHSuS/aNiwOcRjFm4NgLCn9qgqAxD2ogRI9
	Dt/vz79zuqHqde0HbAUmAmUER5rVXDJng7Nuq1oH5o/38ZonKIOVPfeJgNRERSuaJfwlGofGi3J
	qGleUM996eQOYnzpUxrUwsHdEExUf7BI=
X-Gm-Gg: AZuq6aIYHbOUsKP8Ie2yxoh9pb7F8vQC4VZk4u8HdXtKg5FRYY/DdzHUUtQeS2LpvfF
	sgeKvA/Xi5T0uZlX7aTx3WlWzX45yaq28gQQgigjRZJa4sBdA2Le483TwOXXAVrMoZAsI90pysm
	/ITMf2D5YV1nIE8GlpvShmX69i2wSeNxTwcN0vSsBvS1LtV5IJeRSCGXhCAMUEKUsE7Q1Xz5ODY
	1DRJhdV9Px98QdH45LpX5envtZdZHWo1wdX5yj/2r13mGlRC1R2cSEE3f1qctFLSvPPN1c9
X-Received: by 2002:a05:651c:31d9:b0:383:38f6:eadc with SMTP id
 38308e7fff4ca-3861c8e54d9mr1990261fa.24.1769494554800; Mon, 26 Jan 2026
 22:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123111605.4089200-1-edumazet@google.com> <CADVnQyktV_z9=SoT7yhkT6mBQKRjaJgpwLhR2SdWGQS3iKD3Tw@mail.gmail.com>
 <ebb3a731-a3ec-444e-8efe-aa13cb76adad@redhat.com> <CANn89iL=a922QTQUwr5EK6XeL+gQu-zeqca1PYhs-NBu3aeyzg@mail.gmail.com>
 <CAL+tcoCsAJ+pOs6M2E2xRMa=VKNB9wwoR2DEbiFyvOmfe_dkGQ@mail.gmail.com> <CANn89iK60d+X0eRffN2jrJAON4DLsLH2Y+Yg5f+OOsr5mGGsNg@mail.gmail.com>
In-Reply-To: <CANn89iK60d+X0eRffN2jrJAON4DLsLH2Y+Yg5f+OOsr5mGGsNg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 27 Jan 2026 14:15:17 +0800
X-Gm-Features: AZwV_QgetiZHsjDozz9RlSGC30hgQtQXnVIYKKkK3Ofx4jeovyAam-mp7hJp62M
Message-ID: <CAL+tcoD22caHYfsLhtSNyuFDt1cXEZtgjO66DPJ2C_ePdNqzaA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move sk_forced_mem_schedule() to tcp.c
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253714-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,kernel.org,google.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: 8D03290553
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:06=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Jan 27, 2026 at 2:56=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hi Eric,
> >
> > On Mon, Jan 26, 2026 at 4:45=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Jan 26, 2026 at 9:18=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > >
> > > > Hi Eric,
> > > >
> > > > On Fri, Jan 23, 2026 at 6:16=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > > TCP fast path can (auto)inline this helper, instead
> > > >  of (auto)inling it from tcp_send_fin().
> > > > >
> > > > >> No change of overall code size, but tcp_sendmsg() is faster.
> > > > >
> > > > > $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> > > > > add/remove: 0/0 grow/shrink: 1/1 up/down: 141/-140 (1)
> > > > > Function                                     old     new   delta
> > > > > tcp_stream_alloc_skb                         216     357    +141
> > > > > tcp_send_fin                                 688     548    -140
> > > > > Total: Before=3D22236729, After=3D22236730, chg +0.00%
> > > > >
> > > > > BTW, we might change tcp_send_fin() to use tcp_stream_alloc_skb()=
.
> > > > >
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > >
> > > > I've a question out of sheer curiosity: are you using some specific=
 tool
> > > > to look for inline opportunity, or "just" careful code and/or objdu=
mp
> > > > analysis?
> >
> > Paolo, right, you beat me to it! I'm also curious :)
> >
> > >
> > > I am studying performance profiles on a stress test using Google
> > > production kernels,
> > > on platforms that are a big chunk of the fleet.
> > > These kernels are very close to upstream (at least for core and TCP
> > > networking stacks), and use clang and FDO.
> > >
> > > I am currently focusing on some functions that even FDO does not
> > > inline, for some reasons.
> >
> > Eric, could you share your more valuable experience and methodology beh=
ind this?
> >
> > Prior to the recent work you've done, I completely missed that we
> > could even do something with the inline functions. Normally using perf
> > doesn't give us a clear micro observation of those functions
> > especially about some hints on whether we should inline some
> > functions. If there is any tool, it would be super awesome!
> >
>
> perf is your friend, and a deep knowledge of your cpu-du-jour behavior
> (assembly)
>
> perf record -C xxx -g sleep 10
> perf report --no-children
>
> <Use the perf UI appropriately>
>
> > Let me guess, are you trying to avoid function call action as much as
> > you can in the hot path based on your deep understanding of
> > ingress/egress performance?
>
> I think you could answer the question by parsing the changelogs of my
> recent commits ;)

Right, I've already catched some insightful knowledge from your
commits :) Thanks for the interesting work!

Thanks,
Jason

