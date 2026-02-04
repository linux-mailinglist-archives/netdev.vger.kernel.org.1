Return-Path: <netdev+bounces-256494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PlvByKTgmnYWQMAu9opvQ
	(envelope-from <netdev+bounces-256494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:30:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77977E004D
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 238BA30CC68D
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56082156C6A;
	Wed,  4 Feb 2026 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnhLTaGG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DF038D
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165023; cv=pass; b=PKL1XxLICYTrCCR8PE8GvGMqpSB3LoN4T8XJMlee5OQ2iHrFCuKTVxuIKOSc5d7+jS996ZncPj8XNpavKIB4X0UR9T0EItFA9ru24w3MBoK624wsRd+Bk8fWqU7fFWmSOtrireVQDi6PoYTpLaXNIEumfzLVJ4perDTcY2NTXz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165023; c=relaxed/simple;
	bh=GsssjGcvi+aDiMGNhJzUp7iKtWbA0SYhQfyog3Cb41A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u22GGz7UI9CkBIisqbpP/WJhiHnKZ32xcmw8neWjRGje37Y2ed7VnEU9fWkjqXOKwHDlMz6wPRi1wkf/c9Xz+KxeK4ntU8cAqyy0UnfjylmNO8j0iylMf/fQmJnGx6oAYWgOHbq1CUGr+hVISeBHkGWLC+WUYJ2YJWVlMjZtZ7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnhLTaGG; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233c155a42so10279018c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 16:30:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770165021; cv=none;
        d=google.com; s=arc-20240605;
        b=RioWIFi0WgF8/IF0SYuq7qMgtHNzgr6I0SI5QNl1OOXYpB6F0vZ5n6r0cTjnQOiPHC
         L+IVss639fYEBV/PHSrTStI5K77VWY8+mo255nnA++DX5hkAB079EV1j83s0Egff1AjT
         Zji87f+xw4Vi4w6Jkk0TXPx0kX/54xoXPJ2l3OUqcJYRf1BaPIoIK22vxDMWN4DeQYOK
         oebcQ/xW1lfh1/v+0oZ9t7XDe/mcTtuM17Dpd1I0IQdUwy63BjQxy7SY4k+oaDrLhXMw
         jLSOnS9oIj3EwGVUnEnFTpXTQbpC9vNDn/mx1+L0PN+4uZs/RXmoRp1hgIKSAdJsulrC
         J6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhvO68AScYfvayAiJMcHA4Uc5D3lgqarn1OcYQFMB+o=;
        fh=sC+r3nfRobovVv8NUvy0gSF16gtp0oNQ+D8AbYBP4MI=;
        b=Q+1q4jUebGHYD4jicNkkX10K9nk7zICP5q8lvD6+8VzqiAQ/lL7c6QFffIJfOiUvMQ
         +EqxAu5jjFJ+GQy9N1n3vx+qtSPmaCIpiH/BSs4S10Nqe2YQDc1YI6/3OkrNjJrmrk8U
         8WsxTPofXV2TjQT2Nn7Tt9nsOpk0k0cZFVKEpP00ANJ3xgUNRtybPmvHlcb0HvTi/m/E
         WlD5X9s80s2QSLQPAjElxX564UcWiDuUTyQ4FUDelnkXVppPsGzrPNc6nU/z6PbW4iaD
         yEpkKRspHjlkjyMETZLYAjuvqZyvumibW1K7zLKCglJowQiSPlu65dCOPfx3I8LsK5M4
         AGDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770165021; x=1770769821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhvO68AScYfvayAiJMcHA4Uc5D3lgqarn1OcYQFMB+o=;
        b=mnhLTaGGK6ARpt/J1GfukjixpR971lBurB0mTfCkWgW3qeQe5Qh9h2kQgZs/q6TOZy
         /6j/8CLs5zsSqZ+5FcXMsALls5kPwbstSVD1pdcKWRGaLuZPAuZRFlwTJmsykm/lVpk2
         C6xigRUJPaMVynrfo+Dg2/N14mUrlG9h4gV092T1gs0qOXTEgYKXmZaRqbC4kJ98kYb5
         LS7C78Ors48YgEQnBNEWudFnSKfp2kX8ZEhBgTLhLs1odntUEvweloK0cuPbwrMy6hvg
         a2TMAaesOZdq8zfnPMVVJgQejy3kWsJuDeRG9mlUfS4ALiRxWiY5phlp8EQo++3YCave
         e7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770165021; x=1770769821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhvO68AScYfvayAiJMcHA4Uc5D3lgqarn1OcYQFMB+o=;
        b=AAitLILMkD7B93j9B7KKNYaKJUPQX2ujohz6BKR/9bm1LFK+NZU6JpZK92FG0YCCLZ
         +TXQn+BzLO/ED4t6lLm50AuYmF9hQaQlfECgVcwmosRu5nIu97wf+aWyF6ViPVh7JNjC
         bVmXU8BaGpcmuShSpfZc7ITjZXy7vNo07egsUKkAp20jqKgHBxJxM19OBSrEvQO3B4Q3
         R4+XiXZUAMn7tXC4PYPkW2udd6h+odXv6sFC1E5u1udn7Wg1qoG5xsWZmze3EUUmgFut
         ETRPGwc2OBoN8jm7LpxVl8+s5r/o4zq5xzUOHw73PZdwjA6/dCSLfKc/XpNf/EsMjEzv
         AjDg==
X-Forwarded-Encrypted: i=1; AJvYcCXW9Pn+5pd7l+54I4S3aq0cTVHqhBRdGYNFpUlfNcEHddEVzgNkqrTs0u0d0aQ+331L/fp7QEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8xGjk4LJ3nmSg2XsyHuKHKG7hQoGiFUjtIMKgXi49Mu6HvKqL
	oSFvR8idbb42boX/QxTWfNiNnljNbPdHLhX2o/VKIiJQ5PIePoEnHKmh40pC9j75J1bZ/o0YNMX
	ZSamGbaRsElucdyto1K+TYmUzMsvP/30T0wZYwP9o
X-Gm-Gg: AZuq6aLb9i9MIG7j0k5iqprRPSVw7ATx0WKKWu8If9f1A8Bm8DpvMS/WKbh1aGn8Rh8
	cr78Q7YIticnBmx8ps1RF7DfIXZEJL5/zAe/TxGAiPm1xl6SFddrEFReZiIy+FugSIYWsg2P8Vm
	VuupvE501+2yW7Uyh67Z4dUvDt7WeiKCxb2wQ2704VKhDFlMRPyron8i7WgHgkfgGy0KKOpx9Jc
	vtYWBrbUYO9yAF/gWcSva0S08YJYgOsTsA9cbpp67tJFKJPxS3wJ8qyGAkVyFhq5ykVzDMccCls
	FV1QCsBywH4lnneCOvN0suVXzkr3+K/Hd8cIEBaWfGSq06UsGyPdzK1k7g==
X-Received: by 2002:a05:7022:7a2:b0:11d:f44d:401d with SMTP id
 a92af1059eb24-126f479b250mr604379c88.22.1770165020589; Tue, 03 Feb 2026
 16:30:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203050932.3522221-1-edumazet@google.com>
In-Reply-To: <20260203050932.3522221-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Feb 2026 16:30:08 -0800
X-Gm-Features: AZwV_QhYjSPVP9CS9LZlb0WTQpxijnEdd1IcPTf7RmT2wgY7SKW9CjlvFlk3mC4
Message-ID: <CAAVpQUAvyQvZnP3E3PwyX_hRvLSbo3TVsZJaVWFTXWrpYf_9vg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: split tcp_check_space() in two parts
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256494-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmlinux.new:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77977E004D
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 9:09=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> tcp_check_space() is fat and not inlined.
>
> Move its slow path in (out of line) __tcp_check_space()
> and make tcp_check_space() an inline function for better TCP performance.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 2/2 grow/shrink: 4/0 up/down: 708/-582 (126)
> Function                                     old     new   delta
> __tcp_check_space                              -     521    +521
> tcp_rcv_established                         1860    1916     +56
> tcp_rcv_state_process                       3342    3384     +42
> tcp_event_new_data_sent                      248     286     +38
> tcp_data_snd_check                            71     106     +35
> __pfx___tcp_check_space                        -      16     +16
> __pfx_tcp_check_space                         16       -     -16
> tcp_check_space                              566       -    -566
> Total: Before=3D24896373, After=3D24896499, chg +0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

