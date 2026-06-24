Return-Path: <netdev+bounces-301766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zv7wBRgrPGphkwgAu9opvQ
	(envelope-from <netdev+bounces-301766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:08:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A68C6C0DF1
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:08:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j9Xee0b2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301766-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301766-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EF0C30237C5
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9414331ECF;
	Wed, 24 Jun 2026 19:08:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542732E743
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 19:08:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328085; cv=pass; b=KAHDxICX5q16wZkalaa75Xel8fzCNpK2oY7GQZxvqjp0S8JjFBDWC9qltBbQZJnKOWooxntJjzZPRM1FoDrAqcAK+Ml8DShSmZUAC8KTbhU7sOat/WlKXzd4eZ+ESD81eKwX5z/RAJwLlkz1ZYiXK1oX2Ng6DtPNPixbWcnM7mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328085; c=relaxed/simple;
	bh=a/LXfwsYk03RG+j05HejQJt9P+Em4FQt7v8Wo2dT34c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XU5VS3bJ2npgp4bo5mL+REuad44cIE+V6wYKWyFYrPAiRBsR0mzY0dyrJAWWBZdS/SJS/60IcyFQ/Rf/AlzpMgK0rx+42X52Bl/3nl0pAr7s49O/BkxMWgaqTkm++YsX9SuwlXcBwEpQ1jHZJjiKUJpY6Fh30fezWYUJabfnvhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9Xee0b2; arc=pass smtp.client-ip=209.85.217.42
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7276a7aefefso552193137.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782328083; cv=none;
        d=google.com; s=arc-20240605;
        b=WdEuFSHksqUgHz8rf57NbZbGgO8xhFRv4o9Hz6/M3ubyKyivjMSTk1IvQvylTcORRM
         v0EabE3hHcUhV8nYnoBjUO2+oCb8qEQJwHx9RTm+kKrX9GOPHpco8aBqDj4ExMp5iUBM
         KrkgFLcFa9BkzhjVRPNkAzBbo5o9XmsZQpKeUJbR52eYKFRrEG27KwbtufaWXxcVc3V1
         kzhir2AOT1H3Dn1GIa9SohYm7qrPL22/epoEwiHh3vr9ic+YMRhfmSauH9bCCneqAiJu
         F9vdTJH5WZEbO2L+zgXBTXBSibUaYpMr2XdyDyH0y94GsPGOS72hjKbjF4WQEOzTbzJ5
         KUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7yvOePNFOw/xDYjvVuPFW0GtX2+mt0frb/jI2djDuck=;
        fh=LFt3vGNUQeVXgdXz+KpTN8enDKGxxqQ0pkfAkpS372c=;
        b=Tq6Iz26Q/mAqVPCJfmfYgTdsS9nj4JVFFRBZO7/TZMe2LCNoFVpmH19FaAXK53qkcA
         C4lrDg/PdJl4x0p9yCcPwCn6ulW4dY1qKf/rLmVvcrNVk55zDIcsOsUbZSXEwJGltNKK
         nZziRrdV7/UeAhiMEt8WH3LMRkZJAXd2rGtK8/you69bItjKKx1HDAokRmDCBtCeTGPQ
         J0UgXItj9EyaTqmIZSeri17KIcbBdSmQrcFu7yOVFtJ3Fp279Wqb2ET8FFFE5EcgL3o+
         72iiXv0o8bM7dSn8h1iL5KAGjigh8HRZk3b8ByOuFLXCrmuFD5tTkVDNwmSP4FGeQKrI
         PCAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782328083; x=1782932883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yvOePNFOw/xDYjvVuPFW0GtX2+mt0frb/jI2djDuck=;
        b=j9Xee0b2WMsJiYELfzhtcS5gk9+03RtJCSM3L0fgsG0j79iPA6fJa0D3EDgD1zJXFy
         ylN3ksXJZXx7IBbxqkMCnhL8w9eK8ZsLFcYooy3nSpA47fDwXViM4eFHcbLBWJqA8Fqm
         PdVKWhIaRaxkezG96itirbj5HUC7WrruL3SBdZEfR/2vDCJ5LjO6fwVt6vwj0fXmSGxN
         JDD1hwtOlH8uLMjMGWePQJ5eBZ0/59UHvtFqx0BHgbxjQhLHyKiA/ZdWGj9eLqUtQKfX
         OIXKSokPtGjq42kT4HFldLzZ22Xy2TBttPo4l9hJnYJJEx8rI1LTnLnVTMye0nZnucCU
         pkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328083; x=1782932883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7yvOePNFOw/xDYjvVuPFW0GtX2+mt0frb/jI2djDuck=;
        b=ljMF4E9n7tqARPz2mZcPtlgr/QXJgmNpSy+x37fnAONmQyMM6oq9TFgskc9C92Q+HY
         Wy6RIvA3s4hlANYCBgzkd8Mk031duGFvdj6iDLjmrZHK4HaOOzWj7osp24qC9pJC1FwM
         4YTE27aCeIN6G5g8D9Nd47HUE+kHpQuZJI0etlr7b/o8tiYeahh78av9+1F7xwTewx+t
         mVw4pQ1nJlP9fqf+uIMvmViIu5VU/XGcxWZfS7eC+ihrBMDgSx9H9TFu7654OwrJ70lJ
         jBrH84i4m7Jz18nAIoGQ7NM9jZqGZK4aQ/LEZxG4b3bVZg+o7fs0xQvv/ZQ4+sGQwN71
         vePg==
X-Forwarded-Encrypted: i=1; AHgh+RpZc135bnvobtnRRxAsYiOwG0vWJhBROEuKUMek1YdS8d0/VZaXKt42fLuH9nNM/YDWy29N3I0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw06goZBFTtS60NW9SPPihRVU7IAuXxDcektUYYyAGoSmHl4PP+
	+QnEhjrMxkA4qq1g3Pl9Dec8iK8CU0t8T/ndnl9QNbvjoABoqkwfH4A2QLLiQXzyqM8+vLeu7Ba
	7dux+JsM5xMJX7jlnrNbrxMu7UK6xDoY=
X-Gm-Gg: AfdE7cmjibgdVa6FEZvEWJn1m1sHHYWNr6c5FHnyU91QtfLcQrUPR9CrUuRyA2fFXiT
	0SaEy9yJFoqj9ItqG5n6kQJzqJfBC232yJz+PwLVb99iX15mfw9aSMokz2McI6YwbpwW/1Axa1+
	e2pVNu4HFiXZuKnLSSPlWAdgy8KK6d1nqF7tE//cxDITNpg0rUG83SfRTwMTCAUtBc4q2cOVGct
	JgWCn7i6LmMKxIJnZ0fz3SlSzGMe1ViNA7SM9Zob0F84zKkh1BH3vqEPpNHMP4Nd6aXlYsLK3Kl
	jsnM90NiH0claEAa7Mq1tdE3twJwhmQ9p0Ib19In9jMNO8GSsqbnua0Ig+kuMLUDvxCPJpai7PO
	gFG84VJU=
X-Received: by 2002:a05:6102:3f52:b0:6c5:d55d:c090 with SMTP id
 ada2fe7eead31-72fd548f071mr5681782137.3.1782328083555; Wed, 24 Jun 2026
 12:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623173030.2925059-1-edumazet@google.com>
In-Reply-To: <20260623173030.2925059-1-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 24 Jun 2026 15:07:50 -0400
X-Gm-Features: AVVi8Cc7g9HynwWv3noKDUA_HTIXkRh4QG0NE4vGm8qvUGWCoPR6K6tHKtK6PbA
Message-ID: <CADvbK_enr9GFw34DSRYA24kVKp9UKFggHwMEMXEs-XTD_vhSUQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 0/2] tipc: syzbot related fixes
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Jon Maloy <jmaloy@redhat.com>, 
	tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-301766-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lists.sourceforge.net,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:jmaloy@redhat.com,m:tipc-discussion@lists.sourceforge.net,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A68C6C0DF1

On Tue, Jun 23, 2026 at 1:30=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> First patch fixes a recent syzbot report.
>
> Second patch is inspired by numerous syzbot soft lockup
> reports with RTNL pressure.
>
> Eric Dumazet (2):
>   tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
>   tipc: avoid busy looping in tipc_exit_net()
>
>  net/tipc/core.c      |  4 ++--
>  net/tipc/udp_media.c | 19 ++++++++++++++-----
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>

Reviewed-by: Xin Long <lucien.xin@gmail.com>

