Return-Path: <netdev+bounces-284358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLvzJMvg+WlPEwMAu9opvQ
	(envelope-from <netdev+bounces-284358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:21:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B30E4CD59D
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 083CC30088B2
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728E9426D2B;
	Tue,  5 May 2026 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJbmWb5p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035F38E5C8
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983687; cv=none; b=clZn2jONJuWs+34EdPJGgJhGLAm7YwoXgw112hd39az3axLsoAscg7nu8Tp5Q4pXmCxYygB+zugjdwaQO6vGo2enJ8cpzE7R0ozH8sZan2gpZHOwgbfE8qZz+T+Yf3j+hKoBixTng0CtYDp1AMxogSmlCurlxK2fp25uZfgo458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983687; c=relaxed/simple;
	bh=6hSwkK1hVeHHOkr/8Je33iQCWFpHZmFOmGavBvYZ4gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0Wh2O9JMCJqPNtCqThybWODbY9Wg1q26qAnaAMShkoNCDH2L6IT7EyLfV1PBVoPgqOSqODuA3e96hh+dq0M2cL/DxrzybHnusMIX19IgaJwhdQpnjZk2Yt/+kKuAgadgTu7bIR0mVrudf3EfcO5CgkZWv1Qp5yzkSjs6F3cI5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJbmWb5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E460AC2BCFB
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777983686;
	bh=6hSwkK1hVeHHOkr/8Je33iQCWFpHZmFOmGavBvYZ4gw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tJbmWb5pBrJ9kVq5+baxVKvOUSmS27PLHuLviGByEsvSO4bHMLDYWlNQvXR0Vensp
	 IE9dAnqYan6jVU4elgBkUAXZrIISUYUpwmejtrF6QbwJZMhBJF0bkeAQDq6HQ1s0bK
	 F//hcI8j9fR9CS3SIXaoCaJ6afNKza/ly3v7oLPrW4770Vbrn8I8dHvjJkU3egAhnu
	 DQ/2GdXxZ8S4p+RerlVpfMH9vK/669K22vJZP1sPmT7q1g6WTQy+XCgrvdJrRU6K3m
	 JUS2Lad5H25fivYH8OZdhAfjsSAhvF8tgTy1/ZKDbv4xRX+Ro7WrFiQhOLmCiIflpX
	 3cRIT7FwwLRdg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dea72099eso5297390e87.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:21:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8bk8EosPG6ewI4MJqlTADkcvIflAELgtkWQlPcyfq9mTn5MhxcffnaOkaDIOQpp7RG+2pfBYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICz5pa3ZU0mLjhNM6Wh7FWQi3798FysPIGWexXkiTpY7CSWiP
	ewv7TKKf4ro8EVMzRmWiEUN+xWT5xfsIQHMjwhBy/ZG25svh75jGDxvEJg9/tWKHsefnK8WtRL9
	U0EE5E4646x4OoSNwsKLtE4JpC8YNPlo=
X-Received: by 2002:a05:6512:2302:b0:5a8:65ce:e83a with SMTP id
 2adb3069b0e04-5a87f206564mr1341626e87.34.1777983685569; Tue, 05 May 2026
 05:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com> <20260503-realtek_forward-v2-1-d064e220b391@gmail.com>
In-Reply-To: <20260503-realtek_forward-v2-1-d064e220b391@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 14:21:13 +0200
X-Gmail-Original-Message-ID: <CAD++jLkE7zUCZyJfnEsxcHF5TAa-ggQug8xqRygVFJ=oADbXxg@mail.gmail.com>
X-Gm-Features: AVHnY4JVw5zQepvD73TQYk4486G0c3DGCb7V1d4QERhYyEC9XfVAH_gLihJbcCs
Message-ID: <CAD++jLkE7zUCZyJfnEsxcHF5TAa-ggQug8xqRygVFJ=oADbXxg@mail.gmail.com>
Subject: Re: [net-next PATCH v2 1/8] net: dsa: realtek: rtl8365mb: use ERR_PTR
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
X-Rspamd-Queue-Id: 0B30E4CD59D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284358-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Sun, May 3, 2026 at 8:18=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Convert numeric error codes into human-readable strings by
> using %pe together with ERR_PTR() in dev_err() messages.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

