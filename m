Return-Path: <netdev+bounces-257462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BD2DZhphWlqBQQAu9opvQ
	(envelope-from <netdev+bounces-257462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:10:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE078F9E81
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22E2D300D4CA
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 04:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6798E326957;
	Fri,  6 Feb 2026 04:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QD3+3Crj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC92F5A05
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 04:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770350994; cv=pass; b=GaGgYLQzVfDIvTHM7BTzz3KwQ4aR+yGO5cppDI5Q4zwyQXiDvgORfMRZcyqH4N1R5hc1+kgsxxHmR9drV+opVlNL50XhBJ4ULEgvqmS7WWvGMDkVrN7S5ec+F2FZc1a+cjFUizHDl/JiB35uwMgJ+2el/dKmyNZtTulP5iB9UuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770350994; c=relaxed/simple;
	bh=d8gFJQcZEuV7piAaZnUD/SPnE0285aKJo9ADTNdpf2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgCv9+eoGEanEMW6OrJNtLfOMg8vfjyNoRhUyC6G+Le80YQsO2Kk7YeFvoSosq9PdNbCpkuMydMx9T7vy1Mt3WdrT2CUUkIyz6vK0/m8suKpcbq/K7ES8gJstF2YSRZbky8R4swF2TVcDsrcQd8iznJy0hIfwg7Z6CyBw4a4S1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QD3+3Crj; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1248d27f293so4194730c88.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 20:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770350993; cv=none;
        d=google.com; s=arc-20240605;
        b=FuZ98RqlbsPx8wJV5Q92aINIGlkpWrpkpeQJ+S25r+VnK7fxyx2mhZXhIosTPZ+m+f
         QCxrIJ1MMz+2DPtGjGYn3A/4WRpejAB3dT8H7VKUk+KsXmUt1bEgDoXQIxHsNA+EREQP
         24n7uDKTdFphHrx/KvmPCHEZbPiSCL84vdOfaL9Uf90IWIGcaKEbHMPeLKKUQ90wmoUJ
         qu62IjQFCShGEhZbGusq09jtR+LSt3jSXnVKqvxyxk4b6+s5Totf07b4tlvQ3maqim1a
         MQpNmgy8REwJeX87HGyYcTlCB5vrpLabRoDA68NE6y4Jx3CqHU407VhRseeASbfDJLNz
         M7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R813DXOJxwrFxUZuQvXebLRGWb4QEof0xl051ZNt74Y=;
        fh=WGMb81dyG5EoiHuoCnE0UC3n5uwYuB4d2WLI7rdvXN4=;
        b=SF6vONYUlfezzYV14lg4Jmk3YljRLDPJnJG2UcG3flMaxVojS4csV4+XMjNs668u0x
         9chi8JJjC6s+KmTgSlGXrJOgbddL4ISz9fOKRXI2HGGqHc+4VH7Eb6kEVVPq4VJIucwX
         DiPMgjj7rh0SAKiO/XKsg/VC95pzDoqPaI2Ubo7i7NAyQNg/2VUHFIH4R600czGwqHXC
         4UgW7/gkcHZtcH/7l4tyZm399KVbbZIIJqmmDylbnopzhNpZOY42FSmXeCfPQYbbOQni
         X3fLnCKsUiBhVU5/QTbB72bB7+Lc9VYGYroGXrWTc6PpK+0Yruc2MhZXHeDBkc0EiJGT
         ibXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770350993; x=1770955793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R813DXOJxwrFxUZuQvXebLRGWb4QEof0xl051ZNt74Y=;
        b=QD3+3CrjRzO2MN2NJ6P0sGnZk/KEPEsnQYutQKICVAOu36B7xFF/Wkg0pEO4bBDjeS
         JT4EBZxjF0ouNo8CP/S8/ivlLh4vUxlITxktl23krCK5PMZ1eFh964MIVlMIm7EOitmq
         RbZihk9L0Kzlo7xK5y0d25MUt70Has8Wjhuiu/TN4P7ZfDimyt9yOQS+B4rOYC7WXe9l
         jzdS6I0trvcxPFapfkFyaBcqcZObifG83bnpjrQO1wGMKMTrO0cD0bqM49yJPDQN//Mv
         xe5ulM6rMFbxeuCw8hxE1+63Jc3BeWGYEsElsi77ZcTyFbXLLQ3mim41O8On6UILJBXy
         vaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770350993; x=1770955793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R813DXOJxwrFxUZuQvXebLRGWb4QEof0xl051ZNt74Y=;
        b=YK45GGEI9fh/7qNH2Gfd+g8c7k+C1guaL15XRa/pdLl2tpnG0x8Z7798o1gipznTAi
         sqGM92bmTDlhBXBIsqfPBzPlcqBKcKT12WPqQugkevthkhVyx+BMdHwOPaEpI+XDBaPB
         BqnF/9bX8B7luFS9Lm1SYP1pdf25Jmxl+eLA/VmJbEEUIZmNaCsD6GXIbQkYsXWc08is
         jaUHyg3kYvG+tozwncTKjLKMRpJjOZnMyDEdUIh44pyQE8OklFSVfsYskzowETmPwR1h
         pve94YjJl1cKNuifvbENiyHfpeQumlmw42w+xrO0oLkmvCiVIdvg5CMrlpXT7PjARsLx
         MAxA==
X-Forwarded-Encrypted: i=1; AJvYcCWI3JzU8R+/mCdu1Iq/ysganPY8/zbGcagwKbjJPPl48YnVtUC9GZmAunoBXmzNu+o/SbxfaHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3kS/I/Xz7M7ckhk1Ty71xTLxIj5wJ4ERZTH5s7NdPE9+Cvun
	RJyRLRIrVKFYG/Z5iKg6HKonrTDAH7W4cnra8oIBOHaQELw+LI4mvuezgT0e9g4PJDQw5x0d+27
	ozviZOXv1filAqoMYnL9/enfss+IAqBO/Ro70o7kb
X-Gm-Gg: AZuq6aLWOkr5icVbmZn/4CSl6YzcMhTR1fuEmKRsN59mkCx8kes1ClyEhFQJDDN0WDX
	TCnASiPfuVechrSiddODc/jX87bbw+1fpY/2aWEWeWMjK/hVYZrufjxWHeDjtJDqsjtg3wjCW6b
	877BxMDJEMnrTbBLW6FxU/lFbaSTeovqvnrgxw650rSXYt3mX9BRHifQHMXsvRcJ9ufpbBJTlmW
	kYPnotkfdOaH6hGNRFsjCJegTmIr0tgUkXsDw3krNUIx9IEj7DMcfn3hYce+k4OVhpWeEuLBn7N
	lQIsbPp0Sfove/mrcKjbQNDCWxUjkuzYgbUKedOI3WEIyBqMtyA6I/JHpUdFLp2fSNT1qA==
X-Received: by 2002:a05:7022:2527:b0:119:e56b:c74d with SMTP id
 a92af1059eb24-12704003783mr861570c88.18.1770350992912; Thu, 05 Feb 2026
 20:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205164329.3401481-1-edumazet@google.com>
In-Reply-To: <20260205164329.3401481-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Feb 2026 20:09:40 -0800
X-Gm-Features: AZwV_Qjq7Ir_PIHEeymnU4GUcLBJZ9ireZwXfV3pBk9oJwwhMo7Wj8qeYYhCeKE
Message-ID: <CAAVpQUCm9QKLrTgN5EC5Hy9eBR-8B7hB8P5sE8e9K0ev=SX_cA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: inline tcp_filter()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-257462-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE078F9E81
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 8:43=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> This helper is already (auto)inlined from IPv4 TCP stack.
>
> Make it an inline function to benefit IPv6 as well.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/2 grow/shrink: 1/0 up/down: 30/-49 (-19)
> Function                                     old     new   delta
> tcp_v6_rcv                                  3448    3478     +30
> __pfx_tcp_filter                              16       -     -16
> tcp_filter                                    33       -     -33
> Total: Before=3D24891904, After=3D24891885, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

