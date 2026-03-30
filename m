Return-Path: <netdev+bounces-273344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KUPLN34ymmlBwYAu9opvQ
	(envelope-from <netdev+bounces-273344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:27:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 401F0361EC9
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 767953048ECC
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC413E51D4;
	Mon, 30 Mar 2026 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWJMdggJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD13E3C5D
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909613; cv=pass; b=hXOOfWUc6dL8FgW0Y72WB967C3DnoQSk1YrI7Syf7ObhpJSKGEMDQP9Ye+FUjjbmmLp0K9ci+Ojuxy8/+V9JPK5wkAf43HoiPG9QYz3hgVIzmHCIRP8qc8T7QWM809oWeHz1dn3oFtsRvamuhmC6glE6OrHNH4NBqwotNkSZHy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909613; c=relaxed/simple;
	bh=vakATihP4mCxAvV7TkAw/QAr6YVcvDOHJ7aoqLhL6Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfmmTcM7sPL0lGFbTawew/tVEStfRfxyd6KrJduI9gx2qVgeiqnS1h/Sw11ok/XNhBJehVfj8dCCcAYcg0VVVq07pXfxUH6vzeoG96EgQXq8TnnIaVYnMWabBZsGabkv4/UQBq+QhrnrKOxrKTieh9gY4IPRrR6ki31Mv11yjnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWJMdggJ; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7cc688861so886287a34.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774909599; cv=none;
        d=google.com; s=arc-20240605;
        b=TMAdBECm1NVd0OUyNa4SbkPtJrQ59VNvwP4P4dD25w8cYwGclTdVan9S6s5gHjLJUk
         8GrGWft4L4iloMpkNhgzBVgjze97+wBTZhS6vqsmWNVKymGcZEdTqQS+9kZ8WOF5Mla1
         M5lMoyzo/ZXWeOSYu3M+WyUedRwgRlh+r+WDsetmAfrYgEJuCmeaN8c0Ic64Yg1BCAG7
         8RlpA7+fo3kxL28hZuFWwTBf0vXxlZuDv66n3OC1eD8s9syNb3B7RkzdvHLR/KoEu/Jj
         jS2Zhj0h1ZMZJEKJhwOz7/QZfTQStcgSCVDeI3KtXI9tLPe4fnY1wPaaWn3NqsoaycNN
         qXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vakATihP4mCxAvV7TkAw/QAr6YVcvDOHJ7aoqLhL6Vw=;
        fh=w/N4PPzM0Fj4TOdKVXUZsyHDB8uPhY9caRFOO3DELto=;
        b=Ts9Nz/deXRr98ZvIgul5kv4M8GVSaI2q78fQIFc46fhD6wH82VDtp92FmPNb+yDzfS
         DimWhV30U/5JLOs2FXopBMFUwkBikTq4FBM3bDmUt+uAGAp0OPSNoyCch6dlYJNtszDW
         dEJWrQyVT4i1dyhJ4rjQopvNBpRGNVmahLt/+kE82aB0+ezJWol7TflJMAstigUCRuCs
         tRJFdEW8jMTWvws5No1VbUSHCXCmzGhO10/s0zW5/+a6Ecxt0qL738liAr+lUG6ARLU5
         rdSjOgJMzavdKU9IcAEUAo8kfeLbdzhkpYpRo8gqdYoZPk+0mhTLh3GG/sbEl2oWGFtT
         VlAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909599; x=1775514399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vakATihP4mCxAvV7TkAw/QAr6YVcvDOHJ7aoqLhL6Vw=;
        b=AWJMdggJN5ewAMwa9ve0iG4Hp3aGyPjYdfb8YAZW1D9QsJvfieRToG96a7TZ6P3JT1
         /Ie+6joer9sFVOscENsi95h7GRnv+LbIbfVCsw7bzBvFjoJg+L35HRENlWBJB2JiInOG
         zx5SPuIOd2gAsFpxGnI2vyk/SZU6LWBBhTslIiySjPFBOsV3ax7zWPo2hPDbzlrhY1Vg
         gDSVJMpmgaqYC1zqxp2PtSPzWUKiUarxVp6BI8YM7bpg8ZeBcFMDfeqHacfiC6qr+754
         HllPBEtYgjrzBapJyE3OokMEqKWBlWFteCsH/iywWaix5Guo9b6tZ9OxnXtzKV7zvFCu
         bedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909599; x=1775514399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vakATihP4mCxAvV7TkAw/QAr6YVcvDOHJ7aoqLhL6Vw=;
        b=OQIAf7ZI1Gd6VtHpXRKgaTx+58QFtgsQ7Uyg6uqT5IhkiAv3ikpy1+0oOn7WqBpGs9
         J4ArqtkJNTdcjmCHz3d8laZ6uIW4Ydh2Z1n/ccxZzwlkfRzJXNa3GtKqCoEFh0xcaxdQ
         2X8cPGWF/RZ1XoiOtIMST0Z2OzAg4R0cRArd731ZPPeLILToaYaTDU1UexQIQbzg1f9N
         M27pZ/CrqLGROlSwzQOtz303D0IpbBpwZtB8CPj6iLdKSSJ9ihwsLj2Hdcuq3AGzVZdQ
         GNmIZRT30qmjd/ut94XIKhfnMqIDjNHC4S+FT0vYMwmojQ/9Y6YYmuVyDHvK/YCiszn2
         I1Pg==
X-Gm-Message-State: AOJu0YxtEt3OkSgYL+4QWZh2Z5Qh5FR497WbB0P9SzgjUfG3pf9P8gnL
	aZsioNRruhhyO+PKAGGist4TwyNN6f14HMCEFhPC1ltPU5MswpBQmJjbLFhHlz+F00/tUfLTzV8
	3bhAo8RaqPs4mCMeIL5cBQQEJH3XUoF8=
X-Gm-Gg: ATEYQzxM9HliMRNNwCcB3I/XFwLQSz1Wcd0h42WPeA2h9PT2PRQBODAbpsN15Lm+qkK
	BjvDNPoUm/y16Vi0BNFBYeQ5D39DH4BcwtJ+JGNddbqtrlQcK2cJwZ6D8yOLM8B0kZmHWXse0SU
	nUotH+md67vRkBwkQ0LTWETELUeqMFpj7TmNHKXHjsRJO7zRVZy/ZkFTIxlcLam3MnVPQQPk3ae
	Ivp05B+XslYjAv696Zj8Cd4S9utPaHiW8aDXVg6pO1KxHcOqbX+lSrVlKGVTpiKjWD/DxAlWKza
	sMA/Cw==
X-Received: by 2002:a05:6808:220d:b0:467:2509:c1bd with SMTP id
 5614622812f47-46a8a4115d3mr4973742b6e.2.1774909599478; Mon, 30 Mar 2026
 15:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329041922.3850747-1-weibunny.kernel@gmail.com> <20260329111240.67e6f097@kernel.org>
In-Reply-To: <20260329111240.67e6f097@kernel.org>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Mon, 30 Mar 2026 15:26:28 -0700
X-Gm-Features: AQROBzABcwKSUc3fUywvI4YWennUfe-LetT0i-CJD34xxvOeE07K25FgJMMG0C0
Message-ID: <CAGqc4nVw8h+xz3ABTdQpUO+xmEAh=UujKwv+28Za-2yNgzCQ0w@mail.gmail.com>
Subject: Re: [PATCH v8 net-next 0/5] psp: Add support for dev-assoc/disassoc
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273344-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,kernel.org,fb.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 401F0361EC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 11:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sat, 28 Mar 2026 21:19:16 -0700 Wei Wang wrote:
> > The main purpose of this feature is to associate virtual devices like
> > veth or netkit with a real PSP device, so we could provide PSP
> > functionality to the application running with virtual devices.
>
> Does not apply to net-next.

Sorry, rebased and will resend

