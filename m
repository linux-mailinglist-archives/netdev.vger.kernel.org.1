Return-Path: <netdev+bounces-277250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fH4aB/SN2Gm+fAgAu9opvQ
	(envelope-from <netdev+bounces-277250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:43:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F53D3D25A2
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FAEC300B07C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14DD3321A2;
	Fri, 10 Apr 2026 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpnP5sWD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B312206A7
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 05:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775799792; cv=pass; b=czd8QveUM6zIkKwAfn0ioos4mJ2biYjc3uRYE+ISREfvVubQEbl2QRUOFIMynTxXcGAs8/gFAVZozwkvkf8TlzmUkTzAMNDJ5VurEufA3ZmAA1mF96WRIWKhe+HeTgVIgKHanh7hugYA2sBrkFWEr5V9X//dNn5fQlEhdt+RoR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775799792; c=relaxed/simple;
	bh=rklJJS3t0AHyQ4VzOjeh+EUsSSkGxZFW3T222h2Zcd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0zZj/UI8ZzuMeDQHwMJDuFSREReq9nFxTOg1zfHgi7ViCYdS8PPuG/BmxvKox7AFolw4Xpq4xnjPB/jN4ZHdBKqjrWCsu4MJcTBMeZvqubsDfi2YRcbUwH0WvpLqtckV0pVWt560o7DrqzfflstSc/Q1hXbYeQNoWeGWr0gmqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpnP5sWD; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso1322382f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 22:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775799790; cv=none;
        d=google.com; s=arc-20240605;
        b=MF7X/zfzxdi+1Cn9nvun7T+FHZRq6t7E4UnaAxbpm+3YsTooIMN4/mrjJbYN8HpKqS
         rcjDbJdtBnt+isL6QiPPOZfrkA1cruMTGTncZOfubQkvOP8fI613o0nrFZ50W4JnvsRJ
         VCLaCihi2FVczbKs7H40b7CwKQrlLdz4pj/xmUW+0gijoM7epVElY1qsxyBhMogR+bRR
         lxhyF7BvbJEVwnUMGpVS9Sboq311ax/f+yuDh19D7XgdUNvU2wTltqVX+tPNyC1er5NR
         jM0IuH32GB4ngX7tymO/DZbon6bAvTeOQhO5JsgfWd24W4JGf8ZCjNBPO/QFKsUVddYg
         2TIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U1pt5x+EZNVQ/9L2esCcdERqDp98YgPBmh2Q0zovV4k=;
        fh=W2GGfhWzd/L5MFflZMKO1UayyzNkv6aAXzP61V/XEE0=;
        b=YpK1cL50BbjRkscQObVrEBVVYQrSvIlH8l2pJkL4nKNyP2MExev0qpNNOcNvBw4kia
         L313lxyXZp4d/0bCaoXP7HFtvnTm3CK7Z6+vzDfszcEeXNGIADMWD3O5ZMhpL2MW2Son
         WLDfp+jjqjVI/GPaSAwsEKsxbzm9rOpEBTfhrsuaMEEVEEQ/KDz/xAgtkd5wkz9++omR
         kzke+DAx7Z6gCuJrz/5/uQaU0Zy0KObwjKWf0oPKfIO7CzULwtlF534Fap9wuPhqVTIc
         GvHHyQ2tM0erPKkVjl2ZFAqWp/DgYP42k0ZA7aRuV2/j03LoRUE9Kt+GmmhXOGzYQSJF
         EUpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775799790; x=1776404590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1pt5x+EZNVQ/9L2esCcdERqDp98YgPBmh2Q0zovV4k=;
        b=LpnP5sWDaSoNsUiasi5E9KniRmzzBItM0KsLGn1QFlpiY9/HtV73Bj4z/DpaAlkxee
         4Az9kAcG8e6dSfBJyDqRGOYcKBRTzzlJoW8tyNRFS4/xZdgKh2+AmsIa/VlkH8AWYjql
         kM3De+g1Zgftgyp2zzaYtS52ihZgyO01mA3u0nczU6qcrLUKbL4cIcz+nbuCJlYQweJg
         n16HCQumAGeGrc8BCaMH8eG0JIrxz22MxkTlt0ZEJYy8P+7F8YVoxSCA8cmmROl7H7wG
         sDN7iEm8bMKQw2+l4lB/go5/iCMg0+PpAGI/v7wo1WdeCZLwDyoVCXz5sw2A0pegVnqf
         lrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775799790; x=1776404590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U1pt5x+EZNVQ/9L2esCcdERqDp98YgPBmh2Q0zovV4k=;
        b=q00ANooM58pULZk8m+WGm22X5ZgYo6zWjCFp1OkTxccqngi04KKdNcdvkopr/YqZGq
         w7Aog4DfmfYfVdHUP17NUkXvgzNIg+mUGg1LiMHfD+nEZ3rFM4saGjJRzlLz4DAwYeF8
         WTt13FJoa5iBhGL30GvtxUCXdWT380CqRvEJ+9E8SaGJbBZQSbiH89CNifxeEWY1ST53
         W31GP6KoP5+lmK+fW5Tt5j/w+qq3Bhw+P5UEA8isTQHg1DXLZqQUVqZHrc+nH/Flm8oJ
         UufkOpXGhF36KbDGA3sPTFoF3ATBmgK3YSXUGNvg6UW/U5mgCkVz6z/ilosythpI+Wds
         FHgA==
X-Forwarded-Encrypted: i=1; AJvYcCVqNEHyWdP5OLpdxohlQrpjrarNVw71luuDxSn2T/ko4FScN79W94tmgJi2X7p6Uq6mbbGQxSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLK2LooCVQDr5agv5yskG/5bWXrhIlCVCoH3Qwo5LIRy0EZp9O
	88PVpVTYy2ZsOpPla//MGyV5FMWVWziIRRrwC1NClUdYfW+HIC+64lfHN0oLyMejPUhbzS7Y7xg
	SLKnoqez4Kkk3lWqMKZ47BfUdxmG1L7TUSJxBKwlu
X-Gm-Gg: AeBDiesxCCtSbZqFETHn3CXwPW6oviEdESg+a4xlg9qusamvS7N23Xx+MDpUVgw6oA9
	oBDHIsdWwQB9jVpUL3VpR5QzTqYfcJmgkVJnv2RF6tjiqt39IjR2jGthUd1X5JLf3vkySfWBUrX
	COxIMouLWwa7rhqcgOYyqVueXQpTLCDgbiGZvIReIi5b9/GY/jtacTlRYaGP3R9cYFFiE52Uyd8
	B+4oC8eAvTrbeHEFv1Rqpr+3tMRpTsGqcSVjYS8MxwtdtJ+Meoxhl4yujDsiF8LsWiEVsrPvgX5
	gHWnEYw9OifVK77thpq6SZ9rIkjM4FD/30U1sWhyC0b9wVHvIkO9keUSSI8=
X-Received: by 2002:a5d:5d0b:0:b0:439:b59e:5e65 with SMTP id
 ffacd0b85a97d-43d6427b770mr2432728f8f.6.1775799789589; Thu, 09 Apr 2026
 22:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-binder-netlink-v2-0-c0d327d15435@google.com>
 <20260408-binder-netlink-v2-1-c0d327d15435@google.com> <a12cc023-629e-457d-af02-4c481024dda0@lunn.ch>
In-Reply-To: <a12cc023-629e-457d-af02-4c481024dda0@lunn.ch>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 10 Apr 2026 07:42:57 +0200
X-Gm-Features: AQROBzDO1-pXW1WE9egnGqp-vaAZUj57O5qVLNjOBzOqwnHEiR-EFGeoLY8CTpg
Message-ID: <CAH5fLgii7gkjpn5bkj-dd8VWkFGr_uTHjc292+GM9OA5qUJ+PQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] rust: netlink: add raw netlink abstraction
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277250-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: 5F53D3D25A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 11:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +__rust_helper void rust_helper_genlmsg_cancel(struct sk_buff *skb, voi=
d *hdr)
> > +{
> > +     return genlmsg_cancel(skb, hdr);
> > +}
> > +
> > +__rust_helper void rust_helper_genlmsg_end(struct sk_buff *skb, void *=
hdr)
> > +{
> > +     return genlmsg_end(skb, hdr);
> > +}
> > +
> > +__rust_helper void rust_helper_nlmsg_free(struct sk_buff *skb)
> > +{
> > +     return nlmsg_free(skb);
> > +}
>
> It is a bit odd for a void function to call return like this,
> especially when the functions they are calling are also void
> functions.

Oh you're right. I think that's what we call a copy-paste mistake.
I'll fix it up in the next version.

Alice

