Return-Path: <netdev+bounces-274852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED6ALOolz2kttQYAu9opvQ
	(envelope-from <netdev+bounces-274852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:28:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF18390619
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCD913023E22
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 02:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF534CFB9;
	Fri,  3 Apr 2026 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzznTkGY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2A24A076
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183336; cv=pass; b=FnYGyKv/mFINApFpMVB0xIgRAKhkPX/7/wEf//AXwrPZEMD3UubDeENm2heQi/i62mkZCzvNCOxdwodgmObK2Mr1BNRdHfSHcwBW9eCRW1mCHQl6hm6WDV8jf5XS5WZDhcxAV+aLENkUZT6UB9BUkKE/2Boy5obMzqxaPFE8L8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183336; c=relaxed/simple;
	bh=o76MnSdOtxs+ye4fRbLK45EupBuuE8+zJXQlKKJrCi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J04BXAN7LPLm+Z0LDJVtPmD0h7cIBkBLvqThwS04I9YyZcEM6+IkdrcWT4rM8ZPlgGagMPQYz4QI1gTfLOOk2x9Wct2prcI1uXUVX8Jt14RzRkZB7ltcTVV6ZCakpxEz/gcl7AuTgXSXPtFcGguA41G4JV16PA6itf2sX2pSPLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzznTkGY; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-793fdbb8d3aso15962917b3.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 19:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775183334; cv=none;
        d=google.com; s=arc-20240605;
        b=P7NDxNWrszIeH3GjRQLhNkyOhIZ5bFsozH+RzA/1wYd+pB8yvtXXIHELVo2ZiMUPJu
         xVMETDyahY8+hs2iUt7lnmXHj/jQmzb+wVdp8wJTV7Z2asw/h5iCsseb8eYUSZDnTPjO
         jb0ii257/XY0gRKYvzvO9NXm9yZ4i36zkF6/MKzLRPtYSiT4FYsumKNN6nqHDPvQUq8M
         CcKIQ9GH0zF42KIStK1EWQAmocEEOghNT7Jr5+lvf4GKvZEcz9OPFxM6ecRt14ypQGC7
         ZeYR8Bq6YcREMMGvNFybvuLvQ43sFGvWFF40qhzVEywt/94sADxjiRw41KmlSqn8J0a6
         HmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0XS+D/tqgKAhfModL3S+q9k/U37BM3GfjpI6/nfGSkg=;
        fh=Vrl0tC0K7iMFQCrmxkD6d35+wTFsGeFXqIz4yPfOt0s=;
        b=HJ2SxA59aTwUNOK9DZHLKEHmjpVPDe0hnx6oZN29nFMtQqHAUpmc9rzLToEALYBHGt
         qKiCO8Y/4t4HzJW2zblctayS88BIXDMiuW7GxuoolcWqXeg55ylxrQpjO75aDxnX1ztH
         LqSKBWB7v3jiTcatPQAvwL37LJ0JRCScAw8BC+i/RzTSH6OlbenRvrm7srZgoyG3ZqyT
         J7hm0fOrSGmF15nTyivlTORCvDcXbAKct9ab6oj4gKhKMcKzgyk+pxSbi64vHTTzXuJQ
         uPha4Tf18B8rJYJVhO4EzRzljLJP8gWhNAgbrmTnL3gpSCin1vKDAdlHyET3L8NYtc/E
         Dmsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775183334; x=1775788134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XS+D/tqgKAhfModL3S+q9k/U37BM3GfjpI6/nfGSkg=;
        b=PzznTkGYb4+FXvYwI7suFA4D0rrVfWkQixhm3kKw0Oaf/618qixCvgppqqG+5oxwY4
         vCAYWc8xf9EwuNgABchN891npHcJOEFQkQ8It28ehXh25VrJJCO9Yy4W1ozYn+2qm6of
         XtIRKhTCLjc/eu46tbVoqKqFW1uqr7afssxxvKv33pPIxgLEk70NfWDfRVpFUIqmsoKL
         Ac5o9V6R3ktxeCgsR639r+y4+0xdNZ0ZE3rC9x0F4yuT7EEWBRKIvPZLOS3ly6vh24fx
         Vvcb/M+NGDPUwxtSfqTgDtH9Ked6zB3GzTLWiHF68LqyPjKqm2qRNamGJbgDGJSm3Tgs
         Ky9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775183334; x=1775788134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0XS+D/tqgKAhfModL3S+q9k/U37BM3GfjpI6/nfGSkg=;
        b=bsXez2F5JabSHXO4Fz3B6IrFeTe/GmA3TUGAcKtkxW7epmSxZQXKjhRh6E1e5hip51
         LUpQaLf28pYPkJstRSsnRIchFYIqNOpkhk3Nq9Lj+eFhbsBUNpxiRx5RJjkC5Luj5Z3u
         Xfnv7ZW4gCos3IjMfelnA1JQEQEw+OxdNQCpSDc7TMnMILKCOsV2mi5aPkW5FZrkZ836
         p2WzzZq2KYoNghWCkFe9u7jA0tTGx9BsVSa2HEpd2J/bbco9shvmOn6zZtvjp9YOEy4H
         fbJj3MksvS8mCf7lXcJVhmja8EGYKs8XbmxSU0r5w5v7M77FgaWA31uw1Hha+8UuBBDM
         8I3w==
X-Gm-Message-State: AOJu0YzVUk7DKVxMx4Z1r/p9AEDDbumyz2Vs0hgZx+pA+9YpZ495sPik
	RjPCupZ7GQ7sF3h1abZLVsZR6BjugPm1RtKMdB1i9Ikg5nEUlUmCOMWVmcjw0cnjGWPcJK5WvCg
	JXQ82GEIAKg+8mnsBnvSkGyy79smJ0JYTsQeeWvL0
X-Gm-Gg: AeBDiesCbh+np0Yt3GbARAUTfQYVtx4eRAYekxN4kxOP2nmvE8OuxiZAifRg4fgmgT3
	kvf9nXP67LcAgv7YnoO1PZ+URLXS1xY359KezDmTZ6xWa15TMmpV/hOH8QkhZnrcMgi9TJ1NIkg
	YrXALZ5VFU+imC0IGJUYpnURkjyNR85h/Xq7r3lP0ZLhpPq4vAo2DUcfwfltEeiqVgr7N3FrUPe
	UkKeqp9THf3ALMti5iApYDdn16okHwyF0zMG1m2ZBoLVO+vknI6aEypE+LV6Sq+OQsvtUDm38tP
	Gpq0xxtpzQZtzDZB7Q==
X-Received: by 2002:a05:690c:dd4:b0:798:3051:2f06 with SMTP id
 00721157ae682-7a4d6544998mr18085867b3.53.1775183333311; Thu, 02 Apr 2026
 19:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403014517.142550-1-jiayuan.chen@linux.dev> <CANn89iJru14aPMCXMHmsek1S5TH+sLkczJKUPpcfZHnYxR9KEw@mail.gmail.com>
In-Reply-To: <CANn89iJru14aPMCXMHmsek1S5TH+sLkczJKUPpcfZHnYxR9KEw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 19:28:42 -0700
X-Gm-Features: AQROBzAvc4eSCrpxv7Dsz5Vt2of7OQ9lN3NLlQLvVJIiauIlJc71BlaoIe-DthU
Message-ID: <CANn89i+f=3o66Mr-O-c_w6t92=xU=qo4-mOuADDHvT9Ezatmkw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: skb: fix cross-cache free of KFENCE-allocated
 skb head
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Antonius <antonius@bluedragonsec.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, Mina Almasry <almasrymina@google.com>, 
	Eric Biggers <ebiggers@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Soheil Hassas Yeganeh <soheil@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274852-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bluedragonsec.com,davemloft.net,kernel.org,redhat.com,gmail.com,google.com,rbox.co,fb.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,bluedragonsec.com:email]
