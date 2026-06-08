Return-Path: <netdev+bounces-296360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 706ZAJc6JmrLTgIAu9opvQ
	(envelope-from <netdev+bounces-296360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 05:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AFE652798
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 05:44:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iAEYbVJK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296360-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296360-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 724A63009006
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 03:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189DB34D91F;
	Mon,  8 Jun 2026 03:43:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0D34CFD1
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 03:43:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780890238; cv=pass; b=QP/ZAtmKXPDWwwACptnacbH+q2shfeDAueGV/j6n4S3CdJaclcL8edSWW+Pksmv2OIAcSzL9jdrftFX5+3Ufz8CLGGkHxcfxLTvuHVH31K4/O8gY9V98IyeLks3lQCYPfflUTQkdgYd8WWSa10OXhjB20fjUOHmKjNHEhBvP0JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780890238; c=relaxed/simple;
	bh=6QXOhzjCcsRl3xqRJHqdA7rX4vdnjKaPiCPbYxcsCkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTDjvw0QIE+SuxLxfPzjp5U4WFnRcI8ZjKQ+op3NIuSd27wBxKIEzAot+6eFNYW+u8qdemfcAdMrr20zcqMFngQmZsZ3CyqziJQaM/YrUhu9o92Aynj8AhFaRW/U37Yvk8xIUpyd7reWpRmmf2jWQKKsWsKPcMbM+XifN8X9CWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAEYbVJK; arc=pass smtp.client-ip=209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so513489766b.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 20:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780890235; cv=none;
        d=google.com; s=arc-20240605;
        b=KrV2iLeQtdo8qgg8UTBCdA0OcsH7Gc3QoqhKDFcTmZSuoviw21hdbL2J4wnyYk6Fp1
         UYR9r4S3E30TD7wWyIbb4wgfeP5qVO9dZpuEuUPiuyQvd5jQNW1uecO2MHn64oiARSRR
         7rpg9fFz7uRgqye6mFHEr1cHLbaxPho+T1P5qyYDhbYrhzkT/nrzAHG/otFCaq4ClDbA
         bp1aCpF22wCs/YpDZDierGDbM0jL8xqk+3ZVa4mQoUYLqohyGMwKTjqUgGvJAyTsYUqc
         9hARkginWwa2VNPpM/DhJ2kxlhViZelp3AovSz0GAK3O/3cgIMqmxZtQK7+y3X5ecZ+H
         ZWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6QXOhzjCcsRl3xqRJHqdA7rX4vdnjKaPiCPbYxcsCkk=;
        fh=ehdLjMpY0aVPcvel+T7NJDAcGVSjuu574OpSGeVhD2I=;
        b=kmTLEg1tZrXSBD0GNyom9OkiJY3IqEBI+DDWrmIDnPuGTLkMdziLSuxpf6jevj73gS
         J//hhWTyxEw5cqT+++BYiNMTCpUSmC00EOFO1bExy5YVeCl29SkZkvHICR6cd+980VWn
         0+1maITrtqN54PQ4CJuaY2nPqYU0sr13Rv/AcFLdCPwksRW1xsBeg0kW1MXhbG/Y6evr
         AtUVB21t7WhikHLctpqdrww9p+EUPadu0sQekxBFH4Ej3NPKfq2CbQEOYVKr7ks8oSnL
         nodOnz+OudDL5ePDaVAXtFqMqP3a2VzdNxRsxhwrzijLb/1ReFDb6/VfRNoq/FqXXwkT
         8fUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780890235; x=1781495035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6QXOhzjCcsRl3xqRJHqdA7rX4vdnjKaPiCPbYxcsCkk=;
        b=iAEYbVJKQ5YSxkVDuiK+hCyo101l+s2YXgunVYsuLjJu5PgMR2QlI/jBQDSCpTJXYt
         Y0VRW9RkCXaYfBCDFZcNQXPNgVJTZMNpWQeYZcTFrBMuMrUB2qhgUi4iW3PnmlvR4O7V
         gWZInbIgeIneHKrmuEZwE723KaeR7PcDekO4KZvhr9paKh9hFRdsVc/pHfdHwhv1M6mN
         5VR5NG+zC8gsSCkPWXHHbxRQ6CZWY/JL2dfFm1tArCYfJMD0l455XsO/IUcjaZAmGtH2
         wW7PBPOBIRCWKqaPoHMGPT87fy41yUWsboNt/4ybiDZKawztUhymdap4uEsldSkZMxNI
         CTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780890235; x=1781495035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QXOhzjCcsRl3xqRJHqdA7rX4vdnjKaPiCPbYxcsCkk=;
        b=m6Hi7cTEesgmW5sOQSZyPI8Ugw5TtJS49M0dB6cqhWLzYtGeINacTlmfy635wYdO30
         eGl1S1eP1Sj5bL+IrufnGtTDz8VrrhxK9ct2ntpb9VoBRUHSHTSVwcgZs2PKtGJvnJfo
         I0o5mjSTAvz16mkB5npwyTGER4pZDlmN68y90rD45WjJoBwGL7lEBu87GvdqQZx1ExkJ
         sp+eVdwz+ZE64DvGnqYTiJOaMycBeWwHCzONTG+Uyw59LXVlZJXjbKNx6UNver9SOx07
         rpq4Pfr9IvlB/0qmHvUCSDjDcMUE+XjqScbWTl9OmtT2gqNXoEmPhZyVGO2cGQ2WfijS
         peCg==
X-Gm-Message-State: AOJu0Yxh8/5IxKANgJW885RZBMx/QK141O2gxoZx7ySOJ/UIxp5/b8xb
	WA4+sXXR0p3tbYE6GSn9cz1ohtkK0S5Fe8l3+E/U0sGPSfoJuGNSeWRJJMSMhI3WeFgFCoxhp2/
	MZXiVBPraxM9rX/EBANN8LVV8MJ42EPY=
X-Gm-Gg: Acq92OEztVIewP+smXYQZ5ptAKTdQGP2ivZRTus+3DTNla9ViRH8u/tDfnop3NYY8aY
	TzXUCeavf/HEd5Y5fpMzBGWNtE5CPNGceyQ7dKlT2vxhx+26lJazf3X68Z74gpA+h2D5G0FEWUS
	DuWVSokOAXUBs8p7Nj3lZ0zxZU9NAP7CdYhAddR8LCedesBkrDXIWCs6qAjP9/Eqg1fqhWMRLDC
	o7idU4ux1WVygwYc4NU5ZvFZN0mmYGrT98wOYL85sHHOdQUHaSSuN631fqTmExJRhHMOYywEMND
	AJ7O0gtr0dMeiDK5OR7KSFtRdKYexn3UHzn6GrMvZa+ETVHGJrI=
X-Received: by 2002:a17:907:6092:b0:bef:7481:8a4f with SMTP id
 a640c23a62f3a-bf3738f957bmr670028466b.25.1780890234812; Sun, 07 Jun 2026
 20:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
In-Reply-To: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 8 Jun 2026 00:43:42 -0300
X-Gm-Features: AVVi8CfQuK5BJ19ZDrXVMuW8flPCvGA8iW4kZEP8TJUz50EN_btE22aWzuq3dN0
Message-ID: <CAJq09z4cTkFd=bvdjhBnqkwmO20xiGvqkzFJm0FpM6+9oOJx9w@mail.gmail.com>
Subject: Re: [net-next PATCH v13 0/9] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mieczyslaw Nalewaj <namiltd@yahoo.com>, Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, 
	Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:namiltd@yahoo.com,m:abdulkader.alrezej@gmail.com,m:ynorov@nvidia.com,m:yurynorov@gmail.com,m:abdulkaderalrezej@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-296360-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com,nvidia.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url,mail.gmail.com:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59AFE652798

Sashikos' results are out:

https://sashiko.dev/#/patchset/20260606-realtek_forward-v13-0-b9e409687cbe%40gmail.com
(Gemini)

After a few versions without comments, it now added a single comment
on patch 7 (FDB). In that comment, it misses the fact that the DSA
core already keeps track of multicast usage for shared ports (CPU,
link).

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260606-realtek_forward-v13-0-b9e409687cbe%40gmail.com
(Opus)

It commented about vlan_lock not being used by rtl8366rb and that it
should be moved to the rtl8365mb private struct. However, rtl8366rb
might indeed require the same lock, as the concurrency issues are
mostly the same for both drivers.

It also complained about a couple of unused macros, which do little
harm and help document the registers.

There is also an error message comment that I would consider if v14 is
required. While using stringify, it will print the vlan id limits in
hexadecimal, whereas the decimal format would be more user-friendly.

From both reviews (and the history of them for older versions), I see
no blocker for merging.

Regards,

Luiz

