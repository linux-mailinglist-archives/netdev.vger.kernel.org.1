Return-Path: <netdev+bounces-301497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qACAE5IEO2prOggAu9opvQ
	(envelope-from <netdev+bounces-301497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 00:11:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D49446BA5A8
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 00:11:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="P/Whs7jT";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301497-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301497-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D0AC302E0E9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DCB3C1F26;
	Tue, 23 Jun 2026 22:11:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B673C198A
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 22:11:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252688; cv=pass; b=N+TpT2MgopS7/Evz9WnwiLb0HgOeq8CfeYPuGC/n9WmGNmSwWDeQNN+y+g6J1l+88F4zOJFcRa5rT0C4XIt0xJ/zmbkGIDrTxYOpg1IdDtcNtfrM9suSW9S6wyWmG7jivqjP6oWEgnABsD4qwwc0z/16qcgpsqtHzpyiXAt6e18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252688; c=relaxed/simple;
	bh=vqfHob/oc8EMtLo4gVbN9/7NWzL6Mnz+OCGhreVjcUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZs+D3pXzxuL8VwyF0TpUwZAVrT9dMpvd4P4AoSCsjU6qWDN26erqoRPSkzhmZ9tlQJ7ovxv2GkGm2x7WqsbHenH4O8qXXATtzNHgtEV+pcJb/I85p1ZPIoiOLWYQ99AVFk8wR+BPV+ePXCMq20qpcCFxGfMse4dLfiIoVT1iQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/Whs7jT; arc=pass smtp.client-ip=209.85.219.43
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8dd17d7308bso3678236d6.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 15:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782252686; cv=none;
        d=google.com; s=arc-20240605;
        b=U++GfwBEk8mc1NyGJkB7HWMK6DzTLIrqm1MGyvSKRFYiys3YmZIzjHD2PEVcfYdeL2
         pxdd3zlmjSjH79wtQfWE3xe/+4JDvnxa/PsOKNwLvVLjCW35PJNmbx7L2UWAlT8h/nHQ
         qeSJdMXnaQ3DZYp9aNmpC4pgl2xkIyfVfeqAJsNzEdTwfaZRewzBSJqpooPE4gBsvHZJ
         NSwfjSj8e7lrjTH3GIagrJau62z56pSrSLn4YF5XOIi2Q8UjlkQu0cfZNSXv0NIh3fhn
         eqN9IIdNIxw4ewdjmgwuC8RmGCEy9bwCYQtRMdBqSz12ihhjLjv6d1T4pLyS7SszyoK1
         J38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vqfHob/oc8EMtLo4gVbN9/7NWzL6Mnz+OCGhreVjcUI=;
        fh=zqu3sfGcgM+rYn639RI5wIcHN7EZ7MPEtg/BtmBMlsk=;
        b=RovycNU6njIALCqe9FR0gMSszWj0z3uxWbNigSl3P9prpoZkIiKwPugK/2QLFoXLdl
         DT+zTCl+9sMNcfAyUoGNk4JNqDpXl4aQJEXiYz4/ZrwewspPQU7uGXIZjdNF/A/GWVuZ
         xoQvI09bPCdOSlYJ7iqKDNcYpUNJ3+cg650mjU08Nqo5rXO+ENO0PGE6Evmm8if2ecpY
         G5npicF6rQYQ/rw+RuGCiZ7u7y17n9ZcXwevunDFA9l85LUmkFkoA8IVIeuDgAKMNZEg
         d/UQeI0IlAqYTY6BaVYDbbRIc7mMP0ZzZtb9nlZH241RKandwUKsUuWyDl0+dilOGmYC
         hB2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782252686; x=1782857486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vqfHob/oc8EMtLo4gVbN9/7NWzL6Mnz+OCGhreVjcUI=;
        b=P/Whs7jTr2CI889/8hBtOJZNajHROwbkL8jYrBFPGuRB4Iv9EwquyFxhkd3h6tUrQ1
         5ghPL33WT1HlT/oLXlmiolEuKdOkubcRphVRG5fm95xWvL/hS2DB2J68UL5CownlI5IR
         Mfud80/7l2yids/lKpWK/xzX5nKSHSfp6hth4V4C0mbp2+uAMlCetgcN59jAuaUrXifW
         IKb/WUMQ6YsSPHfKWPnsEGLCZjJNq1QII7UphiKGgQ5A1tgeGfo1eMPM+JI9dcyUDteB
         5T8ks0bWScxUqYF3j43cSEWeGB8oc2AwL/T4C3Jz1P54Z0vd5QU5KN4Q2mSe9dIp8d8J
         1fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782252686; x=1782857486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqfHob/oc8EMtLo4gVbN9/7NWzL6Mnz+OCGhreVjcUI=;
        b=Vh1UDnH2eDHeyQL97jE60m+0nkKRdTLeXHmQEsXzTmqc3tS4KBVq6iUE87oo9Q2CFs
         ifytYmWvUIJzOM6wmQi9oBSm1/kEkVc2wMw5A/EBjqT1PkVxRpLEi8op6HnonK447/TY
         TJCiABleeCymybTlP3apkD1iYiIlKGb8AKyU+2QM+87cyfqm41ZGqN3X0CjVbKujX/34
         JsLid7Q+LrpIn897N85ZUwctmNstshZkPRSsa0d8hGC/KbRCLehDkbFjy+rtN/ZgoG2O
         WwuXEPqOLc/fk/Zz/gP8MJquoml/C/B8FoxT+tUWwUzJ6d2qYx7y6h34YLYqDZgsZkjO
         CWsw==
X-Forwarded-Encrypted: i=1; AHgh+RphtyiUx1y033oyOQm5nAd58sAm3RJQoEOid8+rrE3FIJlfDWI9ydc4uyKIcxa786Qz3HxcK08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVlheOqNB+lKHrB7NIRMRQyENahUH1crVZA2E59VJDF2CIKtm
	iKxLRZqgX4heBQYP/BoBEqO1wvugPoLkTBH6el7ohEVg1DU4l+RACA5BCklZSoM1wuoPzQRjRXM
	ojq2gZVa9jwtADItNW6lRw4j3NRjJ+Vo=
X-Gm-Gg: AfdE7clb+giboaMHoWIKZFD5DxLgb7imS4vkbHe446HSQZL1eLGorw5C6wEhmadjQxM
	sN86oxPFkwuQikajZHKu24b05wF2B5FJW+QLg07kUKKH0ajCpBxyJ1Tnu/tpIPcAgYGiZKm5zB7
	m+7Eo2QPruG7HIve7ZYa1T25d+lW21sP4CWDBnm3+Y+kjUDfXgYA7t6I/oF1rgO+Kib0VV6EHjA
	vAH/+6QdLxSufWfLxNKkzca9yUROdnB8ib8RQSoZM3EGQPSQDlbFEeZaW58VDVunn4xhFCuGg==
X-Received: by 2002:a0c:f002:0:b0:8ca:207d:50c8 with SMTP id
 6a1803df08f44-8e533ce610bmr14459276d6.16.1782252685845; Tue, 23 Jun 2026
 15:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623112133.752195-1-slatoncomputers@gmail.com> <CADkSEUhkWRzW+-39JmkDSjUi8Qfwrr0qsVJFDxZhpNCBSenMyw@mail.gmail.com>
In-Reply-To: <CADkSEUhkWRzW+-39JmkDSjUi8Qfwrr0qsVJFDxZhpNCBSenMyw@mail.gmail.com>
From: Michael Pratte <slatoncomputers@gmail.com>
Date: Tue, 23 Jun 2026 17:11:15 -0500
X-Gm-Features: AVVi8CdRrPp7l8XU8VkAkgRUmQk4139HLaGZCvxpYNjQfHcLmbtARP51OY_pw9Y
Message-ID: <CAButv0fcX=V6jYjZ2H1He8znNy4jhKDuDG6kSNhCt-ZLuOcyTg@mail.gmail.com>
Subject: Re: s2io: driver still in use - please reconsider removal
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301497-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[slatoncomputers@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slatoncomputers@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D49446BA5A8

On Tue, Jun 23, 2026, Ethan Nelson-Moore wrote:
> Are you using the card for actual work, or are you just testing it out
> of curiosity? What kernel version were you running before you upgraded
> to a current kernel?

A mix of both. I run and maintain a lot of older hardware, some for
work and some for fun, and a 10G card that works in PCI-X has been
hard to find. I brought this one up directly on 6.6, so I hadn't run
it on an older kernel; I bisected afterward and found it last worked
in 4.1.

> Given that the driver has not been working for almost 11 years and you
> are seemingly the first person to notice, I would like to respectfully
> disagree with this assertion.

I might well be the only one still using it. But it's a one-line fix,
and I'm willing to maintain it going forward if that helps keep it in
tree.

Thanks,
Michael

