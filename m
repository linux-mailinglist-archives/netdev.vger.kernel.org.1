Return-Path: <netdev+bounces-263612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD+xG2nZp2kRkQAAu9opvQ
	(envelope-from <netdev+bounces-263612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:04:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3F21FB5C5
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2BC63026D9C
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCB2EBDFA;
	Wed,  4 Mar 2026 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVOkm+Ru"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81C12E1E9
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607826; cv=pass; b=eo3ga8J6GJrLqgxuZXHhvcSzJ2aM2MD+7yLYAjUXMu6Tx2182ohg3efAg0L8/5xnerGbtMqBZUpeszWVv22+8ouDFRS7usOuPtwjA+hH5HOWopKJUMoTUqEkBm4daX1JmDQzwQyGAktJpvMNuPE3LKcvWzs/x01uCGnP6nctOOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607826; c=relaxed/simple;
	bh=2Fp01gcFep3ZToILpqcan7GL2j9lmuzomAm7FSANYtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJ+uro/BPwXibOdZvj3KUf5OI3Q6pVBoSJDFZQzRW9VMaMXKJxhS0l5HZD7bmfER/ZswchihZbpUEk5QLC+UCdPlfHuwTPEAYDX8sn6o+TQAcOjO/DhRckedntfxYpSukjfJ002DvfEqFyqn8KsGJskixk9k1ZrIA1A3/CI36RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVOkm+Ru; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7986c7b8076so68719907b3.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 23:03:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772607824; cv=none;
        d=google.com; s=arc-20240605;
        b=N6HhqX+/6mIKmnjFUfWenoDlfFQOMJIkoTRIjM3EX/d7jlVx2U3ew5nxsylStN81ES
         nmhf9OQzgAEMqChwL4PEhFx2XwFauCGa7fx2SW3SCram3uUwLHvc5J92Oz3BrnVRd7fD
         aAPBJjO0sFYtw7xmuEoDL/gw8l9T23SFqouVR9AEMnLWMOS7RbjrbCy/5EPjrj7gKvVI
         pB9Ihx5wbMG4BchiLXFG+kRyGBpIaCEZIkRvwb1pI2rovX0c/TosLvzfDEJof1Unilwj
         UvT+fMxOyFgFHyxsy+/qsi3tKkjPaAzv5wrIAE6ukEHNvCKsKW8kExJCik9Sm4eYBKYl
         NjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7kC36aYQxCFNnOdX0a9rvKTNPSzoVlpL+6fHyvmZ1Lk=;
        fh=t2EPBFbGX34y6zijcogjxNN49vnztU5Vaf2topLEHAM=;
        b=J2IbTSnjUfSegNGMFdlgaKnElXRO1tpcVJ+2mYUgRH61GWtVtAANzUBU3abHSBRvod
         DQ1OXCkkPK81+74o5BAZ0SJGHQacTwRYJ0hc/69t0y+8Brd8+hZGLnDiWouPrABOKtdc
         fs/pcfLQjwXel2yLABoFNa0LcCaesy2rA9ahD8arT0pi1F9Xwvptls8ushgPN+1vXCUe
         aEOQefAuAOwCasrEji8dMhB8CVy7vaOgk4cc9cKvTSw1sitq4r73mEhShLIATwv8szCU
         NXK6lJRivCcsDq6cHP3rkxQ9VGTnxnBi+jC/Vmd2hHFYXmabtmkPrSJ/pBvut3tTDAS2
         BgDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772607824; x=1773212624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kC36aYQxCFNnOdX0a9rvKTNPSzoVlpL+6fHyvmZ1Lk=;
        b=BVOkm+RudvKP33MgD0DedD5RagZDXCY4ExOuAsDupjMEb+8Muo8Gce5rZOXDAh83pa
         BwolsIKTnS9sNZ/3dbkz5n1xdzJz+eZ/bG4oUdRcQiiIWkAocwXRU4vnB7uCf3TCyiN/
         sEnrjpWmfwolZYtrM3EOfbWu4TO4IzJLs/1Zvy6P9OvAyG4qyPXvuYpUhrt68EN/dE5w
         P+l18YFkUKtGmAxcpB9zF12Hn+H2GIGis8ZRCn2HoaAGfwmzmxWZ6URIRfDHVGkq1zGI
         CEsSPQGtcKs7cHdGYBnOkPD3VjsugkOJ3PCAED7pdJ+TlClSBgbR3YdE2woMoUAnUJEY
         +2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772607824; x=1773212624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7kC36aYQxCFNnOdX0a9rvKTNPSzoVlpL+6fHyvmZ1Lk=;
        b=FHoU52ZsCq8VTX5l9KCRimf1and3/LqX7HL0MjtOIqJzUwOr5RL7xpfZu6bDRSNI7z
         w5s1nqF+9AgMSyCn8H8HxuVnC1iLe+WVgRC2yjM1nAYIpk0CiGbZT5oK3oBFPGcQpjJP
         AfIye1pxEl3EtikkCXTwgIW98HJlg6m2/1D+QxjcD+3wMeMatf3d48earUEicGGokGhY
         oPbV60OfN+l/zdIzifRQlMquX7QEcJpwtUTUGPKhQNH9L06FdhFS3b2W4u1JJheKe6I8
         Vtu3l6/T2pPKs2oKIwqWCLWbRhD5A38hwP/bss0sRFl0wVpRNzRaHhCrtm4IdRmT8ed+
         EA5Q==
X-Gm-Message-State: AOJu0Yy9mAevL+mPsHnNRfaIMfdILtFoueqi478AMTmXR9P7wEJk/774
	YxJch5Gq5gmnAc3iwewsGWIXQUh2on+dHGGqJOwvpodD5KkcC7EpoQo/K1nBspjg2tz4wQit6ux
	P2TSJm6AjXK0q1zMwTVKwJT8nVzm85qdiSRN+53rtL5ccBcPSMz4jiiPpWUM=
X-Gm-Gg: ATEYQzylfjyLRwCN25B7fjRpCIRtbgj2U2NB/O/Ig+QodM8FstYJ3wxB9/nATm3GHtr
	7EzbP+moShYNW88Itr38kWOaohTce955iX+vUczja/8rUyFEfrZFRodeFbLhJwg1OgaTdZuIhJ0
	g7Wmx9ogNa7S4XUKIaExknCK9at79euamPtq2S52u02pCHAHlwqGJCZvPMUN2YEPgmzJIXHKjvX
	4kpW8GJgPNXtgMNWb+5sunSp3QpwPTeR5e9P6UrWxDuScDsEv522qKexYiQ/ttUMd0qAno/wA6B
	QA2Gs0F7
X-Received: by 2002:a05:690c:c4e9:b0:78f:bcc1:88e0 with SMTP id
 00721157ae682-798c6b7ea93mr9397717b3.1.1772607823803; Tue, 03 Mar 2026
 23:03:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304064253.16955-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260304064253.16955-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 08:03:32 +0100
X-Gm-Features: AaiRm53coyaipWEFw-8AXQ0FnZoIv5wUSFsu8oZ6PyTI6ROz17FYZQYNVsOtLIs
Message-ID: <CANn89i+ZQxcKscCL_5wXyvG5rxbyPTEueDKWd+9o6Z1rBeFurQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: annotate data races around sk->sk_prot
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, kuniyu@google.com, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6F3F21FB5C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263612-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 7:43=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> inet_sendmsg() and inet_recvmsg() access sk->sk_prot without
> lock_sock() or any other synchronization.
>
> sock_replace_proto() (used by sockmap), TLS and MPTCP can change
> sk->sk_prot under us, so these functions need READ_ONCE() to avoid
> load tearing.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

nits:  (no need to resend)

1) You could have avoided the temporary variable
return  INDIRECT_CALL_2(READ_ONCE(sk->sk_prot)->recvmsg, tcp_recvmsg, ...);

2) This could target net tree, with a Fixes: tag, but I am guessing
stable teams will automatically pick
this patch based on the changelog content.

Thanks.

