Return-Path: <netdev+bounces-265213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEbZNge2rGlftQEAu9opvQ
	(envelope-from <netdev+bounces-265213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 00:34:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 297AF22E022
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 00:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 865D23019536
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 23:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DACE32721D;
	Sat,  7 Mar 2026 23:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="jGngFuCv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8DA18B0A
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772926469; cv=pass; b=NemtkFU2/vaWF6JeMBOmYV9QmoS76Pu0X+BnV7+vdevNWXR8wojENKEEjYvtCKsrlJtDr6FCTRQXY5Z/Br9ZQd0IwveRrMVCVZOSxtPHwvoOyKB7rniUerRWAjIGL/UM7P2OU7A0KMjnVBvhHRS7mF8QQGy1LQj6rl7IdzjHSEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772926469; c=relaxed/simple;
	bh=IOw3FEEu7s9Qpzm5ZXWgE5UwPyAeU165nnLNefeJtx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k775axWzmebo0+fvcx8qucK4lvDWPvjHbbHO2nLWcZnSaIdZEhN7l/oAJOqyGeyQ++XlNsAvPKZ9z5HEhjEXOI4B8GWKc5sle5AEupSyzF3cCzKs11JvkWMYYJk1rm21TDpruHCbSPZUQL6HCoMBmRfGOXYrBbm004/u8D/gtIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=jGngFuCv; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so8868217eec.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 15:34:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772926467; cv=none;
        d=google.com; s=arc-20240605;
        b=VdOcOx6i30A38GPgExVIIY0ITWp2W7VjFtQfO955O7k4ZWBTZ93UnXYIlUN90c+Zo8
         r3J+wfEvyBbMTsxUOwb/DGkYSnZmfEyxV0eSwAbss0r08hk9DNH4dS8MC38f4Uk1rP5h
         aZcq1ka1ayaozVPFmTczsRAUrGCJS40KDvdbAx8Udh4/S8CNPlDjFOsGOW7rVO2+QMxm
         qri0gtfXPhpSXim/mBOCN1FnvapeHK6rjwom5Xk5+OR0cWWaNnhLszpkXobrKaUNEYew
         F/OKTyCrEz+JcTDqrPaUyNKmXjgg4t9GAyIA9lP9wd9Pc0pngqnlinUQXhTYCBgHUFGv
         WQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IOw3FEEu7s9Qpzm5ZXWgE5UwPyAeU165nnLNefeJtx0=;
        fh=BitLwMzFeEG0mUWdJH8srMu2DkWO4V9hKKgxu/d+boA=;
        b=M57UF2FX/DQXwq9JX9H6MLCEii2aDRtbfxOHuZEKPgfmPCNNmCKllyoqGrC3AJhZh/
         PsYtAI0FaMrwjDY7ZHCl7DdWPPf6YvXJDahJO3g2jRlHUtXFS89SlB6VOuyJfkTkxV7e
         ZxDar9gNWwc8tMabhb0D05rbzAyqSfzB+zPQewi9LVUYebaNhUFvsvioJzSOYcsoIlom
         g6urXfpDAA0GCW+77SlMoWZYTgjvxC/inqMy+S11Rma+cLzbOeQ/I0cdq4FcT6WeITTG
         EYZsD6pzh/Mg1E0tn3Kl0hv4Ur4h8UB/3z2QFQ1We/YxtPJFdNN8IzC4ZJ3PSq5JqLYB
         mytA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1772926467; x=1773531267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IOw3FEEu7s9Qpzm5ZXWgE5UwPyAeU165nnLNefeJtx0=;
        b=jGngFuCvCx/W1RHqKPXp8IpI2euXdK4f0vbUBObPkOXUvOXhJJQusotasiq9LRN/av
         YgrTd7Dy2rI62vjxoV2cdQMc4rU64QfbGrEy5lQF1Q3x1d3+MLahwGXnU4HSO7JV+1B0
         YaxRo93uCuP9DzKSekohijrgdE83GHODeGOavpfwmzHFsLd3K3hEQZV5rUSAk/DhsInJ
         RGnJHifJxd8agG9AU6cLGQCNOy18SYYyFa1oof1RnFWGp9nJqpJvy6wpUho219T8TIim
         OY4N7tlvHgAmoFFj4s8UmMBdQgFnrIjPBgv7I62msIZ+pRb+cdfYDjD3rXYW2Qdx9V4m
         QiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772926467; x=1773531267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOw3FEEu7s9Qpzm5ZXWgE5UwPyAeU165nnLNefeJtx0=;
        b=xQnYvOfB0E84mxIu0TznsmFFhZWIriehuaCPEbiPuD0kSWpC+iAwYNrg7xUwFC1aVi
         /IZ1gKh0zW5wBAYSTbpWagERZodzRqmh4cQGq5OruzvTiEzl+Stc0ax0dRYJB+1CV957
         35Uols5G0que0YoM9jJU3Vn2VoeCdo10EkBIHMmVSBkNFv+VX6JshvAUUUFtqqZg01hM
         HbEcpBhUG4CFjfXUDx+q10q1KJfAPFryA6y4v7PSRoJM8nB8sp8KEBwS/lhEG08SO/Gh
         qVe7F96goik1W9tjjARKvV8vq2Y2lMxLmdpE3EWy/DqSi7rKG6qrFk2M3kpGIQPcRjdO
         20Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWhnJFaomIByIJT88efeehUuvuVt8mAjH91/Cj/75zCgSZuiaQJyEPy96NUAU5y6ZYRvBdo6Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJvSzTfxTzYIZSbbKUWHbHDia9ZpcgJ5LG4UdK0Of7HjBYtHO
	IqI3E0s0cPsCD0CTkTHn2l6WvmmZYuAlbb15gNRiRS9CAw+09aCRdtzD+jv7/UIMaPrUJxQhQjP
	30okxLG7IEmFe4XPhvQFw8EqxT9mdBv9TTw0iB4L20A==
X-Gm-Gg: ATEYQzxFDu1+ByxDoEjjU/VUv/xXjl1WIg1nkO/HSsxGgEvzMaa9K1Ah8iq3irjDo/I
	JFZQxn9J1FVrTT8EZE7Ulr2QOS/fb/ILQG3PBBDe4e21kUXUVKtX7Vd7Vc1I2x0/GlfvRG1QNS3
	P8iBGyG8kcOP1E55F/JqFrRbYu8kGHXJrpmUuamIQzswdl854KRrFYNeLjQ6K6KUpdyShrss1p6
	TWuBuJZf1JkUBtsSWD1Z5BYvfg5gzd7hweyJ79+VFrJY+qv/ePRPDxoxzh4xPHEamJyi7xO6YxS
	W1X5AQbg1zA41In9hm6ERn2rJ3O3A6lwDAIu8xywAMJqoM+wbKXKp95ImmN9z/dGsktqFtMYSdu
	y/DE=
X-Received: by 2002:a05:7022:609d:b0:128:bbad:9a52 with SMTP id
 a92af1059eb24-128c2ed3638mr3085642c88.39.1772926466861; Sat, 07 Mar 2026
 15:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
 <20260226201600.222044-3-alice.kernel@fastmail.im> <willemdebruijn.kernel.346c48b49836b@gmail.com>
 <CAD0BsJVgvbmk5y5TKkeFcdMLj+VuCWisX4VXv9g15uu=5ddLVA@mail.gmail.com> <willemdebruijn.kernel.2005cee64b1e1@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2005cee64b1e1@gmail.com>
From: Alice Mikityanska <alice@isovalent.com>
Date: Sun, 8 Mar 2026 01:34:10 +0200
X-Gm-Features: AaiRm53WsOaIARhkAg4CRx7ZSnVGJnwJPrgIDnoMMVXL4Elzeq_EH3yQJGiwB2o
Message-ID: <CAD0BsJVuTBdfrLkY+p93LYM8Q1dmVsv_k8_b3=wYe7hwDOF5Jg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] udp: gso: Simplify handling length in GSO_PARTIAL
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 297AF22E022
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[isovalent.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[isovalent.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265213-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[isovalent.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@isovalent.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org,lunn.ch,strlen.de,vger.kernel.org,nvidia.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:dkim,isovalent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, 8 Mar 2026 at 01:23, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Alice Mikityanska wrote:
> > Thanks for reviewing my series!
> >
> > On Fri, 6 Mar 2026 at 22:55, Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Alice Mikityanska wrote:
> > > > From: Alice Mikityanska <alice@isovalent.com>
> > > >
> > > > Taking further the idea of commit b10b446ce7ad ("udp: gso: Use single
> > > > MSS length in UDP header for GSO_PARTIAL"), simplify the implementation
> > > > and fix the checksum (apparently ignored by hardware anyway).
> > > >
> > > > The mentioned commit started using msslen for uh->len, but still uses
> > > > newlen to adjust uh->check. If the formula for check is fixed, newlen is
> > > > assigned but never used before the loop, and newlen is overwritten after
> > > > the loop. This makes msslen not really necessary, as we can reuse
> > > > newlen, if we don't adjust mss before.
> > >
> > > That's a big if. Why is the udp length now set to the segment length,
> > > and not to the GSO packet length, as before?
> >
> > Just so that we are on the same page: the behavior of the UDP length
> > field changed in Gal's commit b10b446ce7ad, not in mine. You reviewed
> > that commit and approved it:
> >
> > https://lore.kernel.org/netdev/willemdebruijn.kernel.218d53621fba7@gmail.com/
> >
> > I'm just refactoring to simplify the code a little bit + fixing the
> > checksum field that went out of sync with length after Gal's change.
> > Hope that clarifies it.
>
> Oh right. When respinning can you add this brief summary?

It's already in the first sentence of the commit message... I can
rephrase it to add something about "refactoring without changing
behavior" if "simplify the implementation" reads ambiguous.

