Return-Path: <netdev+bounces-271634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPpfKlcKxGk+vgQAu9opvQ
	(envelope-from <netdev+bounces-271634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:16:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2F2328CF4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4DB73233E53
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B433E4C8B;
	Wed, 25 Mar 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE8Cqive"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3A30E85B
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453802; cv=pass; b=BsqpqOmKGJdGLS8yhJKp/Hu6eRbG/xi7jEKRPgrpzxE5DI/DuSiwZRjEs8XGesI68DGvJeJLk9KPB1jjddelg8OBrFMbo7ZBlHY2Mmab17PFLNQbGPRMa5k+ppHULQlENCFPLP0WbWo9Me9+BYgX6YmCgIEaiDxf67y1jskQWyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453802; c=relaxed/simple;
	bh=1Fp+vu62d7+GgDhpjAEu59FtZICCeLh/0ubMdeGXaXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s98gPPFj7hS29wCoEcX1Z7OFhLjjNe2qTxd5IwWUMeTJMxUTPTLSC/XVTSOsSpuHxULZzUdsN7UTR59uvwzhjVWxOUIqAUSSNB+HfbcFaKxSxlluMHxesdIcbNY5o7AN03ilC3n5qIw/ttPGrcweM4fDTBDGAwGWVQI1PI3GDdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE8Cqive; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5674d8be45eso34204e0c.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 08:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774453800; cv=none;
        d=google.com; s=arc-20240605;
        b=UlMedHjHgak4nRToO6FhiNxEwjuLJ6RqgOPOYBw/ksUVRbVOa8vu0XYTjPKctm4WtB
         VlshUki2hdtq98+mQsH9MCy1y3z5YxpN88Sw1L8aEj0YtlyG3we7oaDnlfmqFTcrQLjy
         CM49+reyKJO+xfvpvGZJVcQc11MCNu33bGTDiQbShn6geAemzlQlrTmrWIqbkMYONRDs
         7yTBeTm9GAHGenqYYjMg/SuJEI4amhV4V51do7rYFmJ4jO3VNArOvPhz2O/UHgYvjbJD
         3honNNYZHc3/SwrCWF9InB3u3HYa+C4EekHdWidlVJA8fOlh+UbxN879bdmRFMShLyTQ
         jCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4YyME46GpG0Gw1RKEMDOpkpe2Kju1Ab9MRx6y7uJH+s=;
        fh=GeOh6DKFKd3i3DMMPXniqr0vkZcItSELN4lhqon1jMQ=;
        b=SDgdwe3FKo92lV5ss6LTDN7LqoSniEpRPSNq9k4IGZRR8nlGykXAvnG4dPoMcfi7wj
         YShyNabplpi5ivUOUGAllWGLjsO+6KTczcm+owk2X69HBNcCbDEAUVcZBxZtVqdyK0T0
         +scdwhVbCwVBi+Ee0lJeIiJAf3VKywr5Za5uhr93ghzJPug1CB9fcOs9o75O1wnonJz6
         3+81jlS0WSvCCo1wCaPE2Anv2nlVXZ0Clw7jIFt/l4I9yu/lCWRK9Bb+HitncH1k3F9c
         fUSxSi17c/I/A5DPX6uN6zNFY/1ML8ztDFKZwsDtJEtOfBuUrCRWhlGcC1GcZr7wiLdq
         SEWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774453800; x=1775058600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YyME46GpG0Gw1RKEMDOpkpe2Kju1Ab9MRx6y7uJH+s=;
        b=WE8CqiveS2f9yxvxek8zFPMlu1+i6ro0LInBOuhLyzu76QvTxri3ZqSaQ9Y2Xe5Jsa
         kvShTOJqz0cgXnMfHa8VMIePVTI5G4+9gN8o+fba6wFEjbi1nkQ4ZZ5aKZS3cxNMKkPv
         wjeLJchu5xt0w2HnGe+Np39Leu2byrEURgllqLmJ/JS8DOSPLEue6AzyB2WjoBzF7zNJ
         Ix1w0bNMnVtj4PbLg+gOQ43Gx0E6r4mBkUi9A4ULNDbicb/HUaEzRRikNrSWhkZVRpQ4
         Yyh61cF0/oQ2zXU6Rrg/4BYdkCf77/V+o6OcEoLG5hKdsnRrBydiaId2qvB0Zf77s4AH
         LU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453800; x=1775058600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4YyME46GpG0Gw1RKEMDOpkpe2Kju1Ab9MRx6y7uJH+s=;
        b=PJnAzA+a6JVMqnzuKNud6BsIkcRequXCkBfUXAvCHlQSJdJ5McELbCmDw6cOV0m2Ea
         6YJmBKtRGfS6jabhlGkb2KjxEkejjrJa5TBOVbfzedoDQM1q9E205HfJYCIIAz2WcUdz
         w0pmIMlGzJhv1A/j3Bl4Sg7jRvud0Uj2Qh3u8Xv68C7VFx8drmfWkHhZyhiXDJHsgWNR
         Tvo/S/pLoQ2j5Pu5g3hGl4z6oURRTiIwjiwtJWgJX5ILCS0DFJ0bQ89rQv//b7YYxCtL
         PF+116Yex2mwjpkosFtS95q2y3ifJ1wZEyPpU+JkIdj0GW3tBYoWhmQTVss4IrzLK/BZ
         zMcw==
X-Forwarded-Encrypted: i=1; AJvYcCX7LWny9r0q2i3TpQ3iweUC9KBuoS8WJxey/AjaTkPL4t9A3bM3I5Vu+CzI/PhJ+WdUxpQ/u8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/H0L4EQobXaPV0HQcDU17rCkAwMXK5JXv7iB7Y+7V3RRnbHC
	oa9BM+TRKL10IFTw8rLvmmh5/Hcp4AfGjCQoLdqQQScA9xVD2aWgqnqpEcrQfVi8gOhGWkZhjXL
	y1SZSEgozuGxfhWBJAr9ZFCVfuppBwgQ=
X-Gm-Gg: ATEYQzz2/Nq29fn3kR+0BLqJX41o9LITk+qT6TOmKbCjW049oYOtto8qGw+pbDPnoTl
	L2zqQIYY8B/1mSMRf/0F37JHlOvqvoNd89JY6SqhRGY0ltww9k6IPpHOVFWfnsO0+T+tFFEv/fW
	xBOUsW01tT423T/757EQrhdaNuwIdX10aBa/s2zyXwu8/475BGZE03pbmuoszwAXJDFvLmX0mor
	+SvmlcOl3lfaGu/tDRyy1AsPS8QnwWNUlTLO28iw1dgyVrmhaeimtC/MHKE8ivab12n07lfk+M6
	Q0SsMy0=
X-Received: by 2002:a05:6102:6cc:b0:5ff:bd9d:b1f8 with SMTP id
 ada2fe7eead31-6037904bf43mr1717003137.9.1774453799647; Wed, 25 Mar 2026
 08:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321141510.68214-1-seanwascoding@gmail.com>
 <20260321141510.68214-2-seanwascoding@gmail.com> <e3702d11-2157-46bb-b6aa-0ab60b51eecf@oracle.com>
In-Reply-To: <e3702d11-2157-46bb-b6aa-0ab60b51eecf@oracle.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Wed, 25 Mar 2026 23:49:47 +0800
X-Gm-Features: AQROBzCswDx5a73paus1YHqMqijxhn4uV_LUOu8mN6APcMZNUZeywNxTGqTTlLU
Message-ID: <CAAb=EJV9-v4OsYeaQQH2ycDUCSx3VP2M2ji16xAzO3gT9OuzpA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] sunrpc: Fix dprintk type mismatch using do-while(0)
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Andrew Lunn <andrew@lunn.ch>, David Laight <david.laight.linux@gmail.com>, 
	Anna Schumaker <anna@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,kernel.org,intel.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 0A2F2328CF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:38=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 3/21/26 10:15 AM, Sean Chang wrote:
