Return-Path: <netdev+bounces-272816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xNH8JUE1yGn/iAUAu9opvQ
	(envelope-from <netdev+bounces-272816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:08:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0734FE6E
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A22300C5AE
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 20:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B39330D2F;
	Sat, 28 Mar 2026 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTYzXAN4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLugGFVT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCBEEEB3
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728416; cv=none; b=nKvqqyThD5tr01Br/MHd/09K4pHao0fI+9EfLIuojKhWEtrzESz74b/IraXe+9tNMzLBVKrQN9GPaQG3/Zgf+ZtbUKxiieN5FycLxBbjD3Olo042gXIH650oAomuM5fG1gvK732hmRvI8wQ95kX4aZSjKq9Xu95M2D9ceEBvjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728416; c=relaxed/simple;
	bh=bGOadoblnU96HDigSkK7llNOmUI4XGEi05y/xucO2Fc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pfTVU4YyEjafhCPewejc4cWFcky+hU/snFhZp1Lanigp5BDEskLiFqxdBq0O9V3t+sfNeWmbgcTMLrR1UaSpRUnp7IOfrwm8tiWgV89dcWp0Y1meCnMzpv2JUw67Nio9ieQIKcUvswA+zezePHk8wm3yn/ASBmMAkgSs0vZ62so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTYzXAN4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLugGFVT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774728413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LloPA85Nqff5cq7+bKoEOXpAMWpx0zeVTOibPMT674=;
	b=MTYzXAN40+8RjQuokGZe+V48UI9Riwa2LFcppkXox6TT/2q9UQv7BM58Sg46d1ZN9u7HgR
	JzfayL7v0V56IR0Vec7NhADF4WS9gnax020P+jvZmd5k4jhFhqPKp1rGuWn3Erx5wIYC/T
	XAcMqT+pXXwb1f1h/9eRqHms/BpqHyw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-RXcrmgxJNUSKLUlOnc8O6g-1; Sat, 28 Mar 2026 16:06:52 -0400
X-MC-Unique: RXcrmgxJNUSKLUlOnc8O6g-1
X-Mimecast-MFC-AGG-ID: RXcrmgxJNUSKLUlOnc8O6g_1774728411
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48532df52c5so29669635e9.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774728411; x=1775333211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LloPA85Nqff5cq7+bKoEOXpAMWpx0zeVTOibPMT674=;
        b=fLugGFVTPmqMjrHUcXHLJCcCCTAeO9QV9IxhRdP8mLlHQDNabHuokQuIHWooxBrwwd
         rICjpoSq4SsdYjTBw95WgVy1R2/dvLaIndVbeKia6zN8M7iV4TLQlPCu0fO6Hyg6MmfF
         4kLVtyg74OtZaGZINozm1JkSrW6nibsieqfnyYlmlWM52TysHrKPYSLNxERLWvVy9bbB
         e2Dpu77B/zgomBG2CAUJruS2O46FQPvmIcYsX5i0LLWx/ZCBFF3pBQv0zZ5/kouZMaXm
         5rJl/DyEu2YBh2vSp7VG/IPGlbJYEuqhOHtNuZtqOpX/Piy9vLjar7hBKrnxaAwnsliI
         ie5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728411; x=1775333211;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8LloPA85Nqff5cq7+bKoEOXpAMWpx0zeVTOibPMT674=;
        b=EC9bE+vBP9gOeeCNPjkL5QamihhsueXRySydBO2DDxhUdcoztBHJJXN61RbVN7F3XG
         4UAmgmp4Jz0FT29lgAX61xfPyoEc6Dh/t7LQNnDIFKn2MfAKXomUeXJi3pk73dz2QGrw
         YVQmHe/ovYr/5+re0hKgCrIxM4WiQI3cP6yItbFGBhz3velTxOoiau0+nqPLaNqeEUX7
         IT1zTaJbA6coXP0EAPsPeT0+tlqoPAMDqdjdxWLwh3WC3u8Su4RHKgYQL6iBN2nMQ9zX
         JjHBsGSDp0TyGVCeewVRLNEKzBGNlljrDCByzmWH1j2akOokKip12SZ9GOaWvXgHeIka
         lBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfbmTpdAkSsQJhxyvm36GN5Su6QV0tYAbhCnsNygls6W5W3O9pNp6C0B2/AbxKN88c13nYJtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXq3FK5D2nI4y4OVcBO8q8PKG5PyYaVtpAom2S4KfM/cIZMSza
	ipi5lb9H83m5uF/qCV6/5nQ+YeHT28ODjMj+DnB1OBvM333WyzgnNUVKrVdLFTXvjlqUJ6uNtyl
	ndcyASBiC+0qMa+cJccNuPa65Eo966DZ6o+MWPuQjpCxNLVONyX4fapblWg==
X-Gm-Gg: ATEYQzwnPQ6c+kEBpt/xX5JhNUYtamq3JQFjIHjFUjYPtLFvyXh3NKw7V74KaPHTEZl
	+QHMItOxp3fWA1cpPFTvYOoZPV3Ng3vVlJn3U4Mk/O4Fp1pSHF+3ZaUY6GR14HZhWlnkB4avf8+
	9m2at4w32bTn+4RHVkIghuwlbmviFnRa0O3oT+kDAiPwLvpBxVKNmyqcW/SBRZfQuSHGgMh+COM
	rTGugHR56yQ4cAvz/ca6Fghg8d5khCTJ3QIl3zy9MjcBoejbZqncbLuiKr1Mc6WJ4rCX+sk6f68
	Tmf58cEHmsdDmhE8SMChxqKgAhibVE0LyBEidkIxkAZOJVm6wETjA3G2UrXl3Mcj2UtLzurRZpa
	164iJ7TVmx7LcA0JJInA/5hY0sk4Xkre7TkmeEcJDW15apw==
X-Received: by 2002:a05:600c:828a:b0:487:338:b4df with SMTP id 5b1f17b1804b1-48727d8818cmr110534005e9.15.1774728410544;
        Sat, 28 Mar 2026 13:06:50 -0700 (PDT)
X-Received: by 2002:a05:600c:828a:b0:487:338:b4df with SMTP id 5b1f17b1804b1-48727d8818cmr110533625e9.15.1774728409957;
        Sat, 28 Mar 2026 13:06:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d23679sm321974575e9.9.2026.03.28.13.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:06:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0BF395FF9A5; Sat, 28 Mar 2026 21:06:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, Jesper
 Dangaard Brouer
 <hawk@kernel.org>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, kernel-team@cloudflare.com, Chris Arges
 <chris.arges@gmail.com>, Mike Freemon <mike.freemon@cloudflare.com>
Subject: Re: [PATCH net-next 0/5] veth: add Byte Queue Limits (BQL) support
In-Reply-To: <7d404bd3-4444-464e-8831-c8304ecf5b40@tu-berlin.de>
References: <20260324174719.1224337-1-hawk@kernel.org>
 <87h5q1d2j9.fsf@toke.dk> <7f00346d-5dc6-421b-8d61-75c1c3898c30@kernel.org>
 <7d404bd3-4444-464e-8831-c8304ecf5b40@tu-berlin.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 28 Mar 2026 21:06:48 +0100
Message-ID: <87bjg7d8h3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.07 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272816-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,cloudflare.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tu-berlin.de:email,toke.dk:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 13E0734FE6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de> writes:

> On 3/27/26 13:49, Jesper Dangaard Brouer wrote:
>>
>>
>> On 27/03/2026 10.50, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> hawk@kernel.org writes:
>>>
>>>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>
>>>> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
>>>> latency by dynamically limiting in-flight bytes in the ptr_ring and
>>>> moving buffering into the qdisc where AQM algorithms can act on it.
>>>>
>>>> Problem:
>>>> =C2=A0=C2=A0 veth's 256-entry ptr_ring acts as a "dark buffer" -- pack=
ets queued
>>>> =C2=A0=C2=A0 there are invisible to the qdisc's AQM.=C2=A0 Under load,=
 the ring fills
>>>> =C2=A0=C2=A0 completely (DRV_XOFF backpressure), adding up to 256 pack=
ets of
>>>> =C2=A0=C2=A0 unmanaged latency before the qdisc even sees congestion.
>>>>
>>>> Solution:
>>>> =C2=A0=C2=A0 BQL (STACK_XOFF) dynamically limits in-flight bytes, stop=
ping the
>>>> =C2=A0=C2=A0 queue before the ring fills.=C2=A0 This keeps the ring sh=
allow and pushes
>>>> =C2=A0=C2=A0 excess packets into the qdisc, where sojourn-based AQM ca=
n measure
>>>> =C2=A0=C2=A0 and drop them.
>>>
>>> So one question here: Is *Byte* queue limits really the right thing for
>>> veth? As you mention above, the ptr_ring is sized in a number of
>>> packets. On a physical NIC, accounting bytes makes sense because there's
>>> a fixed line rate, so bytes turn directly into latency.
>>>
>>> But on a veth device, the stack processing is per packet, and most
>>> processing takes the same amount of time regardless of the size of the
>>> packet (e.g., netfilter rules that operate on the skb only).
>>>
>>> So my worry would be that when you're accounting in bytes, if there's a
>>> mix of big and small packets, you'd end up with the BQL algorithm
>>> scaling to a "too large" value, which would allow a lot of small packets
>>> to be queued up, adding extra latency (or even overflowing the ring
>>> buffer if the ratio is large enough).
>>>
>>> Have you run any such experiments?=20
>>
>> Thank for bring this up.
>> Yes, we have considered this (and agree).
>>
>> Jonas is conduction some experiments.
>> I will let Jonas answer?
> Hi,
>
> I used the provided selftest, modified so that the payload size alternates
> between 1400 bytes and sizeof(struct pkt_hdr) =3D 24 bytes every 5000 pac=
kets.
>
> The receiver was slowed down using 10K iptables rules. I could confirm th=
at
> the receive queue filled up to ~66 packets, whereas the BQL limit is arou=
nd
> 2884 bytes, corresponding to approximately 2 x 1400-byte packets.
>
> I compared two accounting strategies: using skb->len vs. a fixed size of =
1.
>
> Ping results over 5 runs using skb->len accounting:
>
>  =C2=A0 rtt min/avg/max/mdev =3D 0.636/2.784/ 9.543/1.735 ms
>  =C2=A0 rtt min/avg/max/mdev =3D 0.629/2.947/10.587/1.927 ms
>  =C2=A0 rtt min/avg/max/mdev =3D 0.587/2.966/11.625/1.963 ms
>  =C2=A0 rtt min/avg/max/mdev =3D 0.589/3.006/10.694/1.979 ms
>
> Ping results over 5 runs using fixed size (1) accounting:
>
>  =C2=A0 rtt min/avg/max/mdev =3D 0.587/2.446/6.261/1.065 ms
>  =C2=A0 rtt min/avg/max/mdev =3D 0.641/2.339/6.008/0.950 ms
>  =C2=A0 rtt min/avg/max/mdev =3D 0.688/2.527/5.506/1.086 ms
>  =C2=A0 rtt min/avg/max/mdev =3D 0.596/2.411/5.228/1.041 ms
>
> The avg and max RTT are consistently lower with the fixed-size accounting.
> This suggests that the excess buffered packets contribute to some
> latency.

Right, so this sounds like fixed-size accounting is the way to go, then.
Cool :)

-Toke


