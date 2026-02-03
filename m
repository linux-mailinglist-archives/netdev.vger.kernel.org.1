Return-Path: <netdev+bounces-256244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHQcL7zOgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:32:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A78D7B62
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3809C3008D12
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6F317709;
	Tue,  3 Feb 2026 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F24AhbSM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055C3161B3
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114554; cv=none; b=HnIh/GO8T3/HJ1Q28fQnBrgGmA/sZ5nG/siAHRinsXpzkopu+4JARcrJBfh9jPrdDdXSOZQ5ILc1bsBlpxka8WmhrGIhJ/CFjhYBoQYqfSRRK66BPI0AP91FW0gUS6dg+Ha5FyORV5msUed+h5XAR4TummFWzWKc03jOIRYwro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114554; c=relaxed/simple;
	bh=Q+5e9H+HdmW0C0So/yqRSBMoljj7hMcdRxROk+ueplk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm5QrT38LAUJ82a2f8IIqCf9k0oX0Uw/rWDnLjyPfMc1+qXurMrXmj4IC7/AYLV6V+g4PCOiro0besKnE7ulsc/eQ/lFqmfa4weyRxccl5ZFTkof5I0IF2lkO4V+jfMXW2o8RVJy7ORlSmSShhp3HetsReA+7aljPrujz7iGn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F24AhbSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244F1C2BC9E
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770114554;
	bh=Q+5e9H+HdmW0C0So/yqRSBMoljj7hMcdRxROk+ueplk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F24AhbSMXSb+bs5HlaRJRtIJQT1DGvnTYTfhcTFseQfrK4Q0qMpeH0KON7R/fMVfm
	 33d3Bd18TTQthQRyMN/3UDCNJnwugN88QNmNQ5mjltGhVETesETnW+z5Fh1WzhE7uR
	 dX/zJEw4oZ/G9QFaWzOIbihL1YHrA+eNxzCTJB50t6iykO0z0j8uqK3c7lN6mzRbKo
	 wSC5ANYviuovTedHoBLnJ4CqLCFxnCw019wmPfteEa8x2IszmNTqyAk2bGYTugYJIY
	 xr7cO3AvLz1ibsiDYxS7A15S8Iq2anTJqoMA4ytPuzFCQicUHyc9QBHfMQ3sKCDpre
	 L0bDGRfMsBJvg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-382fceabddfso42334301fa.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 02:29:14 -0800 (PST)
X-Gm-Message-State: AOJu0YyTVIewIyR1dTHjuLsoFs5sUg7LYnaNNlabcR6rQRWZjkJ/p+Qc
	5oh7w37BhRQcKtlk34Y0Nu7dUI/px8P7xx7o4XhEw8XhbZcewkZiMDphJKJ1cKLsgTB1nAuUlnB
	BCp3ktN0FVsfG+XOc8QTmCAJp+CCg/BLCbgwOW5A9jg==
X-Received: by 2002:a2e:bc07:0:b0:383:1b75:b9bf with SMTP id
 38308e7fff4ca-3864664349fmr58136261fa.28.1770114552731; Tue, 03 Feb 2026
 02:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202214634.72738-1-rosenp@gmail.com>
In-Reply-To: <20260202214634.72738-1-rosenp@gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 3 Feb 2026 11:28:59 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfwuhrUZiFp5v0EjbMJw0fYZTfznqPN_6yuMWxnD4ircQ@mail.gmail.com>
X-Gm-Features: AZwV_QgLNfV5BZ3zJuOTz-WNprPtSMlLj8pGW6PWOOP1hYOcMu-o4WnUPVCBQ6c
Message-ID: <CAMRc=MfwuhrUZiFp5v0EjbMJw0fYZTfznqPN_6yuMWxnD4ircQ@mail.gmail.com>
Subject: Re: [PATCH net 1/3] Revert "net: ag71xx: use devm for register_netdev"
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-256244-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34A78D7B62
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 10:48=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> This reverts commit cc20a4791641a1cbd1525695fac0d4725dd72509.
>
> register_netdev gets called after phylink_create which has no devm
> equivalent. phylink_destroy must be called after unregister_netdev and
> not before.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Can we just use devm_add_action_or_reset() with a callback calling
phylink_destroy()? It will surely make error handling in probe easier
and avoid mixing devm and non-managed APIs.

Bart

