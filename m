Return-Path: <netdev+bounces-256355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI5rJjkigmmQPgMAu9opvQ
	(envelope-from <netdev+bounces-256355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:28:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F77DBF53
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9330D3172700
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086043D2FEA;
	Tue,  3 Feb 2026 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFYkuVt5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A213D2FE4
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135595; cv=pass; b=iD5Qo80Kfqf9zwQ+KQs1iGsj13U/1taQ/FVO6tpQzKGkfav3auQHSKssxFQfbof7eqpC9vcJo2ZzahnJQFrevr1tCNIh/1vtYoSWgZYokTODFVH7Dwtct1kqaJ+C6D4aOdjKAJyEyWqY2wJnt3msgIvWZYhpbWNNO0tDNz3Mv1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135595; c=relaxed/simple;
	bh=Tu4rSvNTKOOFw1ToUC6UiNxnVnQZ9GgdV42C9w5CPZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkSYVm7HCOdSZgRKawEN+vM5ltC6GaQC9baln/o9udfjPkyWBHOwOAPOgZgMVeWH7ZT1T9jMBteXqFJnHwCbDebK3OMy3/KHn3A8xGwV2iReuN9BHg5L2S+vkOTTWI8LJrFrx2C9Ya8SUi4e1+Qfw880afg0IpEdsfAtz1gW8ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFYkuVt5; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64937edbc9eso5166285d50.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 08:19:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770135593; cv=none;
        d=google.com; s=arc-20240605;
        b=YO9I5Ypx6bC8ziSbPKR+oqikZuAC7rJhF9MRCSzy1LIwDTDzKBAc0Z8iMccdQOcOil
         v8xlji+KP+SthaTuDzcMmQIpiMHEfleAx/mqNiCqSW3YorflpabC1sX7wuHsayXzjCdi
         kEpDy++Cf6mks/CSaZX1BNkgKhRajNHvEoZSDb3SM7Rnuxn7bWn61xBDweIsuhaSW2zl
         E8KDwJq9PRNTO9ZtVEYtk7TBo8u4rBcc+6IiuFaNv98f3dlnoSRUMzCkoh0OOOvSye7D
         esIHepjQXcd/P4hEwP81g8NMs1ZmI/uCeDWYJaHet6dt+Gh7k2sZ0lR4kxArmJpa8B8o
         MkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wGWKXutvMucFH05YrWha7pPDqCCm/nyM2LYOpcwTIG0=;
        fh=h5PwfNUUOVN4jpJ+9rMMWOKf3eGExzmujuwPLgMFs34=;
        b=ArFP0AeGvpVDlTw38v3zHO21D3SPi8diBe/oCCpvvIFz0pfc4qiGeCT8ezCVipZoFO
         HsGMIQFpQwO1sIq1WQUPsMXnxl5FxgI7A9efZxs3J/28ddqhwZMbpkARhr+z2RfO+RW0
         SsO5n6eg4Ihhr3PEbaSvQP4beD6Xm609buBQFrBYgl3tAmMLHJkHMQCdlaelXil0WnIz
         PPJk6RKLjoaFyjvw/A7K3GLzJLQKgscSsL7axOhpt4RkI5WNl77cVEVI3K/VU+4oByPM
         E/oRFuzBqR7pFgt6BTXb6Jj+h06+D5Bg7C+PgeznN4SKuV9Zq5XoawTMURwrvpoMTs2A
         /+Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770135593; x=1770740393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGWKXutvMucFH05YrWha7pPDqCCm/nyM2LYOpcwTIG0=;
        b=BFYkuVt5ZAdVXyu3DTkMUfBmRe3WuhPBcfYZhSAlHe0XDw1GAuaPo45rtnMsmpoJlQ
         rgIkmUwd8nWw7r29KnYhYIV8PX3ODYEy/AAMrkpphuoe2L0U0gIwt6P5tnjDZc89VEz7
         CuX/NQS5RoyNjhSjf2MQRazazxUj86fv8rBk5E5+mTMU0eJM/CjbGjFBq4Cx2vyfBXfF
         PsXrYJQqF2XjJ2Ojjc80Tgo3+aWP5lQ6NmIIcw5PixvAFtbJPPIXFEjtf8cDbfgYC0YD
         KgxT+abbNq2m93rfMuOCa7r3VesYLOFNdUK+KNdtmB300XkLhZxGamb2CDo5x6l6nIzC
         5nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770135593; x=1770740393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wGWKXutvMucFH05YrWha7pPDqCCm/nyM2LYOpcwTIG0=;
        b=OW8hbtem1+mZXpFpx4dIpN6pknxpdESLgucUCNhKzPOr3QpOwkNR8bMD7lVz2LnDus
         KU7FleoV8JYsE0F1i6hiy1LyHLAVZIwA/Jy+ZkDCF8Ef9OiCGxn9kJziUJ0dUqSNd2da
         eXMf3yeYEnjPPHbDzFKFxjD5pBI1a/Y5dfFiSYH5+wANjpNmExL9VWSOVMublWp5gMvZ
         3FKeYf7edHJ9z+NkzCklC/dL8lJkQ3qpaKtmypJ65K1DfXQ/LnVempMH69WJgv9JdbzP
         7xFYRY4fFzWiKCIGmA1cDZs8ipUKVxRGZztMRi8RIs/+KCW/iwhE04zuiaZ+Jvr93QRc
         cTdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrRcoQV1QV2AqVPRzGc1GI/0pshGWK1Q1+woKY76C5E2cGvhsX0Y+6raC7BOGgOrsq8ksEsxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nOdW4NcsraijOHW6DbdLYMuxwv9NfFYQeYo3ixJL7USR1swB
	ocKR8nTfnI7S2kZNW74niAmupDMzBbFvbFUZdiARNJAcrjBpoFOcoNWP07aRY2KUn34EbeDUFsH
	0lWXvXkt5du++lI2h7OHamPGWOjiZNns=
X-Gm-Gg: AZuq6aKKTnyc/R1ziQM0pr8buoV4BIq5m44pX3eTniwkU9tahKuV6VUKsPMCTKg143U
	dqEhe9WR2y65la53biQRb4oTAkNQ1S90VEpWMRSwLVgilBZkMAUu+/iXVCwPHp5wjK0OfAnxc61
	0eNgUFRU8fdKcQPW/CtxiPBwG16xh23GBNM5GQCAuld0D0x7vudcGG7EWo0rONQ0i6exvGsJTrg
	rxNjfPiOHEiNi/Yjat8nZfP1UUjLJJf+3swZmPXzSi0u8Hn8ySpl/yaD5yJDrRHrBfHTlDfdbCL
	50wE
X-Received: by 2002:a53:e038:0:b0:649:399c:d964 with SMTP id
 956f58d0204a3-649db4bd04emr32126d50.77.1770135593302; Tue, 03 Feb 2026
 08:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203080109.2682183-1-sun.jian.kdev@gmail.com>
 <20260203145511.164485-1-sun.jian.kdev@gmail.com> <aYIOXk55_DRFKCqo@strlen.de>
In-Reply-To: <aYIOXk55_DRFKCqo@strlen.de>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 4 Feb 2026 00:19:40 +0800
X-Gm-Features: AZwV_Qjfv0Y1awKscWXbDj4yy-HnV-BM8KoCg4M6DTECxWm-KSh8hCQxRruGgdg
Message-ID: <CABFUUZG9LnhXc+nsQA28WHiiT33_5wQ82E1bBSBncWkxkXaKZA@mail.gmail.com>
Subject: Re: [PATCH v2] netfilter: amanda: fix RCU pointer typing for nf_nat_amanda_hook
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256355-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 39F77DBF53
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 11:04=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Sun Jian <sun.jian.kdev@gmail.com> wrote:
> >  enum amanda_strings {
> > @@ -98,7 +98,12 @@ static int amanda_help(struct sk_buff *skb,
> >       u_int16_t len;
> >       __be16 port;
> >       int ret =3D NF_ACCEPT;
> > -     typeof(nf_nat_amanda_hook) nf_nat_amanda;
> > +     unsigned int (*nf_nat_amanda)(struct sk_buff *skb,
> > +                                   enum ip_conntrack_info ctinfo,
> > +                                   unsigned int protoff,
> > +                                   unsigned int matchoff,
> > +                                   unsigned int matchlen,
> > +                                   struct nf_conntrack_expect *exp);
>
> Why is that needed?
Correct. Manual declaration is indeed verbose.

The reason I used it was that typeof(nf_nat_amanda_hook) carries over
the __rcu attribute to the local variable, which triggers a Sparse
warning when assigning the result of rcu_dereference().

I will switch to typeof(*nf_nat_amanda_hook) *nf_nat_amanda in V3.
Thanks for the guidance!

Regards,

Sun

