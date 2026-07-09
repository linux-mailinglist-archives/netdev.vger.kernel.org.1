Return-Path: <netdev+bounces-306109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BYfRD1FnT2pDgAIAu9opvQ
	(envelope-from <netdev+bounces-306109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:18:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1C472ECF7
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:18:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bsa2QEWE;
	dkim=pass header.d=redhat.com header.s=google header.b=m3q6G+k2;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306109-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306109-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 144C030087C6
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499843FF8BE;
	Thu,  9 Jul 2026 09:18:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8093E0241
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:18:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588686; cv=none; b=kUgXS01c+OBMWlHsOHr/DwZD10YDkwGvP0nqCaZekeRU2uxreEk53JtucLQT1iPWrK3LE+nb7zkHH9dvVVM348yrywl9SOcCFwg1PJklDMQRjfYQ1ftRCkrNvvlhWzLSVl8vPfl4bSC79LJ35gw+VNuj8ccLjBrJxe7w9H8icc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588686; c=relaxed/simple;
	bh=FjpUXsvhXEAkUlVQP4tEH1Ee2iSdcpYkelan5p5vzPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfuyFEi93XKkSfzl8xpdkc8JFe7KWtJ6HQS0cWJSvjJWE0Ru9JcfGFPsIplkpibhKLyBqY0sPENJIzZ3qA2nII6xL1hoHLyMdAGHcs8l2Uv1RAzwaP3L45qTmO0sPiKtAiG7v5HF69GcQQTBC19FuFvxq3KiSFHfSMn1BJPul60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsa2QEWE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m3q6G+k2; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783588683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lcgAW3wWwD+CDc95tyrJwQ6t0jD3GIhvTCB6YDG1NyM=;
	b=bsa2QEWEHDPr5cMcdwWrXYDbSL3c7Dg+wGlrHKnmPIrtA3I1t1SzjuBa7KkqdRKyf7sqL/
	fbLG7sHwE3XBJqniWOalHS693gxNlJFxoGl8ymRTo2ebT1IDZjWK2/aFCHEJWXrXMF8Ee+
	2M8y29ejM0lu+Gku12cDnw+O5pOccIk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-LWTVZQLqMfCFvdBNM7W48Q-1; Thu, 09 Jul 2026 05:18:00 -0400
X-MC-Unique: LWTVZQLqMfCFvdBNM7W48Q-1
X-Mimecast-MFC-AGG-ID: LWTVZQLqMfCFvdBNM7W48Q_1783588679
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47407691804so1362001f8f.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783588679; x=1784193479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lcgAW3wWwD+CDc95tyrJwQ6t0jD3GIhvTCB6YDG1NyM=;
        b=m3q6G+k2BxxHrRuy8NIc3HM7r5BkAQ5kBQ1fZ9ywGCU76Ww2QoD/Ei/V6NBLnwI8dP
         49p94kw0oGoRgi10BqgLIvP3Fl7Fwk+kdgpsLR7Me3bzNDOqPzGkN/Owy8+dCZwIys5S
         E/HTui+ygs+0ZK7c0wRh8RmbhlFIObPhFcEFbMDpxyv+QGLycE8U1jdpm5wWcmcXfhO2
         KxQuY430In6dk8AbRp8TUiJ52D/d64S9jTnwkznspCX+hXqnuRKzGQU3vGuTB7NjcFtS
         HEFq3Y+yLePpLqpZWWE84RKIjYCyY2s2Yy8bXB0IgAEEUt01zrrBzLbXZ6ksZeGPKNIv
         UnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783588679; x=1784193479;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lcgAW3wWwD+CDc95tyrJwQ6t0jD3GIhvTCB6YDG1NyM=;
        b=PMt/WU2pEth7ExpNtM+lGLPRf1FoyO+5Czn6vSOSwxc2KSPFLyTYUm2VMFKL0pfRYa
         2EKiQiU7R/YM5c4ebOuupI8XvIHhTADSmIxYVbWebVCHhOS9P6lS5qtzU8+wyp3ycOlW
         4YIzEOIIqVvgsVelUXlrHAyCvVEhugzpLFDsy/WzB3925SDlThDKSDwwMTWi0d4DLo2f
         QBSfKRq9RNhaLwJ8ymh0jxJH1MLC3UzkKiI4jqMNZww+ucHyBCxtrPzIN8k+6hI5nSRR
         N+111EYlZpVfV1hpgAJnppMRK0XaLs+KsqlZbmD5bCDVI3Gl5kiGlT+dq0kbg/wFbKow
         MVLQ==
X-Gm-Message-State: AOJu0YyDZSg5d5OZCPEYis7lCLeirWrGxKKF3NXNYAd7kL5SG8sr0Rpq
	yVHpoO6+9tdh1zDikwx1Z1hcbJrwNROl4Of1bHaLHQqmFgGEIUqiqKhiBkofYBtaB6U3VuEvFRW
	gf6lbFaS/GLokjiJ02EvVoqUMAv7cDVS5t0FtXSsSExGQN+JR30z+FkIc6w==
X-Gm-Gg: AfdE7cnjc1hWQVr8Hl9KFZsOtE5NXvZYcoWuc/WOTYmer66ud+T5QhlLxWNzxUoRdVP
	otonXQCStBrLve5vE1hIw3fouiBg9e98ZG3u++60lL1Ic1i5MIhpsRRPBmm+XMYqeBTGr5EEidV
	vEQDrqcR8ODcUxZnYpBanUFbGoLmcr6tfp/ELYXH8CiAvFK1nkNVbw8k4UQJTQtbihfoSCl+ETe
	lVK0JNXPlyfiwdRCowuDfd+5OAox5f2FMRYeXv7ZwFjaSimc/flWPBTRxySzZb+5zWOHnRQHYMZ
	MtQyimojuE7PvLIB5sL2xjQCXUKNi0DonCgPbkt/vpLOFw6jKgZCrYGer4fRxR714ZRDxO0z62a
	AdxGV6E/PrUGBrWrM6x4dDXT4Z8T9QJU41TqLaXBDOo8JUWhOtTBhp7k/NGA3
X-Received: by 2002:a05:6000:1a85:b0:460:1223:a044 with SMTP id ffacd0b85a97d-47df06c10c9mr6983272f8f.0.1783588679365;
        Thu, 09 Jul 2026 02:17:59 -0700 (PDT)
X-Received: by 2002:a05:6000:1a85:b0:460:1223:a044 with SMTP id ffacd0b85a97d-47df06c10c9mr6983241f8f.0.1783588678905;
        Thu, 09 Jul 2026 02:17:58 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm48486557f8f.6.2026.07.09.02.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:17:58 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:17:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
Message-ID: <ak9h1kWcLmpP74PI@sgarzare-redhat>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
 <20260708065853-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260708065853-mutt-send-email-mst@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306109-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:netdev@vger.kernel.org,m:jasowangio@gmail.com,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:eperezma@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:kuba@kernel.org,m:jasowang@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.alibaba.com,google.com,redhat.com,kernel.org,davemloft.net,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sgarzare-redhat:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB1C472ECF7

On Wed, Jul 08, 2026 at 06:59:41AM -0400, Michael S. Tsirkin wrote:
>On Wed, Jul 08, 2026 at 12:29:04PM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Add a test that sends 2 MB of data using randomly sized small packets
>> (129-512 bytes) over a SOCK_STREAM connection. Packets above
>> GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
>> forcing each one into its own skb.
>>
>> Without receive queue collapsing, the per-skb overhead eventually
>> exceeds buf_alloc and the connection is reset. The test verifies
>> that all data arrives and that content integrity is preserved.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>maybe cut down SO_VM_SOCKETS_BUFFER_SIZE? will make it easier to
>trigger?

Currently, with the default value, the trigger is practically immediate 
for packets between 129 and 512 bytes, but yes, a smaller buffer size 
certainly makes this effect even more pronounced.

>
>anyway
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!

If I need to post a v3, I'll add it; otherwise, I guess we can leave it 
as is or send a follow-up for net-next.

Thanks,
Stefano


