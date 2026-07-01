Return-Path: <netdev+bounces-303868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ohPzAJCQRWonCQsAu9opvQ
	(envelope-from <netdev+bounces-303868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:11:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA046F2079
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:11:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=lv4aBDMj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303868-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303868-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65F4B300D9CD
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 22:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C0B3ACEF1;
	Wed,  1 Jul 2026 22:11:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059DC3A785A
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:11:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943883; cv=pass; b=Ue1T/FM5IsIvEWZRfEuz1oruLKdintTQ1nb29n2Apm2H1TxtLNSavpfGEjrvvJ+XTTd4GbAuicFLYPE4jzrojdq/fCLF5sVLmZ6UgyqQZTTN0B3yKqWO9fd4xgwxa8MgecndXNxHUrRCUfUS532isOWlMTW2TzV/FJf6MzeJwrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943883; c=relaxed/simple;
	bh=Y1j1bpvmGP5+35l9oEg4Q67wsrvK7fTLzrmgfB/FeK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6V7kypWKumn9ZgURAI1NDtk4xgl/IMF21O+UBy6sUw+yVPQoqc3LdqBotS5uZvJ+Gl1mIy5gW8e4RDU7UqtW2Lh2cCxZiP8SAAnHTrVbE36rMX8H0ubh4gO0QqqokGVizV8rVoz55IUbAfGpdjrND3MDBZI9xxv3TqeswpAKRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lv4aBDMj; arc=pass smtp.client-ip=209.85.208.43
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso1061442a12.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 15:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782943879; cv=none;
        d=google.com; s=arc-20260327;
        b=DLUB3ZxsYtSEELomVz8HrahIeK2plBBpAsPyjP0hLcXEzhsseleyq6fILM4UsDqdWx
         TSIxHWIdlH58xexm+yLt38bA6B9zVUIwE49om4SiLjKXbxPvjiMMds6JF/sJbCDtDGUY
         Oh+qnkjiiUE/ekFEWrwZzwzv+46Ff46zljtBi+NjKK2y3BUT4haZajKOh+TZxWi1fwTD
         QbmsbbyGDMGhbIW2K0lV3jLMNqZD6CITO0LiO1kq+9BvhCTtDS9X1EPzUKg/Kkusbtgk
         b3P5oGF7FjoU6RzAdgTGNpT3i7+uFCCGRmUds0jIKOtzkmgH+AYf8sc40512pmd8ABTV
         khJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mpSAZT8hP6uCJbYSVbjAf+76xNY/Ff4h2/wHxdlMB6I=;
        fh=gg5jFdsLDNc8WNla/X7dyb+OjoASzSgNc+FRQgCB8WU=;
        b=IkDqY4G8kweMPzPVB4Th2OtGWcQEFJyWOdl8WCC4G3z1LiQq3cbjBVCNl7uyp/pPOR
         ol6ZfAtBxgYvjlxI1PR2k49MLVEKTrME+maAhv0Q+HZDHJrkldxPcTxwscm2st98Wrey
         HRf+Ri534rw/ehsknI3ErhiW2/di//KtQoRBwNkpJQv4epYACVPdi9R1zQ24fuR/+WUg
         umdQLV+sNAaXC822MQUNfvmjIcpUDEPWt2ldbWd1/ZDbPBYs4G3mhpizuKt3kCFkgu9r
         dtfRsPeXW7CF6Ao9BbzG9rEzhg1/LTCNAv8uFPH0fw01TQEl33StNSK9mjicJzHa/tmA
         xnFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782943879; x=1783548679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mpSAZT8hP6uCJbYSVbjAf+76xNY/Ff4h2/wHxdlMB6I=;
        b=lv4aBDMjkeg7Oe6lmQ90fsYZsRF5nZambL6kJAWHxz6IZNHVWdygusk+aw9+hQMIhC
         tK9S4LLs1sSAJ+SBi0CcMHnSd+ibg8ClcdX0k89xcxvKdJdz6HKDPhloNU1xC3PgVHna
         vE1hPkRR1996uU6wPjNLV5Qyy8MXkck+PWhZf6QfBjDEC3YeMyyIIMfcwB1ArRq5kA7s
         DHLkLJG7mIupyqK4Mzz+OKTE8VLIGQhi5VV1j8mj0d5pZ9spqHsEiyZnrd/SNDZJlZMt
         0s5j3AM3vPiWlzGuZZlI2qQ5AcLpJMfHUdSm7MNHcoDYVJoVHRKcDcZkv2fiWFQ54Sku
         vVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782943879; x=1783548679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mpSAZT8hP6uCJbYSVbjAf+76xNY/Ff4h2/wHxdlMB6I=;
        b=h9ugnyzZH7NFQhc6nlFrl+BdKB3vUgD3vzpAlIyg8ZpTeN8UuiiZjFNXcZj/MPBjDA
         DbP+Wh1a4Mbs0xA21KBirrD1MgIWTZu01qjQ1Q6ZNI11PXWEUq3J3luNBZS2vpPKBpT7
         kohbPUpUdbucLCWMEa28MjZzi6XDzV/xi7MXt1Xp8lf1a2MYaHOyBoaWQKg7WzQ9evR+
         DV0AvXBGkecgvd+DqdV2NrSk2KFR5Uy2Zo9nrtmmTi9wHRyI9qDYKgDaNRueEVBS7Gjh
         gQEDP0FBgHZ79AbIXOVLs57SJDvxvlLbzon1HnLVA3Y2YWSWqdNPJICEP1LFluwtAsHr
         Glgw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0aqYAdpiUvJDRPAbLNgEgYewB90mOBoQt90chnfsG/ZNPWBMvH9ZfpYtRg3qSS2fCJ46/j0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvPplPa7688lZStn0xPaU2BRrcOpZOfOxqKmA2obvC8OuMzpJ
	0ER91ngowqFHzC3sCIvS/b9kG2gh7PQBfeR6Quw1lrd0tyIdZDmg8tMnT9K0Ojjwzgm8YttCN3R
	5QT6qIuxHQjOqdxbNAlnpGEUaELm6fUIY+dN+kTb9
X-Gm-Gg: AfdE7cksoU50S95L67I/8OIAPmxoIZhaA047ZaLQ0vxfy0oqnKOlX5eBkt6csAjqsZv
	twBZ2JnHj361JWp3+KYn8Fzr3dxOWPwc1vexXMBfbQ2QoeNIrN6bWBFA0Bdcm29hYWXil16mSjR
	D4QNCF/NhVC7TLqvC9o6Lfj8oDjeyrm/YetC+2Zt16M+8u7QRe7Y7jaCNJ9PxiDf7ZPc9CNVldz
	c5lxlCDSfog7mTapbticQQTCHugKYI3kD5fRm+PfzcG5UIfLXl5YaGMINJOjjPgHbjulzVw9Z2S
	F/+LCLQceV11C/0PeJlECRVk5ewtj3SrQvZPt/OODpDXioD1UiLoq/rwe3TdYrXRrXQgYpPpUs2
	OU2od28s9oMCw4quLc9D+fBUMLuxiS7rvyCLWQzAhOw==
X-Received: by 2002:a05:6402:1946:b0:698:81ab:c506 with SMTP id
 4fb4d7f45d1cf-698a2cf943dmr973293a12.39.1782943878647; Wed, 01 Jul 2026
 15:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701082214.2974946-1-edumazet@google.com> <20260701082214.2974946-2-edumazet@google.com>
 <cbdc27c1-0fa9-4e4a-96ee-82309b58414c@blackwall.org>
In-Reply-To: <cbdc27c1-0fa9-4e4a-96ee-82309b58414c@blackwall.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 15:11:04 -0700
X-Gm-Features: AVVi8CeV6Nm6Uw284HdjdVedLb593_YDJMzp9mKmBneSLnL0VEDI-8BZtHLI4Xw
Message-ID: <CAAVpQUCK8a91w4wMY-COXDGRVvGYM1KAKz8e8WD49+CMf_Fc2g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] macvlan: annotate data-races around
 vlan->mode and vlan->flags
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303868-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EA046F2079

On Wed, Jul 1, 2026 at 5:09=E2=80=AFAM Nikolay Aleksandrov <razor@blackwall=
.org> wrote:
>
> On 01/07/2026 11:22, Eric Dumazet wrote:
> > Both fields can be changed in macvlan_changelink() while being read
> > locklessly.
> >
> > Add READ_ONCE()/WRITE_ONCE() annotations.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >   drivers/net/macvlan.c | 38 +++++++++++++++++++++-----------------
> >   1 file changed, 21 insertions(+), 17 deletions(-)
> >
>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

