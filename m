Return-Path: <netdev+bounces-265741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKU/Dfsir2n6OQIAu9opvQ
	(envelope-from <netdev+bounces-265741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 20:43:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C830C24044B
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 20:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD05630484F2
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B9C40F8DD;
	Mon,  9 Mar 2026 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="NI527SOx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103E3612EF
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085002; cv=pass; b=GECgo2vt7P54fnfeRlFsZxlire25uzWYgN6KMvsIqL5sOetmmNIcPWnu6txYsBAe17BPstNDhqKAY1J19mQIoM6NdszhYdYpCM+S9DITAkcfCXNfBbm4E+f+cFoVG8vlf0pFH7TgCP60kAtmr59eNp8NXwW5IOCQgFJRz4ZXgLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085002; c=relaxed/simple;
	bh=u8DRnlKLZP0uvCkCDUTOPTd2CTmKjGEnE/vEaEAF7xE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brwSGP0y5jSjcdxuRuaZ4UT+9FQZtIK9tVBPUZXC36fvIvT6S1ukQUQ+zu+jIWDfctNTV+ZnE00xbuvC2CEhjMzqIgneNlCM5jCqpb1JzhCUQAPCUjMfQ7SRxAd/iNRcYo2N1JsfSmFpCKmc7dgcVokWNeNGvjYwNKf0oftTe+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=NI527SOx; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79902e1fb71so12163687b3.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 12:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773085000; cv=none;
        d=google.com; s=arc-20240605;
        b=U2BY6M7SRbFzkQHJ0lsWS71sWxPYb4iH6ac2K0OT5xYtaUhUzD4tJ9OEKyZhHZtDLl
         1E+ZJuSyuOCouR9HICwLkAHUaHq/cRfUJ8JN6HYhBScECEzZmxDsSolCP5a1nMK2HGZ0
         jSOk3DwxtF1wmn9AQc/wvRE02UPJW+9E8Xa+bcVJoScArvMU9yI6woOB6ntZZWosC1bY
         zvlkmtEWvvMwu3N0HUQdwlmAzFYIN12tpxAWuoQghZUbrxBateAiksLszyhteACtV0QH
         WuNdZ6iUkfT96Ho6I0fIYVbbYf3dSXRQEzuxYSkLBvlMm52qpnMAqoP0ZIGk9mDhaGqc
         CpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XF1WqDbojxivp5uBt+4Kr/NIauhmgI6WZtsBhc8uWUk=;
        fh=P/fOrVQ3NNCvyEAlCTmExq1KVo4tNInD0p9aHaBSpD4=;
        b=VD7W11veXQ3guuql/Ye5hzj9kZn/lYKb/CSQRGO0ZHi0VG48RvcCu0Lgy1mMYB/COy
         ets5/3Pq+Sfxfmt1w8uWOUokUA9QS2U7swzVP/Eakrn7YSEQJNxlpWSnDy4myGJD2BbA
         N1LfE3NKSpSKbdDoRgr1CuCr9gMmJFQAFW7uCqCukb3CeaV7TgexLsptfJu10Tb9VIFw
         loQWiJnKBM8B1aXTMabmL0yZbPEPcqIemW17EyaO84YhtEoogiOQiXLfmKEGf3jMWLDc
         JEKwY0FQ3Ld8DII4Hr20vkuiiVQFsohl8+XgRSZ6JkoTRHucLngjuQdS05X4S7BIjb9F
         PgFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773085000; x=1773689800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF1WqDbojxivp5uBt+4Kr/NIauhmgI6WZtsBhc8uWUk=;
        b=NI527SOx3l8MLi1AjPOVPjsirntHXZdzEmnLZhPb46bhLLReGBqrecQlKQJIRCGzDd
         kRBEsRo0pTavmWBwuUgD0ar2rtTbomsA2NXNqVErSTV20+AoveaEDSzuZWLaHGgOY9nX
         Q7D62+qm6TGR6dvVaIIXJvLNz0K8HsuhQ9H1CWceSeSKEU1RjJ3APG4+7hCL1Vji79WO
         IYM9zmkJRucb22fB5aI3xvzI4Qyy0O9uoRrR4OI8417C9kl7rOkVURPASuiR/rJm3XH1
         bwOLy9uPxy1X/jzM+91crGrKLIjPXMVM/32D/jl2R/usFVFR1OoiZv3hmjMedopKQo//
         Lc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773085000; x=1773689800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XF1WqDbojxivp5uBt+4Kr/NIauhmgI6WZtsBhc8uWUk=;
        b=BrINbpBayE/Z9sMSj4QoaqLoy/Xw5Yt3oUDixfOX7tK0ZrbRVi9Xxv1yce9SqhxI7z
         JS+DShXrnhS6su2eTADfFs7qiIEZejPd09+AZdOxkvvSB4oT2bd3yvWsqkFsNczIgwHK
         APoTA6n/X66PrZTdIYaoTl1Jql/Egen/DXUn84aI49L8ERlFvWjt9tbcAdG2O39gWvdO
         MzXN9SokOLX92gkZLE/3Tm6RgbSUU0fcqmX8QLUtcbjhpv9oYXAoBVUapSnJxLmQNP4j
         BDtRuu6u5roUy+4ou7NjRQOPlJE8bsloRWqLX9BroSuZ6rrSVSAdHWTgxKbKI0Mqz+j7
         zu6A==
X-Forwarded-Encrypted: i=1; AJvYcCUP1DSE4qEx/zw/9HeK/edz3fvT7e4s1ZL/daHyzwDINbKngRAnWs2+vEyyRMnELK5G3VhSbr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4MzgSqMYs5dZQ2z5OW9VnCwI3N0rjfLkDT25dZdAFfuGfthn
	1Vo52vpwcCFlyL8ltE0ZiSI/gzhRfH7Lj//uLMIx0laml34QNsFk9vGoycimyXes/a5/LHrpohf
	RwOnIf7OjgnmC3QpOlcgfgmXLsNYenkbGbGPTQHWS
X-Gm-Gg: ATEYQzx4Fe6OYEgFYbOrkAnl92Ua8DKmA0cs2XwJod7OJ4edkMZEyluF5zD/0Ul4yix
	qgop3XP02lVw74MeylYbyAhRCSPXZdFSZd56Z3MMIB3GjpPrzXszYmz84VTJf4hFntJwddObxS4
	7cbs1cPH/jTNeZzBSknVak2OGw8A4E948Oq7a98au0Re9owjTQpRfLBKn5wpPlOR3pa8fuWArOE
	4aBWu3Fx8nZVWruvKTGjabB1ubXcwYT9Ua1mmBkJGv07kPvK3VRRsxYaat7kPNB9RHCg6GxzJwS
	odwydCBqAll+OZidC99PMA==
X-Received: by 2002:a05:690c:c22d:b0:798:6af6:a40f with SMTP id
 00721157ae682-798dd75b0ebmr107239417b3.55.1773085000546; Mon, 09 Mar 2026
 12:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307163430.470644-1-edumazet@google.com>
In-Reply-To: <20260307163430.470644-1-edumazet@google.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 9 Mar 2026 16:36:29 -0300
X-Gm-Features: AaiRm51rGdTyJUpg4dm5fdIAw7f4LJ-68S1FklBzNYtYa7gWm6ZnTMLGOGw67yI
Message-ID: <CA+NMeC-c8azXXVa+GEmvjhWpPRhF6wkSeRAw6TsN_vB0M0wdCg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net/sched: do not reset queues in graft operations
To: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	eric.dumazet@gmail.com, Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C830C24044B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265741-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,redhat.com,vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,huawei.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 1:34=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Following typical script is extremely disruptive,
> because each graft operation calls dev_deactivate()
> which resets all the queues of the device.
>
> QPARAM=3D"limit 100000 flow_limit 1000 buckets 4096"
> TXQS=3D64
> for ETH in eth1
> do
>  tc qd del dev $ETH root 2>/dev/null
>  tc qd add dev $ETH root handle 1: mq
>  for i in `seq 1 $TXQS`
>  do
>    slot=3D$( printf %x $(( i )) )
>    tc qd add dev $ETH parent 1:$slot fq $QPARAM
>  done
> done
>
> One can add "ip link set dev $ETH down/up" to reduce the disruption time:
>
> QPARAM=3D"limit 100000 flow_limit 1000 buckets 4096"
> TXQS=3D64
> for ETH in eth1
> do
>  ip link set dev $ETH down
>  tc qd del dev $ETH root 2>/dev/null
>  tc qd add dev $ETH root handle 1: mq
>  for i in `seq 1 $TXQS`
>  do
>    slot=3D$( printf %x $(( i )) )
>    tc qd add dev $ETH parent 1:$slot fq $QPARAM
>  done
>  ip link set dev $ETH up
> done
>
> Or we can add a @reset_needed flag to dev_deactivate() and
> dev_deactivate_many().
>
> This flag is set to true at device dismantle or linkwatch_do_dev(),
> and to false for graft operations.
>
> In the future, we might only stop one queue instead of the whole
> device, ie call dev_deactivate_queue() instead of dev_deactivate().
>
> I think the problem (quadratic behavior) was added in commit
> 2fb541c862c9 ("net: sch_generic: aviod concurrent reset and enqueue op
> for lockless qdisc") but this does not look serious enough to deserve
> risky backports.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

