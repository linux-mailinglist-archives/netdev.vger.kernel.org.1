Return-Path: <netdev+bounces-267052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMZMHlC3smmYOwAAu9opvQ
	(envelope-from <netdev+bounces-267052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:53:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CCD272083
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC2E2300D170
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B073BED6D;
	Thu, 12 Mar 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QAucDxXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA52387597
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320011; cv=pass; b=oLAiZnO0VgViYODvXBDXKIzbafLW+pGjBgPGK32aB+pUmzZIgLzecQrroZkOfO4XhzGXbrM2tyPtRoZi/qKZwomk2sbhEdI2tYDbkWBlGTbOc4y5vF7NAA/Zz3xsOmHVj0mbDtqLTgrRV4qYlwfz/L8MotGAdsRWpYCtAij3MyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320011; c=relaxed/simple;
	bh=KFziMjOBcymobbH9+U0FWDKq4cjycH+PnY/wu6baXH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIJ7gjsDcSxuETNVoMjQ08PhwuP9Je6acaWvz5vGGDpckxmvUM33UYjqOkPIfZfBJ4BH5LqaSsDf9gzmLaY7rfxH3gfxbUB1uy39ojlSk4K0NN5dXMmqpUACgmh3msIzDsooEzr3Mo0HA7CbyQXYd+OKzTThWm2pTt5cF0BMjJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QAucDxXK; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5094e1d17d3so4768921cf.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 05:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773320009; cv=none;
        d=google.com; s=arc-20240605;
        b=DLnuMJocsWnUD5bkZ2UrkeCV9LmwVybYq0zLScGwCQIORPtJJHfGcLE+cr3pG/M1oz
         RFJ7TjoLcMGKzONhXY0VbcR0e2p/nAXtgk84wUM2R2E8pB3NoXGfllLCj3h/hkdFB+ql
         5lEvF4H1fLpXwLcR+xM82el3NAfadDvnlUR4N7Rc0H8kNCvCRZcsAfD3Q8MQ/5e6G0Hw
         bgS1wRZGIeK7ipEbonXCcdX5ZERaa0PJPDqY5sHAVB5wvHQ8rmsDylNSsf8LwqO4DJc9
         XjxfFzUb5o7AIheiNAPUeodb47D1bnodfRzaeCorWDlwBgHqWnGVnv9ReGDFVWzwE7Hi
         o4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8YJhd9gU2EuvqoJa544eSxYDsSx04FnxayPZrRsaKA=;
        fh=G7T91DM+IJD7N449WJQR/xVG8VUQrxsh9mw03iisrxE=;
        b=KGVraCGJlStY5692f8J9I4+JxbbfIIX6zIEMEy12C1/3du0sE9TpCO3UvF5w3A77TY
         +WJA4Ev0wvDeCUJfoi3bT520KMiHZ7abBLB+UxyGkKgo/CF9WDo2KwzLeEy2+5o4enFQ
         L6hDzQJPyW0R3Q00y9eMbDSvpysSo6fqOSywr4HqT4t0MeXTSpxo6dMUlQNBjogjEo8k
         HbQlBw90FDKkf/yVyrfJ8tmMZ+h77uTbfqwLq31eAvNMq9dy4b/vvhRvXDWlo0t4yjC2
         vEuex2VAvmPS6SLCJsclc0lO2rA5h5UAIZYiK1aDxU92JZyC0O1aAq2K+KdQOuLzxKpd
         de8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773320009; x=1773924809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8YJhd9gU2EuvqoJa544eSxYDsSx04FnxayPZrRsaKA=;
        b=QAucDxXKECQDJsSUSRU11tUioHzBoCISUI0l1EoO6cXwjA0sGvj5Hrlfg4KB2Uz0ww
         Cl3L2AaMMfOkGp63MXGmnB6EpVfy6ebrq7Nknwn0VotmN9+PRecJ+29zwT4N/T/qq92i
         7f1r714VwV97rQwbxGksvfgRu42B2UD+WBpYn3FgqXbeHEG+ai9eAAswwGAQau88apOh
         xCi98k4g8Vv4v0ZnjEIIn97ngGhScQG8cCWHEjShzRt8ZaHrPjQHtHXjIHJiybqxVsEM
         Ju5ZV0gJzlNdpKhTO9OzLQcNMfVCteSTjdULOfL7h5kpzzlNsqjaV+0F+odpzadbusds
         dUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773320009; x=1773924809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8YJhd9gU2EuvqoJa544eSxYDsSx04FnxayPZrRsaKA=;
        b=TB2mCd8mYR4yFD/sYSZaiOK/MDrpJy9irkLsIzGdUaYS+oCIhBxceWmWCUhvfOIA3P
         YrRMcYAmr18m2Bkm02o0VPj7wOl75YJpAgFfTssA0XoQ0LH5BWqxeK30OK9KXKjJN6sT
         bM+k91MQhLuk/tj/61Fw7weUWMSSsSs7aHTyMDDnkTuiaqUbgH7x9gJzG9xZc4CZbNRL
         sWIdYLz3NTyE7hZw8XusfjxTtoWCyYCdmv05jj7a27k1Ci9W9bn/jjhpskSUgoAlZPvy
         Us42Gwd+DKbFMvmUCE80C0AYiJ3XtYrjZBiS+wQolSJ/gdgRSG44iKy3/Kc9WjtufMxe
         vjuA==
X-Gm-Message-State: AOJu0YwryMWzyP2PYP9lxnq8sZ4rLzu/P6R3RtIo1Gad9PDiIVfZLjfR
	MsvhPrVAIttj9HvG4MI1VM+VCjgIIMfcDVVMU1sq21qQmR+9dTYTIah/3vrO9KJGYUHGIpTusey
	slmc+ItWDgNoukpRGR1Q6VKBEi4MJdaGLC8S0E1Dj
X-Gm-Gg: ATEYQzzjamAehWqATVjizbGoGwx57BjqMkYQYMFocQf+K6fG57gyik58sIFigUgTTBm
	PhJcE3ViQlIMxpJxG1jeP6YV+d1nUvIm008Cr35O0A48GUpyV1Ujxwg5dAsulyXvxNyNrNEP8Z9
	qszf8ZdmABuS8DeHrRclfc7DmFSC5OS0dqTHdpNwpvEdrLtU1a39IB/YUzwyRdoE7cR6L4pUYkQ
	z/8XucK0+9g/SD9Hn/wZoXWP1DJ+BU/JRtqse37SiIOzvCpZs5dnErRkq2vi1XruNtV/KVWrwg+
	ulfoaM4q
X-Received: by 2002:a05:622a:1444:b0:509:1d4b:f860 with SMTP id
 d75a77b69052e-5093a17bd2amr74313571cf.58.1773320008905; Thu, 12 Mar 2026
 05:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312124807.186341-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260312124807.186341-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 13:53:16 +0100
X-Gm-Features: AaiRm51C8JKaShcVCmTj8WnlFo47h4RuGaQUwtBwhV3ZwNIzVoTZf9wylwESeOc
Message-ID: <CANn89i+urEcFJkOsE9_3nOzVa2Ee1sFb26vrNnJV-jW2z76y2w@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: remove redundant memset in hot paths
 with CONFIG_INIT_STACK_ALL_ZERO
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267052-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: E6CCD272083
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 1:48=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> Modern compilers with CONFIG_INIT_STACK_ALL_ZERO enabled
> (-ftrivial-auto-var-init=3Dzero) automatically zero-initialize all stack
> variables via `rep stos` in the function prologue. However, the compiler
> cannot eliminate explicit memset() calls on those same variables,
> resulting in redundant zeroing of the same memory region.
>
> Replace explicit memset() with `=3D {0}` initializers for stack variables
> in TCP hot path functions. With `=3D {0}`, the compiler recognizes a sing=
le
> initialization and generates only one zeroing sequence, whereas a
> separate memset() after declaration always produces a second `rep stos`.

No sorry. It seems you missed

commit cfcceb7a39fc10a6f896af8229bf81d96acb22cc
Author: Keita Morisaki <kmta1236@gmail.com>
Date:   Wed Mar 4 20:15:17 2026 +0900

    tcp: shrink per-packet memset in __tcp_transmit_skb()

No need to resend your patch, I do not think it is a good idea.

