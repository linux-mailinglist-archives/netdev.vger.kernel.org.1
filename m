Return-Path: <netdev+bounces-258069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGWnGoEci2kvQAAAu9opvQ
	(envelope-from <netdev+bounces-258069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:54:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D722B11A6E3
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC195301DE0A
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A423271FD;
	Tue, 10 Feb 2026 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A45wwVYb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bd1C3MiL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0552A319848
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724477; cv=none; b=dwdSzWESqgIUyRMq1UqPeJDgzPVBiPpfUnz7SOYxdUZebFhJ/+srkBnCOweg3q7+F52CtLqumwRJRLF8mBE8z1XYWHmxczVRt1n2nfEH+bT1RTPBhRPsyJVVJ0LybV4rO0syHC5nxnCic2/E1LH/VJkAa1BSIabp8jTCeJ+aF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724477; c=relaxed/simple;
	bh=V8S+bf/F66K8deOO2u9VcoAmmrQcaSvWUcOZQvCI4qM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LiPYliJsMim9XWlSo6ROrTey2f9XBQNXIh0Q1gsRtYBUDJ9GXrHCdNGmadZYHYRqbWIB2cxLShMNjfmYDMjGvP6uvGErfFlK08DObMmGzvA3jczYuotY6t7DdeZrTMUz8xo1BbSQge/In8bNDvBujNEPHDlJDoph8zlrkQAApg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A45wwVYb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bd1C3MiL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ujBMXc2jefpwX552HAfe/z0MTFmV9RxghsSUrNeWh4=;
	b=A45wwVYbTa30lF9BY3aj+tDYbjIHTC4hESd4qXo69mmrvaq0cdTw4wSIAp4gS+BxaobdbE
	jzgkZfns7pYUUW/3AtLPMn0Abe6Xx4knyBIsCVaPJ9dyGfZacB6eJwT4hLplLfwkFdIeQa
	7mQqtcUdSCieXrt9gXjH64plvZtIgck=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-XWF2VZjjN6WDMWdCO286Iw-1; Tue, 10 Feb 2026 06:54:33 -0500
X-MC-Unique: XWF2VZjjN6WDMWdCO286Iw-1
X-Mimecast-MFC-AGG-ID: XWF2VZjjN6WDMWdCO286Iw_1770724473
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4806cd00e02so23108575e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 03:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724473; x=1771329273; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ujBMXc2jefpwX552HAfe/z0MTFmV9RxghsSUrNeWh4=;
        b=Bd1C3MiLcYsQWKH+8dbql5kYWpYxacqklrLco/Gl1uzMVPsVNsoIAWiYKbqddPQdVQ
         G8WYkQOx9OG7txUFaVSwNA/eDcIazY8cYFahhO0lws47ezpPUrUgtyT9H67zMHgPthME
         tI4y9Iy8zcvKh0Dc7GC47uop10bETYYleMgoI6zuDVcFzpBnIB/9g2XTtbJNzTpSuBZr
         LbPkG8Gv9KVz6MACldrfXEcMaEhBodbWA7/9cvoVQELP5wUvMV/xhxiLIDIXWXnyLNdY
         1THbFEwQSt7GBImYX0YGwOhhsGxs5TT4xGmGMVoaMa5DHQjnh+8W+EiUuPATXXmHek01
         XITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724473; x=1771329273;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ujBMXc2jefpwX552HAfe/z0MTFmV9RxghsSUrNeWh4=;
        b=fgfXA+mDLYBnyKrV6eCgtJMfN9PBoek76cHjNx6q5x5b0f8u8JiinCzrYQ2SzM4TvU
         1iENewGGctCoHpOAZ+lT6Kv4FaA77vqMkgei4GJK9R+IVJ7LVjqqfFgdllFv6wqlOdj1
         XH4vuv3t7Ql9lIgNkRmldM1UZHj4oykbUIHfxwMRKoyDXfxGWigEDqepMZz3gWNcIj/e
         SGdW38gv4jV0+LNLXsZjp2gKugMqHsNgDby8jResXuS0KM404UKN3dzzrB0Q2MtKbDqp
         AYqifY9gQodBy8AqF2J7SRLiap133oHwCMI7hDYyQdZoec6si/ACX0MC0NzcCpa2AhmD
         xsag==
X-Forwarded-Encrypted: i=1; AJvYcCXuKK8dKtpVHQ5jE1zYQOvwJRi2CkQiXL5UpDMSPc0Ejyl6f3zdPnhJ0zjUU7WaixYPKD1r/DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/JkBdOxN3ASGbtHU5UEMcSwsYdLwdjFjp/QYv+/+Ks8/7qka4
	ZsQ3a/aTVrmwijDb53NfJP0EhknnWj0I5Z9iPIg46LVnPHnVTfaBIvavm9wgsjdl2RyETPt6NNL
	FQbjQtaQR2ZnRpD7NP9PNZqOKySqI+3iSpoxmNENrPaGHLhDyauFaT1J5UA==
X-Gm-Gg: AZuq6aISXJc1bhZ2A6c2NPMQxYkeMlg/KmVYvHgXMNKgJKlC03dz/Ws/+M1O/R4QJwJ
	0+lAIcJhL5Uz1gJOhp4P5vevLurMXXrTBin+mdY7j+3TPuUmRnDb+mveaKLCKIa0XpfzZmB/b2G
	BpCudWFDMWr1Z0VkrWh7VB3byW7Z1ASAkiqnbzzk5pFLTpnVwJ2VVsK7KUb5+E0INPYLtPotqAD
	6adAdIxDH4mKpVRZcn5Vhe8W+0UXSi+Mw749FDNLHhdtDV6W4IElq3yw0PF7Lvq44j25TwLz7rn
	IH4t0Y0U817HKMa4NiJMqIsOUCBNLIL9XBSP1cwKLDvNRCox4SArdW8/dgvFO7aHPzipLz3Ck4w
	GhPXJtO3Nv4Y3lxhgGPCXLXiSlpBl2W1Pl8+UjCq2LvctwQ==
X-Received: by 2002:a05:600d:6413:10b0:483:4807:20fd with SMTP id 5b1f17b1804b1-4834807226emr44644875e9.30.1770724472673;
        Tue, 10 Feb 2026 03:54:32 -0800 (PST)
X-Received: by 2002:a05:600d:6413:10b0:483:4807:20fd with SMTP id 5b1f17b1804b1-4834807226emr44644605e9.30.1770724472261;
        Tue, 10 Feb 2026 03:54:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d8f2csm83406055e9.1.2026.02.10.03.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:54:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B7F784FE89F; Tue, 10 Feb 2026 12:54:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 5/6] net: sched: rename QDISC_DROP_FQ_* to
 generic names
