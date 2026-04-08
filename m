Return-Path: <netdev+bounces-276732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL2jBXnf1mmsJQgAu9opvQ
	(envelope-from <netdev+bounces-276732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:06:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9593C4A3D
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB8B93009B15
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13E2378D9A;
	Wed,  8 Apr 2026 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhOQaNX0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204835AC16
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689576; cv=pass; b=n17dKCQD+rpnSIiNV3ICv24q9RZKOaSXoOeCHSOn4ZiEzvRiXl2IF068YTHagJt82Rpn9jUCCwrKk8ocegZM+V4xV6XBv8p4TBfRJFJZIn+IERn/zt7vu9PFuszt7JtW8b2F1MGAgfKaGsbvcwHyUlMtW/rZfYtF8qm5nN6FAEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689576; c=relaxed/simple;
	bh=z6c7hISk3aid/HRlRk44fwvEql24rvRb047d0E9+O+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7dYaooSPnZUrFqygu/RtZ/Ch0QcXQtuo083jvg/Kjgncsvw3d/jtGGCA/GtYXX/x1Wbas9gsq5JMCEqe2oWV6dVqSdfa/tp2E/+i65egDrpEf836OfLUgtc4WWcPtUhTJVaIuD+ZlDOWrmjU0X64IXSkKk+sOPcoM9VlzJkbz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhOQaNX0; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so279587e87.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775689573; cv=none;
        d=google.com; s=arc-20240605;
        b=Arn7K/2s66k78hQVI6AcFh9fKeegaHRbmB6NkmgMIqtaMtDhB7gKiBx3I6kypZzYo8
         HlyDPfKQys+JkVXuElaYSeo6f5L0/QSSsJVfUSIqy3PKqdOZDKLa+dzppmzK82BCmFy2
         2egkqW/Tg8dJb903FJLvciZZEFqTtY6lWRZX33C4tNZoKlfF4Fkbi0RDYfdmhuaaOpFe
         xbar7+Yg8n7F1CLMsdZR/sa32YFwAzq5/c9N4unmlTfyRMIoLmNTDDGJGXDAmhAbDXhc
         0zLbrf2sakWIi/BFUqn2RpkGinIrP4ucwzYlyBd+9HAZyVCIzAuJJ7bcrDkpl7rC53ey
         2NLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z6c7hISk3aid/HRlRk44fwvEql24rvRb047d0E9+O+E=;
        fh=XDzfqBNVmgQ/k6WAw2U+ddOJcvMvBBo8N45We0BPi2I=;
        b=QKo8YZHS+86AGRD2U76F6n3Es+GSAiUriMFyS7DSqdXmOVJbml8pY8vPAPG5sniTgA
         0niSgVmg6dQnFKFjUs9CWJIQn6/cWeOwlNJUbOf+B4biAqXfeSXJGAbVBvm7gKmv9t5Y
         z1WEYsgUqvGwlVmuZTdLa0pCheKJomcbfl4IN2IaYDR80TsUyYF4CEBz0L7r2jzXlckL
         FV3op1nrw1Jw1Gp2gBW4Os+Y18Q4OHV1hQ404XxOxDY7R50WcXdYLrYNwusXuA/ksmbr
         u3slJu/3ZK/nfRQH0PysbOkUGVkRZZiWOycRC+nzbwjp+pl8W6Rj/oWb8PxycAbIAMdl
         Wr5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775689573; x=1776294373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6c7hISk3aid/HRlRk44fwvEql24rvRb047d0E9+O+E=;
        b=fhOQaNX02gPoFdrlvbU9SpzwcfwU8wAES3XWx8gv6zy91sICkyiWXAtZw4XQooBleW
         EbLTdCUFHmoodtytBNKqjEzSf3+s7e/FzND3S5OhLfepH/HIaHZu+PKBUhkRY2xUy67z
         /SK3g9IAdrDFhKJ9/eGKVfwOmeyz5BL38gmHlKpLO4j2+QYd87rHyUcf15ecTBXT70He
         8S9XzxjY1v+BcFOwgs2gml+zXwYIkFRV79KpTZGJTjP9Q3EOIun3F9H/HumbMDImUtH2
         s0w9BrrxPGn2fPoI9PAkGPNw5EEzav9M3igffoPzCn5SprUXMvGM7l77THCj8rRRnRh6
         zP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689573; x=1776294373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6c7hISk3aid/HRlRk44fwvEql24rvRb047d0E9+O+E=;
        b=j9aRrCFKngK+PpRB8gQJ9zlpglAYGurJlMBWL8c11KDvDBbkKOqvOGqazHCzL2DX1w
         8LwrNHikh2yyBow+e49Uhg2f3Qr1hQsYrnYRJP1VJjqcAD3utZpuOVtjcayV7ouMMidx
         TOhhdU29ZJRRAW7D8l0jsvqck7xHa//wE+K60AiO9ByxkJmbKbDjtm328XQEBjjZUGxL
         +p13/Uyq7ox4xHmXHidboQHdrqa+uXOyjJlWV3CzClXZAQORH3eJ8gKaXiLTTtUsj7XB
         /GfDgQBTqfjWZQ2rGjVXqP9cP8FVqMwAQ0bc+MVEzEY62GdOsS1zDrKpAkhNJl1l/voG
         X75g==
X-Forwarded-Encrypted: i=1; AJvYcCVXan5WRAAIZJQvsxcKpFlOU2fe0A4idMIVd9gOfqXVX8iH4TxWA5VD1rHGEQCqRYELgTAlVCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIY1uPMer/YsxnSswvKOTCEJaUU8fx+Cja/k8NbYEPASCp56Dq
	7ClRzXBL6Yofxx9kNk3WToziCq74jn5QE8Ysls71/w4JcDUz0IcOvPq9m5smDZ3BLiIpo0OAUKk
	4AvUMb2ShG5krf4F5I1nTHSAVtxeIezA=
X-Gm-Gg: AeBDiesFQamRMmgmRwulbvl5gPzXjrNMhNuanzff/bABjVqWgX+YiMkaoWeb6nUZ/ag
	YQIyt10A8GZkTf2+EcLxxz0+dQy8ylvwhXHzDLDHQDLAXyJFsuaGzaOk3nhWUZv7zxDDMlA/CrS
	4RWF0HZwP589phVJdl/iUTRq4qR0uDPEcoePZq337/GHz/W6t6w2KJP5PpbcybfxarqwXLPmZpO
	ijy6r4LvJmqn7ou5jvZL7V72WwLAA+yU+JsI8OaPmB7KVTw/VsNonUpHA+qC+hUXDTU7HD0ac2U
	Jir80PI=
X-Received: by 2002:a05:6512:2255:b0:5a3:ea23:9af8 with SMTP id
 2adb3069b0e04-5a3ea239d28mr12499e87.24.1775689572219; Wed, 08 Apr 2026
 16:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com> <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
 <willemdebruijn.kernel.27ec47b22b23c@gmail.com> <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
 <willemdebruijn.kernel.1b49845d3acc7@gmail.com> <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
 <willemdebruijn.kernel.257654f9a3f23@gmail.com>
In-Reply-To: <willemdebruijn.kernel.257654f9a3f23@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 9 Apr 2026 07:05:34 +0800
X-Gm-Features: AQROBzDQgEI9lw5wbSyPTgXA2FWuJ-qBMbd5NRMWRIDCToG7zeyMq_VD-ECIWvg
Message-ID: <CAL+tcoCx0fB-jsF3j03vFfhPDvO0T-B=FGzEgi4GE06Y_rjeMw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-276732-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6D9593C4A3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 11:15=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > > > Since we're modifying the kernel, how about adding a new member t=
o
> > > > > record sendmsg time which bpf script is able to read. The whole
> > > > > scenario looks like this:
> > > > > 1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
> > > > > 2) in either tso_fragment() or tcp_gso_tstamp(), each new skb wil=
l get
> > > > > a copy of its original skb
> > > > > 3) in each stage, bpf script reads the skb's sendmsg time and the
> > > > > current time, and then effortlessly do the math.
> > > > >
> > > > > At this point, what I had in mind is we have two options:
> > > > > 1) only handle the skb from the view of the send syscall layer, w=
hich
> > > > > is, for sure, very simple but not thorough.
> > > > > 2) stick to a pure authentic packet basis, then adding a new memb=
er
> > > > > seems inevitable. so the question would be where to add? The spac=
e of
> > > > > the skb structure is very precious :(
> > > >
> > > > Finding a suitable place to put this timestamp is really hard. IIRC=
,
> > > > we can't expand the size of struct skb_shared_info so easily since
> > > > it's a global effect.
> > > >
> > > > I'm wondering if we can turn the per-packet mode into a non-compati=
ble
> > > > feature by reusing 'u32 tskey' to store a microsecond timestamp of
> > > > sendmsg.
> > >
> > > Agreed that an extra field is hard. We should avoid that.
> >
> > Avoiding adding a new one makes the whole work extremely hard. I'm
> > wondering since we have hwtstamp in shared info, why not add a
> > software one for timestamping use? Then, we would support more
> > different protocols in more different stages in a finer grain, which
> > is a big coarse picture in my mind.
>
> I don't understand the need to store more data in the skb for BPF.

I see your point.

>
> With BPF hooks, the bpf program can record the relevant data directly
> in a BPF map.

It works for sure, but, as I said previously, it's not an effective
approach that can be used in production to run a 7x24 monitor.

Either adding a new field or repurposing the tskey makes the whole
logic/arch very simple. Being simple is being efficient and easy to
use. Without changes like that, the performance of flows can get
hugely affected just because of the monitor.

>
> > Adding a software bit will completely reduce the whole complexity and
> > be very easy to use. Would you expect to see a draft by adding such a
> > bit first?
> >
> > Or just like I mentioned, repurposing tskey seems an alternative,
> > which, however, makes the new feature incompatible.
> >
> > >
> > > If the purpose is to group skbs by sendmsg call (e.g., to filter out
> > > all but the last one), it is probably also unnecessary.
> > >
> > > From a process PoV, since the process knows the sendmsg len and each
> > > skb has a tskey in byte offset, it can correlate the skb with a given
> > > sendmsg buffer.
> > >
> > > The BPF program is under control of a third-party admin. So that does
> > > not follow directly. But it can be passed additional metadata.
> > >
> > > I thought about passing the offset of the skb from the start of the
> > > sendmsg buffer to identify all consecutive skbs for a sendmsg call,
> > > as each new buffer will start with an skb with offset 0 ..
> > >
> > > .. but that won't work as there is no guarantee that a sendmsg call
> > > will not append to an existing outstanding skb.
> >
> > Right. TCP is way too complex and we indeed see some tough issues when
> > trying to deploy the feature. So my humble take is to make the design
> > as simple as possible.
> >
> > >
> > > Anyway, the general idea is to pass to the BPF program through
> > > bpf_skops_tx_timestamping some relevant signal , without having to
> > > expand either skb or sk itself.
> > >
> > > I hear you on that measuring every skb is too frequent. But is callin=
g
> > > the BPF program and letting it decide whether to measure too? BPF
> > > program invocation itself should be cheap.
> >
> > Oh, I was clear enough. Sorry. I meant tracing per skb is definitely
> > an awesome way to go. My ultimate goal is to do so. Instead of letting
> > people implement various fine grained bpf progs, we can provide a very
> > easy/understandable/efficient approach with more samples. It should be
> > very beneficial.
> >
> > >
> > > If per-push is preferable, with a filter ability like the above, it
> > > seems more useful to me already.
> >
> > Push-level is a compromise plan. Packet-level is what I always pursue :=
)
>
> Then why not directly implement per-packet.
>
> If the BPF call is cheap and the BPF program can choose to selectively
> track packets.
>
> Reminder that you do not want to break (BPF) users by changing
> behavior. Let alone more than once. If per-push is going to be
> obsoleted, skip ip entirely.

Understood. My initial version was just to try to solve the missing
tag issues with the minimum change. You're right about the
compatibility across kernels. Let's work on the ultimate plan then.

Thanks,
Jason

