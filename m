Return-Path: <netdev+bounces-301473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RSH4CujnOmqDKwgAu9opvQ
	(envelope-from <netdev+bounces-301473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:09:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3E56B9DC2
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:09:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=XZ5aNruO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301473-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301473-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C018300F5CB
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B95395ACB;
	Tue, 23 Jun 2026 20:09:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB638944E
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:09:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245349; cv=none; b=PdMEsGIZtrL6hDr0NcD96Yf5V+0ggUm9+PkRDTMvNRfoPQ3pozspJ+81rXncrqfM08shtk5KgONoCMzvPkTZWHYevGFDInVX32nXcdQx4xc0S8liKSVjNybFaT9hH7hrs7/Jq3bOSs+8P5KqHhKvlJN39D2lnQKQX8TKOugkWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245349; c=relaxed/simple;
	bh=7WVnW0wtsKyMSsRVu5jiZnreaAUWuQYXUj4K+nyHjFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h9Nrd1uVUSUE6jquRYZ8nAz0Z9foCnh1AbhvhiqHGUTQeM6DWZtBVP/t8t6N/vadqAVUx4hj3D2GUHeUnVYL+HstYOx9nVjZHUcdtqGZkUZTo9xo2vhKWNbceRw8MUSCuX9/4EepXAYlFPR5iIj7iKy+u9QDNDcxT7FvxK/aNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XZ5aNruO; arc=none smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697764213d6so361446a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782245347; x=1782850147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSmXA5HFeluPyLRo5oZ3PmwkYRRot2n1RG1ZyVygTHI=;
        b=XZ5aNruOlHSO8OKMlLuWpCkFHeLJDJZcL16IW3lMBH6AMhHcC+SwbSC6dULZr/abQ8
         pwGBa2PXxdkrzWRFNB0+lwxJwxIXo70TiJZoM1X/Qy0y2QROz+KEtShLFIDBuinn7oV3
         7kdLiNVEkMURr6V6dnP9etcVSvYG8Zv1+rPSeGzI4ajQjeJb8PvHcNHgPmcQyj6I77vm
         Hfv44YZKC9I6ANrxy4ovkvfE3EibYwJshsIo/DNRfvK6T7O6v0t8kuNRT9NXtsbsaou7
         m9O0IIrDmeAA5qmBf5RR6R3OtVLscdxVXhEusnguhgb6eMQJchv6TRYVxwqgpPTuWzsR
         4rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245347; x=1782850147;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSmXA5HFeluPyLRo5oZ3PmwkYRRot2n1RG1ZyVygTHI=;
        b=eGwmhlSf4AotGUtUeWd7Q202wy3sTT1AIa1+/VdOHxJeFLued1Pi1gJ4ayp9KSECCx
         V+qp3Foy/00yW0AstEtRiDAU2D+R7QbnBpaSn6/fL0BMICQcngyG/WPIjLTq0G7tXTYm
         mPN0tebgUcamQjeJtVLH/f6yPUUhghP9/QdYdkaFmudHj/hB/abqhiy1ciDqwEJoTlmz
         4FxUn5uef5e7HS8ETEZrfLTR6X7ZHMe5FudiYJrtb5uU26+QKc274+e54uhnPePIThUo
         fgyHBz7U0mpyE1OOb4wmYHgDqaGK1bNdrP4Nuah/BBPTusQ+P7iIpC6hq6ubrJT7OLSa
         fA/g==
X-Forwarded-Encrypted: i=1; AFNElJ9xxR5taAUqXtQp+GUrIepHap1575ylxcSj0vAiUU9RdnQCV8YkXQWkCAnda60QI7pZH8wbEuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2m7YJEuE2zdOQTldLcfIPZjbM+dXXaWIggAS+72jC+TS1jAX
	TQXhlJ/PO9syf+wvQe3o6x5dBlIx67RIBMXxzbBOfUJr5pd1TxF+odyYQGzSKnbdGxQ=
X-Gm-Gg: AfdE7cnY92SZWu/jD1AFIR8Qf/o/JQiO7byTbIae4cwCj5RazvlV+5so4xbCP2x1NnI
	jSFV1UHqGnm+YKmjbGbSCa8lfJnMZWnW/x5IKKtGWTVJnaOa8U+mW7pMlwggfXMh+14Wl29AkRk
	HBKrXrj3aIkf1rgCarKw9afLsg/1pWqbLbSCkY8tq62a7QyAgCCkYku3d9on7Vtz9odZs/XY69o
	E4iG2VuTS2Ythzz4JiTRANE5POybn83gj0BZpoeIjg4g1AUC1Sxa/aOXfl3bnevOu6S+mEoAJOq
	dcapqVXReHSU+HDKZsJBRRNzsx/tSxjp/s628NmzyM1C/cZryRte5LiX2Gz6H8ulOzt2nFk7VH/
	wBtCWBPzg8DLWlrCSPDlNeE04CE8U2t6T+oGdh+6xlLCDyNGESPK3RM0+797MsUqa7nnqGDSD+0
	CxgvOT1RdSPkogfRc=
X-Received: by 2002:a05:6402:254f:b0:697:ea41:97af with SMTP id 4fb4d7f45d1cf-697f3adb2a4mr26160a12.28.1782245346658;
        Tue, 23 Jun 2026 13:09:06 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3aec1a3sm8778a12.11.2026.06.23.13.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:09:06 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jakub Kicinski <kuba@kernel.org>,
  Jiayuan Chen <jiayuan.chen@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
	(Kuniyuki Iwashima's message of "Tue, 23 Jun 2026 12:31:41 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	<87v7b9ysep.fsf@cloudflare.com>
	<CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 23 Jun 2026 22:09:05 +0200
Message-ID: <87h5mtyq72.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-301473-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B3E56B9DC2

On Tue, Jun 23, 2026 at 12:31 PM -07, Kuniyuki Iwashima wrote:
> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
>> Okay, will put the whole file behind hidden config option like so:
>>
>> --- a/net/unix/Kconfig
>> +++ b/net/unix/Kconfig
>> @@ -30,3 +30,8 @@ config UNIX_DIAG
>>         help
>>           Support for UNIX socket monitoring interface used by the ss to=
ol.
>>           If unsure, say Y.
>> +
>> +config UNIX_BPF
>
> Maybe UNIX_BPF_SOCKMAP or something.
> bpf_iter is supported without this config.

Not sure what you have in mind re bpf_iter. Can you share more?


