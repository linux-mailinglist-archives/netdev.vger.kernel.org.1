Return-Path: <netdev+bounces-275910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDW7Dl7E1GmmxAcAu9opvQ
	(envelope-from <netdev+bounces-275910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:46:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B803AB7D5
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C4BB3029605
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D426399373;
	Tue,  7 Apr 2026 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkqxTo+i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuUh8Fwv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D257D399377
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551546; cv=none; b=O/11pE9S5FwLmGi71rT6fdrwShBFFgyG+D3ELGk6lFqx6DrX9s0AJBHk0vbQVyeVz8OUSz3Od7P+GaPFayRk7VgiBVE6Qy25jsjewQFAniiJE1Q/cCjE29L6r0z6yu72fLn2mSKsPVS95ucwvokNkBsroIDA7Mwgp3VesG2I9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551546; c=relaxed/simple;
	bh=z7XMqNzqbaQp3YVbNCSinxYvK5mXLBbHoHlDC+DisRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7Q0qWkWiLjX21irMz946OLt0/UyMVk/I8YAkuGg4fdhEFL+Y+I2MEHbSSOLEm32PPHmTnC4ucrk+sB4B2XHJzYUfILx93+nb0agG1QT4s6VTctnKEw+2T7kKLBkdfLPbpOhFuByYPdoya+Q2LPGAsN31ZlrQakhJxJicvbYmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkqxTo+i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuUh8Fwv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775551544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90Dv0Gfd1H3V0FF0ZZTa8jkFYwFCJbiDQpupdqGKTx4=;
	b=NkqxTo+iRgJTl+3PH6z3BvE2jnc96lV5QqQG2F7C2+ozTTlWnTiDAvfdP1nd02Jj+OrhGS
	IXSTrzay+1MbfVwHXhh1yDRte4oKsK/ogvwJn6zvPDQbGAC0DGJLyppJ5ip9+tlgGCBrIT
	foo5JIoHOaMCuWS+L31PddUQ+bfLee0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-dgQKgo-DMJGGdrcJ9jJ9jg-1; Tue, 07 Apr 2026 04:45:42 -0400
X-MC-Unique: dgQKgo-DMJGGdrcJ9jJ9jg-1
X-Mimecast-MFC-AGG-ID: dgQKgo-DMJGGdrcJ9jJ9jg_1775551542
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488af976487so12148365e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775551541; x=1776156341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90Dv0Gfd1H3V0FF0ZZTa8jkFYwFCJbiDQpupdqGKTx4=;
        b=QuUh8Fwv5bfnd+aAjW7iR5w2eJktf60pi+AhtvXEQRhaUk7DyiMj+1ORH4KMoYL7eW
         vF/OG0nWF8RjfNsSBOTReiHwai79fos2stpwhXVmzrYsU6RrXz6jTkRVcwcRwhBXRdyg
         Ob+6WeHHKvRtln/JhrxEHcw6sYho9c8cFWqPmDozQVu8Cat6/Fg3m9bjexeeSWW4WE7K
         USaKERp2a7AAtIplsgUpgiERxNfGA1qfVrXI8I903P6vDuln2dGPX8Dm49ov2ZPWSyK5
         unqzwTjzuOfjtdv0Xn+4RR9wR1ilIu/N/23TUeM4W3D426JZ+rGJJBVRCAG2MAyq1mw3
         50Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775551541; x=1776156341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90Dv0Gfd1H3V0FF0ZZTa8jkFYwFCJbiDQpupdqGKTx4=;
        b=mZG0ebN3TOYdNIHOaC5J1Fi93T2rtmAfgPRusMq2aF9VgkRxNf5FKN8s09sHj60Njd
         l8j0YVGX5BOt6OtvoqZotIe6jXDkhJ1f567AGLR8bbSDCc7B+RAEpZnSCQ91stVoxqnJ
         QLMKpTKHFKcsfxaR5Yed4J/zgRrbsO5e+bedqoYFzsbukm9Y82bKpnZKxjkQwEbXN5Uo
         ru+6Ib5uDsEg2jLZRw0A7W+8u1CS/P/5TW8Vf1hygJ1h6ipJI5VYTjStYeRBZ/Qyf8ti
         3HSdaUiSExq+ONefiYz7mlxa04PJorbhbcjfW6rUmFaYocb1gs1O2HkSVnWxDDEItuPk
         dAvg==
X-Forwarded-Encrypted: i=1; AJvYcCXEzQi+cDPudmZrs6GOxZys9fA1y18yZZoy4Kh48uV63HlkcAcYJ/k/me8FTSnEfHoVN8MmSh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygi8cy41+a+Jxyqo+86BEsg0vx0OhK4jJXHGuKxhf7eCFu3lM6
	LuhD7xiGPW8BzDCGKt9HEVVIplUfuZLr/w8A18iFo5vcXwIeIMt9sL/Yf/GnPOw+WaCyXCOfTIh
	qFapCk0r+pvlTMvqLQ93KUBsE37jhMAYXoDrGUDXbdGsHUbzkgmugrqA6Ig==
X-Gm-Gg: AeBDiesgkIQzN+xpAPEUkkPPZurJ4uIvh2ETbqNO6C3Sua/Afh8Pcug783UXl2kHJdc
	B23ceObQhrWRV4NAouetLhTyXuWOKbd+MG9nYsJ5tx1ihQ5E0HxkzF3SSbLwB3J1NasC8xoOle6
	bMPk6+TONAhrj0JcgFx0kXTmWjXLVuHR9J7Ly7Y+76RSIthKM+tImY8q2PqP9Loi2cKEng26OH7
	NTYqM1Oj2shpSu0TzWyaer5uwuHLKBBaa5gbraDRlah0orht3PKbe/CKn9srJViALHlt+fFsZHv
	3ksNKLkEKC1OYt4Kc96GBIx7TEpkxft64h3gf5aWGNBc+QzqVvcBrfZjIMRKQoFefOiubmFXBTC
	+O4ltabjgGyCzEkQoDrV6NgpMjCA=
X-Received: by 2002:a05:600c:4f15:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488995cbaa7mr243063775e9.0.1775551541495;
        Tue, 07 Apr 2026 01:45:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4f15:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488995cbaa7mr243063245e9.0.1775551541043;
        Tue, 07 Apr 2026 01:45:41 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a7165aasm527048625e9.14.2026.04.07.01.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:45:40 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:45:37 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: add MSG_PEEK after partial recv test
Message-ID: <adTEDKJZklJgdcop@leonardi-redhat>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
 <2521971f-798d-4560-b2d8-bb540591d4b1@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2521971f-798d-4560-b2d8-bb540591d4b1@salutedevices.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275910-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2B803AB7D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Arseniy,

On Sun, Apr 05, 2026 at 10:14:26PM +0300, Arseniy Krasnov wrote:
>
>
>02.04.2026 11:18, Luigi Leonardi wrote:
>> Add a test that verifies MSG_PEEK works correctly after a partial
>> recv().
>>
>> This is to test a bug that was present in the `virtio_transport_stream_do_peek()`
>> when computing the number of bytes to copy: After a partial read, the
>> peek function didn't take into consideration the number of bytes that
>> were already read. So peeking the whole buffer would cause a out-of-bounds read,
>> that resulted in a -EFAULT.
>>
>> This test does exactly this: do a partial recv on a buffer, then try to
>> peek the whole buffer content.
>>
>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>> ---
>>  tools/testing/vsock/vsock_test.c | 64 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>
>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>> index 5bd20ccd9335caafe68e8b7a5d02a4deb3d2deec..308f9f8f30d22bec5aaa282356e400d8438fe321 100644
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -346,6 +346,65 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>>  	return test_msg_peek_server(opts, false);
>>  }
>>
>> +#define PEEK_AFTER_RECV_LEN 100
>
>Hi, may be we can just reuse MSG_PEEK_BUF_LEN which was already used in MSG_PEEK tests ?
>

yep, good idea!

Thanks!


