Return-Path: <netdev+bounces-294292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X/pyJyoIH2pSdwAAu9opvQ
	(envelope-from <netdev+bounces-294292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:43:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C35336304F2
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:43:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=cceUl1y0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294292-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294292-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 552CB3007B20
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D34736A35B;
	Tue,  2 Jun 2026 16:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB630F534
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 16:31:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417887; cv=pass; b=AdI5tu/itUP55XPSR5O0caXNAZRJo3D3KEj20J2qWhl2LyLTBFd6J+8GjqaiDqG0ghDHVJITa5Ljcq12qWPmtvvy9kFLzx4ol6i8HOng+WEv0NB82cdE+5qr++8jf9LoCQRopwqJGi37l2qc4WZ7nFHdH5B943XYgZkGyfd4GKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417887; c=relaxed/simple;
	bh=Ow0EB3J7+I7AGIfOsEF2tfgPQ9JCehdz3H6Y23trGbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3rv12n3cVPH/bn1Hg09ADWv8BeqgowUf4Ezf9VW+J5+YyNEy1kqHRiiCMNRJdvdV3gYjynwF1hUqSXjZNzlffjly89zwCapxjWDpSuTTabvTl8bdAXD9/tYu/0LrPuk5zgimFT8bbBZRdw0pfFGcX/7B08WYgH+klH/+AdAxUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cceUl1y0; arc=pass smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c3546924so19704825ad.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 09:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780417885; cv=none;
        d=google.com; s=arc-20240605;
        b=bSby7ccitoGtOmFG3gLEDMQPkT0M3SX2VQy9b1MZH6gJoJeKwvEpZgL9y/lp47hVr6
         E2ZxHXkZuNIwcwOgfNg8xZy0pTF8JhfnRXNkLGh4lLdun7VAxCWV9NSy8KKnfzDNGI8X
         KZLbKUJCECYYKbErhlIV1FO9p9qgol6YgfLmAqSoV7qJcM4TJ4OA38Mcc/n0C7iStA8D
         2A6lCXnMXVre1JRT8VDrqHrsFVVeTNvMX7BVBUCT5BiLDNPa0Rqf0+vDzA9TzNj1UeSz
         AOA1hRJLP8R11Ujz0dD0VnUv7jc9Sk0iY0sxOZM2WV2bAYk8L8dFTY2a66e8j9wRiRs9
         Hlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fscMndvS/RdN8pzUO4KhsRbHP0McUSVYTdx8doi4pUw=;
        fh=ihrO+0kA9Fov7jhsHXYbg9aiWxrn1bDXGWeas8W5KqU=;
        b=Qv7Snp+1WprI31OwIABF240gCsEtbmsk3jITetO0FjA1lcWEWul1uzMsqQcItN4QwX
         fSVlKcbdCpoEEebUfXJwA1QG+leA7vHMBvmlhcPzTwE7soZ7XCesyOxQdoR3quIVXIUH
         VeCZkx9+O0k6uumahWtOg1mH4IeWBVaIwR6AiySdpRH2kxFQ5s17q72idbP+wSM6P14n
         MK/Io3ulW1N1Ci1+Itb8AIFaDUaVRVViWIzcaErIVcL8D20KipLzO7ffK/lu2TbE9UIA
         Fx99jt4mISekrLH0uvLXG1NZLHeHHQlDhe3oKiq88lcx0arDubg0pAvGChGKhDP5mKke
         2wHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780417885; x=1781022685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fscMndvS/RdN8pzUO4KhsRbHP0McUSVYTdx8doi4pUw=;
        b=cceUl1y0mYkHv+w4JiO/kkYE2NJvjvN6RKdO1Mix2W60CY9ZdeOc0+OB1VUY2EgHUo
         ysSpjtTIW9XVA0kQVoguOH6RqL3j7C+PYHnEwG03KkhWVLCvWJBmnB8AVBzNsjM2ehOf
         HI/ZO30m4IFiZe3x9v4JIg86BMvXxGM/cMTs79qE2pdXwvdjo3fu/cWRB44YIS1m9h1E
         kQGeC2f+3C18UsjDoGn3LZnLzOyEpZLWlqmBdmHiDf1rVetbH7anana3HsWy+NSMfGF8
         v/R8yGYloSM4BYRssgO4icoM4+oTrFMZM8oTd3y4X+OHfCn1laooeRYmN0IV03nAdqS2
         o/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780417885; x=1781022685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fscMndvS/RdN8pzUO4KhsRbHP0McUSVYTdx8doi4pUw=;
        b=OFhUSPRV8a3EMBmLYLodBQ/e+L+7MsXWVHzH5MOz58A2L7B9wSgsR8aKSKu3IOCApS
         2ERORzRuwVDqyCtavDWShJTgT3Z13KyXLNYgs+r8K+rNkgiWC6g0kJd5WfSnhK9Pg8mA
         ikzvgt6mkrbUauMO/900tn2/1dIbqwyTyE6QB2Y3HMqezKpAhDRtP7yYwcuMD6hCgBmf
         PlJq+luDnsZrl1GYiJAOKg6V5MrpDsjZSJzotZrw6JkItVKvKCxQCtMPbnh9QpqVc+Pw
         BaS0AEn9G+waTsQYVTEYvW0+l/d5731Hq0qUSR5gYsgfA1xwzHyhvs6aNkUyw7LEUDLY
         q/5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+SOj6b6O6OCD5gluJyht3t6JMBFmR0swgNFZSiCKGMjBYUm2lgbc/ZZCwdzaQC9JC1fLHZSck=@vger.kernel.org
X-Gm-Message-State: AOJu0YycX4ChOOp8EAtkKJ+3yKkMFMvF2AJNAETliCC16Abrb/RMzYGf
	mqsZvER+uA97eGWR4UhfyvGF1SM1VddrBsGmBL2bk8I0k4vwGj50xGS9SQ7ygQaTaSBY4TZXfs0
	gSZ03iHQOqWPdlVHPgDVtK3jTfFfExhWct6eO3E/q
X-Gm-Gg: Acq92OF8C8pRzg1nhO8KPw3VMxCJvYnShNI14JHvCJFgr6Hcbp16PCLBPHtLpwuqZlY
	hP1O6mvynkfAuQUO5luwk35GCq892kGOOITTTvGwkc7r4eB9KZQpm02G7sLfcYC7DtJJootkm3W
	2i/H6l2aZdXgePRs5dKgRF/qo2njJSx7Vn2jbuCAgDuWufEBrmw8A6WoocezmHAJMeYDUkNgfjB
	QZKL1hRfxvZy+GKtl8vDK+7JQ7rkxCfueS699aJVYPQaeH70ZxoUDU4uoOm43Wu19aak8aV2XL0
	eolvYGdB+3dRSTmkaQ==
X-Received: by 2002:a17:902:e5ce:b0:2c0:ab82:6ba9 with SMTP id
 d9443c01a7336-2c0ab826cfbmr164171135ad.33.1780417885398; Tue, 02 Jun 2026
 09:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah8BzqSmZO40xYhS@sirena.org.uk>
In-Reply-To: <ah8BzqSmZO40xYhS@sirena.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Jun 2026 12:31:13 -0400
X-Gm-Features: AVHnY4IjB4rzIJ_BZRsLHOWTBgQXVWkilvI4MqI_CH17d78U1aoUDdF7OL0mWL8
Message-ID: <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294292-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,paul-moore.com:dkim,paul-moore.com:from_mime,paul-moore.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C35336304F2

On Tue, Jun 2, 2026 at 12:16=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> After merging the security tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> /tmp/next/build/security/hornet/hornet_lsm.c:212:36: error: too many argu=
ments to function call, expected 1, have 3
>   212 |                         if (map->ops->map_get_hash(map, SHA256_DI=
GEST_SIZE, hash))
>       |                             ~~~~~~~~~~~~~~~~~~~~~~      ^~~~~~~~~=
~~~~~~~~~~~~~~~
> /tmp/next/build/include/crypto/sha2.h:14:33: note: expanded from macro 'S=
HA256_DIGEST_SIZE'
>    14 | #define SHA256_DIGEST_SIZE      32
>       |                                 ^
>
>
> Caused by commit
>
>   c62310df81899 (lsm: introduce the Hornet LSM)
>
> interacting with
>
>   c48c3a7e7d5be (bpf: Drop redundant hash_buf from map_get_hash operation=
)
>
> from the bpf-next tree.  I have reverted the latter commit, the new LSM
> means that the assumption in the changelog that there is only one caller
> isn't true and it seems like the most straightforward approach.

Thanks Mark, we're taking a look at it now and should have a
fix/answer later today.

--=20
paul-moore.com

