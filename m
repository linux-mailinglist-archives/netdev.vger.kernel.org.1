Return-Path: <netdev+bounces-263200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI+aG4TepmlkYAAAu9opvQ
	(envelope-from <netdev+bounces-263200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:13:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C142C1F0030
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47A3E3130E26
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB09425CD2;
	Tue,  3 Mar 2026 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="k2OSEZNg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC358421A11
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543302; cv=pass; b=p7LEfkfeCIJuMbGKpes3x9yCWL8rOQaCiOtJrbTYSx3m7ipS/uRs93KTIQb7e3jqn01yWMsa18xED9/zWkc5FuMbQUAIT+lWDAUnSOsScjFkBsYlmRK6Enl2/Z5+8TJrd+lATdgaoTjPZ/cJl2HvokoyW1bL8jFzJYkcZZde0E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543302; c=relaxed/simple;
	bh=fEKulSd1PmTL8WxGU61UMjkUJvtTae79rFbx+6mxzoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHXZ6rzgp4nAAy+xc9KPrP8iw6CkwMjRFi6gOg/1rhwkBmS4Dt5+97sqP6NdCDHmv2SstU8HizbBQP1JYW4aAp6mkp/4Sju8cGS1Wk1/5nTnhrmPUkqfZKoZEgjG7AKkQM6yGYFmDOsg4DhqQ94HFyGXeIXRYuJwQOfaIqj34MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=k2OSEZNg; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79860421382so52816797b3.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 05:08:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772543300; cv=none;
        d=google.com; s=arc-20240605;
        b=W4fW3zpvwkt7XnX7NxZiC73jSG80N97FitbqGajQwOeqWGEllL/wZ42s7t8WkE+qHd
         LS4tCs2Y3v5fLW0bDd7hWSpcHpi001SvHlWg8WeYhaHDwIRwL5+Pzm4C1bPu6BWgwUQZ
         6Zy8gvZWxMbgIxUIFxJRKO1sCHOb/zcAOW7dx7QbMKdud9aVRcNr+exNn7w+zb/gwAqu
         zv2g/WBlAtLHEMPIwa+xqe3vU8+3wM4YyZ24EiQziAr1/J/M96gvQYt/z9xNgi2Oza4K
         aj1HYK7V8tv3+M9AgPji7DP2EsV+HGzOO0kB/moFHsX6IYsSVSjcpxiQOiZVJJ5eG6Fw
         3Jxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zzHyJu1zsXD5QTAUauHKQsg8XWyFjizwJkcjUH3f8pI=;
        fh=Fi9N6eQ3N/AvAiCSRAJz3QfscejVU/ANMZqRLq0N2qc=;
        b=RznHVLTdu5MXWsDeIxfvzRInPs6pVPWeCC7DrEamX3WAKlWvsFR6IlA6DFnMHOwdKB
         DkW/LUqq/ooaH+5pMEBrMjMO/NDSlP0ToaCq7Fosy7YNh2c/3AvUgurbxulpwF6WzCo9
         DhAfJKlRp74eBq9u6G7Bl25HZgV4Ogbw4oIxDwn64KRD+5WOXBPD658prYUEFxdhJMmS
         VPPW8bjV46J2v15usTrGYVT9pYSny4SjRQh4tIcDkWjoiN+Zn+XDRxuXsAhpatFyfMqi
         tnpqyX8hDKchcb6PtWg36XUdR7+zE5MVZtwLDgmEwaka5FEZDNyh3DrS/raj/e1uwk3/
         FzYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772543300; x=1773148100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzHyJu1zsXD5QTAUauHKQsg8XWyFjizwJkcjUH3f8pI=;
        b=k2OSEZNgvl8+8d55qdCe6ArRWJ0BhAywf+anDFW4eQI/wGaelUBpT62RGRUqxenKf1
         7nVznTOqSHQEsLV3MEByVSZ3qGxvOYoTiLAcyzvUAi9eqwtCzGLxGuleTiaFW6GljQ8L
         23ddf8y28OzM1zqPCgmkwwzjG8BJ8/xWJC9ThjZfVclyjhVboMa9JrrHZqutb1nCKzyk
         XMPHMrythgzmP2jlppVigdDUfnSU7TmugVavinUxHrQQOqkatN9lDH1kSN413J6z9LAu
         7IoigmG/KP78XBIgLSjUWy+BXdP/jmNnflX1O2QtUZmrSuB02SPOcuIevU4LaC+Lk6tG
         bZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772543300; x=1773148100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzHyJu1zsXD5QTAUauHKQsg8XWyFjizwJkcjUH3f8pI=;
        b=YarDiY1IO4WYGHU5U/ZkzG1GlHfCvAKunYnUM+pbBnbf44aWyfTlNXqjThHM+uwPRu
         frCuzyHP+Bzq1d9R+uoEYCY+oL+ExNCvqa/ZbeUUkYSGQAAVphg9gZkJ0AIl9wkjlYxa
         1O0OC/BCbTB0Mtua+LLze56jpnp9QX74WZcMPyo7GB9r7WRDrAROEu6D4HgVlH2I1A7/
         iQVCYP0N69eBuYx/M2/65tVAyshfI5zFzIV7p5pfTea+IeHttJaeHPDYgUaDwtbghidf
         QRdxzuYcMNOKYJ2eHNUWIVyKoR6Trd7NQwz4U3qyeUIPB7EGtR2567e2EF4UoKpOyRv7
         SN+A==
X-Forwarded-Encrypted: i=1; AJvYcCXlEmNpc9qYfxCwqwL+JuLu5AwWfkaE1iVomaN6nQ7oSGxBBbtGD9/RWoscl+07pGFic5ztz5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWUBZMvd4bxivDc9Y7EkWKTMaY+Ns8eFA9O05foj4ubrbPAa9
	ge6jxvTC8aZZeSG4JW3eL3LahSh/ghTEkr1td/pI2Q0NaobWeSUmC03Gojs79+6C+LUO80aP8FD
	BloiTRgdfqoapXvRHUevnyfuD+ysYWPM+NLURNhemDtOztRCMO/0=
X-Gm-Gg: ATEYQzwtkg5B3KQaPSy7XxfOJ+3G1dHtulRcwejBnYoyiKQGNSzAN/4qnNdJTqxdsZV
	n13+g6rD/3M9MDoy14L1Y/SY7pvhrOfq9xpsXbsvtptCIGvvX1wOLi5p6pTIxuP04X3bBg8uHle
	1XQ0QAX+LZDqRw0AjZHEGecGU2a5CZq+oPcP16Tp3uu7BAFEqggTgn3fQbYamg40qOnoyQmdGBT
	FNtPrNiOQD0znUeCKXcAAD6AqriliL1hWiWkaMZQZ3Foa3dXddnKRY90+mjh7AjRHjX82SxYfqH
	A8poAesnxqY3rinTZYW8UQ==
X-Received: by 2002:a05:690c:e3e9:b0:798:5cab:cb70 with SMTP id
 00721157ae682-79885508bbamr125655137b3.21.1772543299950; Tue, 03 Mar 2026
 05:08:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211170725.1514427-1-victor@mojatatu.com> <20260225132623.0395441f@phoenix.local>
In-Reply-To: <20260225132623.0395441f@phoenix.local>
From: Victor Nogueira <victor@mojatatu.com>
Date: Tue, 3 Mar 2026 10:08:08 -0300
X-Gm-Features: AaiRm50EyCTEPDcr6AUXLMxJ27vPuyrGVeJ5tAdanHPFgLZcex7MUnGfXnQ31vQ
Message-ID: <CA+NMeC8P7RPudNkDm6kUWjxEZKJDZZg0oNDr2Y7K00NUzhOXbg@mail.gmail.com>
Subject: Re: [PATCH iproute2 0/3] Add JSON output support to the remaining qdiscs
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dsahern@kernel.org, jhs@mojatatu.com, deren.teo@outlook.com, 
	andrew@lunn.ch, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C142C1F0030
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263200-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,outlook.com,lunn.ch,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,networkplumber.org:email,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 6:26=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 11 Feb 2026 14:07:22 -0300
> Victor Nogueira <victor@mojatatu.com> wrote:
>
> > Since qdisc core already assumes all qdiscs are able to output JSON,
> > add JSON output support to the remaning qdiscs (HFSC, QFQ, muiltiq)
> > so that a JSON qdisc dump outputs valid JSON.
> >
> > Victor Nogueira (3):
> >   tc: Add JSON output support to HFSC
> >   tc: Add JSON output support to QFQ
> >   tc: Add JSON output support to multiq
> >
> >  tc/q_hfsc.c   | 29 ++++++++++++++++++-----------
> >  tc/q_multiq.c |  4 +++-
> >  tc/q_qfq.c    |  8 ++++----
> >  3 files changed, 25 insertions(+), 16 deletions(-)
> >
>
> Good start but some minor issues found by AI patch review
>
> Must-fix bug in patch 1/3 (HFSC): Copy-paste error on line printing
> level =E2=80=94 it uses st->period instead of st->level, silently emittin=
g
> wrong data in both text and JSON modes.
>
> Design concerns worth discussing:
>
> HFSC d (delay) field is emitted as a human-readable string in JSON
> ("5ms") rather than a raw numeric value (microseconds), which goes
> against the iproute2 JSON convention that JSON should carry raw values
> for script consumption
>
> HFSC service curve keys use flat compound names with spaces ("rt m1")
> rather than nested JSON objects =E2=80=94 functional but awkward for cons=
umers
>
> multiq bands emits a compound string ("3/16") rather than separate
> numeric fields =E2=80=94 once this JSON format ships it becomes API

Thank you for reviewing.
I sent a v2 with the fixes you suggested.

cheers,
Victor

