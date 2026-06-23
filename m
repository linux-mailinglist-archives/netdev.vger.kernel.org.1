Return-Path: <netdev+bounces-301453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aiICNDzKOmo3HAgAu9opvQ
	(envelope-from <netdev+bounces-301453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:02:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6E6B9593
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:02:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b="k/bypVSW";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301453-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301453-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD66E3020D5B
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2EC38BF7A;
	Tue, 23 Jun 2026 18:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1B38A722
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 18:00:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237631; cv=pass; b=t1caeJsgVQpTlAzoxgAx6PXwRkvxMN4KKa+F++zKJL2YDz+LYiv9TSdZwkAgTuCpWafsTrhJK1YJMMzOiQTwF8wcSKEtVsm7L+BMhyYPSABv7XfPTw3YTcpX0qVBJGGtlI/DZxg9PfhxDsRoDtMN1uq3gJLLjKlOVWtL56agYhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237631; c=relaxed/simple;
	bh=WZY3NMXCKmiFUL6bEHqIaryLyBJ3QkMRef8kQJc3azI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFmRhnqfFVKRo3QVObw38pSGMcVxeJpGzl9c5ZCk696NtXKFV2dc200hB6v5UPCOlf+wE6JXS90MOJ8afkuX/6B0f10aUBudR6OD/mQeutDQfvrq33mOcAFEfdMhlB4sXFIOpjZwOlOmrvSXy1oLM1nU4SHQdK3/E3WU4Cwn+b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=k/bypVSW; arc=pass smtp.client-ip=209.85.215.170
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c86214eead7so68442a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 11:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782237629; cv=none;
        d=google.com; s=arc-20260327;
        b=VqcU2RVyF1VLa5xPL50sr+VX1DBcPvdenCFPu6//J7Dk5DkWKZL28PtmVb6XCoDeR7
         xNS2i1uyf6x+tYUrp8TGv1nHUFqT5CDSv3kptfb9g4H4DOMTOfgeEslGgpam1hxg3sfX
         qIDA23AkPBmUo+f14j8nAM7Vn5fCSPZvzmD5MuBX1kNn4rZwYhHcoig5TNYC16Hw1h87
         jpOt157VhTIEzu7TeejEvPJq3Fuas4i/c222m0NMFz/deqhks4F7Xw0lvnF5IUA7e0D9
         PR7tXVTiz/cpXkiqWXAIGQ9L0IWMf0E1HMPR2Tt26RgsfqtrX6ScmHOiL6oO8VgOx+Rv
         u7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ryxlULCevungJI7+Ffd92DLwq7x8/EUQZpajQof+bpw=;
        fh=DIk+uWjbVrBc7q/YfAUkyAnkXMvYL6w/vLBUxsLNVfw=;
        b=jvahpSGjXn6JReA+kreG0ZlVdT5mqr09UfwzY9cIZzG8iEIaaDeDMMrqVL2PWH5WIL
         OEcmzUyuOl3FdbKsoazb31rcgFzZJoLIU2s2jNcMb0VAY5GMZ0PkttCTn7K3O1otj/wi
         9JVtco6a0w3PI6S3Y7xaW4Sn7SXurIPnYYAr1eWaPwj5pUkW+QQ76wDzARmpuks1ssrA
         8qICPH/pf3xeeAS3WkAoCx2BU4zN8axs6nvX/boCcFU4kjeqUsWpYw5WgUVt0jjpE0Wa
         IKBM95lyGb1G5ASwjMQ3h1vwmMJbRGrlJPUn2759yOoA3DCr0JzIG8/MftInpBAihNYH
         HlzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782237629; x=1782842429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryxlULCevungJI7+Ffd92DLwq7x8/EUQZpajQof+bpw=;
        b=k/bypVSWPyJREY83nITSpfFFScjog4xfLYOAtvYHwbVf4Zudxr33TWb7gfyH92hyV1
         IAwdaUJkppB+dWBn6FU4fGHPWkrrqwfZFqgfBSr3SUGx25le9V2ZRxBGfnQwHOTW+Rh8
         kwOYFjU7OOn2WEMK8YbwH81elKP/qBfS2SaXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237629; x=1782842429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ryxlULCevungJI7+Ffd92DLwq7x8/EUQZpajQof+bpw=;
        b=WcEz3gd/dYD3Mo7pS9u+Y7GQcBaCr/x3vgY6oRa+NGukcQGFtGapDH/RwJMcvXXSiv
         /rLMhRT8kMQOBUTIIo1GCTucGTnfYmLWJSTWPNsoGNNrC6sCXJzmXJqIouIKUHoq6ztI
         5qKmZIl//rAFYgwUHTGTa7J582jEFFD/51AnZEhVplQizJCZ9pqEiv1E+lQOorvsmD9W
         S3+EpC947+vx+pDErnGlJz0S+UItBV8LlFa9zd99R4mc27xYMYbovKZI3KO3jk+1Wb5s
         m/II43YjiJMAimvMczR9kVN2fkFMyF99XDsWgmBip2uYTMv5/c/D4kdb7OeMrWqJQKXt
         YZUA==
X-Gm-Message-State: AOJu0YzjkPePzzGucfWxcATC+2LFzA8uXUuy7xXWWz0r7xiVul+9dmWj
	ON5qGB2T4SOu2S/+H1wYuIr4ZJ3wWA7OrQPYxdUtsn43/3WgKG7QectDqRDWnTkbixMWNIlFm1h
	eGW0If9a3eZqqFjdhlx42EcQQ98jRUs9IZYZuMDDYOF94Wp83H3M=
X-Gm-Gg: AfdE7clcta1E/rBYqoD/UTLscOF/B/UBxTTgirgUp63ykQP2LXJzXk/McVHQZLVgyML
	Xpfnp5DeJa3Sil2qwV6jLUkjG831eyy9htKCP5DVZRw2uqXJyd/Sz0MUMThv0GUqQ5OH1xDlM9W
	j4+PvUl7Zhm4vNry531nEJArC9Yz8HCiTuiw3LY3L9dvXqIIviSbNRX7v8coZK4WOTG4l+4UgW/
	8El00rfHXCz414WUECNcpg3EArWdAObGqFxZ1Jocu8P5gISN/9uPO0/N7evHTjnhKTjV8mBWGkR
	w/yx
X-Received: by 2002:a05:6a00:300e:b0:838:5145:c1c5 with SMTP id
 d2e1a72fcca58-84591c76125mr4780394b3a.21.1782237629355; Tue, 23 Jun 2026
 11:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620130749.226642-1-jhs@mojatatu.com>
In-Reply-To: <20260620130749.226642-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 23 Jun 2026 14:00:17 -0400
X-Gm-Features: AVVi8CezjsSNxPNvGxNfS0psUshap-NDi0qYBt6lePZ7nsFUJ5LlIkjVJxxvsxg
Message-ID: <CAM0EoMmtMDXjVgCk735R+-VaAo6L6dcZaHOOKm2VgFATa6Um-g@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	security@kernel.org, Zero Day Initiative <zdi-disclosures@trendmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:security@kernel.org,m:zdi-disclosures@trendmicro.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301453-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBF6E6B9593

On Sat, Jun 20, 2026 at 9:07=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> tcf_classify() can return TC_ACT_CONSUMED while the skb is held by the
> defragmentation engine (e.g. act_ct on out-of-order fragments). When
> that happens the skb is no longer owned by the caller and must not be
> touched again.
>
> tcf_qevent_handle() did not handle TC_ACT_CONSUMED: it fell through the
> switch and returned the skb to the caller as if classification had
> passed. The only qdisc that wires up qevents today is RED, via three call=
 sites
> (qe_mark on RED_PROB_MARK/HARD_MARK, qe_early_drop on congestion_drop)
> red_enqueue() was continuing to operate on an skb it no longer owns  in t=
his
> case -- enqueueing it, dropping it, or updating statistics. Resulting in =
a UAF.
>
>   tc qdisc add dev eth0 root handle 1: red ... qevent early_drop block 10
>   tc filter add block 10 ... action ct
>
>   (with ct defrag enabled and traffic that produces out-of-order
>   fragments, e.g. a fragmented UDP stream)
>
> Handle TC_ACT_CONSUMED in tcf_qevent_handle() the same way the ingress
> and egress fast paths do: treat it as stolen and return NULL without
> touching the skb. Unlike the TC_ACT_STOLEN case, the skb must not be
> dropped/freed here, as it is no longer owned by us.
>

I just looked at sashiko claims - one of them (on ebpf) is legit but
the one on qdiscs is some BS it is making up. I will address the ebpf
one this week.

cheers,
jamal

> Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo fr=
ags")
> Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/cls_api.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 20f7f9ee0b353..3e67600a4a1a1 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -4049,6 +4049,9 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent=
 *qe, struct Qdisc *sch, stru
>                 skb_do_redirect(skb);
>                 *ret =3D __NET_XMIT_STOLEN;
>                 return NULL;
> +       case TC_ACT_CONSUMED:
> +               *ret =3D __NET_XMIT_STOLEN;
> +               return NULL;
>         }
>
>         return skb;
> --
> 2.34.1
>

