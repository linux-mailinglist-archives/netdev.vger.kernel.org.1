Return-Path: <netdev+bounces-297368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Q6VEcC3KGoRIgMAu9opvQ
	(envelope-from <netdev+bounces-297368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:02:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC9B6651B4
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:02:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=PRoHb9Ob;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297368-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297368-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B683531A67FA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9841F872D;
	Wed, 10 Jun 2026 00:55:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFAF1F1304
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 00:55:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052950; cv=pass; b=cMoyJyZP9VtpArlsgYUtTbQhSmeeVrDUs2BFAcVE85uA0i1qiovoG7D5eP1oj8lNprFsefZFAh9Q0nN6VVyhcmwbpu4FxRNznr6IdorG0ZnqvxoPUjK2bYUv3w1BYF8Jd9FEQVjbx9AKQ5VnXDj1VAfznDbP2aP3nWDa5GAjzH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052950; c=relaxed/simple;
	bh=gSGpRHt7l6KDmu7nMUVayUHTju3psOfTkIteL66MAak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6ZeiM/yRemLNhLq2MlMSvdfENK7d7veGmfjPtjUUZwPs6NyWGgjgv0shWqm2VaQL9bnAINzBko0YVmFVeWc5MQWaSSkjASIELnVhkR668OkKL7ilsKNQ3CZGSwYpX4pAAfRAwFGUnPrcRkDPUs0yyO5uPhAL/d4gPfkhqXfgoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=PRoHb9Ob; arc=pass smtp.client-ip=209.85.167.42
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa88b4f792so5304077e87.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 17:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781052948; cv=none;
        d=google.com; s=arc-20240605;
        b=BCaz2GcTEBdHiH9yNkr0YAWb+HBPVC1Cceq+Riz7tQZUgK+ls4qgV+vYCNm1Anwkn1
         EHVoqfHM4nxe6IwB9t5ZrrfQupk5/lximoL0MGQg69toCuTf19QWrhlr2srQr08KmWzB
         r1ghhnbzxLkybAGzmpYCW6YED0r2b/qQOD+rNZQ0krQb0jCVGGg/sd5kHMlBzRXRtFCR
         8Ae2wb5mFQ5NdpWkYIrNpBG4EVydDH+/X77Q+KUrOZjU/S79CHj/c+kqejrRntoVTLUh
         2aj3OGTQvDwBsCAWh0AlZDrxAdHajn5v/c+/fcKNHSHkZR8RMeq3onlOnDmkr3vFS9EC
         B7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rmwxscvtzuZg8vvmsx0DZoUt0H0TuJjZu7bDicwdGMY=;
        fh=GUKkDv1qdnobCGmQlFiL9iq+6uKuO4ZpTEL48wHNFc0=;
        b=BaEmk1/CaLrbl641J1f70WaDNDowUs/1dIL72XS4nob6EtTL6vmNiN/Vnw+fbwtw/q
         fXLQOZ2Yti2IhoYwa2+9FpVpwXSAwcQZ2iTFw7cGwa7G+4Fne2a20bucufZfQ87FIKrX
         NIBQzZFbvvEns4DyLhWzu/z3lWjykEHjPJDIALozbu+1LuIt7dga67BYK20lCUZuVGdi
         7n/qLqO0JeSJSCgSvVvzFHKTgAxyTILCnFkDDoZyZRa5GQ9E6YBgX9pGF+h6V8qvky3a
         if0xb7wClShV2uLq4QxeOdIg0vZAkbvG2YRXzNVhiBvGRIV1/xhr4k8sWlSqth9PGJ1i
         Nb+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781052948; x=1781657748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmwxscvtzuZg8vvmsx0DZoUt0H0TuJjZu7bDicwdGMY=;
        b=PRoHb9Ob29Vb0wXFc+QJBLfPN7aWbO3bngVCaa6cwljBVXGLdrtT3mBAOrFsoYQVy4
         sK2i+xVdzspD2Ax3ooRM3cG8Ye40qUeoOB/Ibb05EBDJ7kp0cfHHUucIMiksargTZZPD
         MRjfPdJ4W698zACIjIYrw7tMFalcMyaR/zWcgNiFBoAs1uTq2BTtvtu0SrUv71s4pYkQ
         TnS4Y45cwVRClnLxzDu/kUzrIY4kWYiOjb0RVB1r7qKiUVSxgCGU5SfQxe8i76n3F/c3
         elv/SiS7uEf58r1QRePZGQyo1Q3mTV61zmKDx2YetnprxB/kA/WEa2O5JJuGqTpVH9yM
         5EQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052948; x=1781657748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rmwxscvtzuZg8vvmsx0DZoUt0H0TuJjZu7bDicwdGMY=;
        b=HFJ74gxgpQPd9gTqsJsX5vcn67gKarC+oWqlPLePWbc33ehqvLtb617OGuSHKlLq04
         Er2Xvg3cYGgLgA3RKoD6+/zR2qG1i3bgqHi/OuJ+o58B0VIWPYGhZlJ/roqK20UjJYF8
         Wdp96bB/fxzGTvHKKopJBXRMOL0meCWX4Hhzkn+/SZNv2HVOYdSkTMAYWCOMJi09b90i
         QaZSBOKfLmt4IRaRhFCP8SVxGBMeZfXryKVwGBoLe2QwElgZ9DFuagt8kcpCLfO1DqeI
         RJ0a9pUNr3JDET1mGscrC9t+MHz183h0kFsgWPus1yGSj0w6t3E4LZ9SkEruNRgEkLRE
         eTsA==
X-Forwarded-Encrypted: i=1; AFNElJ/S03hNToko7qTofHpLLGrLKUpAFiPvTCvOMTdioVN2R105/eIu2nfQcBN1H3GVgyMmnBkKE5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOSk0kstXJIapcknbb8NhEgwI6g1OuN86bw6oL26SXreUQRl2
	0Ne26Wmp2ukll2CVCt+AVDprpfQSnrPVSBizW995uf7oorFny3Q4Ef4eWlDbTMDUJi3xYVuL0ym
	sZa9DlTIx9sovOQwM/gjr0Q3BUhpCQzVSPov5sTsgHA==
X-Gm-Gg: Acq92OFu+wa+/bC1c1oCu8ArNM68H1ShGgHi5FP4JJajXBK/40/3BBhjI7tj2EDtqpf
	HIs6qn2Cu0ELT828Fqjvwy3ed8sKCfa/q0O+xiC/I1YnVE1pKpmKJgP7ABVtpoPV1rbdmPmEFHJ
	Mu/SOFAUbyZh0e+5toFKwFpe/tGIZJLesq9So5ql9BCj2mZbk8vk15Dn1QNcNy1I+JDdi9NPPr0
	zpjy0uBT0gDFNsEUU/1gdpRGkhevrR5ZYvgD84clbdK3hkeucKkH/8wyj3jwj5nsBQ/TC4009Pb
	z36VXCGnNKzXEUaLeJ5lGifm3ho=
X-Received: by 2002:a05:6512:6093:b0:5aa:7005:125c with SMTP id
 2adb3069b0e04-5aa8866c7c5mr5360865e87.8.1781052947761; Tue, 09 Jun 2026
 17:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
 <20260609174544.114b82e0@kernel.org>
In-Reply-To: <20260609174544.114b82e0@kernel.org>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Tue, 9 Jun 2026 20:55:35 -0400
X-Gm-Features: AVVi8CefliquC2v1uxuX7tJh2x7VHT7HqmzcHLsj4MOV4swgdnMZnEMpez8EyOo
Message-ID: <CAE+C+DYpYjQoSsr3PsQ2pN5hf9+u0CbA=JwJ-2aR9Oz1GDDNrg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: cake: reject overhead values that
 underflow length
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"moderated list:CAKE QDISC" <cake@lists.bufferbloat.net>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-297368-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:toke@toke.dk,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:cake@lists.bufferbloat.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,trailofbits.com:dkim,trailofbits.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AC9B6651B4

On Tue, Jun 9, 2026 at 8:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  9 Jun 2026 23:29:36 +0000 Samuel Moelius wrote:
> > CAKE accepts overhead values that can make adjusted packet length
> > arithmetic underflow.  A negative effective length can wrap through
> > unsigned arithmetic and become a large value.
>
> Sorry, why are you posting more patches? You were told to stop
> yesterday. And you received an email which said:
>
> Here are a few ground rules which are frequently broken by newcomers:
>
>  - You must wait at least 24 hours before posting a new version to give
>    reviewers time to respond. This is a hard rule, no matter what your
>    reason to repost is.
>
>  - Each new version of your series should be a fresh / separate thread
>    Add a https://lore.kernel.org/.. link to the previous version to
>    the cover letter or changelog, instead of threading the submissions.
>
>  - Until you gain experience submit one of two patches at a time,
>    do not send multiple changes at once until some of your changes
>    were accepted. This avoids reviewers having to provide the same
>    feedback on multiple patches.
>
>  - Avoid changing the subject of the changes or cover letter unless
>    necessary, it breaks our patch tracking.
>
>  - If you're submitting changes for issues discovered using automated
>    tools - commit message should explain the discovery and testing
>    process (for drivers explicitly mention that you don't have access
>    to the device, it's not a blocker).
>
>
> You broke at least 2 of these already.
>
> If you keep ignoring direct maintainer feedback you will be banned.

I'm sorry for my misunderstanding. When should I resume submitting patches?

