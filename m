Return-Path: <netdev+bounces-298748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7nfxNnM9LGrYOAQAu9opvQ
	(envelope-from <netdev+bounces-298748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:10:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D906967B3A7
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:10:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=I1+Zi4XZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298748-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298748-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 050423002525
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41DD403EA0;
	Fri, 12 Jun 2026 17:10:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F4348C70
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:10:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284206; cv=pass; b=as6bNY6AUzGD9XOynTLLaujNKwBR6KFRPVxHFguG+VY8osZcMnq4SFRrvLEpQ1YuAj/TC1ZXyy5OZ+J00VSOgODxzWmXCVr8eoPPcl1vpVYkdut9chSZLsJjVulKQUWQunXkxD9ustOuglpVPRCWOqZi+iWPPPTdOiJ4DggxdIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284206; c=relaxed/simple;
	bh=YKWWA8HN/7LM+Kslx5n3GFPqlJF8ctu6GvvxJUabjrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mK/7f8yYBy88509i1vyA/kXBzqsTbFf8FlOSKRkIvdhPa0Py3GJkxhXeS11H/N7Ubaq6XRt2493V3jQQfwB5QVWzPYyJ01Qu1E9Ts4G8xVKC4u4g7PLBLKbpXdJbDFgR+t0MDpWICM5hukl/OscAQQUnnLZlm3GWAgZX72rAdnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1+Zi4XZ; arc=pass smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso1052684a91.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781284205; cv=none;
        d=google.com; s=arc-20240605;
        b=DBR5iiv4G2FljidKO+mTzb0AZNCE7ZmjIsnOIq/iGU5RkbQinTSykZm+Y3pCA+ak2l
         P1EWJcL9H5EsA+eTnTVamJukmCPC3kiVRLnzxcmXjQy1gObkL6G+XKrjw2fx3Z8DKXii
         SB5dqJm2+VhwwLZ9lTmHSJ4UE5JHXvrOHi/2WvfVQd5uslE/2fAg34t58vQHCsA3GpNd
         p/gtSDdjT/YjmxWTscbBf3P7YSGV7CwSCbB8XuwN0xUojGFo/g+IxmaTPqFezp/HOxG2
         ZWn88G9KWYIJDVmk7kVN3FJ0pEfeuN8Vs4/fgXao9cLUrSnmGRJJVqP1I9EfjKRbJHm0
         7Hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nDX6t2X+QHHxQFviKq3UoU1UcseXTprmkcNTRxD96mA=;
        fh=x70cdqJ5DRp6lTIOzI4/3e3+Sgnb7Jd5YcYEA8V/mSc=;
        b=D7qOYIKJcr8p+XQgBZnljHmoF3ahEIy6upejolCWoyQZYI74dDB9+/hv/gmrNOTbrw
         N5s6iwRsPh4xNy0Kcr96WAFvAfHg8+qSoxJfW1ULFtlddSywptGqnvri6gIz10mptEWH
         PTHB3hNRuEaDH5FKzOQX1U0l37AJjJBUNu2JTUKrixNhz/xWefrCtR54P/Rz2xaeGxm1
         wWxyC968Y1bWV9kThXT6HxC1n5JbijcHKeoUfF0ZWepK1pSxtrqlD4u4RWhPHWMAnD7O
         iP6P5ajbrlAms6rGrTg54TFIQl7mj+ctofFuAJcqptTxFc1SHSg0HDAalsV19gZA46mh
         uG5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781284205; x=1781889005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDX6t2X+QHHxQFviKq3UoU1UcseXTprmkcNTRxD96mA=;
        b=I1+Zi4XZYPbd6/vuqeQM+ytqnwbHnJcXmu0iwaFPvzApf1sjqqaX17FdXTxlIp4mPx
         rM27daPEW5rLeTavd+I7qLqBnxqtnwG6fCrRWENZ8rr8knjlT1smCIGstXOx5CoOyAlH
         iYCeMVIO4PQDE3KReq2cHXOM+T18MYObDsnGPVVBAUYpq+uaARLaZa8JSClUUSRVNi6R
         WCVrZJhTsDcPuN8pzWYSlsDqwcMpdyOHYtouoX89YiY2cp0Qs8AinToJtXGb3nJJah26
         oSsJEC9TdJtOu3H55m8iAw8FFupKF67QUgd3q/0wBKjgww3AmB+zvizMkukj4f6I/8ch
         jojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781284205; x=1781889005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nDX6t2X+QHHxQFviKq3UoU1UcseXTprmkcNTRxD96mA=;
        b=VB/ovw8SYGu53QSXhkB9j1WS5qNDbeO/lCDBMuD4tZ7Ca2bGP8oyTdm9HkEayiXBqJ
         BCU3oqAM+LYNIzVkpJyMDEx9b/pdTB2Zx+94Fb2Al1AJOzBdJ8JQP95XWpd+yU60358c
         XjJaRqa4b93jum71XLmzPQoVd7r8ewa66tZLtu3mKJx00cPt90WEA4QKLMM9lrWCrhiN
         OIZBht1URiAXUIrgO3FGGsGLoUbg7siTrPyk4OF534p/l+RtAQUfHkmNu5Q17GjlWYDh
         wPMystswURwWIEjFjvudTJxpsiS2EEp5qRP5UJ2mQEBb/2P2OlYhqciYGisQBtpF7Cfg
         XiGA==
X-Forwarded-Encrypted: i=1; AFNElJ+DWJ0KYxrCAMnfL8GCoAvP7Ynrs/mQ9RK9aN4BHuVGLBzPzUqTim3KZGuhQpiIbmgcisqGviY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1beelmMCm+JvBRSzepcxKgVc4dVKW9svnejhcoVWFwo4yrzL
	6g+T0B3KML4XT3e6BZ7Xgm+GCiYURSFB5EoubMtRYf6gVBWyFmMtQGeScPXTLU3J10V4BoeN2mZ
	bAo1Csx1tYpq+ScSmZsjEcvXNOyY/pcLFmXko
X-Gm-Gg: Acq92OEprJGNilGbb80oa1A4VrWRF02FJ9slnCna4tGBqdJWSMexBmi9fASMPY9c4nk
	ylyog1OEQ3Irjl7ozzu83YGULdsgn0Lb2LEt/P51gqXCoBgSqEBeWuHrXgnkx8CQAwxLqP6MMLK
	VH8jJbF/c7PRXM3l0X6dWRlb0mWc5RYA7hp1dKlLm0ctFWDuZ3phre+FtcR7lLthKanDWHyMpFR
	WYtYDqYLsOf7e8nBrznWIAwAngXR501rxetM4gauJRKVUezRFyi4CCULK1Swf5CuQ5DsKMIvGb2
	5CLlyMs6q9+jkqWc7P+wheYebiZl8bw5oNtdw5us90oRgJDK/Jr/ffVGn6hEeFO2xdFINf3fKXX
	TgquY/HcJXwK/wuaYcAIwi/ls
X-Received: by 2002:a17:90b:2dca:b0:366:10f1:3d86 with SMTP id
 98e67ed59e1d1-37c2bd75872mr189256a91.22.1781284204833; Fri, 12 Jun 2026
 10:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612130919.299124-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260612130919.299124-1-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jun 2026 10:09:52 -0700
X-Gm-Features: AVVi8Cdt5YY96GuciSaCwsRw-A8ob7HHQLryVxTyFCQcmv_QVvBEG-eceoLw8Qs
Message-ID: <CAADnVQKL26zPepqOf_FtuA6ALQEtFJmiKU12iahdvfeAyJ7XhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/7] bpf, skmsg: some fixes for skmsg
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Shuah Khan <shuah@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Sechang Lim <rhkrqnwk98@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:kuniyu@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:ihor.solodrai@linux.dev,m:rhkrqnwk98@gmail.com,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,google.com,gmail.com];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-298748-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D906967B3A7

