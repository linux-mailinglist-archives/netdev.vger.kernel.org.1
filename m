Return-Path: <netdev+bounces-263601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOfuEzHRp2lrkAAAu9opvQ
	(envelope-from <netdev+bounces-263601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:29:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B50D91FB25C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95B1C30457D3
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 06:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D4837FF79;
	Wed,  4 Mar 2026 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYRWkLC4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E1D375F73
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772605741; cv=pass; b=eXY9Ce/0UerVk1UithDAlwC2U92g3zO6bwQcel6ua7N88M8K2NyjmMaV9gx2FVfelfXJLGaDiG+9XFhBGRKmXCZ+iOAlPnptc4lW9SRZTL83WozBBPb6qR9EdNSBEkZBjfN6ZBzUwML8azUlDqF0rscql1DZJclu8SDSCXWT/Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772605741; c=relaxed/simple;
	bh=KejAEfLcSf/FsafjxEKrNdjOYYk/yskk122UsCDgzV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmaNuao6y3zkFER/UoSQyolwUIPNn2O2CXJ3NfkNCpL5qmjONAiha5wMm1rbro6hM+2XQg9uQSAkhlwl803eB7yWH4dV2iUC1Xi7mga3rY0kiNZSxUbgEnec1iw1nOSgeM+MDcjeIKe0NBOjhAZrCwcPExWbGcoK6g4j4EuWQHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYRWkLC4; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38a2e62b893so2240221fa.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 22:28:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772605738; cv=none;
        d=google.com; s=arc-20240605;
        b=G9NdJ8aGd/lbUWSm7UrXd02aTTg0cUpXKDrUxT5tMFjmOeqmpJseTlhhnbhxO8lukT
         hZVWFArI4zTj6oNT9Gjc8FMtSVoLHysNWLkugfY19mRYTRKwMbBvaGC7knpR1seAdQBF
         6/SrHHrVm8FB7KTz5MzdgJNN8+Z+KraGWIf5rurdTZoLcbC9VIIJMT/k6bP5dBTzuxWN
         kI8Rag9YEsxiXYLovucuv8X2eCZokQcD+owMSx9TjABtSLXRrYUtjeuNsTOI9P4ycbY1
         bh+K3O4Pgmx0aTpJQq0HqcsCJRrm753jE9D3NoSyVROpOP1soobNXPV3qFadyqBhBzvJ
         V3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OD50C9zYyE2DnlBAHuPNbrPqQ3xh3gR+kF6q41AaU9k=;
        fh=nNOYcbY+xSQwokLMcGS3DygeThMp7vvTG4yzVOlCZZA=;
        b=I5MHVzglFIhBnzoi1h6zN8XGghmmJY+ETYctaLJoK0kghxHrnYBrWLSex1sxxKTUbL
         09dM4Dk7/tfNP5Z7yvwEtDo8Alfg6k9Yeagbc2afn3pVoT+6t/EVSCYKUwjxgN2ktI03
         +el4XceLyBc0w21spcvHijSoo26pyhSM+zH/1VG6hEmGdh5fjZUZPiR/rSjWtAR/ssfE
         PbMBBB8111FmRjpZbgVqIdHYhW3s0TAVXGkOfMYSTIa+YPoZfEDs/yebDjnr5gyBFSqe
         giPJVrDeaKT9Sdi4H0yrIDr+H6T93WXm6iEfC7swFDexpZNVfh4wSqYss3arY1kbez0h
         UtsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772605738; x=1773210538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD50C9zYyE2DnlBAHuPNbrPqQ3xh3gR+kF6q41AaU9k=;
        b=IYRWkLC4MqWvtm8sENyPHWeUfrg8Yw1xUMcvwov/BUtmiYAOJ3p5p2njqd24NTB9D6
         Hy9tuo0XGvghkkdl52oSOiHfH3qe5EAGj8r2V8kPJwWIggr+h1SaG0OWE/NbMJC3ZiZl
         VKNM8VtuZu1+IwG23HnAvi9MvD7MpydT3ZUgAlSnPrrg+bT/zoQ5tB3O+6edFdRiHxG9
         uglXHn2uuDWiEg1N47cg5MVw/3c/k3N2Sy3TOHQKB8IMja6YHsmE7a/tqVc1a9B+lsKm
         HtVIiBBdq6ZYa8IZ6kyrrFp1uDxXNNg+keRpywtuMs9s+D1NovNKVzrF83VSr8mr1WY5
         f/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772605738; x=1773210538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OD50C9zYyE2DnlBAHuPNbrPqQ3xh3gR+kF6q41AaU9k=;
        b=GxbMqLff3c3FLviI1qwM2t+fxIE4BhD7j92PBNSDQajGrMwa1E+J1qQ9FiQXBxxFl+
         cA7O4Y5eSja6bC/VuK3INYiGgkcrMHEjmRhD0/2Z8zFHer2hBdAr9Dlhgq7mjQr7gl5u
         X0JMmuWllRGDwc1niDuV+BxZhGZFUiQQR+mC+wbK3Lz0IOf6xmM7ojKfPE3gUrqZWBWY
         9jWAOwKZ28hCsr3CA+42vN/RwapnpxBtxCqmG28IyHFZ96XnxunSLRoitlV7M5CcK1Lt
         Auj2TA4ZrAWGjU0F6zEZdpZ6L5fZ2z+wpb8alkoYx0EIVG7Pw9l8CO7cO2feuWGLw6TJ
         ZIGA==
X-Gm-Message-State: AOJu0Yy7qyWz+QyvbQM7+awuyzRIAuMe7OJj2PJn/Mr5m031THO5zyWa
	RgPO+cyxBSaS0JnHhUcn94WITnBmWcoHPvqUtJPfDZvBye8KvohgPhyFIFe/QWIctfmfHQP04o7
	9hWRjy9Ckhtx7NSQyvY1xUXGXGdk+GL0=
X-Gm-Gg: ATEYQzzO2jSRV3wn9wrQF/nJjcuIRHwwd5OoxJYwYvMWZK3KqiojjVpzdh7vHYMZWm5
	aKM8GA9SdmGKBpg7yEDVnvkauAK+pQ5bzhig0E6bA7CtZcmuuSU4XWKUr8bLAdH/U2ch+CiERWa
	MpLidXesy6qunjnwEO59bFww9ryt4GANOC19lkqfP3UFxA3iobH7YXyR96CaKWnwR1vOI47qwU0
	A5OQoSrFcbH/GpYswtzaEKCyG5Zwd+3opPGEugCgMYDKSQ65wXiYCatd9QWrcgYh8B1YDIzGMNB
	KVcV6htZ
X-Received: by 2002:a2e:bd07:0:b0:387:c1a:70bd with SMTP id
 38308e7fff4ca-38a2c58c42emr7993641fa.2.1772605737608; Tue, 03 Mar 2026
 22:28:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113084605.60d0fc56@kernel.org>
In-Reply-To: <20260113084605.60d0fc56@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 4 Mar 2026 14:28:20 +0800
X-Gm-Features: AaiRm50r3zlYk2Wm3l2RE7vKGbD8ogCJ_el-EUgnks5bAjGHzySY-W9kCu0geLI
Message-ID: <CAL+tcoB0GV3i7sQnLScHjAiRN8uxYYM6_mWR2=gZLj0qr_w23Q@mail.gmail.com>
Subject: Re: [ANN] netdev foundation TSC meeting notes - Jan 13th
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B50D91FB25C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263601-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:url]
X-Rspamd-Action: no action

On Wed, Jan 14, 2026 at 12:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Present: Andrew, Jakub, Johannes, Kuniyuki, Simon, Willem, Paolo
>
> PHY Testing SoW Update
>  - Approved by board; processing contract in conjunction with LF
>
> Lab update
>  - 3 machines in production (control, build, virt/ksft)
>    - Have capacity to host Wireless NIPA
>  - HW testing - 1 of 2 stage 2 machines received, other is on back order
>    - ETA 2 weeks but keeps getting pushed out weekly
>    - 2 NICs per machine
>
> Finance Estimates
>  - Estimating $200k+ EoY=E2=80=9926 balance
>  - Looking for ways to effectively use these funds
>  - Netconf funding was one avenue

Hi Jakub,

I wonder if it's the reason why the link below seems invalid?

https://netdev.bots.linux.dev/netconf/2024/index.html

Thanks,
Jason

