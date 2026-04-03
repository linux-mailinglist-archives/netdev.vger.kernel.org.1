Return-Path: <netdev+bounces-275001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCaLGnCnz2mZyQYAu9opvQ
	(envelope-from <netdev+bounces-275001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:41:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E73393C6A
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4D8230420A2
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE1538836F;
	Fri,  3 Apr 2026 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEg8/pBT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A731D375
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216330; cv=pass; b=M2q/sxF5+BhU6IsLIsVqizE3/ePbzsJXE9p911UaYYlis1F0FaR7rj7/bKneEF+mgYbbRJ5JC+Zx+DKn9wPxXqwYv4BQhkJpSkZBeWMhHpuNBTATzaOyzX7KoFNGEzc53XTxDSE7l5JSaRh5uKsA0KTns16R2SFfkgtKBnNtX7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216330; c=relaxed/simple;
	bh=H8sKRlQ3+ZzjIE9MX97CM/8S795K+wCmu9114lqHi/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHWwteWhN9gWDCWAk3bFOmPTC6bjStNm34mNl5Egl/fLlnTw2jRt2O2HmRdgcDX++3xz+445+0N2y+QxyNOc4wugDLkz61KbMidw6lHB7FhnCCiSjthTxmsc74kZRAt4V7aBP+0619D0VAY8elG8sLPhWSbQS3yXebRbZXW9wbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEg8/pBT; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d6144877aso10676311cf.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 04:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775216328; cv=none;
        d=google.com; s=arc-20240605;
        b=MVMUtwsbFkePJ5iiAvGwLMsiJpct9n2rUN3EE8GBgIwm75H1p3OEyGI5LXPI2kxjy2
         BomwUgxlcLqSFfknyqTYxRWAbIpKKvjOQj56A7TSClJmVCkfopvAthnaFqG9DwCm/CnB
         WA5Pqv7KuZ3SglKTyUK6B8tDVW7afx6vyuTQJcTu/RtI52xDRKbNtOipO4WhC0RcCa4s
         sT5Tsvw21+IHUqU09TW4hjJlrAf7g8dOt4Qa0FINMqtQ2bJ2rr+B3JzAK+/sy8a/tXcO
         VbpZOyXluDoYxVVHYpMpGZTdxVwsaM+LREJWGPOHhd3jM2lWolk2kQks+gh7yxC3cC3S
         drkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVNHDhWYudXQme+89+nP//p0066kVABIVtlnSuAq2G8=;
        fh=t2SCG7YeH48iTNh2TUkTkFoj9F2955ZLVxTtEOR4XdU=;
        b=PeLrunImBqJQoCz5vLrEThE1KhQQpA1PcbcQko+43g+jLtaHmePZOw0iS7YFGKLvpL
         yiZRMJ+oB3/AZSX2oK1iTPgIN3tD3ZGoTQs1i0n5FLdOFoNlk0ttQMJHwBYEzAO+PSrz
         nccoKiUA18RK/lJTE58Q1RJdI8Gl7LouBOyk/B6Cd2+LVsRAQhQZkNWzfSvNi2tEoRbm
         GzlYG1vASoabsZyE/oQtzaf+NWGauQzi7wG3dUMcx8Ii75AQ7HH32oouCeJ+YgDfdtk8
         fh7mnohPwPxaBSmTagYnu9V1CubyheXZvKOZg9uIKpx/bJV+P7SeRjHTPhRdNiSezg88
         O9kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775216328; x=1775821128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVNHDhWYudXQme+89+nP//p0066kVABIVtlnSuAq2G8=;
        b=AEg8/pBTTH3oqPYWSfBKBn3xBCvsKxHNV2AT9mEYrkYb8u6g/e1RfMWZ5V75nx2yDV
         b8K62t71Vb/iwVrPDJ5bgaWoCC4AU2rpPHERHhA+e3OdzlICW8kAHENqFEBcyA0VzGyS
         gbo5aFZ5tljdZ6cmdyWT+YuqxwRYLBDZeArFJ8kHA00HR4KrqZ+9zLUUrfhvtALqjxiT
         Mqk1IXozj+Qey2uIniufbR3+mvNq9m/wSBXZWIXgV9TcrsgZITSFs+CHgl5wja97CgHv
         OD84US9fZ8cIgdpzZckiO/9rP2kvm4HW+z42dQ5Bsa+IoLyh6A5TkulGbMHcPOyyxaO7
         U2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775216328; x=1775821128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVNHDhWYudXQme+89+nP//p0066kVABIVtlnSuAq2G8=;
        b=AWICAO6Jmi3/siWbMgIzONz/hvvqYn/1b2+HTxaKj2a1zDd4emJYAHxfXE1JTcVxIt
         AZTlO5naTwHONHiLxVFUHm4jj7KDQlQWrwx9/daiwAVPG8AfMRrwBCHXduhyLzmwIi80
         GkCaczm0YBo317ZHCHKRlUQU6L9sqq+/Xr74sylu5GT/QptNS1QrHEX1J5w4DX2ac9ct
         dJwu5LUO5G6R+B0AeTRiLmukiENjYMYcKyURFw8eFZCHQvzUvXcZU5FadUtJNEdeGfe6
         Znt9LSqHSKINEs3weDrSuvYpWVy1n8xLlUOsY/qp4fKbXBhLUwYSJsvjvcr++LCQ6UBh
         zXpA==
X-Forwarded-Encrypted: i=1; AJvYcCXwbCAZxkoxthiKC9R1q0l/lPDKDdbFQ7jozj2KP39FhZAAi0Mttctua6PR8pGdgN/rrXRC6ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHcwXiHihdBXbxCjzfZrRdw0i0Ys8cy6PvcJN2vt2CyeCS2UfK
	YdZxFt3W61y0JlZHq+TZSZ6r2RLfNnw8RUhVdfTGldGeUa/5TSetZwPr2Sl2K/orYf56rmRC4Yn
	ena9NZRUNkewCi/1JexFFWrcOGrNxfs6Gntc0kMBM
X-Gm-Gg: ATEYQzwAnD5YxSb3MhjyOoPnffW7tHavJYSFF0OdwvljpIkZHX9YYE0uys7RvYIZGLK
	GRIvb2ue3nIM29ORJM08+EGN7yC0g5RkHsrPqcVGDf9Z9Ry6zgtMPZ9sOnW8CADuatJh9RPC9Ly
	8MLbDXGpOBw08c4Zmo1IZuvwGJlPqsltDIIdnAl3CCOoSh+BdqQzXAoqv0oUvcarP4Fzrqm1xLQ
	My+CpmwRT99cM0gJGit/z+a7B8eOKoBCPaeSIkzYwcieSHcjnfzK/o4Mua1/43Ogt25HZs2LiYh
	vHhsYPcfVQW87hqi4w==
X-Received: by 2002:a05:622a:758b:b0:50b:3d9f:3846 with SMTP id
 d75a77b69052e-50d62adc9e0mr32334821cf.50.1775216328024; Fri, 03 Apr 2026
 04:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403110238.16596-1-devnexen@gmail.com>
In-Reply-To: <20260403110238.16596-1-devnexen@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Apr 2026 04:38:35 -0700
X-Gm-Features: AQROBzBobV1nZUDBbz3MMM4_4uWlxzWA8wOrJ3E4mzFqSRyYMLaiPv5QHm5Rddo
Message-ID: <CANn89iJiB6QQ6qPQSnXLOqG_NhsqV-5J5ndSyKcf27pN3EeiMw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_nat: fix inner IP header checksum in ICMP
 error packets
To: David Carlier <devnexen@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275001-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9E73393C6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 4:02=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Update the inner IP header checksum when rewriting addresses
> inside ICMP error payloads, matching netfilter's nf_nat_ipv4_manip_pkt()
> behavior.
>
> Fixes: b4219952356b ("[PKT_SCHED]: Add stateless NAT")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  net/sched/act_nat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> index abb332dee836..cd1d299da57c 100644
> --- a/net/sched/act_nat.c
> +++ b/net/sched/act_nat.c
> @@ -242,7 +242,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb=
,
>                 new_addr &=3D mask;
>                 new_addr |=3D addr & ~mask;
>
> -               /* XXX Fix up the inner checksums. */
> +               /* Update inner IP header checksum after address rewrite =
*/
> +               csum_replace4(&iph->check, addr, new_addr);
> +

~20 years old code, are we sure this fix is needed?
How was this patch was tested?

A selftest would be great.

