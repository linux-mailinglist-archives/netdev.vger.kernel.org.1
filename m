Return-Path: <netdev+bounces-275885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNqOAKO11GnvwQcAu9opvQ
	(envelope-from <netdev+bounces-275885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:43:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EABF13AAE6E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C24063003810
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 07:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839BC391E48;
	Tue,  7 Apr 2026 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXcEaje5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C481A680A
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547804; cv=none; b=YUdevjBOvDDPaS2rWQFGYr4LC4KWZVFvBqP26qvUd7wJkY1YMvmROmbgYA+gLNo5QrO2S0j1xOhuDs0TSfL6HxwMoOeXCqwEMw1quyQvhQQ1oeQ1oOHcs6lQ92JTufc0onEEQkCtKKQCk0z4xeI/uGRm0IG/bzSU8i1KGcR1mME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547804; c=relaxed/simple;
	bh=i7Lj34oeTZUxU/BucLH+A8uqhctOIepLmLSLvFNG+9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlmSQM6fm8+qV3h9CoYzyAUVVmNrtrdsQ0iFZyrg8U133BUXrOaJzRDgMnKBctZjXnEoUCuqpebmwUQIh8KoNlBC2MnapkP7MoCS/Fv7cqLRTIeN7n+ZKhdqBu/NCglT/p6tYtcaYs8xpqQL2JeiUl1WgI4jjf0hThab7ffEN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXcEaje5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42389C116C6
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775547804;
	bh=i7Lj34oeTZUxU/BucLH+A8uqhctOIepLmLSLvFNG+9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nXcEaje5vOV8pYq1CP7lFRW1fLDIwDTLeY6RIwgi731DaGyDoHBmCzqeu/WVUXu9u
	 1IeEZ9SsdKOSzpBReEUOWx5quxE0qzAupiimEa3uyFNr4ki9dfGWHCTNx07Gp92kSy
	 pPt05V/Wnh0GQlUtf9A1tzsWGqakSG2kibpwPqgebGCq2yYBfnjdXkB0xouXkt33kh
	 5Wnbv/FHPyhSb3t+KjURqqE4gLi9nlZC382wqp2rMDYjEnSlLAYOi3nHpfzMB1EAgH
	 lMtQ1W6SJ+h/pQaHpFYJyghiNReKZzVVXzXCj/A5g8uIdID4CkZdiaHjkrT9gNalP0
	 en7AM3JdMdYTQ==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7a43424f861so44621267b3.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 00:43:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4uOGWewrrER5GsRRb9q30avtMp1DmFc5EM1v+oHsi+/oSPcWTtNReiFpJ3w3u8GDDwvsLfW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIHoAykzX5T0mzTDmIXSSd5exskvVZzLF1Y4GAA8TD8eZGpOZi
	nAjf1DtQO41ohUof5cydRTWd9ltodQD+nWlwVCQg6kmFw0Eq9xOYXR4+t2bqHbbXrpkOUqfML0a
	7lWKwYe2/1S4aecBNMAgFPp9EcD6nK88=
X-Received: by 2002:a05:690c:dc9:b0:79a:daf7:c4fb with SMTP id
 00721157ae682-7a4d6253774mr157235817b3.50.1775547803703; Tue, 07 Apr 2026
 00:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com> <20260331-realtek_forward-v1-5-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-5-44fb63033b7e@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 7 Apr 2026 09:43:11 +0200
X-Gmail-Original-Message-ID: <CAD++jLnbqT98VzAwpq3p=9rO6OWw9k9716_ny+ZfaCLUrdiJFA@mail.gmail.com>
X-Gm-Features: AQROBzCapugHWU9A76_HoKOO23GqtL3Q0QAAvIqIW-azuaIPrng_OuzqB9WIsMM
Message-ID: <CAD++jLnbqT98VzAwpq3p=9rO6OWw9k9716_ny+ZfaCLUrdiJFA@mail.gmail.com>
Subject: Re: [net-next PATCH 05/10] net: dsa: realtek: rtl8365mb: add table
 lookup interface
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275885-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bang-olufsen.dk:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EABF13AAE6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 1:00=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Add a generic table lookup interface to centralize access to
> the RTL8365MB internal tables.
>
> This interface abstracts the low-level table access logic and
> will be used by subsequent commits to implement FDB and VLAN
> operations.
>
> Co-developed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

