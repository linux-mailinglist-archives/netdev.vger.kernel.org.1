Return-Path: <netdev+bounces-258799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG0fItAwkmk8rwEAu9opvQ
	(envelope-from <netdev+bounces-258799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:47:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E204013FB2D
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 715E03035A8E
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF306307AD6;
	Sun, 15 Feb 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ibfGqydY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E838283FC8
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188355; cv=pass; b=sSyAPYwlcjppzOI8V7Lw9z+MI82abShZJaTUELxeMi95vqCImphI5InK/0UyvbOqYHVNybG6ET8kyMLwa5wUU2V9ebEa2AGgDPFHMoAPOeackvuGAv7wALDzmdnPBueU7JSbXh9qOV9wWUP+9Tya++CyXSItvRxHASXFKCUdGOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188355; c=relaxed/simple;
	bh=Ds1v+eswAQASNf0hpI4AxWNGtflZxsZg+jHzXoyFoeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+6UEwdCesgWpqDKGK2Fl4yr4I0ISkKFAS00KXbBGweYxxjC1oXiXFry+WDwIhKW5hG+qUP/XI8vCKhqEc1nbPg6cxauYwVT63CxvRVVIhXinRRVrLwHkWwRX2eq128TmIhh+ym5KYUIdQK2+O/o6hojhszh94fmsAED69S9mgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ibfGqydY; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64aefa98fe6so2368954d50.1
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 12:45:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771188353; cv=none;
        d=google.com; s=arc-20240605;
        b=Z4E1yDWgwljUU+TMixMHpRszW8nIylzg+zJUfY2vLhOJk0o5jaN12hfrHayMdeWWsM
         FchaOYHVrbrQXjHEfycyaMiOBYsL3wWNVmX+7AfgYl5enwfEqFOFpGAtD3oddmuZvxjB
         9hllb9+p8lGY08IIeKaE0H26PM8ai7Kt2LKCyD9nO4IPwR7L0bpXGpzdlw57MPSrryJS
         Ry9bAb2D1L79NGRSnyUIJfQx7rETOkMPIVDM6QSiljTj4FTsHTZDWLVO24p1oviYL8OK
         BdgphZ4MIXC9a6kvOlHH2hlDvXX87YTkUFLV2E6wnF72bh7ax1ML3Ukt23Km1Bh85Pcz
         TYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oo6CzlM7VCP6Q08h+JHjGQ7qEb9AnSPDb+La4GMe/pg=;
        fh=iGj4WkGPkKJz2y19eL4DJDm3UoUXGf4XAfhi+PyXKGk=;
        b=iH5UIrLv790YqPIKC4iBQspW83FqaA/zeH5sluzckzRyUCJA0N4XV3WsCrQNjMkZ9O
         +/Ikl2Dt8kSVnCPKzUtnEEWuq8WvFMHkA9y5SVhmtNjEgh0ImwQs3+Hx3BlIkIE6e6VC
         PXCutYeYRMbp0Pnv7kLurBQPAOUw1bbyk/UUR98qzEAgvF7I9kQtekDi+Q4m14zECDF8
         HMbLwthj+hVnTpwiWZf/odLiRM8M1Wpl3xXF5Ny1Hhc/tbzwEFETzwpxo4/qO0idxs91
         V1ivyZCp/XCEHCzLBAui/s4Y5Sw83nKJQrk+4e9x5Wx3nM/ZY2kAQFW17XW1z9BVfIBj
         23aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771188353; x=1771793153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo6CzlM7VCP6Q08h+JHjGQ7qEb9AnSPDb+La4GMe/pg=;
        b=ibfGqydYU4sLq7R4H3NPDplUcl77UxdcOQQYg4doFoKMXtetTwP5xOev4u9a5YT3z7
         iqXrziQEmYbs3fd/wunDwAyDLmW0TLD/47pnOkMArti683CM4T4A7efDkOH/b/eLSSFF
         ScLVN4tTFjE8AGU6DyVZcaA0hFREKZ+kjhDh0Deex5fyOtAr6pAvPlIDTy+zrXabgGrB
         sR6By92k0lxLbk6CeeuAeiH5UpYglY++sk2H12OHgJlqjxFdQhJV5QQTHgJoIyMi5ZrW
         iUwRnlJoMl/oKPOtcOTMLhv24/rohtj1D3PKdn/scvhSb+erqls7ql3tS6mSrLLqGK0j
         njkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771188353; x=1771793153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oo6CzlM7VCP6Q08h+JHjGQ7qEb9AnSPDb+La4GMe/pg=;
        b=TMb3H7hZPUvOI0LmroacMxQz6D+RPW5r8TmdjDKEWHDuO1qju9Krvzcrd6TZRLogqj
         Lo39PFCOLmqqreK6MQkqWxJi3GE/4UipebaosYWVfE22YIDd90K1pYeogBlxQqdlxLJ+
         TrAD8oTotvABlP/0Xfufxquq2c/X4CVCDB2+rjx9AT92YgBTJ8nCEj8arjO9pKYkJH4s
         t53teZPk+6srV6MpAobXnMf5QaB3zWkkkfcYVejoa5LoaGy0mc1VqjXHor950f7l/LnY
         4gmqKxhcQHFRPviPNoMFmNtbfJI+zOk7hM5+rP6k59c+0xJF6NIBeZCkSf3C3FDQxBSi
         PQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIgl0vnr4NZxp9D1pzwOBYMhL2Rk2BY7kJuvk59cw1AYY4A7uQme0mhMT6gGOGZZqfzEX9E2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWAw9XXZhScXLvp9Rv0Rz5AF0G7Pz5M/AaQbbD2bt6oVP8pBbI
	gJ64WW39AUsRkwyRdnwQlPUTYOT4IyPUu88ZWPOGc7S3zgDTBcNRXsW52Rjv8LNoXS13Q9gaV7r
	nmWwigG4vF6GHJ6EihTxQ6fghk1OgwXuWM9Fzae9s
X-Gm-Gg: AZuq6aJx0RjxXT2DwjQ/n/xqIzyNSsedTUesx0geBECjQwJVCg8htE6h+Xi8s7qG+01
	X6S7LgtZ3sThNWDI5UzV8aVAnSMBHN5TnYvfKsG+KKqF8uK9XY7vDLT/oWkUryBo6sitCCmNc9j
	3TgteewBt5IlFKyHYcZYK04i+HumxXDREsdEHQ21G68vxtm6zBsRhBLQ2e4ClXBWc8Vl+dIuqKv
	HLU5GPRcHJUxtzsGQY4ktfO09izFBuCfQHBMxpKzD/52CMHURUlTuJNTa4w+BKx0gBbSTMD8rx4
	zqSDnLd2L+svAqbPaha62A==
X-Received: by 2002:a05:690c:e3e6:b0:794:ecaf:c501 with SMTP id
 00721157ae682-797a0cc95d1mr132565667b3.46.1771188353173; Sun, 15 Feb 2026
 12:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213113849.136695-1-p@1g4.org> <20260213113849.136695-2-p@1g4.org>
In-Reply-To: <20260213113849.136695-2-p@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Sun, 15 Feb 2026 17:45:42 -0300
X-Gm-Features: AaiRm50bUFQOD3H73oRgDuJ6_T-ZnN2l_KlSeCgNXBjOKlK31-17mnd8s7B7Xek
Message-ID: <CA+NMeC805yf4CECdjJh4EmP0RK1AgxAN25V7n+qvOqNMrhVyNA@mail.gmail.com>
Subject: Re: [PATCH net v6 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-258799-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E204013FB2D
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 8:39=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> The gate action can be replaced while the hrtimer callback or dump path i=
s
> walking the schedule list.
>
> Convert the parameters to an RCU-protected snapshot and swap updates unde=
r
> tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omit=
s
> the entry list, preserve the existing schedule so the effective state is
> unchanged.
> [...]
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c1f75f2727576..60c80e609ec3d 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> [...]
> @@ -56,11 +59,10 @@ static void gate_start_timer(struct tcf_gate *gact, k=
time_t start)
>  {
>         ktime_t expires;
>
> -       expires =3D hrtimer_get_expires(&gact->hitimer);
> -       if (expires =3D=3D 0)
> -               expires =3D KTIME_MAX;
> -
> -       start =3D min_t(ktime_t, start, expires);
> +       if (hrtimer_active(&gact->hitimer)) {
> +               expires =3D hrtimer_get_expires(&gact->hitimer);
> +               start =3D min_t(ktime_t, start, expires);
> +       }

Is this change really necessary?

> [...]
>  static int parse_gate_list(struct nlattr *list_attr,
>                            struct tcf_gate_params *sched,
>                            struct netlink_ext_ack *extack)
> @@ -261,7 +294,6 @@ static int parse_gate_list(struct nlattr *list_attr,
>         }
>
>         sched->num_entries =3D i;
> -
>         return i;

Removing this line also seems unnecessary.

> [...]
> +static void gate_setup_timer(struct tcf_gate *gact, s32 clockid,
> +                            enum tk_offsets tko)
> +{
> +       WRITE_ONCE(gact->tk_offset, tko);

Why do you need this WRITE_ONCE?

>  static int tcf_gate_init(struct net *net, struct nlattr *nla,
> [...]
> @@ -366,6 +407,60 @@ static int tcf_gate_init(struct net *net, struct nla=
ttr *nla,
> [...]
> +       if (ret !=3D ACT_P_CREATED) {
> [...]
> +               if (use_old_entries) {
> +                       err =3D tcf_gate_copy_entries(p, cur_p, extack);
> +                       if (!err && !tb[TCA_GATE_CYCLE_TIME])

This check for TCA_GATE_CYCLE_TIME seems unnecessary.
If I understand your code correctly, cycletime will be overwritten
further down if TCA_GATE_CYCLE_TIME was specified.

> +                               cycletime =3D cur_p->tcfg_cycletime;
> [...]
> @@ -434,33 +532,47 @@ static int tcf_gate_init(struct net *net, struct nl=
attr *nla,
> [...]
> -chain_put:
> +unlock:
>         spin_unlock_bh(&gact->tcf_lock);
>
> +err_free:
> +       release_entry_list(&p->entries);
> +       kfree(p);
> +release_idr:
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> -release_idr:
> [...]

This looks weird.
You will go to the release_idr label when tcf_action_check_ctrlact fails,
so the "if (goto_ch)" part of the code will be reached in that code path.
I believe it would be better to keep the "chain_put" label and keep
"release_idr" below it (as it was before your change).
Something like:

chain_put:
        if (goto_ch)
                tcf_chain_put_by_act(goto_ch);
release_idr:
        ...

cheers,
Victor

