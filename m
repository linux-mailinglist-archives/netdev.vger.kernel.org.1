Return-Path: <netdev+bounces-270077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO2iIlW9vWnyAwMAu9opvQ
	(envelope-from <netdev+bounces-270077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:34:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AD72E16D0
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EF67303C29A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDCE37F723;
	Fri, 20 Mar 2026 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="I5/YzugH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C010C3C553F
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042448; cv=pass; b=R38cjITOSVA0lFmCsMgD39TaRwLi/U8t0/wsQrtNAO9wSbAO4rsenvm8q1URVUOZNxHgCxi73wqUw7TEhZwShHSxrgtgIHnYUt/37XKEX+Eu8BBEO133zz3LSBjeGCXIvjijADDmI86vYBWTRf89VNEljDpwkL8OxUjMZRAvffU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042448; c=relaxed/simple;
	bh=uVz6+lgQfj0/2jI1Z1eOw04ULfW3+IYJOoxQUClvUfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dw8bzkcKyhElW1f/G6Tq1cj6moKCebZdTCzKbNLXQmFR3uPfXp5VDYVUuJn3m0QXzgViFvUUA2u8NvflTWIAAzzu0OdFDajuwk4gEXbs2ZEheo8OYjgIMGSaoBYFHeH5CUfnv59joZRX4Lt92E1tKRYQ9O9SV5LznZhFmZ23xNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=I5/YzugH; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ffabb1dfbaso1411564137.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774042445; cv=none;
        d=google.com; s=arc-20240605;
        b=aNHwsn6iS0MadVI1QSMYyvmIBsHTYFAGX6RBkvzS8clfMVEuI0s1SbJlQgzyDLb7kP
         r0p5Fu+ID/bDVsp6jGChJG5dFAnsc3+aMzRDPz+zKUo4C2x5lV/2KFhidOzjHt/GIwfQ
         bV4R6FQr8YgtcN3fJvSiNw0DYoX55PQDzbuozgZ1/U7uQ7eWQfjLbShG6dmv1nYh9Y0r
         SUYDZ/No+8Ad3m/0eIfiDvxc0fKpcZNjEcZ0+ck82QW3aMcBC0WoexkOG9yhf80Z0+i9
         NLsUv7dS7zXH+Zj+x9lSUjYwpif8OVCXYh2tXcFhdutpFirIuT5n3ibEgsHXwnjxeN6k
         D0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MJFbrhtYpQfArweBxR70nT/v+xFCwArxYoD1MlJtyzQ=;
        fh=8Ni+b3A2FHocRS5hGzM+Q2Hl+V6cD0sjyI58SH2bOSw=;
        b=azWM/0kTqSq7J78EhfHMCcthq0+xNK+V2xMHiUOCnuDkEAWFvl4EvuYK92UtgeJQyJ
         S4FJkpBu6Wk2tH09HlwlEU5CklSTZo5Jg1DJLEXLzCqCwYx9aWW4mmBFhov1xb6cbCkZ
         Y8X1XyKvoAfEskvn08vvI4WyUk/HLEvJbEFnQpClApy/XDAZDfo/gm1UGUmHwqSog4o+
         yuQkWodZES4o11baOhi0ZdmxZvuIK3QE/A36y1ru2RPNovE5SAns8G2jEC6w68AjIk2h
         +aFPWTm2WowOZ7iISGZC0jN7LYO/uznB816OOt7uqNmqXOvE1JGeLox9SJFvIdvMJGzR
         MV8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774042445; x=1774647245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJFbrhtYpQfArweBxR70nT/v+xFCwArxYoD1MlJtyzQ=;
        b=I5/YzugHtuDipHKPtcn80x6s8WyBumMSZB6H8aN1fW1BwM2ToV2l2pl4sxy4i8bR9g
         dg1weT4fB7HJi61Br21qXYmgPRN5d1FbwqpBbv2CXwYB+RPJRRJVdpjaRfMfUz6/wyDR
         csouZk0LH9lTEK/E6w75Bs0hOBLciXOuFxHvqadfcU+/MnEJyilOYGbMGmYK7m/5GkTI
         6WB3uTDajum2cG93DcfHQCi4s+Zf7Qoso/ZZMSpE8izxM3cad1X5+rrhtmqPQGTyIWHb
         St9K9UlYMun3EVdbqVuD6g+pOSaMazjVGD61+0MBurHbqs6omdAhasKt2otxj2yYvlRY
         Ri/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774042445; x=1774647245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJFbrhtYpQfArweBxR70nT/v+xFCwArxYoD1MlJtyzQ=;
        b=Ik995Hd8hT/NNT994iX2M4o73NLrwgj1k/SmqUwIuzO3Yc6JJqnsI4yiZlbS03mPyY
         K1DlexqGaom4TgyA9Z184aqBviejFkNuKVoypMgzZKrUYiHjzQ9skU1vEFLqYaXCltZi
         lZ1u1thZTGCbFH5hMBZDstUzQKMkFiIRD2wGs061/C8Y29xsICdSJkH5ncTyqnEM588i
         fKghGBaRox4NQekYk9SM0CY+bcpipNtKzrcz9IoGp/4vK93iIHkHzBMrr8mEc2CUv3Ui
         irvcanI3Ib0/MAp2BzHG66SQpVL42UW0cGFSPtYS2mrmMt7IdaZrx53hf5g642vysASH
         GjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBhe6kXskq0Zsxyyy0yudeHGIHg62hNZD3j6PYih9siJKyehm7N9sH4eQ10u4v1LsqnQQQnRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9F/HtIsC/mZURN3c7KzZSN3K2zXfcuaotGuVJeIQVI94Hjpn
	3jZ71j4kiqXuPE+3acjwZpUJpk0eQ/rOtIN7YxhJLnwXJYhqTlXcJnXGYs2BHI/JJDkoV7dMy8a
	POtC2Uj79t9O9JnzNaL/tkuhOngGKvYk1YvrDMIVtfw==
X-Gm-Gg: ATEYQzxHT3sCc6ph539ZJqErcSX05xOek6VZhimkVDW0LGEcPWYrDX8wile26RYJ2e2
	z3i/t54qHirgW8uo+bQNFBT8eFpzKac+j1xjXJhXQYzMSNnUZYWidDKMiCeKZxP55GrnGs46MfJ
	obMFpFv7DBBH2fkx6K7NME/f3aw9Ylg7r9NWaUXz68lLcN5yAlAQE9PnI8BfG3JkGxNm65+qUjL
	aRL3D3d4o8vqkyxGNZyuFr3ritIt1UBKMv/9djGpm77MVotpuKsSfHQcXNpElfCNzhso6YsT/hX
	OD5XV1OP
X-Received: by 2002:a05:6102:3a12:b0:5fe:c17:a2aa with SMTP id
 ada2fe7eead31-602aead01cdmr2553553137.5.1774042444660; Fri, 20 Mar 2026
 14:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319213323.235559-6-rjethwani@purestorage.com> <20260320194224.175550-1-horms@kernel.org>
In-Reply-To: <20260320194224.175550-1-horms@kernel.org>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Fri, 20 Mar 2026 14:33:53 -0700
X-Gm-Features: AaiRm50Kao6UbPDjUxI3naadhjLMd2C99oC2G6EcaH5D0fEK9C6Xbj-q-0VLEPs
Message-ID: <CAKaoeS2z8pMs-GXKk0ueg7Xg0dVo7jin0L7kTcud5f+pdxwFRw@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] tls: add hardware offload key update support
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, kuba@kernel.org, mbloch@nvidia.com, 
	john.fastabend@gmail.com, netdev@vger.kernel.org, davem@davemloft.net, 
	sd@queasysnail.net, pabeni@redhat.com, saeedm@nvidia.com, borisp@nvidia.com, 
	tariqt@nvidia.com, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270077-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[google.com,kernel.org,nvidia.com,gmail.com,vger.kernel.org,davemloft.net,queasysnail.net,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:dkim,linux.dev:url]
