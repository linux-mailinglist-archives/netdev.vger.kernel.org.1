Return-Path: <netdev+bounces-286005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKadKzRg/mnCpwAAu9opvQ
	(envelope-from <netdev+bounces-286005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:14:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DAD4FC3A6
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0CAB300B1F0
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EC13815EF;
	Fri,  8 May 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzyd+0O2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13C3876BF
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278426; cv=pass; b=G+Z5suSJVaygcq8rQ7MPw9y1rCD2+0IBPUAkrKnx9ZzzIK7mi/mgb2FreaKSweVJncGnijlnSSSMYNZj53IZC82mra0i3P8CCyy3LKHb7I+TNqhzaW/lkRih0CpfjiU4merso59CQpFg+ZcRRPjebnerC+kJwIiu6w4sHOWd3D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278426; c=relaxed/simple;
	bh=DQmgnfcnRr6713xlyyH+//k6KmRLZaPYa60KA1lLt7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+pXv5fY9jbjefR2GvTDSMAeyyWTzQqK0x/k7nWRe4aKfOlwdkyzjm0btBoAJOR04JhZSAh/UKVwjBK+lNVTpu1a9SkjhOmkpoJOn+JL/68rz8au9brrijUkNHosTXDm2vn4QiA5usmFbuKT8mWr1xG8zqZvbMONbigYH3CCjB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzyd+0O2; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c8ccc7755so3918397c88.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 15:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778278410; cv=none;
        d=google.com; s=arc-20240605;
        b=XtX3Vgj5xMQNB0TKpTWDKKS54Eok8ropu32TI6dxvRfYCoAVp4qHsIGAOQUU1PCJ3F
         +18we/u+U61uHCnttb31wu1MkHuKvnpCQyYLgSqo5LD07+nQUflA+9yjLJ1YMpc1fE8t
         jXQPsZwJB3Eh8trvYZhfE9APutlW6fx8K/B9Jm7wLggROH8a6gjItracz1DskHpBdFVU
         hj2I5VCt97pHY66jI3JAuDsZoNkY7yeoGaZtR0Hyy70+e1/8Qa6+lXsXYQhdCJA8H6Ks
         alJ83woBfjhNE9eX0ZOWhJMPAa73oSqwEbivZHiSGTp9qaRS9gqb1P+poK2LLzgyyHt5
         HvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsvMB0ViayQVeQbXLRMaEKqgrrABVFKldkXlrfhVTQY=;
        fh=yvK5tEiyr0nSiuAw/2T5lmsf+6BSml5JpfGcKMS3wZM=;
        b=SyYzxFm7dJwvcYL+RPh3/F+I6PCZ/x7p7OWCspWFN8ARAlSrMt0/Pdj2UtKAjJO+4G
         BBs3nJXUbf2UHqyS2eeaZozZ1qn7IDeiwl8qMfaDYByLjX3NB0W4mHPZpUcz7Aw0wAtL
         +WYo5M7Zv32hNrM4MJCF0lPpYt/9b8VQJX3fE1QWl0KZ7+EXHM169rK0g1fr5UXT/hjI
         gX5zQ5tRtNClY8cuelLA5OivKKmmtwIDo3KgO2kerORPaGTwS7Op5k+ej8K4DCWhgZSw
         W6P66DOtOfhtYa4tyBfIco/jqRhfWborFstFMAeMMmkdIogBZve1pfoL9ku6RKNFdUWD
         LaQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778278410; x=1778883210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsvMB0ViayQVeQbXLRMaEKqgrrABVFKldkXlrfhVTQY=;
        b=pzyd+0O2qN+6WnfOyUD2tKRiFWusnRg+Si+mJ7GsGG7VuqW0PsTVrVd9gnZfILmXVD
         U//zSkGFTcbUOmLS4kGphasYLMD7iH71c+t8cgQJgSmvYdvlLZNc6lbzr5nQZXoB+e0M
         f1cwW0DXvYeGXt9WYvAefK+XIbVdUAR7MfTEL9viPogpuCt6LcFMNBM2BUnB1J5ZiZFT
         yxdmyFW5JBjBtr083wuVVAs2wpC5PRl6jA9me/lS7u7ZxCzVvzPEDTwaBsa1iykQ58s2
         Lkh1JgGX3HLk+OlyQzvDF037aj6IZ4SK7dojvu4LmU1sFH/bAzAcqtuQ/h0rGekRY+xJ
         01Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778278410; x=1778883210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rsvMB0ViayQVeQbXLRMaEKqgrrABVFKldkXlrfhVTQY=;
        b=A8V6x+hY0y2E3WqXQv2pEhN4IbVwCAoBefjOGLLOpMESNhg2TcSEdGt5kVsxYL89rr
         QcpBR/LeiGIkyHpyc/hVRRX/WknvqBCvmtfzhWNE3lEHNj5NqzAnLBjCrgEYF+CnlH+J
         +ajQg/XrvgltaYhXN13PgZGzUNTbwqRlHZaZF0eHy2JsL5vlFnCUZ+4Ff9rD9s2HxgLe
         DPsp5yXcwFQ3g06SyOfTqs40CZVwEUkYANda10W+TxzSKRUEqovtVAh0+eHIAfsIuthl
         1jSOFN/Y650gQNcxkf0kutj72hRJIfPITUrK44TumrYgdkAfcjgq2U4rm8gM6e4av+5d
         KB7A==
X-Forwarded-Encrypted: i=1; AFNElJ/pXgVWbhZ6qNUs3ydBUdSk7cteplNYuYApDBHqtU3P39IejV1+IXaXVlthHK9uCB3rDLyCOiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB9tJFFx1egTAeSsk0m/hwaKxrNPATWPHZENMe+Z//64Jxop3Z
	YZoxQWVtRS+Ga6HJXS4mvyXKH7kMW4KeSBfrVhAYMzhRVHhGL6J7a/CU6akTjbxCtZG4WESqFDW
	hsUbiemTDMQhRaCZOXgO0lwvpqUdilOfvKchA3msT
X-Gm-Gg: AeBDiesqWr9us7vn2jpXq5KyxURRjNbOUtY3VnOMmchgFIzpietdZgZ/mxaqUMRaVcE
	4T64eMcfHKO9ZvHUrOZw/d1CMAmobXOkGedcdZ56WcIN600jRqsKW06pbXbL+0y+Hkg8s3j0mO9
	vIaN83i1UpjTV19hbgTW1/tcrMtubHS//xqKKj+cy1iQvZ8UUKOt2Le1ISWcPEgXYwFnIb4iILP
	GHCLc2a6OdkEU78xij+RpQpbCbwAuFZKRYkQJ6wKmys9BFHSSI57ZmxuuDB8m6mlKW6gdw1IgxF
	MVIkwQLKIMnlGeDYvg3q/VRGevwU/vTcwg2c32RAJttpKN09L5D5r3QEIK7ESJYKMLA1wWdRf6h
	8Jk3A7xVsC+qmnHPCnGldEyUmOxfUBew=
X-Received: by 2002:a05:7022:222:b0:132:1e79:9c55 with SMTP id
 a92af1059eb24-132a84f8b05mr101966c88.31.1778278409825; Fri, 08 May 2026
 15:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426012647.3233119-1-kuniyu@google.com> <20265820377.lHsx.martin.lau@linux.dev>
In-Reply-To: <20265820377.lHsx.martin.lau@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 15:13:18 -0700
X-Gm-Features: AVHnY4JtknxiTmGENEzK09cXcPW9GZY-vVSlIaZcmjsXBnCCd7g7z9k70NZAobc
Message-ID: <CAAVpQUAHXWbbdn4v0xmn5MjAra8AKT8BZ3OYCTqhfZT9YmQHJg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: Free reuseport cBPF prog after RCU grace period.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Eulgyu Kim <eulgyukim@snu.ac.kr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 52DAD4FC3A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,vger.kernel.org,snu.ac.kr];
	TAGGED_FROM(0.00)[bounces-286005-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 1:42=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On Sun, Apr 26, 2026 at 01:26:43AM +0000, Kuniyuki Iwashima wrote:
> > +static void sk_reuseport_prog_free_rcu(struct rcu_head *rcu)
> > +{
> > +     struct bpf_prog_aux *aux =3D container_of(rcu, struct bpf_prog_au=
x, rcu);
> > +     struct bpf_prog *prog =3D aux->prog;
> > +
> > +     bpf_release_orig_filter(prog);
> > +     bpf_prog_free(prog);
>
> afaict, __bpf_prog_release() is the canonical way to free a classic prog.
> How about __bpf_prog_release(aux->prog)?
>
> If it makes sense to you, I can make the change before applying.

Looks like it's applied as is, I will follow up on bpf-next.

Thanks

