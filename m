Return-Path: <netdev+bounces-71682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F00B854B21
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3471C20DCA
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897AC54F9C;
	Wed, 14 Feb 2024 14:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4654F9A
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919810; cv=none; b=toFdvNmHhsXou0CN6jumo+n/suNiBlCa2aLZZJLriB/S9AGAbddbmFQvqlpnSWm5SnuwjM1OouY4LRSphoeIm0KAO9cEc3AyNWcTXVvT4WSZNSh38MPI90hgV0jh7+A1LTX+4UO68sVOGyvibThULSlldy3zbNGFIAhL/2kBckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919810; c=relaxed/simple;
	bh=LAazaHNIj0ee7XqNCaczYx2h6tdz9Gilw28DtSQ2HbE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c7B8esPn4YjGUQqoMK4MqmThfkxT60lbrfqiHzEhNUMus0rG2tIXhRxJrW/UUZrX5o0A1KjjUo1Ag/G6g4PZT16SeS0mcWEpXHrzAPl2TgVm/2fm3A11j64rdob/B/W61LWLPI9fNq3DxGVmr2n4EhnuWLGSc21ttntJFgu/P/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inf.elte.hu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inf.elte.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-411f01e496cso3823675e9.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 06:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919806; x=1708524606;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAazaHNIj0ee7XqNCaczYx2h6tdz9Gilw28DtSQ2HbE=;
        b=TqXWK9aCK5kiLhxZCBtQMMD4GI/htUCAtr2NMcZjujSyOBH4dgMPUydIZmj61Jk4re
         90nYLQMX12Px8vPENt/yxAdhrMsZDhpgGOblP1t7ud5QSbgw24AbJ/STI/ZWT8AAx2Ca
         FgoV07mQdVZ0TeIPATRKxPF8vIdDM90l14687du8YMY8RYn7VRDvcYI1tjbrS+tGcER3
         0t9BYuuRJ6s5YlJ0+QX52cTxWiwulrN1/loeunIB34vM+SzolJLOO3V5BIWYRnXQ38zV
         QnyxLBUCPhSbhxrRFSWkYY+boiguXdO+aKIiu+4tICsnag1KS0PmvmMsdxB3/eEKJF/P
         xwgQ==
X-Gm-Message-State: AOJu0YxQaHL3e1cr5HpHF2JtFXR3KbSleoTn0iHgccRzIAf5NTMWny1K
	RZrthJ4ioTyIOk9kZ5PkAoTIbNa3+Ezgkza7ZsE32QGYuR273exRQIA97fevj5k=
X-Google-Smtp-Source: AGHT+IFYDUXZ9TldTqy87FwCLuoevDU3oYwwUW1Mg2LdmtITI0eqn1wDSXWZatrdDgPMdsuWK4+4pA==
X-Received: by 2002:a05:600c:500d:b0:411:fbfa:959f with SMTP id n13-20020a05600c500d00b00411fbfa959fmr488518wmr.27.1707919805659;
        Wed, 14 Feb 2024 06:10:05 -0800 (PST)
Received: from [10.148.81.47] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id js6-20020a05600c564600b00411fdf85d44sm439482wmb.37.2024.02.14.06.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 06:10:05 -0800 (PST)
Message-ID: <96cd774949773039b078d8c6367d58161bf27dde.camel@inf.elte.hu>
Subject: Re: igc: AF_PACKET and SO_TXTIME question
From: Ferenc Fejes <fejes@inf.elte.hu>
To: netdev <netdev@vger.kernel.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Kurt Kanzenbach
	 <kurt@linutronix.de>, hawk <hawk@kernel.org>
Date: Wed, 14 Feb 2024 15:10:04 +0100
In-Reply-To: <bc2f28999c815b4562f7ce1ba477e7a9dc3af87d.camel@inf.elte.hu>
References: <bc2f28999c815b4562f7ce1ba477e7a9dc3af87d.camel@inf.elte.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Small correction

On Wed, 2024-02-14 at 15:00 +0100, Ferenc Fejes wrote:
> Hi,
>=20
> We are experimenting with scheduled packet transfers using the
> AF_PACKET socket. There is the ETF disk, which is great for most
> cases.
> When we bypassed ETF, everything seemed ok regarding the timing: our

this was meant to be "when we NOT bypassed"

> packet received about +/-15ns offset at the receiver (now its the
> same
> machine just to make sure with the timesync) compared to the
> timestamp
> set with SO_TXTIME CMSG.
>=20
> What we tried now is to bypass the ETF qdisc. We enabled the ETF
> qdisc
> with hardware offload and sent the exact same packets, but this time
> with PACKET_QDISC_BAYPASS enabled on the AF_PACKET socket. The
> codepath
> looks good, the qdisc part is not called, the packet_snd calls the
> dev_direct_xmit which calls the igc_xmit_frame. However, in this case
> the packet was sent more or less immediately.
>=20
> I wonder why we do not see the delayed sending in this case? We tried
> with different offsets (e.g. 0.1, 0.01, 0.001 sec in the future) but
> we
> received the packet after 20-30usec every time. I cant see any code
> that touches the skb timestamp after the packet_snd, so I suspect
> that
> the igc_xmit_frame sees the same timestamp that it would see in the
> non-baypass case.
>=20
> I happen to have the i225 user manual, but after some grep I cannot
> find any debug registers or counters to monitor the behavior of the
> scheduled transmission (scheduling errors or bad timestamps, etc.).
> Are
> there any?
>=20
> I am afraid this issue might also be relevant for the AF_XDP case,
> which also hooks after the qdisc layer, so the launchtime (or
> whatever
> it is called) is handled directly by the igc driver.
>=20
> Best,
> Ferenc


