Return-Path: <netdev+bounces-294344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NuxBLz0kH2o0iAAAu9opvQ
	(envelope-from <netdev+bounces-294344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:43:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D8C6312C3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:43:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=EI35RztN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294344-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294344-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AEBB302ED7A
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A539768F;
	Tue,  2 Jun 2026 18:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1306395AF3
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:40:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425625; cv=pass; b=LXs6nxjKwjo/VD0oNIdb8QJ81+GRGoPTL8MXHiJi/Z8JGgn5n+hdQbOhWCUSKvWTSns2ZPwC8FywTzRrGamFP+WXUb+isZt6oikvp9WRiygvRG73oVsWbwXx9kdDHn+JtLjGlFSDac2LOKX5IF0MQ9PY55RG4x0hdsUboWwVl4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425625; c=relaxed/simple;
	bh=WA7l95NuW7yFcNCRtIvefhqHj1bJWeBjBhmpwS0AQds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWC/HKfTRHdIT1Jytb0Q9+e+2gu7FCfzrRjXciddj/LZEg8NQGU69F6p/vkB9raRh/RDlIIU4Kb6lwXniODUeADdX913cIAfkL5LSOXqpcAy8gyTRCqKxPQqELnVJY3Dsv4mrstcZQBPl2GeSv7XQTLlyF/XP5aFAycgAjMbRuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EI35RztN; arc=pass smtp.client-ip=209.85.215.173
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so2335021a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 11:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780425624; cv=none;
        d=google.com; s=arc-20240605;
        b=hMf/mImdo1gU6r7nb/ZrP96UceEy2RtiJj8TMkNxtumfwU8rLduuZWaZatoj/HLvCi
         4v2UBCV5eKk5X40uSCMv8HXhc9zpb9gy3qPnxDWGeMTD/4i2/lvBJ0J56A2eZE+8OCsM
         iSUVxH/eH0qit5FBAuzp5ZVw1AwhbGPRSx+H339q7ywJCyew7c78fwoxoUbX9z2Eb7Zh
         EQ6qT7GyRCtRJtaMQWYDEwlotnZgc0AW5kWqj2SkSF09UIpraHmW2JbC9Ju/MftNBpjo
         OpLIXs7MPejQThSTi7f0O84FS8qskb8CnmV99GHY1liSygLDLD0xnciMkY+BSmhY+oon
         psvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rfh9WdBs5XOXY44y294ac6EXxBbUnL31MDufdlNqOTg=;
        fh=nrIAeZQS+l013hup0YRZFQVBAyDaoTFYiTuirUVxJ8Y=;
        b=jv2eKHTR8TJtE+HnDiCDjLSvDHGTCuvrWTm2LrWjeXHBoM+mLCJHA4BM8CoAU0UuUR
         nERNRnK2zflIgy0+R2L4gv0cNuPooCwS5eDnVvg2+cEpJCcIL2sHpVq0fsKXsfCp8IZk
         Hqf050elF0QkFKLwnM80QOc0QhE39Paz9L9Fkomxq31mMtjKnWZDi4RSWRoUGARLaf7a
         ByHcnVY6ECGxFaUJm+ySLCx9LONRvMXVU2kkXPKEz8ORPXJVGNOKg3/v768PkKavQ6Y9
         OQr5TRH2ttbrjPp7evrZCd0c+zwwZc1Bum+ChcYQriT8ObhmYJdMNUFUHeofqawzD+Bh
         C6Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780425624; x=1781030424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfh9WdBs5XOXY44y294ac6EXxBbUnL31MDufdlNqOTg=;
        b=EI35RztN4TEm5SbgtgQnyT6eGUU5sgcuBmOFp5ybOirSL/arndAPH43Xm/sc/fu1iv
         G3n1o3yDLVVc8pKP5F5fslIroK0BRZ81N85Dp1X04B7EGWD3JmBzYtDkJiuXSGS9zIUm
         cY6DJEulR61ALbbn38Gcla+FKtRASkDV5UWFwYwOTlgzQgcFMMG+6ud+VkU/ZdwMg1+9
         U47H1LMyHS9dh/326FbIGxwEwbCGRU2XJ1SRvwssIkenqXLMUNJ2qBinitWw1j27L/Kx
         kuaRYp3WmFNptm3BeDwNh/+ylNh6tBM5hsg8glFQdfXe/VmuYa3XIG0pfzAROUCNslHh
         CQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780425624; x=1781030424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rfh9WdBs5XOXY44y294ac6EXxBbUnL31MDufdlNqOTg=;
        b=tXPOXPKtjVknoZzVBwgV/OGgUzu3XMxMA9qZIXNVle1yYqZlVyYo3w+TyNpk1a3uQp
         1OG2Nl4OQJ2JrIulNFZtvR3zaM7FHAR4GbG+Q0z/4NNuSNz++hi3/NfJo6D+3sU/4XTe
         KksTx/sSS7aLXhRhW44FQcWngmGCfjridufD2h9hGgayBCZdP6qjr11vzdtT9aSS7IC1
         y9oj76O9U5b+kPIQo20XJRPytZUwkBydpvv3//BoLZjJRPFkcE0fgXPXNySdE9sgmu04
         SEs5TJNY7UMYVlz75AxD36Q4QBvj3uQTtVJgI/Vwlyp9t+YsHzP5u7P3Y/udYeEkSY+q
         +KnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8+QqJ2aRc+Z6SJ6QhC/BjRW3rTRUlZl6LI07nCAnwTbeqAG4ny2j3fHXjet8SQ+Akw0qivBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9NwapDGokyrbbby/74fjK/XnYI0xgeLbPRMt9K6q7y3aS/+gm
	8DYCtddxqsp2/xYaTND6dQcMfUSBonbWISAXuRgvvlYLuS0pCEiAjSScGs4b2HDl/onJ6yv9MCd
	kZxtic1e3uYKPCas3xJKxw8Xr94zfLwmaGJymRu13
X-Gm-Gg: Acq92OFY510OBKOHrv7O/wzO0wynEvn5aRs36wQ1p9An2QiowESX4uz6UE6V949gRdz
	/tsiI1RNUvLMAH/zd8b1nVqu12LwRbc2fb8KRVhNQR5RM1/sBycS2dBLJWS4UvIfKX9XK1kXpTX
	uKkX1Ge6dczbXwDoTi4hxNB76/zG0F7P6as5zcpWEyTAwe72y80rdkwMmexHz14nr5MRRF6W7B1
	EWdHmUwS5YQBw3vaB/vTnoynCmtwaaWwQs/CLTbzSoS/COVsjTcLR+zqXXiqOWRVQOgm7Z41kom
	xJJJf8HnBK7c7giYgA==
X-Received: by 2002:a05:6300:228c:b0:3b4:6a23:6ba with SMTP id
 adf61e73a8af0-3b4978a0a35mr69451637.26.1780425623852; Tue, 02 Jun 2026
 11:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah8BzqSmZO40xYhS@sirena.org.uk> <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Jun 2026 14:40:12 -0400
X-Gm-Features: AVHnY4LseEdZ3PSnzNXG3ZVT30xvrKptf0DJmetNk04_9qty-3SQmPQjrXm0JY4
Message-ID: <CAHC9VhRPbkVYAMec0KG55er6GOPdKqMXKdpC8rrHgiAodSv-sw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the security tree
To: Mark Brown <broonie@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294344-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:broonie@kernel.org,m:bboscaccy@linux.microsoft.com,m:daniel@iogearbox.net,m:ast@kernel.org,m:andrii@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0D8C6312C3

On Tue, Jun 2, 2026 at 12:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Jun 2, 2026 at 12:16=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> >
> > Hi all,
> >
> > After merging the security tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > /tmp/next/build/security/hornet/hornet_lsm.c:212:36: error: too many ar=
guments to function call, expected 1, have 3
> >   212 |                         if (map->ops->map_get_hash(map, SHA256_=
DIGEST_SIZE, hash))
> >       |                             ~~~~~~~~~~~~~~~~~~~~~~      ^~~~~~~=
~~~~~~~~~~~~~~~~~
> > /tmp/next/build/include/crypto/sha2.h:14:33: note: expanded from macro =
'SHA256_DIGEST_SIZE'
> >    14 | #define SHA256_DIGEST_SIZE      32
> >       |                                 ^
> >
> >
> > Caused by commit
> >
> >   c62310df81899 (lsm: introduce the Hornet LSM)
> >
> > interacting with
> >
> >   c48c3a7e7d5be (bpf: Drop redundant hash_buf from map_get_hash operati=
on)
> >
> > from the bpf-next tree.  I have reverted the latter commit, the new LSM
> > means that the assumption in the changelog that there is only one calle=
r
> > isn't true and it seems like the most straightforward approach.
>
> Thanks Mark, we're taking a look at it now and should have a
> fix/answer later today.

Proposed update to Hornet, assuming this looks okay to Blaise I'll
merge it into the LSM tree (and either pull in Daniel's patch or base
off bpf-next so everything builds correctly).

https://lore.kernel.org/linux-security-module/20260602183658.161744-2-paul@=
paul-moore.com/

--=20
paul-moore.com

