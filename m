Return-Path: <netdev+bounces-286355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN9yA5HBAGppMQEAu9opvQ
	(envelope-from <netdev+bounces-286355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:34:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78C5056EC
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61EA03008520
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E46F3B27DB;
	Sun, 10 May 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyNIcr/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF2128395;
	Sun, 10 May 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434446; cv=none; b=CD6emKvoQDKykgtPWuJMDPiNVveqJaKPtPUSkEWbq41llztX7H079OZHsobDY2ViNdoEPe5DpHoboHmFfBeEgzGCwcgImYh0JsP2p22YLJAp1JVzNEM6S08+dTrqBMHwKB5SddK5YRUe6qN5SQDLVOlQR+ifTzCf1lN6bGPrL60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434446; c=relaxed/simple;
	bh=Jru7/l+BDYpDPfTVh9lIW13IaWEAz6P0PLFOWsCC8mc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0+m3g2BdWSc+6wsiJSxmgc5YVjoHNFwdj6fcFfgjtoJyXIvtJ7nlSINpW+70ldpSwHh40I5/BlX1sbtOXNv34zX6ONudqRXKtBwS9BxDm37sm2dzEQT0FNRpcZYh5cDvP0GMPrhL354/vY+FsU6hRKicGQktgFmMZJ6Ck8lEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyNIcr/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3F6C2BCB8;
	Sun, 10 May 2026 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434446;
	bh=Jru7/l+BDYpDPfTVh9lIW13IaWEAz6P0PLFOWsCC8mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UyNIcr/WycOGm3LZrYgvKZuyoBo4mUc8/cnW1jTKl/8s2PfecUJOXmAQt5cpf3Y9z
	 1uxZU9X3WlqVdo+SvVItchpjOWaJB074rj4p/iiEYyDE6o8KrKz9X0woKur73/4zpQ
	 h6669BgpuFnsNjD4M61r4OvzeUwhYes9066S73ElQkLMiNoUQ2iw+vxrCFfl7rVb9o
	 2cucYZ2jpUlu3IMi/YS8yEtyxW+vBIM/WlLEFE+CseL5ZZ+I2pMQuT2nUB6cRm6bcC
	 1wTg0kTwnHDCQ/r9x9inEi/68q9JRcard2Zm2L6IIZMbOj7hr2EvHJKijpC6GhWPtD
	 +YYhN8KEeHilg==
Date: Sun, 10 May 2026 10:34:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, Alvin
 =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abdulkader Alrezej
 <abdulkader.alrezej@gmail.com>, Yury Norov <ynorov@nvidia.com>
Subject: Re: [net-next PATCH v3 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Message-ID: <20260510103404.21b60138@kernel.org>
In-Reply-To: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7C78C5056EC
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286355-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 06 May 2026 23:58:17 -0300 Luiz Angelo Daros de Luca wrote:
> This series introduces bridge offloading, FDB management, and VLAN support
> for the Realtek rtl8365mb DSA switch driver. The primary goal is to
> enable hardware frame forwarding between bridge ports, reducing CPU
> overhead and providing advanced features like VLAN and FDB isolation.
>=20
> Some of these patches are based on original work by Alvin =C5=A0ipraga,
> subsequently adapted and updated for the current net-next state.

Could you please look thru the feedback provided by AI bots?
Most of it looks kinda subjective to me but hard for me to evaluate
the HW details on patch 7, especially.

