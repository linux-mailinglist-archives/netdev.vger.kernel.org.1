Return-Path: <netdev+bounces-270335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC+hKKiXwGksJAQAu9opvQ
	(envelope-from <netdev+bounces-270335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:30:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E672EB7C1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F5303002B16
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156EF4315A;
	Mon, 23 Mar 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDMjOPMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF442A96
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229413; cv=pass; b=n/qs8XI+bfQo+s89xwAyzy5xiHT/FXSccFSkXUPA0Zf09Q1cmBIuTu0auxUC9LwfgpJjpTbIRG3CH1xwfWwXHqC0OVeCfyQZlS0zAIkLq8A6elZhLWiGGoz7/sIL31pVgl9YDaqHWyyiGZnPYaRx4yX7V/bNiKY1UWvn0Ixzw6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229413; c=relaxed/simple;
	bh=E9CkvlH3wO0vnCwmSGGoH4sh5VKjEKGED7WmaTeWp3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXdSenQ9RBsarB6A4JVZODa6gA1kRVRUVb9Fu7GN7DhjmNTxhhgKAnb7Ty9ag7h/Gd52NQV5S9VMY+FHewsQBNYlqwq+MH3jcKMdn/B0kxtg3WpvAyz3Cqm3ahk1hsuH/I3xaWUabBiCJNFQ+NVuYssBGlVrKPDfNBNHcFYSjDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDMjOPMf; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c0fa90d47bso1331421eec.0
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 18:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774229412; cv=none;
        d=google.com; s=arc-20240605;
        b=YgqgSFmYSR2zTNatzdSJw9z2ABcFU22YtLfzOz/VnQo9zSQsLVDnIa0EcYIsqyfIrA
         1A3n1KsAc0HJATHEAXimc2uMIyP2ltk8pUA2nl2JcDjJoqqHjYlULiG9Oqjpq1hP88Y5
         cHuUVM3VIpu1Zq8wOk+87YTg3LnnC5UN0iF6GGM5uW82dqFAvGk/dMYyU6rVbr87hL9x
         7Pp5nUhX6JJPM01vAetCBHNMiA4W/KUQ+FGsr5DRscWrwHfHG2w2Ke333BXnpTlbJP+2
         0P49c8cYJiNZxzCldPx8ybGvD2lBAiJT+Fj0Tez4BjKvH/02bTqyYUMeL+pbu8216IJI
         np+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=abrppV/VE8C7Qpis592NOvRsSpK24JBmasGAyf46yHI=;
        fh=TYOlXN1m5+KFq9Lk+JwkJTEU5+2VnOoWo/jaQg94mbQ=;
        b=lcrQ8fqfguWiqfrv6MpsSWR9ke+rt0ZaoojwaMdL8fXGPGp79W+n2cjOMICAtYboAG
         2xrB8KOeb5PMXCjvt5CI5rqXVhIWR/xJnrZBwJ9Y8O+iT/5hmi6TgCvbtqpZ2wt/URCT
         Txp2UH3ieZYe+PpImKo4x5nAYwlQFZOUnXYY1K+VnK8m4HRM80nhcQSrU5USoOGcGAys
         IfCntd8qiXWbEmQ7XzuJfpNBwFkk3v6ayrOdOOhJDqtWQFhjgk/rPhWrf6r25jsBLfjq
         dMH8ok6UWeuHg0YWetQcVXMQ8IeY1B7obeGlOi6kTGd4uVaXkuN7ylLHvhMIBc3GtxK5
         Fn9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774229412; x=1774834212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abrppV/VE8C7Qpis592NOvRsSpK24JBmasGAyf46yHI=;
        b=DDMjOPMfBIHs2DlIc2tdQas3x2UuKxIFbYRFt6aSPbkJJSIlNptrZzLdqnFli/7t0d
         ISX8H+KL4NGGaSEs+rpGqhFMKnS+Moz7h62+/OdG45npdKN5dnavIJtsxGqg9sdcPWmG
         ZxyGf8z1bCSAf3Vv77jagufESdSiPRpwYe+NP38aP96vMG63jJYEJxLlduwrAphxoPEC
         RLWjiGB+XGw+XCPEb+LRoQy0J4mrFTz435FfOi0uYmZFmcm6d30uEHoUeymxn0Igb15s
         RNENTTvXIvPvYaoiNcXanlUWZwZP5s/TZiQpuKcVpRBjImntw57Dysun90T3SyiTusdM
         0nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774229412; x=1774834212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=abrppV/VE8C7Qpis592NOvRsSpK24JBmasGAyf46yHI=;
        b=HEFt7d8P5UpOViwgjOM++qjpj8c6sszEwUDNcRngzMIiBeVI47EcpJSGfKMiPbTxKr
         dsR3JD73ek06eoGm0Nf4gztlpz3P0SyBYkxpcY1ZbsL4bYfyw5ePSZA2cDzNXj8fzxaw
         7xR2gSIj1o47l6UhAG4eE+BSqQ+VkaKVcREMRVhpnFwx2QyKWeXO2npZi1ZmOVk9Sgt4
         GZx0pduKzyTHKoeuxLHPNCFqtB65JwiulGm/uAzrtpkrIXkAhmZLnIzimLqzrV5BRBGT
         9hLCDT+2Hnrj2bVOkmq8AWUzQD4V4xUmPVIFB2dcQUcBKyYtFJWZp5DsPpGzx3NdcMN6
         sIvg==
X-Forwarded-Encrypted: i=1; AJvYcCXBqjzHCTDUH5SjwYjDpnfBrKcxrcZgn2UcfWgI/bZZwZv3TbWOrUDyNwFXOv1DbPtCgbSrC8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztz80q/hdq5dwxVolSMANMcpgSh2efZuPuPhWdN3JORSH5PEMq
	/lAOlgc4kQiHph/DJbLIDov90WjoF0hHQvZ2ynshcowfGPDsK+qmjD8ak/DIwE/Djp6ZQHkHdUT
	+b0KvNaSbsz8bOgGysMLJaaghPpYKFndKw1JyW+LP
X-Gm-Gg: ATEYQzz6eNf5LjD/Ra9Hm2ZfULGjjm2PbVZwLhKfizvp9851eQUJSzvrC1Oh5XxkMAV
	p9AkhqqN2ggS6DDxCd/ARe3X37RB+cJSqGbKaOeRiUDlyuFwRYFRQnXjAMF1NN07DLCzKtkH8TY
	q2TposFBb7JfFs28BvkBcclOC2G8DBb3ZU6mqoP6pudTQ6/hQ1u18KuCA2/kF3H905IAUV2dr1d
	EI7BquItBr3GEek/A54NgoxbyQugiYXJnzv195NzD32pNyYN8svm4I+sfHUHH4x2rXpx47K3zMA
	vVZ0mKvqRJdUsf/+wvtb3Xq2PdJ0M8mK+80HDhjDqJzzVcyTu+FysVlsP9r4nUrHREpGESYqa3q
	L7uyTKNM=
X-Received: by 2002:a05:7022:20e:b0:12a:6d05:3938 with SMTP id
 a92af1059eb24-12a722b80c9mr4466916c88.7.1774229411238; Sun, 22 Mar 2026
 18:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323011816.3737155-1-edumazet@google.com>
In-Reply-To: <20260323011816.3737155-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 22 Mar 2026 18:29:56 -0700
X-Gm-Features: AaiRm51TxH_qkbpMmcte5yCWpn4tmJ42hWvy6MKPzvYFF6osAJLTo5dSfPle7Po
Message-ID: <CAAVpQUAvKD+ZtLbvxtze0-kA8WjAywRcxCCbab2JrgFLtQFE+w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: use __jhash_final() in inet6_ehashfn()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-270335-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 35E672EB7C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 6:18=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> I misread jhash2() implementation.
>
> Last round should use __jhash_final() instead of __jhash_mix().
>
> Using __jhash_mix() here leaves entropy distributed across a, b, and c,
> which might lead to incomplete diffusion of the faddr and fport bits
> into the bucket index. Replacing this last __jhash_mix() with
> __jhash_final() provides the correct avalanche properties
> for the returned value in c.
>
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-4 (-4)
> Function                                     old     new   delta
> inet6_ehashfn                                306     302      -4
> Total: Before=3D25155089, After=3D25155085, chg -0.00%
>
> Fixes: 854587e69ef3 ("tcp: improve inet6_ehashfn() entropy")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

