Return-Path: <netdev+bounces-254914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKzBC8XPe2m4IgIAu9opvQ
	(envelope-from <netdev+bounces-254914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:23:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE160B494F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 986AE300276B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190ED35B14C;
	Thu, 29 Jan 2026 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="T5koWdN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379A2E6CC0
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721792; cv=pass; b=M57B/P/IEP/BAp4DFhYKoIl171YzQ78YCo0VbISsDvvLIEZ+2lMJWPoBgPYQKN6MUB4AOUPajCQew0BQXZELYX71OXfzw2mVECp65i23sGqgIb0yJujnRLxkKkVZ7WWOvKj8YUqrMwWmk+Vfst6A/R/va3PmZ4A+RPeCgvoL6e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721792; c=relaxed/simple;
	bh=GDj4/r3SS3s+s2QiusxwvkNIs82bmNooEMM3IRav3dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9rM/qlZBemNlWhuX5bZqTO/FaUz7/JZFaoYV/JAVoWohCZYMkDJ9fGcp/mdU4q9DAJqLHR3p3UOSXtRqj8/X/GwvoabfMZcLQv4bZUXqTP+VeBtYA7egS4RaVDP4rJ6bf8qKpPtVU+WwEZ/RBZlALw46Gayd7iG4gXbBZmnF+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=T5koWdN7; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c868b197eso1016098a91.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:23:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769721788; cv=none;
        d=google.com; s=arc-20240605;
        b=k7g4juUql2uSyo/ki0PZF3n4J11lroSysjOOec2tLFW6v1YQb57XgZQeUbApHdtrA2
         KoRdVrHg2C9ff4bTxc7YrZLdeWA6huBuUd7LcaGEJ1IJVbVduquXe0vCxj2/G/P2TJov
         FIObx/Fzb2gBQgUvJPO70HARAR4I0AoMDFMsga5VvO02APC94RcYy/rr9V3vukpfZaPb
         4Zs8Rl60HzvySebR/2TqyjYlixsAXKzjLz6Pp/UE241/ajTvpKKzOhltHz0lLLD4IzgN
         7kfs5zDgGlsYnmEzsFRE5h+stAImEvlZv8B6KCQbd3HbOPNQgyOJsb7ad6DTYXmS8TzS
         kZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GDj4/r3SS3s+s2QiusxwvkNIs82bmNooEMM3IRav3dA=;
        fh=tB4m1fnRHvZHDjqcTr7Zd3wsVuyWrDNunuA0CLATzKE=;
        b=kfHkIRJevw6W1sy7OpFzCM69wAs84biGf7BHen8loaVN+KqiqkDODv5v3YFKFUVUsB
         g+FAv80nMM7Ywx1cIa8JKDRz3ySSWJT3wzBvrx2PwXI8TtvO7KZdgjqNoZ0MZamF4VWp
         LlP4uEZNtryBDGOfai1vGu3SOjod/g8Ns/RasxRuU6UoKRu3Yx1dzfn2rEDdH/rCx57e
         cuB1jlH/caLIG1xYJK60/oPbIAMGgnLGDWgD/iIhHamKxHwxf92VKHgvgL1UrRUMEOXI
         9/DBx1VD6sygmRCAxrqxPxsCgu3gLcvyEon8GqWTzQ10R6gqHMgIR4EsBW3HA6bLaEVc
         vf0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769721788; x=1770326588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDj4/r3SS3s+s2QiusxwvkNIs82bmNooEMM3IRav3dA=;
        b=T5koWdN7PKdWeXKEkuejN3z0jj83Kft2aG+XhAvpgq3H9igYLT0QUl/729jUiBxMS6
         wQh5Rz8aoNS9KvhB2XMglZ413iCiFa8rI9yshESi+qtXmCjakkhLrx2kGq/r3naBTdP5
         vysAhWTca6nutjrCFApKivF4l7LmzgV3iPLWH5G0LPqGpJka37vawaAqioGTJ8oydRNG
         ZkL02KvHYon1/Vl8kz5CgOLIoZVO8I2koIQPVGVNYe5xeJjXSY980TRMphApaHEYtrCq
         ePdhlt5+Te7Y9UhMQR6edOyxXL8WQq66ZuOUqENzfdOlz8AyWaWg9Jm5mHk2ilxB7qwV
         X4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721788; x=1770326588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GDj4/r3SS3s+s2QiusxwvkNIs82bmNooEMM3IRav3dA=;
        b=O9/A3CMG/HG80iaBfEnfhfFMMaJCCvBqq5tVMt5yWVNrkxBw8Mv0iOMB8QREDGdnYo
         VvrRFxGd9n1IxGVpOUU+gG3D3m0c+jF+TeLveEISbrzTHiPQKkcV3r28bXacEUb/63O/
         Jy6mz3mY3rbOTOuHiwIwPhuJIPRqV2vtyLH3zyOcQUge70Rgf9eciOevP1lIdACc1NSp
         m7JpTBarf9MKu7d8wJyPmWbdbBqBvYGbyyQ//zJ880HrrGr1Ug7soTUKYNm/PTMzCqjI
         FCtJqBmti78ivs8NIDCll6NaprRdb9MYrKP1Mvlt72W8cVmJnMcs1RUSNFlh2LXNBbzv
         pSZg==
X-Forwarded-Encrypted: i=1; AJvYcCVyh10vk1op8lRNjGytpmc3Lc7HSnrXyVsyIE9TCQL45W6kavsLC1cpa+E/d6eQFKsJMGZjL5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1E9C63hTIobb23Rg3IaxQNFwB8DLrMnDGcl+nTDMZapKk5rKN
	jkQIQVK80Cil/4SHtOZbalPwA+OduaosyH3pLEDUrU7aCMvfW3EeqpVNrsU0PNUCiwjSLQsSdhA
	Xjw5KQnNaCGGK8RwDI3ha7tsO9mugUmAft2SMD2nmbmtCTXATb0+g3Q==
X-Gm-Gg: AZuq6aLRKY8XApv2o8G55y3U1UoM3cz3b6QCjXptwpvHNM1+BJT91uHnt3J2zVX7JLu
	RplKNg7iC360MVyMGBT0eDAqjz5OtsrKKdSPoBWvkDJ1n5ifuET6Il1efYDshkO9GzYStbm2ta1
	wF2LVXZo0HSQqcAp/8GUc94/nx5SjN3U7vTN1x+pH9jD12uxb44vVNjO+VH+1cPL+cJSCpRepI7
	euutdo1MuTdw2RXmRgeRz/Tw/bnVDeesNh8Uce8UYMoT72GKAMnZBn5h63euBryjvIYHL+MC3ny
	GCVV1I4yCH+rtg==
X-Received: by 2002:a17:90b:4c48:b0:343:7714:4c9e with SMTP id
 98e67ed59e1d1-3543b2dbfcbmr682737a91.2.1769721788038; Thu, 29 Jan 2026
 13:23:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163947.811248-1-jhs@mojatatu.com> <d42f0c80-e289-4e0f-8608-10580d315fd9@redhat.com>
 <CAM0EoMkFMURPj3+gNOaqO60D4deeht2F3EZWZbmShjO+B4wJBA@mail.gmail.com> <CAF=yD-Jah3+1Sj3-Us72fKNu-__sg7pNb+-kC_knAV=iTHAitQ@mail.gmail.com>
In-Reply-To: <CAF=yD-Jah3+1Sj3-Us72fKNu-__sg7pNb+-kC_knAV=iTHAitQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Jan 2026 16:22:56 -0500
X-Gm-Features: AZwV_QjrwlV7YwIyQ6tLXbQsHZYNkOUfNXVYF9EnMlUAAM-S-VR9gIDPkbF9bi8
Message-ID: <CAM0EoMmAQ8RvHRmyEeMwehhNe0yXzn8NU5UvwitzAoL3cwVPqg@mail.gmail.com>
Subject: Re: [PATCH net 0/6] net/sched: Fix packet loops in mirred and netem
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	victor@mojatatu.com, dcaratti@redhat.com, lariel@nvidia.com, 
	daniel@iogearbox.net, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, 
	phil@nwl.cc, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	zyc199902@zohomail.cn, lrGerlinde@mailfence.com, jschung2@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254914-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,lunn.ch,vger.kernel.org,gmail.com,resnulli.us,mojatatu.com,nvidia.com,iogearbox.net,netfilter.org,strlen.de,nwl.cc,zohomail.cn,mailfence.com,proton.me];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20230601.gappssmtp.com:dkim,openwall.net:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE160B494F
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 12:06=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Jan 15, 2026 at 6:33=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Thu, Jan 15, 2026 at 5:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On 1/11/26 5:39 PM, Jamal Hadi Salim wrote:
> > > > We introduce a 2-bit global skb->ttl counter.Patch #1 describes how=
 we puti
