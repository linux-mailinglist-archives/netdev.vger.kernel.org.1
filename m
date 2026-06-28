Return-Path: <netdev+bounces-302398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zuSxLN0oQWr9lgkAu9opvQ
	(envelope-from <netdev+bounces-302398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 15:59:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F10736D3F66
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 15:59:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=HADoFSpK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302398-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302398-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98E383011874
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1001B3A9D83;
	Sun, 28 Jun 2026 13:59:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910A93A7F66
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 13:59:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655182; cv=pass; b=rACdso2wZ17l/hqYOWYkhCsDJ8gge0zQAYP/zzgGNRwRH/dTsrvYeFC3w+njTlG0slEh76tifRv03jYjcqk+Tr8vPVvRlW3T7/PxcKhI8gP9/NaQGznTC74TYBkg432Vf/VBie7dBc/hiGP+MjF3YU/G0zTaxTChL0aMuTTON7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655182; c=relaxed/simple;
	bh=iYIhjYVr3YCB5gJuCm045DGHO+A3CUSIkTn+4OuZeok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQlGdg5DJaJ4Ih9PQEbhts9+w88oIdMQJyhjRPk+k1x2zuzkXbEBKTFID3h9wGePtyUr4u3FKcj38+tjX/GhEW2NNxT35D0THwnjDWRHzIjpMojzM7MzjrzuP9KPRRHl+p4ZCxRDbq9V0XMcl6tieKzqCOxYOSH+xzMPjmM+Egc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=HADoFSpK; arc=pass smtp.client-ip=209.85.167.43
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so86990e87.0
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 06:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782655179; cv=none;
        d=google.com; s=arc-20260327;
        b=Az0iuhEpZkDIdB+eyQMuc2lmBUKiutPnJ1AaYiM01BumCr2S2T6Jts1J7O9Zy5Vy1P
         nuMtnDaEYBtTmajapwRt6Z5GcdlMOX/rF2UgLmkjkrQALBqnQqAaLFuFfgnXy7u8QoUS
         p5qvqyaZpdbnzZsN3t5kSFMRcMJzKrBKx2UqD5QimjPA1C24PfehorexiCKexGUPN1NV
         T6tlOEL4yRQkh1+JwM24oXgWZTebMVB2xBH23ObuPHrtW0uuK2CEXsCgv3rgzKn459Sd
         q+GmYVhmQW/Lg7jpzeFiLmbIzoeOeI3gif5B/YzULAU78dQgTvsZ/hekiivUDCYUlvD8
         4haw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pl64OGcNMjExLSIMvN1odvcmcAO32g2DtQEWzMRicaI=;
        fh=lOOtcnJ5P6UVJA5uvQYA+6p40xx66hG35U3LX4luG3Y=;
        b=lBXC8o73AtsF3Hz7B8bVo9Z435nMLhzI/g5+HS6Nf4WD8ztyOxjX873bQpo/V26XI3
         oEFGzbQGZQdUljacc5NeCtu5URcq+RNGW6atHRrhG8N/EStOofk7loXqXWNSf44y+6SY
         p/du0DYD+jin0x8c2C0ApoAxKLEPLFNQhNmNfgAdcGXkfdlpl/PdCK/7Us1AyqfFaQQL
         FSHfiRqDpJJle66Z2Vqg1PqLQd67CC5VOtVXBG5VuCTB344yQM08NUn3ce/JxBre0n3B
         zIpVnzMimVzRAU083d65PCzWvPuqfCCkPUYzV8wkzZx6L9uKsDvGcOs0tCeL0VfW+sQ3
         Z+Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782655179; x=1783259979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl64OGcNMjExLSIMvN1odvcmcAO32g2DtQEWzMRicaI=;
        b=HADoFSpKzc3DSMmaDIv7AKtoyax7SUHMS2/pDyibVms8cd4ZiYmrtmkZZCeNgXMq4N
         UJ+riPGtcSx5wIG+kCMyp+cUAvE++txWjWZB+FOgWeUNQD4PDaipSAGA7LsCsjpn2d4m
         1ShqSuRw0h1WbH/syCwSA8e+kMlD7yl0BCA+kt2RxS//tA8MeoEipVACOtcMwu98PvIF
         oYQDRVkcopoIiQCLt5QXvNQvOu2jGk05qzQsF5gTEhmXL6tQfe2IHQUFw7LvnO3BHQCD
         pitZQ4+6YTsRpqHjJBJ+MluiR/PejD0NGBcoJPLoPmk1iNWbxP39RzOj+DbpCIc5AOD5
         RPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782655179; x=1783259979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pl64OGcNMjExLSIMvN1odvcmcAO32g2DtQEWzMRicaI=;
        b=IOXEYljoIEXz5XXLP+pIG9Nvj/2jjeMc0ttCQeD4nQB2IM39y8Apk7D9lPykZIFGmx
         Ix9BpZNzqtHXvEJ6OhtDQLSk3HQqCAF3cCatJaMLyXpewvYe82XP7VIdfmOCa/FUDmVC
         h1slxH+xwXAy7W6E1ylDPD9sPhpSpmWrcEjmB4ae9wYQdWoxROEcnMuG2BO45dMWL2aV
         Vy5QadmwZMbvE0TXOxZOicuJUezDINgAmMA3kXUx39H88L4Jz/EJe0kQMs9TePkR5MSY
         5C4RszXjpHqb3Q3Hov1Qi6UWDv/QXuHz77X0ZADQ1exgAYMX++brQqjHqJ0EnmiOR6Af
         l4ZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqydXkyIoaeKU32guVIP+ab8Ii5tOk8HllnvwaxOyHyUMFPZiDDqnVxqfI6p12VbBRwosBvMoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxPQynuUoah0woDlEg6GM6vRMDjG/BUsKd6blDWED4CdGA90C
	EI4ewTY4raD8NTC2olNZGyKVwrT2zy6S1Qpj+yH9D6N7nQ/9RSN8T8nUHTF33nUaM8u4RaithWw
	a7vJuxjrb46aJ8nxtwFvmLjn1hlDhUk9KTmB2QKBpOQ==
X-Gm-Gg: AfdE7cku9HXehLz1k5gnW8JKQulYsMZBRENKqimzaGVmW0wS1hN7XM41JFEtbEvK+7c
	m2xWqZHYkv1I7q3SBf4GapY0wket2GXG0GHdFAWET/ZV9gCRH96/GNFPh150z16FwogvcA9MtB8
	dS26nb0hdYz0FSobYY95SITR49T4tKnUZ0EtBEQ5tTYsvzExUFnVbcmUtXCytHYfDIBKbQgwxNI
	iH/eL1IAvBwusWrA5zq1GZ1ZTIlM0TKoo0JzgweVEXveaFg/ocVd3i/qc1uUbmARAbF7sE=
X-Received: by 2002:a05:6512:3093:b0:5ae:b0f0:c217 with SMTP id
 2adb3069b0e04-5aeb0f0c2admr845655e87.9.1782655178876; Sun, 28 Jun 2026
 06:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609001013.1234755.d884b9e2028f.codel-limit-zero-bypass@trailofbits.com>
 <CANn89iJdrwPtMkexacercdV+2qDAZ=JYwGjW8xA1aKZTk3muhg@mail.gmail.com>
In-Reply-To: <CANn89iJdrwPtMkexacercdV+2qDAZ=JYwGjW8xA1aKZTk3muhg@mail.gmail.com>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Sun, 28 Jun 2026 09:59:27 -0400
X-Gm-Features: AVVi8CdfwLKISM-o_F_DryKNaa0rIlXCu6TvGzhfgwCjIqUwotxoPubZQm4wa6k
Message-ID: <CAE+C+DanBVutAamhr9RkQbhnAPphTaSEsznLn-PhbNK1LXyw2Q@mail.gmail.com>
Subject: Re: [PATCH] net/sched: codel: refresh CAN_BYPASS when limit changes
To: Eric Dumazet <edumazet@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302398-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:from_mime,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F10736D3F66

On Tue, Jun 9, 2026 at 11:28=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jun 8, 2026 at 5:12=E2=80=AFPM Samuel Moelius
> <sam.moelius@trailofbits.com> wrote:
> >
> > sch_codel and sch_fq_codel update their packet limit without refreshing
> > the queue bypass state.  Changing the limit to zero can leave CAN_BYPAS=
S
> > set from the previous configuration.
> >
> > The enqueue path can then bypass limit enforcement even though the new
> > limit should prevent queued packets.
> >
> > Recompute the bypass flag whenever the configured limit changes.
> >
> > Assisted-by: Codex:gpt-5.5-cyber-preview
> > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > ---
>
> We can't change sch->flags in a change() method even under qdisc
> spinlock, look at __dev_xmit_skb() which reads q->flags locklessly.

Your point is well taken. Thank you for the feedback.

I withdraw this patch.

