Return-Path: <netdev+bounces-260675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGtdFg06nmncUAQAu9opvQ
	(envelope-from <netdev+bounces-260675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:53:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF4F18E32C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 553E2301396D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A61363C5F;
	Tue, 24 Feb 2026 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSQ2Ua+K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD725B1C7
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977226; cv=pass; b=aMOZYZfUOr4/DDru3OQ/7FbsdHK/SlbN7+oWLNaICxEe4dL6DqeMx+NJcsGVHzS+l+XFsNXxB5OPBDEZa8sd6Ssxx+qqNrQgfSHEOmOjnNwbrNQ016HRNxZPEj1FyjmIHMZC42n/zKsaWZoJMRKJnDknnIqvl9QXU/J9G9YwYMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977226; c=relaxed/simple;
	bh=sG4ThKEvv4t+/MpSSNIIvK1c5AivCnTZuA+Fiu58Zno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXXze8uqSRf/MkFEM+A7G/pYN4PUSqHlVkCPP/zA6BI3jghAe4OffLlj8tnivFmtMkXUNyV+TYkQX8ZgsN7J7pv1vSp2xDvEWMP5Zk7AVXB1rHKi87iYo0vKFRKeCVYb1pzXiKxCNgMcoPMdzTzhiqWZilg7krw+XUo/qudp8q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSQ2Ua+K; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5033b64256dso214311cf.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:53:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771977224; cv=none;
        d=google.com; s=arc-20240605;
        b=LWja7QkPRFwWywe+8oruwkp9gdSzk02PnHVWQz+TvksfT4z/KQBhrz99/fbudT4y5s
         G6nLHNrEBL1ZabcTdjW7zyuH4YDlDLdsUfYfVKjrQNxD2i4BrYlaB0thUyQ13rd7dRkG
         I6iGh263DVZljkJYgZKT5OjTOhG1gCLJe4UlP+rzly832+ihl+YcK7fW84BGZP5/vx/c
         3bByqqHIDeaxrsCl3OHnkhEj5z1Od9Dk8jpKJFT4bcZSeRWjGJXJfB9PEl4G35m28YC5
         l3kfHRZ18vCZq6Rqfvf2bO8h3bHxaEmeNzQqCkTAK6SAdw3gr6s8ZilmAcxjuAHphk5t
         nihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ZyeG2Q8XyW2wc8KoZtdZ7lIpqMq6VE1Ib335DSpfY0=;
        fh=+qE9dLq02beV/Hy6gwYd+voYQ7zmFWlUYMhhN/5WDKw=;
        b=cnezVRag7G2i1JLSgtj5410LBBPYrKe7xxfSEBMBVOwBGDHtpDGEI/zMP+MnGDiKLd
         /Iy31vmnoVHxoJXW7pH1Nx9G92uONT2Hk2mZwykK/nYq3ZHmtpHgR6oLCL/u/k1k4QU1
         Ln61KxGFHWid2dwStGBfoUzXqpkih/bUFyKFaS7nriaRiIII+xo8GoCPg6KeeN5Np7Lo
         YBnjIwyEnsY3G6WK+H/GX0oIsVZwZGu0Lx6lnQRi/9pOrdl9q8FLZetVWW83h8J7v5LU
         n9V9re5afTQmTFASlcOI6Wuw5LlilTbzYUKCjO/iO1Cqx44FRDuTd5lK8g88Xi/7Vs+g
         xUcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771977224; x=1772582024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZyeG2Q8XyW2wc8KoZtdZ7lIpqMq6VE1Ib335DSpfY0=;
        b=dSQ2Ua+Kbjuil6p10cbPxCJN9ZhCNW4iCS0fA5zT3nWrNEzraGa1D5lj3jBNQOnY80
         ts6Z9TrjZlXPtLEGeoM3a/Bn4w7TNCWjaBTDgSQNvBW9qu1eiTKkKsKEpET0RxM5O7av
         AZKcJGxFZA/Cf7SebIxhKhW79HeRmeJ0l7OeZw5K9W7zvWYJeeIjQNjv9rt2AiY/A3f7
         J92YuT5a4sY7wRDqzTxP3mKhQKVzhq2scSA2k1CZtv8v4kA4GkW7NTL+5Nzj5kYvXoC0
         D5II3daNwvBwFPEbutvI/obfCLbuZaiN817c/+YLje24jRx9yZFOqp6v+QHtnRVREO09
         rcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771977224; x=1772582024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ZyeG2Q8XyW2wc8KoZtdZ7lIpqMq6VE1Ib335DSpfY0=;
        b=wY04o55HM8P7c5zSSxXkvJm5ggjgwuMuxzVxciWPUFe9t7LCN/sAELLoieXT0uYBlt
         +vnEDKPrE6z/Juue13UF4vWSeTGz3z5mvBer6VFgwvBO4cP+0FpVRIE/MrI3bUSs81LW
         SScfPDtie8q2Pe470M/p/zT+vXf/pLxghiuiN8nhlPmXZ/AIjnt4tXkykdeZLW9DC2lj
         NcCnO3+0jQPypxXvunwzJheQKt244RdQFZendsjp55r2l+8NKrs+zPESqRv2bJNmjdLZ
         zEjk1DYbn4YWLlqVajfWWguvTHLOD6qQ0Q6j1H3YW/QwufrtcXqIDF8VhMbdiShP7V6C
         n5fg==
X-Forwarded-Encrypted: i=1; AJvYcCWxikqI6g572BgdYmU4u2WUD4GbLfz7ERJk/uxmxkVuByyPxwwhIx0qZ6vUGXJfpMTZfH+ulLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRvFYHx4mK/gkn64DTL4JE36yVVXLnZ27sBo8llLcbgWo0RZ8L
	eWnfWa+edfEoPXdMLqlFRljDeF2CFDPYO1infLSj66+02shaEdAa5sVrUxOr9gSdiiFdHLUYm90
	9AD1r5/jwMVUs5fuPrXEadADr4R9fj1DPxPNISkH3
X-Gm-Gg: ATEYQzxn6jIHtRv0K4wtTi4vLBT/qEviLVaoC9phe8FlMvgFoNUrxglraq7Bu9yOgpo
	wlsc4rVDvuvK7mLnR9ggFvm1xSRehJXpfWPmON4uSgYwuL0pZQyd/AMZcuED8CrkJ3uDPCr4zz2
	1bFRXj4n3934RHss+4Mh8gUJwQ4s5NhS7EaAYlj9iLVnU1mY0LlSZxz6/M5r5j73OV+B2w8R+pK
	/xecBgA/ixCbjXFVIekHTaMqhg3VneD9lt1kxywQeALs21nFrWkuBY7FuyyE0Qmx3TP9zOCvZaU
	F3U4Pg==
X-Received: by 2002:a05:622a:1194:b0:4ed:ff79:e679 with SMTP id
 d75a77b69052e-5073a3623f6mr2473021cf.19.1771977224030; Tue, 24 Feb 2026
 15:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHa2dChQ=4UVY5X5Ad=jryGRCBPQ37Z_Sw60-6h6h_EcUFG9g@mail.gmail.com>
 <aYC0OvkVPkOnVU-i@moon.secunet.de> <CADHa2dBN+_9H-_L19Rg3vfvzC1N5FzG+rzW9Pff8pyM3KL9Ocw@mail.gmail.com>
 <fcc761de-f677-4fc9-969b-47c2b56f54be@strongswan.org> <CADHa2dBzJBF6po_qDcn97C15U05EZOzuY-opGW1uc3WAYTPx_g@mail.gmail.com>
 <7b4667b9-c4f2-4c56-a0ea-6e9bdc8b5241@strongswan.org>
In-Reply-To: <7b4667b9-c4f2-4c56-a0ea-6e9bdc8b5241@strongswan.org>
From: Nathan Harold <nharold@google.com>
Date: Tue, 24 Feb 2026 15:53:32 -0800
X-Gm-Features: AaiRm52LeKyFHmrBHThjXo6fAcTnOc54gKIBzNRjsyb2oY2tPkTyvzzOikCvHIk
Message-ID: <CADhJOfbv8A+2X7xwtoEpLUV1D1vesMjj=nSYc--iOHF6R+VKLw@mail.gmail.com>
Subject: Re: [REGRESSION] Discussion on "xfrm: Duplicate SPI Handling"
To: Tobias Brunner <tobias@strongswan.org>
Cc: Yan Yan <evitayan@google.com>, antony.antony@secunet.com, 
	Steffen Klassert <steffen.klassert@secunet.com>, paul@nohats.ca, netdev@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, 
	horms@kernel.org, saakashkumar@marvell.com, akamluddin@marvell.com, 
	greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260675-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nharold@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EDF4F18E32C
X-Rspamd-Action: no action

> That should still be allowed when using the intended APIs (i.e. ALLOCSPI
> for the inbound and NEWSA for the outbound SA).  ALLOCSPI might enforce
> a unique SPI without considering the address, as that's intended for
> local, inbound SAs, where the kernel has full control (looking at the
> the patch, it's certainly not ideal, as it goes through all installed
> SAs to find a duplicate and it prevents an inbound SPI that matches an
> existing outbound SPI - I guess that could be resolved by using separate
> tables for in- and outbound SAs).  But that must not prevent installing
> outbound SAs with the same SPI to another peer using NEWSA, which still
> uses a hash that includes the destination address (that must always be
> the case because peers are free to allocate whatever SPI they want).

Agreed that there are some unfortunate limitations with the current
patch. Keying off the inclusion of XFRM_SA_DIR would resolve the issue
you noted (conflating inbound and outbound SPIs) and function as an
opt-in for this enforcement. Whatever the mechanism though, the new
behavior should be opt-in rather than opt-out in order to maintain
backwards compatibility.

> In my opinion, you are using the API incorrectly...  I also
> don't think there are any benefits in that "consistent larval lifecycle"
> (if you found any, please let us know).

The Android architecture is multi-tenant and allows userspace apps to
establish SAs. At the time we designed it, this felt like the cleanest
way to facilitate leak-free resource management because the chain of
associations between kernel resources could be symmetrical (and
managing them was already quite complicated). Mea culpa (Nathan). But,
correctly or not, it has/had worked for many years.

> By the way, are you using the min/max option for inbound SAs as well,
> with an SPI generated in userland?  That would seem like a violation of
> the intention of the API as well (i.e. letting the kernel control the
> local SPIs).

We provide following two Android APIs for app developers:
https://developer.android.com/reference/android/net/IpSecManager#allocateSe=
curityParameterIndex(java.net.InetAddress)
https://developer.android.com/reference/android/net/IpSecManager#allocateSe=
curityParameterIndex(java.net.InetAddress,%20int)

Indeed, allocateSecurityParameterIndex is direction-agnostic; both
overloads are implemented internally by including the min and max
values in ALLOCSPI. For the variant where app developers provide a
specific SPI (which is also useful in testing), Android simply sets
both the min and max parameters to that exact value. Our understanding
of #xfrm_alloc_spi  is that min/max are required for ALLOCSPI, and
otherwise ENOENT will be returned.

Note that we also use the DADDR as a mandatory part of the tuple
because of the issue mentioned above: SPIs are only unique in
conjunction with a DADDR, regardless of direction, and accordingly,
that=E2=80=99s how Android is expecting the uniqueness requirement be
enforced. In this way, 5 duplicate SPIs can be used on 5 unique IP
addresses on the same machine; therefore, a strict "SPI only"
interpretation for ALLOCSPI (or SPI handling in general) is curious.
We feel that ALLOCSPI should really enforce the same uniqueness
requirements as the SAD.

Best,

Nathan and Yan




-Nathan


On Wed, Feb 18, 2026 at 12:42=E2=80=AFAM Tobias Brunner <tobias@strongswan.=
org> wrote:
>
> Hi Yan,
>
> > For every inbound SA, we allocate SPIs before negotiation. For
> > outbound SAs, we allocate SPIs once requested by the peer. We only
> > require the (SPI, destination address) combo to be unique. Thus, we
> > may have an inbound and outbound SA sharing an SPI with different
> > destinations, or multiple outbound SAs to different peers sharing an
> > SPI.
>
> That should still be allowed when using the intended APIs (i.e. ALLOCSPI
> for the inbound and NEWSA for the outbound SA).  ALLOCSPI might enforce
> a unique SPI without considering the address, as that's intended for
> local, inbound SAs, where the kernel has full control (looking at the
> the patch, it's certainly not ideal, as it goes through all installed
> SAs to find a duplicate and it prevents an inbound SPI that matches an
> existing outbound SPI - I guess that could be resolved by using separate
> tables for in- and outbound SAs).  But that must not prevent installing
> outbound SAs with the same SPI to another peer using NEWSA, which still
> uses a hash that includes the destination address (that must always be
> the case because peers are free to allocate whatever SPI they want).
>
> >> If so, why would you use ALLOCSPI and not just install the outbound SA=
? Is it to avoid differences for in- and outbound SAs (ALLOCSPI+UPDSA vs. N=
EWSA)?"
> >
> > Exactly=E2=80=94it is primarily for code symmetry. By using ALLOCSPI + =
UPDSA
> > for both directions, we maintain a consistent larval lifecycle and
> > make it easier to maintain.
>
> In my opinion, you are using the API incorrectly.  ALLOCSPI is intended
> to allocate a free local SPI for an inbound SA.  That is, reserve it
> before and while the details of the SA are negotiated with the peer
> using IKE.  This step isn't necessary for outbound SAs and forcing such
> an allocation, after all the details are known, to the responder's SPI
> (which I assume you do via min/max option) doesn't feel right.  I also
> don't think there are any benefits in that "consistent larval lifecycle"
> (if you found any, please let us know).  And the difference between
> UPDSA and NEWSA is the nlmsg_type (there are some attributes that are
> different for in- and outbound SAs, especially if you set the direction
> in newer kernels, but that's the case regardless of the message type).
>
> By the way, are you using the min/max option for inbound SAs as well,
> with an SPI generated in userland?  That would seem like a violation of
> the intention of the API as well (i.e. letting the kernel control the
> local SPIs).
>
> As the XFRM API basically mirrors PF_KEYv2 here, you can find more about
> the two ways to install SAs in RFC 2367 (SADB_GETSPI/UPDATE vs. SADB_ADD)=
.
>
> Regards,
> Tobias
>

