Return-Path: <netdev+bounces-273499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LnTOcR7y2lPIQYAu9opvQ
	(envelope-from <netdev+bounces-273499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:46:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84300365705
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A9EC30406A1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C993AB265;
	Tue, 31 Mar 2026 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSlHoI1v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC43C3436
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942907; cv=pass; b=YpPhJPV7f2fW7CNEOF6uWEGs2226VNDWWoI8Djp1vm3D/DTp+FgWvz78DFkkWSVXueuYAqW6GNq5S4upSyDl1+dQbF8k+vPdwdN5wtk+IHHqtU0IYC4gKhcJrqU175a9SJIS5Tn2RUYD7u7q6FmqMV4gwU9s6ZLoiPzSH6+VSYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942907; c=relaxed/simple;
	bh=aWPwc0cTosgJmdbPXI037r01bH5DgAIXxmQX/wcosfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdLQKu8mO18zT/8DWQyPnNCCF1vWCF6X+0Y5JjF6/WT90Q2YqSBP344Y3G3PT+t6EjxbdTnQx1c9XlV9FXfpKi4O9N1szlo2mDFBWQkafoNA4hUtGsBvMpJeBulmKGiLWms7nissJBaozuZxakLXS7muKGUs8TYO3URVYUls/3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSlHoI1v; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38a23dd61c1so44506801fa.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774942905; cv=none;
        d=google.com; s=arc-20240605;
        b=KbGgLn485xp1ZuaYwCvNCxtqyDcoLHQVElG2ancT2rVm3LYHZxRRn9hLnaE2Aj8pyP
         Y9XwgWsXV7CDRdzJzYs2dsAQjCv6HF8gNmrDfRm9cxVJbYEZ2oSKvCAktLaK8L3nUFax
         Eu2stiOzBnJK0ehTtjzf0RSqeu4FJYu7QmotYosg3GoQj6RyfREHA9ae4Hz7YNdbY619
         +tn6eGPPm72JotOywVqygh9IIl70gJz4W6aA5swIZvNm6R8/4Q1RnKVqoD2ihuDJdFcC
         p49zK8L4bN1/LSI7VR0Jl5X15v7sZtylsGl67kDDudGvhakb2rNY+XcwMF6L0jz7913M
         4VIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KKZX1gxZy4jzOatrXwkZvEdUXieJsQW6+W95OcMVVlM=;
        fh=EeGS1bnM/DKqihJcfO387qjehLEAMRIDG5yIYVYW5fQ=;
        b=Pf3i0ixiatAfTkNpu/lYu26hjX/+tTmAtRbafe0Dn5QxYU4DtR8Cir5k72CH1WT+r7
         HBtrvXxbdUct0BZoJKNXjI9Be7WzK/k24xEj+W1SZCOhhxlHrqXoB9Hc1Cbkz16+mOSi
         F6WWTvyAoSGGfQFM9vTKFBf77pYPKiBfn0D+Pe+zjx3bEGi2vZ18LJ0+aMO37Q+5mlb/
         iVw9a6YoWmFaTbgxBqMG+SZdpf9y2/yEBqpbflF+MjtleQwrSdBnfmvHXhUWHUQnBqIE
         foimDihWgI033JLnfgO9MjgVOjLF8KAy5DtOhZyXsBorLaQk3Vqfg9Njj5+BFVAsHg3q
         +vPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774942905; x=1775547705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKZX1gxZy4jzOatrXwkZvEdUXieJsQW6+W95OcMVVlM=;
        b=SSlHoI1vIi2HVARd10GAqsYXtycM5rWwtFIa6r2o2OsYk58qqACn/CyLyMnNoDqJeU
         JxcNloUuMo4dN4wfWhopULnLy9AWIkxx0XF8Y9UhGDQ/OTYauV/95d970WlwL2yF4VnV
         +6IolfoUeGmOrt7DSpwF947Nuh51VC9V2RMeUc87vgm2Mqve/6xKcs8bj4EDR8EzpITw
         ERVTY3C7/5sexVGdEAU2wk+hppVlrCQL+uvxp9/Nt+/RLa6paL8xvaanYzABpaOmFhe8
         47jfMQldpNUvWLJ5wXNoX9m8iOXSjtriF2xSFUyN/A9Y78nmgKnKkCFRtSRXcblU0Z2w
         bToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942905; x=1775547705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KKZX1gxZy4jzOatrXwkZvEdUXieJsQW6+W95OcMVVlM=;
        b=cMuZRoPVueMLJVEot7nWrcu+caslREcxVwNhoZ46DdzpyAuJWvu2oarboieYlXtMs5
         LyNRoM5H+ZUG8b99JEOhxtrJllhJrU8yz7cFWKEsYcrZ+ILUZGyf00RmbWGP78C/qcMS
         Zj8FTXuDca9YMbksqF3zjulyI3oUcUbXwKA1MTdmFy+sY6BglNA584HOPljyCuya9bB3
         D1yK53j/oz+AAG7B/C/+ut9MXOo1IHp2lKwKbpH5DxwYJyNZ/1lawk1aPVlFR12UMzN3
         XXqFEI+N1qhD8CBYifjbQMoCfkvpd1fsGS/d5Otn0LHcmAKwhHXMSMtO8NHkgXZSb38m
         Y6vA==
X-Forwarded-Encrypted: i=1; AJvYcCUigOwGp4CdT/S3z59Ak2qbrKNGRb9etGbyPu2uBFKp1HJ6EDK9YyIDGiO5xSVf1qbuBQYkMZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8pk2U19I+8nx0uVIZ4LViYw101dCyhSnlDAmFgXmE7b55CYmr
	h5ylMm/49GvCO7poO3je1m7UFGAG4pYyqLDYjtEIoB8665orC5V6zQ6D2YPYRB3WXCbqw8p/nQZ
	BtMOQ/9b+WhdUbZMhWdHvjOCjzBBv7bA=
X-Gm-Gg: ATEYQzxis/z2HIgNYP7zUscQz8IMrPMjBMSkE8XCnFpO4jBikyJQlJVsTJMNxgITMVB
	WAILpgZa2DigZRLgpKmwWRiNhBrYCvECUKQJ0oUK9XbhY9Misdh6zP5iI+jNWZu6P1jRy/fNUpB
	fr0Nb45MUcNLPDrSY56ad5ZNW/t4j4DLXKPQIPRp1Lp0DLPcXYjYjoO0KlMxg9uDhr0XuGfFMmr
	PAkTimFdKhDUXbS4lffslF5sp+Qr1cpkLcdNe+pwtgESo+goTUh9EoTUL5gT89kX3qUcc3h306S
	niKunA==
X-Received: by 2002:a05:651c:324d:b0:38a:437a:516c with SMTP id
 38308e7fff4ca-38c73ff1327mr53062951fa.17.1774942904207; Tue, 31 Mar 2026
 00:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKvcANOzRwFk0jm4xBfMGVNJrgGhBT8zvb6r49qc=WdB5zP_fg@mail.gmail.com>
 <20260328185804.41325-1-xiaoguai0992@gmail.com> <20260330181541.5a3c9f73@kernel.org>
In-Reply-To: <20260330181541.5a3c9f73@kernel.org>
From: Kangzheng Gu <xiaoguai0992@gmail.com>
Date: Tue, 31 Mar 2026 15:41:28 +0800
X-Gm-Features: AQROBzBrXvn1mm06vDIzXBB3QWsVoi1e3Vq6PUpdCG8chWsRve8q_yAD7-HYpV0
Message-ID: <CAKvcANN1OEqXv9fo=cxTEEnq+=qs8NnZBrDTf=FTzdo9rHYJbQ@mail.gmail.com>
Subject: Re: [PATCH] net-shapers: free rollback entries using kfree_rcu
To: Jakub Kicinski <kuba@kernel.org>
Cc: gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, kees@kernel.org, p@1g4.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273499-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,kernel:email]
X-Rspamd-Queue-Id: 84300365705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B43=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=BA=8C 09:15=E5=86=99=E9=81=93=EF=BC=9A
> If dump can see NOT_VALID entries we have a bigger problem than a UAF
> don't you think? :/
I am not sure. My concern is whether the NOT_VALID can be exposed to
user by design.
I find that NOT_VALID is used in limited place.
A representative one is that net_shaper_nl_get_doit calling
net_shaper_lookup to check the NOT_VALID flag.
If it is a problem, maybe there are more paths that should be guarded
with NOT_VALID check.