X-Rspamd-Queue-Id: E3AD72E16D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:42=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> tls: add hardware offload key update support
>
> Add TLS KeyUpdate (rekey) support for hardware offload connections.
> When hardware rekey fails, the connection gracefully degrades to
> software encryption/decryption while maintaining TLS_HW configuration.
> Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
> TLS 1.3 key update cycles.
>
> > tls: add hardware offload key update support
> >
> > Add TLS KeyUpdate (rekey) support for hardware offload connections.
> >
> > When hardware rekey fails, the connection gracefully degrades to
> > software encryption/decryption while maintaining TLS_HW configuration.
>
> This commit message claims the connection "gracefully degrades to
> software encryption/decryption" when hardware rekey fails. However,
> the implementation appears inconsistent with this description.
>
> Looking at the actual code behavior in net/tls/tls_main.c:
>
> > @@ -711,64 +713,68 @@ static int do_tls_setsockopt_conf(struct sock *sk=
, sockptr_t optval,
> >       }
> >
> >       if (tx) {
> [ ... ]
> > +             } else if (update && ctx->tx_conf =3D=3D TLS_HW) {
> > +                     /* HW rekey failed - return the actual error.
> > +                      * Cannot fall back to SW for an existing HW conn=
ection.
> > +                      */
> >                       goto err_crypto_info;
>
> When hardware rekey fails on an existing TLS_HW TX connection, the code
> returns an error rather than degrading to software mode. The same pattern
> appears for RX:
>
> [ ... ]
> > +             } else if (update && ctx->rx_conf =3D=3D TLS_HW) {
> > +                     /* HW rekey failed - return the actual error.
> > +                      * Cannot fall back to SW for an existing HW conn=
ection.
> > +                      */
> >                       goto err_crypto_info;
>
> The comments explicitly state "Cannot fall back to SW for an existing HW
> connection." This contradicts the commit message's claim of graceful
> degradation.
>
> Could the commit message be updated to accurately describe the error
> handling behavior? This inconsistency was noted by Sabrina Dubroca during
> review of v7, and remains in v8:
> https://lore.kernel.org/netdev/aZxm8hSrVMkEIc2O@krikkit/
>
> Additionally, the commit message style may be worth reviewing. Sabrina
> suggested looking through git log for net/ to match the typical commit
> message format used in the networking subsystem.

I will modify the commit message.
"When tls_dev_add() fails during hardware rekey, the connection
gracefully degrades to software encryption / decryption while
maintaining TLS_HW configuration."

