Return-Path: <netdev+bounces-278759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMN6Gu+G32nSUgAAu9opvQ
	(envelope-from <netdev+bounces-278759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:39:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B066D40457F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28077301AA62
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200362D7812;
	Wed, 15 Apr 2026 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coUeAToS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E361518DB26
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256449; cv=pass; b=a2aEpjJx1pgRiRk89rt/vvS6cVN/bTB43sl2acXQ4e4Y8vsdncWAxaURaa79LU2edG8JJnxCkXqoBsJmpmPeS1bhtRwm8b0Xr7s+p5LhQIr0eUIygkY60sifJ//QVubm6WLQZmCriXexH5nfR7R9GZNoPn8jeAOTdBxZCrxop+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256449; c=relaxed/simple;
	bh=+h8HlJDwvYNw5rua/v6Zk+eoY4fhxZ1OcFHecBDCW7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDCI2mTUdZsU72h+SlJ271ezCnwJILvuP1gqKnX02vx9FhjGenlEt3XaaN74W9No9EAGxiBY6QBgwYS0XkecUUnGQC6vm69Roj/VDVvoG7Ju4p5TLqHGXBUAx8G/gV5/aKpxwK1vehEfSbwwctQPDHlXlLhxf3ZH9SIvBy7+U9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coUeAToS; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6e2355739dso3018020a12.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776256447; cv=none;
        d=google.com; s=arc-20240605;
        b=IxtpKmVLZWbSJpmDD9x48OAoYjDBSUEZLzChiz//JVo+Pv8khynvLb0X9LkcsG7AKB
         3CiJ+xRFNC6M6WyZBJH2AL856/kgxNKBh2w+B47sLXjRWwkP5SWezizcS5L6uGfGBql7
         MJ9nRF6WRMFOGdi9dgKVGVTxPZN7WtJCEqGNqgqXsNfQyUK/oS9r4BGZ7iCkX36LA/Ms
         Ma1MNbuuTh9VGF111S2H9YfGnPM9SEOWG5BSpiWbh3BkvO3FNuARy4ojVkmxZ9PXqhWA
         SrNsALauZhHCtORbvwz5feu6eMokZKpaT/xvQjHLK/bRxvaC6w542zR6DbTppLx7yWp7
         rGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9v5h0WGA6GciBmySthgQ0LZ+Ql4Vyrp/FXGCtEgGi0I=;
        fh=cDI25iQxdtp3W3DH93XkhZebOTxjmZxDQhFHk0pag48=;
        b=PXhFUwpzt0tmfEk2WAbqjGIjYb9Q6B7YTlPRYzXyREmzBd0VUKSJcR4U7ogMIovo+3
         N4dkjpBMyT8YlxN3nGQkeUZPvaQ/K51UyspbeISk9l69qFLPJTzzPq6tnl+uCktWecHG
         AHCCzYnJmR0xOKUZGqIQl5OSpMfD8WhfMHuUFiFa/uqqfwB/lmlQDlo3dEtPii1Vmi4G
         z4En+6lFCsfYA8ZgGdMSNc0ZElUWL1oq/tU7pIGFfWhDCpII4kuoHUmrrYuS/US1KuUM
         hP/SvrpAzmYsx0NFE4BgSqq6Vkh93uwoP7NXsPGo0nd/9lit5jy1O1yBsna80QxTgDyu
         er9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776256447; x=1776861247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9v5h0WGA6GciBmySthgQ0LZ+Ql4Vyrp/FXGCtEgGi0I=;
        b=coUeAToScc18oshLGC0r4BNfr+qC+POiK+moOCSMnnLTMm2Kn6FCEJVPZBsctVvdEt
         j22YgRLi98r9pGRpxNkhZTPziPIVbLiK7p52l9D/jde5zByL/bWO5gZixlsYEypEH9iZ
         7QojMrYnMFJYKjw3rHFt5uZ3JijHGOpKDy0vxDGF6lq1jEVAFPiGJ/alcoXUj3B3u/aK
         yfdr9iX8dEONtCv9U+Ub68K6nMoTLJnkWCkH44THSydRKMywhLXp9RyoA4SlEt1+1Tpn
         588RupYVXT+wwBKeQPBraUpPeiYnOFTZha0km4630k2dRJIeXxUkRNwEmK8ku723W/wM
         4KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776256447; x=1776861247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v5h0WGA6GciBmySthgQ0LZ+Ql4Vyrp/FXGCtEgGi0I=;
        b=da+/ZJXzzKJK3J++SNOb7VMD3zCRxNA1ErvejunepvWvNOD6ot2bZ+b74W0CitilWX
         Zp8ir3ZL0d1uLrkdlgAVefhpnx75swUpqSb6DtfeNnC1VYlRVsI4A+bIp+2HTIc4+uzb
         iXghwSYCqJolgO8hmINqqWtgLF9g4OgdZhY5/bzgDaX54C9UuhKgTqPAy1qhRwJfrHfA
         uNhv+slkJ86TJpyd9JBdoKUND3wn7I1QmNm+jj2OIS02AHzd4t5AYOpzzVwJJ7oMcs2H
         acOurlxX8BAspgdhW2MyXiElUsN5Z3ifFvTV5/QqoAHEX3Lh9k262e3pZ4XXCbH6OmBz
         Lu0g==
X-Forwarded-Encrypted: i=1; AFNElJ/oy+P7Cq9/L/Oc2o5ws1w7LTpgyXffnZOdo4yk8RTOzwfOvXlslNwwl9JlgVzr5RG8T1qgMns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAFXtOfZ/EPctwQn9wL13rRHGIK7/bFptIObZmab6vTBxzd6Al
	1Q++tQ4mZOfPg6LXQdKL65lRBO49uXYxOhOs+XloLHDIBWY/xa1kT4BJyI6dCVzVRBkLR4wKt7Y
	0ATk+nppMR94SiSLj4F48J0W9mksuiXA=
X-Gm-Gg: AeBDieuKMBxUwU9ieAIJGmwE0SXMjJ43TnSsASLAA0lhF19dauuH44O0z3UZEVXblr5
	vnmMPF3uz8KSZaI2Aitnqa/qsE6r9NXiB1FiQFyag3qG9VXM8PYwlG2YVTiyu954MSt8ewkAYQi
	T6TNFT6pmDKxsMe6+puT2XwYZx01f7OBDMHGHJAPze7fGahLQAkH9LxjJMTvWcJgu22q2F4FD6i
	3U2+6Ououy8LHMgZ9y1TZ7bmMSV42/xn30MysKNNlEMuIOwCxOJfP/ESizfbJJJh5nWGFX+P/Ei
	JYp0t2uNLcKPB0eivJGK7bSBJakCAA==
X-Received: by 2002:a17:903:ac6:b0:2b0:60db:7927 with SMTP id
 d9443c01a7336-2b2d5a168bcmr221211305ad.28.1776256447117; Wed, 15 Apr 2026
 05:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com> <CABBYNZJAEqwfTuVqbFAnx97HBSjcwn3Hb+y+r4r2C=MMPxFoDg@mail.gmail.com>
In-Reply-To: <CABBYNZJAEqwfTuVqbFAnx97HBSjcwn3Hb+y+r4r2C=MMPxFoDg@mail.gmail.com>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Wed, 15 Apr 2026 14:33:55 +0200
X-Gm-Features: AQROBzCJwjrc1bDi-TXhcjD-wf65qYVngCDiW7f3UZYU9kWetoIg3teCKW6NkdA
Message-ID: <CAMT+MTQ6orj5tpiGL9hz8m2TGiBjA-9D_0e1iLt=_dXBFHcOgg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add Broadcom channel priority commands
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278759-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fnklkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B066D40457F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 at 16:00, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> > +       if (sock)
> > +               set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
>
> This is more complicated than it needs to be. I'd just add a new
> callback, `hdev->set_priority(handle, skb->priority)`, so the driver
> is called whenever it needs to elevate a connection's priority, that
> said there could be cases where a connection needs its priority set
> momentarily to transmit A2DP, followed by OBEX packets that are best
> effort. Therefore, `hci_conn` will probably need to track the priority
> so it can detect when it needs changing on a per skb basis.

I have tested per-skb priorities, and unfortunately, this does not work.
If something tries to send a low-priority packet (for example - a volume
adjustment), a priority drop causes the same kind of dropout that is
caused by scans. It appears that the only way to make this hardware work
is to set the entire hci connection as high priority for as long as it
is being used to transmit audio.

