Return-Path: <netdev+bounces-269211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K80E+Ayu2mEggIAu9opvQ
	(envelope-from <netdev+bounces-269211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:18:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3C62C3C8A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DCF53058E03
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F94315F;
	Wed, 18 Mar 2026 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX6tLVTg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB881A682E
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773875907; cv=pass; b=LI7TNwLCc4t5d1xxEeIqHy7SzeCPHQLBvyH4NJvq+2KDZVzVIz5bB/PSNRqxNPScwLPqmifg3eblKQOmb7bfioVyEILMUpK9pGvhA8ejKDDcffy1JlgxQuGaeTJVv10r9poMtk0ABrv+XL+38ruWXHCZ/02HuRm1q3rzUcvAdRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773875907; c=relaxed/simple;
	bh=39G6VhNjqSI8lRjTTtbDrj2wp6uAuLBcTj3h2hKU/RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3jzdpV4Ildn+CND7gYPXFfAwvrxvmRABdfG3bBYABRZwFoKovSY8ysqWR3jfJItUpelKy+j4VnJHg7nvyG0iQTf+s4Vpw8UUcT6gR5JBYkFdEF44JzGmbxhE4+f8YfICSPFH1Js9W1eIxir3nhOp+DNtU3dN4jRqTMZrFwRuYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hX6tLVTg; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48532925a4bso2061165e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773875905; cv=none;
        d=google.com; s=arc-20240605;
        b=Raemg0mubg6D+5cIUEMw5MEmRuSs8lyDGB4Qes4ATRfvN7ot0Rv3zfrJW3/tWAFm4X
         qddmcwLR+CkBE6ALVLrpSzH+FvvuO9ZiMRV1nfWWtHJkmyUPwA6cZ0dadMIZ+CzkkOiQ
         Rm3m/TaXiRuhmLcZxjFSuDGl8FgbI+/gc7tu2yNpiVHzy7NnzZeVES8uvvP7n37Mtjkz
         d2JUWkpDjvvXHjFZPk4o7VPSzxBtG0hMXnQo6MtkHtG9tZM8Zgc7eCZeofGGijpXzyuv
         +PQEAxti+cH5mCBy4J89rgrW8g39OusVfW2hUKxmeUWnp/bVAPOCUgjKZreCG63F41U8
         ANYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=39G6VhNjqSI8lRjTTtbDrj2wp6uAuLBcTj3h2hKU/RY=;
        fh=kFrw86xbfGLD3UwJOzM3nx/WriDQ+uiHgxbViGy8yqs=;
        b=XURuYb7PHja1ixTq+6d5aprVAl90kiEekQdAQAE9hU8H7ql2fs8BP0XCqUfjj2Bjzh
         b3G965RFstm7rZSF+9NMG8LPwiOhVuteR52/mStx7973OZK9XLcU7sypc5cRa+Ew4PuP
         ddAfFr0VSyaFRuRHJzY19bj/GOeJtVeHhs9DZ8Kx6TIAcUwqMRrSL2NPaVCXUwEf6nBA
         ke461gMx2lZySzCMwP4d/QnETm03reH7HrMmjoUgexNyYCWtnExXb5P20pC2T4U8uSdT
         5KquF28kdME+Jx8nJy5uMeNw0jNyBekD7Qy13dmugDIy/Tlt1qgoWNwDOapxT5dk28qS
         0ZVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773875905; x=1774480705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39G6VhNjqSI8lRjTTtbDrj2wp6uAuLBcTj3h2hKU/RY=;
        b=hX6tLVTgmILvVTXsh5qXHoKA+vhRFgtz3YPPL+QevAX6B0vpO7mSxzsjCH+e5g23HK
         pNouTPqDrFz7XpdUVIQBhF0IHm1jycmFR2Hdefh/wi8Dr7rHMOEl2brtS7PXwqihZRqV
         Smxf66d2tkz5uaWTcFYbov6uDEjWpNgjSJ/0iWWMQTGnJeR7ZN81A6ulufb7S2QNXk/P
         KrjqRfLoT/ZqOPV3amKYerLUObCyEgbPOXL5jxtGUdJyYLVXdqrVF92HUE7JQfUnR/t9
         sDjj/asraoKeo6yrOUmtrxeBXX/+yWlq8oR6Cng0BFB5vzTCKixqUQELjvQePTdmCf5w
         nPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773875905; x=1774480705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=39G6VhNjqSI8lRjTTtbDrj2wp6uAuLBcTj3h2hKU/RY=;
        b=DozbMdLeTYa3fTTewN4+iM3JFDshOlkwZWaBpZxoyNliKuQjHdbCevdWXkI8G89aFm
         GzyRsXiveT7OOKfACuoIRGj1hwhcwICSNL/vjMoAX+QTiJFupEggqXROKXGiG+HfjnrE
         P3NlG3Zwj7yFJcQIWKxg5Vjvq4F3ozcXFv2zTc2RNgFtiNudhmj4qUE9haKLbWw9bnS+
         tE4hsOiLgLAF2K7a1z5tkMiwyyDoSSKKEcRDgRJKjrqaI1PKt02rlTj8/dF0uVUizfbG
         cMfD3iADQWBB1TlDzW9I3kHsMGtWr57S7ihnVWYWcY7Vrz8hAfqZm66Nss0RXrlN5Okq
         ACLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiQdluf2jjT13FVXQJPN3+oiE0LEcjbsAIoWosb0BL2RwxnJEt7uUAXRg+c1hM7FLjuGSEp4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQLmhDv+KsHT+rY2Sd6zDnlG/iajaE8Ardfb2uNhZyBM5rrowJ
	omLa1P6CbOiBmC0B0ocK7wr0vZTT75ew+cTHjexiTMnPdQMAksrR6SfPePVC/qzVZBn4X7gg3ib
	POiHcKzlGOV5hqpbjLwDH9je/ZzNoMVU=
X-Gm-Gg: ATEYQzxss3/axkvDbn8q49GsDKxIVAYtyB698gDyIIRXEvf/UGUfh2TmHvQM9J7krMR
	uCExmrjMs5M8fFuS3XOu1FUXYD3VcFyxDtvPR93S15UtO2+DbmXrxuo1sk59Ijv8nW9wrtan72t
	vcd1lmse5zs2KyeZzJz0uc2qdU564zJ9q/9M+7Vs1htIT1LsFlz0FzLMkWM+XIYHqfEh2XltQL8
	xKaS1fqPbKy07H7dsoDeI2xj3/JC+HTyConTQr62L5hpdHF9ps3Sei/B5XGuspcj+0PTsjSY2ac
	+LzvgjRtigvMtu7cTCnJ
X-Received: by 2002:a05:600c:6995:b0:483:badb:618b with SMTP id
 5b1f17b1804b1-486f4463574mr81919745e9.24.1773875904527; Wed, 18 Mar 2026
 16:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316021009.262358-1-CFSworks@gmail.com> <20260317202718.3a5433c4@kernel.org>
 <CAH5Ym4iaBkFsAH6e9UgHbxOEs8D6-Tcq9so0HJ24GFfmnQiUiA@mail.gmail.com> <20260318151116.665400cb@kernel.org>
In-Reply-To: <20260318151116.665400cb@kernel.org>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 18 Mar 2026 16:18:13 -0700
X-Gm-Features: AaiRm51YP9gogPBHIhlbloiKNsmx_tzX5wtT9H4tULOXMMRpIlakAKewKNpYF7A
Message-ID: <CAH5Ym4jYyejXqp0NrX_Gx9ND3kyrQxZZ7zDLN2P2HioZOgybUg@mail.gmail.com>
Subject: Re: [PATCH 0/3] stmmac crash/stall fixes when under memory pressure
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269211-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.350];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC3C62C3C8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 3:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 17 Mar 2026 20:46:00 -0700 Sam Edwards wrote:
> > > Please have a critical look at the commit messages.
> > > They are very bloviated and not slop looking.
> >
> > Thank you for saying my messages aren't slop. :)
>
> Typo, of course. Are you saying you haven't use an LLM at all to write
> these patches or commit messages?

That's right: My crash analysis, source code study, bug reporting, fix
implementation, testing, commit messages, and correspondence were done
the pre-LLM way. (Perhaps it's time for me to adopt a disclaimer a la
xkcd.com/3126? /s)

> > I'll try to dial back the verbosity, though. What kind of bloviation
> > do I have? Should I be leaving off more context, or should I focus
> > more on preserving the same detail but using fewer words?
>
> IDK, writing is hard. I read the commit message for patch 1 and I felt
> like I understood less than when I started :S

Ah yeah, I get it: Sometimes with negative feedback, people don't know
*why* something is off, only *that* it's off.

(Aside: I originally wrote the patch 1 message last month as a comment
explaining my issue on Bugzilla, and later reused most of it when
preparing this series. Patches 2/3 were written fresh as I was getting
ready to hit send. Maybe I was relying on context from the Bugzilla
thread more than I thought.)

> Try to imagine you don't
> know the code very well and think what information is crucial to
> understanding the change.

I have a bit of an edge then: I'm actually pretty new to this driver,
and used the commit messages to document what I had to learn in the
process.

I'll try to workshop the commit messages in preparation for a series
v2. Thank you for taking the time to speak with me about this.

Best wishes,
Sam

