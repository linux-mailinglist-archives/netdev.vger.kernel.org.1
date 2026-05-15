Return-Path: <netdev+bounces-288330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEEDDDAyB2qQswIAu9opvQ
	(envelope-from <netdev+bounces-288330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:48:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA82E551A8C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF6AE3011A67
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637CE3B6342;
	Fri, 15 May 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXAjZAGw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D533B7747
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856493; cv=pass; b=hXcJ1VixgZo5GFKD5nFUr0/LUK4JVsz8vQFPg5fb39ii3UqQHIyGYCS2c7YINPzmpz3zOfhMYgu7HbvipbnJadxUYpi0/yVrR6xtfZwQeA+BQ6ozPx7Vgb5uHXTADUCgUuZ4hMxtVDhm7QQ7QAM5zWSGUXbqrwM0nXlW1mpfbIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856493; c=relaxed/simple;
	bh=l0ozLGbcjuIJmi/yw/V0EiYOZG4hK5ePDjx5Or9hgco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JS0mg2PJqhsfNd8Wz5jeHAa6h2di8hCCyS/m80r/nSXRPhdtbpHeKhsOOXHmOOT8qSq0u/DymNY5Anbku69EglwfckEnutHsVS8X79Oo9kRcnAZH8iRS8OgQT1JgtR7h2L5qLAG7nFPQaE3fgXTXkCK+uMO6xeYlNyscFos+Fhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXAjZAGw; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43fe62837baso4833980f8f.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 07:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778856488; cv=none;
        d=google.com; s=arc-20240605;
        b=JiaUURp08nJKmIl+G8CAsG/spznU0GcHTD9JVsWnuwgYJupAJ3FqmLsfe+R/Be1Pgl
         N8vx8WZIQHhDPj3m+GJf6EYXZovDHosc0WMU44TTuy8D8g72fPhMhSc558qgFJg9APEU
         Q3oJr3xsKePn4NwPMaBEUx/wJkW6kyC4HDZR6ioncl0WgEgP/ElG43+1T52Igh/4dFwT
         IHtct8E1Jf2fgdAR1lWj6sW9S9YbjqOwKoiHxnz7igoenHQ+j6LQWuSrO3Az6gofvt4T
         HYpuWWBlYdu4z1QpYn7xoyHUXusnv+7JBr6X1ZFXxE+bpUtL0JMkgcDgWdRuzZg9+sq2
         kRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0ozLGbcjuIJmi/yw/V0EiYOZG4hK5ePDjx5Or9hgco=;
        fh=GDDuBkrW6vbAx9rQVm9NOjYhoJh8RJaWxDs/S3Nv5vA=;
        b=ENDjfGXG5V12GZOFiADCnloL6nbAQxv0FMkOl8KC463dj2TGhrT5HtJTNwH3UFrwX1
         42cBhiDyyoGy+jy4g2FjVW58AWOgMB8NHRNRlN7zdMr8pu+ERoWC51nvTqs38ppCFL9W
         LjYIUwIaF9UaJlkfM0MxkPt9VL9RTZe4No+GXBFm1Cxa9tq27WnUibctyoS5ogU+jwQi
         Ix7tp2Hr1dHG7hcOnfms21f+hBkazE5HzkUHIZqKbI1XTE69ncnvs4Wvl/JuGpVNeDiG
         TfHJTbbG39onRGHUODbOcZ/7GX9ldIo66QWA5xmnh3Cbn6CH+0+7VzPArqGAT3ERYJR2
         R1Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778856488; x=1779461288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0ozLGbcjuIJmi/yw/V0EiYOZG4hK5ePDjx5Or9hgco=;
        b=DXAjZAGwc652jCVwEctT9TrSu/8trr5N1ViqFwAvim98iTZwngOEB+cyOwf8jEOjdW
         oE5ZteloVxoruA8g3Hm5oHupj6Y6EG6MevUOVBQ8OBP6XUiTq4rhrf2ceZgBoq1sQSsH
         PG0aknUDFS6P0R+Io7q0neeWbU2acMbRQP5L0Al3do2kBPQSHw8ZPY579qzXJN0Abepq
         PXJmhFWvdmWKja3n7y1LpXhLcq/UbMrX2H2GxmKlY/9/GMa4MgFIiLuilKrrQL4fEIw1
         mj/vdjOSicy65W1+Q1Hhv/dfMvX6EdxNBnG+EwJPRSGcyUk0ntdd7rS507xg3z9J+aQz
         CwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778856488; x=1779461288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0ozLGbcjuIJmi/yw/V0EiYOZG4hK5ePDjx5Or9hgco=;
        b=hkscv8Cmo17ixOr/TaZtZqrS1aplw+CUcdeplo2M84scAdvJF/cf1gzJa8TslzrBSY
         IaGCOJ56nYGwOm3car5lGGqWnB8ploHddgaf7InTZAL9oPsQHCmOCoCUDHe6N44oBaT/
         BgSLAlyyLYF4xm7esQkMLAj/5RJm5fTufyMDacbbbZMG+gb38nuRmDF5t54KpE7K3B0M
         0psxGa7shvByDPWC/XGIBVUii9ozP5h/8bW2uj2fP/WJPEl/73ZP97qPYc65kMiIJ6nK
         rXgvt3wwXrv25yeOZG0JJDX/1KXk2os1ly7tidh9i88h5wC1Yw3/lQaGXuiSrOAqXzGA
         RBvg==
X-Forwarded-Encrypted: i=1; AFNElJ8Y2tsKDmp6Bj3liggWDV08Ee57sZslJxUNQjs0KbfRN4gEf+A5GshBSGlqzQdxUsDvNzRS9oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNiUKuyyt4NlW9zeUHhz9Ro+yH+UIq9RwLpMLu5/EvtxHDFioj
	iTuwSszHsAV+EVbVzVXlfk4beRxL58mnjWcYAmqE/GUAe+rY83P4ofxZ9Yr4TR5rvHtqT8G/iyP
	fIl2k4SyXVI1vWyZUZLdfPXF/CIiVjOQ=
X-Gm-Gg: Acq92OFYfsQbg+bgt++NTDi1PtAyGQMTRy1AzAFwfU9mpzTy/+OfX4rCG+adHabcbak
	AZtnoZrjGy8aMK+kEIVm9mrGVZqOewUG/ngKxS3hMqcRjs8z2hBgnyuDnXeucxmtsJR1ewI2Os1
	dWHwJcJSNUX2N9AbwKNaYFRMSE3gZMMTExk2JyL0aFSmpI9qh3YlNw2ROlyT6oCIjWx7FrpLB1G
	ITkXOoWnsYQ2gRyP9op5t6+ISctF36YK6N6l0z5gjO3wjk4rBVWYoLRRd6N+9taP2b0Rtw0coF6
	NEllwuh7kF4mlyDekkuPVK2e/EkfKr5e4GtMtT62quS/kUCrau+MD6t7oEO42H7G5fun63VpNUK
	vxbmeovlXasBx4N2laesxsjzjQG+ZX0UAYSQp
X-Received: by 2002:a05:6000:288c:b0:43b:962b:5314 with SMTP id
 ffacd0b85a97d-45e5c372a9cmr6225346f8f.19.1778856488007; Fri, 15 May 2026
 07:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515113102.2389020-1-arnd@kernel.org>
In-Reply-To: <20260515113102.2389020-1-arnd@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 May 2026 07:47:56 -0700
X-Gm-Features: AVHnY4IJhGzViGxkFydpy-ZBw9ON9MzDz_cZ5mrUv3ShjDNoKLYLS1-DYxXoS10
Message-ID: <CAADnVQLYitAZVpXCTygA1uAUtN6m8pMkWzFi9su719M=nktmQQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: test_run: reduce kernel stack usage
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <kafai@fb.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CA82E551A8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288330-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,fb.com,arndb.de,linux.dev,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 4:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The xdp_test_data structure is really too large to put on the stack
> and results in one of the largest stack frames in the kernel:
>
> net/bpf/test_run.c: In function 'bpf_test_run_xdp_live':
> net/bpf/test_run.c:387:1: error: the frame size of 1608 bytes is larger t=
han 1536 bytes [-Werror=3Dframe-larger-than=3D]
>
> Reduce this using dynamic allocation, which avoids around 1KB of
> stack usage.

1k?
pahole -C xdp_test_data
/* size: 192, cachelines: 3, members: 9 */
/* sum members: 120, holes: 1, sum holes: 56 */
/* padding: 16 */
/* paddings: 1, sum paddings: 36 */

what s390 doing to make it huge?

Probably better to rearrange the field and fix the root cause.

pw-bot: cr

