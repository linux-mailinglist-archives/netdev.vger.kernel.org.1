Return-Path: <netdev+bounces-284360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAxVGEzh+WmYEwMAu9opvQ
	(envelope-from <netdev+bounces-284360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:23:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EDD4CD613
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E42A30198AF
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE424279E7;
	Tue,  5 May 2026 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYHzMuLN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4EF426EDF
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983810; cv=none; b=M6UCmsV01H6gQ6xSAthsVhzxuWdttjfbtKMpQgwKKf8BlIcwwFvmcop93PVplfqK/oqDO7mH4gwb+qI5EPA7WoZT1Er2Oc5fBld7RYfW66BN7cpjk1C5VSy8whB/8np7J5Y2HQ+cwrVZEMLCzyTAROiQTZwnRbMCH8+b9aBrLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983810; c=relaxed/simple;
	bh=adyJcgIaBJeJsj35M2H1DezeCnMor0uiiAyMw3Z+008=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auTQRXfB3SojOs7z/rf7ZCjC+kNxFSzQekGfC4PM4SSTJM4Pa/AEc61YAVcZFNZk5ar5izGlmngE3MlB01ZkBtJqEVfqNwKM/pNRafAhjh5Raaf5YwijZovMcyux1MAofPiia0H1CRS1G/2/RSMVmaK1h8pSZS3xHw8vH7Z71Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYHzMuLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF6FC2BCF7
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777983810;
	bh=adyJcgIaBJeJsj35M2H1DezeCnMor0uiiAyMw3Z+008=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EYHzMuLNJj4POzijZDiblaWvT1n74Zvc/PValYo/HzJWxD0HMZ3JvEzpcOCzq0QzM
	 Ukc7sJUxsRoyVH/0JreinpR2yD76SPUFKEzOjTJ3LgaWfOKvIUfo07tjjWcFsdkfo3
	 i60ue6tTxj5fjK1CFT+DB8zODMC5CKndH11+kBLmf8lBUfCQoNwH3DPLj541vWZo+6
	 Z20LnuYnEVwRD0B+ok4oXypIv4Dw3yJc/jO9OJq/GkU+JL5Eeqt0yQK4p6tuGxvin6
	 wOrLuwE84xssqQciH08ZNGOBx2qPhWhXsnWg6JsZQvAeiY3rulNh/Z5zYs2TvtwItl
	 RP8KOz52cwbWA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a40502e63bso5268275e87.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:23:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8mvtxiULMbwU+IVLK26KXzUElVLeZFxbHy7a4BLAlQf34M1hFruyfSc6qz+BdN4KCV+iJRUII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk4PJC8VQDhGFRzT7E5llYSaB2F11X1WrRhvsRpPNU/fdw2dm5
	w3r2qqq0lemZ27mjuUw5GE4xmUMF+zcZNjJBoC2Y1AR1QLzn3CkGdXa9w8JCgF06F7E/0iGN/w5
	qUmneOjcQaS2FuaZgibYsE51KKXJ0ZWk=
X-Received: by 2002:a05:6512:31cf:b0:5a2:bf50:763d with SMTP id
 2adb3069b0e04-5a8631c8222mr5653045e87.38.1777983809030; Tue, 05 May 2026
 05:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com> <20260503-realtek_forward-v2-2-d064e220b391@gmail.com>
In-Reply-To: <20260503-realtek_forward-v2-2-d064e220b391@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 14:23:17 +0200
X-Gmail-Original-Message-ID: <CAD++jL=fKJ+oaX_bNs56mUzTpfNtXH94Vx8AfUHCB+GO+eDAYg@mail.gmail.com>
X-Gm-Features: AVHnY4IFSleMB4FJQyjWJ2jdgKIHnpyMjWfGHEzfXwxHlKzFvNaOEjGaFcMASVk
Message-ID: <CAD++jL=fKJ+oaX_bNs56mUzTpfNtXH94Vx8AfUHCB+GO+eDAYg@mail.gmail.com>
Subject: Re: [net-next PATCH v2 2/8] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 35EDD4CD613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284360-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Sun, May 3, 2026 at 8:18=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Use dsa_switch_for_each_*() whenever possible.
>
> For port setup(), a new blocking setup phase was added for all ports,
> including unused ones, before the user and CPU port setup.
>
> CPU isolation now includes all user ports as traffic was being blocked in
> some scenarios (suggested by Abdulkader Alrezej).
>
> Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

