Return-Path: <netdev+bounces-255463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FFjFwozfmmTWQIAu9opvQ
	(envelope-from <netdev+bounces-255463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:51:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C38CC313D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCCCF301D4E2
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232DD327C13;
	Sat, 31 Jan 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KfB8BQ1F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129B31B107
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769878278; cv=pass; b=RQFNAlXp9N1MvonBZyDmcsVhXATgD0akFltZzc9xWTvdc0mHUK3sHbAGIpLsQVkf7DBOyz2TED5jKv89ZgeXiBIZs6qn3yVOY+97d8cXWAIqmW2RhrBMuYukgG2K2BmYbptDQX5JQl2E+vRdL2GTRJILjaGixnLilkNAur2h4Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769878278; c=relaxed/simple;
	bh=PlKDov0CfRrzdYPEAvA5RZPww3ErXc+h3pemJ8YZZU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PG21oog7BUYZ0RH3zAkdKx3uSo1QPZCuR+d/zeCdLMqp4e/dGYVbxB6IPc8EmjxlfAOyv04Y4G1UaLdpPr0EYiWGgep+XusZVHQNCUp7tXkXqLYJLOcaWz0JGVoqRiqcC2YXlpvH+ov7PfMHORcHJqgnUDtBjQeEH6lGq446NgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=KfB8BQ1F; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a79ded11a2so21378555ad.3
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 08:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769878276; cv=none;
        d=google.com; s=arc-20240605;
        b=igSbzX9OXSn25kAxqTQiWFisEQZmouxVH1U1tg9mAZtJJuCAUYX8tgg58rw6aCUzZP
         e3ELOcUT1njf4/9PL0FithmpZe05sO3QmmkLZCDAyY47rV/QLfakk2hXpVBjZ8U67Bh/
         75vzDntCjtpwRjHU5itLBojpwzQ/fj0SiSsGq3XpM10iktCZ/FDSzB2CwlHjpHobEFXv
         8NGXYO4BYigQpDUGk9rkIy0+nRFE0sujPV7dujMXyuz1vbN/hFmP2aUaVYm//RYeN+xA
         Md4h1M9f+Y3E1cTIqniaH8A6oCeTrOH21S6Jug2sWxLZf1EfqgWFOMbrzkUXrQFhYhR8
         6ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TwOhp3zvds/DC2IPQt15OObsZRJJzyJCu2Sudhqgw2Q=;
        fh=x9QdEeNHueCIkNXX527hi19agiCELBBIpe2v3pSsflY=;
        b=f8gNq7A6JVRQONKeu8CAi1T6VeM6ptmwGFhbJ001DIwIHvqBJkIiFXTGlNPqqpnMjW
         VJqJCV3w/9s5qY1ebaRNaf9QM5Qz7rizdhF7bnu+3J9w/FEWHI7rRxR5fadZXVW1MTVh
         Tq6m2ptYDEttZgYg6tRhrXDnmEHZl/lcL3imYSsVsyUUcmkp2/PRf6ZfwHamU3lpK070
         8d25USkLm+Nt7AfURNKEzLvkMiNR5Q3ZgQZJXk+KODgM7TA7HNGX7dU+ramfBNF5+Ruc
         segQHdjvCKB87R+Rl15iui6joS7ZZZMHw3MPtpKMNeoDx18aW7xs4XZeisQT0jiRIUOW
         fr+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769878276; x=1770483076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwOhp3zvds/DC2IPQt15OObsZRJJzyJCu2Sudhqgw2Q=;
        b=KfB8BQ1FdaKteUXVdB5oznY4T7as0z96BWE8n2lRP4Nd+QNqHq16CDukhtve3gaBjM
         h2rkxofcP2YhIxlXon6/caU1o0nsJMpFxx+SQBkol+oWWZdp17ncUFNCPO6cUgTM1PSP
         JDb49s4uvoRoNKBlDkbJB4GP+TUNo93QC6ZJw/sodgJh5N1kCdJII1KgXzeIJCgq2hOx
         DV51KikrpEy1PDrQvSE58sqNkStAeMuNestUr5/+ET6QWn+CgpIxYWXF5MMRxchbavFI
         L6GFY+qGpnnIz6NLBxJEIcgHlzRk1oo0a6lQtxyDC1cjxK8z7mM5Jv4GAcnk6/WOZbO7
         aPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769878276; x=1770483076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwOhp3zvds/DC2IPQt15OObsZRJJzyJCu2Sudhqgw2Q=;
        b=vBq6yTmZ17CwNQMN9RYqRHC/Zl9wUt83H05410pVYOsbXkBYwUw04+N29dRLuNjGpc
         oP8TV0kEx2Fj5rb6Ou9p7n/mdrR7E6g5Mu3cVqa0OyOqJ4zy2PTSfT+5kPjyZOz8TtWg
         8+W0i6//fL703ucTEu3GyjMQXGvTYl1lHXc2R7UIXaLvN6htZHFX3o4rZ+JmoOUHODod
         7A+32D4jClPWj3lxRVMRV3xL/UR62FEze2Rmd2H4hQKf8XK04X0LLJBQCGzbMdfTr9vd
         0ML5T0rTnfMjd5JL+CfqaQtlCZNK+jcqZ423Ze0gc0vojCoaOUgyJ+LVbuKxpGDiKn4A
         MIDA==
X-Gm-Message-State: AOJu0YwLxHv47M85/AeYopqQoldy1vQpNI0vxTAO4zUIxwWLQygY5it6
	llQnvKRuabRYOe++DKIgZanqQ7HkSHTma2vua3NCITZOA/QOphuPIf1vRl2JQ/0/GqCe15ltlPz
	lP11RRNZHvcvVWywcW2LN9T5p/J1IY2yng4QdqEE3
X-Gm-Gg: AZuq6aIzGV2Y90cQNmXFUINUnxHzHyr8bGY0O+AxB1DDH9j7pT99wAokLWWBgmWtGyE
	bE3fKgw2q/jErf7HErhrOM7PIfolMfEifaou0iz2fonETo18vBqFzczo/MEBt9VZNWCy3itP9oX
	HTe854E7UpONR+5oev/ZpyupuwRq9fllnxVPObYXZobdZ0vFshY27jUP0B0fii6/CXWeSBah0j7
	QK55uSJR56dKGNH1Q1dvOklHLtMdmmszGI1F07Nw7dFKSoFeLCo8O75H+39K6j7Sfad7ZNvRkf2
	JfU=
X-Received: by 2002:a17:903:2bcc:b0:2a7:ca82:c198 with SMTP id
 d9443c01a7336-2a8d9593256mr66751155ad.6.1769878275702; Sat, 31 Jan 2026
 08:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com>
 <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org>
 <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com> <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org>
In-Reply-To: <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Jan 2026 11:51:04 -0500
X-Gm-Features: AZwV_QhbvdUGGDKHMSVrKRp__slOASeUl2cG-7KOOlKDJEhjhAF8ghls5VrtbvI
Message-ID: <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Po Liu <Po.Liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255463-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,nxp.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,1g4.org:email,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9C38CC313D
X-Rspamd-Action: no action

.

On Fri, Jan 30, 2026 at 3:48=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> What version of act_gate.c are you currently testing?

I am running plain ubuntu on this machine using their shipped kernel 6.8.0.
But i did look at the latest kernel tree and the dumping code has not chang=
ed.
+Cc Po Liu who i believe added that code.

>Did you actually run the tests? =E2=80=9Clarge dump=E2=80=9D creates ONE a=
ction at base_index, with num_entries=3D100, then immediately does GETACTIO=
N. So =E2=80=9Ctc actions ls action gate | grep index | wc -l=E2=80=9D won=
=E2=80=99t exercise this, because it only counts actions. It doesn=E2=80=99=
t amplify the per action dump size (the entry list does). It uses libmnl (m=
nl_socket_sendto / mnl_socket_recvfrom) with MNL_SOCKET_BUFFER_SIZE. There =
is no custom netlink handling. The failure is returned by the kernel before=
 userspace parses anything. The dumps are transactional at the netlink leve=
l, but an individual action dump still has to fit in the skb backing that m=
essage.

Sorry - I am not running your code (didnt want to compile anything on
this machine), just plain tc and i have to admit I dont know much
about the mechanics or spec for gate, so my example is based on
something Po Liu posted, here's a script to add 100 entries:
---
for i in {1..100}; do
    echo "$i"
    tc actions add action gate clockid CLOCK_TAI sched-entry open
200000000 -1 8000000 sched-entry close 100000000 -1 -1
done
---

Then dumping:

$ sudo tc actions ls action gate | grep index
index 1 ref 1 bind 0
index 2 ref 1 bind 0
index 3 ref 1 bind 0
index 4 ref 1 bind 0
index 5 ref 1 bind 0
index 6 ref 1 bind 0
..
...
....
index 95 ref 1 bind 0
index 96 ref 1 bind 0
index 97 ref 1 bind 0
index 98 ref 1 bind 0
index 99 ref 1 bind 0
index 100 ref 1 bind 0
$


>
> look at af_netlink.c
>         /* NLMSG_GOODSIZE is small to avoid high order allocations being
>          * required, but it makes sense to _attempt_ a 32KiB allocation
>          * to reduce number of system calls on dump operations, if user
>          * ever provided a big enough buffer.
>          */
>          ...
>         /* Trim skb to allocated size. User is expected to provide buffer=
 as
>          * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
>          * netlink_recvmsg())). dump will pack as many smaller messages a=
s
>          * could fit within the allocated skb. skb is typically allocated
>          * with larger space than required (could be as much as near 2x t=
he
>          * requested size with align to next power of 2 approach). Allowi=
ng
>          * dump to use the excess space makes it difficult for a user to =
have a
>          * reasonable static buffer based on the expected largest dump of=
 a
>          * single netdev. The outcome is MSG_TRUNC error.
>          */
>
> This is where I am currently but I have seen these bugs appear throughout=
 all my iterations including what's in the tree currently, if you show me b=
etter alternatives that solve my problems, I'll gladly accept.
> https://github.com/torvalds/linux/compare/master...jopamo:linux:net-stabl=
e-upstream-v4
>

I dont see a problem with "dump" as you seem to be suggesting. I asked
earlier if it is possible that you can create some single entry - not
100 as shown above that will consume more than NLMSG_GOODSIZE? My
limited knowledge is not helping me see such a scenario.

I looked at the transaction of how the 100 entries are dumped and i
see the following:
$ sudo tc actions ls action gate | grep total
total acts 12
total acts 12
total acts 76

User space received batches of 12, 12, and last one was 76 before it
received an empty message with NLMSG_DONE.

cheers,
jamal

