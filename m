Return-Path: <netdev+bounces-254888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPt9CJSpe2m8HgIAu9opvQ
	(envelope-from <netdev+bounces-254888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:40:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 454B0B3A6C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C695D3004604
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D32F999A;
	Thu, 29 Jan 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElBzHiTB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43251F09A8
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769712013; cv=pass; b=Xy1uZbD/ApNgmNrTxzFBQH92Zg8I4us8+26zxNobBVhCX69ExwKTs32vOMP1UfUpnBpHTdusuy6suAQG7KywOZV893nIZACu9LPHUZn46z4WtF6nrfzqyxLAIrYXMjJ+89Zq2U9VHP3MTQl/ELVX1dJ5LFzQvVuvTo6WkRt7DbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769712013; c=relaxed/simple;
	bh=f8cfPakyvy1Eh7fyVMCEsckwEJSxJA3C0M5/aOxdJzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2mHc68TOhgJbSgfkoCasHJCzq9UjkyHvO3/ukKQKPUofsUlxSWdnDrXyDsFI96ZT8J+grW69BY4xMTWiBmudsWVJ5K3prhoFjA1Yv9jC6gskprjB+a3U/MT/gExBTs56l9/YiIHwQI/6UUSn7Bo4prEeeAmx0uuolq/dDJAAYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElBzHiTB; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7b47a5460so11034565ad.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:40:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769712012; cv=none;
        d=google.com; s=arc-20240605;
        b=gexfOBhsRcTOTIgsewqCTYUMEQnpshAqWEUp73mwpWmrbufzpFHUxrudZillDaHXYF
         1Gzs+UDbj1qDi3rcUtOuueGjAAemGwuQ67STSugvxScZJr3SpdSdjgSz/8/4W4s9RAS2
         8ZvVRQt3hLbL7lOHeANWnPEH4xAeZRUAjQVmf1SgbxtKz4Bl0hpbbKajW72Mft+hVyci
         DuYDtI6FX9gJugOFUanCsVXHkR3CUq9WZxLRObiMIhqqXvbZLxN5BKCR8SOvFX3wXKKK
         J+eZpQomBcIQOAYwRuqh+qGMUhiZPNq+AgcHT2K1EqBsJB0/YTfV3LUOweWGd6T1eTS8
         1ZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f8cfPakyvy1Eh7fyVMCEsckwEJSxJA3C0M5/aOxdJzo=;
        fh=jVh5zQBZ/iZddhgo+NkKcEASvcpY+BXBps6oDyUDzDU=;
        b=hVIgXp+Vu01qoUJHFEZzf6bqw45DxRSc6D/P26vBu3uPFj9bu776/Jupwt4zgGIKtQ
         MKFUP/0TmafMnSFQhyNRwWUkLachU17M7MDaTOwOx3EetKURtr2F301V9Qr4GJG6vL6f
         wQnYlii4UVxtwlal58GsQpiDTZ3CzItDoX96MciKzJv4dUKgU2CwNLbzXRgj4flEG+9Y
         vd35mEfakF15TIcrnZcP7s/U/TDTiBZouTk3QPTv3LCw6nicLckLG+754GOr8Bkt50Vb
         SEgvZh+6KjwTpC7F7XgeMAw8voEoDm2es7NrpFtIT81qLOv5fBi2QgRWtN8UjhbA0TrN
         z2rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769712012; x=1770316812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8cfPakyvy1Eh7fyVMCEsckwEJSxJA3C0M5/aOxdJzo=;
        b=ElBzHiTBHuk+ZqTv+p/A3ZlFFUATUosbAv2d+TFURDdLoR3DnYA8s3v/9omx6yLIYG
         MNW/qqG2bMdECIkOQ4MFl3Taxra7+kinu44H886FhhiKKOtiv8leVS1fuU/+shSbaNlN
         grr8nxChiSEO+Mwf9zkrzvooU7a3B0x71P0a6IPzNuOKrJBZ0Woq/wcsmPkS6cTlU0TX
         1SYEcWJOTUogVcTagD6+vf/QLHn6TMeTI37niSyChMT47ORN5k+Yvx3/ZKElDEGKLFzS
         XZ5zMt8L2rXFPrY2ByOkJ92hQbiGJM5ZoVn4XDLwORK22W5yZRfhXZjxi/rSQoMGBp4v
         tpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769712012; x=1770316812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8cfPakyvy1Eh7fyVMCEsckwEJSxJA3C0M5/aOxdJzo=;
        b=i9zW0/2x/P6hMovam7+EM+iM3OFJ9hHUXd9Z4YIAOHcX29faTP2STdlJgK0VDq+2d+
         QHBvuJizfsV9vtBxxzIlxD6VXGzfQUKURgWZ/jxx9a/HIICdcG1ufw8Fetm2Ai/MCbbN
         ETkuwZ5jK7iTpYnftJZMxxk/C8E8B0yhXkoEXDS4fsVbpQD0fXe64HlCKci3hG0HKxcm
         xyT5izZAz2NJ+SkERmNk4DeeFLnep4SLT6B6r9Fr/bUqRWCqESibAmjv7mt9SrYMiGjC
         CIhh5QKTasUCt+4ssxnH5ChrbZ+hQFizYXOym3a0j3SmmWq9DuH/BhuCE6e0Kc3jqXcx
         BC5w==
X-Forwarded-Encrypted: i=1; AJvYcCVtsPwN4TCItRaHhZAjZTQwiCq3e/cRutq7GBYWY7fQIMS4WvBBHKUkGUbfFDbz14E0uIPlMw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHJE+UNdCibElrbfU3TeMeYg6qAqn3ipmSmjTb1qRGEhmX89A0
	JRsi0pts++JVq4f5lBNglBWfOHQig1wloV+MEMc+0GCGQdkyvjv06Ok6zCgujUFBhOzo6VhO7HW
	zRIxN9ljhn+lLtph5Z8JBQU5D64fq/6c=
X-Gm-Gg: AZuq6aIWAPqWF27ttyRLhhROzml4h3P1p4WXOl7GxmcLTqo4IYyZY4RftZrx6TQO8Lp
	5dNFa/Wu6lOThnkMkNUtQOd9lRsZnCmH22RL5reSYbELO5A+mYc1LCeAh0mBCzXyWtlE0AyfWX7
	22gbb3UG0DqvURdriwJ8L62dqq1idxjHVagU7mbat+qGE8TrijbzxdbeuLZVWc/koiZy5zkOMAY
	o28pUCbffRUofMF55DcJUsRpNB6T82GsGHn6YGviW3AUmSjw4cfkwqrzJy3C0SpVdjumIlrvKkP
	BlgzIFdrOcW9L/TQlFfSZL3wZwJkkM19SmpPHHYuPH+kB60TzkBDBr3Bgw==
X-Received: by 2002:a17:902:e84d:b0:2a7:9e34:f463 with SMTP id
 d9443c01a7336-2a8bd430fc5mr36080515ad.11.1769712011941; Thu, 29 Jan 2026
 10:40:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769464405.git.marcdevel@gmail.com> <20260128202406.69c1eef1@kernel.org>
In-Reply-To: <20260128202406.69c1eef1@kernel.org>
From: Marc Sune <marcdevel@gmail.com>
Date: Thu, 29 Jan 2026 19:39:59 +0100
X-Gm-Features: AZwV_Qj_xDOCpc-bXi0tieCcLhL3ExeBR6k7MJS_Yb-MUJhF3n-CjrmHtG0QkDk
Message-ID: <CA+3n-To=jD3z+PuRN6WbNf8QYeRErcOzk-W+Lovv3x31NHH22w@mail.gmail.com>
Subject: Re: [PATCH net v2 0/4] discard ARP/NDP b/mcast/null announce (poison)
To: Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	dborkman@kernel.org, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254888-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcdevel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 454B0B3A6C
X-Rspamd-Action: no action

Missatge de Jakub Kicinski <kuba@kernel.org> del dia dj., 29 de gen.
2026 a les 5:24:
>
> On Tue, 27 Jan 2026 00:53:01 +0100 Marc Su=C3=B1=C3=A9 wrote:
> > The current ARP and NDP implementations accept announcements with
> > multicast (broadcast incl.) and null MAC addresses as Sender HW Address
> > (SHA) in ARP or src/target lladdr in NDP, and updates the cache
> > for that neighbour.
> >
> > Multicast (incl. broadcast) and null MAC addresses shall never be
> > associated with a unicast or a multicast IPv4/6 address (see RFC1812,
> > section 3.3.2).
> >
> > ARP/NDP poisioning with a broadcast and certain multicast MAC addresses=
,
> > especially when poisoning a Gateway IP, have some undesired implication=
s
> > compared to an ARP/NDP poisioning with a regular MAC (see commit messag=
e
> > in patch 1 for more information).
> >
> > Worth mentioning that if an attacker is able to ARP/NDP poison in
> > a L2 segment, that in itself is probably a bigger security threat
> > (Man-in-middle etc., see Note2 in patch 1)
> >
> > Since these MACs should never be announced, this patch series discards/=
drops
> > these packets, which prevents broadcast and multicast ARP/NDP poisoning
> > vectors.
> >
> > This patchset only modifies the behaviour of the neighbouring subsystem
> > when processing network packets. Static entries can still be added with
> > mcast/bcast/null MACs.
>
> Not a very strong opinion but my intuition would be to target
> this to net-next. I read it as an improvement to RFC compliance
> more than a solution.

The main driver for this patchset is to remove the attack vectors
described in Note 1 and Note 2 of Patch 1/4 (in the cover letter of
RFC v1), not so much being RFC compliant. They are arguably low risk,
but I would think there is value in having them on all stable
versions. I originally targeted net and didn't add Fixes as I think
these sanity checks have never been there.

Let me know if you prefer v3 to target net-next instead.

