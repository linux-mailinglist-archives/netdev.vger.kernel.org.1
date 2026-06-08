Return-Path: <netdev+bounces-296688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W027MzYJJ2pWqgIAu9opvQ
	(envelope-from <netdev+bounces-296688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:25:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701F659B35
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:25:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VOzeiRdk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296688-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296688-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88F4130151E1
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9867384CCD;
	Mon,  8 Jun 2026 18:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850033374F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 18:11:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942309; cv=pass; b=eCwSvnIzyyXv38cQ1nGm8W6Pk70ebBgX0Z2NJm1u7qd7GFGzPK61Z+V/n+qFx6DmKz2NnoFtkgGLXLTDIjNHpDSQcIDkclSFVdhxe51Af23k0PiUgNON248Nw1C8ts2PUcVOBOa8/jpIZOtfxYe16rNxolcj+I25MOugrdaq96U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942309; c=relaxed/simple;
	bh=VZpVuEIFYp9UsfFz5BGKAT3YAHB73zvlRx6pwQWbJ0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LybMPlbVVEEGKVfw5qnAj7pzjSijHN1NAR9Hzu1CUwN/R4+gKrj4Hk1EQUqXf0K8UmmsvhnNq1iT/FVah3gB88O1+nTYWEi8YhpD2ywCFfPuJnhRdMD6ja+6mROXBIGY4lfDtRqrhUa1PjTi5KDKe/YX5Mh6giLSwX5UKOxj8r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOzeiRdk; arc=pass smtp.client-ip=74.125.82.44
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13809223fd4so3929479c88.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 11:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780942308; cv=none;
        d=google.com; s=arc-20240605;
        b=RAL2yPWcRRGPyM8F0hIxF7yBXM2i24S9p7mO0MKkptgwJ1XZxJQaE/MiPh/+P3QRcU
         mqTxitvPQp625hWBbVUrxO0JQ9LSfl830V4IxZ6L7cWk4V99HEC8CSWr1h4obP+x9aco
         upDL2iaNt/FKANyiykRlItGHe35A/VCaIIyDOGgRAFAC14PzsrbwISA5qEvWCmxsi2Bu
         RZ7qWApvrcWSzH6z06Ply4KneuTJ+NBDFXa3VoYb0OuQkTBuj12SYxEFTCzOi3VhCDVH
         fA20gTSdT3AQKWouOrtbnjaWimI3/p7H33Aqq7ikJWON1aOiWFm/sUUNONgB4CijjHU3
         0ooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ep5iwWlczkBtdvT0ueoldhn2n7yNnVgtmpFujFfNkgg=;
        fh=4l5DPsttvu+8jWOE2eSNTzjeAEY7U3uZSLa1DZhy4Po=;
        b=EcmF8G3l97Y1eCwuAoJdcG0PDCoQy/hFEMhFVz5c2IcgeUyTBXdbUskfSCJBWoplsz
         paDcoO8L+6Uq+dhnLLXl3Kei45EnnXm1T5N/XJrNYCNZnH3IGJ+NzRgW3wxUvay6EYxn
         4hWWyXSq5EW+00ZCBJPdkmu7diMYHzIE1TeOd4q57NpVJsNq5ntmKZlYY+CMv3oAZy4e
         aTu5Rc5WCYKrhDEmo+HolnynDeCMc8Dr5u1R7y1LUUJ4lSo32fzg6v3U8igl4AcoPToz
         EsvahJVrwOtKOuagtiDQFexV7UpSfu1woYenlyPSMXeIGX/SVLtgK7E9TeuIcLNbzA4Q
         imfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780942308; x=1781547108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ep5iwWlczkBtdvT0ueoldhn2n7yNnVgtmpFujFfNkgg=;
        b=VOzeiRdk1KnojBUbI4Q4spYN0loFYMm7+wM2pmzYMiXfYlC/INktsaz3wOh0h0+YqQ
         7vQN607z3XTTm4PQ6OONe0xoaUJuQ1ISDH4OmGBxlvkCct34fpTODuNSiUCuNuDAtJPh
         JMDjOMSYDN+wkGpQo6OEe1MjzERAV4ax1a0BVuTa5CkV1Z5XRVMY/k0SlFepPKCnRtko
         PkHKXyb6EgIAdntCHmHj33TdwDADZchljdy2T5VnGMJw0hlnWoXVvRcEJB9pA5bLCVUu
         O1dt2ZR1aeJRs88vnuv0chjK8HcXDTHReFScXro8vWVwXcFxxYJ+v602VaPLbM/dqc/J
         MwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780942308; x=1781547108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ep5iwWlczkBtdvT0ueoldhn2n7yNnVgtmpFujFfNkgg=;
        b=rdIycGlOfiVmCcm+iRudTUjY2SfYj/UPCq+7UK2M4bNd8A02urC3LTRO4297Xy7MVf
         T3yJ5PWFtSfLiiTYzFwAIiJGgPlCaMFNDTGwIKPbl6X5dn4xxb76O10sXINmex0NkKMC
         7M6gX/fy+YIe7tzzZTIeDEn6kV2Y/GQcaD3FwdKpQOCtS98YgUc+ZJn3s8fwCvoGVtqZ
         9PPkJT2B2dbxmju9onW6fgECHR7/sZWUOquP6mVjmlNAKxS52RtWrhQSgXAf65y9WvbY
         tzYNGDevfP+3XH40XeES1XAqIQEppsckfUtUaG4qtUuhU9NRsbDTJZa4ufZ1rJZ/nGQR
         anYQ==
X-Gm-Message-State: AOJu0YwKB582IxVYzZ+4O6ZeAJyqOefgiSJ1XraZvLCQDnqhYWi1zElF
	x4GEpQPtyz2+YpxEGkk8NbKRDIESlMGO49rt0+cz8zfakDQU1Ry3dupqv33Iqlm9ceh6V7G9Adv
	8MFocSiUF0wf4Mg6MwkFqXXXQ3FvbQQ8=
X-Gm-Gg: Acq92OGKsAAzMUEjE2kd3eh5PHuZxDiGlboKlI5Q6JhsqVV5w/UQbBfQB1JlUEXnxQA
	NbRtodvjludPvzw5hBKXZ6Rfb2II8WWbsfRCXDRLWnF9l8UMYIRegXm0EifHlYiI2HjF+vmWPn/
	Iu5lpUv8sAN9gjUOg2AvU5zmvv4XsjZHr3nL58rPXMczjYCXeb41q5UQcLMfsNZr3f15QM/YbId
	APeu9HEsO8Bf17bWFcCf8TE4kIJSVDicQzVl9zw1Pdc3RDE1QQB5hGHblw/L8z6zTolUJbxwwKJ
	6RWNSJm9e7VuJUY=
X-Received: by 2002:a05:7300:3b06:b0:2ed:e14:e954 with SMTP id
 5a478bee46e88-3077b8014d6mr7984972eec.30.1780942307519; Mon, 08 Jun 2026
 11:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522050740.84561-1-ebiggers@kernel.org> <CAB9dFduBir-41_Ef4noEJPHsFU-++JHDxMU-6S7B8pBYynvadA@mail.gmail.com>
 <20260603050557.GB18149@sol> <20260608173921.GA434331@google.com>
In-Reply-To: <20260608173921.GA434331@google.com>
From: Marc Dionne <marc.c.dionne@gmail.com>
Date: Mon, 8 Jun 2026 15:11:35 -0300
X-Gm-Features: AVVi8Ccuf9-VZpieD-CilJz3X4Bu-AwhKT-kdmFxIlO2MI1v6r1hS5SlD2UxAzQ
Message-ID: <CAB9dFds7kUSMRPAV_BGZ5hGYd-yPq3YziFW5VTN7FgXTtHuhZw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] Consolidate FCrypt and PCBC code into net/rxrpc/
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296688-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:netdev@vger.kernel.org,m:linux-afs@lists.infradead.org,m:dhowells@redhat.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[marccdionne@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marccdionne@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,auristor.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3701F659B35

On Mon, Jun 8, 2026 at 2:39=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> On Tue, Jun 02, 2026 at 10:05:57PM -0700, Eric Biggers wrote:
> > On Fri, May 22, 2026 at 10:06:49AM -0300, Marc Dionne wrote:
> > > On Fri, May 22, 2026 at 2:07=E2=80=AFAM Eric Biggers <ebiggers@kernel=
.org> wrote:
> > > >
> > > > The FCrypt "block cipher" and the PCBC mode of operation are obsole=
te
> > > > and insecure.  Since their only user is net/rxrpc/, they belong the=
re,
> > > > not in the crypto API.
> > > >
> > > > Therefore, this series removes these algorithms from the crypto API=
 and
> > > > replaces them with local implementations in net/rxrpc/.
> > > >
> > > > The local implementations are simpler too, as they avoid the crypto=
 API
> > > > boilerplate.
> > > >
> > > > I don't know how to test all the code in net/rxrpc/, but everything
> > > > should still work.  I added a KUnit test for the crypto functions.
> > > >
> > > > Changed in v2:
> > > >     - Added missing export of fcrypt_preparekey().
> > > >     - Write "RxRPC crypto KUnit test" instead of "RxRPC KUnit test"=
.
> > > >     - Rebased onto latest net-next where decryption now happens in =
the
> > > >       linear buffer rxrpc_call::rx_dec_buffer, simplifying the code=
.
> > >
> > > Looks good in testing with our kafs test suite, forcing the use of
> > > rxkad with encryption.
> > >
> > > Feel free to add for the series:
> > > Tested-by: Marc Dionne <marc.dionne@auristor.com>
> >
> > Thanks!
> >
> > If there's no more feedback, could this be applied to net-next?
>
> Any update on this?
>
> - Eric

Looks fine to me (and in testing), I wasn't sure if David had a chance
to look at v2, as he was away for a little while.

Marc

