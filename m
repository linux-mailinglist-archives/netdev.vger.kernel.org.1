Return-Path: <netdev+bounces-299954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a0CYO+m2MWqppQUAu9opvQ
	(envelope-from <netdev+bounces-299954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:49:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1F96954B0
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:49:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jrife-io.20251104.gappssmtp.com header.s=20251104 header.b=xHxAlQxY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299954-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299954-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1B24300E912
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F21D3955C4;
	Tue, 16 Jun 2026 20:49:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52D392829
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 20:49:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642980; cv=pass; b=TL91pfyHPr7vyg7p4GzYEeNqEKJf3/ECkKQJX5OorA18Ko7eaXq8yf9TM0m8/RPefXPP/4Vl+ggtQfw0LlEMm1lE4ecnVVJTF0/jSueqMRmBKKw6t+TLW5twBAtHt4/I3uvi4TjK2nIki5tZWTF8NXPRE3RYefRX7FEBmtocQF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642980; c=relaxed/simple;
	bh=fi9NlmpSEsgxURdIHjqA8/usrtI/7e3sTahEYTEgepE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Va2+HoRgj5PUFGR6YuwXWtiBPSDzwbY6LONukbptRSNxDfHMQ1X8uAZHiHfx2O09betQCkvhzwBPsmVW54MZxaBa10G4HPTbKF5drlF0NlJYjSnN6REia7XEqmgGbdQqPZUdyqgofm+A8jSpFkkT0n+YMhIOkO9yxFZESYVHQmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=xHxAlQxY; arc=pass smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8d34c62765aso9998796d6.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781642978; cv=none;
        d=google.com; s=arc-20240605;
        b=ON4u2wh+pbS23wzmsO7zSqIoZ9+QHHk9usboVi2UDM47jrbIBZQ7qhKjZdfXaxRQ5S
         8SrTR6Ko0gwH/Sjm/2jFWYNHk9PJ53LWmOvHz2pZ5KH2odRTgUGjvZ73pm9HMK3wpov8
         vw3mvXMnTQI32qXEpZMkBpVf0Os9MoibtlvVfUApHId+e4Gmf0YSRCnH6iKJ3gkIEuGX
         Gvf/YwJDNP703hvxin84YcLw9kHokgtQfyefTsElSZQl78E7pAHETVa6aO8GTEF0TBiA
         p6+LF2jNQ6oQ+Jppb5AkXQN9AR/Tw5Gt8Z9zTXoyKXSHOlBDrgBtx7fy7KOyqHMejwXB
         oT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fi9NlmpSEsgxURdIHjqA8/usrtI/7e3sTahEYTEgepE=;
        fh=lbyFrSmy/ECKBqhmNuOm5ZSBglx1Fz0Svk3t2p4i1W4=;
        b=IV7FLunUgjleCcAWeW4GM+ehmhe8WY7JGYmXI6itF7qJlQLGjyJ7gFVDHvVe4z1cGx
         ibjgXnlbkMvO3edrFet1zzvtvEv2k1jPevedsthEM2AtKlVMbYz7b6AJYnt11yW8x9DV
         ny1dxvIbCWn+q1kF92mTgbL5oKOaAfoCr43IoYt+gfbkpsly/1GXgjXpMrVPhaxLDUZv
         aKMwu9z20up6dVnqlwq0k8Zper/Rfks+NtBnJY1WdZ2M7I3/IZYtifA/K7uxuTWgXu3m
         clV3uRvwIAEJbcpM2t1BDJ5XwCB9W1t+TZazywS8VBMwzEBaRXV5Z/gJUnxrxWKXyFQ0
         l9iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781642978; x=1782247778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fi9NlmpSEsgxURdIHjqA8/usrtI/7e3sTahEYTEgepE=;
        b=xHxAlQxYxAxSkOD2tl/gJExFZiinPk/Ux69leEhIgv7g8y0PApBQRkXPhu8WJ1Ectn
         ji1j5RL2as6QqLzbATSyJ0MSWx/I+C9U0TfeFzDAhgIlY1nbpc1R5DVweEP08ftWm0nK
         2tQy9i3g/vQCoV+oQorEonjK61QDqHfuCTrs6hfv4P5YqkvvAlBs4bAaVuDskzU5t1Sl
         4/1klFfRUZPIwb38ev2jpLQQxGXaESMgpo4QCInQSd2W1hu5AN+dhYVeYersD4EDrD5i
         +h7AXAXiSgYBDTD6fHPrl+8z7rNeJGhRj6/9DDNzT9C4c57bmOAAfACZk/XTR8CA9WHd
         HpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642978; x=1782247778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi9NlmpSEsgxURdIHjqA8/usrtI/7e3sTahEYTEgepE=;
        b=nLN3EtsPt9cjX3TZU7uuDEja3PwaVHkMKJ1b02ppr1it7y1kD63kr6Ws9Y9JuIEY0j
         95n2b6s2L7QUCqB0Sgsnz0W9ZMI28xfqXsx16VSr+vLcmZO6ZOuhFRVuKkAUZnpUDBnA
         C+c0rzpaBEEmG27lIFgDlKc7sVCWkvY+yvSxeJxOYOu/USNci1/hG+iOkj2v4EkHY4Gq
         2uD9dqNF+BaLJ6cRMs0a/ilNe8yxHC3jGPeA8R0j6WWf0mOc9Dq/LVvww/ZBxXwjZ19M
         eQoUMJAz03RBGzPN9E1tFsi3gOiqFYCtK7srNK3TmlYMWRAOCU2Wlin6IFxjyyCrAVPF
         5zjg==
X-Forwarded-Encrypted: i=1; AFNElJ9XRAQORfql1G48V1JUWzZaZBydNqcdrB0ZpEt3LaGayA17SLF6LD7wZzc6LbL1bAnN1J4eHlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSoff3bGyI6vP0MiR/3wShgNswwAsxH/NH2VvFPlogJ9flfg4b
	fSA6M8yHCitN9TS/Z+VhGFvq1U8eCtgbWa2dF03G9FQlgCF16MCXGdvtJHqOkQgrzHWoVydhjDy
	A6/h+WaYWDiPvMIXlM/uYkI446fVSJhK7FcOxCqmL1Q==
X-Gm-Gg: Acq92OE3dITncLF8iDyHaDnJoWQ+klq9BAT5uhw9v0w6YtD9TSudy7ZG4O6X2qcgo6q
	oDKM1tmYvOvn886NUWnENlUIer4Oa7y+AyQoh0lTalPo+ExSaQY2wDJyFj+YjQKMz3hBTGgneHf
	ycJkcfFoWVS9ghCOa8gjUqOwY9qzgn3v5UAJJZq3XyANQCo3WuScGkW4TyxfcXbLHiYsjdbrjdp
	eS3jfSYjqlJxzM5PPdnfze2YZjajSb8ZP1/7VP03L3JYGB49GD1jdStqOg8xrzroDi+f4EaGzTR
	ufwNYJnmolajF/qA6X42xt9do7cSYPRdGjxb8g==
X-Received: by 2002:a05:6214:451a:b0:8cd:290e:fec8 with SMTP id
 6a1803df08f44-8db8287818bmr8274236d6.6.1781642977678; Tue, 16 Jun 2026
 13:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613183424.1198073-1-jordan@jrife.io> <ajAXF8Nvg91xU4f2@mail.gmail.com>
In-Reply-To: <ajAXF8Nvg91xU4f2@mail.gmail.com>
From: Jordan Rife <jordan@jrife.io>
Date: Tue, 16 Jun 2026 13:49:26 -0700
X-Gm-Features: AVVi8Cfx8fbEJTI1TOk8TlTWVB1lG2JC-U4g3T960cHMQ3Qo-FGba4ycLv-LuB4
Message-ID: <CABi4-ogYKX9T_gWcXsKSs5-y=3GA_WqwfyjobmCxexTtQ_H86w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[jrife-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul.chaignon@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-299954-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[jrife.io];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[jrife-io.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD1F96954B0

> IMO, calling it BPF_F_EGRESS would be less confusing. It's a shame we
> can't have the same flag API between bpf_redirect() and
> bpf_redirect_peer(), but this is creating inconsistent semantics for
> the terms egress/ingress across the two helpers.

Yeah, one annoying thing about BPF_F_EGRESS is that it would only
apply to bpf_redirect_peer, so you still have inconsistencies across
helpers. Perhaps this is less weird than having BPF_F_INGRESS perform
an egress redirection though.

Jordan

