Return-Path: <netdev+bounces-255474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFGRGUM+fmk6WgIAu9opvQ
	(envelope-from <netdev+bounces-255474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:39:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB707C3571
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A04D230869FB
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC9359706;
	Sat, 31 Jan 2026 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="F1XgtR6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B2356A2A
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880894; cv=pass; b=r2M3Imvj/X4F4oQTF4Vj6NzCELw4Fiy/oicRTbm588IGBhYj7PZUmdN0lXwqTNe/7/dtd5dvtjhX1+CSoFYf7TWL+VA967HEdYxOvtSm4bdNEKZLg0cBzUuJzpxXdvM8o7z+s7/SRUlJmc8spVHJHmaWs74FXlBR+4XUuHu/vw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880894; c=relaxed/simple;
	bh=rwxHVPwLM6lwPSweUCUZ13r7SOjMvXjcBMQ8Nx6DupY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuCxbXMsdRegnUq+yeelf9HIaQ+EO3G1cvas0zCqPV2aJXga3y/tceSaTqBBamtkUpsaOb5wZUVvpW8UJVMs3e4xdxXEjB4mbCviy+9PssMODazmriFmJc/hGSXB0FR1ZOyrdW6SDH/gockjqhGpl4Qc0w4iTfeWPnM5iqjRuco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=F1XgtR6T; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-350fe1f8ea3so1453185a91.2
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:34:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769880892; cv=none;
        d=google.com; s=arc-20240605;
        b=hoWHXOvqJtmoxOlxiC6YqzTgvV5ELt8Y1FazY54YzERXotfdvue5jN98CZ7+tFJvWL
         QovfjXMpyKlf2lvHgMww+7XFuOuUy6PqrhIHy1cuq6TrzFgRqUv2BiskhvdEWCOXjLtf
         VKUWlLc8CdWhlRWn7nwWg0pxw0rMxcwc4kncZWY2Fz6ozdnHxicw4POAmLvTroWe/S49
         veah6C1P2IIGkv/n/M3HdNr8R0ccMaRgDSfO2GLpt01Wq5KZTT8kNJxUpTA1qgV0rwbI
         f1ANlKuSRd4k3v7a7ce1dr78iwg0hDQuqbxjKtirrsyzoY1Z5tc8l6l73T9d0bMtDD8m
         cYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pRq9TSnVCRoT0kA8eXHwrla0Y2fyHGlCHi8rmNssvS4=;
        fh=d825hyJZgoaUkZ3eAKRyzjfAo2sQ1Dz7vSNc2ZZXL9c=;
        b=f7xcBMH86vTkx2tQH7AhCFiVSheYaOLX8iFUrcH+D62YAd2HrTOayqNDDWYGcyv35r
         fjZwFuWwbV4yMl+j9z6SS0+e+qAQEWPwrXO9YN8IONzv15Yb+zwcFy5kvuKYfbhIBl4j
         UPnY6j4PQOOtPbLsmZD2rzZ4wd+rwCv8fIqoIaSCN1094JVbH9TtWZGop2H3WnBEL9wn
         V9pG+8Je+i4JWFdL8MxRy2NV0Sk/bSMqONdnFManFN9fJq3utVKo1TZuAc6filEKdCw1
         yRNJ7mFWg1wLVGy+o/uT1Fvf5QGiRp/5UqWHGxhEL/vQg9a0MVqgDqRUJughkrjrSPIa
         /NZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769880892; x=1770485692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRq9TSnVCRoT0kA8eXHwrla0Y2fyHGlCHi8rmNssvS4=;
        b=F1XgtR6TVxfFIbRhiJI0gCM7+vsjxAE0l1kSgbcpTnJLNOJS6EgcwN94slYw+wvx7Y
         Mg+nv+y3QWcueguq9pke288jlgjTlMVten70Ar+y5hU8a6OoXEb1ls5v8wtEhtJivHqp
         QEkMeD7BWR/+eWOLw4v+oZFB62xE1HYDCF77UB26u1Ivva+ta95t7Fytaa7xhfVuhzTV
         hcLE1qpg8IgnywzuZOlp5JfVtaPs9vjoCCgnKDOjPphW+piH6t09iFAncF6fYJCqv4RX
         hojxu0XFGFlo1g6/QwlutQBgBgmgOIMp81o6RrZ0HdQ+W73Ww0Tu/jGE7J3NhDC4oqNK
         LStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769880892; x=1770485692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pRq9TSnVCRoT0kA8eXHwrla0Y2fyHGlCHi8rmNssvS4=;
        b=VEGJnRzAaOCRPFDVnplejuLAiSxO+X7VY1tW/6E0une2SIl58OXzBu3cLl3P/y5yJU
         4ABRG3pAXNUiVh8Kb8OyjHkVvEHWrakwJb/9FMCNCs2ggBB1DbumvATJ/wW++6VwPp/r
         uPBXtVPoUxSVBgxCXHiozFLCtLG/OCWzviWIyuN45BjHCdYWbhIYbjIoyEpBsJLP7BCD
         1VMCvcFVXLDJqCfEiqgjOuDEgcAVaM4Jspdv5M8KO9Yt1lQx1Rh8/Do3mBfXQX7neUeB
         SyBm0xqTQH1bZ8E6NZfII+cembOUtHZ+B1mnRkNfWq4VtvovseMKycBb1L9RhD0iApVe
         FEmw==
X-Gm-Message-State: AOJu0YwSYtFFoPN0i+57zHV6HVyi/jB/sQ84osSFwwNfFRLUsPEJNpWF
	MiSNoDtn+loAjgj4ADUOPAUIGsEnJ1IT/teuoheOjmajZcMa4Wr2CXiZ1lgBkJwghD0yZhbZJLl
	+XIdBYOOSLyaufkpnfx81KdcQM72fDlJAH+OEj2Wj
X-Gm-Gg: AZuq6aIuHmWv3ziHE8mYqXCVdVdt5aBco4Iub1X9eqVIijiNzI+6VG6lpCsGPX5Q58X
	7EIIpEgBJtxdj1ZV9m2jXW9SL5LutEI4dJWy+qcH4YVZQXx7MEA0Kj4AdGSa8uq3BcDPsSj0uZz
	R4gVIunIHqSxWGOiAexEZHdx7HNk6hY2bg97mlRkS5mUuoLDFeNrOgSow1VyOgNgoq03gmU0GMg
	d+KG8cjVLBC3OlW9WYK9DGcjVC3+AYAnNTPVJTDIzuUSfd+xxDlmKrSByk+eqAhUmxL2pWDwGWY
	xC0=
X-Received: by 2002:a17:90b:4ac4:b0:340:99fd:9676 with SMTP id
 98e67ed59e1d1-3543b33768dmr6464506a91.10.1769880891916; Sat, 31 Jan 2026
 09:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com>
 <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org>
 <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com>
 <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org>
 <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com>
 <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com> <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org>
In-Reply-To: <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Jan 2026 12:34:40 -0500
X-Gm-Features: AZwV_QievSWCq04jDFvtsln_FK9Hyq6MQM3y0I2wr5k7K1rPYdtJinWbtN1wNJ4
Message-ID: <CAM0EoMkD=3aRFq=tXijcop5tYsD4X_Ki0REcnj3x+w_C69MaFw@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255474-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,1g4.org:email]
X-Rspamd-Queue-Id: CB707C3571
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 12:18=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> 1. Your script creates 100 separate gate actions, not one gate action wit=
h a large schedule.
> 2. Each =E2=80=9Ctc actions add =E2=80=A6 gate =E2=80=A6=E2=80=9D call cr=
eates a new action, so you end up with 100 small actions.
> 3. The issue I am reporting needs one single gate action that contains ma=
ny sched-entry objects.
> 4. Because of that, your test only exercises the dump path with many smal=
l actions.
> 5. The failure I see is in the GETACTION notify path, not in the generic =
dump batching logic.
> 6. In that path, tcf_get_notify() allocates a fixed-size skb using NLMSG_=
GOODSIZE.
> 7. The kernel then tries to serialize one action into that skb.
> 8. If a single action contains a large gate schedule, tca_get_fill() runs=
 out of tailroom and fails, and the kernel returns -EINVAL.
