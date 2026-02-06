Return-Path: <netdev+bounces-257463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I9gCGtqhWlqBQQAu9opvQ
	(envelope-from <netdev+bounces-257463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:13:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BDAF9ED6
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91F793004CA9
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 04:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC2F337690;
	Fri,  6 Feb 2026 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFK1YtHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5E33375D0
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351203; cv=pass; b=guuRQ9LKllOoqlyX+iKIwZgYP2hEuTxIZzc0GpvSOnfM4hL55mWBhLpPBRnArwKwJB0fcSzXRIixKEaIFkYBuZCq3L+lAm1lmK+0t6ke3b4ZIhK3Xt+xUc3hyjac30GdlBUgkL8093xdgic3GsQ8uptT+NuHJfkjmJMDteGDxrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351203; c=relaxed/simple;
	bh=HugF5Y07pqYjuyf2XuuelnOVpgmkrlqHPHk3dr6oBCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSgWgaRzAwHC6EntDyq3uAKynVWs2pibH2H0Z7y0I9oppvAIhdGE6wdnixcKtJp7t6/ja7qMIYV1IfKoJ5n7w3m+l/QZ9kYbG4G9V4UXTuzeg3vuxgoj2UH6KbarZ1OObW1olXKds2LbMYnbLh43sxNSfP0IW6V1PW4dlzN4UtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFK1YtHZ; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1233b953bebso4245409c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 20:13:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770351203; cv=none;
        d=google.com; s=arc-20240605;
        b=DM8zipnnqsx4iyWYHcxnFECfROIa1103t8j2r3uTX1tF+ygIhJNrVTagJFY0Mes0xZ
         3jR4sTq+WYswFQUhP6wW7DkwU04Yvmy/Gvd9+s3ne4qCMtQYLfkGv4ZMg1yMa/wa+5CP
         oXkqkvbXUQRJPbqgDBHxuiBOCRnI5atC6+pxtpn50zuz30bP9Psi3nxoWzbGToQN/STw
         IcsxUSujVZYK2xi1X6WU0LjQEweMQqG7kyqjxF4bdCctNtYVT9EV+ta9Duck+Oh6Fbac
         t9EDVaWQXqAlNWhMVcu5XqBHLdOodQ10ICFCaKZaWkgWSXYYEhiZ08zUqta1vDDb8sRF
         fADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HI/mL8zv0zENwAn/9CaWWPI/c24xPOYKq7BWdltrIQA=;
        fh=uJHLWPsK7M04749PedEBEI/eFtytPwWpM5Im0WTl+rE=;
        b=YexbvJxO1GMjt8NxiqUHf6hpMErcV2nfmrD5v/mHhCOWbcSxRPWuuXphdVTtaz3HRn
         qQ9XKOF17++KASuL86R+namPVemJZEiXPOZQCVwaE0QYO/9LnYEtJLswXMXNoqG2WqVa
         3xU3VPdtygELkd9OWVQjawEwNfAAF5os57G1sPJOppwbUtobays0IZudxS3RNtOp3QdU
         OCrNHu1Qg+CSdq5dl3r4EkvcXmsJj2MOKQtL3qXsUzkWf1+L+QOMV7WSC+O9iYalKffX
         1tEpgPI3feMlhgv25yhYDSn6bOlmGDed+n23gC64s3J0Hq7u9D1iae7WHXhEvtk3EG/i
         pDeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770351203; x=1770956003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI/mL8zv0zENwAn/9CaWWPI/c24xPOYKq7BWdltrIQA=;
        b=OFK1YtHZM+VjL+eY35p1ftMC0M69aRga5cocialvVSxEG8Grd5iyXu2Q86wkpAAdFV
         1hPKdWr93UEWsP51Y+4He7PYH9F+jDRoyKN8lPcpY5cLoksuA+WUgwNPkg5LBvOLQOKp
         /WoESuF0Bc41AoXu+21jH7M2YxfEwn+KBMvMPZgumN8Z0AcbQwJAa2FPAAEhWnvUzLt1
         SPGFeStfRpn6ciBaGwAjWEUQ97V6IlWvluMzPFbl6DJid3MpuCw3ZnOutsV4UW72KRYJ
         dDlLK8Vf9eI1qvtIaE153dtTtetoBhjMoCTyYCHYDEBIrGDLsDSaKYCxDSfXkB38bLAL
         3jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770351203; x=1770956003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HI/mL8zv0zENwAn/9CaWWPI/c24xPOYKq7BWdltrIQA=;
        b=Xru0L+IuNLbJQNQBN6U2jM0KRtt1hX1Q/6ctOhK5asjIY4xOXlG9RG1DZCR+IuH4hL
         Rl7JaN8uKyLuQfTYuVnF6eFHU3jCb5lM6MLOL4Jsrl12j6yVwc2hZivhsMNEk3KYvmB3
         SaWx+yu/fe2oCrPs8BfeRikh3tIdyOEP6AjRurQUEIP+VXqjLA7QFu6kd/VKvBh7/fDu
         nGmH/C6NvROzpME85naGIjIKBPVllHbp6Cw2AGb/RuLeexr2MUSwqkYIgbIq8VULJgMY
         cBc8dVHzCoSdH7YXT8Q8ccKVWFJkeuLXyh687NTQYu1yNZxQSJ5Sr/udEeovqRygoYyu
         THBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgkM0vtCVx5V5M93ptzjCBLI0z5JExkFBYpwSOu/iWMSgKIM/UTMF/WZmZcDNGivxTr/3msSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2owgf1qbs0EavaopPdBwnH34R2iqJ1j96Zj5VAmEJbttOF8EC
	dUu2S9MABXmWWcDSaESooFTNCTWLoRTLvheuhnLie4VR9fDlQa9kBO65E6T5tzg0CP8LUMVEtcL
	q1QzUxzGBdt9XaTtzj9HXbLVmGKa8i8L8X3FZbdfK
X-Gm-Gg: AZuq6aIs7+fLVlbxOFTk8CuLsqkAb2B9sOcImOH1SqQF5OfuR5DF8p8e5LddqESxmhF
	Yja4vLsgN2dJsqeHUjf8SDDCS2IJm+RoAJCs2IbyS72ypA+gwFxqeZdq7zd9+WS1/xkmD12CbOC
	zzpDmAmv5wLTinOPElSC/TJGwyiIYGPrJLvG23hA2s0bsaFIJP9a5U/Iz36Eoh9t4OdP6h71Cdx
	1r/ibRKn32PVhCf7pEex5dLevaaN1xQYSwLOrOWO8rwAX3mw3o1MVC4zSnymsUbh/k5SpSUPh1E
	t0m9yQo6lzafWGX1UWcdKSO3pBlTl3oWwtV/USKXpz2w80FB/vWbQpKu2Ic=
X-Received: by 2002:a05:7022:4a4:b0:124:11af:7b75 with SMTP id
 a92af1059eb24-12704073b1fmr844134c88.34.1770351202530; Thu, 05 Feb 2026
 20:13:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205211909.4115285-1-edumazet@google.com>
In-Reply-To: <20260205211909.4115285-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Feb 2026 20:13:11 -0800
X-Gm-Features: AZwV_Qh4MPTvaR7ndaIAJUHy6MEdLfQ0nJd1_1wk72IR6avEw7IyknjAodNDkw8
Message-ID: <CAAVpQUBrLm+-5PEkKkYATQMUPtB_MROcByJVrx3Hg26jFPj1SA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: do not use skb_header_pointer() in icmpv6_filter()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-257463-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmlinux.new:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 43BDAF9ED6
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 1:19=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Prefer pskb_may_pull() to avoid a stack canary in raw6_local_deliver().
>
> Note: skb->head can change, hence we reload ip6h pointer in
> ipv6_raw_deliver()
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-86 (-86)
> Function                                     old     new   delta
> raw6_local_deliver                           780     694     -86
> Total: Before=3D24889784, After=3D24889698, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

