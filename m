Return-Path: <netdev+bounces-282878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNTqD9li82le2AEAu9opvQ
	(envelope-from <netdev+bounces-282878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:10:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ADA4A3E0E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3251301F9A4
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6A642DFF4;
	Thu, 30 Apr 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tygPQp2r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782C42B756
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558219; cv=pass; b=iQqF238NXz/7Enr4844cDI2UbV3Q8RY7Mgtq95serLzAMEnUcvHRYFwR3+dACY7exZF16h+Yed0f3srzgH8hZfIMNywBRigWVT6nI9l53I5GHFylcQ1WFxu4l0uG3mOtzsVcc7WEsp8HX9d/bA+0Br72Z7zozj4ikIWrKJfhHog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558219; c=relaxed/simple;
	bh=nlrRb3P+OsaK0+cogd7wluIrjVJZsg9h3p+8/LcnnmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHVR37I9+CstHqDSp3a1BCbRs6/RO4R4zXNIKgkE2qbabgcJhktjHXrE5nvcTP+ZOrg1M1sutZQKfKM/yb0iCWOL77g0/HB22Xw1BYAo7B0Vwuk/95Q+ajdaFcJperq21/RhEAaDOJ3ggBwDCdWuBCkk44eRxiIUkXYjbQDeUkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tygPQp2r; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cbc593a67aso79417785a.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777558215; cv=none;
        d=google.com; s=arc-20240605;
        b=gfCVFO3etLq0dr8itBZiZzKLZItYRe0Y8J9Z6Zbm9s/XJW+0bdJbH9xCAw2MPcW6Jw
         D93obBLORQArlpfRZ6FNdNoJT+eDSsPb4fMxMLjY+T3/4t4y/o853/ewUS2ZXYMqTCLy
         bZuphzL5kKTOc7dTseu7GDufhxA/NR2r7kJ+nL2SuV49ywwWvtisnLyrYr+q1+eyEbb8
         rfC0G3jPzJ94IOt/XCOphQqxuhRVGzkGu797uvEqh2wB9tF8RIN3v7iXzMaVEvnT8R46
         vxlVpKfjrdUAlw85F06c2nemoGRY283Nctl/jA91l4Bv08WqoaveZSz1YshE31yyvExX
         9BZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTrOOKkOGPxVmz9a5UmNsdOSZHoe6a4Kraw5J34Piac=;
        fh=XAP/NFhdQKj5EV/4sRjo2gudU1EN2dVwOItQVbby6O0=;
        b=hu8V0ys+gfGuvVfYkTlctx2hn+3rFBd7e7pPdYk0FDiMVtffAjknzmHDwIz2OEdGpo
         VRbeiVm6wHiBsIr3lbci/u+MiOn2UYAiAw7GTfySSZlz4KTngwGL6LSDc2g4bQ+ZQ0cN
         opwqaMv2DrYQ/e1ko/K4QyewIsPIZ82ngYXbcUBD0QB5hEMES1Nz1d8caEkZRfKpmF4K
         BeCDAIARp+Jz7bEV7IyPl3lATtUtKFZXbAq9oft4CVdalKy0FWTBAFK/OmntKGlPmu+z
         fHJNXU7CzU53T4WHxL8SyDUCroRXLpt/1gBE7WEtTVLmt/cs0n56c5hqATCMGFVvksnR
         pDmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777558215; x=1778163015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTrOOKkOGPxVmz9a5UmNsdOSZHoe6a4Kraw5J34Piac=;
        b=tygPQp2rfiKv0rtM7zblIFIDFiw334WFEWb/Pqv+Y7s7fkJ7kzO0R3el5CjrxC3/cr
         jXMWnM4oBGkxRaBTqTGCD7hELFqEeQQqo5WbNek7H20rfdnh88We9UBJbCsPiUq6ZV5K
         6Sf7Bg1rtGrCLPA+8y2NwWDqbUDdZuxrM5PxKz7ZkD94TcOUAvr/X7XV00lJv11i4Gax
         D92vA7OrDhNE5u8apmTofTvz4mDkdL1RY+VOsBo4CmkUYJQXYeep5+XUD7fa/nuuk3i+
         WhhmNyQjHrVkyphL/mBnENFYpqgCJS+bBKoDzJry0sWvB6Kz3EyhvOURe5auK+bwjkiT
         r4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777558215; x=1778163015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTrOOKkOGPxVmz9a5UmNsdOSZHoe6a4Kraw5J34Piac=;
        b=Id70R3zeXltViZ7GUKiZYL2CYSAZS8VIZULNbmESnVISxmaUHO8BJcvEajMVf1V8Qr
         bJsYyHnhWr/mcJ3vzLgJZYmDZpom5/ozppcgp3Jsnl8Ra7wIiG1FdyUhgGd60IqvcauV
         Jdx4KNhxmnrQmXhYPGG9+U9RGFgyHadLKva2BFpVlcQ2Xnp6ER4fhU1bSLOPCHrTfnHM
         9+h1j+0P6v4sfn8BO0laf7kfT2u1vEvFg9rjk2DD8lBCNIwsSrO82etpUfiIP3jX9Mhc
         yRihs1Z91K+bPGi/v0b9vnnSWfcDhrVQzmFPZUtOontS5PvEdFfhhcQDe2AIH6fsfocl
         kW3g==
X-Gm-Message-State: AOJu0Yye6xQcHYpvpbEPBCN2+RFSSF0BUC9mK2/ngw6gN5LugbDMtCeO
	PNI/fHqNYzbIOO4TSiWqDVs4aVZEePJxATiZcYsZaz5EUogMc8mnTUMBrGMCmt+AcN/ASsSeOFK
	E93+si/06z+kbmP0b8fn7onfreQmmx5l95WwHu6eb
X-Gm-Gg: AeBDievZ/8EhhbwH+exaQUQLxkplAxJ0MvNEXjuZqiI2DpmHOUyy8yrqcwEGw0iUeNW
	Eff1u4gpTXijKhG7wHwy+ejyRTF6gsZbLSuHy4xCxeQdji2/NuK/SGEOfPkPlnGslvjFnmaJRnF
	amfDmvakOFZ0nUPNg9rFDEWl84j+nKbS7rRu0/i3ZWdlNiw64I7/SMYsgnYzkbdemAG9lg6OrLU
	+TSG6iYnVL5NQqixfGJ4fBGJQMEOnP1oe6UZFkMBN1PpD0/x0BkunpZp5I0rJQWlNCcb4jiZWlx
	lrdB4vHnMEsDP1lZyzm7P9m0T4srZoA4L2UOhs3WHL3CGfZgSds5265Gzr4NHRtk//pHhxlDHkC
	l4vOJ0GnGq2EjHJ6FedG6zam6fb9+MYR+QTzE3rWJ
X-Received: by 2002:a05:622a:513:b0:50f:b137:3099 with SMTP id
 d75a77b69052e-5102ae1dbdemr41147381cf.33.1777558214485; Thu, 30 Apr 2026
 07:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429120120.514491-1-antonio@openvpn.net> <20260429120120.514491-3-antonio@openvpn.net>
 <5b281966-c278-46d5-ade0-9dc24175de6e@openvpn.net> <CANn89i+kGAXWEmgSwrUyRhh7kk6r3FjEza9mjDXq4AjwbC5DZA@mail.gmail.com>
 <4930aa65-6d0e-4ff8-8e7b-91feee1ce646@openvpn.net> <CANn89i+5q8D50sEKUwk1OzGt8tZD2ddSK-kHGq6dFm5QRRpaDQ@mail.gmail.com>
 <a643b413-9997-4a28-a0de-919b83b327e9@openvpn.net>
In-Reply-To: <a643b413-9997-4a28-a0de-919b83b327e9@openvpn.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Apr 2026 07:10:02 -0700
X-Gm-Features: AVHnY4ISuCefUC3f9kZ5DfyXCux0VAKzKql7BBpJQmaQfcENLf0z9HnrAWr5x9Q
Message-ID: <CANn89iKNYZWzJft-WKhSukq+PNaaw+gUj40uAqWPg0J+yP9--g@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ovpn: ensure gro_cells_receive() is invoked with
 BH disabled
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, ralf@mandelbit.com, 
	Sabrina Dubroca <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B4ADA4A3E0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282878-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,openvpn.net:email]

On Thu, Apr 30, 2026 at 7:00=E2=80=AFAM Antonio Quartulli <antonio@openvpn.=
net> wrote:

> Well, the process context was introduced by
>
>      11851cbd60ea ("ovpn: implement TCP transport")
>
> because the TCP code relies on strparser.
>
> Before 11851cbd60ea we had UDP only, therefore everything was happening
> in softirq, which means no bug existed (if I have understood this
> correctly).
>
> Makes sense?
>
> [in any case, both commits were basically merged side by side]
>

OK then, seems good.

