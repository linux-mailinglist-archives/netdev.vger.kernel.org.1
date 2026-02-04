Return-Path: <netdev+bounces-256601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBHfAFP3gmlVfwMAu9opvQ
	(envelope-from <netdev+bounces-256601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:37:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DF4E2BE2
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52067301629C
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E2A38E5CC;
	Wed,  4 Feb 2026 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gveS/ZX+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227E927E04C
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190671; cv=pass; b=RwhDQOGaJf+qgVjlsnliC/Fu/tLLG3EWccr+/+2sKAfE/M7IWgwdFbmA7MyAy89Plv6d3zIzJB4LutAlulDEzW9JkpPf3CZzrqgagCJFfL0HXO9CXNKwqXNRl7f3jkWRssFAHy44JYbuWlY/MKXZh1ittpPM9Lxj8JN5z/Ny36E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190671; c=relaxed/simple;
	bh=1xOE5EM59f+OM14/4K8+jmb/ckpzIFbHzKV31oKZPE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sbc09JqGXmf7WdX0J5VQNvLoLJEXToJPQiRg4KTzLIfw8onkdyqcbbIq0Jm8d0pJIw0fDdrC5uDDAGos7s7VcrAQKrt1veFLO/DqmjQZ9cf3Qs7f14IaStFm2hvNVu1DAq6t9KV+PYDHWUmc1wULS25GUyWljWOOMoLsTO/FxbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gveS/ZX+; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1233c155a42so10652300c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 23:37:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770190670; cv=none;
        d=google.com; s=arc-20240605;
        b=W4U5lkLziYk72n9kmm4fubYYH73JUXtRpa6ZspsfBOfY8+nQ0SidwZtsR3zzRWkvaF
         WOnwDW4ZXKqR4UafOuNcK4ju6IHjX54lXE/5l/OjF70p106wwBVjPNuOrGKz0VrIMVRC
         5LT6vd0zx9pZnscEGmqDX8ovEnu2TF1db+6FaBvdHU+QNcb51KMBrIYP9bHD5DnC/5pi
         1DHJ142Zn2e1K0hW4+kjVqWli8tE9Iboo0nI2eML/DUAYVGflaOxxfCZfDVnpCDU0O9T
         LAHwreuSpZd9cNegBuRVbESxmihT3alEx4LNbvLhAASe8B65q8RQkcKkSZoU1TbWhH8/
         oEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RrdmBv3m6OKv2/GGkeFeAs7US7LmMnAPtyk5yw9glzw=;
        fh=d2VbmZMGzyiMksJr9glp5qhMo0WudHRPDMKFU33pNYg=;
        b=KtxWlOkJ7YU2JQOOd/OG8ZPR7ptY3NBvb39hW+mjHvmptcAGR6d2DG1LlwwV9ZJo1v
         gSTIXo18pVQcsp12gUdSrLBw/nCZmEfswfGfbAGsIWxFS6DaLsQ2/QNooIFPkrN8LtoM
         VY5UN7jn5s/1kKoupcaFqAPDU/6DlKw0wYgM8NqXN5z7IXQk32+Ia9RNy9TUPyQRXeFg
         QZOqHUsffWICuHFafRQAHZOJV1rF7gfPVxM4iQjaREg2InTfuaLw8UJZLMZ5gwgh68o/
         ToxQVEvIDYD+EnTSnHNBvgFNnXqw08Hv5ZkTAkKeVbSn61jUpx0n0Z26pYUM6Xym9m3p
         kqIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770190670; x=1770795470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrdmBv3m6OKv2/GGkeFeAs7US7LmMnAPtyk5yw9glzw=;
        b=gveS/ZX+s8nLdCwbBR9mf0bY14CJOmBBrGaRAVoMC6JcQMzt3WW9vpepnzo8e62/BI
         iJlT8hh301nhd4EOxK/wlGOZPcGnAIw5YslybjFTlDENk/3i2dBlyq/dCqKHxka5qfik
         tYMNGfwS7JDc59muFpSTdSGHlWE+z/shiZQEVFdogDjQEj5wUzhuvR98Y14xcD7FjDo8
         pgF5mBpkEZ5yWMmWxJbOZCUgG8bdmRoQFyh1M0fQnjx9F1T9nnpbJxQAGSS4oNQ81odR
         8e+VO74CGraNMa+ZuBHZo+i/OISiioCQ/ij6DwAX5RDg04sn8A4moldxmQGkbINlyVUS
         vMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770190670; x=1770795470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RrdmBv3m6OKv2/GGkeFeAs7US7LmMnAPtyk5yw9glzw=;
        b=d96lRSIvdoyxyoD8FJBJAmL6tjzYPZqRhUui1dtM3cTB8EMReVyt+HAF0aGRhwyEYE
         yRUCwyDrXaSqnraqVhbf03bqYLkYPh7D6LcNhXxJ57BVCMP/sUrvL/dwzU1xF60sVYx1
         0FIbHMyNhuFiGELhYITSVwzeSyv5irCrlhYA5MjrxVxHYRA+2J0titkYCN2ivT09fc6a
         OrQbEpLzJBWt4Fz4lRYzEWV5WIC+QYrwGZCi6EcMxws3/yKQzNF5yLA25oefQDFN4UHY
         XEyPD2mOfifAD3lsravmHyZWxC9H1WZXoMy+lgnL///6Q6IEEy8tgn3rVfnqc+iZKFjz
         /nzw==
X-Forwarded-Encrypted: i=1; AJvYcCXCozmlwaA3h6Bpwy6xNOTqxoTzSGSG4KLlpwiIyBjkVS7u8xNQbPBoKVwgbcWtjp44lCcDs/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy27T0uYyhIqRS7Ybm4X4SsbuvA9C2TTKNtOqpd4ZLlf8p37pjb
	yTDN7p8WeqyBQRAuMhnVq5Ca0FLiJIlQrHbXmRLw7+TMO7KN7hpzSU1zfC4ahofe6fkp2W8/ClS
	Yg+DEyb1+oEtYeUo23hmGOTPalk+SKh4R1ORGH8WK
X-Gm-Gg: AZuq6aLO2rcmoSMmfL3mmLLoKRwRTBSHN/0nqK4OTO/n+c1XOvErThRthc5ri5Pcsxm
	DdQTyFB6C+bGs8SIcqeGqmUsBWIevmPvoyEwue7aNThpXWrDMRRoAMe2z5hYkAIKRpHsMBRx/wl
	q8SayW+bhD3mEjAH9bylhWzJrbI7I3YvQLPF16AMTckd54F6BxhaT/KlPTdlq//NmzuCwxynZIY
	tOk2naMMqbM6t3hCQNhxYlmFF1p53QcVpWAvaqEwYYsaacYXQbiRkOddwCK0XItXEqEfeA/V6tp
	fg2SILwd0cpLzIRN3Oltnr0sQIALpgPrJeMmAxGIf56KqDEkZ0Fygow4BARF
X-Received: by 2002:a05:7022:b81:b0:119:e56b:989b with SMTP id
 a92af1059eb24-126f4780cc5mr895245c88.2.1770190669816; Tue, 03 Feb 2026
 23:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204055147.1682705-1-edumazet@google.com> <20260204055147.1682705-5-edumazet@google.com>
In-Reply-To: <20260204055147.1682705-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Feb 2026 23:37:38 -0800
X-Gm-Features: AZwV_QhR6CgwBijz-EGMgpWVzTIgVadSTwOK2iCLvgEXO0GxOZo2xspTL2NfOVs
Message-ID: <CAAVpQUDO0YnweO9MQZ5wjEzzNi_WsJSraC4FgaMPkH7_m-EODQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/4] tcp: move __reqsk_free() out of line
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256601-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58DF4E2BE2
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 9:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Inlining __reqsk_free() is overkill, let's reclaim 2 Kbytes of text.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 2/4 grow/shrink: 2/14 up/down: 225/-2338 (-2113)
> Function                                     old     new   delta
> __reqsk_free                                   -     114    +114
> sock_edemux                                   18      82     +64
> inet_csk_listen_start                        233     264     +31
> __pfx___reqsk_free                             -      16     +16
> __pfx_reqsk_queue_alloc                       16       -     -16
> __pfx_reqsk_free                              16       -     -16
> reqsk_queue_alloc                             46       -     -46
> tcp_req_err                                  272     177     -95
> reqsk_fastopen_remove                        348     253     -95
> cookie_bpf_check                             157      62     -95
> cookie_tcp_reqsk_alloc                       387     290     -97
> cookie_v4_check                             1568    1465    -103
> reqsk_free                                   105       -    -105
> cookie_v6_check                             1519    1412    -107
> sock_gen_put                                 187      78    -109
> sock_pfree                                   212      82    -130
> tcp_try_fastopen                            1818    1683    -135
> tcp_v4_rcv                                  3478    3294    -184
> reqsk_put                                    306      90    -216
> tcp_get_cookie_sock                          551     318    -233
> tcp_v6_rcv                                  3404    3141    -263
> tcp_conn_request                            2677    2384    -293
> Total: Before=3D24887415, After=3D24885302, chg -0.01%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

