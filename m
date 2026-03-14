Return-Path: <netdev+bounces-267654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAwmGaWstGllrwAAu9opvQ
	(envelope-from <netdev+bounces-267654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:32:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1010128AF62
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92774306220F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7167F23BD17;
	Sat, 14 Mar 2026 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hp184NcG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D41A9F9F
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773448349; cv=pass; b=czkXrgSadTYQ7FBT9DMIiRV5WDAFFusXz7uX498QFGxG+Q04/CtnHJcLaE0kUyusbQSg2edos+3k2sGnm5R8v8ReGAPRlFbjgVxWQZTLN+HK2EzBREGwYSM3PhmUCEx6uaOnmPo35VVaXiIaCl8AYNs8/mVX7tseOBuKijX8qEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773448349; c=relaxed/simple;
	bh=zcn3t1p8ZHRfGiAa8SDTvYSe5yh6XutktfgK+z6O+Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EK5jxsVGj/GTiAvqQU1iYh8HHzlN+CcMDs4C7TiLYzK2VxBOYkRzSkIJxWvHygwSCkRk/R5QpdU1ITdL1gYilo1FVHN2tmMgrQ8RR90r5qcel4N4Q0/Kp4BHmTB2Nhab6nf37pkpQ3/mlLLqaUlq9TpXDAED2d94deMbRmVRfFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hp184NcG; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50906a98ffeso192741cf.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773448347; cv=none;
        d=google.com; s=arc-20240605;
        b=AJoyTrzdL4FHMk++KLLo17g5TKEsGu8i5/srpJS4AGDoSQoDFZV0h1xiGDbnIVqccM
         ZxTgNXBoyEMkU+fe0KiXDcWVNovmMFphbUeAyeIPo0g9Nrwqt6UoBiOGaf03rIP8+/TN
         S/q75DIMYQxGCxDblOLulbK7a9QcgFOXiid+GdAARn9MNBoxSmBn1CHstGo9Fd4IdrQL
         MVkGZhWRHIRq7fOH0Qj76UrtlA1Dp7UA2+H6BPR3kzoeJEQhHBZrV3xehpsCHzNNqVpn
         VcsjNqptQt65E6YZyeSriw7wL61TY8CakKaiO+QmhaViP+XCwrBdkA1ClPsPhb2DPN7j
         bG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sYCGIqvY6vekWSKy5ADGGJi5rbPI4DHrBF2LacPT2HQ=;
        fh=2GMmeSCTR/XHbQWfE/3dCoKiac5J7NONaY4Cx7HU6oQ=;
        b=VvGps6xxV85QXxqrnGvaZ2CDrgzP3ra4Kn1E7VW3B3GpvdaruhdHh3VPgB8DvSIh3e
         6OTXXcFhBN6tTD6Y7X/6imD+DH0g/PgnMnSAgw6Yu1PJJ+wdN9zUzSNd4ia3rXYtHN9e
         AormljHsPL5/NmvEQxpDDvPu4wGFJN6FagIWxcp3feDfaw/PYRxf4U4lfoBBSumYrOJv
         BmWSXtl7690N0gh5wLgzlf8EuAqFwB93KtVpeEI/O2jEIuG97gXFHOFrKWALE6cbPiAb
         ZLpAClX9YGCh2HQUjgST2Nn3/hz+MkRjhkHgkL4URL3KSTRMnPcFPXLd5utsU3Xw0Ha7
         klFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773448347; x=1774053147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sYCGIqvY6vekWSKy5ADGGJi5rbPI4DHrBF2LacPT2HQ=;
        b=Hp184NcGLx0UxHjjI0BYZpi/G31UWsaLLFjB7WikfzxL9UAgRQPhEIulDqU88cyMgP
         ytJZwMj5Q49sDIWgCbR45VCEix8hlgC/Znfvd0AE7969hCka3cLfWqPyg5h2eLXKQVvw
         5Mdxj5l8IA/4Whq2CqOaqTGSS+bjrMcWhtLQrUTVeS/iiOufTI/6sK120HvqggvmOphj
         IGIinOGV7GP3URvVKSBcwb8bTGGUMH4TOfc5gtBSgbP7f7Gnl+vmtroaahbe8ZS+kEMb
         o2fU80qC4I1B6BlEbWste1avoFOjnDq4dpcvxdmsPYcXqujdIbP5vGasGTLyzeqNt5DT
         UOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773448347; x=1774053147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYCGIqvY6vekWSKy5ADGGJi5rbPI4DHrBF2LacPT2HQ=;
        b=PqbeV4liXVzlPCyVygc5oyU97VU142EosAkwdqLqtHTcnxKoMgV7zsncIdV12qLLbf
         bxS7+LtCsj0+4gHAiTT+YP3cDell5wwNolkeItHtclEFrKkchv/cymOVpiqNNGzd1G12
         OIanyUDd9RectYEfmgcB+R84S08R9oXUl52bOaU7m5APFbPxGJZfZPaz58ksf7FsZ6ls
         Qlr2rLBqOtPLbx4Z6GphPORQeGWclLY3t9Kk6q3j78CciYTI+53j55KMNWzcxShqjRZS
         xjv5AXfWVcwFzsJUCSFsJlWpc3BRmCQspnqmP+LXS7bhJTI94OGdGNukngsKEwQnF7zE
         wAVA==
X-Forwarded-Encrypted: i=1; AJvYcCVWQqFjSb2peQf6bvi7YuVkLvs/WWXAYd1dl4XM5DRyPQqk7odCg/sHL+mAGP3Ai9Bi9LWOTWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTKX4Ec9sD6mGouINVf5U+KmtZOm0bnl3i9Y+b5xYy/zJKpS8
	IIYhE0QJwMvgRzcqgrv5+gQT9QUULNnEZl9xOBSJExuuJt5SowD9kNH9Lplo5AFvJczGnhP5SNE
	UtEVaYxv5GWKbAlgcPFPMoksDmqfPP/fQ6zaTJFQu
X-Gm-Gg: ATEYQzwa+V8DdZ6R3ABXjcUQym2wRLInGSpuB8DWV5o7srMfaco0BaPb2aZC/+pGHiG
	2Rr7Q3Df+auRiQ0+12UX9TX68bX6ZT59jTHdJ1sla3lJU7HZepiyYjx7MNfAELKKI7TgEWw8MbF
	FkumH+Cba1Bp8wAdY74cDTmFHbFecUJS4WhoKuxixjTbzaM67FSgyRf2Rj356du4k1r0xrCa6pQ
	a3QiwP0lUoduWpfnTI7kZlDbruWm+bnf7Mj9D6c9gcmnvKHn0Soc9fmcY4xKKFV5rRE74HiDhpi
	kbmaKaXeJXtbgcv4h9cnm2Ny6xwH0zfKePONTg==
X-Received: by 2002:ac8:7d05:0:b0:509:371:f2ab with SMTP id
 d75a77b69052e-50969504334mr6040711cf.16.1773448346543; Fri, 13 Mar 2026
 17:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com>
 <aaF_SAQj4WT8jRaO@krikkit> <CADHa2dCF=Cq2SMYgjHcs71VedwYaDmUXPWnNbv=46+11Mz0otA@mail.gmail.com>
 <aa2K8pXXipCH8cke@Antony2201.local> <aa_750R5Jm5qPbNs@krikkit> <abBMMZWNp_zN23xL@Antony2201.local>
In-Reply-To: <abBMMZWNp_zN23xL@Antony2201.local>
From: Yan Yan <evitayan@google.com>
Date: Fri, 13 Mar 2026 17:32:15 -0700
X-Gm-Features: AaiRm52S6PUaJxrK8Lt6NKYUuHQdExbomiEXV3nbZSeh5kp55Rm_5BrVQohqTNA
Message-ID: <CADHa2dCdFKE4Wg-uSmYLmh1-JEf=rZOA2WUmRbTy0S0rp+rz+A@mail.gmail.com>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 8/8] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
To: Antony Antony <antony@phenome.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Antony Antony <antony.antony@secunet.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chiachang Wang <chiachangwang@google.com>, devel@linux-ipsec.org, 
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	Nathan Harold <nharold@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267654-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[queasysnail.net,secunet.com,gondor.apana.org.au,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,linux-ipsec.org,paul-moore.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evitayan@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1010128AF62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> yes I can add that. I would add XFRMA_SET_MARK/XFRMA_SET_MARK_MASK together.
> If you set only the SET_MARK mask will be 0xffffffff.

> I am actually using xfrm_smark_init() which will accept both.

Great! Thanks for supporting that.

> Option 1: add XFRM_OFFLOAD_CLEAR to xfrm_user_offload flags in uapi xfrm.h:
>
> #define XFRM_OFFLOAD_CLEAR  (1 << 7)
> When set in XFRMA_OFFLOAD_DEV, it means remove offload rather than configure it.
>
> Option 2: add a __u32 flags field to xfrm_user_migrate_state in uapi xfrm.h.
> There is a __u16 reserved currently used for alignment, but 16 bits feels
> too small if we want to cover clearing other attributes in the future.
> A __u32 at the end of the struct avoids that constraint.
>
> I am leaning toward option 2. Any preference?

I'm also in favor of option 2 for better extensibility.

>     - XFRMA_REPLAY_ESN_VAL / XFRMA_REPLAY_VAL : may be later replay type
>       should not change.

I agree we should keep the replay type immutable. Changing ESN flag on
the fly would make it hard to keep both sides synced, and I'm not
aware of any use case for this.

-- 
--
Best,
Yan

