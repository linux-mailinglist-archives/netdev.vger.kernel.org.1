Return-Path: <netdev+bounces-292486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePmYNruLF2o5IwgAu9opvQ
	(envelope-from <netdev+bounces-292486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:26:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCEE5EB39A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1E5C3004C8B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE352175A9C;
	Thu, 28 May 2026 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1Wwxccr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC31175A93
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927990; cv=pass; b=IRCIL/N6k5qNPJ37nRR960Lo/xr2YCmm5MG82MYQPkPqSaW/fIYnXGLBNWbNTFynt0RHPFTLbBB+ICHyISlt4kN4yDtutjeTNDiWlCQi/hVZ80vFO8gO/VQQ0N2CAuO5z8Lw8/0NNLTOIX9xyXF+tc4Gk7/paks1HTLBOzH+0mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927990; c=relaxed/simple;
	bh=+6Ae9AGKSkcDCX4m6ODcC0XnMinUSLOq4eQ1RgIBd6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+aJtK+XukGFKizxNZi6kG0XPYUSDf3pK3sLo5PzPGum7ofphOxy4325nvT50Q7xdp6mgabcM2ePxRYlkWcjSI7yRw64unBBIaWy4YHtkIvQDX0moFRv0iKKEgKv+RF56d5RFca3io8c1IFifTJzkKzreHHUin8MEYNAEEZBMb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1Wwxccr; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-136b46c3540so4988505c88.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779927988; cv=none;
        d=google.com; s=arc-20240605;
        b=jDDpMBycgenMWa33BCSbYgZfHndwvTCI8VLqyRpOWVfx+IjOh2GxP0VwDUlGwDOmZQ
         w+DHnF0Bd/IWba+isjPAnW8z2mxLVtYptX5CQ3jwbFFDh+qg7TsMX/2egTqOULtkFjre
         ArNrqAUl4genChDoL/A4KdW3jNn6s15PdhRqvEKLZ1E/3MRST4Ifhw2IQOcvurCM6Y2i
         R8c9FYMaedrQl7RSaGETHZBbz8WYAw00VEmxt3Mimnhdzb/W+z+QJSK+MZOrTYgPm7CK
         RIFbSv8TChe52yJ0Wf5tDLTGekVtTTJp1dofFJ0C08+uKnm86M5NQADOkXm/iYavT0lx
         Uv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8VQGVVqnuYqJJRTClAJUm29IBH+yFmfVLlQ7PJGpuQg=;
        fh=9iVAB1OVzXmP+1wTpUhm9cW8nMhbFha4nHmtVH1yiK4=;
        b=Y2RWvSbD0puqV66WZbdt2TKLDvizQEpnFj+Hm7hZ5z6j3VhRev+XgN7lMUbKhfCBZM
         pK+9ol+QeEMrzhtKD6d1IEyXjx+2shFe3tPdCO/7DqV+oZxFqKLsN/6V1kapqLcoNI2c
         tV39i7VcoWgwjzniZZ3kCU/QIos2Mh0id0BaKhO/Tn43W/V7r/YcTf3P0n4zyX8zn+Mb
         La3V/vUhLjkfKfwDoGJLCvQ7UlAebDdat9//UThNEVIeIzDs8YRrrR3iUUZMAWwy8isG
         k+zt4jjsmqgiw9BhfFU2/9eu6NLn6TxCRcsBnQaTDXvgK7C3Y8lBYjRpdkGBMW6QL1dc
         aNzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779927988; x=1780532788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VQGVVqnuYqJJRTClAJUm29IBH+yFmfVLlQ7PJGpuQg=;
        b=t1Wwxccr6zwsAF5NQAvFLAOAieLaGbVpTbnuwAPhAyfz8hiMGycj4hMQGqPnLNNB6Q
         GxTGmNxU43fqo7s3RDa4soDn5CKq1aHmAgUbC97Bu0grACl2BBW4sL3KArIKM1DOH/Wu
         BVwgn2IA2u2aEjwHOUwC14LjnwUv4D6+DlMmMMmZp9aBzmgISQUuELZFpiE9Sfk2gMev
         8ONpDNEpdkxm94oQzG5BEqI2N/Ezf60MVmRyjc4BC/Ktemv29proM8BS88by2U41euj1
         DWUZSsFF8q50ctZNDN1RcQUOHEFELvXIGdbg4pH77PXfRIqaAeWMWvpcC61jJae6Ado+
         6Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779927988; x=1780532788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8VQGVVqnuYqJJRTClAJUm29IBH+yFmfVLlQ7PJGpuQg=;
        b=Ny74Obx8H767sNLyHyKQGWuW3cE+Ipl6XnZIPSm4KKjMPmfFHdvbobc9EolUA6XCxv
         lIa4ndSaU2ZyqtdT/h/nGTGrR+qRLBPcbblpFUGcdBdFd6If+0mCYt9xtHknvTtaC+uL
         qa+fsJn+dtkCSIKdHkIyCgKaQG2uZkJccaSpWctcvZAnonJ8+A4G2OO8B4cYXcBdOQeB
         ajMQc/8u+NZa15wxLs7tC78y5FSeyjjoGSKPDxV26D1T3B9bF+HuAomasmuADPvOX5gI
         JuqZ+de5c5H6j/tZCl5UkBwq9i4pIMltCBbvNVW2+b0FRnJr6Hc1YdZThFCEqvMc61xp
         BvEg==
X-Forwarded-Encrypted: i=1; AFNElJ/9bd3GUYOMVrgKaAVPq6UdNlz5KiGYMz1iEYLy7Xz6sV5Dlm+aZ6ShAR2UGHtav1xdHf4zyX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/rE/D5kyb5tRkpp+NMlfDXKyCw6ltRFNVA+8HfzO9UGJ4RkE
	DXv+ehfB5IIdOM0j2jdjicQTza2O6WPMHvRqrvgTmtxF/kx8fwgJCQaewQDDqr6wx+F9UcxW3Y3
	FqOobGgwS6Q0m2fjlvkb6ouC8rUC14eUowokaC4M2
X-Gm-Gg: Acq92OHAP17zQ486mpgION/TepoOrs35elIaZGHfZGza/blYUqi1NWg8cIIXgRF/c9f
	sbxC0qpAGBrlyiBl5W2KRDyOI4ckZtcGQsAAl7H7AkDLlFUiqdVHSvzH5+JH8V3t61YWQlYPtBH
	P7e2tjacUzIJi8909MBPn6WxHTIY7+qAUE4wcBBOk8KnFBH48FOEx1XfRyrSSD8gcXBwSiJ7q3C
	muQp1gnz/m9XScFWyW/rCnYtafNPbzSbrH53vxfvi3T8FP5XoXIFTvowJ4KwiDYtjXepLyMXCxO
	acli9i3jtjxuYYhm/XkUMg8dG1yW3raCZ+7cfPDLE1/l6CGMJ8RjVBPaKXxfD3jkPTsohDyt5ui
	a9mLlxYYHH4t4dU38jGUQMb9uE0I2PQ5cQ7GzkJHWz/iqWpjmtru+Y8BO6hZw
X-Received: by 2002:a05:7022:b9e:b0:12d:ca32:5a7 with SMTP id
 a92af1059eb24-1365f81907cmr8640660c88.10.1779927987620; Wed, 27 May 2026
 17:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526015152.2409183-1-kuniyu@google.com> <20260526015152.2409183-6-kuniyu@google.com>
 <20260527172159.1dfcd042@kernel.org>
In-Reply-To: <20260527172159.1dfcd042@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 May 2026 17:26:16 -0700
X-Gm-Features: AVHnY4KxhI7uCMY-oh6kHGuE3hDfuxvvYdW1Z5_algI7A7eoiAnYV02foW3Rf-8
Message-ID: <CAAVpQUAMPYORuYxwwKXGShjagxmo+ZcnPZXiFZ9B_zUsauY7Zw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 5/5] geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,networkplumber.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292486-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CCCEE5EB39A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 5:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 26 May 2026 01:51:17 +0000 Kuniyuki Iwashima wrote:
> > -     if (data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_REMOTE6]) {
> > +     if ((data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_REMOTE6]) ||
> > +         (data[IFLA_GENEVE_LOCAL] && data[IFLA_GENEVE_LOCAL6]) ||
> > +         (data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_LOCAL6]) ||
> > +         (data[IFLA_GENEVE_REMOTE6] && data[IFLA_GENEVE_LOCAL])) {
>
> nit: Looks like a cartesian product, perhaps:
>
>         if ((data[IFLA_GENEVE_LOCAL] || data[IFLA_GENEVE_REMOTE]) &&
>             (data[IFLA_GENEVE_LOCAL6] || data[IFLA_GENEVE_REMOTE6]))
>
> ? at the very least would be good if the last line also had v4 one the
> left.

This looks better.

>
> But, more importantly - I think the AI reviewers are right,
> please update Documentation/netlink/specs/rt-link.yaml to add these
> new attrs

Ah, I thought the ynl spec didn't cover each driver.
I'll add a few lines.

>
> If you can think of something meaningful / useful in surfacing
> potential bugs maybe also a selftest?

I'll add it once the iproute2 patch is merged.

Thanks !

