Return-Path: <netdev+bounces-286367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AKnFjzOAGqdMwEAu9opvQ
	(envelope-from <netdev+bounces-286367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:28:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CF05059EA
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDE3E300916D
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9133090E8;
	Sun, 10 May 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHIipxFb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUYWn2x5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852830648C
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778437689; cv=none; b=DV0gTyr8MTM14liZZpnOhZWjYy6wXHQaJrHVBVQxM7S6rVZHC4Aa8MTho1NvI0v3k+YGoY/y/qrGa7Qb0+z7r+N/KaDz1DRTn24t6SmamhUJolh+gAiEl/RPHyzAd3GT/H4ipwZhTsEL2VQ2UeNTZT0HIso0Xq8QL7/BlzeqrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778437689; c=relaxed/simple;
	bh=Nds78ZQv+k1dBd4zeRMpIKfcLCYRSolg2HIQ5VEH2Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulAKpNOGLn3XURXd/N9zIZTl6G+hsoo62cYgt8zOC8Lj+rqikxA8obTfdwNSizKba8bHAOy+fkBvRPG4Ln4DSp6mGre26/FIIZ/Z43bGZeFEYABaxywf431cleG68tuclUs/ZFv71SDg9Ry5pkDMWhoUqoszy2iR8c7A9v7yn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHIipxFb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUYWn2x5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778437686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20vi7jjXaNmaH582QbUJViOW3O2EFOcheWh4ZH6Qnn8=;
	b=VHIipxFbEHGwZaYI7LqGUZST0hQX1sOmcdJkNyxRVDsx648nS2Md+FUOrIOtj5O3OT5b/i
	RA2IF6vixT3mBL8etA1N09SOsmWNnSRZ/KxVtDBzVk0ZY525cduC0cF0ljuvlrP1T20laR
	BoM2vZkgstkqvw7TlVBU5dkXGHWi8TY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-l6bYViQ-PxmayQ8WrhOT_Q-1; Sun, 10 May 2026 14:28:05 -0400
X-MC-Unique: l6bYViQ-PxmayQ8WrhOT_Q-1
X-Mimecast-MFC-AGG-ID: l6bYViQ-PxmayQ8WrhOT_Q_1778437684
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a589c7879so35321995e9.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778437684; x=1779042484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20vi7jjXaNmaH582QbUJViOW3O2EFOcheWh4ZH6Qnn8=;
        b=jUYWn2x55zK57cFeSAZxykm50eMS8bFDjOA4d5YBXMI8up4wp6bli/F6lhyboXoobo
         B/O3kih40qHBZV/nmFsyq6mPyJ6QP8Lhqx+GSA/O/0QV5Ok84lfhv1E+CjZMUy7RRt1O
         e6hZz6LDQWw1sH7RXllwPNon8jIecwi2Hcxrjp4kHfR2ZTHzuX2lWia5UqJg8Fqa7prF
         dBro6dBywQKsEW7kJadgi5EzbQyI69/2Dxg3vPbJ8P0HPx0Vt7PEJCFiIlGDL/RLpoAY
         2nke5sdNTdnm9AkNilGYK+l1xKN7abpRfltYUqRboftIds5nuADzXotm6xtjgv+visXt
         aMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778437684; x=1779042484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20vi7jjXaNmaH582QbUJViOW3O2EFOcheWh4ZH6Qnn8=;
        b=OBYSIqhQCqC/odIzPFqpnEj2IyL2p5nM3IdLbVVh7EIgLpdJPaSh0ToIqYiJzWkS5C
         qn+0c6cgMg3U/Y9z6VxA7RWNsDiR6gb8piIGHL09sB0WnH2AcYd4EA6jaUK7jKC3cUEl
         /68eXlN+DojQNK7f9Sy1Tgr9WZpL83gSlhuHPq7dG5O7zRGXvu0tAcBPoAXO9q1BSav9
         QpTtLxboWDz+8CtJoWU06Heh9fXDuQxSNWZonM4+MlBcoCAG6bVZbpyVXbtsNQZhynVw
         QjZCSaEBPvX7tWyA66/kLBVSZ51Mg40nKgDq882UzS/nVL/x6UKvQ+VMDsL9o9BDHlEg
         ekgA==
X-Forwarded-Encrypted: i=1; AFNElJ+H1S0hFsiorQDGeYkChamhQF844rEd8RpsXjzyZKlYKZX/pauYXkfyWqLEeD9OjQoK95Z/kpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHP80SqTDw9L6haqo+dEc45LSxDomQpJkvaM7sFi10uKf7SPae
	IN1Qqbzxg20gISKyR9OnT99d3VwjyuUMIS7MJlPS5+36m5p5jqMf9g5Do3AmV3MajH67ovou3sG
	UgVUd+GzlXhje5ymyPmOdq5ZxVIcsEbfwSQ/JWVXEEeZuP8sW+EDcfcdYQQ==
X-Gm-Gg: Acq92OF+t57U22FFC/KtMQLL+ZPWYtkPui1OoRp1/wpPHJm/MwXfcqYhTBPFBYIh5Jz
	f4wwT1/u+YSGeNuXpSSEUo8wxegmX1qU3lD8dioZk4QIKXMJpN6vY9lBNDj8XEoKeMVzlq03p1d
	7Wh45SVCLzcAWKetMYoPR7pfwLoA6D5CPZRp1YCkzFrVkVEaCouhz4PnZwXSobnPKrGahgaKMNV
	yXaqm/MhHn53BBLnj4KSI5ST2Ag4QIhCNHKO8XvlzI72/MxUqUuSa81CgMKSoac3X8k8z2mjqsM
	n4EBMH7sKf5BdD/bQTnvwe5U6MbIPTq/n3moYQ4gSNjqqig09Vj0/n6bsrmeFnr5M1Zk9fUpNO1
	LilCiqFhkNiz5x+kT2Qg1HvlfJSuc32m+LD8iX6Q9
X-Received: by 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e5e000c1cmr177492135e9.12.1778437683972;
        Sun, 10 May 2026 11:28:03 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e5e000c1cmr177491905e9.12.1778437683333;
        Sun, 10 May 2026 11:28:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7040a9a9sm225839165e9.9.2026.05.10.11.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 11:28:02 -0700 (PDT)
Date: Sun, 10 May 2026 14:27:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v11 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260510142743-mutt-send-email-mst@kernel.org>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
 <20260509183518-mutt-send-email-mst@kernel.org>
 <a14b700a-94e8-44c0-bde0-d8307761c0f1@tu-dortmund.de>
 <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
 <20260510094020-mutt-send-email-mst@kernel.org>
 <e5d69f44-4483-49f3-b7fc-aca2cdb24792@tu-dortmund.de>
 <20260510114401-mutt-send-email-mst@kernel.org>
 <5f39493e-b2f0-446b-9896-98a074f5ed6b@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f39493e-b2f0-446b-9896-98a074f5ed6b@tu-dortmund.de>
X-Rspamd-Queue-Id: 87CF05059EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286367-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 06:22:15PM +0200, Simon Schippers wrote:
> On 5/10/26 17:44, Michael S. Tsirkin wrote:
> > On Sun, May 10, 2026 at 04:01:39PM +0200, Simon Schippers wrote:
> >> On 5/10/26 15:40, Michael S. Tsirkin wrote:
> >>> On Sun, May 10, 2026 at 10:55:34AM +0200, Simon Schippers wrote:
> >>>> On 5/10/26 09:03, Simon Schippers wrote:
> >>>>> On 5/10/26 00:44, Michael S. Tsirkin wrote:
> >>>>>> On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
> >>>>>>> On 5/8/26 17:10, Simon Schippers wrote:
> >>>>>>>> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
> >>>>>>>>  {
> >>>>>>>>  	void *ptr;
> >>>>>>>>  
> >>>>>>>> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> >>>>>>>> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
> >>>>>>>>  		tun_ptr_free(ptr);
> >>>>>>>>  
> >>>>>>>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
> >>>>>>>
> >>>>>>> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
> >>>>>>> operates on a tfile that is being torn down. Its queue_index is no
> >>>>>>> longer valid. After the swap in __tun_detach(), it points to the
> >>>>>>> netdev subqueue of a different tfile.
> >>>>>>> --> We should not wake there.
> >>>>>>
> >>>>>> Does it not exactly point at ntfile which is what we want to wake?
> >>>>>>
> >>>>>
> >>>>> I see your point. But calling tun_ring_consume() as done here is
> >>>>> wrong, because it does not wake if the tx_ring of the tfile 
> >>>>> (that is currently torn down) is empty. We could change
> >>>>> tun_ring_consume() to call __tun_wake_queue()
> >>>>> with consumed=0 if !ptr but I think this would slow down the consumer
> >>>>> path.
> >>>>>
> >>>>
> >>>> My statement is wrong:
> >>>> There is no way that the tx_ring is empty and the queue is stopped
> >>>> at the same time. So we do not need to touch tun_ring_consume() and
> >>>> this works just fine.
> >>>>
> >>>>>>
> >>>>>>> I will swap tun_ring_consume() with ptr_ring_consume() again and
> >>>>>>> submit a v12 :)
> >>>>>>
> >>>>>> If so then maybe
> >>>>>> netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));
> >>>>>>
> >>>>>
> >>>>> But we should only do this if there is space in the ntfile.
> >>>>> My approach:
> >>>>>
> >>>>> @@ -586,12 +588,18 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
> >>>>>  		BUG_ON(index >= tun->numqueues);
> >>>>>  
> >>>>>  		rcu_assign_pointer(tun->tfiles[index],
> >>>>>  				   tun->tfiles[tun->numqueues - 1]);
> >>>>>  		ntfile = rtnl_dereference(tun->tfiles[index]);
> >>>>> +		spin_lock(&ntfile->tx_ring.consumer_lock);
> >>>>>  		ntfile->queue_index = index;
> >>>>>  		ntfile->xdp_rxq.queue_index = index;
> >>>>> +		ntfile->cons_cnt = 0;
> >>>>> +		if (__ptr_ring_empty(&ntfile->tx_ring)) {
> >>>>> +			netif_wake_subqueue(tun->dev, index);
> >>>>> +		}
> >>>>> +		spin_unlock(&ntfile->tx_ring.consumer_lock);
> >>>>>  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
> >>>>>  				   NULL);
> >>>>>
> >>>>> ntfile->cons_cnt is unvalid, because the new queue might not be stopped.
> >>>>> That is the reason why I reset it to 0.
> >>>>
> >>>> However, I still prefer this approach because the code is easier to
> >>>> understand.
> >>>
> >>>
> >>> So do you want me to finish review of this one and ack, or want to
> >>> post v12?
> >>>
> >>
> >> I will post a v12 with the proposed changes for patch 1.
> >> No other changes.
> >>
> >> Thanks!
> > 
> > actually can you clarify? why only when ntfile ring is empty?
> > 
> 
> This avoids waking when ntfile->tx_ring is full. We can not use 
> __ptr_ring_can_produce() with consumer locks, therefore I chose
> __ptr_ring_empty() instead.
> 
> If there are any elements in ntfile->tx_ring we do not have to wake.
> This will be done by the consumer in tun_ring_consume() &
> __tun_wake_queue() after consuming those elements.

worth a code comment if you need to do v13.