> 9. A single sched-entry does not exceed NLMSG_GOODSIZE.
> 10. The problem is one action with many sched-entries, because the entire=
 entry list is serialized into the payload of that one action.
> 11. The =E2=80=9Ctotal acts 12 / 12 / 76=E2=80=9D output only shows how m=
any small actions were packed into each dump batch.
> 12. It does not reflect the size of an individual action dump, and in you=
r test each action is small.
> 13. To reproduce with tc, you need one tc invocation that adds many sched=
-entry attributes to the same gate action, and then run =E2=80=9Ctc actions=
 get action gate index <idx>=E2=80=9D on that action.
> 14. tc has it's own limit at 1024 apparently "addattr_l ERROR: message ex=
ceeded bound of 1024"
>

Yes, thats the same error i was getting (with script below).
---
ENTRY=3D"sched-entry open 200000000 -1 8000000 sched-entry close 100000000 =
-1 -1 "
SCHEDULE=3D$(printf "$ENTRY%.0s" {1..100})
#SCHEDULE=3D$(printf "$ENTRY%.0s" {1..10})

for i in {1..2}; do
    echo "Iteration: $i"
    tc actions add action gate clockid CLOCK_TAI $SCHEDULE
done
----

I know of no other action that exceeds this limit with all its params
batched, and of course tc in userspace truncates it to about 32.
Addition does succeed at 32 of those things per action.
I have no idea if above is legal but it is allowed by the system.

> I'm not opposed to gate being clamped instead of adding support for large=
 schedule sizes, but I wanted to thoroughly document why it's not possible =
so the next person isn't chasing a cryptic -EINVAL like I did.
>

We cant have it to be infinite for sure - we will need to put an upper
bound in parse_gate_list().
Are you knowledgeable about this spec? I was Ccing Po Liu but his
email is bouncing (so i removed him).

