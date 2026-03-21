Return-Path: <netdev+bounces-270241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zotKGIXovmmDjAMAu9opvQ
	(envelope-from <netdev+bounces-270241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:50:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8742E6DA2
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AECC300B05A
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DAA2FA0C7;
	Sat, 21 Mar 2026 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwOAGa6f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778762DCF46
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774119041; cv=pass; b=eJHi0dRLjwkFYhsH4Gaf0u4WTIe3HutbbA/4GVU79wdLgCYpZg4F1nI0YFNOh7/d+o76lIHIOFnoRo+TK350pN/9aWi0rrBfId/1qvXQelQSwS4eqvODRlBXy4qVf2oWeTX5tbR+qQcBIx2+KM7U9OItHr9HDSF9Za6ankprG+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774119041; c=relaxed/simple;
	bh=+0No1nOe3K8acpsovC+eRn2fpHxV0wIVdlMJvNTeFzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcrzaR3/QqIKX/JJ6yRkEJwdhYhimyvpviImnlC9jt/u9tvH5QJq7GGoFGVi/KR2V4GClajCJN53iKCvHBewkVMTb0qhj86g1cnGUERgvPV5AzvNAtI8DHTTRtTPzK87jU36kwuqlZn/V4qDZpF6tfg+cqJQ6H8eTup7ncqLu48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwOAGa6f; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ae222d978so3183524d50.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 11:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774119039; cv=none;
        d=google.com; s=arc-20240605;
        b=UzeUP2iTuWoTqwwLc3vUEGWgDdlSPDbWvNL9Cnlm2njWZe+bAQPioz9//WgEoTiTkE
         NerEObdJPkMFNSScIAs5VS2fHuXeb/yHWemqJ9v4e4aQUfbAiUBUyAYDqoBgxy/UGaOB
         COMZLc7OQ00NIJfg+1QXrm06jvyUcDnSF51V3h5j0BfU6FENYNf+z4LUsMzADXMwY0Hl
         lcLhwn6+SW9m22XWBsRT8+M1EXV2hHIF6pcNwMKyXBIMBzpklyGwDLDJ+wOzlRhGsyoX
         tZhynaS3B9xuiPvPhUFyV5SZmtBRV07jrkdc+NsqpOXjpn+nVyQs7Gg5AutFq4bCG7ji
         Wq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9kUzADYXy/NGXQSWeaYXgTqQSK+6xS5PfeQEuXgpkVs=;
        fh=Xc+i9978KFyI8pb9aA8ka7z6AF2drxGCAZW5UmHsnTc=;
        b=Uk7V88QcF0dkflgcJAIwJaEbGNoCOJYuW5Dvv7S+7EQN+u7lWd8OF5ye/zKYPE7PlP
         MnkbfJZVeZfquB/le5TkzFkVCAiSRvh2cV0ytpkiFZ8KddEQhrgx/ugIIR+m5NhutV8v
         83SeCLRwt/Q2g+kkw3NhNf+1gPTh5ksDC51QUY3LaFPn+kIOp7oYZSz1CcZJKlFvjswZ
         qC4fLCAm6JStIMVXS12r6kP67+QK4fWsu5kSJw2vVo4zO9/8s93hOH4yemWCLUtTN1rz
         4uqyrulysU/RRf3Vur1NZO9vlTsHvkWa1ug2ksrvc7iK4DxxO1+3zdaC5vGZFt6fo1Zl
         m37A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774119039; x=1774723839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kUzADYXy/NGXQSWeaYXgTqQSK+6xS5PfeQEuXgpkVs=;
        b=gwOAGa6frfrfo1I1NCI2qE5kPq1Tlv+5/gAp6XUSPW315zVK6bWYjg7y6IM2aLQMgW
         gtOEggGT/G7sZXCQaNb93t1SFxZGsqGMS2b0SDyfvhvxAtJs4kKPnO6BeFBYxUJuU+3n
         l5iLkayGUDJrNFPLTIWxA2FIdqgkdC+a6bXyN33QhzwM/sp3xiEg8ASO5rpZqQx6mnIt
         vhRRnyEpM5OWPES80pg9GqrAt1OzqTAhZ9vu3+0oksOj/0KczXl+S6YAw6aI3PIVwK9C
         GL1OfhunjkP2ODJnZOBxf23o9BCRLvJagtMjj7QfFL6kardj84Fdck0hXp2ARP3+eHba
         ahIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774119039; x=1774723839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kUzADYXy/NGXQSWeaYXgTqQSK+6xS5PfeQEuXgpkVs=;
        b=HGGWQxSLIw4aILhYQoLon3W8QGodiyiIyhhq3NgE5/f4/W2TW8f+vEyymEtMRFV9kK
         Wp5oZHt40dSf/y1mvdJGkIKmwHzPObIAmrSXIkeQLWNJ6030JAdSKJ0v8IpCveH017Uu
         DOBsnRsr7MjrCYXSHBlUfgYOGstXuX8h3/6qNhsGzBONNldvk8GJdWv9MBWG7LzIjEmM
         V/1yGyaE0OQzWu7cZ4OkVBTB8F8WTgx+4N0Lz/bkI9j3T3biUPKCcXfcr4/ufvyLvnnK
         rTS0Cbp/fARofEJEQ+zH4jPcJOX8M0flrZ4b1VU/h+OoXVYdltEKCoDRCOe6CjNoiKir
         4lVg==
X-Forwarded-Encrypted: i=1; AJvYcCXS2qw79tdEn85VqaF8terD1dbPE4M8K+AuitzFlfawe+KWSuWvLSnGmgNrNTx/kVeaeDQQVz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjigqAAwAcPTOsO81zGOeZrbT1nZBTFv5+rh81ZcfqrghMjhlS
	XYY0T+2oSQoiQsmKsCfsSabJF9Crmz/KXK3/+yAnbChmv25JKQ69MJgEB+/UJR4SYPhJ4e6C76z
	/LsnR1f0mCII4yjpbFZ3AhSWxgRerqg8=
X-Gm-Gg: ATEYQzxBJA5IAXtPDbdtbSaNCIKclQgfEF8y/fuQtaANSNWwv0CDdJ+GZd3pqzNwKHb
	v7b3VKhbrwjf3EKRTocadiHbkEk27Mq1XB8IGAWXn+ZyEmGjxumr6aZyQLm0CZRyCoNLssnVV1H
	28IqCVqeReiwZA/XPeAlzKILZ+SnRdZ47r17KTmQzb5FXRbGZnPjIEEfFDM/GOZgqQEmsGVfrZd
	TEPVdmDY+3yeQRLE4WhvRMrzpMtV+LGY7GYOXZ8EllQb39fKEDeQHD0uRpqFDiUMpuM4pP4axGC
	MmP5i4lGi6gUNGOaKrWFrR0ZVQZlC3B7/bBJlQgmsEBqsL+S+fJ4EHq7l5n2L9dyKg6k+A==
X-Received: by 2002:a05:690e:3cf:b0:64a:f138:3172 with SMTP id
 956f58d0204a3-64eaa7f1428mr5525702d50.59.1774119039521; Sat, 21 Mar 2026
 11:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info> <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
 <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com> <CAHk-=wgryF_COh9xzhGaJ-FAm471pn5uvqt-Z94+3ENPVu4w-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgryF_COh9xzhGaJ-FAm471pn5uvqt-Z94+3ENPVu4w-Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 21 Mar 2026 14:50:28 -0400
X-Gm-Features: AaiRm51cGXYHCRKZ4R7legIePMrTOfuHm9IjRv6oMxOWqE8F-4Vc5HcbG73sqko
Message-ID: <CABBYNZ+YC43qvRQb7-KXv-EJ=s1Bhdf-Xu1xeEZVuzq96R7NTA@mail.gmail.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270241-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AC8742E6DA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus,

On Fri, Mar 20, 2026 at 5:19=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 20 Mar 2026 at 14:03, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > That hardware may admittedly often not be great, and we may all wish
> > that it didn't exist, but hey, that's the thing about reality: it's
> > often messy.
>
> Of course, the thing about "reality is often messy" is that then you
> end up with the truly conflicting situations where there are other
> complications: security issues can sometimes mean that you *really*
> can't just revert a regression fix, because while paper standards and
> artificial tests are relatively worthless (compared to a user
> regression report), a severe security problem obviously isn't...
>
> Also, if the regression reports then come in late, people may have
> started relying on the new behavior, and reverting things then causes
> its own set of regressions.
>
> But when you get a regression report quickly during the early -rc
> period, that tends to mean that it's either a really bad fix, or it's
> just a very common piece of bad hardware (or a shared bug across many
> different hw implementations - which obviously is often then due to
> some common chip or firmware implementation or whatever)

While I agree specs sometimes tend to be worthless they sort of guide
future implementations, so in the end it is not always black or white.
Anyway, since this escalated rather quickly I think next time I'll
just revert and work out the situation on bluetooth-next, rather than
trying to access with the reporter and risk  delaying a fix.


--=20
Luiz Augusto von Dentz

