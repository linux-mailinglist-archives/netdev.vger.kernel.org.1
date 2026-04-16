Return-Path: <netdev+bounces-279078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OfeNiH/4GkSoQAAu9opvQ
	(envelope-from <netdev+bounces-279078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:24:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D29D3410A4F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACCD130060AE
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD3C379EF6;
	Thu, 16 Apr 2026 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="FRXbDfQR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF77264614
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353044; cv=pass; b=EB4TiZkzoksYETK/5tBpml+qhzI3sgNh/RTOuSOVp1SAHfpVcHUsIJYADT31ic+KdcQV77N9Fggtyw3Q2Rr76Af0DevBUWn8MtIw70WcnayH+kF2nL562i1bgzqtx5KMvfmHqeGQ5s5sJzTebHWKCW01tPmR6D3snRwfPZ503AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353044; c=relaxed/simple;
	bh=U52NaOQKzIQpvFnuwyftfzqzX7X55EDlwl+M7r6fR9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBdtvYd8pRW2POC7MzeUu2wBTKmQiuk/OvAbRxNrdMi437leaMzpyb0i3NG1aFdbji0e9kJZOwvdBotJZtLBKZU24NRpnTIRXhoPwJWpNiJnni+m7jHKgpBskeuPY0peRkivS6u7AHrIu/OHldBy0ySDOOYAVALAw9Oa0pio1fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=FRXbDfQR; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f206f2b54so2340383b3a.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776353042; cv=none;
        d=google.com; s=arc-20240605;
        b=dqfup4QPUoeZw8bomSQlttVOI9/RT9d7db0XdHla1ibnZLNXsifxVCtH3/Wh+WCbBm
         uQbQU+AGQXa91gqmFow7gjjXTSgJbfovOWIL2aqCxoCECMy511CjlbXOxAZEjtyDmCgW
         tv2sbg+p+k/mM5EpzO9ZTbIGDeQH59TFJ3EtsQIUA2aGDW/hH7/HjPscDfhcW8gwmwi8
         gCJ4XtpBfvBXAEfxGXLMNv1t8mN39bjvdf3gJEWt2N1CstWPOfasrbLbNbatAKYk8VOG
         +ZB5SzqHByPvZtt2XowjV/VTTR6+vhd4OCVrVTO8RWcvXNzY1cIvJml6KrxY8E/6zRZt
         y+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QlmMSGcub4gRsEzR0kt1jLplgPMUnhz1kWFWpi1RFSY=;
        fh=XN4St5FOnN+qK+EsHAwCJvkqcZ8mi3HjwNzoCXsbOy0=;
        b=EkD5t4SKVmmG7laV1Z4ROSBELfoP8InigME2/SzUMTJa9UMhvvZQKweRvOfjPlBGFg
         a1AxkRCHwjS6oik338ZBEjEXQlJjuGcFkuNKaBaMHqJ5BU9CtQrkUmAF48N4KtktjoKJ
         lRl4no7Umj8vHjoGW32wD9G68Py/vOewaK368Oqm/9op97Jnmn7vSKyDwQ7T5KbXxYQ7
         wB2YWIR6v7e7bWgRg0xcHQk9kd5qRIT34NozI0QZoleRuwaEnw8YYo6GaGxxeJ8sPU2v
         Zd88NRMm+QPE137DteSEGqo47qS+vhBOcF66rooK1/SKd9K3noEog14rXEK9LZuccs9i
         zijA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1776353042; x=1776957842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlmMSGcub4gRsEzR0kt1jLplgPMUnhz1kWFWpi1RFSY=;
        b=FRXbDfQR4/wEb9GWbj/EPWHqSU0Jq7Mr005bPjf7wUGDDsFG/cqPkoriQR9ADXrSzq
         gD/Y30SCtYqdxymiv0vX0FSvZZ1U/4/smpsEAvXjQWeLeDInPYW5/XanPp6FHhi9B37L
         pxwgfZhLQsLc1hsm7KdV9gqqrHVy5As3MP1+zBtuwp+G0DcomYexE173sQZ95K4fbGWs
         T7EOcGqtWgUMldjL1sdE7h7JGHEWqu21DEhbh4DipEEyx/6ZbFj44To4h/d8Up5w9j46
         /taRI2lTNZ11JiC4F5O0DB7sqo34+XvWbqrF33FAlhyxsbewN6TGlwwauaVzEGLJYDHn
         w7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353042; x=1776957842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QlmMSGcub4gRsEzR0kt1jLplgPMUnhz1kWFWpi1RFSY=;
        b=s3dtt0AuLNBRs+QDhXwj8a2sCohEPQppY5iqGka/4YQ04So+9FhCoutzxeghuh5GPt
         QmwAerexlVxm9EwznIE9TffK0vozkZz/rQi3ZPV+KwUMDwh+6RZS9gLDyyjBLU4OcZ8L
         TQ4wfHyDpTiZGwVo8nQiZdsjgIyzya8GYafmMKJarkaNL+8ebgQwEorhWg8t22KoOcEl
         GHuwc8yFrxe983d8rvjmYtpcTOYoBk92jhe3/+lEnCJF2qtVUWxkmb0hWvDYPkECpS82
         HR0zUCzDqqkZajaPyn8Dljpk6mM8jwnv0uyF3kiLjnpZGnSrfOWNZkrB/2SAjjPZzIOn
         578A==
X-Forwarded-Encrypted: i=1; AFNElJ89gP4FaZlFD9R3Xj/pWJWQG0doipO7fSHWt22qI0Gb5kb7CmbwHDug01AOj4uN+J7poRtIfZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX2G3/pb10AC50FamQgRN/6cRKyuGDbwCNCCJTjImxHJrrAAn2
	00fsAD84JpZwMxxAPw4DWEGYnMhM8NrkHtemEsnUaa1HLLzIobDrXqD06aqnMefp+BBaChyAUvU
	kD10YPsfBeUREMaNumM9YoU1A/MCA4Akp54f+vx4H
X-Gm-Gg: AeBDiesitET+Gabq6P1vN937M2VQmnvwSSYzYQG0rmVxLmc2Mq6+7LQZk6OvoUxRiAC
	nLVsKoTJ1zKAk99w1+YTGFM1KvfczXFSfQXgHyqSA/b+D6XpT9ADFRo1J9yRhEB6cwhmPVMLf1a
	Gu7eDXb6pmuHG1cNM59ygiK+TpLC542aFEGPJkyMcWe9M2KpUrXwemLc+tTNsb8E38p/SAureJd
	DrseQQzERvobpD0tgf0r6p/U8VRjMoITWThIyocuVC/loGbNM9V5INY9LOXvsb+1+YFH3L+rYri
	tUBlWGfYjRf347jBQMA=
X-Received: by 2002:a05:6a00:4293:b0:82c:7eb1:4d61 with SMTP id
 d2e1a72fcca58-82f0c298d87mr26612801b3a.32.1776353041876; Thu, 16 Apr 2026
 08:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413082027.2244884-1-hxzene@gmail.com> <20260415141931.808383-1-horms@kernel.org>
In-Reply-To: <20260415141931.808383-1-horms@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 16 Apr 2026 11:23:50 -0400
X-Gm-Features: AQROBzAoYN_pQSmU0S7wggClue8YCVZcBNFzYwWYioiHKnrRUV89OYXAWAbMKVw
Message-ID: <CAM0EoMkchMeE8cyycJ7qqKOQz_Y8y7AsdVp1pUUFXa2+NRbviw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_mirred: Fix blockcast recursion bypass
 leading to stack overflow
To: Simon Horman <horms@kernel.org>
Cc: hxzene@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279078-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,vger.kernel.org,networkplumber.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D29D3410A4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 10:19=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net/sched: act_mirred: Fix blockcast recursion bypass leading to stack ov=
erflow
>
> This patch fixes a stack overflow bug where mirred blockcast actions woul=
d
> bypass the recursion limit check because the recursion counter was not
> incremented for blockcast actions.
>
> > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > index 05e0b14b57731..5928fcf3e6514 100644
> > --- a/net/sched/act_mirred.c
> > +++ b/net/sched/act_mirred.c
> > @@ -444,8 +444,12 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buf=
f *skb,
> >       tcf_action_update_bstats(&m->common, skb);
> >
> >       blockid =3D READ_ONCE(m->tcfm_blockid);
> > -     if (blockid)
> > -             return tcf_blockcast(skb, m, blockid, res, retval);
> > +     if (blockid) {
> > +             xmit->sched_mirred_nest++;
>
> Could this leave a stale pointer in sched_mirred_dev since netdev_xmit is
> persistent per-CPU (or per-task in PREEMPT_RT) memory?
>
> If a nested mirred action later iterates over sched_mirred_dev up to the =
new
> nesting depth to detect routing loops, could it match a stale pointer fro=
m
> whatever unrelated packet previously reached this nesting level?
>
> This might cause a false-positive loop detection and incorrectly drop a v=
alid
> packet. Should we set xmit->sched_mirred_dev[xmit->sched_mirred_nest] =3D=
 NULL
> before incrementing the counter?
>
> > +             retval =3D tcf_blockcast(skb, m, blockid, res, retval);
>
> This isn't a regression introduced by this patch, but it exists in the ea=
rly
> error returns of tcf_mirred_act() (e.g., when the target device is gone, =
or a
> routing loop is detected) and in tcf_blockcast() (e.g., when
> xa_empty(&block->ports) is true).
>
> In these error paths, the functions simply return retval. For mirred redi=
rect
> actions, retval is initialized to m->tcf_action, which is typically
> TC_ACT_STOLEN.
>
> When TC_ACT_STOLEN is returned, the TC framework assumes the action has t=
aken
> ownership of the packet and will not free the sk_buff. Since the code doe=
s
> not free the sk_buff before returning in these error paths, does this lea=
k
> the sk_buff?
>
> Could an unprivileged user inside a network namespace trigger this
> intentionally by creating a routing loop with mirred redirect rules, lead=
ing
> to continuous sk_buff leaks and system memory exhaustion?
>
> Should these error paths ensure the sk_buff is freed or force the return =
value
> to TC_ACT_SHOT if the action is a redirect, mirroring the existing behavi=
or in
> tcf_mirred_to_dev()?
>
> > +             xmit->sched_mirred_nest--;
> > +             return retval;
> > +     }

There's a dependency with the skb bits patch[1] with this one.
Stephen, I will take this set and consider what Sashiko is saying here
[2]. I just became aware of this - but it seems to have some merit.
I will also review this patch and sashiko's input from that
perspective. If it merits it, I will resend the set incorporating this
fix and Sashiko's suggestions.

cheers,
jamal

[1]https://lore.kernel.org/netdev/20260326181701.308275-1-stephen@networkpl=
umber.org/
[2] https://sashiko.dev/#/patchset/20260326181701.308275-1-stephen%40networ=
kplumber.org

