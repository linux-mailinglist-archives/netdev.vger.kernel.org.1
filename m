Return-Path: <netdev+bounces-268873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x/o+HAsgumnCRwIAu9opvQ
	(envelope-from <netdev+bounces-268873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:46:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ADD2B591B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58ABE3019928
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30701FC7FB;
	Wed, 18 Mar 2026 03:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4OsSlNS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361B1155326
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805575; cv=pass; b=RCI3u2ff7+ZfJ9ig3RQNZDd/y5pulp0TRW6twZaTIWH00i9JMlO98vZzj4pN256wyizI4HxfHXrsnuPCtakhX/3KnIoeg+NHQhzIbMPAmbLKdXAcvDYi0OpERjucwyFZ0yYIuBgqlFh/AED+2uSDlJ1yrdIofq1zVaqHsOpxAOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805575; c=relaxed/simple;
	bh=JviHpxyLpcgl/qvpTFoHcGCNmAqz4TMcbMO6zivSxTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVzzDpChges7Yq7hCFGqcPoydnsgSPGv3g8kCEK22/02dycu0efb32i9zXcjVqoFj8bC2mphmnCH5/EsHFWB7yKTiCmQdOmifM/33bD/dOVJfd3FXZx6VnIQrRHxzRf6qZsrBz1h/9wqL2jvLLZBA8ARxF0qkE5UYcZHXdmYPFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4OsSlNS; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b49819938so1054419f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 20:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773805572; cv=none;
        d=google.com; s=arc-20240605;
        b=jQRjSxhotnOH9uSAprJ2AdgFymoWv6fY/IpWAd3nUcPEHgSJ1a8R2fctqGdxUhTX8+
         wsfQDfOc9tvZKYt08qfRRlr3AXhBZhx2Ritx3IJ0FPfmeDqtnCOWRr30IqZAHpcDN1kf
         Tff6etvn3iH05Er4LHsrGn33tQa1DL57cFhXuQY9bUIcP4DiQhY0AOeyzYeLtJ6AdOTC
         SboeTaXCjN+bMUFCCucMS1N9iV0FA9EAjRL+zV24R0+SsVp01vcGkJDW9INa6jxUYNtB
         mcB6bKSvHv/tGLIL++zbol4dZHX3FoA/5442EqRSfInu3THuZZhjsYJbBiJjQpVN5UC/
         cLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JviHpxyLpcgl/qvpTFoHcGCNmAqz4TMcbMO6zivSxTk=;
        fh=eua2HRln+qTWRkDZA66/fvliytCAurp/JhAs9vHfycI=;
        b=hQNE9oXqnFnUWaUIJq/+MFL8IZbAPMOqpLsvbhMQ0JzzxbZBBTaOyBcd8+PapEWPII
         2jsFcGfqxn4fg+SsEm7+5HSsV6K2SxYLZeb9DC2iGPqFLTgXPOguVV34209kOhG2LTIi
         wga9SyW2LUMI8SLsDqanxBsZBPeSLdsqnxBzi1C8JtPgdvGZAnE+uwFChoMXPeS5jgQ4
         1sXIYtB0+WSnyvP6GGxfFuDDUx9aSn2PN1O88AnsD/6My6QDZYltkWlhTDTLHvDqgnxk
         6nIOGLmcDf9OCjPqZcEAr+eZ1eZslHhZiv+x1GLZST7AJhBkyocKPn04JD1jbDQGdylM
         DAsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773805572; x=1774410372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JviHpxyLpcgl/qvpTFoHcGCNmAqz4TMcbMO6zivSxTk=;
        b=l4OsSlNSB1foIHeHbrYpQzZBqF8Ltt2VUEoqHk0UufaWBqoRIlBQN5lhWwvg+p3S5M
         xo8uLiioeWZNhHCoHO8ZMTv+wM+4ktn7tB1LYTL4pbdHKOwmzooxklxjsSOvtSHS1H4q
         2QP/LaYDBhYT9rZQv4Xqlpg2wEoyeNqO0C90n1bmgA1zccmr7nWuRAqmPSruezKnkB2x
         cBcpNDbXstf/vPqENAcIz4Uk2yW0Mxdm5QcvR04cAPBRmLlFdYjyVsOt6cm1bfequv2H
         ZpH+dU2l0i+dOM1DPggGeKWnLNy5SLYxa0KP8gEoUCGPSKOqBKbxOFiniVdKmipjf+sx
         tHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773805572; x=1774410372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JviHpxyLpcgl/qvpTFoHcGCNmAqz4TMcbMO6zivSxTk=;
        b=faW8xa+fLLYeZwvoaKEaG6e6NcUxv2Ga+HbcLSYkBYdKsGyyCCKINLdb1sBNG2ZSnj
         UuwDm4/hNGDrXHcTW9fpPn3d9RFBFQMGp/a+n8t7CcL2hBmwti8jHQLJzSysZ7CE1WYQ
         w/c4n8dh5Oe56puV/kxNE/+9Zv3qIOtmfxYiGuZLjB9+/zk+gTufc1XOjLIULNQymvip
         w6CVE+8IDGVtjre6kscnYpW+gTaw3RQgZzHAm7SWTRMw29DPGw9b1Nef83O7j3beuqT+
         aTAf6aUlcbON6WSfkDfAPViDhMGlUJ25w1BdnKzxZyAPFTXp3qAQYgJYxft9GGKNdF+a
         Ea/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoHU2htTHBgqyXea6fSwe6If7wyvOyx0QRa2X3Q7OSMxc7Yng7RVg++Mpn9i+6Ka4m4Ix3z/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAFwdG/YSNilQdxoLjwvrmA1H0XZgIRLKZWDpPmJKM5bdthuxW
	h+gMwFKL4PDd0i9eO6PycOK7F3i+we0fiTKRoczIbPLJ3LAY2BSpzJDYm/qG47fb358AioPn8wN
	4wdBtGAGLLWHy9bRfRl+vCFm5giKwhxc=
X-Gm-Gg: ATEYQzyoiVBiPOK+Lp1mh7qH4AScll0L81XFvMcnpm8zm2AIVMj8mAPFZz+9Z5UVliH
	lO5v/x5KXZlyKtG/epa6n7RrK/lBrn6lEaivl0uf3vC7OrRzbz74ETeGsVjrxsvK42b7Qts9goW
	ExR6pejFUNhaGBjPgFQF4DTUE3wfWdLQC+kBpX1eXLlpRF3SmFF4YyCEPlWOy6d1eAMew7oA52/
	dNRqLgZkzamd1ZcNQonPzSzYfvOKo64RfuatSKSOx0iolvGiSC285v1CRyw3HEJYS5rs/2YR6Ho
	L374St48kbbBMw2ejRKA
X-Received: by 2002:a05:6000:2089:b0:43b:44e1:f661 with SMTP id
 ffacd0b85a97d-43b527ccd8fmr2614153f8f.36.1773805572271; Tue, 17 Mar 2026
 20:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316021009.262358-1-CFSworks@gmail.com> <20260317202718.3a5433c4@kernel.org>
In-Reply-To: <20260317202718.3a5433c4@kernel.org>
From: Sam Edwards <cfsworks@gmail.com>
Date: Tue, 17 Mar 2026 20:46:00 -0700
X-Gm-Features: AaiRm50hSU97Xuq3EYTdeGqILyqHz9U06_MuFfNUARKHSSz5j_ncstmlSOR-uZ0
Message-ID: <CAH5Ym4iaBkFsAH6e9UgHbxOEs8D6-Tcq9so0HJ24GFfmnQiUiA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268873-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C1ADD2B591B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 8:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> ...

Hi Jakub,

> Please (ask your LLM to) read
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Thanks, I wasn't aware that this subsystem-specific documentation
existed. The reverse-xmas-tree rule also means I need to move the `int
budget` variable lower in the declarations.

> You can't submit fixes and next changes in one go.

ACK, I'll drop patch 3 for now and designate a v2 for `net`.

> Please have a critical look at the commit messages.
> They are very bloviated and not slop looking.

Thank you for saying my messages aren't slop. :) I'll try to dial back
the verbosity, though. What kind of bloviation do I have? Should I be
leaving off more context, or should I focus more on preserving the
same detail but using fewer words?

Cheers,
Sam

