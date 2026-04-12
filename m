Return-Path: <netdev+bounces-277879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM0QBH3x22niJAkAu9opvQ
	(envelope-from <netdev+bounces-277879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:24:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 696533E5B1F
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1251430097F8
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE22C08BB;
	Sun, 12 Apr 2026 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pdbkd0MD"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE163624D4
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776021882; cv=none; b=gbkM+MyHCD1ZpTROHWuHAariMLuwkwTsfnTY219uRivb0rXRjFOE821w/RaV1IdmfS9PJSHdl8lvVg6DXQ0hV0KMXH72tgsHoKqx/H8cJqKN4u0JFQ6lTcBE+dmVkVUuOd0g1AovzU+48xdiR2ZSkr+D8CpG5Ft3N8JLrWwVpvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776021882; c=relaxed/simple;
	bh=Iy3hhlwzu20rJFN2tuJlW97lY33vaDiPnXe0xqQOhSQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ieyWth8E6YsNjJhSPIOukkEe2jpawP1UTqDW34h3rJ1H0Qi4mMHM2yOzm+GODsBGzIolYPAZ/vBjPmKyiGANI0wEPfDQx6gQ3w6jB6ytn7zaYoFooH7pqrOIjdiAKGam+ttd04AU1b3VAIwecYebIZ6/Rb8E9mBDiOtaJ17yx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pdbkd0MD; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776021876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iy3hhlwzu20rJFN2tuJlW97lY33vaDiPnXe0xqQOhSQ=;
	b=pdbkd0MD/ZPOv2q7gy0vwIbn+SPzxhxnX8WgErYwxbyVXyh8pmkD5k/fsVyqPSPYg2dcCz
	qvMZXkhAxkg8zPTeQYXnEgS4RsgqdnL/vznfjFoJoJ0j8Gr+2mDk8uMFZhh/JY35WARTLa
	lqJXuoAQ4Z9Ot3NIa1CZQjMKC0SGhlA=
Date: Sun, 12 Apr 2026 19:24:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Frank Wunderlich" <frank.wunderlich@linux.dev>
Message-ID: <ee4d27c8bf587a66953d8705ccbaecdffdc66d68@linux.dev>
TLS-Required: No
Subject: Re: [RFC net-next v5 0/3] Add RSS and LRO support
To: "Jakub Kicinski" <kuba@kernel.org>, "Frank Wunderlich"
 <frank-w@public-files.de>
Cc: linux@fw-web.de, nbd@nbd.name, sean.wang@mediatek.com,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
 daniel@makrotopia.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
In-Reply-To: <20260412075402.2eda04d3@kernel.org>
References: <20251219151219.77115-1-linux@fw-web.de>
 <trinity-1304ecb5-9a3f-4e37-b2c6-bcd7f35c2921-1775995067670@trinity-msg-rest-gmx-gmx-live-579dcf886d-nkpds>
 <20260412075402.2eda04d3@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277879-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,public-files.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fw-web.de,nbd.name,mediatek.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,armlinux.org.uk,makrotopia.org,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frank.wunderlich@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 696533E5B1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 12. April 2026 um 16:54 schrieb "Jakub Kicinski" <kuba@kernel.org>:
>=20
>=20On Sun, 12 Apr 2026 11:57:47 +0000 Frank Wunderlich wrote:
>=20
>=20>=20
>=20> some time has passed without a single comment, so i just send a fri=
endly reminder ;)
> >=20
>=20You have a lot of people in the To:
> Could you clarify who you expect to action these patches?
> Patches are an RFC and I suppose ain't nobody got much comments?

Hi,

imho 11 people are in "To" is not much, but i was told that no comments c=
an mean
"OK so far" so i will send v6 soon rebased on current net-next.

regards Frank

