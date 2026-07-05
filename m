Return-Path: <netdev+bounces-304788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Ho6OBJ+SmpqEAEAu9opvQ
	(envelope-from <netdev+bounces-304788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 17:53:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B99270A82C
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 17:53:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IMGwhpQC;
	dkim=pass header.d=redhat.com header.s=google header.b="DR/GCL+x";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304788-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304788-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A6FA3009153
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFD6389111;
	Sun,  5 Jul 2026 15:53:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C033890E0
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 15:53:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783266831; cv=none; b=VZETRUKauyuqa8Lr0gWjLac8vtXF1nMyb7x3MWI/ZjGFWswd2agSah7NQxJTLc3J51Hn/hBqZqUQOxKlJ1BfGjEiL4LsmnY0V2X4SmMhYLewMg7LfYrBF+GXoChNHvaB9Y7bpu6l2BpiNnQI5T+dQRiqmJNB3K2EeHuMRuxPq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783266831; c=relaxed/simple;
	bh=5osjXumUGZ4Ch7vHbMYiDu8fWQgkHqYQPGL4m3IyHOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gm5EXht1L0x+V3x5Oxe1M7HrfWYF5YhK8aWnqh2yshREXYHM4CwHg07fmzEj7NayiYTk8bwQ3P6jepaStTzmduPYe1lVQlUxToVnAwDb5hXp4bX/0ZLbqV0u3S/OwwnMBv5LirV2xuUqfe9WN5D5Yxd6MUrvW0VgpVos9sJtfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMGwhpQC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR/GCL+x; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783266829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj3JZzJSw3Gi4lnK7zsIQuSgeOctWdp7FV6jLpJ7PaE=;
	b=IMGwhpQC30H931t9OEmze19TyNrpDLm8c/s3Qvyu8VIuNBQ9T2wPoSuj9RU40SqUazUCTp
	2LAscdpNEijZFOaXNQP3HL28wwgPO/Z6nID3GNb/QmsOI7EaFV7it5Y0pFyhyNprZUCZf/
	0kecw2H/WzUYZVAv3Ntv6FsC9Sa/9Is=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-qrBIt4EONruc0gAGXbqRyQ-1; Sun, 05 Jul 2026 11:53:48 -0400
X-MC-Unique: qrBIt4EONruc0gAGXbqRyQ-1
X-Mimecast-MFC-AGG-ID: qrBIt4EONruc0gAGXbqRyQ_1783266827
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c9b71388fbso51173565ad.1
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783266827; x=1783871627; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj3JZzJSw3Gi4lnK7zsIQuSgeOctWdp7FV6jLpJ7PaE=;
        b=DR/GCL+xSPzPUXlzyNf7fpHsNpEJaxSTGR7ijzQhh+woS3V4McNqCf/i7/4TFit5hA
         Gmeo8DwWKYVkbyy1/kE96jRAHjJQI5JfhVrSMf+zr1v3JgDijALhtUbMAoSjUw1agzZv
         +1WEhPgKyi5vWrJJkvvFnrhSw+hLArOi3COy1qc6xOea2xUkKfr+pSzKSDTFbaJC1Xz1
         l7MO14iGcK0mx019uHiHsQrafVsXBip7sSjhOpSkegQHgYwtihW42Qp1WseWGToaZ0fk
         AgNiKB+iG7PaKJqXIpw9as38FdyczEseltK/AdqlZSUgcrIPf3v4k2sUvPgDNwL0SNQi
         PNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783266827; x=1783871627;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pj3JZzJSw3Gi4lnK7zsIQuSgeOctWdp7FV6jLpJ7PaE=;
        b=Bv1oS3j3/ZStQzDtIxGTjT9wQ9HOytx4/XDqt4gwjPurisGdzD8V7RuxfDFGXhxOWq
         VLaToyiQJURjOVxizQ5dNy01VcS6HjmdD0+G1rfOmP09mwkTCg0WjUKIRSGj2Dk5kk6u
         6NyS+/YLHgcavQ+7FAQrqGorTNFTlTYnGwm0jkdPX0BMJ4WV+POO99xWHIcctmOLMEsa
         jUoIXgILhra5VQi5wXti6ZfIPPEtolvs/3iN+WTtt6HyaKvM/T363wFW4WYAbcXFFBKj
         fK1thPTvWUN7aWvKxlZO2xrdd3FgANYcH2J/SV6XNajHpuszcRF7d5WPe91ZdB8Up6Nt
         2GRg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+v5NzPU9d4e9bQ3NnVFKJS5XiISgPgF6kFb8PXwYlP/xmvTr4Pa4wae/mXevPVO0iPDvXWEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyssY32cS8GYSLOzHarE9SQt5U8Jp0HBjII+2ldDVJIiep7gTpQ
	914RqJUS9IY4SBG1s3vK44wHE16zuAVCIoU+dV3TLlFz+HSjcMEYTP36UpOuvQHawmbsz0pRUZs
	ycrEYd+FzoUbbveDoDu2n6qTqP8OERXAWrxTho3ewB9ftVoWued6+Gq10CQ==
X-Gm-Gg: AfdE7cnvy/6lbGrc4hT4nKWtkJzjI7gYNj0DBE77P/iiQOvjIQeGhSxMoBdxFTvA7ux
	78XQzdLalvo3idaKtFJTeevPYa92TNOZcasAeuUuPr79V32airr0eNbO9s9AlGmPdEzvQpprhKJ
	3RJnhTYk+nIKWjpfBzW5xoRxt9DQrfzcARtWRQmf4hEZmg/67X62XBmvZDdCSwoCKswHVy/FwN3
	EIhsW+etf46rHABMzeNq8AkUgiWYnkvcdyYavYlovwIpibu6sUYtkeBeZrkofORtEohxG3abcfn
	uly8FfHOebOYBgCkTBHemYnH3gbGm2oJVVYbOIZDslJEyM0Encedno/ulX4SoT6Un3TXbamSmo7
	VKA++MtBO
X-Received: by 2002:a17:903:19e7:b0:2ca:73aa:b48f with SMTP id d9443c01a7336-2cbb9ec43cemr65027805ad.35.1783266826963;
        Sun, 05 Jul 2026 08:53:46 -0700 (PDT)
X-Received: by 2002:a17:903:19e7:b0:2ca:73aa:b48f with SMTP id d9443c01a7336-2cbb9ec43cemr65027605ad.35.1783266826464;
        Sun, 05 Jul 2026 08:53:46 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm34473835ad.13.2026.07.05.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:53:45 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Matvey
 Kovalev <matvey.kovalev@ispras.ru>,  Pavel Zhigulin
 <Pavel.Zhigulin@kaspersky.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] qede: fix off-by-one in BD ring consumption on
 build_skb failure
