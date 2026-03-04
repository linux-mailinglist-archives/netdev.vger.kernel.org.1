Return-Path: <netdev+bounces-263549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKIMLnCVp2m5iQAAu9opvQ
	(envelope-from <netdev+bounces-263549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:14:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 165C91F9CF5
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C8693013A8F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0093307AC6;
	Wed,  4 Mar 2026 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFbpVvvC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E61272E56
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772590434; cv=pass; b=nkAdwIdaI2jB9hyqSHhESeBNmmM3ehiLO+oYg9R3oNCxj1VrkhnnfP83Ww/LnwFzZ3JgP1D0pEeNe+4q65TOI3mmBcSZUllGh/pG7nqCti6li9UBgnNgq8IzgSFiBSanGX0hudeQQgju/FZXEaac6DlLgnOejX1QK1hnCXJpVrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772590434; c=relaxed/simple;
	bh=pFkEJeClKjdibxifE/WSrzJX/EaYS9djcq3LhPiWQkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qK/14mOJdozOUVq91xZoL8JM/gop+U58zGhV7nEQ0eaKcCsGBxlegbmmE7RzSzYVl9k43YMo24XyghbnR9FAoeEN7ZsHSWtIlmN7E2THWTiYa0TJapz/h1MhX4CCimJmBt6JJtd7pPIYvFQuCQFAv2ShVAU5gvo4de/uJs8Y08c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SFbpVvvC; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7927261a3acso55515857b3.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 18:13:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772590433; cv=none;
        d=google.com; s=arc-20240605;
        b=ALzVXqOtqMC8nGFbAps5IqJ4WK+ayg60He2zQM75vEP+C7jqsS+bgGcqvkPveRCYHu
         Gz9T//3PGPew4pLWi12h8hVhE3lA3q0NUbOXqia0Fvi2FvPN2mXuhP00+MYQRn1weJZZ
         QHWH88YKq353zEu8qOy7IBCjDX1wIO2skqUs8c98qIzdFpTTGshqPMAOTt7RFekuuh+3
         OhFc7hf9u8HfPW2KUJiUgolktO0wJrTDRaG/c0XsJwcMQh2HT5oNi46DLXv5qMTbRQhU
         WXxZ0v3T5xABgx8XljSoF1Pb+S1ZeH+NAo9vjXmr6mxLS/tYhsAqjr+6POmk5thxlRcv
         ZidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5n3bHcDFEp2p06j2yezC+YzulJBAea9XpQ9Jrj9f/As=;
        fh=HC9YaLqqeLKv99Hgg/7a5NRj5KMv993MKUpZfzobVhQ=;
        b=D0K7HUcNuKWRmjTUQ1AApWl2vlfnzvqA4FC9KXYTHBEQSF76K7ocsaEtQ+aPOqoksE
         8BJGUOMQ0bUYGTBLl7ef3cyIlpEfLoeLiJFGHuKh3NKKQAlMyoFKNH/piZAFWAFFCDaL
         R3opUM7yx1yqfzbA172usb0ycDbxqL7oKTRqIXwYiMEGMrcKlq+U/sc86W5C9laXH5HU
         q7G3IX7rZFGm9MfdL/8qJIDSLqfiwjUOjNYaK1WusryWjhsATpATytaQZJJrSq9kKpXv
         9oJvS9nm8MkKzrKZ8SLoguNyuMHBKOZDra7sns3eHZpS4dlihuWCpsg7fPc0Bhn+Bcgi
         U4VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772590432; x=1773195232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n3bHcDFEp2p06j2yezC+YzulJBAea9XpQ9Jrj9f/As=;
        b=SFbpVvvCZ9iC/yDckYrH+YFmTjJOC2g8dey10gqRQ4+FV9Fu95YKaBY2jKSUfqIlI+
         wa15GDr4lhS9OqDQG6vgjf4BskStpER5e+qwIWLrrY/QJvNRDAgXEvZ3rmxoA8pTuEQE
         uWYBfxry+4AFEvkvErqzSNfDu3f3gFLsCffv+KOhIEkb0b/C36xJIBdE0WV+bCTSITxg
         72PkrUjFA9HNfh3YHgoU+khHJT2baCOYG/tHM7S+9gyEh2/bzSs0fDMpXd59cmzVAnt5
         le6MKXGEPbC5ZvkMSno4ZijDaFxYoUDofJKpZwE1vCiIzCt35P9Wkydn4T5KX7IZHkji
         FoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772590432; x=1773195232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5n3bHcDFEp2p06j2yezC+YzulJBAea9XpQ9Jrj9f/As=;
        b=IBFirH3YfvarN7tLQwmkHsvp5lf42GWzQ8rAIziueIejNj722dXVq1u8vtPh7pXzcx
         PwdP9BHLCL0RGAipCOEym4ix0VlTMMh0NuYz5u5/4qLDvvgVDL7S5E/DSrT9W18+MBuP
         f5RKVI1OvtCmbWfGlceCCXVFTIy7r2l/FJFPnTOJMOwmeVSSPg8QlgfXaNTg8Zt7k0m3
         1I784uCQSsph3vTbNtuVeQijWGaJh9pc1FXOYkYlrBwiJlpVoaahaoPeK4SLyHDRyML1
         BJ7/2CEPbf2tEyvUTPrtNkA8D21HK7wqmON39aK4PkBdEsS6eRiebru7HankzAzJSfU8
         l3ig==
X-Forwarded-Encrypted: i=1; AJvYcCWJM9vUqj0uRq0i5KHwbVHtuXXQT7YN8ukJkvjnBDOUj94IiUDGvkvT7xtyibcyGPXiYgTEJOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI0s7oaIzvlRu7CdYLyPZGkost/58qyCsG6tCOrZpTfxHHqOTO
	szukwMuwfm9YeUM77GclMQmJp8POJoR1J6BJnl3wirfRSRE0Ms8uJ4Ael4imyZLaJFj9i3wCbnv
	UaFvsDcx2F90YGpFzbPKnv6k75izQ9RY7GNhvWb50
X-Gm-Gg: ATEYQzx+Cqp7zG/+o1Hu1poaS0ffOMytgggcV2NHvvGLCexukaDCZB6sqfNs+6SeV1+
	VTEtUgc15zusBlrXGGweKb+pJ1vrwoozVl6LB29PJxJZQvyR4T37PsXEQY+eoT4NXb0uUKuIB73
	x/3kB/4/VoOirR2eOmRNjPdPqDKnXQ10RYiqIY2MOqJqqqeI8sJ9W4Dtn0Wu8FZ5uHBN/tolU80
	Q4VXoi1DRvkqeO+fhuhjYbFQyA6xOi8uV8ibYYFt7tM4Yu6YorjVkQcymF/Y63mY6//f40HLbxr
	KbKgDV+x6xG6md8NLfA=
X-Received: by 2002:a05:690c:ec5:b0:796:3dce:d098 with SMTP id
 00721157ae682-798c6bde352mr4451747b3.17.1772590432169; Tue, 03 Mar 2026
 18:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302154201.1621117-1-edumazet@google.com> <20260303170841.218b0816@kernel.org>
In-Reply-To: <20260303170841.218b0816@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 03:13:40 +0100
X-Gm-Features: AaiRm50bdbPZAyAXMxdOI9CYYDZ6jsLwgEU1C500QrPnsbwGLJpQqmVk_0NIpYE
Message-ID: <CANn89iKBDxAqT4MGGuQ8xxXjbNRo7HadXoYYq5QpyP0S_4rfTA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add IPV6_CALL() helper
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 165C91F9CF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com,nvidia.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-263549-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 2:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  2 Mar 2026 15:42:01 +0000 Eric Dumazet wrote:
> > ipv6_stub use is racy, we should add READ_ONCE() and WRITE_ONCE(),
> > even if this pointer can only change once.
> >
> > Add IPV6_CALL() macro to factorize the READ_ONCE(), and perform
> > direct calls when CONFIG_IPV6=3Dy.
>
> Does not apply to net-next.
> It sounds like we're going to remove IPV6=3Dm, however, perhaps transform
> this patch into that removal?

This seems orthogonal, unless the plan is to force IPV6=3Dy ?

