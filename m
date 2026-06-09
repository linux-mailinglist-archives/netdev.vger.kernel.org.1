Return-Path: <netdev+bounces-296820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QGFJKqNkJ2qhvwIAu9opvQ
	(envelope-from <netdev+bounces-296820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 502BF65B7B2
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:56:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IRC4FuRV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296820-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296820-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD180301A9A3
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474E32561A2;
	Tue,  9 Jun 2026 00:56:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C254763
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:55:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966560; cv=pass; b=HqzriI9bpf1i+3W+eHi0/L1HxKAvZmdrL3hEJULBNBarFvEXLsmXea98sKSYdoL938ql+xz13Y+mZT3yCfN94dXGu3ir3C/2+eyOuQEgyzWiFK89X96wOr4c8i8z7Q76pwZ+iNEdp7SLeU0kYW/ciTNo5woOQ+5vrrC2lio7y0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966560; c=relaxed/simple;
	bh=PkTq45A0pBOP/QGhp4AupPzX479NRK/I048dkw50q7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGXN2t6phpzW9FE9elUUTdllxCZ9nDAky5AjLUSNcbTeeXPMlVzXUR2FLUvQim7gO3nwhr0/lT8+f0Ip3302CYm5M2VWiEoElW9/cAOjWxmPuWdfTrlwIYNEIisqzw1olPkYR+Kw9JHaYg/DpRAbn2UAE5uuCh3jTjEknkimV4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRC4FuRV; arc=pass smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51780bbc560so44026431cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780966558; cv=none;
        d=google.com; s=arc-20240605;
        b=bzesu9e+aEBEMiSgSQE77sbyNp4e2aX1NnSkn0y5fF5lVkyQnpQwbXJDohcLsHwF7v
         +49Cn6r9QFEEOyZXeAGkXEZ410TM6UnfEENELyoROpqcrl+L+jLZsFXzsWf47LsgrfXH
         DOXieCpoRxtBMD4vLtRq5f2QLrrv8/IRxS3UdI2Qw3bVBAeWW0MpKOyM3iRXhydXeGb0
         7qbm853WkPemhRIBtEM0PVtXTrh/hsXccXrf75uISZxeXkVUwQeeWW9rFQjB4eTrkfLx
         GCDGFHqr2orEDgpd2IEizVK0vzGo2v/lLGLqSZ3OK1Mu1WRW9XKKsXgXyDQuASnYW95R
         iFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OexP+buf3qM5cBAcvenS/GX07kQKu+F4HJ99bHSkAhc=;
        fh=tUYIF3+AFGmBr+69Y74Fj87f76cdmZhl5R7CKLKUtuM=;
        b=jWz2Vp0GWSPoEugqWP+AyVzx8t5QTPT8/hDoclxzrbIPfXIyLjGRGUai61N4rU0daP
         viPWRtJmYxfH4dyjPt2w8gycT7X+ICGqKWTkhRR1Xca40s48uB3w22jLDAKiAqKhtdVV
         9Olbhc89WfdA6FXDJMqUOL0u1U+SBk0oKwm20oUsyWmZl/faUgNGsB8BJu7jLQhA9mVv
         PROXEu0OEONxalaGvVtG+cUsX+3hCswVtv5np9up2leOGWE3SBqPi/+oTlBkEsNOLOO3
         s/CZysOEVlAMWod4qx4tpqhDoZXPaa1shJg3y7uAD/I9hpD8ipmuT1UXE83lMREqsqZl
         KupQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780966558; x=1781571358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OexP+buf3qM5cBAcvenS/GX07kQKu+F4HJ99bHSkAhc=;
        b=IRC4FuRVJm00HrJNKsroRTECvrJJxiIbXVTwi2/Lfk09xHbFz8S1jWrthEoT4mScM4
         BjBetJfLl90RH2f1xr0Ku1prVAF9fm9SrMgYNl7E+9HFcx1+SLgtK+2ZQZEKLSoqhDwB
         JBW3/nC/CyytjDOE3fGVodq6TgEU9xKP+SNDks1G7MRkIi033DNLR+fw+/oAHhN79Jbt
         931N9OjrSU+Y2Chm+bDljwgwjruU+3px7ZYslE23rLpHCQozfCjhzFEjnH0l3tB65/yo
         XKtuXk5Q0ihi+zW18G5dRjn52rHNpUCy7IFFGxg2LnogHaW1dlYDNCxiR+f4STR1kRwE
         OLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966558; x=1781571358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OexP+buf3qM5cBAcvenS/GX07kQKu+F4HJ99bHSkAhc=;
        b=KiKxYT4wDfO/NvqxPfns9ws6ls7pjq7d0f/4Ejr9/2TyyeA4vqUj6NqDY+pLnD6Wp4
         t2Ul2AgpIRHKdCK/6K11Flq1KpwO2BQTdvIt020JdUSuPcaTalz9mkoLOiwHXy1y304Y
         SETFuXPJ8Je+B1b1psTYRxhutaiUk5n4Qn2YjmrxBabkw7qnXfG4UYBo55+SQ4ZeuBro
         Dk5qzqEceEp11RqWy9cce2bxYHzXQJWYxECvRwQsLzc2FswpwzwJPrBCvj1uCfLo9mHO
         SlQ2KOhFaX1x8+5n646xe0PWcKTDY4+e5z8cF89vDq7pcAfDv21LlWUfFlFpTbf8xbfU
         qnAA==
X-Forwarded-Encrypted: i=1; AFNElJ/wwnvHlBzAs7Z9+bpZDoINWoluBO0NVnrnajw3gT4Mrhh85xG1CEwwgBXAXLkkmMo3vbbI5y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTAUdLC3S41nBcogxvw/uUlxu+Nk8DI/2S0YQ8I5SLkl1nZYr+
	x2ZA013mVVUDU64QwbKcCCL6nh9opOrlvtPpzEM2mfGZdXhyfgcGIoUtLMahaHFiw7zo34DVajN
	VLDoWyLP40ETxmsLHBy9vgbU4ZCMYo6G9AU6Izv26
X-Gm-Gg: Acq92OGXbBUX7pOk386DUgZvaaMsE6ldXg9IEAIi9Rbf5371Sw9LWoJ6SpvM2N2c+b/
	aGGBqJhLZsX/jpuUn1jMTmEbY5/OLD+Q8CmWmgwYhnOHt5zxoq5UTLHDHg1Ha+6k+YnoCkTAi0a
	FIhEZj0+K/MgH210WNoBLMy8f9zdlyJoicNrPsJOK0r6q9v517RDfKmmAxhsc6SHQAGQBp/lhsA
	CP2q0l+cKnMBtOC8cauY65kcsnb2ePvd+UxNn2TzI3WyWyAnV0nnun/iUbq4W47qAhZXyfIP3Vw
	ToAhrXY04rxJJJ3dWvWrswHld909DHBjpxyLh7MBl041G+L8bEl/ROKb88DNvUWlfMyc1HoX+M3
	XBz9qJDBi/Sb7/P/MY+RFv/ByOKBK
X-Received: by 2002:a05:622a:386:b0:50b:29da:ec58 with SMTP id
 d75a77b69052e-517986b65ddmr177661991cf.8.1780966557374; Mon, 08 Jun 2026
 17:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609003816.1238323.374833610959.fq-codel-change-quantum-stale-deficit@trailofbits.com>
In-Reply-To: <20260609003816.1238323.374833610959.fq-codel-change-quantum-stale-deficit@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 17:55:46 -0700
X-Gm-Features: AVVi8CeaVuJ3lCsU4H6NuBzPY2VZZJICC_NwMsxAw1HeDt9Let0Z_bS0G0onuL8
Message-ID: <CANn89i+4d2CbNKs+g2dyPpAbidgBx6OsD3xGdH+vOW8rAZhNYQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: fq_codel: clamp flow deficit after quantum changes
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296820-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,trailofbits.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 502BF65B7B2

On Mon, Jun 8, 2026 at 5:39=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> fq_codel updates the configured quantum without adjusting deficits for
> flows that are already active.  Those flows can continue to carry credit
> calculated under the old quantum.
>
> This can be observed by making a flow active, changing the quantum, and
> then dequeuing with the old deficit still present.
>
> Clamp active flow deficits to the new quantum when fq_codel's quantum
> changes so the new setting takes effect without waiting for stale credit
> to drain.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---

This is not an issue, and we are trying to make the whole thing lockless.

Iterating trough the flows would require to hold qdisc spinlock for a
possibly very long time.

I vote against this change.

