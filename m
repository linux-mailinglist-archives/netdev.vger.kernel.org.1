Return-Path: <netdev+bounces-279958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ4DJLfJ5ml40wEAu9opvQ
	(envelope-from <netdev+bounces-279958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:49:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2776C435296
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72A093004D05
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFE0194C96;
	Tue, 21 Apr 2026 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUxD84An"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF39017A303
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732597; cv=pass; b=MGr1AU8dDuiPKUnrRbzpRAjW4vs8Go1CyYn0oaeKYBgAJFQOquuhrzUcKrSIQJm/iX+plYhykL46PkrLW+eBTYJg9irJp3mjlixeSJhYLfLe0ft2mzJTSAa01OX7fiO37q68gXv8HeT1HF9tQ9PiIVyGjyFaJp9UcxczdaatgSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732597; c=relaxed/simple;
	bh=3wV7bjTRykkBf7rQHZFCkWqym43ADBv1eJ1c8QenCwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvjaJcEI1J5c0tHu0BvyCSRxMDyckyUXAkyba9x0CbuDIQ3fQwsRnAtk/OuXCFTL5RT018ewlkdT4WTqJXilnncMo2aZI3ZOxM1UofparlHXgoIttlaBCANL5m2IAet8Dy7UPXZFvPExhy+nVwRkbHBw2gV6GAIsudk1HyhJwzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUxD84An; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so3882371e87.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776732594; cv=none;
        d=google.com; s=arc-20240605;
        b=c63VVIjKu5SqiK7eQJswks/f44Z4iJMPlwXW5JL3ww0c98c5TZyPJhe2Oa/G2rIiyg
         fshvpKqEiN4PAZeXAVj3o/7b+SWyAZALkpjoDGqc2ZB1Ll905p8SiF+2MRDSs/6YfVUf
         CfxKO8whlb5OHNB/MhIeFE4z7PY7C5TkkdyXbsKPsSJKcn3lsdASU+CCp5xBGSCTrPDX
         DXt9LDO5JnN+/XEDAEaCRfu8fZStMdv/IB55ZxJUvCz8irCsexyo3/Wa8MHbHRf62qIe
         wiY2012BIH4ZBjWSrOqeVUPDpMnYer3cWN8tImB2FY284xg1ozpjWq+J5MHxZcXeMqsY
         k3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zlfya1nwLzGKQ/WeElmtSC+CVctrAYUow69cWs1Bt34=;
        fh=jvks/XWKOQNdnjXo+9S+XXl2a/nPOIv/SgGIq3K/Xac=;
        b=CdhYxZyA3P1BaiWD4Qf7Al2oOnbPRsn3o2jKC02qPhm978nGDY2wOdAAVVgSujVg/0
         GiNuiNGYtbLpxchlcn7QSGXQDmMtaRgiRiNKk8JhiUcRvogI0OF4j9pcnPzFjX+aUNkw
         KcJtWY7LICEbEO8bjHAlgTzfPqi85kC37j+s3XbKcyem6r4ROU9rZlScRpBiIZVh3yJz
         n+N7imZdD+MtHDCDgxRXH4SvVWsLDcmpYFwUl5Fml9h9Z1PcqLUMEoCOClqGB8E728IW
         xa1Dh3rXUXHm9Pb0a9CtZYUKyet4ngbZ9WdjjOqHKZpIXfHwG5P2seXiNyYXn2gXWEvu
         R85g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776732594; x=1777337394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zlfya1nwLzGKQ/WeElmtSC+CVctrAYUow69cWs1Bt34=;
        b=fUxD84AnkhwVu6sE8Tq4Zj1ALe3UfGFzF+56Y61eA6c73ytEsVQ3ybMa9ADqPpCSfb
         yH4r5zWBE0S4MCMl8YOapdbhXiMJ2rXM8p4QwE+0ty1RU4lZe+4TN/FCZEiCFhymxE2M
         Cu1dVhFwoePa4IegLtT8Hh5JtO1JR+tvdzh+lUmCIF/9moNk47WmqBK+nfzKTYFeeJfR
         LEYPiDkHwM+N6k+WUxOQiQm9nr3MlxG1Pd8ai9nSSodbB3aw4BQsMg1h9un5Rz2+j2g1
         2TxNmpKnNGyPID5U1Hy5aW9HuEpVT+TQOgRiq50zutgPL4tdeTnGx8u5MTZbD7a/nO8s
         7yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776732594; x=1777337394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zlfya1nwLzGKQ/WeElmtSC+CVctrAYUow69cWs1Bt34=;
        b=XSQhbIBvR0bG+iVz5q2/Jo0IXB11kmyxrtYMbTCn7H11NARvns2jMmWq/4KwhQe0Dd
         3NaPtp6p7ET5RyfMKg7sa+3cqvednTbWNr6OU2PcgvcFf1de86F6H3MkhlJNWaHJf/DW
         7XWoK4oOFdgJmKN0xuPtRL8bazYOqPQIKDxP3M4v2fQIHViWDAU+UvlomoL3jFhNKRJt
         eOertugL5DOyYqMLSz7ZJlpivYjpA++tLin0O/M8oXj0MQh0Fm4hqcmZhks5mqxFzwgD
         0l/H0N9zZEmVXSHw986ATD2w9ezMe7KVvzLsVfIUzfOWL9p5+RfnD7gLwyQ79TjbPG11
         pp2A==
X-Forwarded-Encrypted: i=1; AFNElJ8z1BlK28UYv5UprGlNuXRbICdKIsirAxIU/vo7Kjz22M4MkbNlUuR87Z9wBnE/s1cO/87laMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBWe+2sE68ku2vgQfYABuNfI0zxBp5RdPo7q+aew1FSEwKYwE
	1U6ki8tZ7UwQhu7EIS23lXXu5yD2LsapqCT4YqtMxGMDP4pYE7InoG0diKG2QNuSd16vPTKiwxP
	bh+no3SO799lcvPQ0oabgbqOcoXafq+A=
X-Gm-Gg: AeBDieu9PCrzRNvDnN6LU57eSNsHMjGcsKVsmcIZaOFj2pBPOY6nXTsw8uQcntJ/0tN
	vPJkfaX77nOJ634SgegFS9PthEHxbp7VuvUIHd/UPw5OsiuC3ZkLkccbj3KKY/R14GHAqnmTpk/
	6S9QKDiFMVzqQlSyuCxVtVpKhw8bMFOQFPLVNky5KLYyvdYyq6M0slfRqNhkYPuk3zYhzYGSOks
	tB5begiaSGIrBD+F8eW5WHjd32lgJvpq0RilWebJGTvCNz/Qm20XDoZedFCtUBlg7Lkn1en6MYc
	sLJ/gzX48ocNz2l85Q==
X-Received: by 2002:a05:6512:4027:b0:5a4:a85:ba43 with SMTP id
 2adb3069b0e04-5a4172e2876mr5441345e87.33.1776732593473; Mon, 20 Apr 2026
 17:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
 <20260420082805.14844-9-kerneljasonxing@gmail.com> <aeaCzchKwsp_LWyA@devvm17672.vll0.facebook.com>
In-Reply-To: <aeaCzchKwsp_LWyA@devvm17672.vll0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 08:49:15 +0800
X-Gm-Features: AQROBzCuVASaKOc8-y8eMYtdYQzDVkUDr4SxyAct9pri91egUgkuZpdE8YO5hhI
Message-ID: <CAL+tcoCxQ8cU+wr7eJsMH+FPMcp+vQ4J4BdSdsVqyTRqN8q9LQ@mail.gmail.com>
Subject: Re: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-279958-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2776C435296
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 3:49=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 04/20, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > uintptr_t cast:
> >
> >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1U=
L);
> >
> > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> > mode the chunk offset is encoded in bits 48-63 of the descriptor
> > address (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset is
> > lost entirely. The completion queue then returns a truncated address to
> > userspace, making buffer recycling impossible.
> >
> > Fix this by handling the 32-bit case directly in
> > xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an xsk_addr=
s
> > struct (the same path already used for multi-descriptor SKBs) to store
> > the full u64 address.
>
> Is it easier to make XSK `depends on 64BIT` to avoid dealing with that? D=
oes

Of course, it would be super easy. Actually the initial version looks
like this. One line of coder is simply enough.

> anybody seriously run af_xdp on 32 bit systems?

But my worry as you guess is if there exists a 32 bit system? I doubt
it. That's why I put some effort into adding the compatibility code to
cover the case. Good news is that it doesn't add any side effects of
the 64 bit system since they are protected under IS_ENABLED condition.

Thanks,
Jason