On Fri, Jun 12, 2026 at 6:09=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> All fixes are from previous patches sent by Weiming Shi, Zhang Cen,
> Kuniyuki and Sechang Lim, which have already been reviewed by me and John=
 and Jakub.
>
> https://lore.kernel.org/bpf/20260610081218.506709-2-rhkrqnwk98@gmail.com/
> https://lore.kernel.org/bpf/20260520102715.3033936-1-rollkingzzc@gmail.co=
m/
> https://lore.kernel.org/bpf/20260424190310.1520555-2-bestswngs@gmail.com/
> https://lore.kernel.org/bpf/20260424191602.1522411-3-bestswngs@gmail.com/
> https://lore.kernel.org/bpf/20260423155807.1245644-2-bestswngs@gmail.com/
> https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/
>
> The automated reviewer (sashiko) may still flag a few other potential
> issues on top of this series. After looking into them, they are either
> already covered by the patches here, or only reachable under very narrow
> conditions that require a specially crafted BPF program and an unusual
> sk_msg ring state, so they are not practical to trigger and are left out
> of this series. I'm collecting these fixes together because the same
> problems have been re-sent many times in slightly different forms, and I
> hope this series can be prioritized for merging so the duplicates can
> finally settle. With so many AI-generated patches floating around for
> these spots, leaving them unmerged just keeps wasting maintainer review
> cycles on the same issues.
>
>
> v2->v3: Target to bpf-next and carry Emil's reviewed-by tag.
>         Reverse xmas tree style is used suggested by Cong.
>         (not all code match reverse xmas tree due to variable dependency)
> v1->v2: fix problem when fix the conflict.
>

Kuniyuki,

one patch is yours. thanks.
Please help review the rest.

Thanks!

