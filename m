Return-Path: <netdev+bounces-307287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OhCpDqZaVWoinQAAu9opvQ
	(envelope-from <netdev+bounces-307287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:37:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C553574F4CA
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:37:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=ILr8ar2C;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307287-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307287-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D21E3032654
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555835F185;
	Mon, 13 Jul 2026 21:33:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E00350D7D
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:33:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978437; cv=pass; b=Q1GYiHtV7IDJ6HBDvKZTcp3JElV1ZMZjZ1rSFqZuVSbk6KDYTcOzCwOZ7vZ8JABNRqimFE+faYVnbgKLEf7KgwUKSWwg/UyfSKSjOb5cUCPu3hAPz8K3vB2oIOzYB2bOKz/qVmgl2GZ/KsTUjOXnACkpUAXEpUOMMGtd6DFQrr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978437; c=relaxed/simple;
	bh=ar9W89D4Ih0LFa4BPdqkCf8t2Kg9okLoqOOiffiJC1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhYME8kl8TOugbgUZVnW4l4nAPeqnQWtqyWRi9VztNwfNnCHFvWFIb2DMlbVZexSxVg5taSR8P3k7uGiO8nLXdC3Zc+SLmeLjWFfK2gOWRrUotQfNjDGiQctf4wKznGIFV5fcn5wXCwwxBMlkXDj2KiWjC1Fv7y+THRGBBD5Ij4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ILr8ar2C; arc=pass smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1214387a91.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783978435; cv=none;
        d=google.com; s=arc-20260327;
        b=BaZYRnnhgTmimDj3WljcqLjCvXpgOrhrR13oVFLuu4Ey8WUmQlADMg7svqkwir17WH
         Reuc0SZ7wfcn5J93JCdfhPmQ6H4BKerp5YSd1qCNfzFzdoKUnaI6s1bekBOcA72TXYNE
         M9YlJ4dHTVag+NUs1TU/vqCLva+RfbY1rVLTVzMiq2/qouStR3qbDFN4gn3TbVwu6CJe
         nAwh7BKHXkdL0IIY6lvzUOHB66achlrfoRvWAXbLhhtuBF77uRpopM477rq0YeFYgUBV
         TGLuWs9+4uJOqXaw0c0RZk/Ezz2kvpQE8k9f7gYbHR6oH1s/TmQjDxyStrjLYu1sZSzW
         /+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iezwh3ME7S217GUTr7unthJmQNFJnH6e1rXTj1TNmsQ=;
        fh=DzpHLtOhV/NIXfIYZYnkvoBmTBSMRvB2S4wy4VlcQAw=;
        b=oGotpDy3T97auX1rKGbt8bype4A4cfPMIDlG19+2s6b5VT2gtZylb+ZzQHSJRNoHgP
         O4mWXRfWdH6qhUbKQsem9bvoFbEs0fxAGzDLe/liIA7I5io7JxU4OHcYeSrnEnxSJYci
         FPUJCZCo6UXOCJyfFg3z1YqMvc6kNAH5Cl+AuZDw0jbSoF/HpmNTNjo7vlazWXEAPZyc
         vAlUW+yAVTnAUQzRWycTCUI4pr2lgI+6w4VzA0HcpWbBnP43TfYH3DaQANS9rAdwDp+u
         pHwAi7WhQtoAcBjoJrjeMEEB+iz0m2CmViAr91E+ihpRNcbU14ocXWtfxmriAvWdywvL
         tzOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783978435; x=1784583235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iezwh3ME7S217GUTr7unthJmQNFJnH6e1rXTj1TNmsQ=;
        b=ILr8ar2CP6p3UrUSfiW9KBumpyCKw03jE9qq7xaWiv1DA8lFDTSLcPGuw1tN9SLFqu
         HQsVzVn5atjaBRzdZgE4+EfmHkBHR4xXspgxLv/v7lYrwMSLKmN1Y3uxsTy8BxCe07Ug
         IJfPdwnIjWzPqW0HhM/DGVkvcX7rwIHZPa7F5GxVQztDUdR8wmPOm+ht5uTVS3JxYz5q
         n57Tq0QVwsysNjXghgVNOpCleOUcv58ZpUqI0nbm7rZNfbaoZRVt/mRwHYePFdBZIYwM
         9Cq7VolP5kzZ5SZ4+ADokR9YSw2sslURcQufY90/kcvgWPbPn9h1loR9sms4uMudSGX1
         b+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978435; x=1784583235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iezwh3ME7S217GUTr7unthJmQNFJnH6e1rXTj1TNmsQ=;
        b=cuMC72h7LZNsyJkvbScSOPtI6x5Ce+5/sQpiOkvOTx2oGLc5+Rk/yQlkM1oeyuZhkY
         I0xaA9NT7CrkqBf5Lv7Id0XUmEuf7NNqY+nefUysTSIngKzkPeNeeOrwzZ+LQ1Q9J6Gs
         3ifQd79tCQH8QabvJE9IDS7sk3j5rSv3gsWHSUuyY9Ndu7M9LwZ9EVR/CHQTSpPu//y8
         1sEq7OiDtXHFYz19TYfzAvpolF+SuXesKGDpiYnIvZmwNhyMqtVbFnCiPxCihstORARA
         S2tNZQVLhCWH8O+R1kb5tmej5VbEB/hLEIhfTF5zqzU7ReTWSoCZ14G65N5nBfKdV4YX
         HwOg==
X-Forwarded-Encrypted: i=1; AHgh+Rooi7hR9lnPLn1hjRZq3Yv+wLr9DC/308p71ZZBTXVlKyhn2m1CD6hy+SnjPeywDOw9NRZjGBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYAC0xv6BkQU0wtGJKo1CzlzPjjoYvU8nEOWD05tZ/ikInijN/
	USY8nhUx3hmdfDdhGIZgyZ1AFG40PWjOQTnwKYLrs6U0AC/RKJymRoY+vE1bg9GXlLpv08EiepL
	8fhTSxL1PvxFd/D8cs64gEV1zaoUKJEswtmyUDphk
X-Gm-Gg: AfdE7ckTjc2kP+Ub2Bb7YBDluwtPfxMHLFG4JUM+KXvu/8TSruWlQdQ0qNQ+pe9czLc
	kxdm81XFfee0x4NvIBUAnTLDW+Szvp7tWUgpL2hdlpb3FReysNrdBL9uwXPtSKqtcSdI1sVyAFm
	svxI30yazXVd2zsOgn4o/gbXUBEj+GUKDNl7qPTBgGciq1Hm9+hFpY28NQIbG4breXeblsdODJJ
	Q6pJnxM0DIDKnKyajGGt14A/kRMCKEGZO014C+8i6FvJCoB46jOk0FqlyOb9ItO2cwzr6Ptum5Y
	M1+J1RTfkNw506PwrQltM1hedoTHML++8MJO+TM54frCnZa0
X-Received: by 2002:a17:90b:5112:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-38e17d96405mr594631a91.6.1783978435335; Mon, 13 Jul 2026
 14:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713183614.2975972-1-xmei5@asu.edu> <alVUka8INN918W0K@chamomile>
In-Reply-To: <alVUka8INN918W0K@chamomile>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 13 Jul 2026 14:33:44 -0700
X-Gm-Features: AVVi8CfWIx0IdHw9ndeEiFA6ywDR0d_SyV2cDqSjXU8pv4s3O00HljjD2IZSQ4c
Message-ID: <CAPpSM+S6+Wu+FJn=Pob4rmOKOGUggUdKHB+pJxfueGxNv5KnoQ@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: nft_fib: bail out if input device is missing
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-307287-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:from_mime,asu.edu:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C553574F4CA

On Mon, Jul 13, 2026 at 2:11=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> Hi,
>
> On Mon, Jul 13, 2026 at 06:36:14PM +0000, Xiang Mei (Microsoft) wrote:
> > nft_fib_can_skip() dereferences the input device (indev->ifindex, and
> > in->flags via nft_fib_is_loopback()) without a NULL check, assuming the
> > hook switch only admits PRE_ROUTING/INGRESS/LOCAL_IN. But NF_NETDEV_EGR=
ESS
> > =3D=3D NF_INET_LOCAL_IN =3D=3D 1, so a netdev-family base chain on the =
egress hook
> > passes both the switch and nft_fib_validate() (which also keys only on =
the
> > hook number). Egress packets have no input device, so nft_fib_can_skip(=
)
> > dereferences NULL.
>
> By reading your description, does your kernel include this patch?
>
Thanks for pointing this out. I just rechecked my verification script
and found a bug that failed to pull the latest version of nf.
(I wrongly assumed it succeeded and checked on a code-based one month older=
).

Sorry for the false alarm. Nvm about this email; I fixed the issue,
and it won't happen again.

Xiang

> commit d07955dd34ecae17d35d8c7d0a273a3fba653a8c
> Author: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>
> Date:   Mon Jun 29 12:53:11 2026 +0200
>
>     netfilter: nft_fib: reject fib expression on the netdev egress hook
>