So back to your first post: I agree we have an issue here. Your
solution will solve the event notifications but then we will need an
upper bound check. We will also need to check that same upper bound in
user space iproute2 code so we dont allow arbitrary values. Current
number of 16 seems to work just fine - if we agree that is a "good"
number (or if the specs dicate it is) then you can simply provide that
fix..

cheers,
jamal


> Thanks
> Paul
>
>
>
>
> On Saturday, January 31st, 2026 at 11:14 AM, Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
>
> >
> >
> > On Sat, Jan 31, 2026 at 11:51=E2=80=AFAM Jamal Hadi Salim jhs@mojatatu.=
com wrote:
> >
> > > .
> > >
> > > On Fri, Jan 30, 2026 at 3:48=E2=80=AFPM Paul Moses p@1g4.org wrote:
> > >
> > > > What version of act_gate.c are you currently testing?
> > >
> > > I am running plain ubuntu on this machine using their shipped kernel =
6.8.0.
> > > But i did look at the latest kernel tree and the dumping code has not=
 changed.
> > > +Cc Po Liu who i believe added that code.
> > >
> > > > Did you actually run the tests? =E2=80=9Clarge dump=E2=80=9D create=
s ONE action at base_index, with num_entries=3D100, then immediately does G=
ETACTION. So =E2=80=9Ctc actions ls action gate | grep index | wc -l=E2=80=
=9D won=E2=80=99t exercise this, because it only counts actions. It doesn=
=E2=80=99t amplify the per action dump size (the entry list does). It uses =
libmnl (mnl_socket_sendto / mnl_socket_recvfrom) with MNL_SOCKET_BUFFER_SIZ=
E. There is no custom netlink handling. The failure is returned by the kern=
el before userspace parses anything. The dumps are transactional at the net=
link level, but an individual action dump still has to fit in the skb backi=
ng that message.
> > >
> > > Sorry - I am not running your code (didnt want to compile anything on
> > > this machine), just plain tc and i have to admit I dont know much
> > > about the mechanics or spec for gate, so my example is based on
> > > something Po Liu posted, here's a script to add 100 entries:
> > > ---
> > > for i in {1..100}; do
> > > echo "$i"
> > > tc actions add action gate clockid CLOCK_TAI sched-entry open
> > > 200000000 -1 8000000 sched-entry close 100000000 -1 -1
> > > done
> > > ---
> > >
> > > Then dumping:
> > >
> > > $ sudo tc actions ls action gate | grep index
> > > index 1 ref 1 bind 0
> > > index 2 ref 1 bind 0
> > > index 3 ref 1 bind 0
> > > index 4 ref 1 bind 0
> > > index 5 ref 1 bind 0
> > > index 6 ref 1 bind 0
> > > ..
> > > ...
> > > ....
> > > index 95 ref 1 bind 0
> > > index 96 ref 1 bind 0
> > > index 97 ref 1 bind 0
> > > index 98 ref 1 bind 0
> > > index 99 ref 1 bind 0
> > > index 100 ref 1 bind 0
> > > $
> > >
> > > > look at af_netlink.c
> > > > /* NLMSG_GOODSIZE is small to avoid high order allocations being
> > > > * required, but it makes sense to attempt a 32KiB allocation
> > > > * to reduce number of system calls on dump operations, if user
> > > > * ever provided a big enough buffer.
> > > > /
> > > > ...
> > > > / Trim skb to allocated size. User is expected to provide buffer as
> > > > * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
> > > > * netlink_recvmsg())). dump will pack as many smaller messages as
> > > > * could fit within the allocated skb. skb is typically allocated
> > > > * with larger space than required (could be as much as near 2x the
> > > > * requested size with align to next power of 2 approach). Allowing
> > > > * dump to use the excess space makes it difficult for a user to hav=
e a
> > > > * reasonable static buffer based on the expected largest dump of a
> > > > * single netdev. The outcome is MSG_TRUNC error.
> > > > */
> > > >
> > > > This is where I am currently but I have seen these bugs appear thro=
ughout all my iterations including what's in the tree currently, if you sho=
w me better alternatives that solve my problems, I'll gladly accept.
> > > > https://github.com/torvalds/linux/compare/master...jopamo:linux:net=
-stable-upstream-v4
> > >
> > > I dont see a problem with "dump" as you seem to be suggesting. I aske=
d
> > > earlier if it is possible that you can create some single entry - not
> > > 100 as shown above that will consume more than NLMSG_GOODSIZE? My
> > > limited knowledge is not helping me see such a scenario.
> >
> >
> > Aha. I think there is a terminology mixup ;->
> >
> > "dump" (a very unfortunate use of that word in the netlink world ;->)
> >
> > is a very special word. So when you take a dump in this world you are
> > GETing a whole table. In this case all the gate actions.
> >
> > If i am not mistaken in your case this is not a dump - rather, you are
> > CREATing a single entry which is bigger than NLMSG_GOODSIZE as i
> > suspected. I dont believe iproute2 will allow you to do that.
> > What's happening then is that the generated netlink event notification
> > for that single entry is too big to fit in NLMSG_GOODSIZE.
> > Let me try to craft something for that...
> >
> > cheers,
> > jamal

