Return-Path: <netdev+bounces-286366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKdlLlTJAGrLMgEAu9opvQ
	(envelope-from <netdev+bounces-286366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:07:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D505058C0
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D21E30022DF
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441652F5A06;
	Sun, 10 May 2026 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="xd2nxrE2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78CC2D5925
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778436434; cv=pass; b=JgrQpQdy8pKypVJ25hhIyNgfY8N3gFb6XXkRpeB18kZzlAkT5cipqyDxjz/KSS30VKSmQrk6aYsK+aZbouCEVpKwGxIICOJ2oahgUlEGFGfu+ddsYJ/1CDRdr9fbpC6N7SnIt/CdhtN46z5UkYljj2tsrL2ZNed4nz5SMQ5MLyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778436434; c=relaxed/simple;
	bh=B/9PkITJMR854+53j7XQJ2o4B0fxddCNlnNjJN0jwA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hz7SKUEk7SyFgXaotuw0LlwP+30W9ip5zgb4ZpUhUhKAsM7yRWsfctspPvkaEY9BxNKntJuRWYQwldxwlr5MME87Wg6FarRWE1YS4M8o+Fuq+DZHH2FszQTJHYMCtpIz+VV5+5+lviKBvBtkbvdQaYh4MMEClM0HtYc+9bXZi5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=xd2nxrE2; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8c94cefcdso241439e87.0
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 11:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778436431; cv=none;
        d=google.com; s=arc-20240605;
        b=Rc28C7MwydfFB4hcYXrocXGH37oHm+eTCVQrQmDLyaqyUxKk3z2eK5vsfiuA3+M+/1
         F/nqR3t6KMp5YOukEuPSKdPyqtQnCJ2Pgux3Vrd4S+4Zijbm1sy9ZmlF3xiF0ObBWItM
         8sFtFHTwHv8lhTcWAfbZ6MYreEdlm/yecNCO9jjUBjhrq2xJGdERJUq6lDdjOfDQjpA3
         /QwNliKhSf4AVI3V7XpEhQ9y1IFyVClGNZiZVHw7iAfxtXjzMiz9CyeNR/FHETZA1wfM
         xH0eFUUHrIIfGCPLmZ4/Hp5rqy1b5l/CzgCvXNjOtGfDECDF6F+pVZPqpz1NuaHnrChT
         sF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mPI9RtUtwfMsUB1RLcg9XhbB2p1KI0Jg9PNs9S7CB20=;
        fh=z/LIbfWiQd2f4b1bYfQSlhxTIFBEcwLelXESfNJmz/c=;
        b=BYUwlxLGy9NUMN3lkjirV4G3oJLqEcgT/3wf0tfCQRsVkd/OUfsulcOC/B/M/IYqkd
         mBPFQH7rYZLWzm0Ta1PTQQHnOvDZkvJCJkJVfBO5bycSNUDwF6tnr16hjYCpIGeM3+nS
         mYLsXOrKiot517NyUP2gCkOT3YUcDvzl5jHAj8f7uYyQv9kSeVhCVS8cuoPi2XXFw+Vz
         G+/aBNU2lOzApAqbJUe12SXs77p1Kiq3b8s88OGquRlHWygwAX5jtqZhedH5kK2NV6S9
         UTictteky8xN26TMVChDIqr9agCJ+ycMTga5kfNPhQLl4+wchS0PkPwd+kE8j8EkYv1P
         mhyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1778436431; x=1779041231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPI9RtUtwfMsUB1RLcg9XhbB2p1KI0Jg9PNs9S7CB20=;
        b=xd2nxrE2rwAT9XPROHji45Y7YpK9Lj8wqqYVwjTqgaMJz/T1a0pi3r14co3QbcC+DB
         1/4Y3nhJBc0pDjz4bJ5G0wRQXnFdGh+e1UV32hu9+18QbspbZI9ZtapjgRmcIkYmN8/A
         s5i2sZWZaL/7qTGe3cYymFLJtdPu27BfAb9pRJ/kW1s6bvKOSKkPnyd2ENQyI/E2Uxos
         Kb5P+sJVgC8pCMhXtMlV3JppbqSy+KqJa5FFCmFTcYHk9ic8b4HcwLQRQ4JPzTHCVfbx
         i+GCaAWpzUEjVYQU5DwBa3Lb8upX9MEia51MmdOlPKXUUobvN8LcCMrj957XJu6cRCp8
         TXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778436431; x=1779041231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mPI9RtUtwfMsUB1RLcg9XhbB2p1KI0Jg9PNs9S7CB20=;
        b=OCL04IqQv4ACRvn4qBuTXgPYyoCVsaesuLmyhcum8SmZ7Zb29u+7gqCRDay96vHIjX
         dwR8zsSNtkgBLQu4kUGOqdUjrZ2xWsuI+xuBCiNaOPbP7dyCIBUYBVzGkb3Ys5uHbBkW
         nb4aFdyj1vjP+BwpykfuOxiSlKRPX6afutGzYLV9t3ePITT74mqYRFz9K/5NEXYPMkqH
         k20bgIa3Z0UMeNvP9n58/nfz8Gqymm3oXWPqQX131oFablA73mLzx0yPIrU030zA/B/N
         UEvtqCkHDGGv1V2RrCVje0rAPiWEdIvnaEpE1OSSnVHYQuDvpkdInw1vnuypt+e285Ye
         9mqg==
X-Forwarded-Encrypted: i=1; AFNElJ9JsM2UH1rtVZCXN3URj09uVzLq5eNgshM2R1HVf+FqR2wNhxyCnEsf2sI8b+O0ZD8dy67AbKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEAdQNk8nynpAnxkNpisSJhbtHDa4G9ivdpr0n/UMC2QrRDAu+
	b8aqpzp+H0CgoN8X+rnZa7YPE/u8tHC0J7/74YUub4lV3pmc405+gZKS0/YuhTQ/IArw24Tp4yI
	PXDdTm4h8hRK5yi/7ZGplANfpJuf/i+DtisqD7qGG
X-Gm-Gg: Acq92OGiz0aHTKNtvnhDmq3N8E+5Xgiml3VgZIzjHw9Ag1QaIKCGlB+ou2/j4ENGfOO
	6bm2JE0m43/DNel4idcKpzW9Kplql2k3osBlJ/gFrdURugR3sGTrPBPEc8e/rcnFZ69JACo6aKk
	Rzede0FUBqA1oXU6VAbewb7p/K+PD6nt9rz/FCLp70uuWNjC+t7PTuh9ZoR4nyG7hrY/42TtAgJ
	9Ee2mP0D4wo0uGvC9SUkg437lhoLiXcVlyZRBzKeN5VW1V3qUMPmjctSKZobylpHyCryKzNiWq2
	BvxLwB4z7Ob6tSc=
X-Received: by 2002:a05:6512:3e14:b0:5a7:4699:d851 with SMTP id
 2adb3069b0e04-5a8b6c9c530mr1787120e87.7.1778436430400; Sun, 10 May 2026
 11:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
 <14A441D8-5370-44BE-8732-99BF8107C3FD@getmailspring.com> <0b8bba44-f6bb-4d69-b9d4-5787c276d41a@inspirated.com>
 <20260510163204.GA2279@sol>
In-Reply-To: <20260510163204.GA2279@sol>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 10 May 2026 11:06:57 -0700
X-Gm-Features: AVHnY4Ksn57e9ZSnowz7i8VDuqmEeyTqf3rUkaTOYFnl29-9oyrpMeTvEmcHBgg
Message-ID: <CALCETrVLsFyo71Jk7pZ+VDSR+cX-tu_mD+RdpDe-q1sVw4wisg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Kamran Khan <kz@inspirated.com>, Jeff Barnes <jeffbarnes@linux.microsoft.com>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 40D505058C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[amacapital.net];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-286366-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,amacapital-net.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 9:33=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:

> In any case, any hypothetical security benefit provided by AF_ALG would
> have to be *very high* to outweigh the continuous stream of
> vulnerabilities in it.  I understand that people using AF_ALG might not
> be familiar with that continuous stream of vulnerabilities, but it would
> be worth spending some time researching what has been going on.


It would not be completely crazy to have a simple, straightforward
interface by which user code could ask the kernel to do a
cryptographic operation.  Think:

int compute_keyed_hash(int key_fd, const void *data, size_t len);

where key_fd encodes both the key and the hash type (HMAC-SHA256 or
whatever), and there is a very, very small menu of hashes to choose
from.

But this is not really obviously worth the hassle.  And AF_ALG is
definitely not the right interface.

