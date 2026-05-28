Return-Path: <netdev+bounces-292590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGLkNlf6F2oWXwgAu9opvQ
	(envelope-from <netdev+bounces-292590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:18:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 552A45EE6D0
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 185EF312E239
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EE2360EED;
	Thu, 28 May 2026 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TklTzON3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBC365A11
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955905; cv=pass; b=ExAQhHaah4IaPSSVgosKlcnz+RK4Nq2okqxE18tN8XGJwInAQHLbSz+JUDhWGQ05AoZEKYpk3Cfzi+2L0+70j2L0YBojHhNffIdQdwmgWa0GeWQZeK9BVW9P/QN5ppixU1ZcR2Zxhx4IqRJNszXgZvvXbH2UCvW7MKmfXDneJ7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955905; c=relaxed/simple;
	bh=oBWuhO449n/7oDW8IQocev0pXxI7H22xX2oL46e2KcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENrDv11moVQ1P8U7YJRoqyDsn9SkfN7OC4rmXSTpVZrhilA+yYh3SpgF6NW0sDAnURWKXqUFqSXZ/a/KctAjGjHTXlPQtPqxL3HKib7h9+1740eQocLnhUhJ+cw6HEaKgGns05t4HK7qPTgZKWPi6l0SVhHO+LUlklf5wi1QV/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TklTzON3; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-6312970d9e3so9504186137.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 01:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779955903; cv=none;
        d=google.com; s=arc-20240605;
        b=ZFJ+0F/ChorLWqNXR3LIGgL8dxRYXi20psJs+VPIwYVjgmxuU5oxxeCiBo8LCJ9Prl
         Kezjn4HFgi9QLfG9bAkmNpdatR+ICwdg+3GUcvXYEgElkD5bCcY48LowapsAK8fAk53/
         /u+aolXjewnsJKZcwQEcxHcjj1gNsp/wmh34CdJCRdFVoY1MlyutcouYjDwjlASlteJs
         7N0Q8JHL+rRpnu8Cs406SWkZvorUXFZLJLegKFvzpYbute/GCuWcav+vQPWXqWTzNp5G
         IspCkUIzpBbM25PTKaJrSeLt8Ki0CASB2jAXc4KTjggZx0XUlli4XfbDwoQCSleVHvQj
         f6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2fX8PvmFDzJ6+PjWEtBk6E6XYedyqF6i/1jP9zX4zKQ=;
        fh=YpmF2IbGbYOz3RMWCTE1xTKVBOfLpb0fgwpeUrYLjjA=;
        b=RqbyAP1JQMaBn1G7kBKn00qDe/z1mQ+cRYk5mkppaZLISOWipnrBQ9b/a0972p/DhH
         zGnH90jqfKGGiDhEAWGBNeKuEdJZ2YGfI5rYmHq9AVFMUiKk4HnN8FDPU2RQFFZPjMiz
         SS10dDs7opLbcKn+u8hdh6Z87HKh2uCFmzrtiYR8vtLRVwwQwSSp6ygpqFmK+onHvsyP
         uXOhi2L9IxmeRf9c0bMxj8yV5WGH+MKTkwhw6wukuM3vbv/k02iNpxB4WRi7m2gc/D8w
         ypdIjFExnPsyTGK7pW5z1UM+t/UfuUJfwD7ChqFxzqFgbAV+EeJUQTJrkbOrmaYY+Qpe
         YGTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779955903; x=1780560703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fX8PvmFDzJ6+PjWEtBk6E6XYedyqF6i/1jP9zX4zKQ=;
        b=TklTzON3BXK+gDuivj/OQgWFz3cf27WL8lDWMX4GmD/oMEg7vRBQKom/PJn83eCrgd
         u9UhqzIxtGmYe/4UmrPqZwFPLCmEHj5wdrtIKxqvkcUjiWqpN690PPf3+qB4vi5SS4/i
         53XIwCGJMtbaPaf6+Kd2B6XpCvEH7wk3yyH0RKmZAhzKeUweGWkZuSD0h8P4Iamt8Hdr
         w22SKrbGvO1U7AhbODXGV5LEMXgS3pym2T8gaFhTSYkjjWXBUT+KOcth1+jVQDoH1BsX
         QUBqlBrRSrtTtSTDLFMPfm0NAOwGQD0XeoK6nXGXr4v2WOV3dffFv13JVCQdWL5/vSFs
         gukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779955903; x=1780560703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2fX8PvmFDzJ6+PjWEtBk6E6XYedyqF6i/1jP9zX4zKQ=;
        b=cQoGQvOVxxehFrE5nW175OWhgtFOZwPJeGqdsKnekY3uIy4+qM3Avgu+d6kl6Q3Sdy
         BnvhIrovB5qm4Q+wmPgRg8k+P4n36iWeVHNifVFQ8f5LXdYh7d4fU+YRtHtxnJxO0MTJ
         mM7PICVqgp/Ph3rQeWBP22W8I8KUTTNGYgqPB/w9Y08UtHn6/mXiqlySSFpmyOR81qpl
         hpvOjdZChhXmZfVCPwRYY/RF8l0xYROQ+CAG+XNMcgl4zJ//QBOmKYgigWBjTpM6l+zA
         8Qb0blKO6KMjWZ08ZTy2P0+vAgeMoU8ZcKAKCJh8iHXoeYsPhylA2SsveYgMJd6/6DMM
         i2CQ==
X-Forwarded-Encrypted: i=1; AFNElJ96RypLvgO2GA78qH5XS7WH5GPLQ2ZaHPQVNNHhyGfXPAC3iFDv0ai0nJhTik2owcUyvjrlCDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSSdRd0eQGPxVKQ0nT26ULl+d9i/h5EflS6uGLVzrEn261Pa2n
	NgT8wPzm9WWtz90puSTPp3VUI8uu63xl9h7M/etCuRHZKn4EYH3lq9qhLAkJzO9XKdSUU8bwDTn
	sjKuS5CGprFnAfdRJp+1vO2sD5kHAhZA=
X-Gm-Gg: Acq92OH3WtJZK9UJdC0aChvscDOYhCj7KofWfzB8Iv98WxvNTxswAcFpXRWYk6SyqnT
	+KrQZC3SwZ175eYIGdv8QG5/XULXFeE6RGsCA2yLgB+IlA8hh+Nm0d2tqv3HsXCnuqjcGG0jpUF
	FaIh7QAPeMUSge/hEWumfnEStBNhEwvfTU8xx7v15zCPSZXyB61PDLGJZILnd0kxsDuNBdPvcpA
	mgJoMCfodgVOz0HHLzz9AqgKi8Y9FPAXeq47yS77UCZCK7nbEBZehL80D41EJDBSrZ3xY2k+Hn8
	D+gtNS5kkAz4KPyG+mJnowJ9aBOsXkdcuF0AG+mFuaKwSJpLTXGb
X-Received: by 2002:a05:6102:c07:b0:631:23b4:8dce with SMTP id
 ada2fe7eead31-67c75680787mr14443441137.13.1779955902798; Thu, 28 May 2026
 01:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com> <PR3P194MB1505960E42BBFB9AD9E8B18DEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
 <885A5B11-A34A-4F69-9E9F-ABF10159B789@padl.com>
In-Reply-To: <885A5B11-A34A-4F69-9E9F-ABF10159B789@padl.com>
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Date: Thu, 28 May 2026 10:11:30 +0200
X-Gm-Features: AVHnY4LxbTQIEAlETlZseiMWXHdXXQwaXiOewN7yelpX4pMD-BSnkr-KP0A2qW4
Message-ID: <CABvLYuA85b1X9wHH073HPX=xv_1uZ2+anhcr+3MMkoVF-3DVcA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
To: Luke Howard <lukeh@padl.com>
Cc: Cedric Jehasse <cedric.jehasse@luminex.be>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kieran Tyrrell <kieran@sienda.com>, 
	Max Hunter <max@huntershome.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292590-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,sienda.com,huntershome.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,padl.com:email]
X-Rspamd-Queue-Id: 552A45EE6D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 2:17=E2=80=AFAM Luke Howard <lukeh@padl.com> wrote:

> This actually makes more sense also now that you pointed out that AVB mod=
e is set on the ingress, not egress, port: configuring CBS should stay out =
of setting any of the AVB mode bits. Are you planning to submit a MQPRIO pa=
tch? If not, shall I just wait for your CBS patch to land, and then rebase =
my AVB patch series on top of net-next?

No, I don't have changes to support MQPRIO in the driver.  I use the
default FPri/Qpri mappings at the moment.

>
> We have different use cases: yours (as I understand it) is host-initiated=
 traffic with as many queues as the hardware supports, and mine is hardware=
 offloaded AVB switching with (essentially) three TCs (one queue per AVB TC=
). It would be great to find a solution that can support both.

My use case is both: forwarding AVB traffic by the switch, but also
sending traffic from the host at a certain priority.

Cedric

