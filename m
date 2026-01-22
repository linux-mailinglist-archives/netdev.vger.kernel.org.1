Return-Path: <netdev+bounces-252374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFDhG902cmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:40:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C26806D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18934989D37
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106E134A785;
	Thu, 22 Jan 2026 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Un67D59/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F22F28FC
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090100; cv=pass; b=UtQ2vQ1ruDTT9IUfFuXazK2tdgHYmFxXwWap2/OF/ytgrvpF4QRncYK5QvgOUsFeyXCp928MRRy78/MJWQN+V5JWLNo4Drx1Aecgy4dQLhlkhrDbkRybgtqTJE/Znu2Nj+ZiEDjIgwSxWp3KFjF21g1rEZBjIuU3suXCOBwjw7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090100; c=relaxed/simple;
	bh=gVSZxdxPBReVZyPqmvkoSTuZzdbDdoqTl4x58rjozy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkVUlzYzswHjPlaCKFjiNaL3qfnqsFkKriPdHrldCgs4FCgeGwY+R6+45+CW9qvy4mex5LEiy6wEr7me+GydVMXywLXuW33/T/UKgNxqy60E1eNSVq55oath3EP6WbJPPkFbTNif2pzWSh22ae/TQS4MUzNF3wwAwR1IjtAtZdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Un67D59/; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6a001e3bfso60168085a.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 05:54:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769090098; cv=none;
        d=google.com; s=arc-20240605;
        b=a4+sh2kcoZEdrHcVbfoOllsokowwsFfEq+clQzged0fTjQuESu9RfCbhehK51Rb/g+
         2CZsAGAHm2ZFOziSY7NCjHCIu+IODCPLmxGhenh8me66xAYZXP6FKWfco/BUIZKqGKMH
         3+ZUGJchhZ8MwFOSQqA+AMNSALq1M5czgM8Z4Lw09i//3gpOTYsRtPh5qHAbarvkhQxx
         LewT6F3yJ2UCXvtIDv3q1OlI7V7ouiJMyt5Yx23AdfNUuGaZSKwNUppZlzwjUnm6i0fr
         1jZD8FB+gko4RpGHasZpID8+dyDlryh9106GExFzpf/i5lVfL2KGoBQL67qggurwbNcS
         KnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fnv+Qq8ruMpyyncSYu+WMygfb3R6Kxmj82u6o4NFWt8=;
        fh=lQQ0/j05EvZKWId4kHMvplmCgzX8+CX6B+GDfSr58Ys=;
        b=j0z59YOmTO/SdCE7N2BHUdrT4+r7/FTc0dPTG66ZUByE1Ndf8Kh6yP0d105ny0OUnR
         rNrReCZSodCnbBXk8yFR9HzRccQMxhozzL1BkWYXS1e6jmJRyHJ+C+2wS+allAQj21II
         IV9F9RU+9Y/E3wi1CBY3Xz+8egVbixzq0SqCLgzK5LTvA2xaX0sX2ZXMexCw0K/jmkYr
         ChUuteD42YGGMMqxamgzZFbxBheY4BfrjEZTLGCoOijep0/w5hrIi9b2cKyrcH0nbh2X
         8vvqzMvNYEnJqUAPR/dkGUu2zFXJtgn/HJQAKwpvgO9wKdU7yuPVYhDeVdiWDV3lUJIA
         GXDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769090098; x=1769694898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnv+Qq8ruMpyyncSYu+WMygfb3R6Kxmj82u6o4NFWt8=;
        b=Un67D59/piJMspO+e6ugEWg4KV9+OmXJgnEFlokPiKc7kdWJFeMkA3piokDgKHG4lq
         eb0kDsXaNiUo3vGH6bYuVyXBqGMT08hXAdt1UTWZGS3cfI5u6/c7sKxEE0JESTLduI0N
         4ZhMQdpiUBbhuKAb92ZVeH+43csDujNrR+4c/mXz7EC9wdhlar/Obp94HXcdVLc8rjfc
         N3GKurNdqXDEpoDufaSMJVZUh6tmdm4isV1YSptPNnaeTaEo8FHZ/+PSx1BNSB8TRyr9
         eyoNMOAg1AQlIt6gPz6lFB9OM17O+Gv2AoJ5c8dxEOnoG08gJz0+Tkbv1Mh3uXCaawKw
         PV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769090098; x=1769694898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fnv+Qq8ruMpyyncSYu+WMygfb3R6Kxmj82u6o4NFWt8=;
        b=fGbePZvBnuEKlDVwzo/EX2BkU4AWxVZ5kLDJtZyPsjh1Gkgk3Nyp5SW6jO+dOxLNfp
         3lPn4CYucSJC9Y+4zDWVR2Qbo7dMDW8JqxKstLYrEmYSfxVgm/0UJev6rE6C3bkJawAd
         YqWa1XyC1m932aA5IYy/z8pYkJsPNzvngQ9h5Yy/bOwN1rkqDqTY6QO/z4l2SVh0KLd1
         MUiqFYxggb98ZkfkLFInmekndiLTX59pnsvVuQzRZuAj2K732qLKmVZWxVN3Y33Ml28f
         ojZN9kmqtnYyAOce5RFZERHxpiU3PC3VlYs7fd5lBk5W7EzAt0Y8lhIOHzmNMrHhqOUX
         WlGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnz8tEBGpTtnJoq30eOpipHizX85ui5nKz1VqL3SfrHBMLE6N4m4WNgUlfRrL0GJEcbxmmCsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NDll52fUhn8A3zpSRg3U1841yYAYQmBt1NDlZ0eSC5+9PtTw
	R37xKNCl38Aos/NOi2eDRapkWFOgYrNqeXKv31toBkrZ8NXnuMGDOQ/en/DJf0z0i/G7SHNDtKF
	KKoTyNfPMV2HJ/rvU6EiIYeIeDJRtgPkXdVkSMpEWOZc0htCg5383364Psv8=
