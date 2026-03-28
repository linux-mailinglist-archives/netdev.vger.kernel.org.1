Return-Path: <netdev+bounces-272773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENueNGzrx2nQewUAu9opvQ
	(envelope-from <netdev+bounces-272773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:53:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9641634EBC5
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D69323012E4B
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ADA33D4F2;
	Sat, 28 Mar 2026 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="cs4sm4o4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EDE237A4F
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774709604; cv=pass; b=lpLZaDAaBzX84RDZsKCKRasyxAZdcqICrbwP833oJhaSpx4SgBd16uzGSuD/yoGffMj7VW4NHtxuhP3JbWJ2QBMnFXMi1EHsjwWJdsnX428sz4SzPrP3Kb+5wFBEajtWG7UMQ1Am+zD1AvDvaN7c41/oZIh/EylvR3wosogbhhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774709604; c=relaxed/simple;
	bh=4iM5MAIov9TmmhEbwPy4MuWwPDqnNZAdicEBFEPR3Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tX9r0IrzDU44+M8z+OSEqFtap+ZDmjvPsmvkifo+000eqVGB3d8E1kf/eCQbCxL8ko2oit4aieqtpV1NlxQ5GVBmyWrEOfjKEWpCOEWuDiMPRFZ68LPfQx/MZSZT244qKnjFgyJ4k5ptB9TSdsQt2MkQVJOshep0CCPueKf/dBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=cs4sm4o4; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56ce5c899fcso1037038e0c.3
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 07:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774709602; cv=none;
        d=google.com; s=arc-20240605;
        b=F/YycIjFUtn6gMFvOXzvF+54ZTIr9c5aQRe0bhXflpBF3z2GJCfmn8V/w6AyV5peJx
         PEk3KJ0OHciqBZU5Y6H2YEv9XBRLvkJuR32cgkCLJVd09cPKhJJpi8ynf23XKcTGvVBc
         DIsSrmljWOG8yzZs5GELnEIMVw6UuKQHKHTGVd5E42bMVOJSbioNPvB3/hYjL5omttsz
         SsPE4VV9uCDoqzi+tF+Ol8vJmJs54HnR+h68//L/gPsd6ZLV6UJx6hEABvckhk9YoRuK
         s0nZ+BSpGJyVnBF1MB/+uiPJ+WgWEz26VkR+rRhTxD7c2CYGbbDUoTzF0iWoqrRUOSQY
         juCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8K9A4IepjhPa9vc6l7mHTCI+KSKE0N9+UTIgKNEFiw=;
        fh=RA+Qa+ISJfkVmZv3hENIA3DHpb/w9nUFTEfJNneqZis=;
        b=HqRxOtKBL68AVKMCxza075gKnQBw4X7+XsfIV+eAGSP9f2GeK3vq8viihFW0dgFiRh
         Mvnad2XzoTSYKL0ZFpCc6M4I+TKTg/aBLEuxeMXQasYt3sYzNdTTjAxemi0Kfn6QbKLG
         8zEylcMr2OQXheVpd1OdBl83+i4p25xKt5/N6uyFrbrmWfx9EqI45oF+p5YZS/6syyzA
         5U2kJGKXyeMFVQai1ft9hoTH5t/Vb7rTCcVgWNwy92YIMaKQG7rLPXG4BEk7hdcw314O
         ZJbDQdYxmBAV21mxs1vJ5iT+sWlAkbuKPd2PI8qjGbsKI75bzJT2wPX4lUk/LQZI74si
         cCzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1774709602; x=1775314402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8K9A4IepjhPa9vc6l7mHTCI+KSKE0N9+UTIgKNEFiw=;
        b=cs4sm4o460O+UhjNxM41E/3GSU37sMHpXBZ0WBjRrSSXJzyNKp43vI6keiWU0OR5Sm
         h/RO0brC88HC1npxMGrMF2V7+B5QlN7r9f+Z2BLRgCOLdhGxYRkuDEtXMKpPhcifRfaB
         9sUMoAD/bz+W/+WUUlUdruny9jYFAIRubz8SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774709602; x=1775314402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8K9A4IepjhPa9vc6l7mHTCI+KSKE0N9+UTIgKNEFiw=;
        b=s8/NfrWMI1Uk/Se6XUM3rO2nVdje4y5Jht1TMEPBd4IIozwkDb6lgCkAUWJ5MdK61N
         /u1peXfSt/huN45/9nLRhcfl+iTKuqoFrwqJxe2gTFzHMGGO+88uu5iGHV6X0cl/yzwE
         y+qEfWQGKga3Q0uvUgUBTdn7RyZTmxpgbkZUedU/TULY+50BiVgMyxcPLyBB24H8Al5z
         +ozInLb/9X1uUvco5jvlGTtMrXnlCPPUIr/ygaNwQK+BOWmzNy67FP7l9xh+f4ernYKW
         zQISI+RTWoO0jyfLNFf9LQGnZPHgUW68oAwoqzk/O3KQ2zr39uV8kK3jvgpynoQ90qKL
         +2qg==
X-Gm-Message-State: AOJu0Yx8+KaRsfYeDU7sGvriUDAmWnoRL5y5bsjvIvqUFdG/rMnKWf7s
	qtie0neXi93q19BsYNHk4LMmlC1czWvP6N4EbRht+2djESZSyZDX+Hboa4Ik3fmvwURl5X0QsBp
	UAc2V1sk0QLbQsoNrkSjsVQ9ik309pMJL4RmZ5lsojQ==
X-Gm-Gg: ATEYQzwHd/EKz3EthmO3yS/73oP3I1ImHwdzWxXH77Pln/A47FcMKy+ez5Oln+a+5q8
	frfm4beH8X3jm/r8jgbksPrLRQ5gDOFAUVIC4l5QD8U2eGRUCkpa3JTI2wNUuzO54vpzxT1Xm5s
	mcZUQ5Zzj9npm4VaQPY80rtbyfku6lXs++h96Il3olyaR3irad+4gGAPhG7A7z2RKV4eoQSyTZz
	WIlnf6vXIhnTeVWA3ERHD9mURvvktSR9PI/lDa5d1S/NJK15Ei8tr6PH6y6DHf8ClLq5vRzXuGV
	f6FKXfDI
X-Received: by 2002:a05:6122:6e0f:b0:563:72d8:ea6 with SMTP id
 71dfb90a1353d-56d4a5f6444mr2368140e0c.10.1774709602071; Sat, 28 Mar 2026
 07:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326131838.634095-1-dhowells@redhat.com> <20260326131838.634095-10-dhowells@redhat.com>
 <CAPhRvkw8eopbCei6XQY3Fi-nDk+FyuXUWs8ToQyHE9J229_v0Q@mail.gmail.com> <754861.1774596280@warthog.procyon.org.uk>
In-Reply-To: <754861.1774596280@warthog.procyon.org.uk>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Sat, 28 Mar 2026 11:53:11 -0300
X-Gm-Features: AQROBzBU8tH-q4cuA3iSTogdzoLRSLE0c4b3XuLrC74SZvPkg-yetUQ-5dfx7O8
Message-ID: <CAPhRvkz6xBqm+eEmrGKjuwuXu1QXk_UTsri8B2HXe1K01vaYJA@mail.gmail.com>
Subject: Re: [PATCH net v3 09/11] rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>, 
	Simon Horman <horms@kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272773-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9641634EBC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 4:24=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Anderson Nascimento <anderson@allelesecurity.com> wrote:
>
> > To make the logic more coherent, what if we check if (rx->key ||
> > rx->securities) in both options and remove the rx->securities check fro=
m
> > rxrpc_request_key()?
>
> You're allowed to have both a keyring (server) and a key (client).  You c=
an
> issue client calls on a server socket.  The in-kernel kafs filesystem doe=
s
> this, for example - though it normally sets the outgoing key on individua=
l
> calls.
>

Understood, thanks.

> To parallel the kernel example, it might be worth my while adding a CMSG =
tag
> to take a key ID or key description so the rxrpc_sendmsg() can do a
> request_key() when setting up a call (the AF_RXRPC socket allows a differ=
ent
> key with each call dispatched), though the AFS command line tools tend on=
ly to
> talk to a single cell at a time (you only need one key for comms with an
> entire cell).
>
> Davod
>

--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

