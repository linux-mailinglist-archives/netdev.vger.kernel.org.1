Return-Path: <netdev+bounces-264525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL1DAz3hqWnDGwEAu9opvQ
	(envelope-from <netdev+bounces-264525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:02:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B1A217EB9
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3419D3083CCC
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 19:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E383EB7F6;
	Thu,  5 Mar 2026 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StXAXoMu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66E1A9B46
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740688; cv=pass; b=fIhQkS1JJykZ1lmTulwP9JNf8jdfsTlaBcAsJWJLexHG1QluTb3YSCSM9JdbJW0cQb7/lr+4jWMRG5+n7SCLkQuJddCFI9xRB3ylolVpWL0FwZs/pGiW08qP/ysBqZP6tVNwjUn2Ub64PIPdxm7Pi7hB93uHPQsEaMF+E7LUL7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740688; c=relaxed/simple;
	bh=y/CDdZCuyVDufnFG1fa5w4MteBW7a/C8VKRaqDtD3x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4gBQsp90jSs3Ea5ROdOu9g3sMXNKcwH0e8ZUEHhAAOu6yfxQpaSyvRDVmY+n9EkHjxJQvM/uFD+r5iEzcbr58cbpq3EEemt2CQJL5fwQ/XofonaML8M6XyU1Rjylx70DPAur3f5cAU0cff+9KvjW18C9+SXW5paY+rApINQRS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=StXAXoMu; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12776bebe9fso7742337c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 11:58:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772740681; cv=none;
        d=google.com; s=arc-20240605;
        b=Ki+VB1SMqPKGbM17x6uXRGg/vnKKeRO5YDjD6PzEBoE0+uLTHpe4d8CLSDpjtsTuXK
         oplC0+qOZWC5qI1d7+pTeWOxWZ8jQpVXkAuCDon0QPG/mf4UsK5bpiKsZZAO6N7NlgMK
         XqABwjqTlAfiXf8pn5begaFg2YQknlw5ln3H8MsfyBPWSTlPKapk0sLDE+NjXAUw0ddB
         BziDSJidQUTXNx+wFNG6+DOJB/n57DShCtNNehrN9HbMeZUYdB7tMPBzT8QFp7HIpxHW
         JfwKHkpB5c++94BjeKnupinFMNGrPZC5Jq7yBcFl9UCX+HRacfYKSIzegV7rn8RgBgar
         cHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2HpqSlqbmQvY6DBW6BfmuaLMsbU6QsMeiDen6NJGdpQ=;
        fh=KwS6P5KZUUdGick9DkZ6/UKScLIVis8JFm1uC1YvOsE=;
        b=YF8CfGLMwzAIhikrxe4S9KpB6GaLNu75lIhwJJdG7n5lWckmAuiUs0KPF/4W4PBoYz
         2l/jkKkkVtS7MvN/FcWyPV0Hf7PRv4yFlPTdcaF89KkqyCslUzvyGuGg8oAoQqnyny5r
         4Nf91L4rzDzw9vOjW2hpOjhVt8VBjgK1U6LIP0T95HyZWw+Hk+lrE0aAD1mOGI+Cv6xp
         3cMnOMfSRgJgsmhiNy4BxFt1U51oEvS/Ay6s5sgqV1BZFL6oydu4ZnDAH2VeGmKYRuVd
         ib8QielWPshcBe8kOpPhAlKAlWyJJf1X5rxHbNJXromafgWEkXXjdcRvA1WIYiUhSiap
         1D8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772740681; x=1773345481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HpqSlqbmQvY6DBW6BfmuaLMsbU6QsMeiDen6NJGdpQ=;
        b=StXAXoMu7nHbbuA9HwPWD2zoD0JuXZsXBNEas/oXJGLU6Tes8twDVNsbttPTEf6kdL
         zxAk7yU+ur23VUSKiOQvQoMPyx7xPLwhslZ56nM1xaqm0lbjbShfZXRQK7Arz5tw8Ei6
         84UoU82PmbuWOzKBJoxfQFF+lcLGk9HcTaXUghUYK7//B/MWnjvG1QQwOyTytW425+DP
         FW2Tvf6L9niTBez51zm/8ExhyX2/HhgufRnKPhmjkGLnF2YUBMlve4jWgFWdh53UJ2K8
         Dr2NZnRG/tSY1RNx3kCGqJdUNnVvfvWBBjeYA9cTOjPawPvHv3gH+c3SThQ1PcAyIYkK
         a/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740681; x=1773345481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2HpqSlqbmQvY6DBW6BfmuaLMsbU6QsMeiDen6NJGdpQ=;
        b=EF2BKsiZpW/40az2N6QUzojTbRObuLzKsmuWJnmR/2q2PjhNm8X5eiYKL6C0Q2Yqhz
         IYWKj+nq+2DPxp2XnnVg2XC0adLsv35/u92bQNejzt7PHS5euPMxUvUq3u/HlSYR2Oaw
         AGywsD4k4pe0+5Oh2vHWrUss3D1GVsGEBU7mdsn4IWtKy5d1kDE78vmGW+E4/Jgu3WGS
         /ICmrhsFj7gXWvLzqsAiCQOQMxC2ueoA9qcNMfe3IP0DGqD+h+1c5z1thYPPwCoIkJ9H
         Y+j4pZ4ndL51aqXCVLvZa/3I+HV3a5z9TaKiqkKNMTy26Ya2UcaWs3c2fxa6y9gwNdyo
         9Qfw==
X-Forwarded-Encrypted: i=1; AJvYcCXKd1XtZWUTJbw4F5jDTcwBM3c7uBseK4c7c17/IVE7GSTjLZsl28k571DCIZJbrPgO0NM/azE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwjLY+KE0BDsSFGnJh02lkP0B5mRYQdvfIebsOyfS6roWk2IAi
	gN9xeBXj/QJGORTGxOgu+jt7dz8xfDY5bSowFeHlEc3+441+PBwtjmAVlD6hyCo6Xxt35/egdjV
	uqOyZGck87Uudzs/iniZmBlKurPK+tqbefXBNw7RF
X-Gm-Gg: ATEYQzzGpisixKnEjU5nK9yEVVT4wQ05rqy0P+PzYSKY06TNJ0cC7S0bOl1g5aL78XS
	EPFBrwqT9sn7qXHpA/VMRStmSFUe3Uyg3WBuLChp2bo0GlZUc0uodL9eLHrpTkQ6j8Kyg7Yr2aA
	0olzbscEvsNf72xrO/zqmfGcJoE3vSUxMBMiVDFoal/Ei03Qh2422RK6l2ttY9mKeENn4C/rRoI
	PopG9aJFS381rNf5BzTbiVwi4ICK/XosRp5GA/D4AewNFp3P3qSZOAOmrBFWewZJXp/tsMd4BhA
	ipZnrboVQjgIaokvt1OHTQb/fi7nsh/f+1F6KKhvEazreVuSXUOqkffJuOHrCPifwOhGCkGG
X-Received: by 2002:a05:7022:250f:b0:11b:9386:a3bf with SMTP id
 a92af1059eb24-128b70eeb71mr3473428c88.42.1772740680305; Thu, 05 Mar 2026
 11:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305114829.2163276-1-edumazet@google.com>
In-Reply-To: <20260305114829.2163276-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 11:57:47 -0800
X-Gm-Features: AaiRm50seHo8rUE82AkyRq6iO4Y_dbNlHQXCAe_RoRurhutQmnsR5Sl_1xEdSj4
Message-ID: <CAAVpQUBm4G7k=ZFiioLu3QV6Ek3Ju4rdSSQWydL2RofxzCgGdA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] inet_diag: report delayed ack timer information
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 49B1A217EB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-264525-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 3:48=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> inet_sk_diag_fill() populates r->idiag_timer with the following
> precedence order:
>
> 1 - Retransmit timer.
> 4 - Probe0 timer.
> 2 - Keepalive timer.
>
> This patch adds a new value, last in the list, if other timers
> are not active.
>
> 5 - Delayed ACK timer.
>
> A corresponding iproute2 patch will follow to replace "unknown"
> with "delack":
>
> ESTAB 10     0   [2002:a05:6830:1f86::]:12875 [2002:a05:6830:1f85::]:5043=
8
>
>     timer:(unknown,003ms,0) ino:152178 sk:3004 cgroup:unreachable:189 <->
>
>     skmem:(r1344,rb12780520,t0,tb262144,f2752,w0,o250,bl0,d0) ts usec_ts
>     ...
>
> Also add the following enum in uapi/linux/inet_diag.h
> as suggested by David Ahern.
>
> enum {
>         IDIAG_TIMER_OFF,
>         IDIAG_TIMER_ON,
>         IDIAG_TIMER_KEEPALIVE,
>         IDIAG_TIMER_TIMEWAIT,
>         IDIAG_TIMER_PROBE0,
>         IDIAG_TIMER_DELACK,
> };
>
> Neal Cardwell suggested to test for ICSK_ACK_TIMER:
> inet_csk_clear_xmit_timer() does not call sk_stop_timer()
> because INET_CSK_CLEAR_TIMERS is unset.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

