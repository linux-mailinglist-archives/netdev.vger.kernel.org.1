Return-Path: <netdev+bounces-281076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJpjGTgB7GnuTgAAu9opvQ
	(envelope-from <netdev+bounces-281076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:48:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DEA464293
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C699E3018D5B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 23:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D8C325714;
	Fri, 24 Apr 2026 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Re+yzXAH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293B2F5485
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777074199; cv=pass; b=TqkBgOuD7tBgiqyhRPh2ht/hZlMJiEotgBRNkbM7s0Cxe06TXZuq6mTd7Pb/2XV5i6XPDyRVwhytPvDqV92aUkDdQZSGneSfez/mkvjjMun0fGeE5Kl6S+1CvJ8v9tK6uiS52ceM99M1se4VFoUJZPnvn329zgfb/yPbEIiw1r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777074199; c=relaxed/simple;
	bh=Syw3mAyVgAzWD/0LIQLcwHvIMw7PDmmqjwD+SpLpDBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEnTgqJyF4CvMIScOCA2uFxk8ntC4PJKgfx3Z7xlI6UDP/u6XQSHU0BJzElUNYve7P1XIAc2KTo5UV0PAKKFTVoHsnDMQXI/d9R6VJ4WGXGv61VQt0Dc0HIKqCW32opMScIxG/F3nZUx+eOZWJdvIwBjC6W6+aU4H9IeZLz8Hbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Re+yzXAH; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c8f9846c8so8225663c88.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 16:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777074198; cv=none;
        d=google.com; s=arc-20240605;
        b=Cvv68r7DtD8vY6v0cJrSVRlPKvBZ8SXIf6wi1wxzfU+CU84NEqQM8ubO/3G4kgASy2
         wObmEEcy+UyPIdRItjur6Oog+7YldHcqFpGXwRn5CoasvHSgW6osJeuk01/GKzNhECUq
         aWWc11dus4CKGswsRUl3udR+XyvWMP8okrdinrQYv/x2rwttK+knZa88kXwmZjhJ9Xkv
         bZCoqW7m7Ut2LchL+cKGQOcxEy27G9wVN2EWpsqgM4XBEUr2JEBmbZnkFsxQ/lzdXHWj
         ze/KfkaZ5U7N64TYiGX72WeZiFoQRuIM3RR539XHr7wIa4TFqrnzKki/kY4kbu0re4d3
         cU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ESB/gBxbgV7rGZ/8pNR7vuAzFSz0pZYdHaWbNc/1QUY=;
        fh=t1KBct2X9hARvc03fGuPXySaMBrFHGolkRFhGXc8h4Y=;
        b=kER1yq7zsxB1NSp3E+FwDnqN8TyIWE4ZTUmepXiYsg+oWq3+4GvKwGOGRxSAWfwz6Q
         HQo0/dKALyHexOCJIQ7j8AwTirllZaYQpSpDd+wcSXw1UhrOE112UIAocxN54QU/imix
         rjjSbZfCLcvNpFSDt1RY/TK/qN+cOJu7VA7vrKe7VhjIYKlDmXAvx6rdNQoqa/BbmP7E
         6nrzwhbXVCDgsGPkAyTps9EitB2/texF8mlVlSzjf9DKLsGpX9bpoFC1ZhUqMN1BW7jb
         BIx3W3k7pNtWnlDQc45pe2BoDONPF7/doZlT+uKTAdAizlF7KO7zpbeMMAoE06fHJUBv
         JKkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777074198; x=1777678998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESB/gBxbgV7rGZ/8pNR7vuAzFSz0pZYdHaWbNc/1QUY=;
        b=Re+yzXAH2rQo3QjJzrOphGj8oaYF9lEm7OZQJX+8HbhT5lLezjRXwq2+tGVNuCY4h8
         SOBKogU88Mrm7Yb2WvM4zP1Psv7hV5Z/PQGIHCUm+VF3IC5+UXIeurLRoE9cC9Qpo9eZ
         0mwlfuBBi+emD/HkeB6Xl06R2CUEzQfeiM1bOruG8ykZwyEqm/AJII4t1SNjXew7GWkx
         nzbOKkSwQaM4sB3npqPYXqPnWnaRhwUhbAIBrIvt0Sw0rekF3/gK2HCCOcrAyzR+0Un7
         b5skQAQgLHk2Q1mfWqg1X8YTcHlKBhkXcsL0ZD+yx1AaNVMjp0RErt0LdVaJQPHJYfPK
         01iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777074198; x=1777678998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ESB/gBxbgV7rGZ/8pNR7vuAzFSz0pZYdHaWbNc/1QUY=;
        b=Eh3+xu3ECFLdyQzE9el+p8BK14jiVOXesuELXzgSZIsWz769U7Wn0fITUoLqIFiRSV
         O0kd1TiNLyZozYTLTYrncMp3rd1djlFR+ogrQR450wnTd+mHkvI9dPlCmkSRn0MiHS3S
         HlPOqKk0D8Q4+lzLtJDw6Uyiht/Ep02AI0WpWYdrEHCjv9m03Vwt7SOKULoAPPYNjsfz
         eM/PHtgLj9E6EPhOpSkkksaFpewj2pvYdelPp92mTMgojj/8QHZxGyY7gksRHSY8YqaP
         Hhj0ODC1CQFPx543BieeX3A2p48medJGO0Xbe3vtATm/NUXe67x5H+WoUGTdGUP4UeC1
         K/dw==
X-Gm-Message-State: AOJu0YzhAAcMXtdun6CesFN8hixoM6fifwANiYTrH4osRImz/oujiY21
	U+KOvDlF01LaiOCEMnGkRNdcdmehJbdHjJOoujR83dwcFW1EpP48FGbbG5XDL/b9gxXzLn0trX2
	3EGhr4Upy6jEMSoMuA3qK8iDyROqdnDWTEUWUFJ4j
X-Gm-Gg: AeBDietwzOcYGM7XWBr4GMLQhGAHyedgmJwBvVRtduIL5mqb98vF0mF/F2Nr4wOOW+0
	+L4a6X4NjmUVKn1L35PJRN/sqLU43drMqRF90IZglOwJlBdw3Hvj6DZ9ZD+wJ9Hz6tFHrnyR8NL
	asfbshC7bRYu6fibcDJeGYOmaT0R3XQ+ryW7w1EbTtf9TYfsjQtwusr6NKF1stvEGDrxhtazhac
	WI8ifR/zMrJ/boQGocW2tgHxzbFORtsJ6jCVCrvvMo9oG6/CQD+Vqg+bZG0jmoVPSM5D3/2xsun
	n64eV8ZBZ8wROi3SFSeVzhFNEZdJaUfvfZ1GqsXCQ0CDXEIX+augWjpWMYgr4OlBuA8vC1Bnx0a
	lDSHmdp3gL/V2AQ2a63FN79G7LSgjsRD9sVWgG7HUyJBB6TAmWQQRkUtKalxuH1/Elq55aQKezA
	==
X-Received: by 2002:a05:7022:12b:b0:128:d5bd:357f with SMTP id
 a92af1059eb24-12c73fa779fmr17941532c88.30.1777074197134; Fri, 24 Apr 2026
 16:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424145843.74055-1-fw@strlen.de>
In-Reply-To: <20260424145843.74055-1-fw@strlen.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 24 Apr 2026 16:43:06 -0700
X-Gm-Features: AQROBzAR6ie_z1WPiopOr7AnsFJE2zb2uxDTN9Sj5BgcF5yWqjbQxZddD0rNeqA
Message-ID: <CAAVpQUA6R6Bbw94=kh6uywErLgbAixVgCpjVhToLHFbGDa9uOw@mail.gmail.com>
Subject: Re: [PATCH net] neigh: let neigh_xmit take skb ownership
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, idosch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D2DEA464293
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281076-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,strlen.de:email]

On Fri, Apr 24, 2026 at 8:00=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> neigh_xmit always releases the skb, except when no neighbour table is
> found. But even the first added user of neigh_xmit (mpls) relied on
> neigh_xmit to release the skb (or queue it for tx).
>
> sashiko reported:
>  If neigh_xmit() is called with an uninitialized neighbor table (for
>  example, NEIGH_ND_TABLE when IPv6 is disabled), it returns -EAFNOSUPPORT
>  and bypasses its internal out_kfree_skb error path.  Because the return
>  value of neigh_xmit() is ignored here, does this leak the SKB?
>
> Assume full ownership and remove the last code path that doesn't
> xmit or free skb.
>
> Fixes: 4fd3d7d9e868 ("neigh: Add helper function neigh_xmit")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  could followup in -next to make it "void",

Makes sense.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

