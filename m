Return-Path: <netdev+bounces-304654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YgdhIBkDSGqKjQAAu9opvQ
	(envelope-from <netdev+bounces-304654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:44:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DBA704FD9
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:44:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fUKRYuVa;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304654-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304654-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84A3530328C9
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC4232143D;
	Fri,  3 Jul 2026 18:44:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D22273D77
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 18:44:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104279; cv=pass; b=f/lA0034Yu8Pqxujh9wUyixmSpozPjR2E4oRBNbZVXMrmfvoVqf6iYiS+wyaqAwM/dYGlxrJQ6qsGE2u42/Irbm9z3j+zYkHna2MKWRMiNZ5ODUnKj20M5kEEDmmSieNFAJE866/NFL3UiWZsTeNXC1tdQys4MnnfAmYYDQh1DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104279; c=relaxed/simple;
	bh=6P6fDiWSB3kdTNl9U0SiUY0ZMUVbpm+b855g/OS6yfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frrBRVW2fFNePVrmbpXdYEX/2muXb9aSLERjBJJ8z4FCRVW9V2iY5ByDdpjyDwjFe5bAbmmY2rCKkiPyjKDNpAPxmhLIkMHbuV0jI38SrF8zJRTqrZXyFMaA0tVM4rzWslkolrMIJnwAlDKpa+vhvlymPR5KZY8xTykdMQFGD8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUKRYuVa; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698b899b4c8so814136a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 11:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783104277; cv=none;
        d=google.com; s=arc-20260327;
        b=lacDDM3dPr8jkOd75dxzNvpMTfHRYnydr6ZCa5sSO5EWdkkF0Dc6qHWowhBpgNjviN
         UlNrnwG3sqRmn90peupsAIn7QACD2bN2eGWTBg5GpCa/1wPJAGKpvHVS9JPRzKNXW4h4
         3rPojnKE5Y4aQg35iShEmMqnX4av0V7LMi9fIPSVQ+OsVh7xdPqz1dQ5mDPhOzKBlvei
         4r+7L/Iqt8g59fbs2RLGOpMiq79wg1wxJZNLlZ9jDT+PyHgaIvLg192fdgEtWuGhpmVm
         3IiR/6q2EGQJxZ7z3CKUtvlmZ1t6jpjYCMsyBf99Fa2AUsZpIxfQy7HEEU6XvB4L5iae
         tX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kVsx1Lt5j2+xhQiEpkE6HWCMfpz4vvUckdBMfTth9dw=;
        fh=nIv6pSZr9ozNTJcPUkoK74qqlj726jGA8mSIF/RzEbs=;
        b=hvIyukNaJYQMUWYBqcCc+aCzAjtMyAQ63FsBzTevwZnoQNychBBjHFtv2k1ueQJc1A
         zpoLYd6awZWbw8ltW4uQ0gPYCcSaik4wWRKY7tVU435+48UZkn/IO+c6O1jjr4fXV4vo
         suMLRkrsCNcyNIO1fbmQUgIov6rxConEMn9bKqqcFEyIZEzo9CKuHQXHCGzBP+hKFNex
         H5xNlFjjMg8QRO5IsbGOoP9vxZ2kLjl68Q1JLCPyP0zOKO8KQgmc7yPuVfAGo1fwOnyQ
         b7QyuyVBXHf+LswSTyzqypMtTLEMC+xumBlximxO3MYc9Ts9+jkPnrHy5xXLo85Q7Ivc
         7Uyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783104277; x=1783709077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVsx1Lt5j2+xhQiEpkE6HWCMfpz4vvUckdBMfTth9dw=;
        b=fUKRYuVap64eeiCSHCmFMz6QHJ386Zemz3bRt+0oKfQ1F2x++H1HABLLV58IPWe1ur
         M94yVAIDuwtftnQTR9uvTR2BIZ63NPYsvV0jcdCgPnCFR37G69n0yV2Q6pDbeWqVTRnu
         oHQrtHqBjnQZKeR/iNH8qdkOM0DITumSjm9TG1NskoylUGKqeTbVnBaBJqGKviwtQUNx
         nEYddBYXPbtqmZ9OmbnYPYrAmJ8SZMMan7vKGSzS/QBa0JmKTdYjH0y1VMapjVPzAO8A
         PIWJtk8MqpD1ypqvi6Ln8DAvRPsW2QpSjdaBfXA6gHvgx/E/hjnBLkuDiQvl4umtoC7W
         sG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783104277; x=1783709077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kVsx1Lt5j2+xhQiEpkE6HWCMfpz4vvUckdBMfTth9dw=;
        b=hn6kqNW/B1NYzVXTmeKPLLZgKkROfeZSIMZGsdf8RWsDLY4wH2NQ0jSb8v+uo25lja
         euNU5X2qKUAjFW0WCsEK7tF9LPJWKYdMYtaezdRos96tJxCvg24zk64tfipEZym+USTC
         Oh9yP6jGDqQAwFQoUa+xKBtAcK842og3NiTOTr7T0DhK4pZQSzdTxtv0coBgSv6p6790
         dtDGXleF7omLfTN1Dyl6rwx77rWSrnknDT9bOGeZmtKc8E8LmM/7vvMrXLiN5Qezbee4
         ePMPbRoyN+08zbXjLfxuqy5dd4wF9j2Mc0p/dE4Ico242cuy3kOiuA65Gji7NQJ7/KI9
         UWSw==
X-Forwarded-Encrypted: i=1; AHgh+RpWyqTft/axv2UwBofUt4FgkVxr9ssyYynLKhzKuFUllyPplt/xYGY10oTK2hP8U36DYnF/jvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07nnjAzTrSNXDajU3fUKY9uJzatkB6ixOO7wt6B2NuoUUbqx/
	ox1mcvvNj32DHqlbAwDPoFMlinwnqfd1Of7rYfERngGZ1D6pbMtpbzxgbGpoYPLDTIhqirssBf7
	JW8JqeENPNat57Ou4t2Cr3FsoLnGS+jk=
X-Gm-Gg: AfdE7cle+SrlKUncWVZd6dzxL2MSOa9UlOfStcAyEZ4tbtfMsli6k31VQfo1ORfuTt/
	8yjXEnm8Y3+A3IvkPXygIsXMRnmlZluJEFuxpaICnlThnEOXfTyrq2bHXwnkN53+fmgktfgrGsV
	ZNSZe/u4yHb7P9S6AxMIU1yQ2iscTtwerhOpQo9PhpLaLqPzN4VmbsVluA4Cq5lipcg+96j6uuu
	fMTH6iQFKB9PE0YviHm+vY95q6g6001PhaYD3Yxi94psjvQj5gTUOQJfQSnD1VsNzD06ELDsqds
	c+ScX01WAIehGHDioiVXo2ATh5n9wgZU9AsbK/J/QyMbqq2rwpAK8qyVWKYHxwXH4GodtmNmrag
	I/Iy+OFYYRIprehWovrwvriWH2uk=
X-Received: by 2002:a05:6402:51c8:b0:698:6084:db7f with SMTP id
 4fb4d7f45d1cf-69a1a261fe0mr176049a12.10.1783104276671; Fri, 03 Jul 2026
 11:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702234923.1320412-1-rosenp@gmail.com> <akcnQEiJYfAtPqN1@zatzit>
 <3a9bdad9-3755-4efd-8de4-a3ce3ff30b69@lunn.ch>
In-Reply-To: <3a9bdad9-3755-4efd-8de4-a3ce3ff30b69@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 3 Jul 2026 11:44:25 -0700
X-Gm-Features: AVVi8Cc07KyShVpyVVtvw9efIQGWbywZyUZHgPqSRZnDG8s3j2pD7mPY21n4Tlo
Message-ID: <CAKxU2N8u+psVg4aqcm9Pooo92XsxTT12r02dNt6GttZZ_NkHPg@mail.gmail.com>
Subject: Re: [PATCH net] net: emac: mal: fix W1C write race in ICINTSTAT clearing
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Gibson <david@gibson.dropbear.id.au>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jeff Garzik <jeff@garzik.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304654-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:david@gibson.dropbear.id.au,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15DBA704FD9

On Fri, Jul 3, 2026 at 9:37=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Jul 03, 2026 at 01:06:40PM +1000, David Gibson wrote:
> > On Thu, Jul 02, 2026 at 04:49:23PM -0700, Rosen Penev wrote:
> > > The ICINTSTAT register is write-1-to-clear (W1C).  The read-modify-wr=
ite
> > > pattern in both mal_txeob() and mal_rxeob() can lose interrupts: if a=
 bit
> > > that should not be cleared is already asserted when mfdcri() reads th=
e
> > > register, it is included in the read value, retained by the bitwise O=
R, and
> > > then written back as 1 - inadvertently clearing a pending but unhandl=
ed
> > > interrupt.
> > >
> > > Fix by writing only the specific bit to clear (ICINTSTAT_ICTX for TXE=
OB,
> > > ICINTSTAT_ICRX for RXEOB).  W1C semantics guarantee that writing 0 to=
 the
> > > other bits has no effect.
> >
> > Wow, it's a long time since I thought about the MAL.
> >
> > > Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
> >
> > This doesn't appear correct.  The lines in question were added by
> > fbcc4bacee30c ("ibm_newemac: MAL support for PowerPC 405EZ")
> >
> > > Assisted-by: opencode:big-pickle
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >
> > Assuming ICINTSTAT is indeed a W1C register (or "read/clear" as I
> > believe they were termed in the 405 documentation) the change looks
> > correct.  However, I no longer have access to the documentation that
> > would let me verify that.  I would absolutely not trust an LLM to know
> > if that's the case, since it's a fairly arbitrary and specific detail
> > of an obscure CPU.
>
> I agree. If this is pure LLM, we need some form of verification.
Only verification I have is the hardware and whether or not something break=
s.

Sashiko reports:

This isn't a bug introduced by this patch, but does this read-modify-write
pattern on a write-1-to-clear interrupt status register cause lost
interrupts?
If another interrupt occurs and its bit is set before the mfdcri() read, th=
e
read value will include that bit as a 1. The bitwise OR retains this 1, and
the subsequent mtdcri() will write it back, inadvertently clearing the newl=
y
pending interrupt without processing it.

This is a pre-existing issue, but does this suffer from the same
write-1-to-clear read-modify-write problem as mal_txeob() where concurrent
interrupts might be accidentally cleared?
>
>   Andrew

