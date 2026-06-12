Return-Path: <netdev+bounces-298482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id viHULLqvK2ptBwQAu9opvQ
	(envelope-from <netdev+bounces-298482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:05:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7EF67719B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:05:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WFB828DK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298482-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298482-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1954308D691
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751B13D9DB0;
	Fri, 12 Jun 2026 07:05:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49A226CFE
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:05:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247919; cv=pass; b=aHkSFb3HEMZTYluwUyScX5hZRtR/92bmPYDj8xUIn60OJEr3qGoV6pucxtMXTLMP54cGZiv5tFfSR0ln4hdDLsf43hqbpk2AKX0AhZf5gg26EwGtVj/DZ52O8p5v9nnrgSoDkuXEtdY9QnI0EMHtoDQQE6ZWrCnZQion5jbLYE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247919; c=relaxed/simple;
	bh=+Qls2skSc/3vmZca9FbusO2tssEcMmdJgi9u1ZaRRZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhCXmicmWMtv3MbtQtvM/ZaD5wiHEOCOihBIvlgm78ADtbhVAe/Zl37OBJ618ziSN0FDiSn00UbabyMd0sgRqZZ2FUCIgsFMyLONfmyryBYnRkb7BIBjLtoptT1P3gJMNqCRGo9iFS/KQ+zX22sswctBWzKLzeRexyeTrWAIQpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WFB828DK; arc=pass smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-138129a622dso1227164c88.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247917; cv=none;
        d=google.com; s=arc-20240605;
        b=lYJUY+cfvVbsQg9JjhTmXtTP2hyY30VuyJEXTSh67COocdo4eYr+nwcDymNvK0gSR0
         Ml3qrXn1Ekz89IiKQZ1qMxS/dvaHtf1ok9CNpdI3bRItsBM+iPfT/KfcHe88Y9zDyHue
         BhTG1KyLGe+NWJYwRFN++fCIxlncSWMww8AyUlR4RhQO/Z6ZTzRPTSUyskgE5KxhiHfJ
         21iC3FvxfjuzmY930dHgVWgr0nmhMonavdG82K3pv5HlWgOnnpkFeIxWRwWnxJT3ar4F
         25Um8w8SxPSh468PQn+9l8HU5G3mHyEntrX/cX/EGGjEgr1JzgUMvVPxHalKkoq4m2Ds
         KoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ySAFFGZVCImVoCKxPs5cex2u/fdf51xmls8xn6ywiMk=;
        fh=b0ajODJVDuJTvOeuJI5buvh8n7AevgSgoQws/eYIXH4=;
        b=J/dX9Jo9rCgQhUcpaHvTap5gd4FgHqS6+xmpPVRei7diY4wXt+jmbB2UIV3hWo6dRC
         NdMNYYL5gFDG4BUbXMz76coCEh1aWmPfoFuo83Be2u0HcN3KoXG544ldnr5Ii1KVy9X/
         +yxxOA2PrjnuKwxLC4qmV0jq98EQsqiePkXiQ0jSTMXdLNRUAvnfdZAUIptTu4+feb8r
         qYVysc46uSzz+xNvHCqeaieIqysZnCPni373tnzyC7x1EnJ1yDsu+PSawlDAcZLpVe02
         cmdnfX7uICerW2Vt7JbGAK+rz37gmfatVQlm6NBk5INJwq0n95XatDIvhJzOm9hS0wC3
         n2Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781247917; x=1781852717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySAFFGZVCImVoCKxPs5cex2u/fdf51xmls8xn6ywiMk=;
        b=WFB828DKoccgIhySSPU7wejmWYVU730jQnhrxaapKrkBfLAYloyJc6YpDVjPcX6aaj
         kciqaVa3gTWP5h5+RpY7z7oo7wBBcaDZr6x6dIWZ7qBwXNgvEfOthCoRu8cydPVkANa+
         gADhYoZ8f3lZfwSfp3JoWGENblyyMVU/ffLcUmJgTDJ5suAyef1lqePCdWAQ67labEXz
         wUUxlA2rvRQMWH9kRAVR6sUWR9Zrp/q77VM2oBV5ob7sG4VhVyDSTwcYBGVL9ZB3IgLu
         F7KW1sqR12eRphYlFSNAT9D194L+WEAGUqtyMbn+8dCIhGi7+tjPewOYI/KhkKQDE6yy
         vL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247917; x=1781852717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySAFFGZVCImVoCKxPs5cex2u/fdf51xmls8xn6ywiMk=;
        b=QnKrXzBEbwkSBAq7q5jAsiuSW8mvbmZwZ6KvytEIUM3g1hStAR/MKcHudHRzRHXnwa
         OPTqtWwkcDIkI1U1cGg+6huZOmJ2RCimh/bMZzsEFdu38pEAre4UneIYG+BWoX27uD5E
         mmjtwm6t5fxey1dKTAjRtZaBbCgzEJTfHeqeEDbIc/XPPrxKEX5NxQXwyscwf27/izLX
         WENrKSr2KMNJbrVS5F2/5YzzTSeZ+Ge6mPJCUU+3EM2nL4TGc3eaLl8m+5FGn9wx9ujf
         02GydeX2+m2sxtPvcTPBQAuBWaqwsIrfyUZRbo3RxvVtiMN1YNTiLPWLP6/nNhpZl2tG
         HDhw==
X-Forwarded-Encrypted: i=1; AFNElJ/micI2T0bs7Y/v30kv4myiwhiDiC12gS4hAZfrP4YOudfCImwuO3Nhe3HzBe2K5VJKw9bJm8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0veRG6J9k+/yFG6Qt5wrTi3V4F1Y2bwLvjo+DimKGuKjcmPH
	i2wbqREo4WtIWLYvKwTrrsXEYH9XKp53gjEy2lj+q0YL2fsYtcphJQ2tMCx0kRIJs2TzEI6Xz6y
	nohYBaUOj1aJEKhbVGRloVEVOiCT57bmFcxm8HOkh
X-Gm-Gg: Acq92OECjeEz6A2n9QezUxItXWkBFvtlgmdHEdNcb4IjCs2yGpDYoMNmxefxBR6OD+a
	Vi2xw0G01XWONf5rq2rE17FtkOOdoxo1T55en5+elr7sn2kGsQi0L2tuIBCKeDrhCiLlvgzwesR
	RAd8ehPK0E0RINPOvTpXVc/eqXhIQUv3BUViSPZ9T/orkSLSbZYSYZpvkOkNaQMOy9EA+QXnGQ7
	Nwz7rljy+jQYdkdWE/IyNLOqMQycTpI7Yww896Jg5ijqnlfzJ+J8RlgCluMeinAXxDoB7l+lAOv
	Yxw3AJFMaA+Tyc+qeKr1S7LbeSNXqCW6ebeO1VkhE7aJ7g24mFTBZiFf8dPwvsiK+LDips+mqNn
	jOcrZtm2okuU9pWKf3cp+uV1ODHdD0pXj0z9mteIlg3cUJ1Lv9X3a
X-Received: by 2002:a05:7022:f82:b0:12d:d972:b96e with SMTP id
 a92af1059eb24-1384bba8b3amr736453c88.20.1781247915492; Fri, 12 Jun 2026
 00:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 00:05:03 -0700
X-Gm-Features: AVVi8Ccmokh-rVUbp9NLMiWL4MP-Zle5S0yShB9T0PhjR4_ZLN2X0FgYOQboXjs
Message-ID: <CAAVpQUBL1pFxgVtNjM=YcWuE7YfvBpUf65WBpUBzjVZJgz=hTw@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: clear sock_ops cb flags before force-closing
 a child socket
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:edumazet@google.com,m:ncardwell@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brakmo@fb.com,m:ast@kernel.org,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298482-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C7EF67719B

On Thu, Jun 11, 2026 at 2:29=E2=80=AFAM Sechang Lim <rhkrqnwk98@gmail.com> =
wrote:
>
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.
>
> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state(=
)
> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me()=
:
>
>   WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
>   RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
>   Call Trace:
>    <IRQ>
>    tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
>    tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
>    tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
>    tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
>    </IRQ>
>
> The child is freed before it is ever established, so it should run no
> sock_ops callback. Clear its cb flags in inet_csk_prepare_for_destroy_soc=
k(),
> the common point for the IPv4, IPv6 and chtls forced-close paths and for =
the
> MPTCP ->syn_recv_sock() failure path (dispose_child), which reaches tcp_d=
one()
> on a child that was never established too.
>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

