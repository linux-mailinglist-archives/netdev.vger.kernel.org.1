Return-Path: <netdev+bounces-286474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA+dG96BAWpObwEAu9opvQ
	(envelope-from <netdev+bounces-286474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:14:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE066508ECC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7360E301F4BC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5067632E12E;
	Mon, 11 May 2026 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hB1AUY2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F51684BE
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483651; cv=pass; b=WKkzyisWW+KThTsKCdj81DRCIYnaRMngD2NTKp+zv1SZ/StZaYLmGN1ULvuWg/y735ChTYFReI1HP1x5OmoBfx9EHmS3U2X5/KtCzQxUHpZW90dhFk+pD8xWszaDSz+inY/VhPcfBeimDyKV0tNMEAOokg6UGmMDXKRny7wiyV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483651; c=relaxed/simple;
	bh=92OK3tsdbu7saUCNHE4eIO9FBbIOBAEUwcmiijGObDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpWk/OLOiiWmWq9GejzsAmogsg4kMZpypqbmSmyDjQ6MWWKowvCTGEnxXwrtGqhQ0hl0IBIu7a5ocIQ4+Zb0lbvCP9ECPq7m5dKAd1XjEWtsDmQcImducFWaXsw7ESsxIXtzEk5TxcUSC4O+6Pf2dDSrIS9VWW0a1IG+qVdJ//8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hB1AUY2o; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d6ab4476eso38676301cf.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778483648; cv=none;
        d=google.com; s=arc-20240605;
        b=Tg+gY4pGL3InoRF1rxm1THCzh8RjQsr9SpdzLfoLfnMvDRXyXGVpITFIk1FKLWCSrW
         YhKgstFQASAFJLtuxTxwge0LXKbK9KjJhv5XXU4VYSNzdmYsTIMnozVvCZ56cOjlo/Xd
         j36Pg8sqUWwFykhJzxMII4oF9hOby/8WMCYAuihnKtWzYHoWGf2XyS0ZYahCPRsaS53O
         udZnxBtnBvLO3XAb1PC8fF6f2rWbvPPFKE153FBOPzp5WNO51iL+F8EmGzMNmg1PBtqQ
         WrWwsllfPo1Pdtnwl4t7jCCb4vBGdJjJ648IQw1V+mFxRpRhX4U+NtqVoi+YEj9nf67M
         j2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1okxzvEJMJIB3k8TO+d6Fa5QcOtnP6lMRj6fAE2bX9g=;
        fh=7IuyQlu9pra3yv1f8nixqSILlRdP3gSD62L72AELRWI=;
        b=auVlnA0WUozcuf/rACiF43b1ZTOk9iMc3DMqtjv/q5HZaUZv9nIl1ulpiK0gzO3Uaz
         MpMaOiFu38G+LkEoRNJwkdlwetESpWUKlS74r4sCN0IUEVoiob436Kd7VW5qVXzd+4ud
         V9pd5ZQE+ayR0d1Vz+oj8PtOrn5cKwCVOcfxKNx8j8g5jGUeutG/7u1gHnlFHx1hrIa1
         pVDJ0uigD1Qe6MQl3K1+O4V/pQi/71/OJ0C7gmMYdTnmT0+VIboUjNfG5BGIt87Oz4zS
         LxsmCnTfjpl9HEWAq68O0NMOG9W5vATffPLnpksc4/6cWHa2u10SST1YTdNhmwgfO89q
         Tw2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778483648; x=1779088448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1okxzvEJMJIB3k8TO+d6Fa5QcOtnP6lMRj6fAE2bX9g=;
        b=hB1AUY2oNKlliJnpGAaBGKmpNdN1qUM3nYrPGMC76TS9q4qfFOgACIsCbjsE9Q0TH3
         iMkEQEOFu7gEqxZCc35samwg1jrb6YIR1jj4CJOVQh0jidUXH90oNH7rgLVmeWRT6E74
         Z9hDojCzN2CtZLCWPAofAbvIJnXv7l0FXwLgSeG8DDIsInZwKpxXIAI/3OcDPD4MNFCE
         76uQOKO75e4MDfOgZijQdXnFyAOIwOC08nam1gwgf2Tajfo4G5XA1E/K5uMFlWr+3UNv
         zuGykDrLPhVgr+IsflznK5Z6H7iHVNK3+XhUbfy+H7Kqw7R15XRb4CLi5rItqvQ9lDhh
         /2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778483648; x=1779088448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1okxzvEJMJIB3k8TO+d6Fa5QcOtnP6lMRj6fAE2bX9g=;
        b=ISYx+UyCGbXGceyZf6x6rghhVv2ycYfbnksOxh0Ky+r+/Lr/2yI03Jx5VlQD6WEtIh
         mnQm+eMxsygElEWstVZaMhP+Icv78o+Rjem8XGmma9FpfCSPY+XPhR6086drdcQ70B3Q
         nyvCy3oM/V3Snsio5XKFiK3mllSjMJCU1q4m63RorwE5w+/N8CwrWUl7+RmoCA/1tfhg
         g57KqZ+Gcbmt/U2ZXrBMLmTwK6SOBADanSTRLfKBoGmCu+6sT9DzMuLElvoZa13os1+s
         /5dgURmhNAUxRKtJnTeUmrn7U7Y60+UlwF6QXds4SpR1jjhB4Hr/kzEQso9WjN8gPNTl
         NdMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ypT9jOGv55ZNYPVDYoJyT+aZEtFe+xukf4VFw6Xp3Wml0e911oNB3EaCAV2wPVd/trNKMh6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1fy2HeUockflpWegrlsmIduZ7yZwF3hoDPXHtgiO/ZMflN6U
	NCxtGxjU0U+Rdd9QFPx8mu1SBQS4eXT88AAT+SXUoboys5itgnhF9GFuQ6QwabiW5mOE3+CFQEh
	vxxHzWDr8sf66hC1wrv+u4HEEKisNifjT6Kp/CuFO
X-Gm-Gg: Acq92OHpvGshoO+RyngIESaZVY4Ilkd1+yku9eYKkRNO5lyal4hjJZ/YdmiasuHVwW5
	ll2vXdqPeTwGbD3c7N1t28nj8l+azIy/hzrnv9Kg2ww+MaltcfJ6FlG2rmvumSIFPHoOXJuuBKT
	66Brk3tWtlLNFmMWL++CVMx2leUV1mdg2s2yH/r/+YpcFcZ2/+cqtgBvnIbvF2/gtu/NfIaIJmM
	RXgLZ7qbHre1H9szwrZMa6s/NyR7fMk8lPAhOCD6qtGOr6eu+hmVlvsANFVV8z6fs0vqiHNpPrG
	4aQhz7FuUlH31DhRib9L9XN1DYFkxaCGjH91l9+1gcUITQuM31+esacKXhrURmcnpnqIEWX5JCI
	s9b+0GjJ0oxHxVrC4GfKC6qrxqrfV
X-Received: by 2002:a05:622a:5e0f:b0:50d:a8f5:1c0f with SMTP id
 d75a77b69052e-51461c33bbamr316965331cf.24.1778483647816; Mon, 11 May 2026
 00:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507084305.2506115-1-edumazet@google.com>
In-Reply-To: <20260507084305.2506115-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 May 2026 00:13:56 -0700
X-Gm-Features: AVHnY4Iu1qjsy0Fxbhl6Y9WdLlb0R951v_JD88H1k3AzjBh5J7RbGhwz1aE5Hbg
Message-ID: <CANn89iKmmvcOEduzj5e-THY-bScdsD3u5qTDCqHSLp33=BqB_g@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] net: use IP_OUTNOROUTES drop reason
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BE066508ECC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286474-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 1:43=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> First patch changes sk_skb_reason_drop() sock to be const.
>
> Second and last patch add SKB_DROP_REASON_IP_OUTNOROUTES
> to both tcp_v6_send_response() and inet6_csk_xmit().
>
> Eric Dumazet (3):
>   net: constify sk_skb_reason_drop() sock parameter
>   tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in tcp_v6_send_response()
>   ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in inet6_csk_xmit()
>
>  include/linux/skbuff.h           | 3 ++-
>  include/trace/events/skb.h       | 4 ++--
>  net/core/skbuff.c                | 5 +++--
>  net/ipv6/inet6_connection_sock.c | 3 ++-
>  net/ipv6/tcp_ipv6.c              | 2 +-
>  5 files changed, 10 insertions(+), 7 deletions(-)

I will send a V2 today, changes to net/core/drop_monitor.c were missed.

pw-bot: cr

