Return-Path: <netdev+bounces-256316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBGKFXoGgmn2OAMAu9opvQ
	(envelope-from <netdev+bounces-256316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:30:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D3DA9AF
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A2A6301FCAD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755553A9000;
	Tue,  3 Feb 2026 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifHGfdxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC743A7857
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128970; cv=pass; b=MEg1ctbU6v1WS7BhCysGC6FZb1Os0ArqkL7kUGSQiSZQUDXc5ITuxdJ0jZOK334IUxbxWY75s1+9XxyV1Z79pFu5Y/ye/AK+J3FrxISfuxyxSnZXJgvJD+g6YfDt3Yu6WuvrbrdrHKHuQw8TNVAqhQC+1pzS6j1sMHEe+UDOeYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128970; c=relaxed/simple;
	bh=TGjSaqAS9NOUAVPyvUO+d08oDPJTIY2GRuN0tthIDww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8p7Lc8LbPbE2ysQ9WG1v1RzUHfwBkuhJJVtEIPYXVInMOepImQavOR+qYXAN7/MZLM/BTT0v/UIHksdXY2EkoP/VJxngUl3EhJhdGlX7AwPWLVD9K+hqWNlYrPRuod5kGshIy2hZy6yxBcCerSdYiZvBXz4pApLALU90uPKhZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ifHGfdxi; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5033b64256dso376831cf.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 06:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770128968; cv=none;
        d=google.com; s=arc-20240605;
        b=FsREwKaMyDztUzo55VRDzuaTZxDyj2nfHVmHikv5PVHwz28mOXua5BWetXSPxHzZRJ
         I75J10x6HoSOnRUkVacoZ91q4Y1nmSsBAXT8Y805fo/WDb8e32c3qfEYjVQ7jW1DLPTT
         b29FwiN5UceGu1JOp0qve4BYXBrrC/RZh6PlVYJKzXN2SnyW5zUIy/LYlfOn+8t9Dub/
         JhSXv5KvUM48l7zweM1IIDywgEejAnYVV+xDYKjZPNzWsDdL7kxq7C3rKZcSQDV6D7mz
         AZ5ELABsWoIRmPIRP5koOSSPizFCXzhT/wz09krgXnr82EtM4z1K2cVaVqOmU6zcNb2z
         ltzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p5ERrpy1T3UdkgZhR6+h4J6D+3MqjDjPYcfyXMrd14c=;
        fh=oePjzb0Imvarpd5dNTMKtR2cg31iZi8R9WtL0MyXvpY=;
        b=EI/dvxXvnQBC+YVYyOm4eElMM2H6jG2E9pbeBmTE6+HjuBfuhirgZWKwZ0Vj36BXoO
         4/7teA5W/FeTcDSkAL/UJ/GzA5NfJek60zmbSvFLSuDzvkVm6YHiKnS9pb4PWrvn/y+/
         ahc5OGxtABl+c/sG2ShWHlpD2uHjBiSnZ0h8kxjCUxGhMJUxfSn3Km6BhW6cd/aX/qWp
         BEkzs1kcrKXPneffTF2D0xO6sC7TaYZvXqFX4+ySMxUjmNaTzLPpQMhBHaoXwpMbSj8W
         P4k13ari9LcQrB1UQgjrq4iOy0vVTsW/pccZ/QDJvdYitrNkiKDlRb+b9NHemgg3s66g
         BjhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770128968; x=1770733768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5ERrpy1T3UdkgZhR6+h4J6D+3MqjDjPYcfyXMrd14c=;
        b=ifHGfdxiRb9W5QK1WCkbasQGt6XOZrnr9jFL9Y644NmJKb/96Jk9ZS8/eux1SQ0ni3
         toKt4LlttY7/OdVB1eHUSa+kAjk+lCH18XrD2siovKyauzT+7Bx6fxp4/YhNHdgqDfyO
         GSpJmoDetQC5y9hg/uK3fDCSOrp1+TjYjEt7hEn2KTGEFfbGpaHuvemgD4E0VV+l0MiF
         YQLPD3MZbIt41sTPqwo3fp60e43tCdFN3Lf3YvYpXkHzLumPc3FwGBAnn/BU7WV+a2Wz
         xaBRW4WnxOlN8fRWkDHbwRXTlRUv9kYWP3XlvLAxk6N/ir3OBWZnflETIJd/heq8zq1X
         A4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770128968; x=1770733768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p5ERrpy1T3UdkgZhR6+h4J6D+3MqjDjPYcfyXMrd14c=;
        b=hCCnMgSeegfw+xDCurvjLIK2fR6XbstAGoF2tfQJZJuDwsucWtkxoY+cTX1z2KS4H8
         2DV5n49mbvZY5til54g9ynTb7IuE0JOB7QJlQuy0Leg1piGlKW0P88m2ya4PVs7YCnVW
         u+1bP1PJz0Qpygz7pE6T4WMCG9fjuYL7m/ZEiZdOElrHts6l620Jfp7wkd+lu2OnGO+d
         IK3LD9GCMaYrQq6UbAWPnZl/dOknv3dMEJSE0z9CBrBNiVbyLSTUkhJifC1MGS65foDU
         I42nBAhPoFOa+1gjXp1RpnRMCvemGLUUFV8bQ9uXfJTiyNE38z3gSYuC9zTq4hewTpHm
         Bo+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXC/5hzTQzVg4R14wQqo3xw4SSSMwP579e0Z2u+q6zDIk9N5hVGZRNwpCMgw2fT8zVoaP1liaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+9pppKBn71f/429i+k5QipfKsCMP9DNPgNs60HXXRxIolLuu
	Q05XzObXAbLkuti8buU77TVV7vHxpTkKbIBtat8Y9782HwZeo03LMfCjC6SxXRszQfkGlKzytAV
	HTNIor1/rZckIl9DDef8bIe50YTMB52oaxCJbqol6BDvv/lWzTooap5KheVY=
X-Gm-Gg: AZuq6aK3m5F7R6IoTMrlJ2CoGd6fDX5kTEQnPrHE9DfIMcGZketTIGYdSeDnxV3l6Fh
	fYpdKp9nTpzUuxic/fRfkdyoZSgHMb5ImetSNUUICJmpU5DEuStBcP4YtrWUkH4J4fe3+zEJLGE
	Z22FaDvumylFYGvoeU3Y1U/QHCEPNlR1JzAbHeE6s1HrXW0d5pNFF5xENhQYmBaPNJFGu+uHG9y
	oDRSJVawAY4ofaaIHA9H34kqoArED3LA/xvV/pFHqzC0CkCkoPawXOHxAt8JRrV7f6y8zQWAq62
	J01CvWl2qqlvpiPuzeFzmdS8X3LkOQIwIvaDbuK3zekB3u8fHhAPZkRcP+grGzwEbtbyriw=
X-Received: by 2002:ac8:5906:0:b0:4f1:9c6e:cf1c with SMTP id
 d75a77b69052e-5060f24bff7mr7275241cf.17.1770128967184; Tue, 03 Feb 2026
 06:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202101454.89445-1-kelmenhorst@uni-osnabrueck.de>
 <CADVnQykLpW+GV6sSG5py1J+WTZFM-=JObhYS7Pwd=9ut1GY1BQ@mail.gmail.com> <f1137fcf-1778-4811-9211-4beb95db3a32@uni-osnabrueck.de>
In-Reply-To: <f1137fcf-1778-4811-9211-4beb95db3a32@uni-osnabrueck.de>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 3 Feb 2026 09:29:09 -0500
X-Gm-Features: AZwV_Qh6mmZ6pR-xZ0Iu5aBp54XWMVEd0CY9M6UH7bKccEYPy9dpRymFxNK0WdA
Message-ID: <CADVnQy=u4zQjC6A9WBvnZOvRFAVzi=0rSzbSs_4kujB2u0U2EQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp_bbr: use high pacing gain when the
 sender fails to put enough data inflight
To: Kathrin Elmenhorst <kelmenhorst@uni-osnabrueck.de>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256316-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C41D3DA9AF
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:36=E2=80=AFAM Kathrin Elmenhorst
<kelmenhorst@uni-osnabrueck.de> wrote:
>
> > AFAICT this patch does not look like a safe solution, because there
> > are many reasons that the actual number of bytes in flight can be less
> > than the target inflight. Notably, it is very common for applications
> > to be application-limited, i.e., they don't have enough data to send
> > to fully utilize the BDP of the network path. This is very common for
> > the most common kinds of TCP workloads: web, streaming video, RPC,
> > SSH, etc. It does not seem safe to increase the pacing gain to
> > bbr_high_gain in these common application-limited scenarios, because
> > this can cause bursts of data to arrive at the bottleneck link at more
> > than twice the available bandwidth, which can cause very high queuing
> > and packet loss.
>
> Absolutely, app-limited and contention-limited sockets exhibit similar
> characteristics in terms of inflight bytes. My understanding was that
> BBR uses high pacing gain when the socket is app-limited anyways, is
> that not correct?
> For example, bbr_check_full_bw_reached returns early if the socket is
> app-limited, so that BBR stays in (or is reset to) STARTUP mode with
> high pacing gain.

The "or is reset to" part is an incorrect reading of the code; BBR
does not reset itself to STARTUP when the connection is app-limited.
:-)

