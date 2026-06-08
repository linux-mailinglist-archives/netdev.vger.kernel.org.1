Return-Path: <netdev+bounces-296677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GQBqHTsFJ2qVqAIAu9opvQ
	(envelope-from <netdev+bounces-296677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:08:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4236598DB
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:08:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tfpKBrEY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296677-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296677-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ACF13183DDE
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D9E3D8107;
	Mon,  8 Jun 2026 17:28:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EAC3D3321
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:28:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939705; cv=pass; b=Bc3SQ/VTldiEfPn5WNpgrytdgXWjBLiysehUwc+qoM6TsqNYhTAwhVxoasZU5wubta1Lah38plnZ3wreacs0VX3ObcabIsNQO2VZ0ZUmEGTKtv4uG90DtWan+r+u1hP4hQZE5cdH7Hu6+vzVuVNWhOze8E2GzmnSnEKlIbzvao0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939705; c=relaxed/simple;
	bh=u5SPsoYjBRcn7coHWeZLtR64Od3+HiU1H9t9TpVkdeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASKnk5gtPYNVxxl3DqqTTMIJ9shvmd2kVOAlct9L3GDZEyxh0fBLdRgRfb56OQi+2aGY4Def6158JdVRw840oaaz0qChliAnp7pE21UEVo4R5Wu7B7Om24TZ5Zf/nMiNNQAA5QmIitMLtLsmeUOnAy6FgCdBcUEhYdWGsKttqw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfpKBrEY; arc=pass smtp.client-ip=74.125.82.44
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13809ed8fbeso617914c88.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 10:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780939703; cv=none;
        d=google.com; s=arc-20240605;
        b=BQQ9o9iUf9FNamFxM+q0znTxO6hp8fykRo9SGG4s8R11iDyjRE5K9P+aXVV2xJyQaf
         BaYjVsBz6DV5FyocZENu0jYUs62xHwa+r9eSNEpfukT3LBiiQdH0joSllDwpaE4dmQtV
         LuLE5pSGBcUOwV+2icsd/SqJa8V0oz9+3hqo8z/YMnpqqEajK/HdLDIy2U5YH4nq8x5R
         DBp8HOilKKzncnrMRT2BYoJPwhpI2QIeAU1mjN5ItZItC1NuKu9s6sxyQvb7igxW+7QC
         2UBSZIhsSvwm9wwtfk4OR+Hn6k6i5zjZnefM71c6bOtMs+PVYcAB5c3upOkuKzhNw6ES
         1s7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u5SPsoYjBRcn7coHWeZLtR64Od3+HiU1H9t9TpVkdeo=;
        fh=9XpwS0TWuI2JcY5WrvXpNUU2pAHEREBhjmuWTOFz7K8=;
        b=h1MZ3Mb87z/XQJG/sNSRQZj9RwjMliFoqTu/y9gu9XnPAQOYqEKKjz7juaNSfEBDGm
         pdhPhLomnws1eTX4ezswcW1N7BNh59bwmsMXGL+dyigctr1XZ1xKNnrkrDMDmqnpy0yS
         SYSWBREBLG/TrZ926/zTaLXz5VlTtf1Pr5IvGbp0kAGtztExj1Qx47xSDd1lvoh43Ep3
         Re9AQgZE6tz1V65hl7Gq5KOqwk09d96TuEU+GafQWw9rZQdzDSlROJh8rB4Faqv/dV4h
         RfLwVDI09Mq6PKgCSilQGbLgtqdMDCGLbsHoLXPNhme6yMX3RKJnxRy0SCsB1OGaH5uR
         BcsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780939703; x=1781544503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5SPsoYjBRcn7coHWeZLtR64Od3+HiU1H9t9TpVkdeo=;
        b=tfpKBrEYeNv1oRXxvhuDS+jjxVBFYskQmYttPUE941Cd+Bnz0qSFavL0qRGUPJBEmZ
         1ohiYUxPlaA+Ew4Xx5zxyDv8V4a7WAqPtPiNQO2eDknYr2+rfxcm/hXv6PAqhzxeZ3pM
         ZrgI2XQawPXwTxYpMDq+pFw+WVjlYGYE66X11spJlZfHgKumv4yuew5QLqqCs0xtqAR+
         ufP5hq7fO/YaQHJ1pY5fT9gfo7omhZJgLS2frHW2SHMszFTyUPMLuSkDJoNaR6h3sulo
         UQvtkKOoalXuHdWXmNcHxFBzPRAzInSg4cJYiHbrPDYVIeUOisLpiK8HFk79lDWMU9kv
         jObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939703; x=1781544503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u5SPsoYjBRcn7coHWeZLtR64Od3+HiU1H9t9TpVkdeo=;
        b=Ldh9+KDGA/P14Ck+M8fc+N8alM8Q9utuB2ypEkyHscYkjgYJv0f6uXM94WD0X+8FcG
         RbaUGnSVoaawaPCFyRhft5r+p5G08e5xfPPOWqgxoiKoG0H2LBaFpg/TeQc8JWzaKOzp
         EKfT2OmhdahiY9i8eRz512lPFCgTCY/r8JeuI0/lcTls3E5M7AQbPXiX5G1vwcon0eth
         6zRLYJkWU3tKF4DaeCP2Tw72O/oxYOMtqAn6Jm+7nj4Z/7Hsns8Le3IgyQcnD1Ma54FI
         lzL3KTk6BTkibX+b1tEyeBCVG2Mo4CC1gMF1sJWf7LIek1uX8Dgrk+8rN2mceGijHZ82
         JpVA==
X-Forwarded-Encrypted: i=1; AFNElJ/+lWhjTxNYz9VENkXSp6b1dWEVRSnmF07t5nwz7NETLr/K23ZPE6A+7K417IQ7YWDge65P/gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfrayCH8SLdXluYdmotfD4hrEkv0LPfSKGDtBERNAQeAmkHbN
	CRjeL0jb1pHjmpksEX0EGJh7BnbHx1j+KeczsIG2EISXB4mu4i9pzIAeVyFYgKi8uG3nXxdI0zz
	ZGHrW1mAJsedicEl4nHv5QlyPvBkgemf1iVnQAjtW
X-Gm-Gg: Acq92OERHPO/k4YvHq8MAW43nyLoTmcDpdLnBUfcBrD8tNH/lhfYHcLzfmjX5t9NNiL
	lX056YQKQUdwegpbpgZd5kPTplusHuB6Tnalfx2zfWKnlFoYMmb8Xwh3LYv+y9eLZnsjpZOq3t6
	Ssjti2ff3s30hi1W0JdVeUTxQL+iwius3K0yxcQcRSsoxFUqJKrxQVWKkAaM59jDWX5GKgdGeRj
	kq1Dj8l7ZM4aG6aUtQ+a4YZ24l9sPjMZQ92tflyMG1ls/ZJt0gUv7rRsSQb/UiuX9AErBGbKeZK
	Z53IhgYUn854luZ/KW2o8WBhs8uzzhce7zNW+M3M3IEtwNPnwWYewMVfS5x3vs8UC1KJQ+iIWJM
	VounYbEgFboQahIOvSrgdqKselzb+YfsFRIYmGS6UPqhcWuGH6ocgzz40DPhJoE9aM16I8R0=
X-Received: by 2002:a05:7022:204:b0:137:ee9a:2ad1 with SMTP id
 a92af1059eb24-138067331cemr8944769c88.35.1780939702051; Mon, 08 Jun 2026
 10:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608151452.706822-1-edumazet@google.com>
In-Reply-To: <20260608151452.706822-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Jun 2026 10:28:11 -0700
X-Gm-Features: AVVi8CcCNYxfjWjdtKudRp4hiMRNLCQ7wqutznyB_eu8iY1YPlIe5NwOX-KQyOQ
Message-ID: <CAAVpQUAFdtd3rnoUsxJCns-LYca3hwqjCmhoHnykdjmkiJ17sg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: refine tcp_sequence() for the FIN exception
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Simon Baatz <gmbnomis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296677-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:gmbnomis@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA4236598DB

On Mon, Jun 8, 2026 at 8:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Commit 0e24d17bd966 ("tcp: implement RFC 7323 window retraction
> receiver requirements") removed the special FIN case that
> was added in commit 1e3bb184e941 ("tcp: re-enable acceptance of
> FIN packets when RWIN is 0").
>
> If a peer sends a segment containing data and a FIN flag before
> it learns about our window retraction and has a buggy TCP stack,
> it might place the FIN one byte beyond what it thinks is the
> right edge of the window (i.e., max_window_edge + 1).
>
> The data portion (end_seq - th->fin) will end exactly at max_window_edge.
> In this case, we will drop the packet if our receive queue is not empty,
> even though the data was sent within the window we previously allowed.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

