Return-Path: <netdev+bounces-285521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFvSBUQN/WmFXAAAu9opvQ
	(envelope-from <netdev+bounces-285521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:08:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CF04EF940
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F75C300CFDA
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7FA34D90D;
	Thu,  7 May 2026 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5TLNzSX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC12F8EA4
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191681; cv=pass; b=YKxHqTzxHYTq+E6/Nvbj6AcZkEjDsFGKddZZIF16aN072kiZUKiFL1qXzMzix9l6VPUaCf2Wobg7/ImZiqCW/W+gjhAW3NBt2aF0GHmWZs+yVbHzqKof7zRmmY8ScW8h0cKt2uvREGjwgOy5WOg4Dv1yZCySnucb9T+6sZo/aE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191681; c=relaxed/simple;
	bh=2EQbB/2gE5laaQm1xeI0jyT3tP46JjjvnGD6w7SrIoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n63LFyo2fTXUDyWXJM0zvds6s4h8ThPm5/tLWIEDBP8X2TUud5Q0Cr4OlZgZB7HkptQ6kmAXDYKUgBrr9xbAysbJNX5oQbqfTkwtzblL/BsN034iKOkQwsF2qSxyE7360cpfxiI87Gdp/bzuj5cVN/Y1UkzyAF4Eut4tAxuyCX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5TLNzSX; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12713e56abdso946674c88.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778191679; cv=none;
        d=google.com; s=arc-20240605;
        b=FfprQvYTIsCG9R+0KA2+1ziUkCiS7u6LTM8TqbaJhFSLm2Mep5JY8MoXf/iodHxOeT
         zJG2m5uGxXeKfVcuQ+XcEMI1OG36KWX4+fPiD+ecWK5Ygwqx5CiolhkclfNU41b1RcQK
         FXqM0ABsx4D3azQY13Fcc5KCRrdPFkmXPspgp7b0Do676ILNESMY1GqAp5y3RxjZ1+Wi
         XRSoq3Ddu9HNWHp5sofM1oW1U0jJ4Ig0w6dLwaUzCICynglsc+6lkn9TVb8/zffdoIiM
         cxB2VeMJXQMyjFuYwJBfpLqQrfScMljgs+yeMCx0w+nJbKftJ0fHW9BdwlcmqqgTxQ+8
         QEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2EQbB/2gE5laaQm1xeI0jyT3tP46JjjvnGD6w7SrIoY=;
        fh=an6fGP2mTOSxK6JW9u/n1JEs3mAbKIP+tXQHP+N0TeE=;
        b=UMwezlRr2rGmXs/pQ3gRh0h1Tj76WF+bGjlpPU8uMZgbrZsILSDuKx6Bm1RTWN2G+5
         BB8hHJr/V7lMRXi0wPoknC/SShZMVqqQupEP2aHeteJsoMSbla7sFrMnNybyMQEMjV/J
         M3UJM93tBy8gmgDwmqe4I1I2/UFlUi6zcVHngfdb2ItnjZw0gmHkie+55w/d+Y7zGw0J
         TzTQ+SyZc8vQWCkxxXFdOD4k1CsXITyvZ4jPmlrZSVi2SWMstE8UjrKTh9CpUP7EWSka
         Mdj8H/ug/gEw7GgSzz2pohNrl1o4RUIWm1LkbILBUUnTGKea97XnuOxzsSqSOdmN4RPj
         HxCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778191679; x=1778796479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2EQbB/2gE5laaQm1xeI0jyT3tP46JjjvnGD6w7SrIoY=;
        b=a5TLNzSX1gvH86R0Pv0IQOWAc2+8w3rmqk+0q1KphuNeIsU/joMeqG/WRzRxnnww/5
         C0me0DXgVbkV1HTA8o4ZiEJMTzHjCchurMsYLEfqlUFoJZfzLpTTwqSk7Zxki2SBnG5l
         BpM6zLmxtc7JeeijAJbkVJHrAw6FFMBabl+8Knu4eLOocOZkWKW0PsSqxcBaByPyY0bS
         eFDA3ZH6OcjMg0K43uEsOTrAjvw9aJerBkKJbchqpSGEr8ydGf9+h3zNvAdZ9yWjVLHS
         6+yaZ/UcNmRdP4jM4yrFZVYq0VUuvRkola25YEK4Cn7u+0Z9MkVIJFTEpFj/oDlfjRCZ
         oL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778191679; x=1778796479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EQbB/2gE5laaQm1xeI0jyT3tP46JjjvnGD6w7SrIoY=;
        b=fCwUFAvfxRZo1oMt16PfzT4/p/7KSNubLGCkNziemyTY/CbNfIQ28tM81L2nIvkpw8
         qmJs9WxvNb0IEK7xS3IW49CzrH87sXTZSjAXOwRw/NLQsDxfHRnU9kaKf9YL1uBNEkId
         5qOADWpWw3lsqZKjbhhSVEcLAHdaHWJCr5Ho0F7xkTyIr1rtIWrUVmal1YBGjTMHWT2N
         P/JiqDft4X0O7XRh4KQeR/TEzZa1xf2jIx3drDnV5goryA2fGwfVRzkpdNlQPmvnnaX0
         zoPdVHgs0pUk0tvmkbb46yoMQmijLGW/RWOdOX9JfbfVRoFKZ/NXdK44wCizDDaZrBcJ
         uBZg==
X-Forwarded-Encrypted: i=1; AFNElJ8w3xxbSKgfzJqeIkRHSE3zPOLk+2mOR9KbIoAGq0KR36Xr6BySOGnkUj1INsxr2kXQbK2p9EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQ77qFrEFchwe4cQ/ClJ0AJaCmsd71KvvrrhSV2/I7LmMb1WI
	xUr83FQqzA/WKYfBuFrCz4HbbowPFAEINLKy53Ib2vwJCb+C36mlsM2KFrI3ehHklaDS+YVYQIS
	TnpVeQxz8dgM3Fv+EJErcvqwtqsZ1hg==
X-Gm-Gg: AeBDiet89ivu/6i/vxidnj+YdKq9t+mUzEUv216WTs9U23nIEb4acz9QoT7vHgTHdwp
	oUnNDP0qhpDJvZzuMbP0msBgk6/uPE0jZLbZfMPWXTR08onkvuQjdHMtKe1TsXD7XQtqw9fKMlf
	Jw+geW2EdYR30yLP8CUR3/k2D70RIPZ0zwSf3/XIZxAX3sCZadXkElYT3shm930rmJgCQPiE19y
	nyi9ZE79Zi1RTdFQK0PzizvbzGGriHIeh5KlKL0xIPpdwGhZ8h39girc20RQVXjfD05dEoDTTe/
	tR9p5FbwTzQQ11KcYudcEMl6SqFDYQkws5KCaOVlxYO4Ovm2uC2kglx3XMIfoHWgTq5mZYkT/Yw
	=
X-Received: by 2002:a05:7022:239f:b0:12d:de3e:86b1 with SMTP id
 a92af1059eb24-1323b0af66emr2022609c88.20.1778191679291; Thu, 07 May 2026
 15:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416-alloc-spi-dir-v1-1-145e16477480@secunet.com>
In-Reply-To: <20260416-alloc-spi-dir-v1-1-145e16477480@secunet.com>
From: Andrew Cagney <andrew.cagney@gmail.com>
Date: Thu, 7 May 2026 18:07:46 -0400
X-Gm-Features: AVHnY4I78wgQJNRYMaB7piLFBfFHFjCR7i0r-bjyrRnd2ZO6cUXIkrTWe4ndMQ4
Message-ID: <CAJeAr6vM2jCEfcpfju78RUSzB_SMzhEwCRD1oDm_P8BNWkJaLA@mail.gmail.com>
Subject: Re: [devel-ipsec] [PATCH RFC] xfrm: enforce SPI uniqueness for
 inbound SAs only
To: antony.antony@secunet.com
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aakash Kumar S <saakashkumar@marvell.com>, 
	Yan Yan <evitayan@google.com>, Abed Mohammad Kamaluddin <akamluddin@marvell.com>, 
	Nathan Harold <nharold@google.com>, netdev@vger.kernel.org, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 80CF04EF940
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285521-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrewcagney@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, 16 Apr 2026 at 01:45, Antony Antony via Devel
<devel@lists.linux-ipsec.org> wrote:
>
> Per RFC 4301 section 4.4.2.1, the SPI is selected by the receiving
> end, which is interpreted as making SPI uniqueness an inbound-only
> requirement.

Yes please!

