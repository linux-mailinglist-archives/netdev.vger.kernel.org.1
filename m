Return-Path: <netdev+bounces-266902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNidAlY9smnzKAAAu9opvQ
	(envelope-from <netdev+bounces-266902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:13:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A48E26CFAD
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E39330157E6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D543876C3;
	Thu, 12 Mar 2026 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1wBRX5L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F85390220
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 04:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773288787; cv=pass; b=Zj2AQNte09L4GWiE42lrLb8NHx4dyz+1NR/Rdl3f14e/vdVkiO/S/c587YhlFueFjhCvCHsr6KvVthNsO21Nti0DJR0SRrsnWEUDjVkRRzakAIuRz+3kMZN+o7d0o9pUXEtW6yx4Zjaf0Os1kTaQK/2HIdwjyD3f+RjAShdamYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773288787; c=relaxed/simple;
	bh=cH7qNk4D7abhYV01Aa6ZmoiIJllWqwgK8v2iVDRM2bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rscIEkQNGwVvSacF6LD+fSqnmKkzCMiw3VuxETle4JuCI1Jg3vQD/v9Wot3hksp77JWerNisyZnARaLVpIxz3Ef0unLWE5FXqZOT4K/iMeg5M+tOykd/K4YVW+WTa/PNmARl9lnshMRbnnHSNt/KbgzdjKo//JlUK1FBkudk6a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1wBRX5L; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-509101189f4so5175861cf.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 21:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773288785; cv=none;
        d=google.com; s=arc-20240605;
        b=bql6PE9+ccJxfRcd6fos/+bNcbNYOiCpBcjCYPfeMLrFpCeN9QoCKRpWg97/gcwFdT
         GCkVbndvmQZZlAlGrpRaOi19bhHYEj0KTTQ3R2/FpgNvwAnoDybPul6NUFKPj5AP6CbZ
         wb0/TX35TB4CzXu+fbwD/yUheHLO4URXLpCODYRbCS0yfQdVpKzonkyA3ZKN6yab4go7
         KTQXvAkknzV6ATbE4NAWyGLMw7o4Iduf1cUXe4Gwl2ts2mGBQGRgth3dcXtd72qqW2nS
         /+LvIUm9sA9KRmTBD1/AH+bah0lGZtPyMdSDkZCH3Cm7DGSbboMBSlY1JACeYC4qYzUw
         6NaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZwowkJ+ef4NLgXuLaG/pevMJISu8sLllw2BooraGq+U=;
        fh=8cGWUrZHUqwBWLOLuOZGnC6kIR6aF2GDYGwIWLi2vq0=;
        b=GyTC0FdaqPRXShH5TQkHjr2NaO5AxeCjB5L8IBdqLMC6L7TmVaVsHrxUQrcTK+syX4
         ZCPXWzGK52Pk8XFBBous/6pqLq38uv9+zwdlVdJNSmoXMY/3g3SU3R9GStLKwFYaaMFf
         QYWbSK7FabT2MGZjav8oBt6taOICxFb4RkBXRvSbhZwJG4FDxsYXMdcva2ueUylxGsg4
         5LIqbCPg4jgQEaStdefL41cnZsM9OfEK/Q21r2UCdP2nmWHXINkPfQT60rZ8IvwwzXVc
         i8ERp5nLZjOpnGckcAaxk4IhCIWpFLYqlPWHYX+jDvJB5iqJFE8easuGZvqgQ3WCkTaP
         q+Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773288785; x=1773893585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwowkJ+ef4NLgXuLaG/pevMJISu8sLllw2BooraGq+U=;
        b=I1wBRX5LFDTQhFy9fXtMTPxrmzaU6Sy2wj71a1LHFGHHTLwgRMzycORCPymu1H+ENH
         j7B6z73RV5tYa1HyDdiXUcKKno2KmNwz8m5spiku1ZjO9Koh/Fq9VUzfCzyMdx9t4OyW
         SU5oA2lKjudw61xniJjS74VMxiGiVFwRXnLiaTqSdnGtIy2wec8gAC0opj/H/NL+E7ra
         sw9CIiWfeDa8DO4SDjlRPMJWHzjU+MdthJ95h+9+pICV04sG+Fqa4BdSlJ4zDF/kSLA1
         IjL6/1PDvAK6EiVvehPKcP9lAUCK5l8GQV/mumO2oQWeOrxkcYcJGf2Fe2EFRTBLM4Yh
         0f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773288785; x=1773893585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZwowkJ+ef4NLgXuLaG/pevMJISu8sLllw2BooraGq+U=;
        b=QolxYSmnLB+wBJtPFsNcJimUTfeQNyTuUjTg0keNfyZ2MEKABR2WKi7uYtAzm9t2zt
         QIjUw2Scba1mWaNSgRGpZ1UNyUiYHdGnC42w83bfnHRdSRHCmWQ4k8/DDN7xahIrWClS
         JO1EIbHLfylHshjAbKi8+34o+6M55OCzVdo/rG5nYTwOl8GAnMKvoiadERKRRdQVDEpU
         LFDklP+BV5NeWgN1NUKtSgipwpbKbD/JgLwCl/KRG+LJYfTDRNentDj9SZ+G1hU6fWZw
         q9eogVtd0lnOyjbBwlH5DnO+UtSToGY5xBzhDz5NACiwczX5ePVkxZGnS1oLP+mTh24w
         awRg==
X-Forwarded-Encrypted: i=1; AJvYcCVM68FTlLMzaNOMk73/a1PGbCu0Y5bVIlcgO6JXuJH9cBkegjuu+oFFRy2JFDr3roY0XQagCdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEoAQCcwusI5HqfOMpteq2dbItiQnkf2xfIytgoz2KjgjZ88u9
	0mkTeuRC8QMWhkvpZHkEXXa14FF30cMZbpBnk8RtLIeuxUyMbspr4iKW2RTtDfaQuDnjcfUnGi/
	i93KM8gZEiNONFp64nwgxJ/aHEzKRNHgsjgVdm7ZS
X-Gm-Gg: ATEYQzwWIuDS89xigYqgUR3GpvslKHHDjEztOUQyocveCel8v4oPpu/W+BhEa8r2BSa
	eU/BQfSdL3LwxuQwpdO4nvuZVnys4/3QeFxQ1qMB86IjO9kpqdYR/F0rIFKx4CQP8d46a6bRLF7
	RjuVV0skwT/r1/O/MLQbgQBbOKOfxPbbjNV12Tf8hI4PVJdLO3uHp3rzG53+ScUu6VW3/F9Lr07
	fDpF3QC+nraqQ1vAxR8Xd2pTpSbxwSIwTJatsiCwz0xFV1C801vEBlafSntp+V6VOrWnfIZy2VF
	4PUDyhw=
X-Received: by 2002:a05:622a:28a:b0:506:9944:8cfe with SMTP id
 d75a77b69052e-50939f6e9dbmr62326321cf.15.1773288784655; Wed, 11 Mar 2026
 21:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312041123.2756608-1-edumazet@google.com>
In-Reply-To: <20260312041123.2756608-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 05:12:53 +0100
X-Gm-Features: AaiRm51qig0Gj_8yYie1cl_qKAn7XEQstmYVBVoKqsTCNKe3psgusNnrXIScFog
Message-ID: <CANn89i+fFZ1JS_ii9QEXsKdPq5nRAh8b1wqP8s3_FT3TdwqTZA@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent NULL deref in ip[6]tunnel_xmit()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-266902-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A48E26CFAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 5:11=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Blamed commit missed that both functions can be called with dev =3D=3D NU=
LL.
>
> Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functi=
ons")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> CC: Weiming Shi <bestswngs@gmail.com>
> ---
>  include/net/ip6_tunnel.h  | 2 +-
>  net/ipv4/ip_tunnel_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
> index 1253cbb4b0a45f1c62999be21931ca31b596697f..b964b31e8757858ffafe47d00=
3028d9a2640751c 100644
> --- a/include/net/ip6_tunnel.h
> +++ b/include/net/ip6_tunnel.h
> @@ -158,7 +158,7 @@ static inline void ip6tunnel_xmit(struct sock *sk, st=
ruct sk_buff *skb,
>
>         if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
>                 net_crit_ratelimited("Dead loop on virtual device %s, fix=
 it urgently!\n",
> -                                    dev->name);
> +                                    dev ? dev->name : "null");
>                 DEV_STATS_INC(dev, tx_errors);

I will send a V2, DEV_STATS_INC() would also crash.

