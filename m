Return-Path: <netdev+bounces-299710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u3U+EjqvMGrUWAUAu9opvQ
	(envelope-from <netdev+bounces-299710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:04:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2FA68B61F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:04:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y5mhYYkv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299710-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299710-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B47D23017C3F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017C63A5430;
	Tue, 16 Jun 2026 02:04:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4836F8F9;
	Tue, 16 Jun 2026 02:04:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575478; cv=none; b=jhsrRpuMhJj7FGy8Ytk0EGViH/nuDl1rD5E13RYQDc9n77J1vc40Q/4Nq2yxMZcxdvwqonPHXglijRwAD9i2Zsm3zpjWWdO9P8KIHLOArYc4YOpIb9O0LK2h+rGj/l/j3eUrw1w7eQFIqefEyD2PC64HAvJAs9ibqd2tXUfogQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575478; c=relaxed/simple;
	bh=U5oPM1horFdKZDWIZd3XTBMiJ7Tvuzk5bxDKLuXnnco=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLZf7s1wY6+kz+vadrZY7aTZ2pRpjhOW3QUHfpfLAfgHvQpmPukj31Aj18EFG9FoCjjcmCrhi6/XXMhiTv4mRpD/6Tpwa5/8Bk9VFQOh6Khq0tmDPs4caTN8ZMTiUFd8RFGtDqe4PwepNGNi4ceq8x8k25Iv6b7bskwEXNfJ4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5mhYYkv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B5E1F000E9;
	Tue, 16 Jun 2026 02:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575477;
	bh=Ynt5Rv/FX8cb2j96OmIo8MCXaTk9mcGzKiQ3nlHp39s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y5mhYYkvansAIvT3Hva6QceMfiuFfZeDBYczpkQqd5K5mLQcgstTkkYXGMiZe1SbN
	 +9yzyG7ffYCbYvmYGSKCnPKwDLb8My++8BAflvI3NluL/L8WKo8iy7zwfVrIuP8xY8
	 0JN9ff0/mAGDquUVykk8Qs0ElBIGY5XXoaOB3tsfZ2pY2jDis/8Zj19SdohC++nakK
	 8yAz0ltok9dToMeczqsZp1dDHEmSpaEcZsuCk0hSImkURCeNa1ANzOhPxsOlqfkKXX
	 SvxqX0HuIbaFhxVXkpQHc1qEQeKeS2UzHV5+cBHVJfrWWA8w2ugHTyaipJQ+dHPL39
	 sFuAttQ4CEbAQ==
Date: Mon, 15 Jun 2026 19:04:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 0/8] net: dsa: mt7530: modernise register
 access and add two DSA ops
Message-ID: <20260615190436.4b87d50b@kernel.org>
In-Reply-To: <cover.1781500517.git.daniel@makrotopia.org>
References: <cover.1781500517.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299710-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:chester.a.unal@arinc9.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E2FA68B61F

On Mon, 15 Jun 2026 06:20:55 +0100 Daniel Golle wrote:
> The mt7530 driver carries its own register accessors that predate the
> regmap conversion and now largely duplicate what regmap already
> provides, including locking. Most of this series removes that layer.
> 
> It first moves the MDIO bus locking into the switch regmap via
> .lock/.unlock callbacks, matching the PCS regmaps, so any path reaching
> the regmap is serialised automatically. With the wrappers no longer
> adding locking, the thin mt7530_mii_* indirection is folded away and the
> remaining accessors are replaced mechanically with the plain regmap API,
> using the coccinelle semantic patches included in the commit messages.
> Open-coded register fields are then converted to FIELD_GET/FIELD_PREP.
> None of this is intended to change behaviour.
> 
> The last two patches implement .port_fast_age, which flushes dynamically
> learned MAC entries on topology changes, and .port_change_conduit, which
> moves a user port's CPU-port affinity at runtime.

Oh, v3. I guess the kernel.org bot missed it.
Too late to apply this anyway, but also you put the zero init
in the wrong place AFAICT.
-- 
pw-bot: defer

