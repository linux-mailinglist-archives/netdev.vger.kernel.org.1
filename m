Return-Path: <netdev+bounces-299780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iAc0LRwRMWpcbAUAu9opvQ
	(envelope-from <netdev+bounces-299780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:02:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E26568D5B6
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:02:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mhgcVyf1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299780-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299780-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4BDE304546C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB463B5835;
	Tue, 16 Jun 2026 09:01:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728AC32ED58
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:01:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600518; cv=none; b=JagJ01nB19S3e19Do4eiUtWD6kuYdlyZweyBgewnWziR34vmAq6yrh5chovNXb6rDAHWpqqnbZWmE6lR8cXSkAvK6Hja7QeOxo05aF2UpnhBEz4MH31AoIJzRRRKko5SZQnpm4yBuzl6w3CuFIhxerlUbYa8mcTj8WA7R27USyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600518; c=relaxed/simple;
	bh=+MGg1Zi65E6mCYU6kjqX5GheEVXRx5541DIm0X9S3sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5e5fILjTwsXB8wNAHgjlnkEuv2H533w4OvPPlUHR5OPnktV3oAqTT5cPYClc2cUqbtPSiGXxgck1+8Y3j13yIOqmIS7bQKbkHzhaU2pjFiOcVzb8/nW2FHgLucUjWBAPG8rHns/e2bzOkStb1wrGcTpnmqVICOib6ystYoBwKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhgcVyf1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BC51F000E9
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781600517;
	bh=+MGg1Zi65E6mCYU6kjqX5GheEVXRx5541DIm0X9S3sY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mhgcVyf1dSlxckwHoqZ9eFaHHvoonGLxupvjuJYBu4rYRHOjCf0IZ+23m4NcbiljB
	 A2Fjdmlt3d3+xidyD9IgVzp6C9Cqe81gL+U73raCMbwv6NRSFXvpOZzvDz2Qg524ea
	 2ZBQ7v9JN1RmIw591yTAUuU5dfWmujHuBVXhEzgIn4p0xOoEe8imkRYEb0qDKYgG6b
	 kdTBsQ14AVN9Y8bM2vi7QGZSXxCkXI2rsL/QP9VlT+6mFKbqfus4LM4sKjQ/sXCnLD
	 QfzdlPGQfnmTE3UHqhchZjDuGiFfn6qHYcs6tGi/PKWElk66Hp4AihhXSwxF4UPWMW
	 Mk+mW9W0CYdeA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68cd8dd3so3915190e87.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:01:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8GG6gybNOwcZCzqqQh9G+EpnvqnSHHbvgB2IhXqsd8oHSRHJ8PYPUpBqFqvmpfklkQrzngNhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtwQRiao5Kg3+LmG4bijP+YvykuPAVFb/Cwflyt3FQ1t4fvLK
	gI5h72ktZBTYIoJ3OEpRXWX8f++QaHz/oru+yCQP7vz8Cl0ivfbZ0c7Axnr7X4huRREL1O4OSVX
	Hd+dsvAr3Z1Vx9Ln6uUYB/5EkmPE8kBc=
X-Received: by 2002:ac2:544b:0:b0:5aa:6e3b:1421 with SMTP id
 2adb3069b0e04-5ad43316f5fmr635675e87.15.1781600515886; Tue, 16 Jun 2026
 02:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org> <20260615180113.13fca89f@kernel.org>
In-Reply-To: <20260615180113.13fca89f@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 16 Jun 2026 11:01:43 +0200
X-Gmail-Original-Message-ID: <CAD++jLkVWAdsvmj_y0ZQBSVJZ7EoP8U2i3Bm7Q2+9nh7EB9OnA@mail.gmail.com>
X-Gm-Features: AVVi8CdPT1szIytXRDSBUC4xB58yGQ3WdeDDEm5Wbw3ljMt-0-ShgprPk2K0w4k
Message-ID: <CAD++jLkVWAdsvmj_y0ZQBSVJZ7EoP8U2i3Bm7Q2+9nh7EB9OnA@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: Fix skb ownership in taggers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	"Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wei Fang <wei.fang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	George McCollister <george.mccollister@gmail.com>, David Yang <mmyangfl@gmail.com>, 
	netdev@vger.kernel.org, Sashiko AI Review <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299780-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,broadcom.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[linusw@kernel.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E26568D5B6

On Tue, Jun 16, 2026 at 3:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:

> Impressive. Thanks a lot for doing this.

The grunt work was AI assisted actually, I just took a deep breath
and jumped in on the deep end and vibe coded it. If AI finds the bug
AI should help fixing it...

> patchwork says it doesn't apply to net. Is it on top of net or net-next?

It's on net-next so it covers the new tagger, since the merge window
opened I just guessed it needed to be "net" at this point.

> Since the merge window started already net-next is probably better but
> you need to designate in the subject correctly. Feel free to repost
> without the 24h wait, maybe we can still slip this into our main PR.

OK I fix the improvements pointed out by Wei and Quingfang and
repost tagged for net-next.

Yours,
Linus Walleij

