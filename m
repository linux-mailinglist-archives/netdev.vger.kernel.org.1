Return-Path: <netdev+bounces-280188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJn6Gz+j52nw+QEAu9opvQ
	(envelope-from <netdev+bounces-280188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:18:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8343D3CC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 373FA300E4BF
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD792571D7;
	Tue, 21 Apr 2026 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhtOqGe7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0E434E746
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788282; cv=pass; b=Tb7ci7PS6J9r42xTMMERFSYmitxCZio+tT7zoAW1uxM1cnsw7vx29nskYgz2QPZV3zGViTOyNQZUaEJQIkatcr6dHsq6vHEtnahUe24+Lyvoxe0Lu/o1cFzV7cWBJd0fZ64YRDmxoZRce92l3y22dYTb3BCWatUx6g4e9caHpFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788282; c=relaxed/simple;
	bh=bpNWPmQUmtbAf0gai0ctu6DBVgpxv6rlo0i3uJ04sWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiqZq7WgTLSnOINStTsyFSmR2IXQWcMUb5nvxL2ZUjODcWmz1FajqRt8a9taJe3Me/DxwtYu2Tlz04MmujLw2Z0pBhw/SxC05pJZJETKDFY9MvfBriGNykaAgB+F4SfkIia+YA24/LKHQMIlNcevM7hZK8uffL9D7Re/Rtz6WtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhtOqGe7; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fc4425b6bso36461507b3.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 09:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776788279; cv=none;
        d=google.com; s=arc-20240605;
        b=atcR3jXQtcZznKUFhazct3C46REbOQ6l4P/rAfMw6QOVFAdX1U+s3ZUlcAAWulAiob
         f8SMEgI2ORl99dZuu6nFJWiAPgH7XAIcbVWfMvFhYbsB4nCCXyazqfVcNhcjUeGDS1+6
         OkwyKjkFUm1Cfy/0tcSq6ZNTOCAjrmN/PHSELJc21GNipBjapZNj4AoQq1pFJj4y/KJU
         amZDj5LF7Rb+81jfYcuYl1pmHhBu4iG81jo+AxEcpx/e4+fbWQrUlfKWzk1N0N6wnOcw
         AS9w2KyZcnboheaEM5Fa+B3nWEmgBcR1/3NbhfoP7hLqSGhUfThlo5Rd8bmx4sa7xupA
         G9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WlejQ2Tpf6EuBEgAofXCiHYBLX5AECYqklHU2vA9qDI=;
        fh=Vuo06zfxkg04d0lBb0W1ZWwaUUtDd4aFeeG6KpfTUi4=;
        b=TZpVRzWjpk54uiP2oJQKK1oo740JUBycv3wzL6FEozAG6z/2dcIKcoI3GOHyKmp+1M
         QuPvA3IX4j8Vaa39AnrMogidA/aBPB09HA/IKsukm//DdLLcF69gD7gSuBKo1hurQnU2
         oHWuI4PTdVds01I40axrd8pPKOYqUHOztJ7TJR56yVay8r9HRwGRXSfX0NAGOaCtyZK3
         3aWDu1DTUdcP4YsVNInLSTQlvcUCOTEjer4BJ8kMtdnA4TRcnIA0NPT8pm+3qWJMBZRI
         Lde5g2yv9Bi6Wc/4eCZpGM+lAPlSAMIRFLT706pFlJT2XmpEMkI2Zg9o8P5o46f2thCK
         lAXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776788279; x=1777393079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlejQ2Tpf6EuBEgAofXCiHYBLX5AECYqklHU2vA9qDI=;
        b=BhtOqGe7RRiIumgDU5cmNdklvcPueg50lKI4WWG2/cDxTXZQlGpSViHfQ9efN+5Z8m
         EAyLwYe5saHRlKuBwhm/6CyS7NTsTr5fsc4wzlS8p26QcC7X+PGNgtHaCIqEkW6WItdK
         170UggOhkbPuef5armjmTEHwX6L76lT4T7pcbdJOGn5I3CEuKP0PlXUWEVGSRKUp27Bt
         NSKsBfmVSz7FIV4650sZtzBIWN67QdJ4yaUNTx+g2itL5c3EXIukyEO5O0rXDNO9+gT4
         CUHca599zSnFtZDldiQdna7j4annw/YRubSH4Ij4/3ppVf92s7h0rM5Cz5GKlBbBisva
         nZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776788279; x=1777393079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WlejQ2Tpf6EuBEgAofXCiHYBLX5AECYqklHU2vA9qDI=;
        b=aw2wmZkqZtBp1pxgEH+m6U9GzqJtekO9gWNsurrcKynax5CmInsDflwwCouKxxwGmZ
         CXwit12X/zAbj7uI4NK5I8noF/QMRtW+hnUpOgp2Gf0OK/Z4Kt7lX2VV9KJG5cq/AsmY
         WEAEf/BXkwV2uaCaSMpkg+DAax6Lqc4src6Rc1J9XC/SOKLwnKfkOHrKzyZpvGq45rBn
         RywPdFoSuEIjpePA5pDnEVPhakmIpkZylE5EWkCaQhSKc297+uPMsdPWTelFZ5EorpOT
         b9YRJLN9HUPgAXpbU33ERV4go8FP8xaG/lLLyo90MyOD3gjqc2Dv451ScIVzYjxQcNu+
         Qd/A==
X-Forwarded-Encrypted: i=1; AFNElJ87sZHUX0dMgg2SxH/U4RjVARUOH5w4vwz/NCB4FEGmgh5Pd+bDitZqg7oSoahn0t7eXcNi+Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8o7XO2YPlQsXDFZwS781PkvHQ7oe+HSW8rJzhp/+EHvMH7YFF
	Ocq1flHzEdlAmc+ACLuQgk+E38popw804u/+15LsCch66L7rmNyIeFpvtm4yhz5YPEosGPx2bkR
	Je30gF8vp3GpkUXhOpBAfznHwfJyET3Q=
X-Gm-Gg: AeBDietQCju4+o6NiyWh0UL99LneLZgSq/A/4uMoKPUaDr1SO28XcuEg+OgG3ozScx7
	NBUiEFF0O17SuWiQ1bgCZMqRz71cETQN49We1UVi2uILFielxByHw9vygywJRE/ZcmjquW+zgsg
	8VkM5tyMau/ME9JMZRclR+KW4+U4lUozQam0KTkqwAiqZ1pnh0659+Tj3X6CIn0doylAMSjlbr7
	5rzYDO07ZhwAmQLW8LebOLfhNYQvKMazW6U8KIJ3z12LkaMZW98bhJJoS6+SOhAbayoEquETu0u
	drzaGtbflFbRyhl/iM+0ECe1TEl24ao/KdVs0VVcCXljzNs13y+pozpPV6mbFuHaKziw6taD3n2
	Roj/toVdz3Xt8teGYeuXShvv8lLu+lyRgglC+
X-Received: by 2002:a05:690c:60c1:b0:7ba:f129:3770 with SMTP id
 00721157ae682-7baf129489fmr85282657b3.5.1776788279397; Tue, 21 Apr 2026
 09:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421021824.1293976-1-kuba@kernel.org> <20260421065507.2c5e3ba7@phoenix.local>
In-Reply-To: <20260421065507.2c5e3ba7@phoenix.local>
From: Dan Cross <crossd@gmail.com>
Date: Tue, 21 Apr 2026 12:17:23 -0400
X-Gm-Features: AQROBzBxInpXswvKS4PlaD90HmpltOzEo3_9ivTaP46UHDxuQQ1dPVwgB3AoVnI
Message-ID: <CAEoi9W6ZRw6aEh62Xbgkg-TW8URHbVp6dHTT9krFiTkotjTuTA@mail.gmail.com>
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
To: stephen@networkplumber.org
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	federico.vaga@vaga.pv.it, carlos.bilbao@kernel.org, avadhut.naik@amd.com, 
	alexs@kernel.org, si.yanteng@linux.dev, dzm91@hust.edu.cn, 
	2023002089@link.tyut.edu.cn, tsbogend@alpha.franken.de, dsahern@kernel.org, 
	jani.nikula@intel.com, mchehab+huawei@kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, tytso@mit.edu, herbert@gondor.apana.org.au, 
	ebiggers@kernel.org, johannes.berg@intel.com, geert@linux-m68k.org, 
	pablo@netfilter.org, tglx@kernel.org, mashiro.chen@mailbox.org, 
	mingo@kernel.org, dqfext@gmail.com, jreuter@yaina.de, sdf@fomichev.me, 
	pkshih@realtek.com, enelsonmoore@gmail.com, mkl@pengutronix.de, toke@toke.dk, 
	kees@kernel.org, jlayton@kernel.org, wangliang74@huawei.com, 
	aha310510@gmail.com, takamitz@amazon.co.jp, kuniyu@google.com, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280188-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,lwn.net,linuxfoundation.org,vaga.pv.it,amd.com,linux.dev,hust.edu.cn,link.tyut.edu.cn,alpha.franken.de,intel.com,mit.edu,gondor.apana.org.au,linux-m68k.org,netfilter.org,mailbox.org,gmail.com,yaina.de,fomichev.me,realtek.com,pengutronix.de,toke.dk,huawei.com,amazon.co.jp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[crossd@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Queue-Id: 75F8343D3CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 9:55=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Mon, 20 Apr 2026 19:18:23 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> > Remove the amateur radio (AX.25, NET/ROM, ROSE) protocol implementation
> > and all associated hamradio device drivers from the kernel tree.
> > This set of protocols has long been a huge bug/syzbot magnet,
> > and since nobody stepped up to help us deal with the influx
> > of the AI-generated bug reports we need to move it out of tree
> > to protect our sanity.
> >
> > The code is moved to an out-of-tree repo:
> > https://github.com/linux-netdev/mod-orphan
> > if it's cleaned up and reworked there we can accept it back.
>
> It would be good if these protocols could be done in userspace
> or with BPF?

Consensus for a userspace implementation is what folks on linux-hams
seem to be converging on.

The amateur radio protocols are more or less specific to low-speed
links, they are not particularly coupled to anything else that
requires running in the kernel, and the main coupling point (IP over
AX.25) can be implemented via TAP/TUN.

There are several popular packages that already implement AX.25 and
NET/ROM in user-space (for the interested, LinBPQ seems to be the
canonical example).  The main missing piece is ROSE, but it is likely
easier to add that to an existing package, or potentially something
brand new, than keep it in the kernel.

There's no compelling reason to keep these protocols in the kernel,
whether in-tree or out-of-tree; at least, one has not been
articulated.

        - Dan C.

