Return-Path: <netdev+bounces-304018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ssvpGbgaRmpHKAsAu9opvQ
	(envelope-from <netdev+bounces-304018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:00:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2A66F485E
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:00:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gDp6BZjf;
	dkim=pass header.d=redhat.com header.s=google header.b=Tohd8Dir;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304018-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304018-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E3FB3154CA7
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE2D3A6B9C;
	Thu,  2 Jul 2026 07:42:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177D3AC0FF
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 07:42:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978163; cv=none; b=CloBpq+sM0dpiMzAizRVQ/gX5IhnGnJVQLL9Srpzp5HYxn9IuT+Appk4kMR7aOO/8YrjE9DxmTBmEjLiWh8K10JRgkaeGyQzHItokDqNfIV9TtuOwO1BBHDTodrmdqwnYoDp0F6fWztrECmFhihO54UE2QiM8Uk/213vKBVtaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978163; c=relaxed/simple;
	bh=MkwN5dCd6L8NNAmC8fUcYgtdXfx35Yl1FYi/+AhzZ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuEYgYZYTOy+w3AbH3mp4HFxZ3n6KR0suBnGCrIqgCf+SBjdZdiNJGqF3g2D43l6AWRV8HoPjQTKB+8ooS7mcpRPzMqbRf0H1NiwDt5ZwoHzbD/Ih0Uq4Zj0FsA82oY9tkiJhMNLaj/4oUR+tE/aZw1b20NcGwNeHLAetFzNbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDp6BZjf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tohd8Dir; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782978158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dx5alYF7wM5OvYX9ux70YYfyYzEem5hU9USAOkUPmog=;
	b=gDp6BZjfVMI2YtQEXs42MQCWDbnTM26wvpNxAUNj4b/fSJ4cpMzCHJ6wJmXOY6F2QQKJhZ
	GaL/2ZtTCn62yJTe8D8+Gp3CUmOoy0mPy1GuiMtcW9B03Y5i2VAy2Y+lBYtouECLixGzSl
	Qk0RtB7kYLlSg453T9ypqvn3KbQesHw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-zPA7hVTwNgSDNf75CF0e9A-1; Thu, 02 Jul 2026 03:42:37 -0400
X-MC-Unique: zPA7hVTwNgSDNf75CF0e9A-1
X-Mimecast-MFC-AGG-ID: zPA7hVTwNgSDNf75CF0e9A_1782978156
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4744b72f90bso1020349f8f.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782978156; x=1783582956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dx5alYF7wM5OvYX9ux70YYfyYzEem5hU9USAOkUPmog=;
        b=Tohd8DirJSNf7pqE2cqyNRX9QELbfROtaaCtOOINxbuG+KOWcG6lKJ3KobOBnDaqEx
         ohnr6ScwoSiHB+9Hc63gk8qUXspDy79GrxNzMoRVLyLLjBQjQMNxUaNMj7ndBrI10Eef
         MyRtEd5uegG/sTZ/ekeTWM8iSzcv7DIgOqSH88itCI5PT8BkLzhaHVXHHToojxd8BMtS
         zWI7c7pXboAphh2odNVGYy28ZydluSdJ4eLE66ufRjGheYqx6kOtzSdsv3SRam/O/w7C
         3bQcaMbWpEOnHYox1yc/NIPzLHJs2xYESFcRed2wfwQjJN1xxh8D0Al17oTbFJpIbwyB
         jzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782978156; x=1783582956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx5alYF7wM5OvYX9ux70YYfyYzEem5hU9USAOkUPmog=;
        b=jJi9y7eTcdK+9676mvyv22hxZsCvPqBdR+jhUJR8cYZDaryjxoWwWoxis6OBWVe+gJ
         D2WlDOzpNxl3WQ4Rit1bddABjoBoh/0qKNT3zg6sUE/0CgiMrrDRDa+r1WNcIFgtxZIx
         0movmK3aoY7CNUjVVFAJxzG8G9RiqXimA/ckSKkViYdGimwoDyIxY/uTvqtthRzODxHD
         R6VWNR3qX+fTQwD8MqxxY4UOVpDLUfhTxMII14KhKFUxIV3FMjYVtrP/cV4UEOKHDxDY
         7KHa6/X9Qooe9WGPEh4pUPbw8pMFAJ090VNqWujfi39NLf9Ki/Rbg2mPhwELxukx+iBp
         W8bg==
X-Forwarded-Encrypted: i=1; AFNElJ9524PsesFy2OrECLYi1q2nxq5zuVBMZ13VW2IxogvQy/V4ODFQzBJuCPG27E08/uYqh+Vva0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaNncvDjZcqRf7qbxlMUQYEd08xgtrPp7YZr7/zmaNz5vsiVZ
	EXA6kdNmPqxRnqtjn/qFB+fLgY/MU/KWEl9xKDOsvf0TITk7T2nO24kVNl9wH6fhOUPQKDinJLs
	+O+ihS9H+V5DEyAL8bxtaVmq+xCayHdxl11Yo790h8DbmZVjUv0HbIswRqw==
X-Gm-Gg: AfdE7cm3OrkHWFoCWG0l5Iu/PRm1YOuXjrfRimUt+law3irdN0ydyGZCDuBR1YfPOXp
	fQ4rnGQhVYxG4pD1SA3B/OdC7rDNVA+gZBbU5B397CbIEOMLbdVaNUue90VmT+UCbWDm52EqSUq
	/DREchjMvY/Ujl6YkFV4Oj3jvtxnGC2qh2wPDjHZiA4u3Xk1kGfO7pZrcYFx7ZAOPIs66+c0zPQ
	51z4cuQ2nffQRPR5aLCNh3UXJvwUDZk4a1x5Q2F2E4+zApDVVWgvZGTnodmL8D1UOPVZ45kNGPF
	ADHTYx6aB6vCLaGJ7ajt8xWbZV+sWBL2z/JDEacBGwUSUw6oXll4gER3IRtm3CodFztvtwZ59ei
	ueIppMtGbqGC6AkCvK6uCy3JEn/UXqy8Z
X-Received: by 2002:a05:600d:c:b0:493:bfea:2780 with SMTP id 5b1f17b1804b1-493c2b442cdmr59747105e9.9.1782978155670;
        Thu, 02 Jul 2026 00:42:35 -0700 (PDT)
X-Received: by 2002:a05:600d:c:b0:493:bfea:2780 with SMTP id 5b1f17b1804b1-493c2b442cdmr59746625e9.9.1782978155014;
        Thu, 02 Jul 2026 00:42:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6375764sm24174085e9.5.2026.07.02.00.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:42:34 -0700 (PDT)
Date: Thu, 2 Jul 2026 03:42:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Brett Sheffield <bacs@librecast.net>, regressions@lists.linux.dev,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
Message-ID: <20260702034152-mutt-send-email-mst@kernel.org>
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
 <20260701165359-mutt-send-email-mst@kernel.org>
 <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304018-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[librecast.net,lists.linux.dev,vger.kernel.org,kernel.org,tu-dortmund.de,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:bacs@librecast.net,m:regressions@lists.linux.dev,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:tim.gebauer@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[mst@redhat.com:query timed out];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,librecast.net:url,brettsheffield.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D2A66F485E

On Thu, Jul 02, 2026 at 09:24:59AM +0200, Simon Schippers wrote:
> On 7/1/26 22:56, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2026 at 09:16:48PM +0200, Brett Sheffield wrote:
> >> TL;DR - Commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 causes
> >> significant performance regressions with TAP interfaces and multithreaded
> >> network code. Please revert.
> >>
> >>
> >> Librecast is an IPv6 multicast library. One of the tests (0055) fails under
> >> Linux 7.2-rc1. The test performs data synchronization over IPv6 multicast using a TAP
> >> interface. This test has run successfully on every stable, LTS and mainline RC
> >> released in the past year. Every kernel with my Tested-by has run this test.
> >>
> >> There have been a bunch of changes to MLDv2 so I started bisecting there, but
> >> the culprit is actually 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 "tun/tap &
> >> vhost-net: avoid ptr_ring tail-drop when a qdisc is present"
> >>
> >> Reverting this commit fixes the test.
> >>
> >> To eliminate my code and any multicast weirdness, I ran tests with iperf3
> >> comparing the same host running 7.2-rc1 both with and without 1d6e569b7d0
> >> reverted.
> 
> Thank you very much for your bisect!
> 
> As the author, I am sorry for that regression!
> 
> > 
> > Thanks a lot for the bisect! Reverting is not out of question, but
> > just before we do, it is worth analyzing the situation.
> > 
> > Could you pls tell us
> > - do you see packet drops?
> 
> iperf3 shows no TCP retransmissions, so there were never packet drops
> when the patch was enabled.
> It is the number after the sender data rate (example: threads 1,
> reverted has 368 retransmissions/drops).
> 
> > - does it help to increase the tun queue size?
> 
> I agree, this would be great to know.
> 
> However, even then we must act. I am considering IFF_BACKPRESSURE
> as a feature flag, defaulting to off. It would just enable/disable
> the stopping logic in tun_net_xmit() and the waking logic
> in __tun_wake_queue(). If disabled, it would result in the same logic
> as before.
> 
> I could provide such a patch as [net] material.
> 
> Thanks again!

Or BQL? I quickly wrote a prototype of that and it seems to work well -
could you help test maybe?


> > 
> > Thanks a lot!
> > 
> > 
> >> CPU: AMD Ryzen 9 9950X
> >>
> >> [ host ] - [ bridge ] - [ tap ] - [ guest (qemu) ]
> >>
> >> Running matching kernels on host and guest, I started iperf3 in server mode on
> >> the guest and tested from the host so traffic passes through the tap interface.
> >>
> >> iperf3 -s -V                 # server
> >> iperf3 -c guest -P nthreads  # client
> >>
> >> 7.2.0-rc1 (threads 1):
> >>
> >> [  5]   0.00-10.00  sec  20.2 GBytes  17.4 Gbits/sec    0            sender
> >> [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
> >>
> >> 7.2.0-rc1 (threads 1, reverted):
> >>
> >> [  5]   0.00-10.00  sec  15.3 GBytes  13.1 Gbits/sec  368            sender
> >> [  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver
> >>
> >> 7.2.0-rc1 (threads 2):
> >>
> >> [SUM]   0.00-10.00  sec  10.9 GBytes  9.33 Gbits/sec    0             sender
> >> [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
> >>
> >> 7.2.0-rc1 (threads 2, reverted):
> >>
> >> [SUM]   0.00-10.00  sec  15.9 GBytes  13.7 Gbits/sec  1567             sender
> >> [SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver
> >>
> >> 7.2.0-rc1 (threads 4):
> >>
> >> [SUM]   0.00-10.00  sec  10.9 GBytes  9.33 Gbits/sec    0             sender
> >> [SUM]   0.00-10.00  sec  8.00 GBytes  6.87 Gbits/sec                  receiver
> >>
> >> 7.2.0-rc1 (threads 4, reverted):
> >>
> >> [SUM]   0.00-10.00  sec  16.5 GBytes  14.1 Gbits/sec  6701             sender
> >> [SUM]   0.00-10.00  sec  8.00 GBytes  6.87 Gbits/sec                  receiver
> >>
> >> 7.2.0-rc1 (threads 8):
> >>
> >> [SUM]   0.00-10.00  sec  10.7 GBytes  9.15 Gbits/sec    0             sender
> >> [SUM]   0.00-10.01  sec  10.6 GBytes  9.13 Gbits/sec                  receiver
> >>
> >> 7.2.0-rc1 (threads 8, reverted):
> >>
> >> [SUM]   0.00-10.00  sec  16.2 GBytes  14.0 Gbits/sec  19319             sender
> >> [SUM]   0.00-10.00  sec  15.7 GBytes  13.5 Gbits/sec                  receiver
> >>
> >> 7.2.0-rc1 (threads 16):
> >>
> >> [SUM]   0.00-10.00  sec  10.9 GBytes  9.35 Gbits/sec    0             sender
> >> [SUM]   0.00-10.01  sec  10.9 GBytes  9.32 Gbits/sec                  receiver
> >>
> >> 7.2.0-rc1 (threads 16, reverted):
> >>
> >> [SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec  43593             sender
> >> [SUM]   0.00-10.00  sec  14.4 GBytes  12.4 Gbits/sec                  receiver
> >>
> >>
> >> As you can see, the new code works for single threaded, but for all other cases
> >> there's a significant performance drop. I see this trade-off is mentioned in the
> >> commit, but the performance drop off is much worse than suggested with the
> >> current patch.
> >>
> >> In our multicast use case data is sent by multiple threads to multiple groups
> >> simultaneously, this just breaks things to the extent that a <2 second test
> >> times out after 5 minutes.
> >>
> >>
> >> git bisect start
> >> # status: waiting for both good and bad commits
> >> # bad: [dc59e4fea9d83f03bad6bddf3fa2e52491777482] Linux 7.2-rc1
> >> git bisect bad dc59e4fea9d83f03bad6bddf3fa2e52491777482
> >> # status: waiting for good commit(s), bad commit known
> >> # good: [36bdc0e815b4e8a05b9028d8ef8a25e1ead35cc1] net: usb: asix: ax88772: re-add usbnet_link_change() in phylink callbacks
> >> git bisect good 36bdc0e815b4e8a05b9028d8ef8a25e1ead35cc1
> >> # good: [db314398f618a3a23315f73c87f7d318eaf06c1b] Merge branch 'net-bridge-mcast-support-exponential-field-encoding'
> >> git bisect good db314398f618a3a23315f73c87f7d318eaf06c1b
> >> # bad: [079a028d6327e68cfa5d38b36123637b321c19a7] string: Remove strncpy() from the kernel
> >> git bisect bad 079a028d6327e68cfa5d38b36123637b321c19a7
> >> # bad: [f396f4005180928cd9e15e352a6512865d3bc908] Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path
> >> git bisect bad f396f4005180928cd9e15e352a6512865d3bc908
> >> # bad: [ec1806a730a1c0b3d68a7f9afe81514fb0dd7991] netfilter: x_tables: disable 32bit compat interface in user namespaces
> >> git bisect bad ec1806a730a1c0b3d68a7f9afe81514fb0dd7991
> >> # good: [50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85] mptcp: do not drop partial packets
> >> git bisect good 50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85
> >> # good: [68993ced0f618e36cf33388f1e50223e5e6e78cc] Merge tag 'net-7.1-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> >> git bisect good 68993ced0f618e36cf33388f1e50223e5e6e78cc
> >> # good: [34c78dff59a25110a4ce50c208e42a91490fe615] Merge branch 'net-use-ip_outnoroutes-drop-reason'
> >> git bisect good 34c78dff59a25110a4ce50c208e42a91490fe615
> >> # bad: [9587ed8137fb83d93f84b858337412f4500b21e9] Merge branch 'gve-add-support-for-ptp-gettimex64'
> >> git bisect bad 9587ed8137fb83d93f84b858337412f4500b21e9
> >> # bad: [83ea7fd73b11dd8cbf4416507a5eac3890b49fb0] net: dsa: microchip: remove unused phylink_mac_link_up() callback
> >> git bisect bad 83ea7fd73b11dd8cbf4416507a5eac3890b49fb0
> >> # bad: [f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a] net: make is_skb_wmem() available to modules
> >> git bisect bad f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a
> >> # bad: [c411baa463e85a779a7e68a00ba6298770b58c4c] netconsole: move push_ipv6() from netpoll
> >> git bisect bad c411baa463e85a779a7e68a00ba6298770b58c4c
> >> # good: [fba362c17d9d9211fc51f272156bb84fc23bdf98] ptr_ring: move free-space check into separate helper
> >> git bisect good fba362c17d9d9211fc51f272156bb84fc23bdf98
> >> # bad: [d0273dbe8be1640e597552f81faf1d6c9997d3e3] ipvlan: use netif_receive_skb() in ipvlan_process_multicast()
> >> git bisect bad d0273dbe8be1640e597552f81faf1d6c9997d3e3
> >> # bad: [3803065cd6b0630d4161d86aa04e2d1db0f3a0b5] Merge branch 'tun-tap-vhost-net-apply-qdisc-backpressure-on-full-ptr_ring-to-reduce-tx-drops'
> >> git bisect bad 3803065cd6b0630d4161d86aa04e2d1db0f3a0b5
> >> # bad: [1d6e569b7d0c0b2736636749e4be0a27f3cefcb3] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
> >> git bisect bad 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3
> >> # first bad commit: [1d6e569b7d0c0b2736636749e4be0a27f3cefcb3] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
> >>
> >> -- 
> >> Brett Sheffield (he/him)
> >> Librecast - Decentralising the Internet with Multicast
> >> https://librecast.net/
> >> https://blog.brettsheffield.com/
> > 


