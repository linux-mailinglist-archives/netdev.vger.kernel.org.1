Return-Path: <netdev+bounces-251583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCFcHGrlb2lhUQAAu9opvQ
	(envelope-from <netdev+bounces-251583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:28:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 161924B4A9
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45A1D970930
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2724657F5;
	Tue, 20 Jan 2026 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EtsHtceN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF045BD41
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933518; cv=pass; b=KuZc/SgGTj9KN3vUwzeH4YySiTeyzrqmEO5BDI+aPSw8RIIADTNsJgBdd9Ii2Cyztyt+BEaKHmdJdmNGN7nSst3qzkDzBhq6ZWkj8lZppyJyW5Cbw10XWdjFrfXJ3EJiewYp7mEOOfX+/Z4i/Dr6Ncv3y1iNtMsNvi5kDjc9cMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933518; c=relaxed/simple;
	bh=yJ0/In7PKFw5egPEyuwjNNrSDESwA0aryCjQTpVL4/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHBJPaMgTcsJHR/1CsWuTwjI/tXkf1pFlQ0zIX2M8sdqNETLE4wie7+dui0Ptqyki6OmEslXboYMQRUxOhHOTI6HOnKglKm4zEbIRdrxy3NDuSmZDuYjbR3JPErabFVRSXfvtnZj1g1XBcnRo+hqND1BEdtRhZ5BTz8TMOtsCZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EtsHtceN; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b6935a784so336e87.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:25:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933513; cv=none;
        d=google.com; s=arc-20240605;
        b=iTzC5sCck9/lRIe1+Nejjj6WYXoS8viEf7rQVtNXYDYTlHfEhLQL36psFmG6IE8dyb
         N56ggWCya2w5XIoydY5Qka42+t034TRAlC654kC8fk2i54rk3DOwE1dikIloKeLLENLH
         +T2EN378svy0IL8TQvHfJC07eQXxVeGjZFv2+6P0wyXQG5RDb9Qrg+tk8I1ltyKTDSYM
         XTjwc29PgmcDdiXV14QGz4Ka6EfokJYHIfGFMJcvRVjv+gKXSE0JdmJ++UcpRkcnfAsT
         quiStsHknfCP+kfciVbpx0ULCSmzH/Hj34IOy+aJAbRGeKYbV2CuckWUowKTg33Cr7cr
         241w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M0bGf+EPs2Mxct7IR1oXsdqnd9aw+j/UU1sitKcLm+k=;
        fh=0PUVEvXDUWGhWeZHh5vDt2UN5RkbkpRaSh0cFJNzT38=;
        b=baEsO8LMOvYOzq0k0SLlujVUyT86tG0n6Ku6gxPLg5RDL0BNxyzT9mQnw28Z2FNPhU
         1Y2EUsTs/Tgljc7QFxI/rq46fK41KKNTL0zjWWqZa2G18NJu1yXCvCcwcUx6SNBiMIY3
         7W0Vz1R0dApHpcnV23CrlbBeafcfZ9vMjcdMiPuH+tIJbxLUKell4pSfM4lMPWhsxXYb
         l+Oh3TPWXk22SHi+clO6davuNDbQtlTJ2uO1UfT3JM3+XhxTkqRrpttLNufwrSBVTV/F
         rpx11uHpmJayJQA5zxuSck/tL12SHnkjMfyaKi0ARZ0CE7qvQdIj/AqrcJtXZWS0tMbX
         cvlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768933513; x=1769538313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0bGf+EPs2Mxct7IR1oXsdqnd9aw+j/UU1sitKcLm+k=;
        b=EtsHtceNhWsBdDFjvivwOOSmGNNR4KHXc9sTTEwNZRKUc1qg58PKxLNjPVkQy9m2UV
         wxGaKARZpQw/JUfA2WKr2ai5H47KSVpEVUJyPH47pWK+QDp9FrrcrQJXzJLS5f8jMTfj
         3Ss4XXMsNZdgekRKFSpSkV7yenbLE8mmt1qfvmBqcCBR2jk1Pc1Y65jvz6e7NEmxa0xR
         ekoKomxikSm22M2VSD76P9ICrttC/8sNtDtL7UcfZdrxB2HnUCsiOFDExU5rJpnZiyMi
         7eKoHJLqwwad3rw3lxK3+313+tRxiD3WZrhcUhWQVhYo/jl+YOoFmO9Gn8psJK1caZCL
         Qctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933513; x=1769538313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0bGf+EPs2Mxct7IR1oXsdqnd9aw+j/UU1sitKcLm+k=;
        b=Q2KK+KBlWkJeh6m1Ojinmo9JUObi4gN3FXLQuDAM9ROm8FyCrZ6Pvo32M46Bv5+fn6
         3MaexkRX8ffTpzX9mSxlUz6pEMs1rqyCdDS+x76R5a//z/XaK1q28KJk9BpLuallp3ov
         s9JKZcHQbvom7rOOVnbEqkmGtETIc2mlLhUrfsqLrLGYhOZVoNlM/YA54flNniOEYLpy
         zh8vU5aGLK1Ldsd4e3RRrY3nOdlwUG+Unq3bwUcUg7ujnT1qNEQul376Z5XZtqwP6uni
         i5Fsya4ulQnrdrXQJUVdCMUvcjFQldpR4MNlLzyjegftFsEldi7gDvJBa9dmLPhvb0CJ
         QHtA==
X-Forwarded-Encrypted: i=1; AJvYcCVdsDJWzOlZZ7+QfWZiy8SbygsoV1yM3HYKMblMt7pK6LHsufXLOBD4wPYe5+6qYguZmi5Ka28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuSvDHbyL6VqASs4xRpPymHPoWdux5snF5vvFF48vZrykpAgCc
	OvU20cweTDNoOTLhQslau9EurO6dSrftE4Lhfy+2A+M6oZSu+hODWl3vkD37nuwlEUdCvWTkRSx
	O6IkXI+CC5Oif7eyM0Q1WRqnJFk5rR9vdtjjU6evV
X-Gm-Gg: AZuq6aKE8tJczpkY3qgdPxjd7MUyTGMkQ3P3yrNABWR+7ESxI/DDlUGT1B9TZJxRUGN
	YPayQTe/Stkc2fO0e+Tn35mGWYL2gLKqRdkrHSfg6oUq5yNbFXyZRiGudi9VaW/y7OfGWxhMgwj
	L8c/5AwExESIauc8JU0WcXZtzDeGjvVyPeemXhP82NM1TtyX3NVdrLDAlqbdxGBpVO9BMcksPKq
	cUbclOKkwBga3s7OThsG+X4T3FbkXQj+zd+zG3RBEHDPGhv8WBIaOv70gPcIm6galU1RtTBv3Bi
	j/D7j2smZzHFA76V+X+K4qefHf5pS7SD/ibF
X-Received: by 2002:ac2:5b07:0:b0:594:43e1:ed43 with SMTP id
 2adb3069b0e04-59dcf6407bcmr6194e87.2.1768933512653; Tue, 20 Jan 2026 10:25:12
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120180319.1673271-1-kuba@kernel.org>
In-Reply-To: <20260120180319.1673271-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Jan 2026 10:25:00 -0800
X-Gm-Features: AZwV_QjuNTma8hpUk4wIaGd2eIbRoiLwDebyhcOY8hqjW_FSBhmx4mg8QmbbW34
Message-ID: <CAHS8izNS7cFxVbCQOTrsfNvqFCPm8ieu-vX+fMJ1rzLaK+C2SQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: drv-net: fix missing include in ncdevmem
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251583-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 161924B4A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Commit ca9d74eb5f6a ("uapi: add INT_MAX and INT_MIN constants")
> recently removed some includes of limits.h in uAPI headers.
> ncdevmem.c was depending on them:
>
>   ncdevmem.c: In function =E2=80=98ethtool_add_flow=E2=80=99:
>   ncdevmem.c:369:60: error: =E2=80=98INT_MAX=E2=80=99 undeclared (first u=
se in this function)
>   369 |         if (endptr =3D=3D id_start || flow_id < 0 || flow_id > IN=
T_MAX)
>       |                                                            ^~~~~~=
~
>   ncdevmem.c:77:1: note: =E2=80=98INT_MAX=E2=80=99 is defined in header =
=E2=80=98<limits.h>=E2=80=99; did you forget to =E2=80=98#include <limits.h=
>=E2=80=99?
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>



--=20
Thanks,
Mina

