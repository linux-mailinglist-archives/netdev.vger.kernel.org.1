Return-Path: <netdev+bounces-305640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4WNbJ5DSTWpe+gEAu9opvQ
	(envelope-from <netdev+bounces-305640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 06:31:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA3372198D
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 06:31:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=luLGVtoK;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305640-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305640-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE12630045B4
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 04:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0533373BE9;
	Wed,  8 Jul 2026 04:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84884307AC7
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 04:31:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783485069; cv=pass; b=sxC9o11aHt29nJ+nOe/CPPcMlFNbw18rWOxkO1U8hoJhLxWgvrSZKAet+FjZIMv9lW7t3+Nt2zIX6wTJADeayZr7fhsnnfmSOi2osXhP3ZfUWgODiYaivXkgdGDGGXCocC2dLfthCtR1KmDFa4zhJyh7QSec7RT+pgMcuRfBLwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783485069; c=relaxed/simple;
	bh=tUDkASecqLwGKSNtjFZRMY5P8qo0UCmZuf/kuwMqhTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9it64DNMWkJJViC8t2CiM0KwB+lf2q4gVEcF/bFyPCWceSkAceJS5IrOLMLE9DtXeCePJGGR9wa8KDpdiu7nbQKdUs2IWBAS2ZknsEkbOL1pAkR0d2br2IKxYbGiKCFf55nzGrPUO4noHd+FzsY3qaAQBTlH1ZR2E6bjsMAFuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luLGVtoK; arc=pass smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15d47266baso2063766b.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 21:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783485067; cv=none;
        d=google.com; s=arc-20260327;
        b=m0GyUDHFHXHxJz4L5OcZ3Zkkmknk2j68KrzPvrj3klGJS/1sb2cx83IT6T7o7lZBjv
         0NzHjQy7D+bZse8xZShlANLyr5UHGHbt6NIjO8uuFvspu1TO+0p8ca4WE60useBTYBtv
         RgiVQNEjOBz6xkUOvj4e0g3kuBNfmtjQxrioKx3Mt7yGLKiia9wmKXvBeDsOYJNX2oiS
         zM0eDgBDt0R4jmzb2Wc0sOGz8fcJs7wgQogLraTky/+XV/AYSS8WklOLHpKzJd/CT1jq
         emmKkt/CivPfUQ5+vF/cuGhu43aD1pZhRLADFwf0IHjftdBdQz8AEyOq0lByAyQeMGOJ
         qXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tUDkASecqLwGKSNtjFZRMY5P8qo0UCmZuf/kuwMqhTI=;
        fh=CDsjDYjRMQYwUK7h3MaNR/Z1OLwB+mLxuZcLjTFk7I0=;
        b=JzHfgbJ+EMfUgzMWj6pDsb1r1ZxWYpzlMpsSP2j0WPNz5K84mL4E+XLtcaRhQkpVNm
         TLN8VtYut75Kat+uW2SZlSaDrOOSR4mwGVyfGr9FYNe2v7Dktbyoe5qbznB6okp7hag+
         Uy3TZv1ZwfsZYBJnGA+O9LaB1FMldz6eeIzuohrDchqP1HZhoiE2kup1Eu3RqJXCOzVK
         PzsDZK8ScmUtRnJqWsqCJ27n+MZduRRSxpRozvKnPkhC7SGRHdlsvablXY+LleXaW9pU
         BC3ZVHs4sfAydMDeMqEcl/KFq7H9SMoqtB3U+DfhR9v1qhk9Zk55z6kkUhSEiNGP/ng/
         FRsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783485067; x=1784089867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tUDkASecqLwGKSNtjFZRMY5P8qo0UCmZuf/kuwMqhTI=;
        b=luLGVtoK999fh1ztNotOVodoUNbDtwNIUUiZ4T1TH5gUJTiK5HOSPetHx0fm4HX2Ka
         yIHQOk4jHAFjZplHVW3HUGDIW0gXmyyTreRm/y4SeqOvLpP/HX7oKse5sOxZk3OOZGWh
         V9+Z9CLea3AmAf0ZgGWtyhGNl6hWe3FOeFERKAInt+Cq6dMAPs+IJOZyEjoCe01y7ZfT
         XlIoz8edJ731xBBCnsoheSZ80fJMExbmHBZPH4eo1sIspcoRXPMKg/eZrwnknvfjxmS7
         /Z5Tc4KGCcc0637B1PwRiiwqdgjdB1FmNyQnOvOqtk+mGMp2iwFwVZZuBPujSvY0aIY6
         tI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783485067; x=1784089867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUDkASecqLwGKSNtjFZRMY5P8qo0UCmZuf/kuwMqhTI=;
        b=jWRdEwuw5zGdQKsYD/Awf3e7NO2WAEkqbHvxFedt+AtwLkvFc44RRlyzs5VYSAGd1R
         T/GPv/NGVpGtQxwbiYIv/yg486BsUUNGdO7ValVumdyctYT9DQPI5gD8SZp3FLoCWefK
         UQtJG2canO3xK8nbRz1aE0KDaZqBZ1ur813N8GX/efnr2CN+1Ygksde7cF7GM+UfKWUZ
         tpOFStpzN/6HMbOJu6mfuck4RGuahkHHu8+3Vz9KttW5bYwQccBzVD9o1AEPcZC+a/4c
         Il9x1v2VYGpU0yJS80i61ACgtQjAYiJUF3n/R5EwQDyuQ8JCvXyLV2x9pN69VObG/zfD
         9E7g==
X-Forwarded-Encrypted: i=1; AHgh+Romh/lYPzykBaS11KWT3JTWJrPdNqrXbnRhuVrRAUX7N/fO+qy83AlRjfkOwypbWOXQZNYP9to=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHGFKlbzc7+UEh4D6mCYBp6sLLGaY6JDoS/Ko6wzQuVz/86N3
	7bkJ6nDFW5NjqpS+1U2p0GvIca7G7durHWGuWv36LGsdU8Rov+jLfogqhQEuhg/G3f+nanxCoc9
	h7OY3HOLSn0irQ0iGKcGNdkYMX4b8VIg=
X-Gm-Gg: AfdE7cmX9K48IzoxAtvNU19K0vNw+RcVEU4/plKF/DG9loAsGzymuT8BaOACW8I9nII
	Kj0HZEgt7TQs425Phn9vk2zcsBMDnGI9PdkylOg+q+otBNekv9/X8u7l0ySWws/m+o/Sak1NV7u
	fSVmq19PNZSgI6u1o3FVw4DfReMBZbsgxZ2mdg8JXPBKRjCRAsTJZE252Bvcsw/NHr1AVDjUMLO
	mMtAJCkKEA4vGxJlikiz/gNxPrIzd+gIXQG4JTNyzs9dZujB48Ub5IiyH96RKc9K7JaZpc=
X-Received: by 2002:a17:906:7311:b0:c12:a425:cbca with SMTP id
 a640c23a62f3a-c15ce120431mr36961566b.54.1783485066766; Tue, 07 Jul 2026
 21:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703093708.18141-1-running910@gmail.com> <akefPJ5cCrsZcpRw@chamomile>
 <ak0OCusCIcf0DH7y@chamomile>
In-Reply-To: <ak0OCusCIcf0DH7y@chamomile>
From: Zhixing Chen <running910@gmail.com>
Date: Wed, 8 Jul 2026 12:30:55 +0800
X-Gm-Features: AVVi8Cex1vNfjnHrYqfwd8VK6BSHarnOJlNbyicT7cbK9UzWiFxnbumKebvoVUU
Message-ID: <CAMyuFdWknkYNB8S8NCxAACu1T8A-QLZ5fQEReH8Y2u8+HXFhGQ@mail.gmail.com>
Subject: Re: [PATCH net v2] gtp: parse extension headers before reading inner protocol
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Harald Welte <laforge@gnumonks.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, osmocom-net-gprs@lists.osmocom.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305640-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DA3372198D

> Patch is not good, it needs to refetch gtp header after
> pskb_may_pull().

Thanks for the catch. I=E2=80=99ve sent v3; it refetches gtp header after
pskb_may_pull().

