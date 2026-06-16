Return-Path: <netdev+bounces-299813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iA3CBWsuMWqydQUAu9opvQ
	(envelope-from <netdev+bounces-299813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:07:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D168EA30
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:07:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=s0dDammC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299813-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299813-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F650300514B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DC142EEBE;
	Tue, 16 Jun 2026 11:07:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2122F3CBE8B
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 11:07:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608025; cv=none; b=pBPj1EZ7+QVo0JmH0S8ITYZC3ZLBC2EHVu/kvsnmZF16lG1XnVfAwG/CJAQzpvNTZMw1uP8GitVDOcH3peqjT2jnzVW9MNCMOYyYeCveCSCYzJGMXPEq+1aeyjb18CRsUpdPp+93DtJPLIDC7JlzM7iqS86MXPw5eZskTxS9hQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608025; c=relaxed/simple;
	bh=8L7LN5GWKaXLjw308PhIswoJMOtulW5cOuUEITh9aLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhg8IhD/8r8O+Riwq+rfryG21Ls7Mhu6ztj7nP2aTl0NQr5n7V5eqEPBfXpsHsXkX1UeHw0VA0HFTd/iHHqXOiajx/Uz5Nh+0NVITbK5QlSOJTWwlB9hwBpV4ibfnNwNsPj2qDDegqboSPn2saCUQc1+h68uCb77MC4VP+w8ag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0dDammC; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso44265e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781608022; x=1782212822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJ3fUZ+/EYmTkDXUK4ZNvux/ajtwZf6cg0AECRGmMnI=;
        b=s0dDammCBCw6WQnhJiLaI5FSDeCMnXGJ/V7Htq9NOoieO5xbrJ0d5WAfbAJmpiuHlb
         vgXDnLkT0H+yGynRrxSohSposzVOdjBV1XV2yB0oz9RQNX82FG900JTUiKfNmWG1tEVs
         EwT05VVo26DFdu3cntCQM+ZRwHnXaT+a2n1ptFfnx+O1gZCEG3NbT1jlaWt8NbY8Nw3R
         kHlM3+qrspfscti8TWIvs9Jj5klAfStgA1GUCFfkkgOnYdckm4Gs+PEUz1zNbsDQyjq8
         FaEmkueTkkDjLGECDitqGDjkvCYY8jDaKXf9q84g7Ezj8fzECCNj1MwNvLrJXmkgzrm1
         w8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608022; x=1782212822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ3fUZ+/EYmTkDXUK4ZNvux/ajtwZf6cg0AECRGmMnI=;
        b=bT9ATdUbrO+2TTJFWzUY5FXhRH4s6i4wImyIQji0PsmkdiyLul6O4i4Qer8q5WEBXR
         XqRWJD0fTM/XQUpobDIM5EH1bKd7SUaKc23ZvuAexnG6ltvMDM/s/ah5Qx80tLizXAm4
         EPXUa0wmUhupkKfrq+8ydjkpgImTdzLwc/4OJaSAPrTNQ5NM7YhfgjS5ds38IgBQacDk
         XKsUfDrYSVavcBbmXOarfkAwJQTkBPVnGs05OXAg5nAa/KPRLwKCTGzcDonj2nsAFBTn
         87HSvsWBA0Raz05BCQ7CXjLeVi+LrCwbBR21OP3wsX2k0ffq+tfPakTwzwRxNHLQB9L0
         9IPg==
X-Forwarded-Encrypted: i=1; AFNElJ+3KH2uKEYABdxZkFBcWgmk44cQhJPOgV5CdrlPXdbCacHubjzKXpcxsb8LUxrIuP+MXBmcyqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KeFcEDsh0KQ0ivE/Frc2kM2vCWuHuzrjaDrBGLJb/N0HgPoB
	nI3PBH5E66oab8WLCBsZaoOcRsOJiY+vld+3b/VbJyVrQ4AIB0kV8g8EhLB4cG4EdA==
X-Gm-Gg: Acq92OEez2LDe8yuDKnE1FSnsbSUOxplHTcY99CgTK+esQHAl5ChYrqoxDFsqu0Q/Iq
	V7sb6OK+WUxfBnoaq/rDoWNbX6OG9ZBags5b0YYKDmrcG8+66+teMNdXbyJl+HkUHt2eFZ9PChb
	EtKyCg5g7GFBZuzzUE3srSRmKz1K6ndR+PDaRC7E2B+LtndyFZNucfBQJB2APpov3M+IXEUkMOy
	joAhEhjE8JlMSv2MJLWHKqIjIOT89WynWzus6M4VkfnWrKkUf8SSiObyUUeEyFdsSBw7HAnhkg7
	5GYr3saWiQBiE0UMUoNzc0U6W20PlF2FduL4hPmM2ekE8J07esoH84C1wwA4v55zJQ6sgZonp+E
	UT68ZPx8lMhc5hqT2IGslWM4a4uvpBbcaA0yJISRjS+bWEO61+yqYmEevv26Jt6UkmKcL/JOk0k
	bt8EUGWsimnUPmr+5e2w44xlIVA+2jCQhwUI3DeczTm1tuAKHdWcLB5wgP5ZuAWQ==
X-Received: by 2002:a05:600c:c059:10b0:48a:5aa3:ac1e with SMTP id 5b1f17b1804b1-4923088e313mr879485e9.3.1781608022038;
        Tue, 16 Jun 2026 04:07:02 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26393asm46289637f8f.5.2026.06.16.04.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:07:01 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:06:57 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Luigi Rizzo <lrizzo@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, rizzo.unipi@gmail.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, willemb@google.com,
	kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <ajEuUZMgS_NRmDcp@google.com>
References: <20260615234220.3946885-1-lrizzo@google.com>
 <20260615172535.080cf94f@kernel.org>
 <CAMOZA0KAHKsvA9yRcdrjG13S+=rJhw-Cvnw2WdLjGGY0azG0kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMOZA0KAHKsvA9yRcdrjG13S+=rJhw-Cvnw2WdLjGGY0azG0kw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,samsung.com,arm.com,google.com,davemloft.net,redhat.com,linuxfoundation.org,linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-299813-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lrizzo@google.com,m:kuba@kernel.org,m:rizzo.unipi@gmail.com,m:m.szyprowski@samsung.com,m:robin.murphy@arm.com,m:willemb@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:netdev@vger.kernel.org,m:linux-mm@kvack.org,m:iommu@lists.linux.dev,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:rizzounipi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[smostafa@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E7D168EA30

On Tue, Jun 16, 2026 at 02:33:52AM +0200, Luigi Rizzo wrote:
> On Tue, Jun 16, 2026 at 2:25 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 15 Jun 2026 23:42:20 +0000 Luigi Rizzo wrote:
> > > The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> > > especially with greedy senders, this has a high chance of happening in
> > > the softirq handler for tx network interrupts, creating a significant
> > > performance bottleneck.
> >
> > What's the use case? I associate swiotlb with debug / testing mostly,
> > so it'd be useful for people like me to explain why you care.
> 
> Ah sorry, I forgot to mention.
> swiotlb is used in guest kernels for confidential computing VMs.
> Ordinary memory pages are encrypted and the host or devices
> have no way to decrypt them, so the kernel must use
> unencrypted bounce buffers to exchange data with I/O devices.

I started looking into the same problem recently, to reduce the
bouncing in protected KVM (pKVM) confidential guests.
My first attempt was to update dma_direct_map_phys() to skip
bouncing and do inline memory decryption (for pKVM that is a hypercall
which updates the stage-2 page tables), however, that was really slow
compared to the memcpy in bouncing even for massive pages.
My conclusion was similar that we need to solve this at construction
by making this memory allocated from a pre-decrypted pool (which
does not have to be part of the SWIOTLB)
My initial idea was to teach some of the kernel subsystems (SKB,
BLK, SLAB) about "CoCo allocators" that allocate decrypted memory,
as this is not a net specific problem.

I am still looking into this, I was planning to bring this up in the
upcoming LPC.
I will give this patch a try. However, I believe that we need a more
generalised concept for CoCo pre-decrypted allocators in the kernel.

Thanks,
Mostafa

> 
> cheers
> luigi
> 

