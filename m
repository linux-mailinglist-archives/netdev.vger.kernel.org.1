Return-Path: <netdev+bounces-262070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIH1DKRlomnI2gQAu9opvQ
	(envelope-from <netdev+bounces-262070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:48:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 017DE1C0352
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36636302AACE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4364632692C;
	Sat, 28 Feb 2026 03:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMt3vbeB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E933C1F
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250525; cv=pass; b=u+2bSDpmXozpBvXAjuuPte/QDUKx2lFAZTNoQTXpdECnD+V38H2VXY+OAli+UWkJXgCqUwUgx91+DjR/Nyct2MAYBB8fNco9eTS7JDIM69j4YIttvbOmEflLw/4WuOozyTRrJlJH9yyI74J1QUWa9TrDENzh5zDclTg6VNJFZvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250525; c=relaxed/simple;
	bh=Ba1H2TI72uyhHfEZvzmX7MYx8m2ImsoSnKhMywAdAXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7VHdQ1h9hrCOt9hnk1xrf+Cx7+zWRbBfa5P9pUhr0XwjWoYGupS80aGG7UjrfqAyyd7f+RVPrNoRU/0NDdnknLlqCNm+AQfvPH11CspksFK6NrLJ8rG+SfPziHw30mWvk0ZRkh9XRVA0vxj0JNuhNE8A/krK5W3CCphrjhdLYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMt3vbeB; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1277d379936so3547241c88.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 19:48:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772250522; cv=none;
        d=google.com; s=arc-20240605;
        b=HpiDw/UVS7T9KHKu2xkNV0zNBjpQSEsB1NmzEPk9SZXaUxxncE6mkXh/CaUNmoOQPi
         5q770jojK/HpryVHrONU4gq54h97ZmilJPJ45eT7wGQ9ObB4Qb8l5su/jXsm7aMIiseB
         czoTspBdf3n5DpOg3nrCjU/N9VDeQlav+3nIs6DfJNyI+JidFi895aVltU9gkLZjHtNw
         Whuxu2XB738XJJGVZPRrLK4dn5bVPTufMafUzWyxBuKTGP6iTHrAts9YLc3DZGCFEFpU
         bWhrO9JB+oGvblnDufvgtR7137pHiON2Oz2I1eZTa7cC0fV4qtKf/YO1sG8LgOlUw7Wc
         vU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jIQWYMFVZVNQXQfjOYp0TaaSVZneXxwrSH3RnsbFwwA=;
        fh=I97dSwSsz8qHuG+12q9qPCzLsIGFAE+Uuh5bU0uR9yk=;
        b=boMeGx/k9787myLqXpFi4Nahbs1netaaPeCgOa+YbOf1+CWwHjKflJjdEF+IkxE20Z
         0KFcRA5Qkmh+Wt2fc6Sk99iKYg6TpcEMPpSnE88aWQnU4mNDlilmg8vo0v5sE4CnvXpY
         Mulr6crZaBnSEXtQ9PgMgqS8xx/tfMB7XMrfRCODncTwOnliYYesLM5Dmo8xp3CUCWJX
         BLXItN7SWxBnJbZn11M80E+e72Kw01hz5oe9+PGhD0CyU4DlqwvBy8ndCSrc96AYxx25
         Lf6N1sl6sLyBzlzwCkFb+9QcePyUrWux6rP0v8jmDHDli4c4NHdk1dWD/fbz3jmj1vfI
         R96Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772250522; x=1772855322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIQWYMFVZVNQXQfjOYp0TaaSVZneXxwrSH3RnsbFwwA=;
        b=XMt3vbeBjUIbeHrUJ8PUH/b6HauBQji46Bqqg7bhHX6AepgjtRFHXmkLzdtTLv0CsN
         DbeeDwEx4zTDTu1QcgAh3QTMH7JOgnn1VGsueHCeFppTMPvO5mKIldx9gClPpSDD+OSi
         ACozNSj2mND71887l7zTIpcsLW/MbwLoD2VmxvReXknAsy/7LAb1As54S9QCtTHfnhJB
         tc0Gm39JWGkwJZv5sMVDCUHX3TAy1Fk155WUlmjebpjCIRLoIBAjyR01McnVTVtB3Zsk
         mpS6fYpoX6N+DdbuLd8906FVKSO+5OJXZFICJeR+zKjO4gTd8aa2V9kyFEVbwBwNZlMX
         qZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772250522; x=1772855322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jIQWYMFVZVNQXQfjOYp0TaaSVZneXxwrSH3RnsbFwwA=;
        b=oiYQpJxbZAw54QMVYDi5+aNaw14MwKG5Va/1Hw3Uw13/0Ut5SkEAzAjgEOHM/RVs9L
         5YmfZahBu4XBu26Dm86fPgcTZpKVah0tzGdzdbST9+j1mkn32oQ/XkCgLrLDI+LBCJFH
         gurZs17fGWFNGveFKeHQEJXr8YqUq7N3CwwimYGABr638RGWasmTiSwg/b1g49+EubbO
         L4CfuuKMCqUWHqLoVkfc9QkqGdHR3RzgjVa0jv39wTmc0Nj3zMvR3LDgFkPRv0XVi/tb
         ircIbMnEwKB2U3GIUW6kqeb0iJ1LolRYw2VtgrTpvktHYdCPncIixx+W9aok5l4V9BVu
         urmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuTc7E0LuS0JAfPsCqmzgz5a5Ya7jdJXQncwiVW9b8f9RjTSjTF5yZ4MVLZiZ8ynizVNLsQmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ne9oBcEeqKph7unR0i83DMj58wjm0So0ItaMy1kLB+FyqAYP
	5H4iXapgC5RtWZx/phL8QOfM4gcEMis5rFQy8BXxl6n1kSOY2NCn4ezsd+MXwcWfAAUOtqJZ0Yl
	q0lXX9LROSFaR5cXGkd0SuJRQLdShCRDQ45phVDvK
X-Gm-Gg: ATEYQzxOTsMylrJvuhhB9SFeTk1pE2cV556pKiJ/yPZgPD66J2OgEPa9RHp2ylBS7zb
	E5/QVL4PTxNeI4f2kTGb8gZw0WFljrl3mcp+O5C3TTFu9fNTxmb0hSprJoJ9ySNJZFR0PTktXHI
	nRjM49XDa1m/fS1hpiAwjnihyGRUBv0HshMYWIKryUmcOALtWE+blQqkyOb4RP2fT73AGh3ZY4z
	ywq9D40EfvmZPYjYHVG1oijUR7kBdPvPVQTjhPFxsG8SOlxcK7RRqpKItdjLH24u9F77DlSU/vW
	aEAFN5vnCnQFyMX0ho+rS7vUuCBLDlyHez37GKW2Og0ruzGNx0VYxPmcBoyb3kcoiTX9H7V+
X-Received: by 2002:a05:7022:6607:b0:127:dd7:2062 with SMTP id
 a92af1059eb24-1278fc8cffamr1494429c88.43.1772250521780; Fri, 27 Feb 2026
 19:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227003359.2391017-1-kuba@kernel.org>
In-Reply-To: <20260227003359.2391017-1-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Feb 2026 19:48:30 -0800
X-Gm-Features: AaiRm52ZWna_8ztruWlWXVSJwCMr_I86hks7bulKpebqPGmdbTxkbSIEL6OsDPY
Message-ID: <CAAVpQUBu+tsn+aWnOp-tkCvKvjf+fjtVP8CtvN9zFfJJNC0HJg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: give up on stronger sk_rcvbuf checks (for now)
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262070-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 017DE1C0352
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 4:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We hit another corner case which leads to TcpExtTCPRcvQDrop
>
> Connections which send RPCs in the 20-80kB range over loopback
> experience spurious drops. The exact conditions for most of
> the drops I investigated are that:
>  - socket exchanged >1MB of data so its not completely fresh
>  - rcvbuf is around 128kB (default, hasn't grown)
>  - there is ~60kB of data in rcvq
>  - skb > 64kB arrives
>
> The sum of skb->len (!) of both of the skbs (the one already
> in rcvq and the arriving one) is larger than rwnd.
> My suspicion is that this happens because __tcp_select_window()
> rounds the rwnd up to (1 << wscale) if less than half of
> the rwnd has been consumed.
>
> Eric suggests that given the number of Fixes we already have
> pointing to 1d2fbaad7cd8 it's probably time to give up on it,
> until a bigger revamp of rmem management.
>
> Also while we could risk tweaking the rwnd math, there are other
> drops on workloads I investigated, after the commit in question,
> not explained by this phenomenon.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Link: https://lore.kernel.org/20260225122355.585fd57b@kernel.org
> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

