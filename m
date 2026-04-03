Return-Path: <netdev+bounces-274805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIxtKA4Pz2lysgYAu9opvQ
	(envelope-from <netdev+bounces-274805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:51:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DF638FAB5
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23C9F300BE89
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154023D7DC;
	Fri,  3 Apr 2026 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNJsrNHf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABBE23AB81;
	Fri,  3 Apr 2026 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176851; cv=none; b=eFKQht50ZSyDE+gqYE0XPwOM8fPF1qb78AppZVQtzzYWuUZJv/T7CGr5PeW0yzRfE2S6TcUXMXv/zoAJ/MTEEQYV7KrH+2cXjgvn2ycUH7l8fqVKLx/0VViVCSWvmdgTcRuj18wXDHYRzZgzawiGsLqXQje6dYlT/hB67Kb7888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176851; c=relaxed/simple;
	bh=NJ+8mEhNn9wUSa9R8VvhGJpfu23Mm7qVZmFxt2lVutQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bd+8emBlhdt8QQMMpJgjxYEUFq5kOy8Effn+U/NKxiteqhb3da4uW2O+k8Pm0yk2xvjJoHRMAa592JtxXFLmaxJ+IBN6TcVefWQ/ADPnUq9bub7qAKmjukwR6+8PkORHJfxJqu5E19k2bAsVSj14FFMnylx9U3uUP+gLj6ddhPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNJsrNHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F130C116C6;
	Fri,  3 Apr 2026 00:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775176851;
	bh=NJ+8mEhNn9wUSa9R8VvhGJpfu23Mm7qVZmFxt2lVutQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bNJsrNHfYcRJm007j4S0gUwfNrjeWvZdoHliWvtkVxFWWc3/1jlesn+xPpAqsNfry
	 HhSfY4bIiG6NLXrsbLCFeWKAJ6+3sJEDrdS8gHJ1u9OBgNqTkxXL7Y4Y3XuLfTkwbT
	 gh3zzJA7WItfiCMP76cE/w0dGh4w88Q7/aeFZOpCpGt1s9fSkApVEdjpalyO83PeXY
	 AEsd+6qBgB/SsrF3y4d8FXKBR+CCRachkUBXC0xV/V8w7UlVaYG9iD2h2Ry0bqJYP+
	 9GBOnmYjagrPaC5X4llk/14Li576IXy7ywUsYIQbvNA0KxyjFvi+cYMfyynW6KI4lz
	 UiTTZ3PrZQRrA==
Date: Thu, 2 Apr 2026 17:40:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/2] stmmac crash/stall fixes when under memory
 pressure
Message-ID: <20260402174049.0ac088cc@kernel.org>
In-Reply-To: <CAH5Ym4j5peYXc5c9ycJzimy26Tv+4x18hyy+j-H4v7PyWuWhtA@mail.gmail.com>
References: <20260401041929.12392-1-CFSworks@gmail.com>
	<20260402080542.293e8729@kernel.org>
	<CAH5Ym4j5peYXc5c9ycJzimy26Tv+4x18hyy+j-H4v7PyWuWhtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274805-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91DF638FAB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 09:53:43 -0700 Sam Edwards wrote:
> On Thu, Apr 2, 2026 at 8:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > I meant we need both a threshold, and a delay :( =20
>=20
> Hi Jakub - got it: when the critical threshold is reached, allow the
> NAPI instance to sleep and start a timer instead.
>=20
> 1) We'd either have to leave interrupts masked or let them race
> against the timer. Either one is manageable, but I feel like those
> interactions carry *just* enough regression risk to bump that patch to
> -next.
>=20
> 2) Could you point out which NAPI driver best handles this situation?
> I'd like to replicate its approach.

Not sure, the last few NICs I worked on had the ability for SW=20
to trigger IRQs exactly because of the Rx buffer depletion issue.
fbnic_napi_depletion_check() for example.

But let's not overthink it.. say we arm a timer and let the IRQ=20
be unmasked. The timer just runs napi_schedule(). napi_schedule()=20
is thread-safe, if IRQ fires with the timer armed - no problem.


