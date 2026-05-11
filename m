Return-Path: <netdev+bounces-286452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDL9GQliAWp+XQEAu9opvQ
	(envelope-from <netdev+bounces-286452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:58:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7489507ED6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34C60300A102
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD397363C57;
	Mon, 11 May 2026 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPn11qbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46095363C69
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778475511; cv=pass; b=coP9LzqKuAcN63mNMgZPFCh1uzx+Rh5AkkF5JxmfvNaN4c+C2TfqinElj621r3SjX7FGPWU4evKv9B04D38dPx09yk070SlUjGZtq/o8x4RU/t1PAVy73wugffdEXRVF8NCJcXIZ7G0mvIc7Qtywl5Qdkn8qYxiT41m9IAlEK1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778475511; c=relaxed/simple;
	bh=pcvFh1XAY8MKLcGUyjGHBZRuShdzSDrraUf7tWTd1zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5X43pvcFr8alYe64IhiblfDVm71vnYSBz10Iqe5rxH0WNLjr/npovEkstpGNQFmwZJOoTIsdYk/bHlWGSlDo5EoWp6vcmkX6giJV2+AtVwEizR5DgeXWPNC+mCHktAAUH1R4sOebLaIrl1TGnk8W7rZ7R6VMf0NGUbY3qIp+XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPn11qbj; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9d9971d059so571580766b.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 21:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778475509; cv=none;
        d=google.com; s=arc-20240605;
        b=F0c3M2H332oRSNE7pZKlpvbeFWJf2X11D9ahPglV+XZN0jXvUyhweItKD2VUNTnaP9
         zKNXb1IYSn+DAnNWoKL7FUjZQqyk56NZ1WTZ7HqR/5AZInMK8iywMgqGPXsWlNleSB0O
         nOigNah+340LRMh8brOq/H2awy8iWn7G5pVR7bX3r/JR8MeEGP2H9PG8xOpXYwl3+yLO
         XkeD5MHrpn9W+cCsrnaKu/aP2M3bTciAV1LaV7rOhrZHgTldN5kPTDGONZFA2oRUrlhE
         OvN6YfRbmTt1WLHM0h4eqSbp7GnScYCTwmZZTFcOp90N2YzfyPSBQxWdR4d1Ai2WrcxN
         yMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pcvFh1XAY8MKLcGUyjGHBZRuShdzSDrraUf7tWTd1zk=;
        fh=4UT9pFOUZ9bYajwxGIQdVGU4OGXZFBJ0QkTbs2YWFRQ=;
        b=CI3rV7j++3v6VQqWjb4ryfGiYS3y8TTJ1SqBv7OChkwhJZp4jD+1gC6A9TFRgRGoBB
         aFcLDhS/GH0/aF9ylYs/uSjjgSS3j/hE2H2nbsR8lN3aGR5tags5UoLwn5cSQztSczWi
         ewcAqyXfEUqd3HQomgD2qOu2LiogJWNP8Ox/2x1ZP0gE7V6AFXq/MCoRj6TT1Gih/dIc
         jKfEU3RsfuweN6nAsSufyNcqSjCnGYeTm7FXsaCuJdpcNVBLfdJWv9CFU3RKaEyu3zcn
         Q8MqO5TaCDlELou5eO0ewOLgW6rZUhfEWKH4afkYrlfgbDfYFicr5+/TzbdEbI50XSMg
         xj2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778475509; x=1779080309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pcvFh1XAY8MKLcGUyjGHBZRuShdzSDrraUf7tWTd1zk=;
        b=WPn11qbjk1qSaIxR0DBfZYsCkgJA/4tbZO6nsOdBkD0ZgyIyIR53u23qLExFkNyLhK
         f/F+/Ak2u0UhuvkFvE5j0H0k0mZn2Qwh+b95ECJEvGJT93E7+PvTZM2C7LJBYZLQTnuq
         teLeAn5941f0Puc2XWbrqlScfYNlB7urd06xOtRZbfcgjRlPj73itIOTtl9AP4EfxCJl
         twZofI0baGU+4h04Kv0IU0ry4TG/t9UIC+FswFKB1ePZ0ccH0urNl63mW2ONWX/honxu
         g9c79ROQPWePhABvbmxQ9DrWUc/VKDoLQDT4BV0+c3B48V5cSNeZtomYS4bz9cWHnmHy
         TDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778475509; x=1779080309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcvFh1XAY8MKLcGUyjGHBZRuShdzSDrraUf7tWTd1zk=;
        b=nd9Q/HvzLAxA8M5kmqemYby9O+jM8PTS7dJG1BXXwO6iVVlCjr3OoX5S+B9cdsVZAL
         Np9OjEoHhDwqapGI+hzdGTsh1wWjacFJyUTP10aGLDgKfy9JUzd8cPRPsWsNMzM5/J3t
         fgvibk/V5KM3+OClhXrkkBqrifeiId/qcAGTaB4SbbdemccAZm7LZvfTpnV0U2synHd/
         MGqVcelzD1OyFyfQyariHUbwegHaMwLKqKgUtlugi4UtRt769HuYs3/TkVtUGJhBwWwC
         xm0gTLvp5NaYOtMbaYwymadibo3N2ghj6nFcf3hHi9f02jSp2EyMfxg5s/zYRqN3Enbe
         J21Q==
X-Forwarded-Encrypted: i=1; AFNElJ8bWkRdHV9bAtiKfmpEOef6mnThP9gNTI/8TCGCGBCkWOtcaFXzU03Z7Y7lmH2f3UdXgnjN0gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLADY2/jqeYOUx9iR29ytY9Lq3qe1t13rbDMdUY/72Cb4uO5xB
	JLJ9wRBGfT8rm/THqT+LuquM1fwrIDTlaVSCLuLsdo3YYB1vx76LVPvvMx0klj28CwAGez6v3Xw
	7egGDxjAa1qolTXEWXVdIJpwvzh7ndHU=
X-Gm-Gg: Acq92OG9QZQ1OGWMN5m2lYcAJSoveK2COvXROtFNcMHFLxTyG//PwZCjr3ceOTcfsla
	uRFt1KVMzL11D/8hRrd+v6zAA86xAndXtU9E25PIMVC1JnutgNH91P9d/DPXt2X5/nyipCRj87m
	kZHrxsDa6CWD9f4WM4P3nzOuwy/UogczXfhJKoQV1uY3R4PH6qg7O6kcpJCdF+F3ls1YQUHItc0
	v099h+eOc5A6A3uicLLyt88KfJ5c0mQHHsxHS7eUke8EwBi8r9UxL9efO6kl2+yR4f3WXYV8X0a
	CmxLLbB+pxYgEI2cPQaf2nidaLCI9Ej19XvHCtJc
X-Received: by 2002:a17:906:6a23:b0:bd0:bc5a:746 with SMTP id
 a640c23a62f3a-bd0bc5a2c38mr43176066b.36.1778475508496; Sun, 10 May 2026
 21:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com> <20260510103404.21b60138@kernel.org>
In-Reply-To: <20260510103404.21b60138@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 11 May 2026 01:58:16 -0300
X-Gm-Features: AVHnY4IkReEwcxqkSWeZZxZq4yzZceQ8maqnhUQpBe2UfhAtqFHcYS1Qqrla7cg
Message-ID: <CAJq09z6SBALacbkqpv1KUN6_G+Eax_5entFX-_-cnh3wLWN-gw@mail.gmail.com>
Subject: Re: [net-next PATCH v3 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C7489507ED6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286452-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Could you please look thru the feedback provided by AI bots?

Sure, Jakub.

I was expecting that, if it was an AI bot reviewing, I would receive
an answer or something here. However, Simon Horman sent me the links.
I'm already working on the fixes.

> Most of it looks kinda subjective to me but hard for me to evaluate
> the HW details on patch 7, especially.

Yes, I'll have to rethink how to deal with the HW limitations. It'll
take me some days.

Regards,

Luiz

