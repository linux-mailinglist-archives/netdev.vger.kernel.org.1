Return-Path: <netdev+bounces-305563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +YpYDEdCTWrSxQEAu9opvQ
	(envelope-from <netdev+bounces-305563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:15:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F871E8BD
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:15:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=pivGcpJm;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305563-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305563-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3E303055C4A
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE13743C7A9;
	Tue,  7 Jul 2026 18:13:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027143C7B2
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 18:13:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448032; cv=pass; b=dwuDwrnP6XaCgu55g/NMSLziPQpRnueoyP/ZDPlYc4CCHR/IDsS15hecOFSOELbbcOV4pE/+Zki/FFSp0r1dbfU/Hku/xUJ9VnSqkGKLDxd+8N8fkq+yRPbr46MrgTyn9VZZoxOOdvU6q6S1e9IpLWWS6H28Tx6bt8P5wLNEtJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448032; c=relaxed/simple;
	bh=PaKwhx7OFx8V5ymHc3fSiLx9u8GvqVCxxeEBAgpxEWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCAD+uqPZDEno/GoES0pNDwP/t0gB+F856oU85sI2OE7YmJi77I1z+2ZTmP08Z2Orp/w9vTfKla+ADr1KJlWvJ9WbTaWGn+pSefxXc/cmpI0yZnT7NYYLZIjBhNaLfeij+r4rF4oOpVE349CH6K9rCj9SciEY8vWAOk4kHe2StI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=pivGcpJm; arc=pass smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-845eb7b96feso4435116b3a.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 11:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783448031; cv=none;
        d=google.com; s=arc-20260327;
        b=KM/rYsUsJ21BZ5N6NkcX6iNCzRxoNEGHZb7NmzeYMJrx0kua7dobGJtAbQnG1rUEv5
         zicOtwJnHO4UMDG3RjDqVwgaIRovl7+8kEswLpm9hRa/zgUsXTKkRqQ3TMZqfCIZ6RkL
         WcdS8AAi6LA+k6TTK/G6i6ujjkmTiNfsbCVmnD+Jw+ZownzzG6kKXHgWlcnCLsIHMlP0
         bBeMvcVM0mcRBdNMpz9bCbFxGCetIugIxOyCT+CEt8JeqVppNoGa3W9kf695hl+M3QqQ
         tIV2g+CIh4XaYCkgMJLvvGVYz6avuSuUesigDNTKh+HT80wiqknE2I8IUIqLlIB0ZURt
         TWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Il0fS3EqZYDSH+4CImnwZDDp7xnni5Su6f2YcQJGe/4=;
        fh=e+jOas3gZrPYhNac4MMEC5foKS5GfTJeOqfpUTlIP4Q=;
        b=iczshS0+noF7V8TezqI1skySMoYY8jxOclphWK45t/AmCMJfnfwfjvExjR/lCyOOvq
         YZM30pyiaambXbrXeaav5EBab2+H9INcdcX22FU1Ylh2lB6KviJ9OiCszh51oaKZ8kiW
         BVQl5EgkGxKgdBWtTqPLE7WIJsV9KZCbDwgug7A8mJpRmfhvU5RhMuVZcexPumFt42aL
         Gk3nO5GGDVxkg40Icrn5qu54sZXienSNw4bB0Snzic9OHIwWF5BNPkN0qeVJeF/s3wXR
         NBQ8uQ3tuJ1eRW9vOA9LiVndBgAdvgCDVClFfoKVXq0NG1/70t0Dl7+jVQ09+OFHFqN1
         fqcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783448030; x=1784052830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Il0fS3EqZYDSH+4CImnwZDDp7xnni5Su6f2YcQJGe/4=;
        b=pivGcpJmEmjQ8H6H8pIzN+2iesbXnwPYm5SaKx82C3uLu/MwQ8Y1T45kyhBu8v+Fbu
         IdabCkS5lilgBQDltQhjVlS2QLBA5AbtvNVrSkVJ8IToYVYJczDmcNXenEhEpzxFkOoH
         rJSlUJ/8O11daiebvhEd1cMRNJBgEeIxGm2Zn8oXJR1m26MTWuZLGd7idUP75oM+DPOz
         HR7k3CBlwuZ4H6wfwaSk3T7X7U/CgM+xhflNuR1uNlwpYWvq4Zj2r5MkLvn8ZjyUwQfP
         v/LUmLO3sJ5uOAXvlev6oFKGFVhzSByT+9m6FLcLsaIPfRW1ysO/zY0v5FRoX477QKD2
         g5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783448030; x=1784052830;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Il0fS3EqZYDSH+4CImnwZDDp7xnni5Su6f2YcQJGe/4=;
        b=tXT1yq3fRsRwsIIBYZt6UlVFPhSVuc42hGYOgIlS+DqRy/BGCeG64cdkovVQEdCA2N
         RTO5FvsGUHcMeB18Egzt7pY5gAzE9q9IT3LEs/OQJB0WZBPzkaMZfobksXgIiVqiiw2C
         UL560QPOE4neKnWyDcUZ0z15Tdu4rWFPrC0ki5TDsQkB5Pm8SRQD01ldQMRfvcctBmXJ
         oELZEqjSkHsnmJL2mCvacDh8kAciP9HgEhQmpJ79nEqT+cA5KOdVulqMPf+fu8IRgEJJ
         zQHTIYnEb7nbg3cvybSoJNERGknGkrQ3FW/q4RSBMKwq63C3+T4iJDDm1eeM1TFAZA3o
         dIAw==
X-Forwarded-Encrypted: i=1; AHgh+RpfHaExriaLm+4B81b2/1PdlPbe1bUsV4eYAWuObDBlSM+/ab/EW9QRD1fEZnErDP7XItwqbRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4ylxMsydG7eHU75ZZzz183jpFLNHftuyYIGIBbvsNEnqrdvF
	ppnMRK71MyF3msXToOMZNaJRhUdsFMCbYwyi/fOUwu5OTPZzLMCUAy6D3i41fVVtpH/sGuktflf
	8D/CMfdwr1d8b+9sbL9qtZyQZsIqysEQZUYI0Suri
X-Gm-Gg: AfdE7clOMYmhrJhOkg8ZuW+b0P6md7mgqYlPypuLFFRhyqutfriPby31C1cfodWusr6
	Ra2MqIMAuij8JeDeY6iQFFN+EUhrkqnybf3I+kFaj1c740NgeKKlqr7CiE2guQ1v/mo4howJR3a
	J3JuF5Vbx3ienrLuNgslU/OFAEhRgOQnL8EihR4LByj4y4Sz+Gz19P73COFMg0fDdDI7B7oYxbT
	6X5LfsZ54aMQNCEMqeENS9HCCuViJICVCF1iKKtxT9h9HytuaSOCXduMJ3Z7cnxNozTZAvJW+cD
	E4ZpC4cJyd5W8QAWlEeKq+3ye2b/
X-Received: by 2002:a05:6a00:3a0d:b0:82f:72e6:ed4 with SMTP id
 d2e1a72fcca58-84826a36650mr6063625b3a.0.1783448030625; Tue, 07 Jul 2026
 11:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703051932.966884-1-xmei5@asu.edu> <akdM501yK5_mk1th@strlen.de>
 <akyeIoKtMaRiQUI7@secunet.com>
In-Reply-To: <akyeIoKtMaRiQUI7@secunet.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 7 Jul 2026 11:13:39 -0700
X-Gm-Features: AVVi8CdIO81i0KHxN9CsWNdtvLUkZbUyWQMDl28BHIT8ezRg-sB_dL0zKQFVoRM
Message-ID: <CAPpSM+Sef_Merq3a06UVyyDaAk0J3qsxDqv0_Dh4PpBZFcXfHQ@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: policy: preallocate inexact bins before
 xfrm_hash_rebuild reinsert
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Florian Westphal <fw@strlen.de>, herbert@gondor.apana.org.au, davem@davemloft.net, 
	netdev@vger.kernel.org, horms@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:fw@strlen.de,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-305563-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:from_mime,asu.edu:email,asu.edu:dkim,mail.gmail.com:mid,vger.kernel.org:from_smtp,strlen.de:email,secunet.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 731F871E8BD

On Mon, Jul 6, 2026 at 11:35=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Fri, Jul 03, 2026 at 07:47:19AM +0200, Florian Westphal wrote:
> > Xiang Mei (Microsoft) <xmei5@asu.edu> wrote:
> > > xfrm_hash_rebuild()'s first loop preallocates the bins/chains the rei=
nsert
> > > loop needs, so the reinsert (after hlist_del_rcu()) cannot allocate o=
r
> > > fail. But its guard is inverted: it skips policies with prefixlen <
> > > threshold and preallocates for the rest.
> > >
> > > prefixlen < threshold is exactly when policy_hash_bysel() returns NUL=
L and
> > > the reinsert takes the allocating xfrm_policy_inexact_insert() path. =
So the
> > > loop preallocates for the exact policies (which never allocate) and s=
kips
> > > the inexact ones, whose bin/node is then allocated GFP_ATOMIC during
> > > reinsert. On failure the error path only WARN_ONCE()s and continues,
> > > leaving a poisoned bydst node; the next rebuild's hlist_del_rcu()
> > > dereferences LIST_POISON2 and takes a GPF. Reachable under memory pre=
ssure,
> > > deterministic via failslab.
> > >
> > > Invert the guard so preallocation covers exactly the reinserted polic=
ies;
> > > the reinsert then allocates nothing and cannot fail.
> > >
> > > Crash:
> > >   Oops: general protection fault, probably for non-canonical address
> > >   0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
> > >   KASAN: maybe wild-memory-access in range [0xdead...]
> > >   ...
> > >   Workqueue: events xfrm_hash_rebuild
> > >   RIP: 0010:xfrm_hash_rebuild+0x5b3/0x1190
> > >   RAX: dead000000000122   (LIST_POISON2 + offset)
> > >   ...
> > >   Call Trace:
> > >    hlist_del_rcu (include/linux/rculist.h:599)
> > >    xfrm_hash_rebuild (net/xfrm/xfrm_policy.c:1365)
> > >    process_one_work (kernel/workqueue.c:3322)
> > >    worker_thread (kernel/workqueue.c:3486)
> > >    kthread (kernel/kthread.c:436)
> > >    ret_from_fork (arch/x86/kernel/process.c:158)
> > >    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> > >    ...
> > >   Kernel panic - not syncing: Fatal exception in interrupt
> > >
> > > Fixes: 24969facd704 ("xfrm: policy: store inexact policies in an rhas=
htable")
> > > Reported-by: AutonomousCodeSecurity@microsoft.com
> > > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> >
> > Reviewed-by: Florian Westphal <fw@strlen.de>
>
> Applied, thanks everyone!
Awesome, thanks!

