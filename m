Return-Path: <netdev+bounces-260158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAawM/KgnGnqJgQAu9opvQ
	(envelope-from <netdev+bounces-260158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:48:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E36E317BC49
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 668C230185E5
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAD5369994;
	Mon, 23 Feb 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCD3WCye"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F781369967
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872420; cv=pass; b=db5VHDpF2t5GWTW1hOZtjkMPYbQZLmNA2Rvrz5wrPascg4nx++t8lNLL1540+YifHL6XUM8PJqUS75JXrfoeIj6B0dfxjo3pjCTbs3mUQIWJH1i/1yfOcMfjrd90HSBM7wF/orCA88g94uV9mBIIIim0y+36Y7ESFTMC8+HbeLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872420; c=relaxed/simple;
	bh=DChLLxetRWXjpSdJg92N/gcZI80If+PkvbXG+ih5ZRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjGGDw7OM9ugmcezDVmP7kd6INsQagoXH7ufXv3NDHoghywas35eHJLbcROim06oLLGOWyeDcjtHEoKJHl2m12wn9s+nP+ldiKfHI86A7Zgvx0ar7v5qLEASYfFpQ54xw/qyi9R+VJjS3eTIprLuTdzsSihoeR9oLDOkQdOUmXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCD3WCye; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270ac5d3efso4202113c88.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:46:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771872419; cv=none;
        d=google.com; s=arc-20240605;
        b=fM0srNiR9HEwaSsBdJUIDDMufzfqcHkwxkYbhFaOCfmZagqlBsudFOVr1YDBd6iQ0l
         i5/c/dBVXIC1Yj0G65mrBvWWRZzSJ8n1NNa7bERdzHze4uqD4YzmmGXregzQ62uCQOP8
         zQUg0ygRsCYgbpBhNvpyLBIr+CgzQDXYhbM2D69rMivcXwk7pXGTGPUghAWKW8iDJGx0
         IUNAjX13OreMqvu0zoP7wWAz30LQnTBDmfr8exvy1KDO+U0eEWMslfT2nAMCs1e5WQMw
         bxDCsF0bTW2EnjJUuBONt/mbCpZiiIEKq0M22j1XETkx92DYAGtPZO2L/Gn2gaUWfNq6
         zkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mt5Aw8SwMoGdYcHkvWgxAWmLKUxURO2zoxyB3pGDnYM=;
        fh=Fl8Ns9FMfmFvShPbAFh7dpZ1TzhquLv5K86WoZIKpbQ=;
        b=UUsFQPpnZn3b83JSZvwTyqpYkb8WUpN1/HbzSS+mW/s/7HDVi5nshkao9xqwJcqALI
         DRfT2JamLnhsr9fjEFVcSXGE7MH3ga8Ikhl1pGWkxNymuakyKKC17/ukf4N6NV/+II/F
         jtlYbJpqQFXlIuZFKL3abMi1jGxpvwX59lInnm/T1+s6a4SvgiMszYLzrxH+ZHEojBzF
         Rx+qXnigyFMwe45OoOPW4DCV7Up3aFxl6V4hXGVe67JhKz8ylUvSjiNVXWpJkaf9pY9D
         D/S7cSX1z/8ksVEL9c6cKyatkew9iR/tYnutby1VBYveyJFqNWSDLLOOKTQe00NZgUPU
         YmKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771872419; x=1772477219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt5Aw8SwMoGdYcHkvWgxAWmLKUxURO2zoxyB3pGDnYM=;
        b=fCD3WCyeySfQbzE1BIMutpkae8GAynyJjvWdighfre9uKmR7U5t9hPWrBSjCO4hASd
         WMc1Nof5s+rcIw9W+GGga9b5sgYyzBmbahlScfPbhcHtKMr3afM2D5KPL2AkfIRx5Yte
         rSwUoImt2ZifOzfmzFBmgjLgYgdjyHgIveCuRDzSg5cZUfgzCFo4z2wSL7bVksfNDZmu
         WmquE59h6t3CPq1ZSXpI4HLMCcQfdJZM7x4s9WTC5R6zahafGhvCuqXs0quSzVBaUAND
         vMaDcuTV48yx72WH22QBqwL/nUpp2p4Q/AYUzd0rPjr0W09PWz6n82bdi/C1M5rTrTPG
         mfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872419; x=1772477219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mt5Aw8SwMoGdYcHkvWgxAWmLKUxURO2zoxyB3pGDnYM=;
        b=MtPUTrjTCvBihaB5JxMoXUxG8YguPJX1ckkBJ4YKxm1hvdRazHnwREYPheTtePVGdp
         HXZVYg98Skh+XD9BbR5W62SMoL99TYz+tN6qaGDe8Q8J6wYY9lkjvawL0cvHBIPzu2mV
         vW+dJ5ejJWL/dTw5jnXpkSviEcCH+scK5+U+KNAUf6Ca6Y8VisRz0Zis6yAPJT2SkwUC
         0DiSjB6YaHKq/D7ChHS5P6kOYBdVW/KKrkTioZXKU7mbuet5r+cdzuvvinqtpZG/xcns
         3kzImPyZl06zfmRPcF4nJFmY9/dLuEiHed9bweUsFA0EuxwwiM78I2rT9k/9s/Mgtysd
         HV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/jEyUayBGwefBdNCG8UG6jlgtBegrmmApvrH6RKbN68tpJMAngOEn2Zo7r8fPH9N7ZKznvV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztuXnF3d1QMtUcoko/SVaSOHri87+wH8K6lk4U1BooHT/cZelM
	GPOzSo5hA3aEzY1jpYSrMb3NgvIo5iQ0n9t3+Z/9kGggrR2ei+ECcbv0U0idv9pBCgM3/V57X2G
	LdTS85ezuKFNysiKNCmH//Sdf+Ub/Bupg4SHs+gCC
X-Gm-Gg: AZuq6aJj+QDNCJ6Wmf7vqsv0gGfDeU1S9IJUIPY+Zb6mF51HpbvDYRl2zo0dPP93zPi
	NoDWS/tkrkl6ocSmH8sm3vqZTz8p3ftnbQlt1Gnw7UYjrPbXHxBr3zKheU2xroWM9ULCW9HdD8N
	159n56bhFBEWPAWNTEPR9kEyybl18WgZG4HpulMx2FWYUfkGRVSduByKuBmypqAk5KzEDeyKDTk
	B6fZ4miGlx0Qt9jQ4up98e1hvzZQN+7GtlnJn5VRR8P8pRQjrQl9f3kwOcE5/hs9WpfroogIvNo
	gjnsU78OUxdP102k/gCW14kf7pHwI6YoaIFE3wXznDeW+JECa9pllLQOapCYUeCFIhMREMxz
X-Received: by 2002:a05:7022:521:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-1276acc49b0mr3149095c88.17.1771872418340; Mon, 23 Feb 2026
 10:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223093445.3696368-1-edumazet@google.com>
In-Reply-To: <20260223093445.3696368-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 23 Feb 2026 10:46:47 -0800
X-Gm-Features: AaiRm50eSzHiJJ8eDA-omCLU8QCsxPa87CsdQJzQB-HouNkjKbPmCdckmJkwyT8
Message-ID: <CAAVpQUB+qvwkW+zMnn3nFwSGM4TSfWxMRsQr6ZMp3i5xz15tzw@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: move udp6_csum_init() back to net/ipv6/udp.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260158-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E36E317BC49
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 1:34=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This function has a single caller in net/ipv6/udp.c.
>
> Move it there so that the compiler can decide to (auto)inline
> it if he prefers to. IBT glue is removed anyway.
>
> With clang, we can see it was able to inline it and also
> inlined one other helper at the same time.
>
> UDPLITE removal will also help.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/2 grow/shrink: 1/0 up/down: 840/-785 (55)
> Function                                     old     new   delta
> __udp6_lib_rcv                              1247    2087    +840
> __pfx_udp6_csum_init                          16       -     -16
> udp6_csum_init                               769       -    -769
> Total: Before=3D25074399, After=3D25074454, chg +0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