I use the kfree_rcu since net_shaper_pre_insert has another failing
path like this:
    xa_lock(&hierarchy->shapers);
    prev =3D __xa_store(&hierarchy->shapers, index, cur, GFP_KERNEL);
    __xa_set_mark(&hierarchy->shapers, index, NET_SHAPER_NOT_VALID);
    xa_unlock(&hierarchy->shapers);
    if (xa_err(prev)) {
        NL_SET_ERR_MSG(extack, "Can't insert shaper into device store");
        kfree_rcu(cur, rcu);
        ret =3D xa_err(prev);
        goto free_id;
    }

Beside rollback, I also find another kfree(cur) in net_shaper_flush,
which I reported several weeks ago to security@kernel:
        <CAKvcANOZufuVeDqPAuMWh0GCiV5pGmmZHrRo_V+_8YSG7Cs_ag@mail.gmail.com=
>
It involves another free of shaper using kfree instead of kfree_rcu, I
think it is also a problem.
I noticed this patch
https://patchwork.kernel.org/project/netdevbpf/patch/20260309173450.538026-=
1-p@1g4.org/,
but it seems that there is no further progress on it.
Except in rollback and flush, all other frees of shaper uses
kfree_rcu, so I think that it maybe just the problem of free rather
than the flag.

Best Regards,
Kangzheng

