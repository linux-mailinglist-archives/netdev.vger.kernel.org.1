Return-Path: <netdev+bounces-284646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLO3JfSY+mmRQAMAu9opvQ
	(envelope-from <netdev+bounces-284646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:27:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF494D5409
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6A8B304777A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27296257423;
	Wed,  6 May 2026 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCUSum7G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E8F1E9906;
	Wed,  6 May 2026 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778030834; cv=none; b=t1scSK/fj20FUk2tZqKTzkbhYwflCPgrcjY3OLfmyDb88tjBT9flz/NfHfR5zrFlhl/ldOFdftE5Rh9LgtTYuamzR42E62osXoZclc5xs5g6AyKdiBMaJZ++SMzHM78KCz+PvAEAkCYtKknRULQSouERU4iJrhOI0RZ9g/ZM1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778030834; c=relaxed/simple;
	bh=mFXTeeYtti2bxUJkQ3AgwIFH7/s9ZS99sQ2637uLCxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqgv7K5+cank2KgOsv0LT1XQF4hJV09WQ6RXn7bMgiy7m80bmqd4737mxNufeKBAh1BjJ48FInvQ2EdWPppVc3Oh9ruoPkGRxKItBPy6biMI9w0kDtJqBBAQKqSoAsPLJ3X/SERfbF5NNKPiAnAABiRDS0KDufU6EO0yqoMJhTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCUSum7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFADC2BCB4;
	Wed,  6 May 2026 01:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778030833;
	bh=mFXTeeYtti2bxUJkQ3AgwIFH7/s9ZS99sQ2637uLCxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MCUSum7Gjl4qDiR7jZf/hFC6zE4meCzrwTNVmLU3cymnPQBMMQR+mfEMXJEGIEM+E
	 8EC8BAU/GQH50hoahYg+LwHhpDAZYk/w3v40tLg8uP9d/Ef3+56ZoD72S+zpCFp0CT
	 CFY85n9jOFX+sRWn1af9JwCIH9HWCKLL+2VWRz09PLO+rpy6s98bBPckzp7Xox6DyB
	 al9s45ke6jEgIUhQy8hwcYFZOpiL2Of0fk/1aNE1SFIBUGy/slceIhpRDjZaQvhhas
	 gFb5FL4mkqTLdVzSVINj8hjOQRzodddw+KA88awsssLlokFo/qCdAnBlXMo0fHFdJJ
	 S8IgjfBxSqDsA==
Date: Tue, 5 May 2026 18:27:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, Alvin
 =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 7/8] net: dsa: realtek: rtl8365mb: add FDB
 support
Message-ID: <20260505182712.2aa4fb3c@kernel.org>
In-Reply-To: <20260503-realtek_forward-v2-7-d064e220b391@gmail.com>
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
	<20260503-realtek_forward-v2-7-d064e220b391@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0FF494D5409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284646-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
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
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bang-olufsen.dk:email]

On Sun, 03 May 2026 03:18:27 -0300 Luiz Angelo Daros de Luca wrote:
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>=20
> Implement support for FDB and MDB management for the RTL8365MB series
> switches.
>=20
> The hardware supports IVL by keying the forwarding database with the
> {VID, MAC, EFID} tuple.  The Extended Filtering ID (EFID) is 3 bits
> wide, providing 8 unique filtering domains. This driver reserves EFID 0
> for standalone ports, effectively limiting the hardware offload to a
> maximum of 7 bridges.
>=20
> Introduce a mutex lock (l2_lock) to protect concurrent L2 table updates.
>=20
> Add support for forwarding database operations, including unicast and
> multicast entry handling as well as fast aging support.

Warning: ../drivers/net/dsa/realtek/rtl8365mb_l2.c:243 function parameter '=
entry' not described in 'rtl8365mb_l2_get_next_uc'
Warning: ../drivers/net/dsa/realtek/rtl8365mb_l2.c:243 function parameter '=
entry' not described in 'rtl8365mb_l2_get_next_uc'
--=20
pw-bot: cr

