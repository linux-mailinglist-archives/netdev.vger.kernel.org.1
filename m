Return-Path: <netdev+bounces-270681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AINEMyWLwWlxTwQAu9opvQ
	(envelope-from <netdev+bounces-270681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:49:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FB62FB8FA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DC1C30151F9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15C93264E1;
	Mon, 23 Mar 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhduWarS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB933264E6
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291736; cv=pass; b=BtKR8Tyb+0LNbH527YIYScQdfW9aoPnazxIbm5SsnxAMPRudZ2XJGGfSYJOoUD/08JHyB2+eVy4NIpiTj1RA7bolYLGSfrhuoIh++mo9H77W88ZhAHUtvgTFVlA0f0C0gCimD442gKJk6RcMSLYXdTxZ4JAnc6Mx+3aaAY2g9e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291736; c=relaxed/simple;
	bh=LnUo8xPXY2a9qcQiBFF7Ulv8Qa7ifb4jb0qVzy51Qr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUB3uRjAGHi8/gwwr5OSXB+g5JH9BemsiRhRlwPrsR4jaMCVGy7jgocL2UiYjblC+tHi3U5nKIEwm//fPDO812tnh6Vbn1fdteOc1Ok2Q9cptnbu/fKT3R/UZgl69av8UuooEEO16wd40BMBQVF+a3nPXPCxCWA7mv0OZpegVa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhduWarS; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89c52db6231so52496196d6.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774291733; cv=none;
        d=google.com; s=arc-20240605;
        b=GCIih27nv4MIULDicytNZm07QhyQJ/gD2+Pm5jkIrdHPnV96Cr8JqwgslXXTnFbWik
         6YLANzzdqBXudanUR0+Cu/05/EMaDouXr6b0JLEGGYaaRH6AsgV8VZTXKURaj2O/jahz
         9+XjV1etkU0t/qVpEBH5ykIapnzXxNseMpv5y5yj22xxxtEVFpUjQl44MqwO4FcgJtcH
         RWABv50QSsq6SYCzBvA1WFA0HTZ5Arq1Yqqa+8y5b3MVRtOCQwVVbjrXoPiiMxCbf6io
         Sop2kXNxi7j/TDwQmG4HppjuLRTRrzBPzqD+WPCFJcFrIQnMmovgwBS8y8EkQNy15aDS
         LZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NtBB4zdtntdIPjHDLb6v84U9LWAONzNKpl1otWqh9ME=;
        fh=c+LbnZwTynhmdqtdo84lTl0yYwJ5ByJzfDFbE0DcRJg=;
        b=MMkjvA4GMa/bGWAbl2VEcnnS9w71fVezYlTGZEDNvSxkNmHM6ZO/KXC4nhoajadTJP
         Pb9mV/aXKJUzXM7bqT6oI3HKWN7gNS0+Y2Sj3S4PO2/KR25/F1YTMeT/coit5B6TSQTM
         RnYIdzrcrzHTaf1QBuZOPMUABTI3Kjps4ARHFxjexHpbgrSnZERJrBu81xqIT8lQu+XG
         X7iSXrvpiuiGE+SXiVbeLI7+XLMJ8p828W1KUhw2QCQIk5rTk49pJBRPo64Ek9KiVbkG
         lZ6tqHYWbpy9B2aZLl2TkdrkSPp1hvkdBnJnK0fIygG0EzXZPR3AmxSc8OcMXXkZ4pbq
         6evA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774291733; x=1774896533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtBB4zdtntdIPjHDLb6v84U9LWAONzNKpl1otWqh9ME=;
        b=EhduWarSt9RMdgQYvJGhSFX8kuB4H+zNFI87NnI1QbYkKEmTVH4Ujoh2Ozx407OMwg
         WoiDFGycgzCIaE/h/LeFBJ5XL2m8yA0X+rO68w2TUX7ZEXSmiTj81Tg0HrrN3fnF7xjR
         YKu1+GxUy/qW/6Vg2FbUKzYuGLAetkzowsL7PCDFoL6uLEFkGzNouN3gdfCaqMZk0vkA
         Xt31ryIBxM8tjq4gxG/GbsFY1RL4ftCFZc+nmknONgWSv2KITkHl3GvP+o0a7yY1bKKi
         5KEMmB0JUDBsUI3u79JZWhqvqKmzwbUG9JSCr8UbBPBJThmvaW1slzlk9WtyEhLtDPDO
         P54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291733; x=1774896533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtBB4zdtntdIPjHDLb6v84U9LWAONzNKpl1otWqh9ME=;
        b=ZbFRBdR8/8LpdOFqZ/A2sUejt4SGyj8/aUkuW4IsXhGOughH5v6Out/r4TjZUYdccQ
         3fTZ0EQx9IxeOVjdaPb207lW96wIT6kUZuUn3t0Hyl/xFx62xmS1415hHhkcYeyXChfJ
         1/lr8QNwQNYK3KITMdgeqr+YvQCL2mFJ4Jl3e7h1KgRMURsk5gpGg0kpwpxABQspXdxi
         c3L3D8xtEnmnLIxrDw1I0MAVGu0JK0jzK4TT6PIo9mkZHVbskNJyB3leKmGv7GDnOENn
         nHaCsYCR/KLmfGa0jDzLtT3/W4Z7ODb97uTGK4QjH/E0A1vcDoV0gCGPEJrdQxYponc/
         6liw==
X-Gm-Message-State: AOJu0YyV1xQ7YjTVdsr/ud894GOMUNipjwYd0mr6igNxecCnG9Nxneec
	AGMZIOlcsvIFjm3EDR8DFV/+zdoWFvNqO0EBL/LQ5wWVOjL47VdP8sbVwO7FmLF4MiyxT8g38Xo
	t/g3poqB6C4Q2vxcBChEisHzcnFuxijdHnNmPAdlXzf/6ZLRBJsxcLyvp3ol9Vg==
X-Gm-Gg: ATEYQzwWyFp7zs3gpn7a4VsEmXgOxmkHRDOqHZHt4CJ9Yz68yjynKLqsSyMhCE6fFGK
	i13F/kGQ94+HLhqUREcHuEstSKe882tAP2cA8LdfkDry7Rwkdo8Moe8oyfma1kDD0X/eZ6f2YE8
	dMD+t1m7lpyLqgtS/He/nY07aTSeacgowtTJ8BcbHzSd747j4XPdYcvDlwrnj5RGmeutQbwKx4I
	fUJdtKDrydXBj2l5ceSkfPzb+E0aZLrOPa72vWGXsUN/WyowIbJpCA2X4xfMWoBlaftwmxqV9P1
	JCiebTRz6bVUwUwY+cQpfaxE7nLNfI8gDb9znVChSHkwH/s7
X-Received: by 2002:ad4:5ccc:0:b0:89c:8cc8:7c6a with SMTP id
 6a1803df08f44-89c8cc8836bmr196029996d6.5.1774291732866; Mon, 23 Mar 2026
 11:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323174920.253526-1-hawk@kernel.org>
In-Reply-To: <20260323174920.253526-1-hawk@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Mar 2026 13:48:41 -0500
X-Gm-Features: AaiRm52K8HAwa0fhrepNwkLSzV4jL0-ITMbIDt6cTPTT0KNwkWa5jGOKFgQHHaQ
Message-ID: <CANn89iJKiAB7N-OOHP3tJpV2Ku0mLCx55aQmXshXyGYx73uRQg@mail.gmail.com>
Subject: Re: [PATCH] net_sched: codel: fix stale state for empty flows in fq_codel
To: hawk@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
	Chris Arges <carges@cloudflare.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270681-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,cloudflare.com:email]
