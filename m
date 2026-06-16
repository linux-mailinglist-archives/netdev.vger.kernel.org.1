Return-Path: <netdev+bounces-299794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lLbSLCIcMWoCbwUAu9opvQ
	(envelope-from <netdev+bounces-299794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:49:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3072C68DB2B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:49:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=M17Yq3Y4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299794-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299794-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0252930160DE
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66160421EFF;
	Tue, 16 Jun 2026 09:49:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE14218A3
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:49:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603356; cv=pass; b=B26W25PfEMdE8utkyPEJvaHNWOqZ/kC/+AEe0KdpKHN0YNMgEXhxb0IIlkGplGdDUPHPKVSKqhIh7mds/vRw/nH/PTP2AxIl478kurXwBo4xZioxdKunMiA/edZtIs5Y/0/Ufw5bqNszGp0Lvwvh4h7+LKl/93KyL8CVyl2eVb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603356; c=relaxed/simple;
	bh=QjEqLU00etgxuyHhjOjo1O1DD6A8WJ0GvFeC5XpYtfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpCG3tsrUo6GgnpvJV+qskHSq+yDZJQQ1z5eSoIWxAEFesMRn2g+wyfnLPm0pccSutHMlxNHDE9drEjHsrUVMGgA1a2mRA92Pt8Jko7ubCWxMYdqtjbAkUSb7L9IHMLu4XysU+5JuH01WwdZP5R9/0ig0Fpuh+1F6wVoXva/ETc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M17Yq3Y4; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5177d1ff061so52721cf.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781603354; cv=none;
        d=google.com; s=arc-20240605;
        b=k5vaMPdxzJbESlGQDBvSkZHn43cMbho2x13aPg7Z87jrjKbL3oTDK69BfMUtmn67I2
         TlM0MFIMXZuJKP0RI0yCL3ckdyTGzBAhOYbpS0o+nahdCRH3wQbtRTKoa37Nwevy4gxI
         FyHgKjh8e/y8z0EFpev/PmNHFEQYQEfnhP6iso0G+c1kogLuKjHHd/HE3EtJhmXyYJmM
         4Gcc5RyJJu9Y+KDeFA16N+r84EafcWYkBSleMiF8gb4erbwxYGm4czZ+HeGDfpr0LeJi
         SgFyjyQuhdM/WYD1zuSR1MIQ1crVqBm7cKcY8BASS7nw4TKViAfeFRWKN8URBAfbut2l
         bppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2/X+IQDU5vWc0Utt9YT+71W3AhmdLwN2v6pALPN9Aqg=;
        fh=LNg0vabHBE1uydGeCoY5v0Pbm/6aiGEvXftMmGf22DQ=;
        b=Cq3KQn3QolfDAzYtJKPBKnGIQ7RsfwR6P2lKf5knSnRDaZjskhANHd0LXVYDnS8+Kw
         sYripZXot8myiFc3bd7SlAjgm+4Lo1iBIA6zjv25VQEdPWMwAP1ai8wIL5uttUubgKo7
         AnzPleCzgiFYRn1UYPiwygU07wljKfN/UIxSTW3H6xLpsg4bQlac2y0G6+3DkVYb2lHc
         umdDQGrGmo88wn4UWmJz5H3X8+tAUhNCI45BSKeN39rMP5gEiktQoSyCgdgWNgbM/4g6
         WykkKneGa569TW1kye8pXztYXVovew6O8XCg5hLkjzzkN7H1K3b1qt0woTIFbJxRbAUH
         hcZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781603354; x=1782208154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/X+IQDU5vWc0Utt9YT+71W3AhmdLwN2v6pALPN9Aqg=;
        b=M17Yq3Y4DO6a6wbwA+tYgzro60asI45/mrkJxOg3CStold3/62T9XAtK7AC3wKOaZy
         oHH2z6bP+2d3xjgILsGKUx3DZipa7rR39nQCiN/0GidXfh4cqNNTEJmkr/NIKkOshMOD
         uMXd3GFSF/M2Tyd6XGBfUwjs3hMnCEmVxjxveBhq5+XWKlWGwlNoy0wq3KgiZ3EQs3Al
         lBRvLCY6mF9kx/OXOkbkjbBx1RCcIVt6LsGXjNbJ01g/YauXbWv9LbFXi5r6bH3xbThu
         dt08+iMGyXNitZ6kMkr7Oyo7c4y81M8/j+Id5FZ1fPIVASsn1Y3llEkJtgTvePi/rGUd
         QRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781603354; x=1782208154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/X+IQDU5vWc0Utt9YT+71W3AhmdLwN2v6pALPN9Aqg=;
        b=fEkyO2zGVgLpxjC7UtfAyx+BeRnMtq316jTx3g1c8gAI7HmB7OU8Kgh9ftJLwMsOqq
         tnIx/ciRVIlYHCxkwvo4UCE5Wfd5Exl+K8scTfP8bexeTBO/Gg1NOzwT9Z/viEcVkoAx
         B1tQD6qLr1op/wsqJwbtdojcHyhW9eBKW/EjfTzt4bfSZ4bAsuU2ozRg8INRJu/hOM6J
         AhZtd+MEEdOZLGiVEaXDXQGFIAeJbBZqZQfGSqcrIrxPlEbWnhAG6z2SBtTqwT+egMqe
         pK92lcxm8+aTltycDQEBBfYOfLmPUUz1TXkYJYSdaEExTZqagqtVb0q6Srek0deZmdhn
         hv/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8bN7IhMqsLdXmz9Yk1xKJNNSMV1pYI9rW5k4nqBy8JJ6zM2figg3oumC6nqXCjlXVKnHt+j28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyMDPElFU7q/3pOJAFCnJp4Q//VHAaZ3zJs1v/IGAPcEyn5kzs
	Vzg9b/7HB8ORLniILhU0CtadhdCW+efP48BCDYJLkogTMwqi/hCIHLYab3aluvAV+akQvWL1Chl
	a9GFxfIqpYhyU+lGK/q1KmRoX3mDVesJXzGbokwAs
X-Gm-Gg: Acq92OHqs5BEy9/baY4yAdJzZEzE5hn24HJedFJwVQC2gObWeYDTR/xn4BjP2bCXUNx
	s2Jz5jzYV9RbH6kin1e74dsv0yx68x7rqYw06/W4I0bZTCabqm5TkfRjg7ufXWX94g+HKKF+jQG
	I1KlVpEVIhLH7QMp8NfmRiLFntu8G/EDymYBNIWuvZ4VdjXGFxIPz4QiOhpzNwMR+8AZa/53fbb
	1K2kMdkzwxdMJF6oBHvPDrGzUvY+/6emjX2sW1p0ey7Ww+zSDkXl/cttQNI+onw+NY3JH9Z3+Rz
	8CTqLaTS
X-Received: by 2002:ac8:7f83:0:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-519904708a9mr8164151cf.16.1781603353313; Tue, 16 Jun 2026
 02:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <ajESl4osXP7roz5q@pedro-suse.lan>
In-Reply-To: <ajESl4osXP7roz5q@pedro-suse.lan>
From: Luigi Rizzo <lrizzo@google.com>
Date: Tue, 16 Jun 2026 11:48:36 +0200
X-Gm-Features: AVVi8CcHZ3OPXbKC4trSPNuaSPbYaO79J7ToG8S7bAu191E2DonWT9FNgV4gu7M
Message-ID: <CAMOZA0+L2+=FEQ5ORvv07JaJix0R+6Q6u01CyMKCbd842To9nA@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
To: Pedro Falcato <pfalcato@suse.de>
Cc: rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	willemb@google.com, kuniyu@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, akpm@linux-foundation.org, 
	david@kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:rizzo.unipi@gmail.com,m:m.szyprowski@samsung.com,m:robin.murphy@arm.com,m:willemb@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:netdev@vger.kernel.org,m:linux-mm@kvack.org,m:iommu@lists.linux.dev,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:hawk@kernel.org,m:ilias.apalodimas@linaro.org,m:rizzounipi@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299794-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lrizzo@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrizzo@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,samsung.com,arm.com,google.com,davemloft.net,kernel.org,redhat.com,linuxfoundation.org,linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,linaro.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3072C68DB2B

On Tue, Jun 16, 2026 at 11:20=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> w=
rote:
>
> (+cc page pool maintainers)
> On Mon, Jun 15, 2026 at 11:42:20PM +0000, Luigi Rizzo wrote:
> > The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> > especially with greedy senders, this has a high chance of happening in
> > the softirq handler for tx network interrupts, creating a significant
> > performance bottleneck.
> >
> > Allow tx sockets to allocate socket buffers directly from the bounce
> > buffers. This avoids the second copy and removes the above bottleneck.
> > The fraction of swiotlb buffers allowed for this feature is set with
> >    /sys/module/swiotlb/parameters/zerocopy_tx_percent
> > (0 means disabled, 90 is the maximum, to avoid persistent I/O failures)=
.
> >
> > Implementation:
> > - define a new page type to unambiguously identify bounce buffers used
> >   as backing storage for socket buffers
> > - modify skb_page_frag_refill to perform the modified allocation
> > - modify the destructors __free_frozen_pages(), free_unref_folio() to
> >   handle those pages and return them to the pool.
> >
> > The savings are especially visible with fewer queues. In synthetic
> > benchmarks, senders with 1-2 queues would cap around 50Gbps with
> > conventional swiotlb, and reach over 170Gbps with the feature enabled.
>
> I could be wrong, but I genuinely think that the way to go about this is
> using page_pool for regular TX as well. page_pool pages are all dma-mappe=
d
> (so whatever swiotlb optimization you want can be done there), and the ne=
t
> stack already has awareness of these special pages and special skbs, so i=
t
> won't Just Return Them back to the page allocator.

I am not sure I follow your comment above, can you expand/clarify?

The problem I am dealing with is that the copy from the socket buffer
to the bounce buffer is done in the device xmit function. Under high
it is almost always done by the tx softirq.
This means that even if we move the copy outside the HARD_TX_LOCK(),
it would still be almost completely serialized.
Hence the proposed method to make skb_page_frag_refill() allocate
directly a bounce buffer (under specific conditions) so there is a single c=
opy
done directly to the dma-able buffer, and ii is done  in the user threads/C=
PUs
and is not seriallized in the softirq thread.

I am not sure how page_pool on tx could help here.

cheers
luigi

