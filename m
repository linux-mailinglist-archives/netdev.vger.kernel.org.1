Return-Path: <netdev+bounces-274987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLmmDGCez2kTyAYAu9opvQ
	(envelope-from <netdev+bounces-274987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:02:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8503393795
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0787C302EEB5
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A113399357;
	Fri,  3 Apr 2026 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VM0rvgCn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A2386438
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775213973; cv=pass; b=XAndyeO5bRqXpXaWmd8mhyBLYNMLZkHFh8fDgrWl62Waso7m/IT3R9yMG8mY1kKeGU/qQyJQ7jxoQIDYZjfSP0enSoiQCLcxdLjEV9ugLL4ygrZV7IQyZmbTVDOV9OyGKZTm77WkOxT3gF+2r4k8ByoAdR9xDgf4iQaEd5yyDFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775213973; c=relaxed/simple;
	bh=tULb9t+RhD2Smo2f+520AiANi9csECHKgXudevq6AIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z00NjcjSM2hZwecDIXTIpsjqajhYBocHINItRS8tgEPKziR0hI0V9uhI9LI757QdMSjHvKk7JvKMXc9gKkdC4DxFLR/rxRUWUWEV5RH1AvSZnL9GgpxblcGnbtPR3nqP/6dZPaXAZR5+wnuidKOZmEql69lYl4gOyTHYqhoYMmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VM0rvgCn; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6f21c2d81so163466485a.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 03:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775213971; cv=none;
        d=google.com; s=arc-20240605;
        b=SjwMV3FTZys7gPhy1y0DV8fW+cHp0pXNxAeq07nA8uqWuuawpyddKy6rOy5XZG7UGT
         W4MFg3Ixh0WMlGIOHVO8rBe7eLlijdeCSztWgPVpvhbASglmn0FMdCmlImSKN/a4TmY3
         ZjYHFQyrcgxv7HZDyIkIC4crblfyqJuY1b8qYb6+oJoWJxwEuSWG9mW0TRfafOoLFkNT
         CtxaNKh7NHo0R34xb+BBzH3i7R6crn2gunPU8029pdpmEqn9wgXc2wj9r6C/gqXS6WhT
         rMMFfeXDqcTa0bTl8n5EL5HMq94K7RKmASUwMFR43pgctAOKcHkRPW5AXL5nSrShY7ud
         hVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DTbNWpf2oY1TuA4rqnb0S82auaEZmVEW2jNmCIvSAZI=;
        fh=gyNJ84FrxRCPWL+k324zgDZxnV2Pk4koSVN7/8CmRmA=;
        b=Xg3yjCH6HMQ9q5wKvMnPKAYhiUHjBg70zztK9NQQKhroXStjz4JiYlXlJUzTGuxXHq
         3W8X1in87stL3WhdgYP1hyT2DxDXM81HCIvsfZToD13gSJ+NBUeEL6uuVmm8qulfDeCy
         59B9fiuujy8v+RoK0UlwwLHPLJsv3UI8PjR77YbF8uIIp3yBmE1CJ0u+XgVhDWqFr/Dx
         c5fxocvjhko2oulxUhpjpnpnaK+5tr6szNWiFjyEPBUNglkSWB4wATTOM/7dmB4nZLrh
         A5k1Ma47vLpG4Gj94pAsOqVQHAv4fKZOz7ylhgG5U2IEIsAgnJkLzqfbZkjtqFMoXbsI
         ZMOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775213971; x=1775818771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTbNWpf2oY1TuA4rqnb0S82auaEZmVEW2jNmCIvSAZI=;
        b=VM0rvgCn12hcuN70EOFhKU5zWAin1jd9Q0qpSwDURxbkOgsQAyiuX+6QZx6xAHCmoS
         KaoptmWTlTGNPAChC3Q8PL0CkNgkevICKTFMYSGV1qwOggZucdcbp5xdhR/PGsox211y
         L0Gt4G5ilQ13TFLV3tEB5/gIasEEau36CL+YN/RjUY9eMPV6cPZZe6YQpUAWsf4YIenS
         eA1BEqiuVshlWkCzBihiligMxpnZ1jUR3y1P6B+UTRuzwXM90ytoyWfI22LONvOhTJf9
         ZY4jdHp/U0/tcW0V4O9LID3U+GGVZBq6MJcxYMR1k7gWF1PYZCMvyBWRSclP+GNBztUA
         ER5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775213971; x=1775818771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTbNWpf2oY1TuA4rqnb0S82auaEZmVEW2jNmCIvSAZI=;
        b=h9u+LpL+dgREg4/gEkvkcIp5qKyWfmjZplPmwWNvxZIC8DzAEGeiAiyRiLLxkfks5t
         tPwxayA4AnDxluDlQhhrxFWOSXNBhtgSCkEB9Vuat9klfOpuHMG7Y+jpI+4IsgGA/Wm0
         pcedT2PsT0cDuLRhy84tKD1LwQosuIoI54QDPDyf8ZiRzmiZybjA9E26okovTaK9JqHZ
         JNeiifPBIwcMujpQX7JX4IUif1g9S80nJwJy880DdRppx2zTwe6yta4JsRJlJnN+/L3+
         pFPiVSutbv+ZyRtY58ADZrLldkvH7PPYSgh1r8i9qHIKC9q2s2ppqk5MK2me5uZQczh6
         ceWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHXaYYkyLHXLLGMfm7SBatFDuzCc53hDP9teAvqu0zU9lI3qZa8f0n4CmmiGOF90FTl3/FNGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBmYY9AaDHG2d9SWM/EFQejtYsEUyHdGTFx9H4kk7WdO4uqDW
	GvXpouRs5qRcqWVigX5RUR4eyC+jfSW0GUz5RhsXwCuGMG1B+orSYxs563YVWnl6r6E8Dg+lS0P
	XgWQA+T8aRQoayV1TOkwrzEl2LSVmpvXdrAVyX5Rx
X-Gm-Gg: ATEYQzx+SA8dPr1itMSbIRDdESEgxCSoAPzag0zdi9+XTH8N9FCJUlBpfgr+e6iTKQI
	7zxHYgWuptTl99nT1iMkiYo1yuS6T8HFpgBEWhkq0RDIsgSSAteb/JEzhG0RpMA1ObHIWxlt7PR
	K8D1wfkahA7F8JOHtO3ILJFTzAw8Tr7qwb+9b/2Fk7VwbnE9nTxR9F5rhakm389s1Z5GKdNmHx0
	ZrLE3sraXC8hO+DZPuvAegLc4LDDBJX+MK+/A7dpxWt9Hn+IaKpsjtL06jImtaBwJN49dk6J78g
	jpyD6NI=
X-Received: by 2002:a05:622a:a:b0:50b:46c2:bb78 with SMTP id
 d75a77b69052e-50d62e676bemr34586771cf.63.1775213971083; Fri, 03 Apr 2026
 03:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402174430.2462800-1-edumazet@google.com> <4677d96d-3509-4bf3-855d-b3e0bd956722@suse.de>
In-Reply-To: <4677d96d-3509-4bf3-855d-b3e0bd956722@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Apr 2026 03:59:20 -0700
X-Gm-Features: AQROBzATJJRFsnd3sWjtXROpgrXds9wpInDlQmLi_F0Oiv1a-_traf7nIL1IO0Q
Message-ID: <CANn89i+kEU2yu3XuD+1Cy_GVxPAKT8hiAJBh8yXT2RAfS8h1xQ@mail.gmail.com>
Subject: Re: [PATCH net-next] inet: remove leftover EXPORT_SYMBOL()
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-274987-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.de:email]
X-Rspamd-Queue-Id: A8503393795
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 3:49=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 4/2/26 7:44 PM, Eric Dumazet wrote:
> > IPv6 is no longer a module, we no longer need to export these symbols.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >   net/ipv4/icmp.c        |  4 ----
> >   net/ipv4/ipmr_base.c   | 13 -------------
> >   net/ipv4/udp_offload.c |  4 ----
> >   3 files changed, 21 deletions(-)
> >
> Thank you and sorry for missing this.
>
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

No worries, these were not using EXPORT_IPV6_MOD[_GPL]() yet.

Thanks !

