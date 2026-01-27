Return-Path: <netdev+bounces-253680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBTvMRMxeGk2owEAu9opvQ
	(envelope-from <netdev+bounces-253680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:29:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1A88F985
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38BAE3024285
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE228C5AA;
	Tue, 27 Jan 2026 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcsrgDV/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2E24A06D
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484560; cv=pass; b=fr5BUpAoQ8jMigHM8c8rkLMglv3u1Bv0BL6bfVdJv+gIp+CpOQ3qprPg2J7bK7n9gjL88qrUSOk/PQtKMhwBjHwI2veqkzuseCwsRNrY7G6uv7HrEZ4GQPpg1rXLo3hc2hkUSuCQOmB2a5/BkFbldhZ0NhOIsdZHda+fGHUhiHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484560; c=relaxed/simple;
	bh=3AwfbwxqdIWMq1Ao4NZ+UJBYSnLoxLt6dmwjoC7/7Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBZ9pWtS9cVGS6YX9hHPtNkFt8j8SEb6Tx3v9C/sCIxXVk+iFm6uFGXMJg1WgdbNlLQSDCG6LMtBfvUCNXOjpz0L6V+VVwNgs63QBtVBl8b+p9pTp+yTc6jrxeKn7hDHSDF3KX1/wR1c30ltUyaKomKZ2t8+53FBf+fTgNaTv20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcsrgDV/; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1233b953bebso13032102c88.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:29:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769484558; cv=none;
        d=google.com; s=arc-20240605;
        b=Kx8Z9DfO+5wJN9PDPm4Q5JVlmaWlslekDIHjfa2AIBtqmgD3cfc2gQ2FlbWu+7z8XA
         ufmZiRxswQQHinWLlyjdJpb+UyDE1xho3rTFPn49DqKrsylNEx/B8kQZSKzo2G1mn+rT
         ePI5fMM6jhLsaNbVDJH1jjJjDqVRvZRnSI9UD0UgZ8+lKPx5r5p7vUDzeO+Ng2am/aJE
         L+NwRD4M78tiJdkvzEsddEiYlEXPeabu1a/o/br3Zw4x6NZhVQJd0hSlQBE2tzVCsYfZ
         HXv09jYW8/N41zjWkMJY6WP9QJJnr+FwNj1O/wEJTIKIlGGvPOFjagoIPfnb/WEEbDDQ
         fUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x/dYrP8DM1TbTA5hkcHpEiQ3QTn4BHv9cezjphPhYgU=;
        fh=S3KCHk7vT5IE77+pwa1PkskmGpaMhZj8e6kGLdXtktA=;
        b=WJJxcKvlPQGW8UtY/eQXyMqgOHBXy8sHyVw5MObSicILizh0JWsFTRuwZ29z6BaJ9m
         N3UhzXKBkUniFrkz5Ei02VqqPF1XBFqkh9t4f50DjWl3GUVUNnA2H10x6143vwr01YCb
         dwjEMINSmkS4u4vPcRQZdzpjeYZ7u5XLry1LC+Og2hGDDwT9rH3In57jfCIFwKZ3OKYT
         0gHyrS0Y2HQ+Irs6+xBKF2kvWLI/cXGKPoPKcFRvmSTyGT9U4F1sCG94ZjnPOmw64NXD
         ZhoaA5OR76VLA3ygqK/0CZIiAKxpAarGlXALTdgLaWt47d9QdijxTBnTmnznqyL5EOqw
         0DUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769484558; x=1770089358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/dYrP8DM1TbTA5hkcHpEiQ3QTn4BHv9cezjphPhYgU=;
        b=wcsrgDV/fixmHMUgYwg6DK42aBQfZd2BnoHRcQCZvvM+x/TLu7aI6GYAt5ktFqCshA
         l8w2SGkK6YO1zbBzCalGlKszLDGJz8P4SH93uFFHu5UOwivBYjCJkKZ4pWR+B2iUhf4C
         qwq3eyZGa9YTz+TmSPY/s1oVaYhEc1iVMs3dvRgvNiRLAQXHf7PMd0uzs3TscvNhhQ8x
         MZ7/zJJMYxeN+AW5BqgZG72Fj7teQ7T/R2It00UxS02ZFFHGpz4bSGt4nqWimpiYuO8O
         73pdQETuow4O0WhdoK+QWcwwY8+N8Ngs2j9sNhEqEQ3fCgRo+fZlP/GVvNbvKGJqCSTr
         OfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484558; x=1770089358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x/dYrP8DM1TbTA5hkcHpEiQ3QTn4BHv9cezjphPhYgU=;
        b=YIkXvkP1SQaCAkyTiVdWi2cfDZ1TCT3Np9c2AHVaAsm29pjFnHG0T+yEeJjsQHU4Mc
         CqAWrgfGQPv9oSXFIsAv2PtNDqeXmBPFsZn/+6mcRcxwR39u4agC8F//RkwH8m4PAC+s
         aUo/82xdzyg1l4+DfGyGtsU4GqHoqE2aRGRwDcfGD8mULCn2mmurgdJBknkGFnAZI6gm
         r5sOpKkmosV4xg2egsYUNU+issAdvsagxbwJIuFOBkS1TyqQmVsoSUbHPsv2elwxr02h
         fNx2TpAHCXeyHvHdc1ovUq/0UjX7IF+PzxykjG93p6y4vANYn1HwLL829NDT+NI7W74Z
         GAWg==
X-Forwarded-Encrypted: i=1; AJvYcCUpG4JeCZcGr4+zXuOiMSFU3h1S9Zx9+bbFyPdX4guh4oF9pXwccDxaii9xte1waD90PWKpr0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMexalQGYP9wIQUwGWZ1NKJsqw4EUKZ/F7N+SKmmjSN8XNCI5v
	IMv2+GSdfRzYQuJfnf364KzQm6g6wf0pPObRki+0pA+TIdfPazAUyz50icQNyTJdZGzi4/Y8n1r
	PGstg5s6s/SLEgn1ZsUaySyd058NPwxnwtrIBljah
X-Gm-Gg: AZuq6aIMR13TCGPGDpZ+NTEZ2Mkg4J5JdTD4kO1etZ9mtyrdtjApbQGlq7iTvIaLcSb
	7IjMTHd378x2GEssuoCmzRdwOdfr74gpejQMFa3OAhs9ro7jHTqL0VBOyYhm6YiC84jzjT3En61
	btTDPTMV9BRwE8xGHlhR4hrnPoUJgcDG+87tay0Ro/4usK8obw25FXeM7inopKj3S/8GMo0iSI5
	44g6y6GbQDZ/d7vSVpSY9rQL5EDdag5fCS5AaFoLKzBqitaHzr3cYCuVziN0Y05LjWzHnj2a1Jr
	3cn8NzEosMnMKsK+u3WsLw4bWEQr5e4H645JHP6A3IPXxSGuYOYBJNEMmwu2
X-Received: by 2002:a05:7022:b90:b0:124:9dea:188d with SMTP id
 a92af1059eb24-124a00c6e90mr217257c88.30.1769484557601; Mon, 26 Jan 2026
 19:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127032147.3498272-1-edumazet@google.com> <20260127032147.3498272-4-edumazet@google.com>
In-Reply-To: <20260127032147.3498272-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 26 Jan 2026 19:29:06 -0800
X-Gm-Features: AZwV_QiQ4-GCg5vWjYXM2t3McgbYmumOagGIedVAovO-xkS8xZa-4VS2DfxFhnU
Message-ID: <CAAVpQUCT8BeAU60JnOsP4bp6hBhxYcNZPmCgaq-zAreePsvNGQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: move tcp_rack_advance() to tcp_input.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253680-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F1A88F985
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 7:21=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_rack_advance() is called from tcp_ack() and tcp_sacktag_one().
>
> Moving it to tcp_input.c allows the compiler to inline it and save
> both space and cpu cycles in TCP fast path.
>
> $ scripts/bloat-o-meter -t vmlinux.1 vmlinux.2
> add/remove: 0/2 grow/shrink: 1/1 up/down: 98/-132 (-34)
> Function                                     old     new   delta
> tcp_ack                                     5741    5839     +98
> tcp_sacktag_one                              407     395     -12
> __pfx_tcp_rack_advance                        16       -     -16
> tcp_rack_advance                             104       -    -104
> Total: Before=3D22572680, After=3D22572646, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

