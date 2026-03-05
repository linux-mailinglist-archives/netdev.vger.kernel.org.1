Return-Path: <netdev+bounces-264499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LrBH7G+qWnNDQEAu9opvQ
	(envelope-from <netdev+bounces-264499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:34:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2603C21650F
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 844233006787
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483593C2772;
	Thu,  5 Mar 2026 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DaU5PrWD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56238F49
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732078; cv=pass; b=FcDZQjkE0pqDPHTs61b3vocAG4LbW+v09VbK6gey8OX0f0susK8w+kyX8s5aGkSDRnqc0GcIl2f6pO02R70DjWhD+3pJJUFoNMCQfAchLrHcft476/UryY68LvXQRvywIPURY5zzwKcSPnDZnYJ+/N91s3QvjoLCu3/HcTal7F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732078; c=relaxed/simple;
	bh=I2TJC/EhEoqOOC+MKGxOu4LgQidHK31zkKbXGh1FN/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtW2wEtVWzLJDh9Cvg8bSYAHAkyl0lKpQmzR9x73DuETe8pCAfZw3qq990MvsTzxeRHdvxMv+4M3ML8YlkUJaicimceSSXV9k5H6WOsNYy67CUoLzCrwu1sg+wCKvGurMU4lQIgI5gAtPG2F5Mh/PpeMJwnXhuOdtNKNrUB8aMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DaU5PrWD; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506a355aedfso3121cf.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 09:34:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772732076; cv=none;
        d=google.com; s=arc-20240605;
        b=Qz2ydj/5l+5IFBW3B7JLKBcSNYHJl6PtuxIw+QXu+RXP/e+BaIAKm+y75RGs46nQLs
         7Uu4hUWmK2tIkRCywCctMeCZVB2aTRvpnKU93m+0xzYD/nqinEpMRxTnmAJZ4rBpxKh7
         40m9bmn+rqOZcxejmyifv+iBF2LpZSxrimESNKlACDh0UdGQYIFpdUs2K8iESnfCGsSP
         1b6oZQPGy/1owrVI/toPDvxWXM/WWWTy9/0T1cItO7cq7pOmZv06q7KD0gCbeRqwZIic
         gYtgX+dRQOAZzGL/ByQwJeGcLOKoE3syx1bvcyu6kERiFE7bnQzDDkNogAHVqypcz3mA
         hnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/nl/BMZ/ZTEciCJ/K4c3M4p6En6MTC8QBLxjFca2N58=;
        fh=17ZAwv+bqBLpgzv+7tXTAcaQ8XJBapfRYtAG+Hxsh7A=;
        b=aev1LLp83AE/HF5s/2Cor5AdlQ1AmTaQOR4Oet9pr+pISfqBWu+OHyIZS5a5d+zZdn
         s3k2uz8Qa6Ha3FBBqgKGNW34eGKG6N+ls46FqDBirK0uYiGrxjkcKwExRvjbXZ6lKP3M
         NeU3p8MeivDrJbkqVEvkBlgDGAt4K5HBLlmHfcaqz+hNa1Ukno49ledVhnWeXpjIuzv+
         lbUItrZoPbfRiwQJAyF11/FMiI3CcRBBG6EY00RMK4UsZU6YqDn6h3abCJbpKXuh2rKF
         mHQIWazbAFB/5eS54LR/j91ktGiJPGbsn/70iXy26ICz4qFz4nL3GcsGV2TodHyaktyk
         3W5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772732076; x=1773336876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nl/BMZ/ZTEciCJ/K4c3M4p6En6MTC8QBLxjFca2N58=;
        b=DaU5PrWD6TX0eXUA5vNPBwUmFrykIIku/+kTNNUkDuZax2NbTRLXRf2plhDyAp9cBf
         OUSYxZj6ebRbjR9nDqmX55T7eRghiuPxOAw1s8qfJA42XVB3YiXF/uscmOe26A2APhNL
         rOHCe93IpJCUNPX2r8B+I+jBLxbaDqGS2MDTTSGkERbCU2liLdvpLHKF1rN11BlHWBou
         CwhLmPNOQYaaHQogmMLmWH6Zc+Et9F8hCnq3ls43xheZmiJhzwCCqCb3zNsFDxu9SEjv
         dWcdMSf7GRZkQ9V8AUNFbuXIrRkXTPAhIh76+7kxwV/CFTfHPkLbiIrJCO65FJZzt9MY
         wUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772732076; x=1773336876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/nl/BMZ/ZTEciCJ/K4c3M4p6En6MTC8QBLxjFca2N58=;
        b=A8L9HrxzRIBWVccAeodCuMGeiWFwHQMMzbuW+1WTW2HK5o/DIrl90tIX/jDOilFEny
         YRUQrDM8dbzl5nb7KQ0iIR30ua4feC1uUQtoMDxAgxhsn+e2F0ypGHyW+2RsvKwY+yUm
         0j2KKlKJ6gjwjg+WW9Povx7P3In+fop/oEF2+daN2or2BwbKLQU1ewlYUb5D9f5YMDGR
         a8Z1l7JxMcFSQh3cEME/oc8DiWoeTKhRH49e1bScuzrqcVeqFZgInEoD3rtUttLt+KEr
         dDAOdi7qyc3ayD6Ht6JCPk5W6hlGlhMyB+N9kcMOdepK/4EoaXxvASLvrWE4FEEnmXFx
         QhOg==
X-Forwarded-Encrypted: i=1; AJvYcCX/5wPPhiuT8iOrRmVpUthN6of93uEfug8Q0ROoIbTOzAnyygahTQYvaMtwyqSU+I2Pl7pLU+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQ6YyJF5yHuOwsFvgqK20tSTOsF9LiNBuTWzVM5HSYC3XtJUy
	NWFX2oE2sh+eVeEk0g+GjuxYjDW0KRWbMtOXDZ/21J4qaelGcJBAVj+tB3CapSiWfMZqzXU66mi
	lO93TRhIWnEt3b9PhF0SMG9oaKmcSi64CPIl2ZZC9
X-Gm-Gg: ATEYQzx06Zs9DOCPtgqoNaat6h19kWagXzgsYQT9w3U0ICEHEyJG6ftnmsGrnAv/yGI
	39h5KtRY5lcOQu2qx7g+MmZo/WO/RakqIZ/rna3Z+Jn1yP1OVsnL1b3tizDlPS/Bdbhn8S9eRc5
	E54gF09R4l/Nh/tHEN+LRvvlU+EOtqFFbmC7eygFOoM3dhdmzXlftVGO6Vekp67VBUbfGXupEcT
	PUM3WxW4KgPcZ7rRGgwsVUWYTNyHi/4MrWu0iqdzlPlRkMBXLW7EFDHy69zG5QxvxQZ+wWqli1H
	u6Sip5S8PEQ0HwzLlaDKJD8vDg7L9N1RWRIJjg5AdvesoANI/t2qo13D19XkPDxYWe07div2Yw=
	=
X-Received: by 2002:a05:622a:53:b0:4ff:cb25:998b with SMTP id
 d75a77b69052e-508e5e2b32emr10455151cf.12.1772732075316; Thu, 05 Mar 2026
 09:34:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305114829.2163276-1-edumazet@google.com>
In-Reply-To: <20260305114829.2163276-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 5 Mar 2026 09:34:17 -0800
X-Gm-Features: AaiRm53gm4wLRjI3S7NJlzKHBp4UVnL3hClt8rMbVryDVQHTarRWem2aE47Ps4w
Message-ID: <CADVnQy=-e28Mqc4qeic6y9hgwQVqrCJUwGg2wugQe8jra9WaaQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] inet_diag: report delayed ack timer information
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2603C21650F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-264499-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 3:48=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> inet_sk_diag_fill() populates r->idiag_timer with the following
> precedence order:
>
> 1 - Retransmit timer.
> 4 - Probe0 timer.
> 2 - Keepalive timer.
>
> This patch adds a new value, last in the list, if other timers
> are not active.
>
> 5 - Delayed ACK timer.
>
> A corresponding iproute2 patch will follow to replace "unknown"
> with "delack":
>
> ESTAB 10     0   [2002:a05:6830:1f86::]:12875 [2002:a05:6830:1f85::]:5043=
8
>
>     timer:(unknown,003ms,0) ino:152178 sk:3004 cgroup:unreachable:189 <->
>
>     skmem:(r1344,rb12780520,t0,tb262144,f2752,w0,o250,bl0,d0) ts usec_ts
>     ...
>
> Also add the following enum in uapi/linux/inet_diag.h
> as suggested by David Ahern.
>
> enum {
>         IDIAG_TIMER_OFF,
>         IDIAG_TIMER_ON,
>         IDIAG_TIMER_KEEPALIVE,
>         IDIAG_TIMER_TIMEWAIT,
>         IDIAG_TIMER_PROBE0,
>         IDIAG_TIMER_DELACK,
> };
>
> Neal Cardwell suggested to test for ICSK_ACK_TIMER:
> inet_csk_clear_xmit_timer() does not call sk_stop_timer()
> because INET_CSK_CLEAR_TIMERS is unset.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

