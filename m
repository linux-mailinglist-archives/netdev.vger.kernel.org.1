Return-Path: <netdev+bounces-254905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGOzOqu4e2k0IAIAu9opvQ
	(envelope-from <netdev+bounces-254905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:44:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74090B4125
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 141A6302C5F4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E23328B6F;
	Thu, 29 Jan 2026 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+U+QY4/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1B327C06
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769715880; cv=pass; b=i6QfoKm2or7UGDxhtxwx6eOqYtEQit2GLlrV0rluvMgiNbv56jC5AFEIuPmJnWAT6cDREvxgF+UYh2s4QGqlO1C9I+NMRY1kMlWutr6L38CRkjam0Siwkt9WpC7MIQAVtH8C0ctDZVaWtAPRHZHeoQyKng11BMLGPeoNNtl91Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769715880; c=relaxed/simple;
	bh=Y0rOjxXytJB+38cdl2LNr6UYE5fA4/7cWyfoN0StXhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdg+8Dmoyly+d/JxFlMtUDpft0pPmPtQ08XEoQFAMi9Ta4o+CIxv+u+qFBkghVEaezStB9dSr/iGHPVO7oGeFJi6Ac6XlGJR4YMnQRodX0CHwu2nHYet8iXiAhJmHyA8cvmwLoncymePYHNZL4Ca1timyY/VkeHIl9CF4aRIX9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+U+QY4/; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-947fea7590cso364912241.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:44:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769715877; cv=none;
        d=google.com; s=arc-20240605;
        b=TLc6pOLYjrUAfZKjhDnhAWtUWFrViL9gzGmv0cRvXHBQebxtYFbnLctWSbmdsONNjt
         F69PJNVgTTUQLwHR9HXEsFrfb+Cu7DV5AnKzpRWofVfN3yQssmuolm0CoaBToIhj+9SS
         OvzD60EOa7BFERp6VHIrBExGOfEmVHKj0L3XswojbbuMF5O7xdZyxDdUs3fJN4txyF0j
         BGKuebLNNXWBHSezPahqspfbX4qfGkJ4kNYAg3KMeZzHHYsJIqtVS0UaQVUMQ6eC12O0
         wf2uBZru9LxRT8e8VUQrtXyV4hafqRtkzL+vaQthQ/0Qd/S9ZiB6FLbh2bfuzIuQ5/FD
         q49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gbwVti2MveWgbF61EO9aejU185mP/ZCSwXbR5m8XjS0=;
        fh=xGCdc1uWJmzD75+Y+YLK82mt5UilC/EZs3R5uDV0W2A=;
        b=KPTJ6OqBWL4VlaEI/aUyLM/Rbb6vrmn8S/3NsbdEEzlteQaTIF/1RaVQAPjlqtdYAr
         O6YRrA7h5qV+gnHnSTZ0KK2QFp3STQcEh/m8suUH8fGk8efNLJJHlShsTGaXHmIMUt91
         gvpm4WYFBqpp1PLg8P9CyLmr5QoswG/ThxZV16+TQfS80Pvght2CSqGQ/Cw0yMgrtymC
         M46+105/cFA5jc4lUq0jYSpFeuq6lEuM7+tZyDD8LcybvtJoCWphNYfyQm9McvRFVRze
         /hA1xyEy69bQiW+fDWJm56EzxHbdj6vZlO4S/cof5krn3HmmRkwAqrgh8ZaM2LI0nHyN
         uy4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769715877; x=1770320677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbwVti2MveWgbF61EO9aejU185mP/ZCSwXbR5m8XjS0=;
        b=i+U+QY4/8SKhsKGIab8XPm0cB5toASuCzlmBZhre8O882K7JKZAre1VMB/ducovgef
         Jj3DLv2X4YwzLkc0zx8Ig+4VbOfPKgxq41QkXNkxncXbE8Yvcq+C8lLw3ZhXMwjQKZKE
         EQ5UKTI2yt1Yb1jjnEMoRn9y+lzcaxg7T8v2jpoYcyPIA/X9198+J7UMc2/Z9qbCZNsm
         Eu2MYEvmxzq6+7oCYyoJXIS9y42G7JJ9V8fyQk2YcF9tevTqpI2++qGbttdNVcqop9iT
         ltflJ1Fd6Z+z4dwRjWbQMk+7pJD4w1CLKnzTHHpDXNn5ydPPaTczmwj0xQ8aYUTbqFC/
         vHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769715877; x=1770320677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gbwVti2MveWgbF61EO9aejU185mP/ZCSwXbR5m8XjS0=;
        b=FMuXYu2llqeNEs4vPk9CzJbOjA23mfsRVSPZhv06hvuXGjKR3qLOJgjoMZamhhBaVq
         bzQCdC6aG/QAdcJErw9jdbUp7MmJObgE/v/oywRkcz8fIY5j/Thn/A5xmBjwxuBbVWVA
         lBt4t5rwU5pFXLHogLAcdO130cA4r9GQlFDRzOU0XZxMvOQrCnslOwaa5FVxInuYnSon
         LfbpXm2Il6BIm9W48Mv0RfFDE91qYW4lBwOBvxwkQM2bvAvoXuIZRDGV8M6iyM9VYUQ9
         MW6SX905GMtPFon6lAfY8MQlbh8rt9yoWHNzM+La/x4TqkF5PPthMAZgEWJUVSOL5zF7
         lpoA==
X-Forwarded-Encrypted: i=1; AJvYcCU6sH/YTMyjFt4gy9Hx/KQQ1IH5ezzqQX9xW/rXfYHd2DSn5O5JTgZjOfAPzzNOqz156HAvpkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfAkPOlk3YW5F11vAWpnSoUMBel1mwGeQvLgEQ6ChGiVhZ/qkp
	9zE4aU6bRhpITUNnPe2kFs7JHyM4JIlxcLaF56Eb1coNKHGErMUCxLxu+mHP5Mfj3bGKNo57npC
	hYMti7TVuHQITevBpqNyEWq+K3gkFj4E=
X-Gm-Gg: AZuq6aLkND81hct+FLGRKD27uLGdJGfFd1VXpXTXCTvy1AH4D2Anm3GHGY8SH8lHy5A
	y3UyjgOU8g16NTHy71PouKQKHBgRK+1W73Dk0dUjfY/3HtRUTtYjblzbhyyFppGClnmmDmyYoTG
	6gmVl99rn9UFQkgc16zllDD7tfMVytttT/iqpb31y3i0S8eiS66zI6kUL8JpXLcrJkqrhSuYFgb
	HnGuKxQUdaWPM4zhWGS8Q5iGlegN/gjzP0tUJLO+tP1TjVTMAjNIavpEh8ge8KiiKE3Iic1H39p
	T49XpQK9BgoWIMp0kpaWHVJx/wu+4g==
X-Received: by 2002:a05:6102:3a0d:b0:5f5:33e4:12ea with SMTP id
 ada2fe7eead31-5f8e25b8bb5mr192452137.31.1769715876891; Thu, 29 Jan 2026
 11:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9b38b4291e2b1b47ee17f7247c4c66f5bcdccffe.1769439073.git.lucien.xin@gmail.com>
 <20260128161505.1454974-1-horms@kernel.org>
In-Reply-To: <20260128161505.1454974-1-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 29 Jan 2026 14:44:24 -0500
X-Gm-Features: AZwV_QiOMgB9Wkbq9Dg2c4rBLhA6Us48hykz0TzV8M9p-NxQPJtuqm3d7-FhuP0
Message-ID: <CADvbK_cNUg+N5jAnmJXGBri27+AkwuFFhbKUqONkAgu1ZAmOJg@mail.gmail.com>
Subject: Re: [net-next,v8,09/15] quic: add congestion control
To: Simon Horman <horms@kernel.org>
Cc: jlayton@kernel.org, davem@davemloft.net, daniel@haxx.se, kuba@kernel.org, 
	dhowells@redhat.com, chuck.lever@oracle.com, andrew.gospodarek@broadcom.com, 
	matttbe@kernel.org, tfanelli@redhat.com, metze@samba.org, 
	marcelo.leitner@gmail.com, edumazet@google.com, linkinjeon@kernel.org, 
	hepengtao@xiaomi.com, illiliti@protonmail.com, quic@lists.linux.dev, 
	mail@johnericson.me, jbaron@akamai.com, alibuda@linux.alibaba.com, 
	tom@talpey.com, steved@redhat.com, sd@queasysnail.net, pc@manguebit.com, 
	smfrench@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-cifs@vger.kernel.org, xiyou.wangcong@gmail.com, dreibh@simula.no, 
	kernel-tls-handshake@lists.linux.dev, mbuhl@openbsd.org, aahringo@redhat.com, 
	hare@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254905-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,haxx.se,redhat.com,oracle.com,broadcom.com,samba.org,gmail.com,google.com,xiaomi.com,protonmail.com,lists.linux.dev,johnericson.me,akamai.com,linux.alibaba.com,talpey.com,queasysnail.net,manguebit.com,vger.kernel.org,simula.no,openbsd.org,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:url]