X-Rspamd-Queue-Id: 99FB62FB8FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 10:49=E2=80=AFAM <hawk@kernel.org> wrote:
>
> From: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>
>
> When codel_dequeue() finds an empty queue, it resets vars->dropping
> but does not reset vars->first_above_time.  The reference CoDel
> algorithm (Nichols & Jacobson, ACM Queue 2012) resets both:
>
>   dodeque_result codel_queue_t::dodeque(time_t now) {
>       ...
>       if (r.p =3D=3D NULL) {
>           first_above_time =3D 0;   // <-- Linux omits this
>       }
>       ...
>   }
>
> Note that codel_should_drop() does reset first_above_time when called
> with a NULL skb, but codel_dequeue() returns early before ever calling
> codel_should_drop() in the empty-queue case.  The post-drop code paths
> do reach codel_should_drop(NULL) and correctly reset the timer, so a
> dropped packet breaks the cycle -- but the next delivered packet
> re-arms first_above_time and the cycle repeats.
>
> For sparse flows such as ICMP ping (one packet every 200ms-1s), the
> first packet arms first_above_time, the flow goes empty, and the
> second packet arrives after the interval has elapsed and gets dropped.
> The pattern repeats, producing sustained loss on flows that are not
> actually congested.
>
> Test: veth pair, fq_codel, BQL disabled, 30000 iptables rules in the
> consumer namespace (NAPI-64 cycle ~14ms, well above fq_codel's 5ms
> target), ping at 5 pps under UDP flood:
>
>   Before fix:  26% ping packet loss
>   After fix:    0% ping packet loss
>
> Fix by resetting first_above_time to zero in the empty-queue path
> of codel_dequeue(), matching the reference algorithm.
>
> Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
> Fixes: d068ca2ae2e6 ("codel: split into multiple files")
> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>
> Reported-by: Chris Arges <carges@cloudflare.com>
> Tested-by: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Link: https://lore.kernel.org/all/20260318134826.1281205-7-hawk@kernel.or=
g/
> ---
>  include/net/codel_impl.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/net/codel_impl.h b/include/net/codel_impl.h
> index 78a27ac73070..b2c359c6dd1b 100644
> --- a/include/net/codel_impl.h
> +++ b/include/net/codel_impl.h
> @@ -158,6 +158,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
>         bool drop;
>
>         if (!skb) {
> +               vars->first_above_time =3D 0;
>                 vars->dropping =3D false;
>                 return skb;
>         }

Nice catch, thanks.

I guess I wanted to avoid the ktime_get() cost as much as I could....

Reviewed-by: Eric Dumazet <edumazet@google.com>

