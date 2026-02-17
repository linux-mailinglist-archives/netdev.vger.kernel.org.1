Return-Path: <netdev+bounces-259152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPebMUDklGmjIgIAu9opvQ
	(envelope-from <netdev+bounces-259152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:57:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DE715133B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482D43005D36
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937343033C8;
	Tue, 17 Feb 2026 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfuMW0zs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14F301000
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365413; cv=pass; b=rkPZq2p1zXKOFvT4BXUOikowkvfr/ispo0Y3HbxhaKZhTtdOFNrjp8q/n4YdsI6+v9FnaQ1VOG17cS5fIgPrptmiqPAREg4O2MS4j0otHICxTPKIin99ZJeLNphJ/P0r/M4jrJTd/NvV1+VR6KGfXO6axOccqaAGub/z/s5Tnlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365413; c=relaxed/simple;
	bh=ZSlD+55NpdQk84bZl9Lu/yWiA3dj/AMrDmlZ29EEXdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9f1rkvN7jfbfFav52w4Y2twJp7PKqDQG6jjGQqchpKLEQLhTLykfmoBwg+eDq+WzAW2nO1AhowNGSBJHfNL9bRnFJaTKAkypmEXoeGO0hDVPaElR6a66xqAX8OuxyOmOjJipreTf8HR4h9rxzvUQdR6mix07gSfFel6W36cSbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfuMW0zs; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79456d5ebf9so42822657b3.2
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 13:56:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771365411; cv=none;
        d=google.com; s=arc-20240605;
        b=eV+EuUgxAjlroAKQxcU5QtQnH0qmrUC5pUfzE896uCS9lbTYzZMYr0GX3j0ugY5ceU
         W5tMspiaMSwyCH/bdkTZfu8G0Ny+vdihq/167E2UJMc9CCepbyh8vsWIWBJxseOgof1i
         a9g/giUHM9zQ3qIDu+KRRxyfGxItEOFGQ9vigdogMbPN5e17sQsgBG0fePI6Uitu/SVN
         KG1yiY7tjlnK83KK7/GgyNhpFls+At5bbgLpQ226EuBkxkWuAjssC6Kkkbtydcf7BjvP
         W0wRiyzYEXTrug0wgmwHTweOGiAbkg6VRzMsAw1bJvStzUNU2LTvqpNlGFldhHbhZ6WX
         h3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z/R1WYMVM+Sw6HNuHSiQiycZeu5/EkoQdudWinKy9Hc=;
        fh=u4VtPq/aKfZcC9SuQjyNUmZDSSVDljUG1jDYOLK/vPs=;
        b=UYef/Ho8syoLCnKCbXIz4a5IkHz0KDLsQWGs6stkN8hr96yUmliSg2K7WNyvd854qN
         uHGgzRvdxagXIPaB/qj5JI99xfsrv6dXTOvHKSR+MKHg3UHp79lu5pmpuJTsrezWvMzr
         mPQ6ywR56fqbV8zLLP6XONx717RPLhPlLCBUp8PYcAvUGqan1VPmShj9OAlYQBF2WMLz
         DHq76aO0alF0v+EfcbqjvVBI3azWRWBL3kxPDjqokBZjHBVyUuwG9xliIToR97J3FyVM
         ozSgstofmOertPwrEcQxtyqpHcXWF5COoMNlj1i7eqUFi+wrUjCZAYMr8rmSsEL88c5t
         59fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771365411; x=1771970211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/R1WYMVM+Sw6HNuHSiQiycZeu5/EkoQdudWinKy9Hc=;
        b=vfuMW0zsPBiXBBMwtY5wgWOEZy24/WdyMFQKrlG/K5MxZ7KUB8n16E6eYB/dRVdvYq
         dO8FI2M/w5OWZ+sVagX8Zxv8jHWiX1XjxZxeT/tXW86ftOsj84YBM8Gme6ptTBRlIu/k
         5SFYECjWuSmIO1grtG4eqaHGvRClE7tJ5ORS8gkr+Po4fodZXKencocYbs9tyrMkIM+A
         iw0vg32H6Lc9uLONps1JRdUN6JY7K1LU5gatMzkW25NQxztzMRH1flao5bdHyHt8/fmp
         QVZYz7J9L9qFaRUzyDaBxA8NGtZEFC2VXTPZyAAXKo1dEiPwztQ0casrCfN6/reLOMbY
         rfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365411; x=1771970211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z/R1WYMVM+Sw6HNuHSiQiycZeu5/EkoQdudWinKy9Hc=;
        b=GRluQGHcJqtpvyrvHIDYjnNCgFuP2Uwn1QczwVaY/ewbR2mnjAg3OgmYer26M4fIOA
         0K1lqAJmVDxWwy4d+sqJvvmmq60Rk1ErNAn6zMY7xQPTN6zGEqwvTT/YEcsVwVQpyzjZ
         syeRxK1fFk/qZp22Hdl428OlFWglwA2siAbbRKzaVTH/2CEWVjoaUfu5KwpRd2EDgOGv
         1WEk/QB1eFpCN8vTdkxlBDTjSDGDHUipZPS3MEbmxQq52DkHaZg+8DY/ZrhmAlXgegw1
         QO000H/e7QvRKA9aOTwRK8EG3QFDdQzB1wpbKwWm7Sr//oOPaQxbNspDGu7GXrTklP8o
         xJug==
X-Forwarded-Encrypted: i=1; AJvYcCUFZ/LX44eq+krAqVNJGjU6Nblsz7E8hsxninYGM5kGpzsBwreTadBFgJMmMMlmjxEluxMZpZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoqXoWbjRfdejqnfOU4xoJJkRQ/IJuELQts1Ip9k6+DUzehxZw
	JROpv3EvxlIq159+a6139GPdBwgcQrU7BZbfmKxsESqcEVbUp+BKveC8dJsNA/fDMLzioFNuyCD
	tjdMFkEZzjnaqq2ryM5eZRXkjgx7KquMooX18yWIX
X-Gm-Gg: AZuq6aILo0ShoJqevZ1QXHpBkXMHjF3A9eFU83PP1Jz2tALkdCehZbcSAiGjdwgqIrT
	XD0WYN9I9YBckiYLjGsfZiwk5Q1CRkNk374KoSvPj7JStpxbprkMneNCqTqaiQVjV6q771FQZWo
	hZixfJgqT7f/htphWPKeuQStdbAuD/QjwHLMO8Z4E6s20q30imAow1Q763bwGcMQBktQeUwS+1W
	Vw8tc9uGF+ZubJixInLF+fQjjR6wQD2jIXdJsJFBZJlEXw/jXSGis5HsO/2E6nnbIL3gzYS0bpc
	ZNuPn4YE1Fh4XfWcHA==
X-Received: by 2002:a05:690c:c4f9:b0:794:cf56:5bc2 with SMTP id
 00721157ae682-797ac63f285mr98922127b3.59.1771365410880; Tue, 17 Feb 2026
 13:56:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117164255.785751-1-kuba@kernel.org> <CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
 <20260117150346.72265ac3@kernel.org> <CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
 <20260119090435.44b1da2d@kernel.org> <20260129150459.29419003@kernel.org>
 <CANn89i+P86WVVUY-4WppUAH1TGix1Z3KhgX9vSHok5nXqQAiHQ@mail.gmail.com>
 <20260216094936.5bf9d789@kernel.org> <CANn89iL+kzhRqwBr5wAcEBMdC_wbLFanHJ6VxS1r5ppGKUhftA@mail.gmail.com>
 <20260216101108.6b2319b2@kernel.org> <CANn89iLURfPA69TjXjdBJjbc+Ad8X8XO-fiDQp=Uc8J+0PU5JQ@mail.gmail.com>
 <20260217135008.30561ad9@kernel.org>
In-Reply-To: <20260217135008.30561ad9@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Feb 2026 22:56:39 +0100
X-Gm-Features: AaiRm51kXQbUsE14biAK0N_Pu_vz1iAmwrXPVIpk4O7GmMEjlQqb9onCeP2gX_Y
Message-ID: <CANn89iLp5=DtwEc3kLWVvsTnMbmKQ+K9f5LJ=HTfQtXffZJYDQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259152-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27DE715133B
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 10:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 16 Feb 2026 19:16:46 +0100 Eric Dumazet wrote:
> > UDP use of skb_attempt_defer_free() is  with RX skbs, and normally
> > their zcopy status has been cleared ?
>
> I meant coming in via napi_consume_skb() -> skb_attempt_defer_free().
> There we are freeing Tx skbs, which for UDP these may legitimately
> have zc state. No?

Ah, I guess I was referring to a kernel before  e20dfbad8aab ("net:
fix napi_consume_skb()
with alien skbs")

I guess we agree then ;)

