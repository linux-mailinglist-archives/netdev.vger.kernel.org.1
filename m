Return-Path: <netdev+bounces-286479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE/IBz6DAWoFcAEAu9opvQ
	(envelope-from <netdev+bounces-286479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:20:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAF650907E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD833015C90
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D6637268F;
	Mon, 11 May 2026 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igXfiYAU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E3936C9EC
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483953; cv=pass; b=qAHGNBt6bLFUWlelvY7fWO8mLi+ThqpiTVwldG47G4TGd8Js1tLWfjeuuGIYnmLbbqHk5GxzM86OArnqrq66xg1NhGFxm6bfuYt1f1szZWA8rr1k7nCZa+kt5FSrHZ12nmzKW7bIEwllOvKUdUlaQgv2WL4oXhpZRnRG5cb5LX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483953; c=relaxed/simple;
	bh=0tq7+QO/zX11vt1mSguxtzM29Iyxssr53gaIc8N/SOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3BQk3gmCdVTw2Skcq0WWHeR1HRYLipFmsuEKBNFuIYZs9kR1rA8+YI0eiZC12IvKciP9cxHOW7mXf4MjhI0wKH1XMGWm0dLCuuoXOfZwsBynOOh6abKvKeEDw2H8RALsUnwwdEVlicxtFo9Pt0h76+ap/POq8csmt5FiqCbCS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igXfiYAU; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50fae4d1f85so47851721cf.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778483951; cv=none;
        d=google.com; s=arc-20240605;
        b=WWbekxCJZ1gCtFN5a0npPP5PiWUxgJdgPAmv2TMyE7WFVlYEvP7j55uY7td0eUNLcK
         9dXBE1tB1DnUIz3N6Z6jAGf9Bg7/qVA34P1tKUBh11FPQhEQPli3ng237csI3OUsXwFl
         hL/dF3sg7kGZCFsRKbh5Axv+7f6kiuXl5tomdPUfz+Dj6XDyg1RL4htDgfAhVCDyHiuR
         NT0qV/HKlJv5b8Rp0vS9wkJpnBc214oU68h2MLCTc4KiOBPwjvf7Q/k5c5I3cdABQa+A
         aAiTED5tZR9CjUpXBxCzNy3Us3j5kkN5CBf2ldqN1T17lhDoTtMJ2fsADnPZWeTmbpHF
         se0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pzjX5aZytdYjc4ATBvAkFaDuhTJ/jrgQQEMmC6Ei6Yo=;
        fh=G2DSwxLluPLqL6T47MaKC8+0ljKI0cNkqCj6fMUkYrU=;
        b=R5G7+zrWH8m0zHTfXUd2DgibzYiSTKGvMeAtnDlPd1GIFFA/PV6+RZjAiB+3iGeN8A
         f9b8ZFlBj8QQ2Jzlk5bRlWisKpoq6UZOvGGScP5rYtl9XrEUvcBCkbTFVihzAD6Rl9P5
         hdBDcP9xJCiiCh1Ok+93vtyIu8dR0rbe6SGFvliD4xEwZV54fPKEQVxoH6ExSIjBUAXA
         EtjsHKdCVHQesjrZYJTRu2tzgP+wLnH91wGvkP7IGdJ60nOpbsS9sARbL9HhrTKX4Eh0
         +qt1Ce8VwQ46KE2Zyf+oKqyVpKPs+nAT8iS4wkzp7wC1yFgzr0ZTV/XEubzovu11W5LU
         kxVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778483951; x=1779088751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzjX5aZytdYjc4ATBvAkFaDuhTJ/jrgQQEMmC6Ei6Yo=;
        b=igXfiYAUbXEliRGqN8I7qjh56av/7yNp63Jtv8oxc2nu0ZVtTm6XT5FiX4yWztASS2
         /961gPDdw+zGvR7R7CCkwWNQOF8M/a+pSs7vY/nM68KUioN+lXF/oNpCfFl26s8V8BHF
         Ud4mpP87w4jdi6AsGa89ua7OAjg9Afg0R+2FYZvI9CFbWMFu6kVW6t3ba2MPrMgJa7DR
         xgIqN+qlX8zydSv3SFnqCV2HvoKn6hFjr1w8VtcYRGnWiV7vuxTUA68t7bwFvFCOYCzU
         y6iTJ+yXpZGEv48Ero6YCU3DAcvIPuigtJPJl3w0oGg4gEz0fNR4qLRSy5wyKcLVWNTf
         1zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778483951; x=1779088751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pzjX5aZytdYjc4ATBvAkFaDuhTJ/jrgQQEMmC6Ei6Yo=;
        b=j0xw0FVcj+1CdJM0E/64gjaAhtLRPf3G33f0YESPBnm6VwARyM5pSqpcBBlXeNZVbS
         ZjLNpRVLge6PTfABYFJqB4Q2FaUg1FSpvX+6A6RILfQY/t5yO+53/WidMQ9A7G2diKkY
         wZZY6yUU475F9rK8haceKld5Rsj38Iv/6StxRzE905um6JiQhUeJ0oEIHF6p1xMYyQ4e
         fWMQdlvXA1+/WsK5FTwuI4Wyo8vaDRarvPE5r5DDVjrvYmfT9drsnJpd95j61vQ064mB
         5wq/jMkL8JnIkvbNpOXaI2i4aexnzNlCpktWauHB2Nq2WSvTGcqbYwFFdHYCEd7e4UMe
         KggQ==
X-Gm-Message-State: AOJu0YxDwHEk9tv6GiCXmbg+OC3SI4aVzokx/hXG5qOXd7/bUHJC0ipA
	HueJwWn/DyeKC3rcshSWEfj6IrnNdkusAREMsqyBaofS8hXSnVrSLzhtwdkSffkfWpdWzq6gEUr
	oVZykkqe7pzMCd/kFgcSu4FXBN/tz1qnNnjKDuTm+
X-Gm-Gg: Acq92OEFNDiz3DaKqbmDNVLhjCp3faAQ1pzE4TYNnVye1UmJeHr3w+nMEAr7+Y8gVHi
	f1SH2FUeZQEJpfC+5wgV6E2Erm21htElYr3lIRxkoiVu7XD6Nn4e3hVg0iKe5fvDmxWfjdMB9e+
	sEVYwqoUzb3aEHr2rRWxTw/ivvDvnov6d1q5WyVohReqv5G6lAG5nxf5WdblD9vObJmAMCM8Esg
	wmbMWvMs/yuOfwIgJlNa4yRsutWGPWLObnRyDa2IZgdSI8VU3p8deqYHpB3//O7JOt6cxefe8B8
	WvRfp0MPbM5UCrlyzqolweFnCC/rm9C6F2vMkJVWbcLtSVY/sPHl1OmwkbgFNy5pLyXkSDQ0Hq/
	t+mK7GgOKGuja9naHq/d2gMWPin50p7oZOYi2mUM=
X-Received: by 2002:a05:622a:647:b0:514:5d88:8296 with SMTP id
 d75a77b69052e-514621d0e45mr321046621cf.52.1778483950919; Mon, 11 May 2026
 00:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507154806.18635-1-ankit-aj.jain@broadcom.com> <20260507154806.18635-2-ankit-aj.jain@broadcom.com>
In-Reply-To: <20260507154806.18635-2-ankit-aj.jain@broadcom.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 May 2026 00:18:59 -0700
X-Gm-Features: AVHnY4IXty1C5WxwC6jVyVP7UV6kJQcgN3ykDWabEzHXjKxZoGtorArf6iJ-G9c
Message-ID: <CANn89iKs3KLo=5hhUEH8OEG8p7_52g+fsrwYYNW=GzP+k7WW-Q@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] tcp: protect locked SO_RCVBUF from Silly
 Window Syndrome
