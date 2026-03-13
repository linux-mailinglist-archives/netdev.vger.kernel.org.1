Return-Path: <netdev+bounces-267640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEqnLI2htGmxrQAAu9opvQ
	(envelope-from <netdev+bounces-267640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:45:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE9528ABAB
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 918E131030AA
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C187237BE64;
	Fri, 13 Mar 2026 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAPg71Qz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2492C029F
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773445510; cv=none; b=LtQL9zXANdDvphIalackJnY4q1grPpjzm2QojxnqByPZEgiKiFcLNUa4WAUo5wj1p5ceUDAHcOwzoD+IymUUutJ7i2WzT1PrGUPuUWX6vCSuko7riK8bwXjVsenxdoeiZ5pJkSvdQbbIrQcHUlYGZM+lDTz9MrOYiqRV9vJuaBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773445510; c=relaxed/simple;
	bh=fOd/44im5/CXSgmKExZ34EPLx9erpANLJRLxew2LJbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hdnp0p68PHSvIjLgFLU6AJ5lfGFQjucq6f9aHqFg13A/C8K1OZWLgJrGfT1MGEVIrDo7rQ7hqRxj3sp5q1EZNGvg55wXCicNLRZ99PdyQ2uu2Sann1LKuTfYb2I83xFgJrGQm5QeRF7U+cXbPpKQHi5jozdXOWxWIPH7RvYYOAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAPg71Qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8C7C2BCB0
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 23:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773445510;
	bh=fOd/44im5/CXSgmKExZ34EPLx9erpANLJRLxew2LJbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KAPg71Qz3FD5nku0YGMR2OE6VVa3P4OhlQgxEFExEHqeUTE6By0F/cjfBpI4vlHR9
	 k8zQvOSlLhWoiCbVOhmK/Rhyj6KeuLDGvkkXUmoUTccIuL5YkFFlyJBtg9HvOdVZCk
	 WLJ5olds50xF6Sbb5RZEO/Hqo49M46/DUqKrcN7mYA5b1IsO9gYLN1oGahgc2IWys5
	 1N5aWnfg4p+E8Iul8lIqye6yGOT0Re1eQK0K0Va81wS/IdTsh1eJM/NdZD1iDnWqGc
	 zXriWP5NKH0q/C0Oa8U76CqrEvi/WFPaB0faqF1dDEIsPdsTFh2VQ7bguH6pgHLGeZ
	 XmJIBLCRbvmLw==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-793fdbb8d3aso29150177b3.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:45:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCT4eQriP2X0bERwTRVPl4hEQVxSEghfxlIUKg39uE+fG2fN9ttDSezikRZsNE7w2fAW8b0Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6g4eNbes9zX3sCZIpRRVm4NHXFYSg7xPvadAYlyT4CfiP5pcn
	w4BylhBGuBN1SvBykCKqpOWODZpZuREWpFfE4KEozEYgdKdpCmOgFpl9BPw+JH+iXOUEEsJORLf
	AE/CYtnVFDGA9j9uD9LuJoniHnR/FZnU=
X-Received: by 2002:a05:690c:34c9:b0:798:23f:7c4e with SMTP id
 00721157ae682-79a1c1bf4eamr55367137b3.45.1773445509360; Fri, 13 Mar 2026
 16:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313105718.359614-1-christophe.roullier@foss.st.com>
 <20260313105718.359614-2-christophe.roullier@foss.st.com> <abPwHh12MLwMwOIs@shell.armlinux.org.uk>
In-Reply-To: <abPwHh12MLwMwOIs@shell.armlinux.org.uk>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 14 Mar 2026 00:44:56 +0100
X-Gmail-Original-Message-ID: <CAD++jLmBP5Puwf1ZuFOzF6U0XowoF1nfqEL3gwLy-svXsXrbJA@mail.gmail.com>
X-Gm-Features: AaiRm50-LY2Xhs76thbvINckDs7OJCXfCO8--wEHvQ5qpVOHRa3ZyCR2c8VTkN0
Message-ID: <CAD++jLmBP5Puwf1ZuFOzF6U0XowoF1nfqEL3gwLy-svXsXrbJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: stmmac: fix pinctrl management during suspend/resume
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Christophe Roullier <christophe.roullier@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	antonio.borneo@foss.st.com, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267640-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,bootlin.com,nxp.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CE9528ABAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:08=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Fri, Mar 13, 2026 at 11:57:16AM +0100, Christophe Roullier wrote:
> > In the deepest low-power modes, the pinctrl configuration is lost
> > and is never restored if the interface is down.
> > This commit ensures that the pinctrl state is set in all cases.
>
> Shouldn't the pin state be restored by the pinctrl layer?

What we have in the device core only applies "init" and "default"
states, and provides these handles for transitioning to "sleep"
and "default" again (like a state machine).

I would love to handle this in the PM core, but devices are a
bit sensitive to where this is applied wrt e.g. some register
writes that need to happen before/after this pin transition etc
so it's called explicitly like this from each drivers suspend()
and resume() hooks.

So FWIW:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

