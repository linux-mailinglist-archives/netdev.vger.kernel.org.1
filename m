Return-Path: <netdev+bounces-274124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEfACJknzWlkaQYAu9opvQ
	(envelope-from <netdev+bounces-274124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:11:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7713437BE8A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2D7E3113C40
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66994429813;
	Wed,  1 Apr 2026 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5VIYh7O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD03F7ABF
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051501; cv=pass; b=RPHDA55EGK/bZlrnWnB//OHEzIIAVaiLzzbZFYQOlNCWB4PDzv/HpRPXDgADH5bboGCa9yDWLR7rLJaQ0C/JsycWkJsjIduYOdzk7WQmLX4/PwfAg7Kw0j0JJOee87QzHTCCV3HDlrxpJrFahfHjRxUenlzMBpRN2E4GVS/i2ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051501; c=relaxed/simple;
	bh=MF7SbN7WJwSlpVJFl9jWw3a8r2QCQncqGNIgFOXSg4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvLyZkWhmRqvH8fKHJu6UlVFHJYO3FzLiXxaKGRVueOvDyWWrQJxy1Rv7dBYJbdV44daOamASpd3GaaDVq3llIWRvq4jTlhbEKnCc+IXttGH6cR6NoXqn/CIL9ecA0i8SZtY7ncIENRBQLGIRrzDcZCrU+yjXicxqOMC4SyqrQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5VIYh7O; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso9531548a12.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 06:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775051498; cv=none;
        d=google.com; s=arc-20240605;
        b=Ugvf7oghVX03Ht87vrQzrLwrdBb8AWU+hwowJXP/aIb3VxPOSHQWx9qPGuLXG6Q2sV
         Zio2DlgSJ2PCZwAhn3V4Ui5YNEEsuKj54MuAYFo7dsf5kg6Hp1Q1MrhRrsNI6ojCsksd
         TxY3QxUrB/ptVTATpbtftfrGn/DzPTZH18GK4MIxxrvbvdh4uY2bfm6gADquQj6kJSib
         PQhIVdPF/Rh4VoFjXDBLm2Iub0+ve2iTHRe0cMpEHKZf6bE83HscEOUKQ5P0dAHJqjyT
         poL61sZuumEAthTb2bFUZaXKPVl8Bv8M21rEXVehQRkVnEh5Q1cYo3p4yZQtBMBfbMl0
         mhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MF7SbN7WJwSlpVJFl9jWw3a8r2QCQncqGNIgFOXSg4A=;
        fh=oLlYDEyIkHzC86k8eZl71LtYkWopP9S/rJVFIGhUcio=;
        b=GESt2H+A2jJ6tHbYyAD2HnZA0bzB8M3PYPDxmsR/C/wCYctD/Gb5OQUvmOvyb3PzRR
         Aed4e4N73yTatszDyQjFSklUqzWxuARCH+w56LPxKEnSIr32CPXDNeuyDdjVncN5ThGd
         LRt2DybhxtAJyGjmomR6qEOOBYm6CJBBgBskHOZx609GoKl2CuVuMYzOMZXBN7p/AXOI
         3u+Rq8X+rPiwqCmf+CKDkM8ZosA+0fpvR8sB8SH510AAGvU0VlR3Y6YYe7KDY6lauhI2
         VXTV/0+Mhl0dXEPjsgVOahomFcjnUjTXn50mORdcVSOb7RVlWIb6xKm/ULp1PeTqaVL0
         uKaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775051498; x=1775656298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF7SbN7WJwSlpVJFl9jWw3a8r2QCQncqGNIgFOXSg4A=;
        b=c5VIYh7OOSEZM+w06nirLXqxCV3y60hTQAXrTPdmohSGhAcRidyh/9bLU8ldOUl+6Z
         3WuKYZLYopppBr9X5058idv659nJT8radrcHgbmQI89VAqj3DYLpcuWdJl0W+whTtyms
         p/2aiUvAMpTBLUv6Yg80vzz040Ha+6cWJ4Uyb4gQmyUGJqCF+ABfYcZF6TLqSZytuB6s
         CwNvNQciX7IUqkZSSxYxZoMJ7WuK1ps8QoQB7ulfPh3hG5dCHc5xY0YvtrswsdjMzSCw
         Yszxq6UiLfT3oFlp/f1phs5c/jDg+6MEZCCBtpz/enCzUsvjkeXZCk+7dpiKsrqPQQ8e
         8Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775051498; x=1775656298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MF7SbN7WJwSlpVJFl9jWw3a8r2QCQncqGNIgFOXSg4A=;
        b=WryNWTyEOd4XFK84XzN/jIMPiomtFmVMCXzDUfbQMa17IbFshSgWC+yV4i/aCujL8D
         0x1y1G+4yF5tE6PKiPaOmDC8PXkFGLpHOlfK9TdML9XFvhBGucRZfBsCTosgy0h0S2Jo
         zoK9BjuXfdPyepP7QGQXa/GrzQ/ZjEKrJsK4JYnMJNfrf9IQjFYxDCiTWRTp2i1zl28V
         087DFwfq8JFY65vW8bZl8dL42Zu0sWNUtLAYLb9hRLhQHrgKuU9/47fW3+lgWryeGon1
         4zVnlwpbW4CyVstFPacnv6RFGteUa0ts9lhjNlTX94OpA8BQzcIx+1bk/xrXYCBzWCex
         /N4g==
X-Forwarded-Encrypted: i=1; AJvYcCXJfFwyaE4FqRCCAR+1Pov2N/TyBVSzAr3k9XL/WWtN1HLoQZe0JGfVaRpQVrbp26dZW/xUNaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIEKqLuy70+yXrREisILljJsm1g2AXPJ/r6x/EcglM95UaQWKL
	iR85Ia6U7e/iC3rkxwPmpf71y4w/id1j81zzV0H47psxP/oO9JcVIzrORoeeGdlQU/DJluEiAi9
	0h2/osZU9LXBSSY39hOFNVLLHfaGQs64=
X-Gm-Gg: ATEYQzw6Rkhf+D/dvZNU5w5u4RD5IOUrfn61hnARX3hheDKxWpDLtf5+gfuQ/V8ypUN
	ZbS9+dfymqkPaBswm0rX0OH3JK07Jf/XBzy16itQ2sEoLzzBeae1WDXDroK9KMxciOAOZlDmPH4
	7slfmu6jisUYjGmyZXaTRtSj6PHvfcexT92e5IOOaHgVcN5B5Yneplo+6rPgYkjxVQ0aS7S1LxQ
	rJwyUgvE6AZAgZi/2wSLt9DF3It50PqLDSiBQK9q6HTQKHXPwEQarhG80RpQmy6GmuV8zFk2+Kt
	+IVQzF8L321nyKORfHm2CXiSFvyk3si4DlyJ
X-Received: by 2002:a05:6402:20da:b0:66c:4cf1:efe7 with SMTP id
 4fb4d7f45d1cf-66db539db4dmr1609678a12.26.1775051498125; Wed, 01 Apr 2026
 06:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL_bE8JNzawgr5OX5m+3jnQDHry2XxhQT5=jThW1zDPtUikRYA@mail.gmail.com>
 <CANn89i+XNV-Axy3gDSdVadBaHUYqvxPxJ_OGyZYo8=-EdqRqtA@mail.gmail.com>
In-Reply-To: <CANn89i+XNV-Axy3gDSdVadBaHUYqvxPxJ_OGyZYo8=-EdqRqtA@mail.gmail.com>
From: =?UTF-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Date: Wed, 1 Apr 2026 21:51:27 +0800
X-Gm-Features: AQROBzDucSPzqQj3RMGmrZ_nM9-fhbhI3XkgYQ0F77fkAMeR2YUfOjJ_EBgoTdk
Message-ID: <CAL_bE8L5n3N3+00G6QQDePgzihFy5Qb9e9Lc9knKFoHLVGOhwA@mail.gmail.com>
Subject: Re: [BUG][SECURITY?] ipv6: opt_flen wrap via repeated IPV6_DSTOPTS
 cmsgs triggers skb_under_panic (local DoS)
To: Eric Dumazet <edumazet@google.com>
Cc: security@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274124-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yimingqian591@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 7713437BE8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> OK, but why sending this report twice ?

The email system reported a problem with my email. I assumed it failed
to send, so I resent it. I apologize for the inconvenience.

> Please do not CC security@ to anything you made public on netdev@,
this is not welcomed.

Okay, I'll pay attention to that. I'll standardize my vulnerability
reporting behavior in the future.

On Wed, Apr 1, 2026 at 9:46=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Apr 1, 2026 at 6:19=E2=80=AFAM =E9=92=B1=E4=B8=80=E9=93=AD <yimin=
gqian591@gmail.com> wrote:
> >
> > Hi,
> >
> > I believe I found a locally triggerable kernel bug in the IPv6 sendmsg
> > ancillary-data path that can panic the kernel via `skb_under_panic()`
> > (local DoS).
>
> OK, but why sending this report twice ?
>
> Do you have a patch already, or are you asking one of us to provide it ?
>
> Please do not CC security@ to anything you made public on netdev@,
> this is not welcomed.

