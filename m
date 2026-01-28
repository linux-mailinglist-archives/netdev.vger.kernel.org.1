Return-Path: <netdev+bounces-254234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPoCG4r2eWkE1QEAu9opvQ
	(envelope-from <netdev+bounces-254234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:44:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C82A0B93
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E625301158A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131934DB56;
	Wed, 28 Jan 2026 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjBFE+Lm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B432ED24
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600645; cv=pass; b=GPkQQ3UMvdaG3Gp6PUOWDLrt1gt+NbYsJrcfelMh3lFH5MByL+6heO8HX1NH/lZXgmuPQn/Gys0wcH/a0JHQa5O4kHkjCnrNj1M5sCPq66FooNWigy36cysKLWdt/CNV6qM9TFTibAEeW9JN/MtFm9CZGaRaN3+tvGtTbnv8Lv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600645; c=relaxed/simple;
	bh=puAwTvVmkifgHCG+CS4+S3AkOuTB7bbS4zZ4iZyMiCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=El8mPBwf94DkBMtd2um0ok34dqgmJJClyJt+fQB0jxi9/OMPxHhwv5vVGImbBx+4dbncYJqmK0FgqWu7VWfy7NrDIDkbdmkF5/dqzmof0FXb3TycCFTX+AhcbMtyw6lLIYgIkTGA8BnoKC3x8dEZnODFSvouTLbi62Lei6EVUJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjBFE+Lm; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-501469b598fso50756851cf.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 03:44:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769600642; cv=none;
        d=google.com; s=arc-20240605;
        b=VJJQlJsIbLcl7S3zpfRF8kSv18R0px2xzUmpIysCe93E7LeD7U6FTXhUxe+3nniRAU
         spa0Mv2NqGYlyuP49ONnuMrCQLOmInAYIDdlq7VQz15tqAR3ppaCfvnFoyMbDZlEEnQm
         DWzQ24NtV899A84Gbi4yFVv59VOUlfCqUmMFRQJr1qvw5B3OZAO6Vz9bGbgQR/zPkc7V
         hDwLLx8SesV5ks6Gf9IavPeuNVsa68TFY92g1qxTVrCWg2fuhqUHpqeR+P5qexIo7Nvv
         5NL8f0T3jqvjTyMLptwolXyTsklIHMwLMY4KOuxoyT3RK3LjVgAfTY/b/NZJIpX0fPmi
         vTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YoUaa72q5W2UvONTR24tbFfrkylb549w2NteFUNhiss=;
        fh=hejTrwsSVkB3ADvtaaSMSpD6gBrmYQoNo2YdC40kTJM=;
        b=cQwg4ZdqPCjjt6E+mtVVWT+DalyNekai/wcwgl8b6ES1hlxLTtEUFdaqhJDd4R8qoT
         bmQXcLxcXWBPJX9/xJDKpHtVcq8uQjo3Rj0AzpQp6JcIR65b/8A1yiSX/UQYXpVTRkIX
         TFEdxd9UIQG2HEQMTvgPoSMNcTbz1mBjQKzF1ego1UhRtZZbfSxI//9EmDZOdtG5bdKY
         HTw9OTF8Zduckdi6GMAMjtt6JU4gQltHgqaHNkDjUN3JSaTioSkYmaCuu9Wi7cgzgJJY
         cI6STi6MgTfw+1bKobAMgytzh00poQvmx1Dv6gnTc+fhF9SQDKE8fbRclpclvF3PsKoW
         DXCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769600642; x=1770205442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoUaa72q5W2UvONTR24tbFfrkylb549w2NteFUNhiss=;
        b=qjBFE+Lm5/a4oDawPt6lcj+HcCNeHvdsYMRtxTFaHdw658pcWzix1OkNf6rgKfF4r6
         trC08O3OBV0qplcgWDs2kfm2xGL+VdWkHAg8IWTtr2P7ejVRWmAXO2PMncApAqDSGkPz
         HkCdJKu7ox0NuE9vF/5YS0/D9+/R9Ld1dZoaAHAf9g0/+a4PEjZxkDXCXYo8CzaaTgJj
         lnSX1YUzOmY2bXxi/pM+Ddgv4bc9y1iOwpIZ5Ve5ZXBvmH218Y2phqfAea8VtaEprH2G
         ilzed+8fQJk3HcSUaAVK0ABBpses0F9gGvNukTvD1GZM24mw+ezXWyaYiCKTJMNJ6Ane
         QQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600642; x=1770205442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YoUaa72q5W2UvONTR24tbFfrkylb549w2NteFUNhiss=;
        b=xGvbPEm0wzt4Yo59XZpGVGu69aCrIeLnq1QwXp+MDH81g3IGwT69qLJ2eBU/f88Bqh
         CF5r1sL2YwDYWifS8fEujmJvJX/3wYmmxwzQLWFaO2eTPVZcR4VS8OWaLXhMztk75X6R
         dLff+BWxjraTPIHWvXa4Ncgd0V/xxKbL4RwOEHWv13TPUNwjpPr0Q1TNJdbubD994ZiC
         y9iFblizbVuNlx7cNQCDT1NBedUp09ZdgzOuTnyY3XBWc0KSrXkpR3s3a1B/mtmMnmKq
         lFAM5Ncv8vTGrytJino2HBpxp9GxPcmfYdWXp4lZAjkGtTgPibRcwD6Jul8flIq4VykG
         jNSw==
X-Gm-Message-State: AOJu0Yw+FKIT5yiFzfXroP2dTCw+hItA1kWmQnaO827TE9E9RkFaGv2x
	ltm1VVRBYpoyFLxVKkyrcwHvcoG1u42Ms/4KPadvAtFFUUwLKQ35n4dsR5V7H4hB5GtKCqyG/fj
	6EkubnRd9LnXXINN2fn0xK5tOkDxeRru510RcK2TI
X-Gm-Gg: AZuq6aLOg3Oww6yG6YDAhFOuwZN25O6JKJgM4nYE8brht2swmst28hRHHEmPKErS0oB
	lOoB+ZW+gmaduoRZaa5XTnrZoXoJ7JzLbZ7nMTyGQ/FHmn8bMhB4cqsVA1xamJX8fQDRQpM9gmR
	zS7QDNJ+NWqj2Kir0nS9Aa6Gcpk4UgHrZLxVsSMsS7VsXA/hH+8F0PNPijKzr4DbVDwAOnWFwVj
	dhYrRilYdOGVIyN9ZSBRb1xu8J9byfFtSl141QXTPgwmHRUDQthRPbZpr30v9LfksK+jg==
X-Received: by 2002:ac8:7d4f:0:b0:4f1:ab66:7c43 with SMTP id
 d75a77b69052e-5032fb1d4dbmr58370101cf.74.1769600641902; Wed, 28 Jan 2026
 03:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128070311.48892-1-mahdifrmx@gmail.com>
In-Reply-To: <20260128070311.48892-1-mahdifrmx@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Jan 2026 12:43:51 +0100
X-Gm-Features: AZwV_Qg3CGIuQfKn7wjPurtiWWqPhVy7GZpuP1NHvYr2CNRlAoypFFnf0txtahY
Message-ID: <CANn89iKwmhmAOConHjNP7XxVLghaJJgU4gDSH+To8Q1V67Jv0Q@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kshitiz.bartariya@zohomail.in
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254234-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,redhat.com,zohomail.in];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0C82A0B93
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 8:03=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx@gmail=
.com> wrote:
>
> This commit adds SNMP drop count increment for the packets in
> per NUMA queues which were introduced in commit b650bf0977d3
> ("udp: remove busylock and add per NUMA queues"). note that SNMP
> counters are incremented currently by the caller for skb. And
> that these skbs on the intermediate queue cannot be counted
> there so need similar logic in their error path.
>
> Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> ---
> v6:
>   - increasing a single counter based on socket family
> v5: https://lore.kernel.org/netdev/20260122185357.50922-1-mahdifrmx@gmail=
.com/
>   - check if drop counts are non-zero before increasing countrers
> v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx@gmail=
.com/
>   - move all changes to unlikely(to_drop) branch
> v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gmai=
l.com/
>   - remove the unreachable UDP_MIB_RCVBUFERRORS code
> v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@gmail=
.com/
>   - change ENOMEM to ENOBUFS
> v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@gmai=
l.com/
> ---
>  net/ipv4/udp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index ffe074cb5..dd302f5fb 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1797,10 +1797,13 @@ int __udp_enqueue_schedule_skb(struct sock *sk, s=
truct sk_buff *skb)
>                         skb =3D to_drop;
>                         to_drop =3D skb->next;
>                         skb_mark_not_on_list(skb);
> -                       /* TODO: update SNMP values. */
>                         sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO=
_MEM);
>                 }
>                 numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> +               SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family =3D=3D PF_IN=
ET)),
> +                              UDP_MIB_MEMERRORS, nb);
> +               SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family =3D=3D PF_IN=
ET)),
> +                              UDP_MIB_INERRORS, nb);
>         }

Hmm.. I have not followed your prior attempts, sorry for coming late.

Note that an UDP AF_INET6 socket for which ipv6_only_sock(sk) is false
can receive
IPv4 and IPv6 UDP packets, if bound to any addresses.

The to_drop list could contain a mix of IPv4 and IPv6 packets.

Ideally we should track SNMP values in the proper space (Ipv4 , IPv6).

See IPV6_V6ONLY and /proc/sys/net/ipv6/bindv6only for reference.