> This behavior actually gave me the idea to fix the
> contention-limited socket in a similar way. But maybe I am missing
> other cases where BBR reacts differently to app-limitation.

Please note that in bbr_cwnd_event() when an app-limited connection in
BBR_PROBE_BW restarts from idle, BBR sets the pacing rate to 1.0x the
estimated bandwidth. This is the common case for long-lived BBR
connections with application-limited behavior. Your proposed patch
makes the behavior much more aggressive in this case.

> > But if you have further results that you can share, I'd appreciate it.
>
> I separately sent you the arXiv link to our paper. Due to a conference
> submission policy, we are not allowed to advertise it on a public
> mailing list yet.

Thanks for the pointer, and thanks for the nice paper with those
detailed experiments. I agree that this is a worthwhile problem to
solve, but my sense is that we will need a solution that is more
narrowly targeted than increasing the pacing gain to bbr_high_gain any
time the actual number of bytes in flight can be less than the target
inflight.

I suspect we want something that builds  on the following patches by Eric:

commit fefa569a9d4bc4b7758c0fddd75bb0382c95da77
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Sep 22 08:58:55 2016 -0700
    net_sched: sch_fq: account for schedule/timers drifts
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D
fefa569a9d4bc4b7758c0fddd75bb0382c95da77

commit a7a2563064e963bc5e3f39f533974f2730c0ff56
Author: Eric Dumazet <edumazet@google.com>
Date:   Mon Oct 15 09:37:54 2018 -0700
    tcp: mitigate scheduling jitter in EDT pacing model
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Da7a2563064e963bc5e3f39f533974f2730c0ff56

With both of those patches, AFAIK the basic idea is to adaptively
measure how far behind the intended pacing rate the actual pacing rate
is running, and adjust the pacing delays to make the actual pacing
rate match the intended pacing rate more closely.

This kind of approach:

(a) should more narrowly target cases where the actual pacing rate can
fall far below the intended pacing rate (cases like low-CPU-budget
VMs)

(b) should help all CCs doing pacing; not just BBR (e.g., paced CUBIC)

For example, what happens if you change the line in
tcp_update_skb_after_send() that says:
   len_ns -=3D min_t(u64, len_ns / 2, credit);

to say:
   len_ns -=3D min_t(u64, len_ns, credit);

Does that help BBR performance in these  low-CPU-budget VMs?

Related questions would be: for VMs using paced CUBIC (CUBIC with fq
qdisc): (a) how much does paced CUBIC suffer on  low-CPU-budget VMs?
(b) how much does this alternate len_ns computation help paced CUBIC
on such VMs?

best regards,
neal

