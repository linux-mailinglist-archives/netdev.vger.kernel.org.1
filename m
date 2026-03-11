Return-Path: <netdev+bounces-266666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPdpNah/sWmjCwAAu9opvQ
	(envelope-from <netdev+bounces-266666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:43:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7752659C6
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8894A3005308
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC1C3D0902;
	Wed, 11 Mar 2026 14:43:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A453CCFB2
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773240224; cv=none; b=WktJjAApp58SIttpYEuVqXJlxofS9LmSFOvNTFW/DDr6i0cAD+TkpOxVbt2zUJBX/xpGeFaOcEcuxtqnNXoE1LqrfNia6nAdLsx/EEVHsqjNApyAm+gY4BgJrR9klVSTAVUjcjhWyIVWZUg1mfs+NjUKtt7jvZXuSZy6BNY36c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773240224; c=relaxed/simple;
	bh=6yFjK536+3xu/h8LkGPxclUc1He+ytgB0FqBVRe3iEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRSQJ02waGJzwks1Ae2pJ3OeFas6PKPWERXA9jWb960Ck+4Trkc2RdF4WTj6M0x1+p712Km+THd8uZFhP2FJs84yKD+aidRxwYBL4BIsMyB2UUwErIctFF9Kno0ToWkcpBwkuRMqucLpiEpyuRAi9RZyfzjSd3/ItecSh3DU2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56af41d1e0bso2861951e0c.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 07:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773240222; x=1773845022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4Hq9IyQS3eOQ6+eqiNIQGDu4N8I59btxzg2n4rMNdg=;
        b=jispLuhX0ax0Jv5F+AV21wdBa36rVv55hvgq5ieVMBQvkLJnCl6M4BrjcuPLUMeZiY
         YVM2D2X3pCNOC1hNnoOEl0OwSIgZdhCyyETdKvw5gDmZI6vU4o1ylk9++E5ZDp1Zki55
         fXBKbYnjUNo7dRteb8DcZqCIu1I2OKHK1ooiMkcHHO9Az2HVTyLKlhrj+0zk4tbSXLWu
         sX7KEpCUN6wmsWwGnn/2gJZux0VwxUusx+W599CAtLwvee3xNLsiEs+qSQGLMw/kX/OM
         jheA1TTiXgoYzvO7glnf0k8QKqyk963EIUM6Hyt/gnbwR/vhb1+IMytcOgTyJIOcUVDo
         LUsw==
X-Forwarded-Encrypted: i=1; AJvYcCVsc1RliZOV1IX49iqAYsPhxKCMKMglrQyTeWKXX+ntrgtPBUdGn2bAtkTLkHb6PKUSutXH8DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkkkxEKWW5U0p8J0fyjgT8uV5+ZP33ugEg/qyYqKos1gBrpfj
	qkYo4n5eKKxYfQr5S4zvJwvyh9YVUqG3h9QvuglJR0QhueH+QKDThfVwCWBcWvJIJUY=
X-Gm-Gg: ATEYQzzfTLgz8wpDtDMxGr0XP+vu1HooaMIe2ZrTbei7b52gR1SOm9x57tlr2AWUVc6
	N95YzZZtGstJAFOJBw2SXhRaz5js5b6douRafmEW3sHGf6IOj3ZG8j56ItBaco/1dTmBglKfeHH
	kNQCLKmaWdQCSrKVP2Uk8FJfrRT/7SRKdTtekVD19peh7xAYKgGRmBeILQv5KQVHKqQeTyB6F+A
	7pdn4NhJQGFyMqUo+N3xDz1G4eBuIg5Z/u9r2wAFzflsopGNml8wYamVsMHxjLdyGaoqcPGDYKS
	ANUuIj+XgbfCJS6eNUO2Q7SrC1PLEEgvLYD89R6AQsQauZ78LgpKbCN4X7dihYC7/idmef4Ibh2
	V5hTaYFkhj1X8WfSkho+yvQ+QBtqpVWka0cTAuxNZATiiluiP77AWPEUhRSHzqjZ3XurKJGCrVP
	k/Z5RRUv2V1J3MYdRLbTCR9h/W3NK1z21lnuyZiRiaK7cs0DpcCK1DhN6acF0QJv6+
X-Received: by 2002:a05:6102:d89:b0:5ff:e139:c02 with SMTP id ada2fe7eead31-601deec0f7fmr737670137.25.1773240222479;
        Wed, 11 Mar 2026 07:43:42 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-601deafcb04sm753329137.12.2026.03.11.07.43.41
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:43:41 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56af41d1e0bso2861940e0c.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 07:43:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXobcBbPCdEElPZSTyWGTLy+nrSHa3yqj1tqh1iVSy/wnrnQnAGZXnCvMcbGqvGG8lDXgNf1Hk=@vger.kernel.org
X-Received: by 2002:a05:6102:5127:b0:5ff:ce5c:f20b with SMTP id
 ada2fe7eead31-601def2aa63mr986750137.28.1773240221699; Wed, 11 Mar 2026
 07:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
 <20260311140135.937544-1-geert+renesas@glider.be> <abF7g9kZk5-9YN5_@shell.armlinux.org.uk>
In-Reply-To: <abF7g9kZk5-9YN5_@shell.armlinux.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:43:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWiN_zQ_1j2HcD1KLwS_FUH_G6WtaMy5bK2HnLTKeNA=w@mail.gmail.com>
X-Gm-Features: AaiRm52-U6IBH2zqUx9sBm32xnOph49vuMiF85bhgCh06n0Q-ad9Nv3d1IxpfhQ
Message-ID: <CAMuHMdWiN_zQ_1j2HcD1KLwS_FUH_G6WtaMy5bK2HnLTKeNA=w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: vitesse: add inband caps and configuration
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, conor@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-266666-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: DE7752659C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russell,

On Wed, 11 Mar 2026 at 15:26, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Wed, Mar 11, 2026 at 03:01:35PM +0100, Geert Uytterhoeven wrote:
> > On Wed, 11 Mar 2026 at 01:07, Russell King <rmk@armlinux.org.uk> wrote:
> > > Add support for VSC8662 reporting its inband capabilities, and also
> > > hook to configure the PHY's inband mode.
> > >
> > > This fixes a regression in the macb driver caused by commit
> > > 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
> >
> > Fixes: 1338cfef1ff1b958 ("net: macb: fix SGMII with inband aneg disabled")
> >
> > > Reported-by: Conor Dooley <conor@kernel.org>
> > > Link: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@spud
> >
> > s/Link/Closes/
>
> I avoided it because any other PHY used with macb that is also connected
> via SGMII will run into this same issue. It just happens that adding
> this support fixes the above commit.
>
> Conversely, we have stmmac, which unconditionally enables SGMII inband
> at the MAC end no matter what phylink says to do, and should this
> PHY be used with this patch in a stmmac system, it will cause that to
> break, because we end up with either end misconfigured.
>
> Also, if this commit is applied without the macb change, you'll
> probably also find that macb breaks (please test that.)

Correct, it breaks in a similar way.

> So, while this is a solution and a step forward, I'd rather not suggest
> that it is an official fix to the macb issue - it's merely filling in
> a missing piece of the jigsaw.

Well, when the stable machinery will discover the word "fix" in commit
1338cfef1ff1b958, it will backport it.  With the Fixes tag, this patch
will be backported, too, keeping at least the MPFS Icicle users happy ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

