Return-Path: <netdev+bounces-261582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOXAMD2roGlGlgQAu9opvQ
	(envelope-from <netdev+bounces-261582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:21:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FAA1AF04C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 372863020EAF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49724657E8;
	Thu, 26 Feb 2026 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="SEsGLP0S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C84657D8
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137235; cv=pass; b=hstbyR1enrzDG7Sr5Hr4MilC1QRyOVOwVSZF0GZ4tR8Ht8sgj+NbfZm9yb+tiaROhUmo9rjHJ0GrAL6krJ8xdD6Lj1ESfMHn1DQ8lyrBAGExyOP9mPWNE5Mbv3+2NeHtMoRHK62ZJnPKYkZzUjuzZy+z1g4JpLxqVIKDPlwopTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137235; c=relaxed/simple;
	bh=F7N3sIMVsu62v/9zcy03Xgf+/bGClwhYlchdyaZMHmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OacCxZ53iboGz934TKhUtu8V5Cg177KoOHhprbJq78p4UE+5zjRit/X8aOjY06TSDsWK81U3bbRkIs0JJ5jzRl/iZRA9OGGbO1Xiekadj0fg6lIQMxTHp3DFh2i6sIfIYS6TYlfY60f+UooD5I7wPKvh9goM5fmbUzuKMnpaoH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=SEsGLP0S; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1277d379936so1693583c88.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:20:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772137234; cv=none;
        d=google.com; s=arc-20240605;
        b=ACTZYx3S33kgko1KqarOOmxOFDuTLQ/x1LoKqFNCOu0aJozuP1rUPWujMZSkFr4ro5
         qxQe8hKip3INEfq0BIyxHbb3tfhWjGVHSKGorcm7kGFt/xXVlrkZPVRkJ6jQkEdYNh2u
         Vx5WDaxyJSQzh75CtLWrsKDSsUhF9pWWU0Tw1DtkTYHwN3fP31zhdnLSCEeb/Pu9B4T5
         4BgdrZ6LKSPDxrfW9lI+jualORgLMIM0hW6LKo48UQRl78GoowwuSuq/lqobkIjjVQGd
         SbfRb6zjhyKw38LV/InPLnbDSDgDwriRv6YD8TEj+JuGyAK0trMDkVTVBUUqxPGWCzW9
         0XhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qOpSQRUrPHhKbkluLZ6aMgtq61g5ReRWS4dJWWEl9iU=;
        fh=VgJGdtpv+IT04TABv/WGJC1RDOSQXQIEeyLWup8GF/0=;
        b=KNRDi7IaT5tzdnmDc00hQMA4V815Yo91uMGXl1b8pWqChuK3I1acbn2UNHlPmGVy+I
         1SryHc940dXpLd1vQ5PFn8uOMJRy3jrtoL040Z9Atkx39yeprsKpQYNfWcjznyKFsysR
         s5WylJE3aVR3yq0J7o6If4e0En/3mIJHGOagjwqv7qjTQleEotwN1XObmpdpUgeWYnoc
         NEGo75cp9zRA0EdE4Pg/WIQNl0G9vLI+Dcmrt3OqUfZ9GR0YIKFJCXbnt9cJQ6ZNpG/Z
         INLkRI1tvg86bhIo/wL2fqI3xj80iIaedZE8weE1f/uSDJ3/kPsQKBcOGnn5cu9KP1nB
         RtAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1772137234; x=1772742034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qOpSQRUrPHhKbkluLZ6aMgtq61g5ReRWS4dJWWEl9iU=;
        b=SEsGLP0SCOVF9ph037qPDFTKefTP4tnJjwXEuZq7pj9X1Jm16L1tDK6/ydiDWHGL1p
         9VmSgYy6OQWO2S8ICKN7R4+2aiSmn4JRSXxXDT7cQD41+/7ICxG7dl0BYGPPresLp8ZE
         7Y6quXuVMtZjo78JPdUs8g2kmr5aMqIlhNrR9uXKqC/S51Y/z4KpZxx1DDRPBlkjNlCW
         IbE7GGLHZs3T3E//N/yLut3yTq+p2gjbsjW+wPQzldHMfE9siwtt2uHiJPoYoF3epbmn
         AkBapjON2kI+WdVZgr/dToALPWLuUhxdvoEk2PeZUmTWkq+jElSJJRVW62KLvnsZHwFs
         TWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772137234; x=1772742034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOpSQRUrPHhKbkluLZ6aMgtq61g5ReRWS4dJWWEl9iU=;
        b=q52uiFxnBDcYwm0wv+bXLGoX/gA9a7WvQLt43RbJFYq1conhwB1z8OqmeXD4WYC5IW
         ssMafKEYAwXKNMHUVkvePL2OkNb7RgZc13+0nNAx4nQq7v+tZGQxrxMpwBqVy+ahK5T2
         SbSgQitaIslqGsdfcP5nZHq7sYvB+YVTlcPWum+88tfcebyjfU+0h4QtrZTchiGLPgXO
         bZSDP8GInDbpOlP6hfW2D4X1tg0DH5UcKWGTrxdOFCV7IWvBUIsvGAt+04D2KuEp4AoZ
         u54q6kgcbcxTO3jdbddbIjO5F+rbaxMY+fiNktq5IWuiMvezVHE4vkrC3oFFs0q/R5pl
         XEcA==
X-Forwarded-Encrypted: i=1; AJvYcCWxcgZ0n8xEC9D+UVDM1o1y/yt+KLkAOrmqQQd0qw4NnShXmCOd3JUIu7vlG3Pnp5Hvd79FM40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3l2fmqgl7jxsEoMV4lXQrC2BmU3jISWpWsbTkQF486PsoMFN9
	LeMTZlgYvbxbTrSOIxmijX9+HBg7vL8r/PPPbBZpQgzkUrNP+W9CfhjxNpVqrGmKx5ntdr18hcy
	GprE0/M2Uyeb5kWx3aLYQc++sny0eK2e5aO/21jSz+Q==
X-Gm-Gg: ATEYQzxg6h7NCxSnxSvNlxsznz4wXzBiMSY9SbisF7zVe9uK4gdyzZVWv900K/xcUHa
	vpgOMFEcacl07D2hGa3ohgwEAkV9wADa8cs8iFLSjE9jarJYDjjiCwrF4CAoIgUr9ccmnSw/62K
	9wOW+H2jgcflSRNsKo3r6A9EM5caNPIQoh2uubMx3NFewHwivIAdGtBrBvh0fTacEXOXzJ5+bAa
	eeFEOKGj3bAs3l6+VT1zxgyBHNwUpu+VPpTYdXb+v6TNTWlKQ6eOKoeQ4eD9GvULiNJd9ahdsaC
	QLt6PwmTp+BJseFZEvJF42t8ZXgyJHLkC2/ULROaSHEoATEb2XL7Nanp35cObXDZ9a4hsnuAFby
	M+4Qci+U5fEmGEfPR73i37pCD
X-Received: by 2002:a05:7022:e02:b0:124:9e46:82fb with SMTP id
 a92af1059eb24-1278fc5c92emr92315c88.38.1772137233483; Thu, 26 Feb 2026
 12:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226201600.222044-1-alice.kernel@fastmail.im> <20260226201600.222044-4-alice.kernel@fastmail.im>
In-Reply-To: <20260226201600.222044-4-alice.kernel@fastmail.im>
From: Alice Mikityanska <alice@isovalent.com>
Date: Thu, 26 Feb 2026 22:20:16 +0200
X-Gm-Features: AaiRm53AvvD1Sv2_MQbjNwGr2vpKM2BnIZIohuVroDp1pcN1-591IdhpnQZeQAg
Message-ID: <CAD0BsJVoC6icHqZbytPCKFKxgRM2FjOphhHAoULXjDdZQZXWUA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 03/12] geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[isovalent.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[isovalent.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261582-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org,lunn.ch,strlen.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@isovalent.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[isovalent.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,isovalent.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fastmail.im:email]
X-Rspamd-Queue-Id: 45FAA1AF04C
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 at 22:16, Alice Mikityanska
<alice.kernel@fastmail.im> wrote:
>
> From: Alice Mikityanska <alice@isovalent.com>
>
> GRO_LEGACY_MAX_SIZE = 65536; total_len being 65536 is too big to fit
> into a u16. As can be seen in skb_gro_receive, packets bigger or equal
> to gro_max_size (or GRO_LEGACY_MAX_SIZE) are dropped with -E2BIG. Apply
> the same boundary to geneve_post_decap_hint to avoid writing 65536 to a
> 16-bit iph->tot_len field with an overflow.
>
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> ---
>  drivers/net/geneve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 01cdd06102e0..7a26e2439d48 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -604,7 +604,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
>         ipv6h = (void *)skb->data + gro_hint->nested_nh_offset;
>         iph = (struct iphdr *)ipv6h;
>         total_len = skb->len - gro_hint->nested_nh_offset;
> -       if (total_len > GRO_LEGACY_MAX_SIZE)
> +       if (total_len >= GRO_LEGACY_MAX_SIZE)
>                 return -E2BIG;
>
>         /*
> --
> 2.52.0
>

Paolo, when I was looking at the surrounding code, I got a question
about your patch [1].

len = skb->len - gro_hint->nested_nh_offset;

This len is calculated as pseudo header len for checksum purposes. The
pseudo header len includes the UDP header and payload. Shouldn't it then
subtract nested_tp_offset (the beginning of the UDP header)? I.e. have
the same value of uh->len. I may be missing some context, but it caught
my eye, and I wanted to double-check.

[1]: https://lore.kernel.org/all/4a9a390588a429191e0ffe48ccdd288bb69e567e.1769011015.git.pabeni@redhat.com/

