Return-Path: <netdev+bounces-253812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBHeGlSaeGk9rQEAu9opvQ
	(envelope-from <netdev+bounces-253812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:58:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C751493410
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 836B630097E8
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0408A345751;
	Tue, 27 Jan 2026 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfMAw3/M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D0344055
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511505; cv=pass; b=Y4kFfVMRc9/sLy9maSwbUTy9itrLAV5RAAND5Avipvy4q/zb6bTfb+O2SUfp1u3OsU2qu11/r9CcK4GMj5gCywkyWyO70QkVTKp7q8YaoSPu3AayGt/001KQy2UArvewLQDvCWJDad9FLb2EjmufZpYUpJcJ+a5Rqd1AIyGaXLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511505; c=relaxed/simple;
	bh=9j47t5rMsU8ZASRBZwwfTEmAJ8TWZKYRSbD51WsqFfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONr30UnEbrwNxpR6WFA/niIQ4l/NQI1LFta8SB3WJgIT8N/MjUuezOZN3mtbLpT3Cy6Q1JB3n5yvWF8uNbA8nji+SfQ6/UXA930vI2ID9FfjKA0mwHNDkm8Uu9zyh/rx48QYc+Xjq9gGe/ZwS9E8xaaTnWrQ8SjX8BG6lamZqdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfMAw3/M; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-385b6a15affso59764671fa.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 02:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769511502; cv=none;
        d=google.com; s=arc-20240605;
        b=h1LnaP4qn3ZYy44ZE8BsRnzJ2Sj1EmGtB2OSS6XtSkIfQDMS+voxfJMSP0d9VUgp9h
         7rHGtFNJPkx8Nt03pQRowFUnxKVNdTFEGndQBshMDZB9z/eyAZA5UWOGdkxLrp2qTEjB
         hwDk6Ia0UnGq9vY2It/KdWUbMIAOpcUSOv3Gm36UylOYbQwZeudumQHK/YBD5UqoyaFr
         LfKPIDv5KMgMyZB22+ALpBVnWkLzYZYp3EcUCnD0P25wJ9M3SQ7Pidbuo9e5YuyFATg5
         WRzJ7Y1CONp2iGcFINMCL7HXDvmUkzbL0d53eEN7488oedeR4IRKwe05vdC7+aV9+Oyz
         jWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9j47t5rMsU8ZASRBZwwfTEmAJ8TWZKYRSbD51WsqFfE=;
        fh=Gb88EkPsvaE3txQuWxoe91YYi4lYHCqDxatpvMQNdeQ=;
        b=OMkOJR+Q5yZf5HC5tCSnFAShS83nwLxl2DLM78nKAVvouQyO38LWPggutZKIUZaYtc
         G3sFMnW1MeDq4QyYGR9gYwF1CbYN2ZRDobnYR3g6k5Tm8g1juFvIUMetU4oq3BzPov9Z
         6owYU0zgk+LN+43vC63lO2ynON0CGo4tYUGhLXk62Z0jiUcso0mCJ/AZ2xE3KABZPQVi
         Tj+7AXdBwViTHyH6EVTbwTk4SEMuTde2wDRVSdmy2dyvguO8K06/HZ9fftUicyydscjq
         i7scw2+qN2IAWmZ2UU3O8Q8LLaU2GylfND6pjL8yVvoZlaPvbyLZnuU/8FufCKvf2O3Q
         p+jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769511502; x=1770116302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9j47t5rMsU8ZASRBZwwfTEmAJ8TWZKYRSbD51WsqFfE=;
        b=OfMAw3/Mic2rqr1c4ldAl7P+FvOUuDD6RMHYqKLQHNAThUg3+149AJ/4KktNPrgg/A
         5QgdzukVlamnkp9LVkQD3SmXxb65cfmC8/2EJIwQi3BchlNHV+YbOI2kws5FUvrwlPHg
         k0jTtOlpdGEG33rmtNyOvanKzcZyOIqoMp/jYBeSEIxy9KXHa3TgsabW5GW8dREL7KcF
         yiry7+TpjjWJ2/zMiBmLslpVWUE1RCyN+wXVSE4V+qKpwKDmPJrJ49dRCjwohXAE5Hff
         //gvCqMfZRgdn0Yhpv0bsCFqj8XSYlry5KKWz1+8jCxGxGNKFYvCX35NKYkxS6/fy54J
         1etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769511502; x=1770116302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9j47t5rMsU8ZASRBZwwfTEmAJ8TWZKYRSbD51WsqFfE=;
        b=K+A6ihETx9JMsE98Z0ZlwDapoyr7UByunMRMC217Wa+wOd7RqS1ycSNADBbj5Wsl3S
         4M7MtULWqhLha2xw6oxHz/+XmaHjh4bJq5mVkpqFajxCQfctXE8LLcLoYwf+JLMCfzUq
         cLoOZb19ElT8EH3LLeEQ9hIbBp2xq/nnvWVR9p1wM3bg3e0MJ10rvMgCrKD04SR71B1h
         5b7kiPy8sodUaq3s/7GpYLorcIFe6PApkxRVV/oB7K0C5C5DMZgz9dX2TSiektA/lI+N
         3AzDdkqNsoy4iORIRjE53YHHdjsPt7/s2o4NUY3jNq/xvJFZQNMG0p/xjow8PdA+uE97
         cchA==
X-Forwarded-Encrypted: i=1; AJvYcCXUzmOnn57ZOo2t+uhWeHWB6ePU4K9YsOdO7kNsVVGr0H7AUKpAGeOyXE9BybUzPypBayU+leM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjM4Squk5z5Gea3JJKc2OU6yD6lXHXJIBotyBqtBWpEXWdz1rH
	ctrpFeCM4ZumIuaLm7chojzX4lMlZHtLUDfbTH8sPTr1CtqYsgm5h2DsQY1bI2/FDCu+7pjnXpn
	ENcYFdsBj2KcqJkWlqNdzLUiPvoMuDd4=
X-Gm-Gg: AZuq6aL5r3AAZxc0YqEiUhs+Q3PQr76H6vRGRyDEOKho8YghwG//sKyQvPbKJClZAIX
	eDAIK93YVoWVCx+2jrw5Bs2yBnMog+LZa253+M8eKAzsp8rXQEeMGkWhTanQdgw9nYykvuEgnFQ
	sMqGS3KXk4f4m1iPhpVuwbpYFnkcHu7omor6UxPIHQzOZFFCTFZwJPhSA2dLI6i37j8y6MGZBQL
	U6qMvqYXNWIDSbfYwFUmjk0l8/MFie+fgKpTiQzXYVFSetVJuyEyANlzH94FN2swRSJyOPbPq2g
	/DTcH3+9LIwhDU1SHdbfGVNdVg==
X-Received: by 2002:a2e:a98c:0:b0:383:160f:c230 with SMTP id
 38308e7fff4ca-3861cdf742fmr6587841fa.6.1769511502131; Tue, 27 Jan 2026
 02:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121184621.198537-1-one-d-wide@protonmail.com>
In-Reply-To: <20260121184621.198537-1-one-d-wide@protonmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 27 Jan 2026 10:58:10 +0000
X-Gm-Features: AZwV_QilmQ0M_E_OX9gIvzqQlcezsEx3A9Xsbwt7w5VyeNrZs3zZwncF7WeR9UU
Message-ID: <CAD4GDZwLgUW1STpjQegzsMSZb4mOh_L79FVJx0SvmhXSpxjVSw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] doc/netlink: Expand nftables specification
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253812-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,protonmail.com:email,strlen.de:email]
X-Rspamd-Queue-Id: C751493410
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 18:47, Remy D. Farley <one-d-wide@protonmail.com> wrote:
>
> Getting out some changes I've accumulated while making nftables work
> with Rust netlink-bindings. Hopefully, this will be useful upstream.

Hi Remy,

Can you please cc the netfilter maintainers (and we should add
nftables.yaml to the NETFILTER entry in MAINTAINERS).

./scripts/get_maintainer.pl net/netfilter/nfnetlink.c
Pablo Neira Ayuso <pablo@netfilter.org> (maintainer:NETFILTER)
Florian Westphal <fw@strlen.de> (maintainer:NETFILTER)
Phil Sutter <phil@nwl.cc> (reviewer:NETFILTER)
...
netfilter-devel@vger.kernel.org (open list:NETFILTER)
coreteam@netfilter.org (open list:NETFILTER)
...