To: Ankit Jain <ankit-aj.jain@broadcom.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, ncardwell@google.com, kuniyu@google.com, horms@kernel.org, 
	shuah@kernel.org, quic_subashab@quicinc.com, quic_stranche@quicinc.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	karen.badiryan@broadcom.com, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com, 
	yin.ding@broadcom.com, tapas.kundu@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BDAF650907E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286479-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 8:51=E2=80=AFAM Ankit Jain <ankit-aj.jain@broadcom.c=
om> wrote:
>
> When an application locks SO_RCVBUF, it disables TCP window auto-tuning.
> However, the kernel still applies dynamic truesize penalties to the
> scaling_ratio.
>
> For small packets, this penalty drops the scaling_ratio to 1. This
> reduces the advertised window and causes Silly Window Syndrome (SWS)
> along with 504 Gateway Timeouts in applications like Tomcat.
>
> This patch bypasses the truesize penalty if SOCK_RCVBUF_LOCK is set.
> To prevent memory exhaustion from large aggregate payloads, the penalty
> is still applied for GRO packets (skb->len > len).
>
> Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
> Reported-by: Karen Badiryan <karen.badiryan@broadcom.com>
> Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>

I still do not see why the current behavior has a 'bug'. I think it is
quite sane/reasonable.

Your selftest does not show anything wrong IMO.

If you want to avoid SWS, perhaps the application needs to _not_ use
SO_RCVBUF with a value smaller than the device MTU?

Applications using SO_RCVBUF with tiny values can not expect kernel
behavior to be stable,
since rcvbuf management depends on metadata size, which can vary
between kernels versions/options.

If  a kernel change is needed, I would rather enforce a sane sk_rcvbuf
floor when the MSS is learnt
at accept()/connect() time.

( TCP_SKB_MIN_TRUESIZE / SOCK_MIN_RCVBUF definitions )