> > > > together those bits. Patches #2 and patch #5 use these bits.
> > > > I added Fixes tags to patch #1 in case it is useful for backporting=
.
> > > > Patch #3 and #4 revert William's earlier netem commits. Patch #6 in=
troduces
> > > > tdc test cases.
> > >
> > > Generally speaking I think that a more self-encapsulated solution sho=
uld
> > > be preferable.
> > >
> >
> > I dont see a way to do that with mirred. I am more than happy if
> > someone else solves that issue or gives me an idea how to.
>
> It might be informative that there used to be a redirect ttl field. I
> removed it as part of tc_verd in commit aec745e2c520 ("net-tc: remove
> unused tc_verd fields"). It was already unused by that time. The
> mechanism was removed earlier in commit c19ae86a510c ("tc: remove
> unused redirect ttl").

True - we used to have 3 bits, but we can leave with two;
Unfortunately, a single bit won't work - otherwise we could have just
used the one available.
Only one bit was available, so we recouped another (skb->from_ingress)
and adapted it to use the tc cb struct.
There is still a chance that could cause issues - all the users of
this field were CC'ed and i was hoping they would respond.

> The IFB specific redirect logic remains (tc_at_ingress,
> tc_skip_classify, from_ingress, redirected). Maybe some of those bits
> can be used more efficiently. The cover letter for commit aec745e2c520
> had a few suggestions [1].
>

Using the iif check against netdev feels a bit "dirty," but if there's
a strong view that it's okay, we could liberate that bit (some testing
needed) and in that case i would leave skb->from_ingress alone.

> Another redirect limit we have is XMIT_RECURSION_LIMIT. Though this
> assumes running in a single call stack. BPF redirect uses it as of
> commit a70b506efe89 ("bpf: enforce recursion limit on redirects"). For
> tx. Rx takes netif_rx, so enqueue_to_backlog. So it does not seem that
> this can address the entire request.

True.

cheers,
jamal
> [1] https://lists.openwall.net/netdev/2017/01/07/92

