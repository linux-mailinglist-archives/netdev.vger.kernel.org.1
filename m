Return-Path: <netdev+bounces-303797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2DlRMTViRWrV/AoAu9opvQ
	(envelope-from <netdev+bounces-303797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 20:53:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D3A6F0BB2
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 20:53:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="C+FhZm/s";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303797-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303797-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C7103037961
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 18:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410B3A4F3E;
	Wed,  1 Jul 2026 18:53:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E639F19F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 18:53:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932011; cv=pass; b=oY7SboiBHahlPA6PPC/DfzMdZdeYdVvCPgFE6kiwIY9gXgJp71F+OhkJGzPuQKbFXehrjAWSH1RhCIWWq4xoLi72VGBrrTMUkmWmYSd6JKlaVetmhZTJJP1uTYpVnrd/fhDnm+dlpeO4E2kgfAETa+YSDqMW6LLtMH0BrHtl/YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932011; c=relaxed/simple;
	bh=H/aIKbCL+2IFonNeWBah0r+NuQqayuH9uK7OeGzGDhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKp1uECYRcL9D6WAdEZRWhoIz4iwWPRKoTmQAkEl9uCKEwxv89wXDh+pT1c5/0j9L5t9eevj9T2wrBZuetFfunvMC2zcaW+kxSXjYTfW85bSdSAQm4Mk11MYH318bsd2d0UJJu3THK6BXVAwVCPcJG45QJScgTWZ4XI5Y+rav+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+FhZm/s; arc=pass smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493bed621acso83795e9.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 11:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782932008; cv=none;
        d=google.com; s=arc-20260327;
        b=sZHpsXctZ7LjMj/RCuZ1QRFKanhqTJkQM8l/QeO8kJOjhcugVqVJFf0K6te3lY5qWU
         V/CwsoKiJaIeF6YfFj/69qhWB0z3iAfeDYDel38x/HBXnB8glInF1EVqrIRSR1fBawJU
         HjeRz25tGjFWNIuCwsCaFobQ1xlvbfouuDSu2+Y7G30XbEUb9p1RySAEdb5SZC4WWE+f
         Y5/rN+S/0SLMbMRA0JqLxw1H7KrOp/6f2LAPJk5+W6J62slRIfaXw9JKcwydmmbtNzsZ
         rgtNzx6pPciP0EsQBnUSMyUqtJCUUrGb9pOTlWVowzHhzLa6RkFiacUAIWYmf2CBGHCN
         fS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H/aIKbCL+2IFonNeWBah0r+NuQqayuH9uK7OeGzGDhE=;
        fh=c+MToWmRe1cLc4ZCRXxzN3oOkTb3MiE8Ix3C/w8mXv0=;
        b=Hcx9TqKprd0AsyPOtiMDUipEfGS8xgopYaUiGq1xLzYyXM2W+Ie/8me8eEOmXOSXNL
         T1LFkLcH7eEVxGVmxMLbTKCXvcljdM10kn1UsrI9wZ1gCY9uICMMUBl7mSSwNQlH08nX
         TqIFDLbXrwqfPge3sYPlkzlFBPs4IfXun033plQUTG8miCuntKp4quNeVV0ryLETKBa/
         KpA7JQ5BCKdhPIDQ2z5EZKLnK3ldqOth/hs1BoRHDxnpgQBBwri5dLgsv7rbn0kzHP/v
         XWKMJszFJJKWF//wdIlxvOt6xRVbLmsaMrp/EVjjQI2mTW1//60VOzONw5WdI94G4TAH
         yDRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782932008; x=1783536808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H/aIKbCL+2IFonNeWBah0r+NuQqayuH9uK7OeGzGDhE=;
        b=C+FhZm/sDu3GUp4bC5TqcMGKjddW8eSQJplmgr3gWh/oA6HT2H3Sbzbd1PdnWx/Ldz
         7kFy9oQtdmlZgXSMz3XbxUv1AlYPe6ApGHQzeV3OMSku2GiY+hLjS0le5Xn2abg0ir4K
         EkURVa95OgERswqcs+CtdezlzPyD3P5DgFopT40L34ASks2HuajkrlhjzPsgQf6eltqg
         mDwHyYFbE57qrhYh0ba6Lo6OZTkMqQBvDFml/Zutls/h5rh064CzabJ2jkx3ndjM7VVi
         QhSNO8rHRx4NMA3YnYQGtIKJu7G9c70QUziBeDuoOxdNu7KAHMgG0gyr9m2Raocbu0m7
         1zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782932008; x=1783536808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/aIKbCL+2IFonNeWBah0r+NuQqayuH9uK7OeGzGDhE=;
        b=d8Hb8WDpTq37b2eZweMRyI0z0oOUjMh4CQSQz8xfGvjNEh1yoGlGkwk4F40Sfox6/Q
         qWgg77bMvnlAzNCHS5j84l7xBdza/BOhMwgi4mT597FMztfBSnKo6M7df7uA8rcLYbcd
         /GonaIPV6MtDjge5a5Hh+/sgRANQB15QKyutLd9dk8J+xUAXyez94X8ARrGArUs4jcV9
         sY61XANjgHx7F9EwkeWTVRBVRpvt+l0/PhtA4aqtP9XAB7+okeFyDo+wNayBp04APOA5
         W8tYmB3akhugPKwveeNivL3AaujheyaR9nFOskjLiCAZHa+Uigqyh8ZPsjNlJAnYLGNy
         s12w==
X-Forwarded-Encrypted: i=1; AFNElJ89l9IP3yedVX8LK4jKfET3XynAftomZx/YyEVipQR++2wcIapQw+D/9a04CNVI0v7sg0r2Tw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPfnJRwFYWK5m7vQIqIz83eIglanbAIvaQ36TTIuK/MZjbAQH
	IU4/tyvP236I9NUp0wIrTl65cRaIQhP9OxktgVrVXShlnXUug+4SWLxplwTsKhxe1HQS3DH7rQF
	xt4Rzm9dUppkXDf3cIPvB4qHnNcY9qFqjKAP08dQqZIamtnGgr97T4QRNrzY=
X-Gm-Gg: AfdE7clenZSJps9qM1xqKQ3fxRj9BkWdu2bjkUYXuJUgWWyHGz0aWZyZVQuUyUtWpAg
	lBEzbd4eizxaINTFx7DJWwq0wWuv7fG7UiL9ritc3Io3aMOMVWlDxi8BwgerhpbR/15WnVV8sIf
	sJyTSZFQVf3uMdyGEcfoA984oXGuZW/YEE5rj0gxHHCZC+iv2D/fvQ7ZboPuhtFKDm9ZJXb7jMg
	ZcA1VwGg8+cLqXXARqnaFJmcV8lcHE0BGIKKSULjtQSNCCzUEiq3SQSTC6qRAnNb2DPvGJFJYnS
	gc5vByiFe7cN5NXpNyQAX/sW8PdCww==
X-Received: by 2002:a05:600c:4c23:b0:493:b169:784d with SMTP id
 5b1f17b1804b1-493c0bca5fdmr869295e9.8.1782932007620; Wed, 01 Jul 2026
 11:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625181557.1086105-1-tjmercier@google.com> <20260626180941.45158025@kernel.org>
In-Reply-To: <20260626180941.45158025@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 1 Jul 2026 11:53:15 -0700
X-Gm-Features: AVVi8CdF5Yb3z_aT9Z2kMSch_xL019u4GW2x7IgXTq3gEFLOWfvUzwhUO6mpfb4
Message-ID: <CABdmKX2oG9m316hiJpSXbujrT3vgE5hUpzH_WHfjNxBJ1_+BdA@mail.gmail.com>
Subject: Re: [PATCH] selftests: Open /dev/udmabuf O_RDONLY
To: Jakub Kicinski <kuba@kernel.org>
Cc: kraxel@redhat.com, vivek.kasireddy@intel.com, 
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:shuah@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303797-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[tjmercier@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51D3A6F0BB2

On Fri, Jun 26, 2026 at 6:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 25 Jun 2026 11:15:55 -0700 T.J. Mercier wrote:
> > Write permissions on the /dev/udmabuf device file are not required to
> > issue ioctls and allocate udmabufs. Applications should be opening this
> > file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]
> >
> > Remove the write access mode from the drivers/dma-buf/udmabuf.c and
> > drivers/net/hw/ncdevmem.c selftests.
>
> You need to explain "why", too. Why change it if it clearly
> worked for everyone running this test until now.
> --
> pw-bot: cr

Principle of least privilege. Folks use or point to these selftests as
examples, and then wonder why O_RDWR doesn't work on systems where
write permissions are not available on /dev/udmabuf.

