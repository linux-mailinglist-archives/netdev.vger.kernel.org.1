Return-Path: <netdev+bounces-252114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOzPBwJ0cWm3HAAAu9opvQ
	(envelope-from <netdev+bounces-252114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:49:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B33600D9
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CF263C283F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3DE30EF68;
	Thu, 22 Jan 2026 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pn1LttlK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F1E21FF5B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769042937; cv=pass; b=JYKYGmXGWmNoz5fsJTQVCx/MN4diyobc3RYjOGr0e1liDyu2UaYK81IjdT/K5cc3KGwQaLvZHzZfRp3/a0GlGcmPfeIwTwe737GeFjWdFqYDp3FBxE0dlrnKSrS1ZYr5TCKvQ8HT66JMtPgE2evAw+Nlc/idRVnhwuVpv6eNbKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769042937; c=relaxed/simple;
	bh=STgDya/rrELwxBw/nR4uv/MTvvetLae1Em5BNoXv234=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/Wi3R3hnAm0goSI+uj5w+m3yFVk6PlgtmBB9IZyxkqEBV/XmsULkaty1e53cgrdZhL90MBVTdPkN6EANg4e2phZJu5E7ueaN2QuiqvNGlMphvq2vv2uo+KUYvzXdWgmM43HjuxS2UZY7iJ0XyHGRN55rBWMx24xvLh0tYn9K0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pn1LttlK; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so143057a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:48:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769042935; cv=none;
        d=google.com; s=arc-20240605;
        b=b6gfyBqlzZAVBC0sG3npqBQ50AnbmRo/qaK5YC0RAl/AEcc7riBNrMo6h5DmGYCo6L
         fWWBDoQYHQ3EcVrWtoXwLhuDffjjzljPFEQslNn2ea4e7CyGrgkC/Uw7XFzh0mdEMZXd
         KCgrmeDZTRH/5JVTE8XyrPEdq5ildM2IlwE+qR9kUaOjrQkHLylGEQxvFso1ivC1ZgZ4
         DgFRXaGEviPLJOLHdomdFHD/YSJyQalux5JVxzELnGFqi+rqJX1RQRVQtKAQrfLLNE6k
         YDZMfWvkWqhCvlYDnXllgQZw9IFPruqhJ6a2Mf0ZdyFbM1h+zajA/t1J5saqKN9RINEV
         jsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b5+P2+OzW2g3dFBRbXD1e9SjxU7d32t2ium8U07J7Q0=;
        fh=Q5L3/gK/RMyqBrg57YB6djo1GcJq5y+OuxPbGgj+wMk=;
        b=CV8NVA9TTlXjaJ2c2XLjsMRLRv+STFbrhYHV5cRp1+A8NO287AN8SWGFZElqj0uzBE
         vuQ7qmo2N56J29qGbde8GJsAEOzxBHUe2Km5fuizzibjjM3SbUUct6XfJXL57vh2r7d+
         9GWL5OVj0fjicYg0WNc7KGbV/T6inScwXEzl7rU/GzUCVxuq/2RqTyS3SU2AQoiSFe0H
         /24voU72ok7qed5PEuh2S6Vdu/V97u6KxpSgtPBpsebVZI4DgJeA033hea4GgaSx86Zc
         3kAEKuCezj7guj2X/dNLwFs4uAM7zOAhV8KhztDisTyXmIli0Q4vrVQW81nXMRqhUpSQ
         rsKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769042934; x=1769647734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5+P2+OzW2g3dFBRbXD1e9SjxU7d32t2ium8U07J7Q0=;
        b=Pn1LttlKQaWqXKll9liL+wWeIuaysNIzXRoKBluFBwRXN/z/M0eDEgxhU1/hFJ+Oby
         OwBWFtxP4U+zI3C0UBZS7Gyu1M4W9Q59V5J+jTcfQOrnGzvSRNTbeETR3dETX2fL8RaG
         x8U+gbekDBubYc3yRE3E7KeGHAx9jNWOgpJtnnmkSL5zrYKC0KvJf6DMiZL9xQGgYXPR
         WUwRawty91v7OZCh74RBm1fLSKWzN1bDdwTG6pHM6wFMLwmfqBPw+0nynhUuCbIZ4JqB
         oZdN7/cDOkLKSmY/IsSD2nW8IX+2MTB9XNDFmDN5GzQg2w5W8CnV3mAfpWMPYSMvMVwy
         et9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769042934; x=1769647734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b5+P2+OzW2g3dFBRbXD1e9SjxU7d32t2ium8U07J7Q0=;
        b=iDqh3SjV25Gh5m/WJptePpWRVfjHxGXvs29Qhk66vio3vZiL4w0LuepLW/jAOQ6jz/
         zlwPcnER/rYJIGUxLS2OYs1BNOwM0ar0ZPPTiO3m60fr3yWHOTNcjs7MtlIoKF2+QWX5
         Vjcki3jHhMWcr/lz7vh/osir1DO1yD+gikBSsbUFDIqelMGbSEPavbH59SMQLCRjGock
         Z8qNsezADor0mI3FmmX3X/PQpFSL+kWOxSm5D/zJhdVeQ07ggwcfmD8D7XMcCW7ziWpl
         +TblGiL9mqYbOM0S2jW2OjBS+vqDIkGOD7cXzT3cSmlLVWgxqoytYzePoI0kCdGSpxQW
         dprQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIyglnZX7XEShC73rrIjPmIv9BFyjDYtxG3x5RpY8jC5xADXrr7NdRzR0zFmoAOigXsdqSCUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZSdCv0RJtiJ/irVKM5JJq0MAQzyF7A0ntqv37MhQUAUxfznw
	asn+HfDB2zQQBYHiWEwLpCT3Jxgqdw6FQwH4ugZA6SJp7IrIAMi+LcXFQ9yYErz0brR9G+FwJ2c
	h5k4CVmx2MMiGe/UcnMQxbTRXvsP5VQZjH+RCe/UD
X-Gm-Gg: AZuq6aLTS5m+dZOjsttoz/c3BUyodOf1kXyZGWrcG0uB8jveYuy99ORyLc2q/RA7Ek/
	/4nfdrKQcT7hozp1C7sR6RC8tdKaS5qGB+ROvHn+UyoIdbr8fZRnv5kKwuxh+frgZvAtY3aiezq
	3qE7copTbxenIPbDXLVTe7WnDtOPv6URpvmyXXJR29etAKChSRo0cenhaToDiLc6Y7Y1h69fXtV
	ZFrpVhwwlHf/1R6Sn7Sy4kJ4Witu5p9CO5jiKTy5flyH6IDwzqCqndajnkPoC9keQJ0xCY=
X-Received: by 2002:a17:90b:4f4a:b0:353:2e1:95f6 with SMTP id
 98e67ed59e1d1-35302e19f6emr3140023a91.32.1769042934569; Wed, 21 Jan 2026
 16:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhR4d7WXOVR7Y9ee2+=-t2nThzOo-ySMB+5x_87LfBJbZw@mail.gmail.com>
 <20260120155738.982771-1-whrosenb@asu.edu>
In-Reply-To: <20260120155738.982771-1-whrosenb@asu.edu>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Jan 2026 19:48:43 -0500
X-Gm-Features: AZwV_Qi1HCix4xsckn9CD1qWcc2lwKyi1WtdhvcHnLqnNUUcK8FpFKmTthwIsB4
Message-ID: <CAHC9VhRbZoApQE07giMxd5j3ri99uMuN8SQF7d6AgOZEkxuQJg@mail.gmail.com>
Subject: Re: [PATCH] cipso: harden use of skb_cow() in cipso_v4_skbuff_setattr()
To: Will Rosenberg <whrosenb@asu.edu>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[paul-moore.com,none];
	TAGGED_FROM(0.00)[bounces-252114-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 02B33600D9
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 10:57=E2=80=AFAM Will Rosenberg <whrosenb@asu.edu> =
wrote:
>
> If skb_cow() is passed a headroom <=3D -NET_SKB_PAD, it will trigger a
> BUG. As a result, use cases should avoid calling with a headroom that
> is negative to prevent triggering this issue.
>
> This is the same code pattern fixed in Commit 58fc7342b529 ("ipv6:
> BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()").
>
> In cipso_v4_skbuff_setattr(), len_delta can become negative, leading to
> a negative headroom passed to skb_cow(). However, the BUG is not
> triggerable because the condition headroom <=3D -NET_SKB_PAD cannot be
> satisfied due to limits on the IPv4 options header size.
>
> Avoid potential problems in the future by only using skb_cow() to grow
> the skb headroom.
>
> Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
> ---
>
> Notes:
>     Given that IPv4 option length should not change,
>     this may not be a worthwhile patch.
>
>     Apologies in advance if this ends up being a waste
>     of time.
>
>  net/ipv4/cipso_ipv4.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I think it's a reasonable thing to do in an effort to avoid future
problems.  Thanks Will.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 709021197e1c..32b951ebc0c2 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -2196,7 +2196,8 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
>         /* if we don't ensure enough headroom we could panic on the skb_p=
ush()
>          * call below so make sure we have enough, we are also "mangling"=
 the
>          * packet so we should probably do a copy-on-write call anyway */
> -       ret_val =3D skb_cow(skb, skb_headroom(skb) + len_delta);
> +       ret_val =3D skb_cow(skb,
> +                         skb_headroom(skb) + (len_delta > 0 ? len_delta =
: 0));
>         if (ret_val < 0)
>                 return ret_val;
>
>
> base-commit: 58bae918d73e3b6cd57d1e39fcf7c75c7dd1a8fe
> --
> 2.34.1

--=20
paul-moore.com