In-Reply-To: <177039508922.2258217.2724637003148631081.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039508922.2258217.2724637003148631081.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 12:54:29 +0100
Message-ID: <87seb8yft6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.40 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258069-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,redhat.com];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D722B11A6E3
X-Rspamd-Action: no action

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Rename FQ-specific drop reasons to generic names:
> - QDISC_DROP_FQ_BAND_LIMIT -> QDISC_DROP_BAND_LIMIT
> - QDISC_DROP_FQ_HORIZON_LIMIT -> QDISC_DROP_HORIZON_LIMIT
>
> This follows the principle that drop reasons should describe the drop
> mechanism rather than being tied to a specific qdisc implementation.
> These concepts (priority band limits, timestamp horizon) could apply
> to other qdiscs as well.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  include/net/dropreason-qdisc.h |   21 +++++++++++----------
>  net/sched/sch_fq.c             |    2 +-
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/dropreason-qdisc.h b/include/net/dropreason-qdisc.h
> index 2e2f4fc36e0d..8661797193b1 100644
> --- a/include/net/dropreason-qdisc.h
> +++ b/include/net/dropreason-qdisc.h
> @@ -12,8 +12,8 @@
>  	FN(FLOW_LIMIT)			\
>  	FN(MAXFLOWS)			\
>  	FN(FLOOD_PROTECTION)		\
> -	FN(FQ_BAND_LIMIT)		\
> -	FN(FQ_HORIZON_LIMIT)		\
> +	FN(BAND_LIMIT)			\
> +	FN(HORIZON_LIMIT)		\
>  	FNe(MAX)
>  
>  #undef FN
> @@ -82,17 +82,18 @@ enum qdisc_drop_reason {
>  	 */
>  	QDISC_DROP_FLOOD_PROTECTION,
>  	/**
> -	 * @QDISC_DROP_FQ_BAND_LIMIT: FQ (Fair Queue) dropped packet because
> -	 * the priority band's packet limit was reached. Each priority band
> -	 * in FQ has its own limit.
> +	 * @QDISC_DROP_BAND_LIMIT: packet dropped because the priority band's
> +	 * limit was reached. Used by qdiscs with priority bands that have
> +	 * per-band packet limits (e.g., FQ).
>  	 */
> -	QDISC_DROP_FQ_BAND_LIMIT,
> +	QDISC_DROP_BAND_LIMIT,
>  	/**
> -	 * @QDISC_DROP_FQ_HORIZON_LIMIT: FQ dropped packet because its
> -	 * timestamp is too far in the future (beyond horizon). This prevents
> -	 * packets with unreasonable future timestamps from blocking the queue.
> +	 * @QDISC_DROP_HORIZON_LIMIT: packet dropped because its timestamp
> +	 * is too far in the future (beyond horizon). This prevents packets
> +	 * with unreasonable future timestamps from occupying queue space.

Why change "blocking the queue" to "occupying queue space"? The former
seems worse, so worth calling out?

-Toke