X-Rspamd-Queue-Id: 74090B4125
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:15=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> quic: add congestion control
>
> This patch introduces quic_cong for RTT measurement and congestion
> control. It implements a congestion control state machine with slow
> start, congestion avoidance, and recovery phases using New Reno.
>
> > diff --git a/net/quic/cong.c b/net/quic/cong.c
> > new file mode 100644
> > index 000000000000..1a8b7f8db977
> > --- /dev/null
> > +++ b/net/quic/cong.c
>
> [ ... ]
>
> > +/* rfc9002#section-5: Estimating the Round-Trip Time */
> > +void quic_cong_rtt_update(struct quic_cong *cong, u64 time, u32 ack_de=
lay)
> > +{
> > +     u32 adjusted_rtt, rttvar_sample;
>
> [ ... ]
>
> > +     /* rfc9002#section-5.3:
> > +      *   adjusted_rtt =3D latest_rtt
> > +      *   if (latest_rtt >=3D min_rtt + ack_delay):
> > +      *     adjusted_rtt =3D latest_rtt - ack_delay
> > +      *   smoothed_rtt =3D 7/8 * smoothed_rtt + 1/8 * adjusted_rtt
> > +      *   rttvar_sample =3D abs(smoothed_rtt - adjusted_rtt)
> > +      *   rttvar =3D 3/4 * rttvar + 1/4 * rttvar_sample
> > +      */
> > +     adjusted_rtt =3D cong->latest_rtt;
> > +     if (cong->latest_rtt >=3D cong->min_rtt + ack_delay)
> > +             adjusted_rtt =3D cong->latest_rtt - ack_delay;
> > +
> > +     cong->smoothed_rtt =3D (cong->smoothed_rtt * 7 + adjusted_rtt) / =
8;
> > +     if (cong->smoothed_rtt >=3D adjusted_rtt)
> > +             rttvar_sample =3D cong->smoothed_rtt - adjusted_rtt;
> > +     else
> > +             rttvar_sample =3D adjusted_rtt - cong->smoothed_rtt;
>
> The comment above references abs(smoothed_rtt - adjusted_rtt). Paolo Aben=
i
> suggested using abs_diff() from linux/math.h for this calculation in v3
> review, and it was acknowledged. Could abs_diff() be used here instead of
> the manual if-else?
>
> https://lore.kernel.org/netdev/a9427359-a798-4f3a-88ef-c10a0bf614ec@redha=
t.com/
>
Wow, AI truly has a good memory.
Right, I somehow missed this. will apply abs_diff() here.

> [ ... ]
>
> > diff --git a/net/quic/cong.h b/net/quic/cong.h
> > new file mode 100644
> > index 000000000000..e6cfb0fa1b6c
> > --- /dev/null
> > +++ b/net/quic/cong.h
>
> [ ... ]
>
> > +struct quic_cong {
> > +     /* RTT tracking */
> > +     u32 max_ack_delay;      /* max_ack_delay from rfc9000#section-18.=
2 */
> > +     u32 smoothed_rtt;       /* Smoothed RTT */
> > +     u32 latest_rtt;         /* Latest RTT sample */
> > +     u32 min_rtt;            /* Lowest observed RTT */
> > +     u32 rttvar;             /* RTT variation */
> > +     u32 pto;                /* Probe timeout */
> > +
> > +     /* Timing & pacing */
> > +     u64 recovery_time;      /* Recovery period start timestamp */
> > +     u64 pacing_rate;        /* Packet sending speed Bytes/sec */
> > +     u64 pacing_time;        /* Next scheduled send timestamp (ns) */
> > +     u64 time;               /* Cachedached current timestamp */
>                                    ^^^^^^^^^^
>
> There appears to be a typo here - "Cachedached" should be "Cached".
Will fix this typo.

Thanks.

