Return-Path: <netdev+bounces-260625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDtXAdbsnWncSgQAu9opvQ
	(envelope-from <netdev+bounces-260625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:24:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D0918B538
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8BE33184629
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1A828CF76;
	Tue, 24 Feb 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML0r/wnR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9912773DA
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956589; cv=pass; b=CE7WNEhCRKOZIpLnR7KaBNKqE8dg8SCPfmmtqjYl94RZgaZXo8f990qBhYVv6Q9C4IVeRfof+7n2HsnPduOFVJHz+w6ZJVhH03LU7VU9BQzp0MaH82FTpik+nmsaREaehOASsZ8rcEA3SDve88M9n4+aRIlnh8XUm8OyjknopzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956589; c=relaxed/simple;
	bh=72D2IRlRHtrVJf/yca2HN4NPq1qpvKc7aUcAN06I89U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeculHfC/2TVQaS/wQAizr9VpldcjFcXSDpb2lU1sYBodaBk4ebBxD2jC2/LU3vOy1kiWEMrHFKnf7e61slSLTg2zdfJkyJ4Bsrj38WI6pGkLbg+CUtKMmymoppNDURsh2pcIwNssJ/phIwMFHeTd8czg/v/MnLiTEoNBqOCSRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML0r/wnR; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b884d5c787bso934629666b.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:09:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771956586; cv=none;
        d=google.com; s=arc-20240605;
        b=UGJ4ZeE5dqti0OHJSnFqbJAGIA/8ySedUFvh75tbOKhf3VI7bU8y/1B2jA/YrQc9Y7
         BVriOHs6+3zbCnReJsSUKgcQsiX3KuyC3adtgsiLer4WuhKpZ/JpjAED1Y1V+8bI6Xe7
         yV003KP4wEthl/L0w39UA9zvNlK4tTLwZBNBaINoBF6Yv9MJYJc/a7BZoRDZ2UBuNkk0
         5eYzx7FvGssonsm9bKeD9b31xWM+Z8w6HxI4Kz/dUdeG6jBDM20W7De2flZy8rraIt1h
         9aMvmVRXSB3t3xRuRzJBM6loe2v2ZtC4SF+72Id7RSYcr+YYqpRb55SKkm7NIdUmu+RV
         QzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DwhhyosjVD4ndU/41J5291rb2sLwQ4pJdLpkSEJUFrk=;
        fh=Vpg/vf+wtbultZ8U2RAXJC4K6mwsyuX685FeflveYUM=;
        b=Pj74b9gyQC7TMjlwTYAeCUogd5gndUurPp5i5acoOs/qCnVrbsxTXvkSD1qOyou7ee
         gFx5v7Q7VUez7n8vLXYKheJOszgc8yrfKnVGJEsG+qSd1QMrR3o6lCECBClziPJ/FUxI
         dXkj0DHkOzrA2sR7OxrDVa3dPLNnZU0obtTQQa/OtM+fqrD5tptlGtwua8kOh/8J+SEA
         nRY3/bDNkOdE9LBNpbeQEbWbPZhgNJJvaH3RwgEGz18hQtH+p+fbprvuwdLHpGoIMx4Q
         yhAx6qFC/nbai9W9BxwqzP5O9dH/I8DMAea2zkrP+73Uu9StsURS3Y8++a1WVAVrs3S9
         5e2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771956586; x=1772561386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwhhyosjVD4ndU/41J5291rb2sLwQ4pJdLpkSEJUFrk=;
        b=ML0r/wnRdbQ9Bf7az4Dni+fk3RMOXaxHDV0YQMFmDR3GdWDwbei/CfTWKPMR99fw+w
         HkaACGcw/mDcS+UaFb20zO0YsUHTa7+cNfKlAlijp1FI3eySoLm7YaabSOVD0b5Ldgp+
         EwdxcC9OYtAndwfAG/poxApZXZnGEMbfwB9GFVCWeF8t6KluS6VOJA19+pTEgiqjUqsG
         fHamacPbS7uEiJHHDc/83VxGxkclfjAkJZTpvOLkNgxGCPzOPYrf3DNWxZkuAGepmv+8
         Nco5sN8E6QqbsMamiMlGfwJHFmoBoStIrFjqOMMYxkoK4QUaY2+FaWEEqH4MdLgWL2i4
         Bzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771956586; x=1772561386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwhhyosjVD4ndU/41J5291rb2sLwQ4pJdLpkSEJUFrk=;
        b=vrccL2/HGCLtFlXMdNYbJuRapD0DpMi+Z1T8mriNiR/EWd0M9iDI2tZl2zRdwkddKG
         qaGi+3AgqtxPReDV/bNKS3kdhH5HDXAyUh0e74BdRs4dh3hcuAPbChYM0PzxywxJdgNw
         0MFwpCCP0Zj9Z94QhUe9E1aojkHepLfnxmIpklPhmrzIrI+VCLmhHuZj+Dzht/rkwrRq
         5eiIFAaDK+qdgohxJ7Sks93R7wXtVLNQE1hZLb3uOfzEB+txpMfUWlTDsIqbwja8czI1
         Mk2dTmCWrexS16HGrtUOz8r7abh5kwoA75JZ419h2Rty+4Z/zaWpho0y2brv///k11wx
         VvSw==
X-Forwarded-Encrypted: i=1; AJvYcCUmXMEdhhNMQMWz9Bu7OBcw+UCtxtRk5ApZpUbVdfs8X10oTtYbnBJ2FQN0P7lphx3JtEGJ3O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYvwgzWqqF6/01g0Ai/wtOFlGYfatiY0z30HEKVMkHusA8WS6
	+UKsj2p1ePHqtWpTZnfULIpwNv+GECzhCzoifMtZrvup+cRr7U3LWwSLXFQkN9CEfAf/Lm0i6/l
	hAq3vHxbO3IALZIUjTJpzYXHiF3EYfQg=
X-Gm-Gg: ATEYQzykfR18gCnm0zKoal1df/laXSwZJlyJOhMOnVzi4BY59eZa4lWJL5U5XHKsfJx
	Ajo8WIhPQ7LfCRJfZhOnlBRdqrMcKitRgZS7PN9HcUyJUPMv6eKhccM2eSMkQxicVPCKek2/qGq
	sSzeeG4sWCGXXsScitGz1/9M4tTZoIt4rLi8gyqiXUd2jhRqqgCYlwCO6qDBaHwR6Oh/8/9gS9y
	eZWBid2Rae7k/hw+muTPUi8lyYJbJK2RF7YCgVZDty2KXbzGDKjuwA4bBCY4oLgzIxQkCvWNsnF
	KcRqH3jYfnM4JwbC6w==
X-Received: by 2002:a17:906:ef01:b0:b83:e7e:3732 with SMTP id
 a640c23a62f3a-b9081aee0c2mr808796566b.30.1771956585864; Tue, 24 Feb 2026
 10:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224043211.1747-1-iprintercanon@gmail.com>
 <20260224164926.1760-1-iprintercanon@gmail.com> <20260224164926.1760-3-iprintercanon@gmail.com>
 <CAC62b0xq8vg4njbcvR9JLvW+o--UnNHEGNVz-+Uxa90d16j80A@mail.gmail.com> <CANiq72kRoHsLx7GSrRq-OP-mz6Y9nru8UMp4dcvdmNJasGZcuw@mail.gmail.com>
In-Reply-To: <CANiq72kRoHsLx7GSrRq-OP-mz6Y9nru8UMp4dcvdmNJasGZcuw@mail.gmail.com>
From: =?UTF-8?B?0J/RgNC40L3RgtC10YAg0J/RgNC40L3RgtC10YDQvtCy?= <iprintercanon@gmail.com>
Date: Tue, 24 Feb 2026 21:09:33 +0300
X-Gm-Features: AaiRm51yLIJu63S23WXp4dcFyGPrhx0kg1nd_drGzlMBBO8red5rQc3PvZCIvos
Message-ID: <CAC62b0zututE+NYNwVWqR4nXh=UoPddA1ya8TJMsT3LqQUXASQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: phy: add Rust reference driver for ET1011C
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260625-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iprintercanon@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,umich.edu,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zulipchat.com:url,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 92D0918B538
X-Rspamd-Action: no action

 Thank you, Miguel! I appreciate the encouragement and the pointers.

  I'll look into the Nova and Panfrost/Tyr task lists, and check the
  Zulip threads for open work. The suggestion about unsupported hardware
  is a good one -- I'll look for something that could use a new Rust
  driver.

  I'll also start reviewing patches in the areas I'm interested in.
  That seems like a good way to learn and contribute at the same time.

  Thanks again for taking the time to reply.

  Artem

=D0=B2=D1=82, 24 =D1=84=D0=B5=D0=B2=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 20:5=
4, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>:
>
> On Tue, Feb 24, 2026 at 6:04=E2=80=AFPM =D0=9F=D1=80=D0=B8=D0=BD=D1=82=D0=
=B5=D1=80 =D0=9F=D1=80=D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=BE=D0=B2
> <iprintercanon@gmail.com> wrote:
> >
> > Thank you for the feedback, Miguel. You raise a fair point.
> >
> >   Honestly, the new abstraction here (speed() getter) is quite minor --
> >   it just reads a struct field. The driver itself doesn't bootstrap
> >   anything significant beyond what ax88796b_rust already covers.
> >
> >   I'm looking to contribute to Rust in the kernel and started with PHY
> >   drivers because the abstraction is well established. But I understand
> >   now that duplicating C drivers isn't the goal.
> >
> >   Could you point me toward areas where Rust work would be most
> >   valuable? I'm happy to work on new abstractions or drivers that
> >   actually need bootstrapping, rather than adding another reference
> >   driver to an area that's already covered.
>
> To clarify, if the netdev maintainers want to have more reference
> drivers, it is up to them, i.e. please do not feel discouraged by what
> I said. :) I just thought I should mention it in case there was some
> confusion.
>
> Regarding new drivers, if you want to work around networking, then
> probably the maintainers can tell you what is needed. In general, I
> would suggest looking for hardware that is unsupported currently --
> that is usually way easier to justify and land, and there is no
> concern about duplication (and possibly arch support is not a worry
> too, since there is no other driver anyway).
>
> Regarding new abstractions or other kinds of work, you may want to
> look into existing driver's lists like:
>
>   - https://docs.kernel.org/next/gpu/nova/core/todo.html
>   - https://gitlab.freedesktop.org/panfrost/linux/-/issues/?label_name%5B=
%5D=3Dtyr
>
> We have also threads in Zulip about looking for things to work on --
> in case you haven't seen them, you may want to take a look at e.g.
>
>   https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/=
Looking.20for.20open.20issue
>
> Finally, you probably know this, but you can always help not just by
> writing code, but by reviewing patches and testing them -- that is
> very needed, gets you credit in the Git log, and by doing so you will
> likely realize what other things you could work on around the same
> areas you start to review.
>
> I hope that helps!
>
> Cheers,
> Miguel

