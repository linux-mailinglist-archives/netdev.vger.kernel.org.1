Return-Path: <netdev+bounces-294316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 34u4L+QSH2pYfAAAu9opvQ
	(envelope-from <netdev+bounces-294316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:29:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC009630B7C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:29:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=CauyokWe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294316-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294316-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C590330611AD
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9682F383986;
	Tue,  2 Jun 2026 17:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADA3F99FB
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:26:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421190; cv=pass; b=tjH6ZcuKO/Bz4JYHm/R6uvhrXEYTDw3gdl+L+c51OTxKk9tNV4/A6YDL8SvdDG/4EGP77ACSObkgp4QuDtS8N40Ny3Jq7zTIm30MQEIHMtclerx4rXIu/JV3AEn+IF25vo1w+s5AFCZ2kIJRh5bJa2bO34UzCLn1Wf2/lsqBLm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421190; c=relaxed/simple;
	bh=N2zSfTpJNCY4t5qOyP0bEyizCSmSRAoY7KosRj4sPVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSAgz/WhFnfTGBwSb9j5OxCg/bRVmzCpx/0aci+fSqxTudJnFEVQwm75DQ4rX4VIkfuNserWp3f2gcxmlHbhHMnLy039wXmoZPR98pv3BhoBhX7jG2m5Y6JiqnnfUH/PpZdFjalt47o7Fbr5cDoJH4S0p1z7k00JRxN7tXWNf08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CauyokWe; arc=pass smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68ad1e513d3so9029419a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 10:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780421187; cv=none;
        d=google.com; s=arc-20240605;
        b=BHVSufSZeLEiu5lm9P4uCrsn/fuCvgEmE1hV/aP1q1JtTTd6Q7yXC4he4Pe+69LhFz
         A26vCMgc13HmaIQJySiCA6pgtCSF+eyDwOHAOiiHk/bsEiDaeeTvyxpnB/FZSTD47xzU
         8B8k8kF34GwlLrPAc63yYL1K91RZewK2YL7TjbcW+0o832RtOD6Y9tM/DubAbRpDUTHN
         wQQlG9+gfztxnO3rlRs05UwjYOTgJG2w7HoMa5T/villfTanKK089uCQ2WcJw7E3QXFw
         g2D9GVyk9lIAoJctUx8j6ovu/fsW74OQufs41M5jMILX3WuzlXWF7zuh1VvlrTSWXOhF
         bEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ho8QkYK+Vpwcxs/VwgFPXZbnPKw5fMjoiOMIsH7CC04=;
        fh=o2ryVPboAM8e6zE+B6mlmzvf43n8L7ZMHrH5wMUJq0I=;
        b=XJruesHDoXQ+rPaF96rSL0rHQM8Bkyi3LdyNtxgebDdEDYGjlgPfcY67ZSp0G7PZx2
         jv0ucg0dTcgkWgf5UFv9qQ41eRBqL5Pgpm33rnbN0g2PZ4IBlxZ3Gaui3S/6p8BRthzf
         FmlkYQHe01S/5ilnqzQsxgExEqdRYSn2txtuiqI6vy4a5LG2X36W89FcpxvqmfV6Yrxx
         XRlKl1eOQ2o7PzZKPbCJ6vzX1CaizSr8a5dwT+U7cjTeHl8kfZFRahkJv/8f05hJv6aK
         lD2fdO+rh9QBYnF3B1Pw5T9OVWogwwOFkNOv3Yr4qAqT7UPW10J4HrC3GJN3nfA9sDgg
         gE6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780421187; x=1781025987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho8QkYK+Vpwcxs/VwgFPXZbnPKw5fMjoiOMIsH7CC04=;
        b=CauyokWezlvbzCwO9w7wAu7iXK2YIYUTDAr2NF0lnPw/x6nU4UCptjnj9xKMdyy4T+
         n31Kl3rkOfRXAxSVe31eq48vHI08eiwVEfE7eS7Z2sn35xBxdzsFdz2xoRFS5ceaMcW5
         A/TGb1Wu2thAugJ4HkXP2DEZ5NQgjreeyOu68HKWwWxqA8Ow4VAISobHmhY3h3Wv/QjZ
         ggzf1v7iMicpV+OaSNnjW1B3ZcnB+uzDEDWkCQqNBCzCpJB9Q6d/T/D853mMsaVVtQgl
         Bpos4l5cQDZ5NkPS/rKgFsTn6MXjhnd9nHU7cPk5/8tbmlvd0Hio1w5biVKDDr5RK974
         LIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780421187; x=1781025987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ho8QkYK+Vpwcxs/VwgFPXZbnPKw5fMjoiOMIsH7CC04=;
        b=OQrQeNRVib05M58SfSJAkrbxZTjo4m7U1ZPnVBtRbtNJoLLTXgdOZLU5czV+hpTxvZ
         J5fU3HL7xkuS6fBR8x0+yRHMFwn5/7AM5+AtxSZAb4gmcMaZVCPjSkFd0ubuIEZD3NNh
         BOONSvplLuZZtrxsT4m/Cqb14XCvG3/aP6TjBo6RbMxKWWp+RIvDzdxDPgwLoPP8koLy
         GcNX6gbplHQEHh666dPSzGVFGB1+YZcfrCrrDye1ZLgc8e7hJ3MbIy3+vXK+Kje6d88q
         mTjpQS0J4KMzmharLWQxIJzLEozMc0W0p6N/ILcruOK7PvWY1BaQVTKYT77/cFtjT2VT
         9H8A==
X-Forwarded-Encrypted: i=1; AFNElJ8eNCelXpFokg6oP6c6T2d+aGvJVCYhSS0d2eInuCfMjWyJKpXU99yCs+PeBoeO3SfY9Q0K4b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8sCGairJDwT1n+vX/GlVXvdyr7TR75JwZhFG6d4J2gtj6T16u
	TCOUtjeCVjCUHISTaDlGYXojAZRCDojxPFwX0VzAxezlnR8KXj93wJVaOdk2YQ94olv4JMbJsuQ
	cHghoL25eEiNXBDLlUhDEvxwZa5XDGX3VxCl/BEpw
X-Gm-Gg: Acq92OEyHZZGUY0njrLXNIQ/ybMShOen/RIW4ZmVicJ2hSU/DOnXNAuA43i0q/HooXj
	Rj94HbmYTYtkiceNs5ogm7AG35P7uQZWqUl+q7x2mlhVS6yR9dMjdJ4NSaJS97mYpCNpirB0ffZ
	tVXx/6NgfeCxpGtXPeTMW4gZJ4QqzQtqQF9ApcX0feaQv6fKFxdtAhtA32Rj6Njt3ZMuv9WD6qh
	PtxeE57Y9+CUB508x8u/T+AKWIsfhUzxd4NGCRUytCtwFSF7KB80KLOUrHdt+DZR5yOx5YzPzIj
	G5OZXt2Y43nMqvTFpw==
X-Received: by 2002:a05:6402:5417:b0:67f:99d8:868 with SMTP id
 4fb4d7f45d1cf-68e5d94b50amr370315a12.16.1780421187178; Tue, 02 Jun 2026
 10:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah8BzqSmZO40xYhS@sirena.org.uk> <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
 <f7892d83-64cb-460f-87c8-ebc7fb4476f4@iogearbox.net>
In-Reply-To: <f7892d83-64cb-460f-87c8-ebc7fb4476f4@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Jun 2026 13:26:12 -0400
X-Gm-Features: AVHnY4KXJdTKb86IwXDncHxbtqVCvwUqkbs2YhZ2hnshZqTYs_erOE_rsX9CAPE
Message-ID: <CAHC9VhQPc52RQpTN41NpipM6U+DBB2CWRjdwh-ykhDkfZACrLw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the security tree
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mark Brown <broonie@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294316-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:broonie@kernel.org,m:bboscaccy@linux.microsoft.com,m:ast@kernel.org,m:andrii@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC009630B7C

On Tue, Jun 2, 2026 at 12:52=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
> On 6/2/26 6:31 PM, Paul Moore wrote:
> > On Tue, Jun 2, 2026 at 12:16=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> >>
> >>
> >> After merging the security tree, today's linux-next build (x86_64
> >> allmodconfig) failed like this:
> >>
> >> /tmp/next/build/security/hornet/hornet_lsm.c:212:36: error: too many a=
rguments to function call, expected 1, have 3
> >>    212 |                         if (map->ops->map_get_hash(map, SHA25=
6_DIGEST_SIZE, hash))
> >>        |                             ~~~~~~~~~~~~~~~~~~~~~~      ^~~~~=
~~~~~~~~~~~~~~~~~~~
> >> /tmp/next/build/include/crypto/sha2.h:14:33: note: expanded from macro=
 'SHA256_DIGEST_SIZE'
> >>     14 | #define SHA256_DIGEST_SIZE      32
> >>        |                                 ^
> >>
> >>
> >> Caused by commit
> >>
> >>    c62310df81899 (lsm: introduce the Hornet LSM)
> >>
> >> interacting with
> >>
> >>    c48c3a7e7d5be (bpf: Drop redundant hash_buf from map_get_hash opera=
tion)
> >>
> >> from the bpf-next tree.  I have reverted the latter commit, the new LS=
M
> >> means that the assumption in the changelog that there is only one call=
er
> >> isn't true and it seems like the most straightforward approach.
> >
> > Thanks Mark, we're taking a look at it now and should have a
> > fix/answer later today.
>
> Sigh, hornet should _not_ be merged to begin with for the many reasons st=
ated.
> Messing around with BPF internals is yet another one aside from a really =
bad
> user experience of having multiple approaches to BPF signing !

Sigh, if the BPF devs had shown any interest in working with Blaise to
arrive at a solution that met the security goals we described (and not
necessarily what the BPF devs continue to mischaracterize) there would
be no need for Hornet.  You are free to be upset about Hornet's
existence, but you need to be realistic about the role the BPF dev
community played in creating Hornet.

--=20
paul-moore.com

