Return-Path: <netdev+bounces-275882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAkkFOmz1GnvwQcAu9opvQ
	(envelope-from <netdev+bounces-275882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:36:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 920943AAD3E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC9BB30048C9
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F939F188;
	Tue,  7 Apr 2026 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upeq5DI+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35A39EF38
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547365; cv=none; b=Tw5tij+9ulZSH7gUTmbwTzsSC93y0Iu8sQ2tCuNlMf9r5L5ftyqOzO3LPiwefX1rYq/DpKG0ASxx0EfiHMXLya8pnEIosAn1d3ywo62wu/bg/09sgOPY1Hf1RO1NY+N5/+Nnyac7W+RRZaE6h5QYb4miip519k+B4wu4xoectUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547365; c=relaxed/simple;
	bh=QGHGnvl5tBAxhaDARpY7eHi9f5aeWkNct0j5tJrd+Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4IiAKItCe1v/pKBLXxnTiZK1CFOovT33+73s1khb+ZxgQo+c+PAP6c2+UQztQsCy7BkZiuQRGAeECaRBafYBQLv9GjtQ7ttXcJA9Bnp+EmDDpzwc3tYXrNWr7TdPRzPYSMpuWoN7Gx6BxebOkJF8gfvjJPAoNSR+WTskzZn88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upeq5DI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9174C2BCB5
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775547364;
	bh=QGHGnvl5tBAxhaDARpY7eHi9f5aeWkNct0j5tJrd+Vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=upeq5DI+8fmDt+jAtqlmFUK/zo0m5Z8WbE1yN+BoGzJTg6hz837qWmEGsiO1O6+wc
	 IBpzJiiczPd6Z1MniLufPtBjExgSiakpcHIgnG/3aJIzuqcgR1q6ObIFrTqg/OEnrR
	 mTqZvkNzffpBy9ZamQi6GCJBeRM4CoaqavPLKu7CKdyOAO8tilQqXpVSaz85MJDsSB
	 JCzQq6Ui/XT7lyc94fhC+wVclFenPFxYwdy8bR30Ff2OxhCilJSyuh7rUvieivDdD2
	 K3H2Vikx82oSOZQa5xJ72IoZIIOEiEgwf5GLJCHiVsZOCIaq6FLZLL333FqaOz47nJ
	 1wX3tpjRR9lGg==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-794719afcd4so44834167b3.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 00:36:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+zTGMYouERESBzUKS1Iu3C/PaNokHoBuPfxYaqTDprYeYASjsOnWWaggAtUsGbcyW4Ir4XT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcj7VpJbl+AJKVbLJcuinqMtdI+Q/dYvlMxMfH7rLrgnmL21+
	0362xjfYD6jCTDavIzCNZ3zDKSeAcroYgLGjI5B40gfRDhJlUFIfTHblq1tL0jCgpcse5V8tRbM
	u/w+688k3E6rhWawDB1TKjffVksUq3Tw=
X-Received: by 2002:a05:690c:f15:b0:799:266:83cf with SMTP id
 00721157ae682-7a4d5d58f42mr153950717b3.43.1775547364271; Tue, 07 Apr 2026
 00:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com> <20260331-realtek_forward-v1-3-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-3-44fb63033b7e@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 7 Apr 2026 09:35:52 +0200
X-Gmail-Original-Message-ID: <CAD++jLmX3BGqyFiyqo5vpjowP3YD3uw4knAAhUtjCS-Rqu4Kug@mail.gmail.com>
X-Gm-Features: AQROBzBNpc0LimOqxUmqi5ix9-VY0QtVkQ_52VrQYMuECre_VSc_zL-XbpXvMAA
Message-ID: <CAD++jLmX3BGqyFiyqo5vpjowP3YD3uw4knAAhUtjCS-Rqu4Kug@mail.gmail.com>
Subject: Re: [net-next PATCH 03/10] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275882-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: 920943AAD3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 1:00=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Rename rtl8365mb.c to rtl8365mb_main.c in preparation for subsequent
> commits which add additional source files to the driver.
>
> The trailing backslash in the Makefile is deliberate. It allows for new
> files to be added without clobbering git history.
>
> Co-developed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

I can't really see from the patch if the line below the backslash is empty =
and
that is why this bisects fine, but if this compiles fine then OK.

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

