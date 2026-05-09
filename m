Return-Path: <netdev+bounces-286107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNUYNXXP/mm1wgAAu9opvQ
	(envelope-from <netdev+bounces-286107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 08:08:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA64FE313
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 08:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30884301AB80
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 06:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D014272816;
	Sat,  9 May 2026 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="lEQy6HL0"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0DE23ED5B;
	Sat,  9 May 2026 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778306930; cv=none; b=k8UPxxZE9JoUm9liA/1lyjGpet/XXPJ4kCmNnh7nXbjjWYSCVtQwtFyaVim0cc8jZc2oPQWnMKxDxE9UyTEePyYrjls38lsuKrPxMFd+fkz2wIYkE2nZMmrJaVHj3NH2euLX8c/P87PAWyBy5+3GAbr6Oc7+3Bzzs69xUMKC49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778306930; c=relaxed/simple;
	bh=2A0Y1EUHnBXMXaFDrfT1TT9FuGuhv6XNN1gNQPCjx5o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hnCXgqsIO3mBeNdqgwb3TnBz4+wGlzjkJy9nwMaSEJ55yBeeIbc8eaLhDkmd2RNL0B0+kAW1BT4dRwg66NlKKrGiA5v6sXuVc5CZ5Uac4na9sPY3HE7ph/FsARl/TPWGJDj7OdQTuwOYCkxjZN/WGkRSv18/VdL23oVB0/1zd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=lEQy6HL0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1778306926; x=1778911726; i=frank-w@public-files.de;
	bh=7inpwn0HtKtqYpktRAtU9KUks5rNpZST1fRF96g/GZs=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lEQy6HL0oNWn1EB1BQHCtIXOrjFU0w9kg4Hms6OvXhyNILbltLlm+SIsNFc4qF84
	 Ve3kspb9Itjk+NBgCqGnKUSLqE98im4IzBbs2Q5L1RTp6AQqE3SfGB38IY5m7E2hm
	 SoG9Azc5uHeTUXRa32Zcgmag0Ph+EFugZRsMNVwkHRRna7U6X7MB/Mv3Dt6viMaMz
	 fs8k+6PeBN5srYynKl9NVSRYcdx0UVZdSRTGKOYeLB+ZWpM7y9XkD5mCzLtdP67Di
	 9Q9bd1KJ/cSkuOS5vchSqIRcguD6NjGXtV1NsY4Gam6NzkI75EUOCyjSjewIy2iBU
	 4V+gOhK6B6yezBHdog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1vLpGQ0oL2-00sLA3; Sat, 09
 May 2026 08:08:46 +0200
Date: Sat, 09 May 2026 08:08:32 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Jakub Kicinski <kuba@kernel.org>, Frank Wunderlich <linux@fw-web.de>
CC: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Mason Chang <mason-cw.chang@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>
Subject: Re: [net-next v7 3/3] net: ethernet: mtk_eth_soc: Add LRO support
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20260508153702.69b89021@kernel.org>
References: <20260506192806.143725-1-linux@fw-web.de> <20260506192806.143725-4-linux@fw-web.de> <20260508153702.69b89021@kernel.org>
Message-ID: <F846A09C-2976-45BA-82E1-43A72C61F06F@public-files.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Fw+uGzBVIce8BVQJfSzFIjv0sVC0ga0ESLDoMetxLliCW4iTv6
 PMiDXJCRv8sx9oe98AiRrerjaW83pSBefZdVD1YnJuYQ0rYGYAUH1wmAWHIHPTFB81T1dnI
 hYjGV51B/9gOJ3J90tCpDdoOMWR3l6L8zdeAXbgAuV0JAi2bMB2n4dO2DWbOPXAvRe0GCfx
 G1dz000Mv33jnogCDmfwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yfrTgDzM90A=;mVGM7PZe/mCFeoOmxSTbdZVM8eV
 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
 NDtoGp8jTmrA3Jg==
X-Rspamd-Queue-Id: 44BA64FE313
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[public-files.de,quarantine];
	R_DKIM_ALLOW(-0.20)[public-files.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286107-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_REPLYTO(0.00)[public-files.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[public-files.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[public-files.de:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frank-w@public-files.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org,mediatek.com,makrotopia.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[frank-w@public-files.de];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,public-files.de:mid,public-files.de:dkim,public-files.de:replyto]
X-Rspamd-Action: no action

Am 9=2E Mai 2026 00:37:02 MESZ schrieb Jakub Kicinski <kuba@kernel=2Eorg>:
>On Wed,  6 May 2026 21:28:03 +0200 Frank Wunderlich wrote:
>> - fix u32 vs=2E be32 reported by patchwork check

>Have you tested this? I still see an extra sparse warning
>(install sparse and build with make C=3D1)

I only tested functionality as i had not figured
 out how to reproduce
these errors till v7 but already noticed that there are still some open=2E
I had to self compile sparse and call like you mention=2E
But I already prepare v8 where these are really fixed=2E
I just testing 16bit versions of ntoh/hton vs beX_to_cpu=2E

Sorry for extra version here=2E

>It'd probably be good to fix the pre-exisiting warnings as the first
>patch in the series while at it=2E

I send out v8 today=2E But good to know that no other parts
need to be changed :)

regards Frank