X-Rspamd-Queue-Id: 2AF18390619
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 7:23=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Apr 2, 2026 at 6:45=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
> >
> > SKB_SMALL_HEAD_CACHE_SIZE is intentionally set to a non-power-of-2
> > value (e.g. 704 on x86_64) to avoid collisions with generic kmalloc
> > bucket sizes. This ensures that skb_kfree_head() can reliably use
> > skb_end_offset to distinguish skb heads allocated from
> > skb_small_head_cache vs. generic kmalloc caches.
> >
> > However, when KFENCE is enabled, kfence_ksize() returns the exact
> > requested allocation size instead of the slab bucket size. If a caller
> > (e.g. bpf_test_init) allocates skb head data via kzalloc() and the
> > requested size happens to equal SKB_SMALL_HEAD_CACHE_SIZE, then
> > slab_build_skb() -> ksize() returns that exact value. After subtracting
> > skb_shared_info overhead, skb_end_offset ends up matching
> > SKB_SMALL_HEAD_HEADROOM, causing skb_kfree_head() to incorrectly free
> > the object to skb_small_head_cache instead of back to the original
> > kmalloc cache, resulting in a slab cross-cache free:
> >
> >   kmem_cache_free(skbuff_small_head): Wrong slab cache. Expected
> >   skbuff_small_head but got kmalloc-1k
> >
> > Fix this by always calling kfree(head) in skb_kfree_head(). This keeps
> > the free path generic and avoids allocator-specific misclassification
> > for KFENCE objects.
> >
> > Fixes: bf9f1baa279f ("net: add dedicated kmem_cache for typical/small s=
kb->head")
> > Reported-by: Antonius <antonius@bluedragonsec.com>
> > Closes: https://lore.kernel.org/netdev/CAK8a0jxC5L5N7hq-DT2_NhUyjBxrPoc=
oiDazzsBk4TGgT1r4-A@mail.gmail.com/
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Note: we can later in net-next remove skb_kfree_head() completely.

