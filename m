Return-Path: <netdev+bounces-298477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0YXTApqtK2oWBwQAu9opvQ
	(envelope-from <netdev+bounces-298477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:56:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DF26770C3
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:56:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="F804j2R/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298477-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298477-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32929328EB08
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58DB3D16E7;
	Fri, 12 Jun 2026 06:55:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCF39656D
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:55:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247324; cv=pass; b=Iwnn922xmnsP0B/PgmrvpnWheJFjOVtoucextAObkGm0TXJYzs7gy+dC9cz1yk8tFfCDhpxTuCts91VTGYwHCvV1NSQbN55qQJF37zl6bnh7XlOEEyJ5OIpc6txxTFqFq/NP+dfim7qzxua2VACBi2sJT4J4vk9dq4GS9Ewjit0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247324; c=relaxed/simple;
	bh=lGD0Zw79UeOYEp/Iar43IpAOp/FzmPhnBGmmwaWHB58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrrKsZ1OWCIYjU8gG7/9Qn6CHUUfVCZTjUD+o3h5pAKzFzJ9GPCaTDrJ4B4hkzisE2CTKyauX91WdODOcHY8XPaCmuzcN5UZ+2F9Qqq8zLtKT4XENUXuQd27NIvPKjr/Lc8IIiDYZDO3TWa+rP6quv031Lzt29osipzgPfS79M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F804j2R/; arc=pass smtp.client-ip=74.125.82.48
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137dd3af345so583824c88.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247322; cv=none;
        d=google.com; s=arc-20240605;
        b=Y/wOTMYL6piAFh/tQl0YSU0NyPBFEwirKFnmJgIiOAaiEDB8GWn+50wgOo+H/GZ4Tj
         Km8UdSw+gi11Wu9d/Pu8f+NqZbv4b1hS6gISV7AWlJgfFlm/JFiS8K3MyeOREoTqAB+X
         SIIZe03KIrimjq5JzKN/nf0++xsBNrOsrldO2S0FR9RjI0UdQcDyJRqF3dQZcPfwVUGe
         4eeLCar3KX8bbTSYgiL2kD6ep3X4RVkgLZXuSv95v2MJdqWbWjxoFer0Io0pyq7lIvHX
         BgYQQmJDvNPLuMXyP1QwkKO4XVu1YiRiWSeZfhUcwf9BnrXdh4wnI0+jDGv/72bJinFb
         kHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lGD0Zw79UeOYEp/Iar43IpAOp/FzmPhnBGmmwaWHB58=;
        fh=JvLyiDOkNe3Cn8M0Ueu7iV8Bk8YSSgGNM2Ot3ZlIxvw=;
        b=gouffcJ1kdz7anYOJJoQRgIQ+8Hdxd866ZdJzz5VLmAE4AI8MG37yG39jTlVF41z2/
         RcKBbp/fAeKFGwcpW45G8J1+KfecR+JGYBKzBGPGbU8XsuLPQgTVj4UfC5U1P5IDojkR
         jGv3Tp2FV6BkWG+BsYVmn3p39m2iOoeCk39FBTSrEnjozzs3dHr/61LkIo7ilXAwqvcw
         5PQtyqnKPHponHZWMZqy5SHBTnw5tFENsBgun5dDiq+6QlCxE2voN5oOPMs0kw6I2hYM
         NzhVCXfprvVB1UeD+L3vpyBI2QkXkHj/cszisbVeO87ccWlfW79Z1AAIEFUmpZHYtIZU
         r4cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781247322; x=1781852122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGD0Zw79UeOYEp/Iar43IpAOp/FzmPhnBGmmwaWHB58=;
        b=F804j2R/0SRYv6zsT2GSsTGO/PxUPiDKURF9nd5dnOKyxT8lXKA+lfNg1TIdCl423r
         skflsC/JFiVO1K4StVXwmQEgv5AiU8oXvdJXT9jnraZse+KlS3KdUZYtsx/Al1ZYt0xZ
         mj/PWz3PwnCfiCMkTn4xxv8wkLCW+BTLrYCnZJ861R4EYHyIl7RuashU2EQpevBjymfV
         WUMP7nQEx9ZKntVW/4Z2F4o1bRACK+6Ots+0GkaR6Y/leJfc8sbPjaRDdaI4vVlGkTry
         WIL5Bx0NedYIeCOMtBh761ml2sjDiFScPNPNHJyjsBASnNi3YROBmbrQQS3s7Vj1XJdz
         uf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247322; x=1781852122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGD0Zw79UeOYEp/Iar43IpAOp/FzmPhnBGmmwaWHB58=;
        b=JOvqkunX7fjVkdkx417LPg9pLG0iXd6DKsn4tn/0bSE2cH0VXMYW38CVMYC10HHF5f
         3Z4mim0XiJigzf+p2RXA+8EXxbgieluHegnKtTGgARGlkK4xHKgDgz9pCvi48oV2y2mN
         eujFnI7uUYTykZFlBsCXtNgUFlRurQ8oczQ8Zi+8zx2mABPSqUUjzJvd31+t/5+YnyOh
         hhd/rKg4lYA7WJUMILLyr/MvpWlxnhpT5P/Nf+x1KwkKWJDvptl9/q4+dIvufyGR00iV
         KrZfV7kx0dBndJNlZjKfByk7NdsdgC3D1wplrTVRGmsTx61DERWbP6K97av5DJIsI35M
         09EQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TwT0qkz+wu03wrmE83TO/T8bbMS1XoJihRs086zeFeFiXfqQeqPB4yV3gkC0u57aFnpkDwUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbui9MtPRq/pk9mrs78kQ25ve3RCz+bl2i2XNQypawTgSt5ul
	W15npvOmAIhXmlUQaZEllaMSFOyGOS19hnvIGkD7Ngdn6F39BBoLF4bu/Ew1Q8CGbGAvomNJiic
	mTlixCIs6VAysNeV6BttennpkIcNhFvFaJyWx44oO
X-Gm-Gg: Acq92OEX6vX7T2dRo0mKVJ8z6X96HyE/mPvqtblRWFdxg4KXuHmySfwFNqiIYCmOD9s
	8MwG313AibaAMamNURt41PYOFbo00/SlUiQNnzwAm1gtR9vwjat0zFSIzK+gqfVdbnWyj3klZWH
	Askk+wdMm8sin3hHJU7YU6pD5R7LvUgkJOxTcgUdI7CFsJ0KUpQbekE620SsITSbN1y38P3II4C
	aK6qQCRqXZ/L8pmgT03srfuZt1aFD7sTq6zNN+Z+oHqYphB3E7moTkR/xszpx2aSFQZyphvefup
	9gK4KbKcd6tn89j2q0Zrpm/2lqY/WLELcoMAp6Q4SSvqhueOeDo8xMA/K+JwMzOB29SFeOU/9Wa
	MyvEI5sW4Ro7prG/gORaaSY84VGBSJyVzRAUjuYV6jUqBqRhHFyAb
X-Received: by 2002:a05:7022:78d:b0:137:e45d:7c3e with SMTP id
 a92af1059eb24-1384bb85425mr663563c88.25.1781247321177; Thu, 11 Jun 2026
 23:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-5-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-5-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:55:08 -0700
X-Gm-Features: AVVi8CdJxHjAgBQ70gRf0u3EPOXvDk9NFYfa82XgAhsq5qFDc9YyaQfsZas8P9U
Message-ID: <CAAVpQUAJq3WEMPzn_rcjct8LO+KDtiCvFZ_0aLZ97PR5awZdaA@mail.gmail.com>
Subject: Re: [PATCH net v5 4/7] net: ip6_tunnel: require CAP_NET_ADMIN in the
 device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-298477-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65DF26770C3

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> ip6_tnl_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Gate ip6_tnl_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")

Fixes: 0bd8762824e7 ("ip6tnl: add x-netns support")


> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