X-Gm-Gg: AZuq6aJDnacy1zCvLZe/9iVB+cdJrd3qbm3LxnGrMjm+LvRRoP3H8Qt4nvleOYmRD1A
	VofgcaJvqPMXctVcoVZwwyArYsD519z9JQ6ISuWxaCHc25SxTn6V8QJPMMWS2h+xtNsI7MstbWv
	KrNUKmfKdcFURvnrhQSMxiIFh390ZhsTB3QOL6KramSp2gh9aCmRoVbltujwEl4ZlbFEbJHb2sC
	zJ+gRNFXWJogGEFV/o0dSFMjkg9N3k4vYzfoIkzD0kevBojnQe4aDiIoHC9bCUfbrfci0EJ
X-Received: by 2002:a05:620a:7013:b0:8b2:db27:425b with SMTP id
 af79cd13be357-8c6ccf226b9mr1069012985a.74.1769090097462; Thu, 22 Jan 2026
 05:54:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122131306.2119853-1-edumazet@google.com>
In-Reply-To: <20260122131306.2119853-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jan 2026 14:54:46 +0100
X-Gm-Features: AZwV_Qib9rfo18RS1wm0njXi222bvYG4DYfndteNpawtoUunkValJvPFNFQ1wsA
Message-ID: <CANn89i+wyDiyq13nn4_NkckA0A9z7ybeKRXaC4A-VS0yFc9GQw@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com, 
	Eulgyu Kim <eulgyukim@snu.ac.kr>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252374-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,strlen.de,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,snu.ac.kr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_RCPT(0.00)[netdev,5498a510ff9de39d37da];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,appspotmail.com:email,free_list.next:url]
X-Rspamd-Queue-Id: 841C26806D
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 2:13=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> syzbot and Eulgyu Kim reported crashes in mptcp_pm_nl_get_local_id()
> and/or mptcp_pm_nl_is_backup()
>
> Root cause is list_splice_init() in mptcp_pm_nl_flush_addrs_doit()
> which is not RCU ready.
>
> list_splice_init_rcu() can not be called here while holding pernet->lock
> spinlock.
>
> Many thanks to Eulgyu Kim for providing a repro and testing our patches.
>
> Fixes: 141694df6573 ("mptcp: remove address when netlink flushes addrs")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6970a46d.a00a0220.3ad28e.5cf0.GAE@goo=
gle.com/T/
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Cc: Geliang Tang <geliang@kernel.org>
> ---
>  net/mptcp/pm_kernel.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 57570a44e4185370f531047fe97ce9f9fbd1480b..1a97d0eafa2b0c9e4275b90d4=
a576f837dc286a9 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1294,16 +1294,24 @@ static void __reset_counters(struct pm_nl_pernet =
*pernet)
>  int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *=
info)
>  {
>         struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> -       LIST_HEAD(free_list);
> +       struct list_head free_list;
>
>         spin_lock_bh(&pernet->lock);
> -       list_splice_init(&pernet->endp_list, &free_list);
> +
> +       free_list =3D pernet->endp_list;
> +       INIT_LIST_HEAD_RCU(&pernet->endp_list);
> +
>         __reset_counters(pernet);
>         pernet->next_id =3D 1;
>         bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>         spin_unlock_bh(&pernet->lock);
> -       mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
>         synchronize_rcu();


> +
> +       /* Adjust the pointers to free_list instead of pernet->endp_list =
*/
> +       free_list.prev->next =3D &free_list;
> +       free_list.next->prev =3D &free_list;


We have to test if the list was empty, and avoid the synchronize_rcu
in this case.

I will squash in V2, unless someone complains.

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a97d0eafa2b0c9e4275b90d4a576f837dc286a9..af23be6658ded4860133bb9495c=
7738014815d28
100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1305,6 +1305,10 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff
*skb, struct genl_info *info)
        pernet->next_id =3D 1;
        bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
        spin_unlock_bh(&pernet->lock);
+
+       if (free_list.next =3D=3D &pernet->endp_list)
+               return 0;
+
        synchronize_rcu();

        /* Adjust the pointers to free_list instead of pernet->endp_list */

