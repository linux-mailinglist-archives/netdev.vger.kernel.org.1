Return-Path: <netdev+bounces-278825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLjrILWs32mOXgAAu9opvQ
	(envelope-from <netdev+bounces-278825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:20:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06388405CFD
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14A9A30360B9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1D83D88EC;
	Wed, 15 Apr 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFRQHxuh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA933EAED
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266379; cv=pass; b=uj/GntvELhK9SCkiHPXQG2L2md9M2brE5LJy9ShSzbq92tSMD96ROvTwwEGy5lEK0A5ZUd5haDzUzlgp8kn3H8qTlIGZW5zr9UVbQEIwMXB6k5ZU3QUfGl845JSga61DPmoqxxSN9+88nvSbSM/spVV97QjN+zhf/ZhEcPGdqiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266379; c=relaxed/simple;
	bh=R35x7FeinH2LTmH0GOByVG4M38bJg/xLsvDfT8GEsJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s05GnXZYKVN+f0vrv8S9I2nppR3h85nADPAMbZ2IMSsWb5ilWcMhkMcxiQhWJ/Gqn2ICxw1yq+thaXJVxZbf9xFlje8ctMPe1/lhdMghkqnXDpRb3tl6bDHkR6CpkLGFxk4Ei1IeFiIE4EiLlDdrH0LaCvSqjrAVMTWtaY2Crts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFRQHxuh; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbb89ab229so5999543a34.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776266377; cv=none;
        d=google.com; s=arc-20240605;
        b=RUGgBKk5hF5QgJZHrkg6DUZ61gMRfkAecA632GTy3cuI1bmGa6het0xzs8lcsf3J4U
         726kVhkmZl8nDA3x9ci+S5TBY0XVvIfxYyClkcMYsp68LVtzWgAJcZd3xEdxuEiTzh4c
         8lD25l7IhEIYdUZHjXUbO9fFeFZ/Ir4TIs/pTsqMUM7lBUR70GSKKM1e4uIpkUeAgdeT
         5PIjTvrQXyIfpqg4k2AdoPyP76DtX7A3m3T3Tw69YAk4u54ZgXyegQGQx9cgVknuhCAt
         S46u87Llq08875d7IjAmjd/7Aho11U37kani+/uu50ViHAYOHZFrsc6E1alGcwEOwuUj
         nodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1VOuNwEfeozQq2kMUhcXYFUYg+uJ+za15jc5bP91H/o=;
        fh=dpu5Bm7uEYP+spzdil8Jj/npGPeODe8murPmXzTZNSY=;
        b=XvE5MnWEIkkfFfE8s1zfAWdCB3S+6lNBWuw3Nz6cXFSwhC0FyfEXaZ2dOwZcb7SyLC
         KPUG5uU7X3cOUw1S5MzZfJPOYGjtSc4MoMmEEV4Q1DtM+CxBwAB996OPYu/1koZSykgx
         BWbOS24Mutm8v37R1BbiLFpgN9FjWRZ51jC92Nv3be/QFGotdNqUTW7IljgbI04BBCoE
         GsYxdjWQ7bKMGmQKcR+npKBY50RepC4kSPAfGvkleVFVpvdHSoPsUQ9L7dC8CVRLYWOF
         xCUEk5pxjGL3wRQYB7Z25O0zwC6SKeQBUGroKQci2yuc9vVT1yh7ENmDGUjUlhDhN8Yg
         60/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266377; x=1776871177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VOuNwEfeozQq2kMUhcXYFUYg+uJ+za15jc5bP91H/o=;
        b=qFRQHxuh4+ctWi9DbmNYCPbSakY9Apnh9G2PupcDxXkQXRl+tJA2966KYHj0GcpE8M
         pG31wS83LMosq6KV5z0RKaSulG/NOGjG5ZYrfQwA7NZe0rm3giAPsygVPyfcnGNiQsKU
         cV/auqh1BXsj/d0HCIIAjxEB/cgkixDaC6mByDFoL+xOKkz5hGuBrgtVKq8f70jA2+4j
         nWEi3guSfqicPJPoO2FPRvewKWQ1OhYlSKOwBAzzMaSqAxU9uv+qU/1hMGFOxEM9HgQe
         39+d8iLtS4mwX6cofPS71CacQPezPM0/WZp75GGosv9PHNckzb+WVFhHSEI2bHhkpIb4
         XUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266377; x=1776871177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1VOuNwEfeozQq2kMUhcXYFUYg+uJ+za15jc5bP91H/o=;
        b=BjHoyjIYJaVjresRkUkBEKCPL7S+gub6O3StYDVPj9aIgc5ZyK6CzzpjpvodKdd/RQ
         cy+ataKSSCgS/koqvjvMlcFOOTtD6o25gZswRzITHFqJ/KOdtqJE7wxHoY6ZllEwg65/
         XMlzR3M0Q42ej326kWgJQjIR1G+VukfpNpwiW2axYU36lqZZ3ckap1fxtx3+xllwtGIW
         WmrC9QEBX7BB7l9PUHqZxaqbNXSzOEpJARQktBrzaZgImpFt3P/23Kr4ODLE7nfTu24b
         EwFJ/xHRgMmSQ1KODWIEmy7pLQDwyRBAiZ3v+ouC5izHCPtRkDj6bobDIWMUkhxbrVSu
         GfkA==
X-Forwarded-Encrypted: i=1; AFNElJ8O3AdErvhct8oKPzCocbi+gvzu4lwiJ8n55PlIHEefYMiSbVP7Gy+rknLc4GdG3kh5ekwtmfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlEKCfTEAzqaM2Oihpau1q6h3pF/4wWNPug9t3gvU9Q3q2MD5J
	r5EETU+7xmWSAzqyBu5td3geIZtolyw5kPqlsLPRMqnBXKZTLJ1faTzXde6DnUfm3fB5of/wcYX
	A1zEu4c/rlPkN2q6+Qw4Q08SiUH8zMWA=
X-Gm-Gg: AeBDieuoZKkXISpPFDAJhwGcinV6XtWRrBUrPRKhoT5Ft/vX9alXOzHAckrAE/EzBuR
	vxr9ll/xDBvS4scMOc6r4KbSHf9iODH+CY1LoCB+4wXLtCIo1q092lEMYGOWAlM8A7MLGVFSPR3
	5NU729WjwmCtL/dpxxDyW1YX8uwvrHm1fXQSWSfO+D7nN2qPx8puLVXFRn85GQKdYAlqJE0cBRn
	f87WAwQoFU7+gp6+3J3EuIkZsh8llZwtZo4VdyhaJhPdztPvhqyvN/FkNHCcp1y40KkPwkbi6QG
	ZpF0NUvgDpJHqcqQG812WsYQm4ASLtTq0zOt1Y2H/zt0QxwIA/I5u4MSs9GLQub5E4XL6/Gk6zw
	RZw==
X-Received: by 2002:a05:6820:98a:b0:68c:a53c:8ff1 with SMTP id
 006d021491bc7-68ca54bd3eamr11009276eaf.11.1776266377081; Wed, 15 Apr 2026
 08:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
 <CABBYNZJAEqwfTuVqbFAnx97HBSjcwn3Hb+y+r4r2C=MMPxFoDg@mail.gmail.com> <CAMT+MTQ6orj5tpiGL9hz8m2TGiBjA-9D_0e1iLt=_dXBFHcOgg@mail.gmail.com>
In-Reply-To: <CAMT+MTQ6orj5tpiGL9hz8m2TGiBjA-9D_0e1iLt=_dXBFHcOgg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 Apr 2026 11:19:24 -0400
X-Gm-Features: AQROBzDwk1p0rJ7IlG2lPh_IuUkTifTHO7F9HnsebEPzRDlTsV8TRziiZbRGV7g
Message-ID: <CABBYNZLNR8hYS9jLLKeB=M9XVvtSFtf1wi4DmcJKBbQVvHTPaw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add Broadcom channel priority commands
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278825-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06388405CFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sasha,

On Wed, Apr 15, 2026 at 8:34=E2=80=AFAM Sasha Finkelstein <fnkl.kernel@gmai=
l.com> wrote:
>
> On Tue, 14 Apr 2026 at 16:00, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > > +       if (sock)
> > > +               set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
> >
> > This is more complicated than it needs to be. I'd just add a new
> > callback, `hdev->set_priority(handle, skb->priority)`, so the driver
> > is called whenever it needs to elevate a connection's priority, that
> > said there could be cases where a connection needs its priority set
> > momentarily to transmit A2DP, followed by OBEX packets that are best
> > effort. Therefore, `hci_conn` will probably need to track the priority
> > so it can detect when it needs changing on a per skb basis.
>
> I have tested per-skb priorities, and unfortunately, this does not work.
> If something tries to send a low-priority packet (for example - a volume
> adjustment), a priority drop causes the same kind of dropout that is
> caused by scans. It appears that the only way to make this hardware work
> is to set the entire hci connection as high priority for as long as it
> is being used to transmit audio.

Ok, then maybe we should decrease the priority, so it can only go up.
That said, in a multiple connection scenario, we cannot really tell
what should be prioritized if we cannot momentarily decrease the
priority.

--=20
Luiz Augusto von Dentz