In-Reply-To: <CAAvyFNjLcVRQBuMsd31neQpo6BY4HBP-hNMHh=RtFeiWBo96ZA@mail.gmail.com>
	(Jamie Bainbridge's message of "Fri, 3 Jul 2026 09:55:40 +1000")
References: <20260630164623.3152625-1-syoshida@redhat.com>
	<CAAvyFNhY2Jp5aH6YPrtfc0mBpwuSeT-8u8bODqq=pootpQffmw@mail.gmail.com>
	<CAAvyFNjLcVRQBuMsd31neQpo6BY4HBP-hNMHh=RtFeiWBo96ZA@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 06 Jul 2026 00:53:44 +0900
Message-ID: <875x2te8l3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304788-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[syoshida@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jamie.bainbridge@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matvey.kovalev@ispras.ru,m:Pavel.Zhigulin@kaspersky.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jamiebainbridge@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syoshida@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B99270A82C

Jamie Bainbridge <jamie.bainbridge@gmail.com> writes:

> On Fri, 3 Jul 2026 at 09:52, Jamie Bainbridge
> <jamie.bainbridge@gmail.com> wrote:
>>
>> On Wed, 1 Jul 2026 at 02:47, Shigeru Yoshida <syoshida@redhat.com> wrote:
>> >
>> > qede_rx_build_skb() and qede_tpa_rx_build_skb() do not check for a
>> > NULL return from qede_build_skb(). When it returns NULL under memory
>> > pressure, the functions still consume a BD from the ring before
>> > returning NULL. The callers then recycle additional BDs, resulting in
>> > one extra BD being consumed (off-by-one). This desynchronizes the BD
>> > ring, which can corrupt DMA page reference counts and lead to SLUB
>> > freelist corruption.
>>
>> Good catch.
>>
>> Reviewed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
>
> Sorry for the double mail.
>
> I believe the Fixes: should be against the problematic original code:
>
> Fixes: 8a8633978b842 ("qede: Add build_skb() support.")
>
> because that is what you are fixing.

Thank you for your review.

The problematic code was introduced in commit 8a8633978b84 ("qede: Add
build_skb() support."), so putting this in the Fixes tag would be
correct.

I'll send the v2 patch with the modified Fixes tag.

Thank you,
Shigeru

> Jamie
>
>> > Commit 4e910dbe3650 ("qede: confirm skb is allocated before using")
>> > added a NULL check inside qede_build_skb() to prevent a NULL pointer
>> > dereference, but did not address the missing NULL checks in the
>> > callers, making this off-by-one reachable.
>> >
>> > Fix this by adding NULL checks for the return value of
>> > qede_build_skb() in both qede_rx_build_skb() and
>> > qede_tpa_rx_build_skb(), returning NULL immediately before any BD ring
>> > manipulation.
>> >
>> > Fixes: 4e910dbe3650 ("qede: confirm skb is allocated before using")
>> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> > ---
>> >  drivers/net/ethernet/qlogic/qede/qede_fp.c | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
>> > index 33e18bb69774..c11e0d8f98aa 100644
>> > --- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
>> > +++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
>> > @@ -765,6 +765,9 @@ qede_tpa_rx_build_skb(struct qede_dev *edev,
>> >         struct sk_buff *skb;
>> >
>> >         skb = qede_build_skb(rxq, bd, len, pad);
>> > +       if (unlikely(!skb))
>> > +               return NULL;
>> > +
>> >         bd->page_offset += rxq->rx_buf_seg_size;
>> >
>> >         if (bd->page_offset == PAGE_SIZE) {
>> > @@ -812,6 +815,8 @@ qede_rx_build_skb(struct qede_dev *edev,
>> >         }
>> >
>> >         skb = qede_build_skb(rxq, bd, len, pad);
>> > +       if (unlikely(!skb))
>> > +               return NULL;
>> >
>> >         if (unlikely(qede_realloc_rx_buffer(rxq, bd))) {
>> >                 /* Incr page ref count to reuse on allocation failure so
>> > --
>> > 2.54.0
>> >


