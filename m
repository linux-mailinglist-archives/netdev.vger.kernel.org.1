Return-Path: <netdev+bounces-305383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CqboDPPHTGq4pgEAu9opvQ
	(envelope-from <netdev+bounces-305383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:33:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4E7719D4E
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:33:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=aU6xEIv5;
	dkim=pass header.d=redhat.com header.s=google header.b=EgRcJsUM;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305383-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305383-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36E4F3001F9E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58AA37C91B;
	Tue,  7 Jul 2026 09:27:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03431A057
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:27:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416476; cv=none; b=Z3ThRDgkjH0lOTDBYJBUvItCiLQPeHmna/UsSH0sC3pFTomaNKRVplWhWT0TxkfhDoiNzew7I181VNWLtGfkxwsZH/qIu6oyhGhhjJVa7TerjVKjP49NWYCC+2NxvUpDy3HneG6HP+OEwnPrz7XNCNH1HgkQMyeA9giedyCoMjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416476; c=relaxed/simple;
	bh=3bYECwpBfkTcXe9Xf4qgJEYNbyztdqohJjIZZ7uI0/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOGLa4g6TsbDpx3R0ZP1kRJhdIf5Ln7Z8TGrbquqAJsdkxEj2mkiauSxlhsFgqzKNLRxyLLV5sGlPveaezVL5/EiGhiMXvVrgjBeMsHI24gn9rZVmmwQe8dk60OU8zT56FcUH7Dai6KBVKixWNMxGWbSrUwZvMWxSkHGsmIL/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aU6xEIv5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EgRcJsUM; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783416474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dWXC2U5pS/sHIFMNKjcnHZ2j56kpHPifAM+RlNplU0Q=;
	b=aU6xEIv5GCjhsSKNRdzG9RpiStMs+glGmXSjsshuXZAi2pBsxP6nRFA3TXx6lVjgeC7kcM
	lW0kbn5EJzfXk7i/edh3z6T7b8BEh15YZjYfbfxh3RKm/XmWu5sRs3ZYr+E7QevEElJWMq
	UY8JwrWyaZYj8M8fyD4ksVvvmvdMT9I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-4xBJR1XENn-0EC2SLrHBlQ-1; Tue, 07 Jul 2026 05:27:53 -0400
X-MC-Unique: 4xBJR1XENn-0EC2SLrHBlQ-1
X-Mimecast-MFC-AGG-ID: 4xBJR1XENn-0EC2SLrHBlQ_1783416472
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493ce08a6b4so40298915e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 02:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783416472; x=1784021272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWXC2U5pS/sHIFMNKjcnHZ2j56kpHPifAM+RlNplU0Q=;
        b=EgRcJsUMwNTfmjcjtTEh0B3qY8pZ2jTTl4RMibEsP2AC6oPkcA1m9ed8kO3wmfmciW
         XgFCGvYzbmiVCC1ESidbypkqxh/Px2k4Wnl7ckZlV5uoXSdKREqljgNJ6Y4d5NcJCUAH
         RPvwbPonvKQhsya0Xq+zx8i0HrVp5hTwxRMjr32/hqG0M7t/i1haIHHH+5YZJJFFUatC
         SrO/2WMMwcbsu/2ei/zknM/dpS7cUqt9Z2njY8CgcAcUaD4audPIfGXOkNzdSc0O6EXA
         VHS5VTYq2sqfyuSGP2Sgcclm0jabmKiMSEgjBJFbmvSusV5mgBmCtBHOTY2w7Aq0rt2g
         K2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416472; x=1784021272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWXC2U5pS/sHIFMNKjcnHZ2j56kpHPifAM+RlNplU0Q=;
        b=TgCqIqaw+/5sHLCrKkIKYKKCQuFApZ6CAgCUTOgyW8eTLlJ/9VE3cYGPsnN0sIoZIr
         ZH2a9cZnd0N9hPuQryOLFudScPu1tmEb/OVLPeukXAYB64ipmkFKdPUtC8yqtMVp8Rez
         JKtEyfitrgqC0RTUqQYFsseD/mZ+wF+VrM8y6GKIas/2g/9aByTCKZMdI/SBbslUhhcU
         I9M1XxvbiRwGiTUa/a/POb5xDa4RtCGlgOAihC5J2t3ZjiRE9IvPGQTquv4zyky8SE0a
         VZILSu4Ub1afOEfsHkjxVpOFIUKKwIsVF6JyVoMsoaAaY7nq7FXum+bpOfdLA+E/EfKL
         caYQ==
X-Gm-Message-State: AOJu0Ywea2vrHaaiaBypRHIO9IcZr/NY0VRypU8mzqhCh7XZE4UVMyHi
	vHdvTpLtHqNEzu7tqozaEuBMaz7C7h6T1cJxRopazGbjk+foi2oEzRe4t5Ys1EzXAfdqusVDzbz
	jp05clJ3thjpvxBFzfL8+2MO8UYY7r5J6vVzTWLd/733raFxkSjpO/6932Q==
X-Gm-Gg: AfdE7ckrcjeR4oze1940ixkchWEmsNtZ3qYOR7s1tvLN4+Hc0EVijnbk+tCmEFDS+cE
	2ewvbsXXCWGpGhGDcpkUr/YSGY9VU9DFfq9pjx04ZVKdsILdERxSBw1cDQ2O8uuai+4+GmYu6p7
	UexUeT2hIdn37DN1Q5obXd5C3zO+IS5XhPcmpVxzawptV4oEeS20nFB859zAtC8vPSjLL8OSUnP
	2edMSxOAI/cKRaQCvPFbAuLMQs3L2prC3Z9P3ihrrrrP3yknmJrZIxEs1P8mHD8fDoiIH6YannP
	wYsGlLVS973UD5aPqI16FK2oAqMNoZ2SXhOcjauhnuiv0+A1qLf88zr3BjfCQXKczVjqnQoXrYO
	XZPB4+Rf7zO1IlxtLlIE761ixs9b/+2+W2NppSFfrYA6hlT4jF42hTV76cNrN
X-Received: by 2002:a05:600c:6ad0:b0:493:c2cc:aecb with SMTP id 5b1f17b1804b1-493df0a08ffmr34351375e9.38.1783416471672;
        Tue, 07 Jul 2026 02:27:51 -0700 (PDT)
X-Received: by 2002:a05:600c:6ad0:b0:493:c2cc:aecb with SMTP id 5b1f17b1804b1-493df0a08ffmr34351085e9.38.1783416471154;
        Tue, 07 Jul 2026 02:27:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f4e3afsm48240745e9.7.2026.07.07.02.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:27:50 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:27:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akzGUvB9g3smaXO6@sgarzare-redhat>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
 <akYl38_9Y4ydXuqE@sgarzare-redhat>
 <akbFcMHenseQW7mJ@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <akbFcMHenseQW7mJ@devvm29614.prn0.facebook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305383-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bobbyeshleman@gmail.com,m:netdev@vger.kernel.org,m:jasowang@redhat.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:eperezma@redhat.com,m:stable@vger.kernel.org,m:brienpub@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,lists.linux.dev,linux.alibaba.com,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D4E7719D4E

On Thu, Jul 02, 2026 at 01:09:20PM -0700, Bobby Eshleman wrote:
>On Thu, Jul 02, 2026 at 10:56:04AM +0200, Stefano Garzarella wrote:
>> On Wed, Jul 01, 2026 at 09:34:35AM -0700, Bobby Eshleman wrote:
>> > On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:
>>
>> [...]
>>
>> > > +out:
>> > > +	if (new_skb)
>> > > +		__skb_queue_tail(&new_queue, new_skb);
>> > > +
>> > > +	skb_queue_splice(&new_queue, &vvs->rx_queue);
>> >
>> > I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
>> > when adding to rx_queue?
>>
>> IIRC we added it in the rx path, mainily for loopback to pass the ownership
>> from the tx socket to the rx socket, but here we are already in the rx path,
>> so the skb will never leave this socket.
>>
>
>Ah that's right, I stand corrected. There is no sender to leak in this
>case.
>
>> Maybe it's necessary for the eBPF path?
>
>Looking through sockmap, I don't think it depends on skb->sk being
>non-null either (it reassigns owner to the redirect socket anyway using
>skb_set_owner_r()).
>
>Sorry for the false alarm. LGTM.

Thanks for checking!

>
>Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
>

I'm going to add a threashold as Paolo suggested. Do you prefer to look 
at v2 or should I carry your R-b ?

Thanks,
Stefano


