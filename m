Return-Path: <netdev+bounces-272175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLo1LhZxxWkU+QQAu9opvQ
	(envelope-from <netdev+bounces-272175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:47:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F864339674
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E206731D66DD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B8A4279F9;
	Thu, 26 Mar 2026 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDJb3lXX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1B4266B5
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546630; cv=pass; b=tGZ68QGbFRlEp2Y6n/9tludIpOIfXx5vZIB8ImSqjFf422B9h33qeQwfUVlB/syKQMYWucfe6T2VnziecED9z+mb5mt72E5A5Bz/EwbHh8eEl/Wiy52FIAkD+VrEUgTi2ABIQp7LqitHhG8s/PMg7eNoKFQgz4xROxaymv+k73k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546630; c=relaxed/simple;
	bh=emkwTzzejzmHP7wiTJvtjNKr6OAdxPK1q1Ly02cgxYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWU06Li8qxMdWAoXKmo7xWaURMJ7sn7M2BA3RlxEWzSSCFLJLeIgbhfrVOrJoZ7vSclYrwo9BwA7/D/508jGr5aabt8BksS3LlwOgUNY2C9z5sSYJm9MmAnQbD3nyuuzcKt9A7v5qwTIlDyyvs/KiHZzH26dzOe7dL985mR52l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDJb3lXX; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12a71ade78cso1433535c88.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774546628; cv=none;
        d=google.com; s=arc-20240605;
        b=Lh7dLYqsJYCgw9oTvel+HCxXI7Vaik/Go8EjYrGby6/8kRnB9w+QxktJV8ojdlyj+P
         5IiqPmre6dwOmxtsxlXHYGC3Qbov2R2SFvaeyFjJV3So1Z6NzMRkRf1eCf3Jr7OdGUo6
         lXdZ1SUF7BmZjDmR0KjeuE9cSmLwO3otzWnVjUix51PZXyUBI1nNXwC1vHpg8PdliZrb
         PTEkgJbofF1uunEwEojXw6wnmn7Rx+/VDbe4xRWI4RWCzb0fMDiAGGDFDR1iWCRVTZ0/
         lTk/3ulpt/9ez2wdlbC2X24wQYw6uhxisZlc/IZsJmeByJE/ajxBLE1vTKTFJ5wFHE+h
         D6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=emkwTzzejzmHP7wiTJvtjNKr6OAdxPK1q1Ly02cgxYU=;
        fh=EpxAy+Vsb2OufEvfxn8ee5BMZ3d3g7JMqZpzoMyYVzo=;
        b=cjh2ZcDfythT1tfh1npvaVJWONgH2QHskoT1bsPuBaxgdqWAgB3zEb7JFN55tyjl72
         zX6sbsaEr8sk5rYS0dwH9cBd3sPOvCX0FbWfiEef0Hh3VAVPqamYn5/TRLNrNm2pyyNz
         FHcYJboNAXgy2Ck9aiJ/Rda53QuawaE+hGFAe9dD4pYBKgpzd2zrqzc1+RBZvVGQiVDq
         JW4E9OYUvAIllIGaAWxh28FwmPGXnx0e1PgTjLpwC5zdqC5VK8xpq+jIz8O6nshr9xY5
         slMXXbVDrsOhCHOXEUWI7de5Bc0Q53sSwHRc+aCrXiUiWWQd+XZ+xPtd2IlDyzJ0JbFt
         PXgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774546628; x=1775151428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emkwTzzejzmHP7wiTJvtjNKr6OAdxPK1q1Ly02cgxYU=;
        b=oDJb3lXXxceF9nwt2VNZ6VauV0Zt8wMI7j62r+98OzqDjRwb7+tQf9XzvpDE1HxwCU
         uW3zzsKyNaPiiwmUtz6v0FEeCMoki2OHNmMK3Mp5dC0TXpYF9DzxNrvvEzPOwxTdlQZv
         8gr616/XLnmjaoL+H/VxmQJ1HBBaqkbgSgJs4XSferszdVpP1McAQaOXbICYI6r2B8Gu
         amCIg8VjphEMovkEl0xdyGpTvjj1rlelPDz+femqDcjnT7b2MfP840jpvJN0uFRXWMwa
         684eX5+DjDCMK+fj8Btsxk9/PAI2g1iTd0Ws4d/dWU9sLmmwyLuKw/3rL+g4N3KluoZR
         PfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546628; x=1775151428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=emkwTzzejzmHP7wiTJvtjNKr6OAdxPK1q1Ly02cgxYU=;
        b=tMLIHEZ4gxsWSKSZuE4OzcMqVO0CEI4vRKXnQk08yky7Q+hdrBruK+le2wvOLhGeqZ
         6X5mW1La2x7i5LyAkggNXXF0Kva0h01ggTUlbORnpfVcApYXxIOTA1aIUpYlw6uetQrg
         w9seoUQiKbD4v3o5FL5DDBQoWdySTkv1/p0wo9jRawBfMZildipsvnaX1j8swyFLSf5h
         39qyle1dU/cSybpLA0buwLBMDy8YBGCcKck9PWABVgiurwOhfQYoveCOMFeyLPfr98bp
         ns8rdt9/GHm0+efbLbf5MPacLMOOqZq/0x73rMlpNOfXeUuP77IDbdFhzmIr6aOCfYNG
         lNNw==
X-Forwarded-Encrypted: i=1; AJvYcCWlSSvZEwNaNxe+O3PUdHyvNSoriGR8Re4D8RhJx0g7AOIHrYvAjCIBtZAiydvmd53ST9uvs/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUDw8Xl5Ow6bilAzuBMAn8khlTsOWktsmiDG25Omjhsxodk+w/
	eMx84f6WUEgIIHGrADgsgQ/NMjD6B1GXkQ9WPVploGX1jJNZm36OTVxPwYtaFB1eVazQKfAVG/l
	bQG0HyPEHSnqJUypRhDNlLOmno2lKPmj3Du65Nz4f
X-Gm-Gg: ATEYQzxcxgyidnhOcXwNKdAtZLSmcznWx1+9SHm9qEirlGMHYR42dFPoKna2SfeAbDX
	mDjf0SozVivrWKFqg//W89CyhsbbjCuYqA0jEb8a6zYsTGMEdj/O+9FskEwODF+8zp17HWgTl9b
	uyVHMADhMEbHw5rKWX7id7gGoQO9y+Y93nsIgEeckAPiORW+fRN4mucFn/yKCtArL68gWKY+XOC
	dg52t7eJ4YaQ/78euGJvWJgHFw2Rl57569H6ar6NUtxEID/ty9cMo2CkF84Ut9TDCJSyWDU8CJg
	u+wjKpCiHWxy+yNjkcrehs65b/YeW5WJqSJXnadEa1WgZlVcmQFtknIaWgPB4NVhkK+3mQ==
X-Received: by 2002:a05:7022:6ba0:b0:128:dab3:f528 with SMTP id
 a92af1059eb24-12a96e49010mr4299482c88.8.1774546627101; Thu, 26 Mar 2026
 10:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325212440.4146579-1-edumazet@google.com>
In-Reply-To: <20260325212440.4146579-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Mar 2026 10:36:55 -0700
X-Gm-Features: AQROBzAAFZeyid-XxNmHrFC62CJkCb-b2c4aPTXSHoACjNC8sEoe-Gvi9MSoEbU
Message-ID: <CAAVpQUBA=KCnUWhm_95pjdHL+vPSVLZi+43bRno00tMz6ztz9w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: tcp_vegas: use tcp_vegas_cwnd_event_tx_start()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272175-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F864339674
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 2:24=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> While net/ipv4/tcp_yeah.c is correctly setting .cwnd_event_tx_start
> to tcp_vegas_cwnd_event_tx_start(), I forgot to do the same in tcp_vegas.=
c
>
> Fixes: d1e59a469737 ("tcp: add cwnd_event_tx_start to tcp_congestion_ops"=
)
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

