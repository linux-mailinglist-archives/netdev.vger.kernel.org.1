Return-Path: <netdev+bounces-258937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL1QNsJak2k73wEAu9opvQ
	(envelope-from <netdev+bounces-258937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:58:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD7146D7B
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 18:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 006493003639
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913142D5410;
	Mon, 16 Feb 2026 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iA6acZ/c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FB23AB88
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264703; cv=pass; b=ZWWfIf/fFEdJF+sJXICuIp3fnT1SJsfvnFzC+Q2Yzz6ZpUP0IRe2DYocgAmG6gb9RNgvbDOGUhCIXFG+bsG49tft5N7kJ+VWWaJDs9HTkWqMfBwdzxZrlhXSmf+g1hw1v75NKRO4OPqyLNdSf8QK3vGbzz15dGCOoT1SlMGulVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264703; c=relaxed/simple;
	bh=NF/x6Z2dLnb0foeE2Uyl9HKrKGOBwUc6kvt94j6iojg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzsHUljBd7rDe9By5w2oe+TcqhWQQ816QJcsXoQUIk/IMdw8vtYQplvyR+ddTw2Rb8RRYvHtNwN3fKNYuRFP8wKra2UYvHmidBDJiP0xdXlYStX6QSEEr4kkTq8zfGUzuBA0Ge/DcIDZfoiwvuLo/XL2xno8AEgIFVJhzppbWQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iA6acZ/c; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506989e8516so30716741cf.0
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 09:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771264701; cv=none;
        d=google.com; s=arc-20240605;
        b=eJer0eebVLh5vfl4FhgmuxXC8nn58sgOsXMymg3zZZ8MhQjFsJortszOFqBTbUJAet
         sRoPF718j/dfck9AQ9Vo0PaGSJyOUK30sUwXbDMVpZfY4EYq7rwJ/qx4lDymyK9wt+WS
         qiHEPAPvknwtRgsglqSVmHgqqoy6CHzoicp6TOtCVw312RVpLvuC2jfezW55JSH93y5l
         jdkUpNjqSWFtpBmkSJ1bsGfuXH8cA0znzPhCgokF9+SVXbmUOwIt/uC3qbpaiRziv/Fp
         SXjYYyOGD5LVuhHfPZIbEl63l37uXmKKLVTnu7wPIp/mX6ZRHNq8UvAgNqnkxabVcsTC
         27WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NF/x6Z2dLnb0foeE2Uyl9HKrKGOBwUc6kvt94j6iojg=;
        fh=FE3uyqFO9V6DpaMRfrGrTKIpUZpHtf/vTUq0/P62vAA=;
        b=e+4tjMc81Fuv/ePN9Tj6Nn0F67hw38CoChxUtsekA1oiJ/BUhkPvRBWx3JZ6AUG44h
         PpPWJvlR6qmW6s7+qIgNdZ/m9tHxBoMMtSpyPGtLlYNLuGfNoxLwW0jqIuSaPTQTZnl1
         ZLXWpVM5fjsYs7CybVhY7N4fQEkHMB4dcarUKAzvnpc38W33O/XBFyXxLy3iply4WFZB
         MzleqKgeZGvRvjhuCP+5qjj1w8XxJ2Pn/+2ZLbzZvg6InW/zv/Tgy93IF7QMOMCmsHJT
         WqQCkgXdrzzN+0yeQte3TK8Vgk+ErZuni70AUBxzpIyXEOO7qz+XflhFiqJD23ZNes0I
         Xrtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771264701; x=1771869501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF/x6Z2dLnb0foeE2Uyl9HKrKGOBwUc6kvt94j6iojg=;
        b=iA6acZ/cegflZlp54SA3UjqV+HoZfE04rYVFAIIg5j4ASRu+Tj/2y7uBTsvMXtRqmC
         ggAOaY7I0KRQnOFqo1Y/WZca6Uq6+emMbT9SFWfe87lasE1NyfLENHF5VQFX1hZ1TTlR
         pl18yakpDPl64aYN9sZZc8TyrR2N7yz84mSukR52TockC5jexLdJbbYbx29BDQ/ZeR97
         /30S1wXCDaG07kA6R7D5747c4tgWDctBArLZwoiXGouNKexBo18iQNT4dPx6FbaY03Rh
         M63NOKn/ZwsbIW+NTuzyEHnN2kJrXaaAlqNp/WLKWmYUWHTDYlNnVP+qF/0eRsrT/vKv
         mWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771264701; x=1771869501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NF/x6Z2dLnb0foeE2Uyl9HKrKGOBwUc6kvt94j6iojg=;
        b=suc2yK1PNyr8FpalOfNrG4ypRjLm5grCHvhxpm65IgqoKxL1TrhAYdIdnxWoGzfC0h
         SmPM6FnnGWuPc8FRfhB/CzdiIZgxxT4a0j+8v0IfdPZS7rOepKRDpp52k5ysG2C4x3B8
         mLj6CBDUQIbKeVUPJ6fWASV3vzeO+4Onhzd2McjwTSWykSak9u5367hYgKMaVjatrpaC
         xGeSN8SzZLWejQgQd6NNMoIT0lbVwqAjYTXIMD6SBEUPkj3ObB/B2nmkaQRMQrmo8OLv
         XVKb/CPzoxrhzQ8wCfUFtcsRpqfmJGB8fAxiV1CYeGKgIvijds5qqa1AH2wWRNNnLq0b
         6pSw==
X-Forwarded-Encrypted: i=1; AJvYcCV74lBPYTG7mU5CgB/GsW9a06dLN6z8Fq7hK8cO6nJudrywyftb5MaZBasswDQGG0tGudSVAs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIuqsblvT3XZHetwJ694NOG5RwJdM6RaLXntHfDzviwVRN15aS
	t9goyZvjah7N8QgmtST9aaRRBu+iPI2xuhhRzF6Vs9/55vluM/UzL8B6MmkZvyaqO3Hk/EtXPsW
	iMevlHs8lvC3est5UTcn8deuGyitjwgQzRMANmFKR
X-Gm-Gg: AZuq6aLn9JuikvfSc/i7dwO7di87WMBxZ0Q34z8zGBJ49wJRAA/s/kXZia5NhoFeYAT
	Z56X7B1wUJqtQzbbaIFU3z+SRm4bOUpHqkLeRRGynXRix1dsWfs/Du9KrP9D36aBQ//4q1wnxfp
	BRUJlZgPHSBd4J+BlQiFqZHIP/n8V/CCjbELIEsx85N9sEnI9xcYJi/pDabHTow2VXWH4uSavDy
	RKh4A7ndx9uU+j6CeRrJtgvZNqn/7mGqH2sGStDVWMAxUnFRV1amwQ/Hug0NMEJ4o5rFEdVYqhF
	kmN9VQ==
X-Received: by 2002:ac8:7fc7:0:b0:501:4b10:aa9e with SMTP id
 d75a77b69052e-506a8270c3fmr147760281cf.13.1771264700648; Mon, 16 Feb 2026
 09:58:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117164255.785751-1-kuba@kernel.org> <CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
 <20260117150346.72265ac3@kernel.org> <CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
 <20260119090435.44b1da2d@kernel.org> <20260129150459.29419003@kernel.org>
 <CANn89i+P86WVVUY-4WppUAH1TGix1Z3KhgX9vSHok5nXqQAiHQ@mail.gmail.com> <20260216094936.5bf9d789@kernel.org>
In-Reply-To: <20260216094936.5bf9d789@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Feb 2026 18:58:08 +0100
X-Gm-Features: AaiRm52kGx1rNqhpktIYbPWRIp8XvlfGMbREko0d5MpaLWaATxpnrxa0GQL7bIc
Message-ID: <CANn89iL+kzhRqwBr5wAcEBMdC_wbLFanHJ6VxS1r5ppGKUhftA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258937-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 50DD7146D7B
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 6:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Feb 2026 17:06:58 +0100 Eric Dumazet wrote:
> > > > Looks like selftests run into the zerocopy Tx latency issue.
> > > > I'll drop this version from patchwork..
> > >
> > > Delaying zero copy forever is a bit of an annoyance.
> > > I believe the same thing can happen in net-next with UDP
> > > but I haven't tested to confirm.
> > >
> > > I assume the attached patch is out of question since it came up befor=
e?
> >
> > I think I totally missed your email :/
> >
> > What about not attempting defer for zero copy skbs ?
> >
> > It turns out existing patch e20dfbad8aab ("net: fix napi_consume_skb()
> > with alien skbs") is already a problem for zcopy.
>
> We definitely need either this or the timer patch I attached, for UDP.
>
> I put the TCP write side on a back burner because slab sheaves got
> merged, I think skb defer free will still make a difference but IDK
> how much. Maybe juice will no longer be worth the squeeze?

It depends how many frags are attached to each skb.

page frags are not yet handled by SLUB sheaves :)