> > Following David Laight's suggestion, simplify the macro definitions by =
removing
> > the unnecessary 'fmt' argument and using no_printk(VA_ARGS) directly.
>
> Generally we prefer a commit message to open with an explanation of why
> the change is needed. Your first paragraph instead opens with what was
> done ("Following David Laight's suggestion, simplify ...") rather than
> why the change is necessary. The Sparse warning motivation is buried in
> the second paragraph. Consider leading with a problem statement in this
> and subsequent patches in this series.
>
>
> > To resolve a Sparse warning (void vs int mismatch) when dfprintk is use=
d in
> > conditional statements, wrap the non-debug definition in a do-while(0) =
block.
> > This ensures the macro always evaluates to a void expression.
>
> The non-debug definitions in the diff below are:
>
> > -# define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
> > -# define dfprintk_rcu(fac, fmt, ...)    no_printk(fmt, ##__VA_ARGS__)
> > +# define dfprintk(fac, ...)             no_printk(__VA_ARGS__)
> > +# define dfprintk_rcu(fac, ...) no_printk(__VA_ARGS__)
>
> These are not wrapped in do { ... } while (0), and no_printk()
> evaluates to int (0), not void. The do-while(0) wrapping that
> was discussed on the list and fixes the Sparse warning appears
> to be in a later patch in this series (the nfs_errorf
> refactoring), not in this one.
>
> Should the commit message second paragraph be removed or revised
> to reflect what this patch actually does?
>

Hi Chuck,
I notice that the commit messages are wrong because the current situation
is not the same as when I first sent it, so I will fix this message to the
correct one.

It may be like:
When RPC debugging is enabled, the dfprintk macros include redundant
else-branches that call no_printk(). Since no_printk() is a no-op
designed specifically for compile-time type checking, it is unnecessary
to invoke it explicitly when the ifdebug(fac) condition is not met
within a debug-enabled build.

Drop the explicit 'fmt' argument to allow the compiler to handle all
arguments directly through __VA_ARGS__. Since no_printk()
internally performs the same format string validation, passing the
entire argument list is more efficient and reduces macro complexity.

Best Regards,
Sean

