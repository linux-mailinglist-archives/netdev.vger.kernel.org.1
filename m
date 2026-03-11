Return-Path: <netdev+bounces-266707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CQ/MpmdsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:51:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA12678F9
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D50F23016296
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F53E2765;
	Wed, 11 Mar 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPXeee+P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nwlvj0BV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5953DDDB5
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247894; cv=none; b=VdJA1W2oluybgxpkvAKmffWRh1FIOMTyXFHRNCI0foOiNUqEWcLW+S2ckABgDK8/FjY/3TpOh87RjQpeFDvWKI4yQaR2YZwFwSYX6AfoIKphauvwvLOG6m0bE1lhJhngexod60SSt2IIJnd05pOns0pUFpoDYqZUQf6IcyKVRos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247894; c=relaxed/simple;
	bh=7ZtgjYvWplDOeClThKKS1LpYWJXuZCe9BIMhGL4CNGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3kc76rvRj87eFmLxU4CispGN+Kri9I/gBW7LtNnswhrpxtBI0qVbPs/ZC8kfek8GXJu1uKre56xXmaRwbhTcoJF86F+St05KWWnmehtiJUcWSQzlzeU3IEISc0snot+9JcaLZJ8fvrZ+wP+c/GtqVwk4m7xu+/e+9QlhjdF1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPXeee+P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nwlvj0BV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773247892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6d/LkdYVX1QbyofflI+RZNGcLNUAjGX4JUh09PCAgUQ=;
	b=CPXeee+PLnl6ntsIei+yUY04RewISvQuWoq9tgeh/XzTr01GO7JZ3bQ3tzCqAWZHQqLxpf
	NA/fGLsyQAqjcD41aKawlCK9Ii/fpdHHTH6u5k9T6RiZOdD3QtYY/kpza7LMmqQLPtHQOu
	Q/h84ZU2n8+NSXPCZrSe+3DDggO2uJ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-rGoutYtXOvGG95LiQxDRxQ-1; Wed, 11 Mar 2026 12:51:31 -0400
X-MC-Unique: rGoutYtXOvGG95LiQxDRxQ-1
X-Mimecast-MFC-AGG-ID: rGoutYtXOvGG95LiQxDRxQ_1773247890
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-483786a09b1so439245e9.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773247890; x=1773852690; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6d/LkdYVX1QbyofflI+RZNGcLNUAjGX4JUh09PCAgUQ=;
        b=Nwlvj0BVbN8Utke1RhkltAscrd1d1FqpJ1s0UaEODmtmVYQdaVJUEvJQ7itu4wx+oq
         9oLKQvvDhEPqC+QcOEejfkmGnlN5+viTT20oLKpDFBoVUv1g0upKO/FNwe1CMb+BooUz
         wxzZz8oZbmO6QwyG1S9YQTn2mC3myWyawdEFHX1DnwpAvlWrQEP0/a4hjoyIm7maxnZG
         vitM/lyhKWAfVNaMI2UafV/eEDW+ethPEp12T+BRnNChYzwen+C3R+oywdV5Z7uRsUlo
         UG95ZXs96l/2y/kcM9W42VKkWIpLrhZxJ8tJ7Ko6fCSU9MsP+DRU0s6P8XO81DuJIaTh
         ydaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773247890; x=1773852690;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6d/LkdYVX1QbyofflI+RZNGcLNUAjGX4JUh09PCAgUQ=;
        b=b2aDK1je3RbXEO8mGXhOvxEXTCEu42xjZxlsrMyoGTXxbgcmsHFJlUoxQ+U8JjzzJE
         r/9My6DcPWRufwcd680w8mu8Ve78q6ZEjjvWyqFaHyB9XwN4iimT38ISjKU22s4yqRTp
         cqaXX1xrvPmVLj89CAuESifvC37CNq59FguKBq1V8h295ueoZQN1w5STl3k0FoH0zSzH
         I6T13V1+w+fPXjySLv5tv3BBbXPuvk81cxojWzFhh1X1JHDu8sX51C+X7++4PqnRNJGp
         oF1/FXRQQJbwElB7buiHmdbidZotA7HnS6VXqK1w7WUQUIWnJpfTTsn/CKJbCNy3tEg7
         8ZPg==
X-Gm-Message-State: AOJu0YwOkYhRGhNpZJeqU+PTk7hhLVzHzXouIKj8LNd4av67nqCXAheN
	llEtD3MtvyzwQecf2JTjD1ejpuwCekP4TD4qu+XPfit3cprfMPr1sXjDlMsVaJ+v0YMLxCSUEbJ
	Thmr6Tl5HnydGBpVEVuFxMqtKPjHBmP+2TLRTXb+yoaSxhfqaBDCfQHC5UQ==
X-Gm-Gg: ATEYQzz5q9D6LOeeiJ5ZI0kQeqApb0onM2vGJBcR1yx+EgDVPxcS010rFfQCwIVMgef
	58ISLA1vXj1aD+x2V08iByF2G4VRK2tk9HvScuTYQPHt/HrxuFMBKjP+RnoDGXANlP6haxdqz6I
	Cxj29HYRysBdDux5tBFDFKuArQLQfdybdb7Rl2GHiDzwDoYkXm1mk0N4jg5UIWCXwHccOtsxcKu
	lWi0lqNfYV4sOU7DT2rUIboc5mnxi+gg87IeKYIXsXejz7/vlZtNUifgQ+Td0IAylogy239rv5D
	1be5KaecbmC6GZ0/n6/EM3JhlACP7d5wAHWvVQjLYHc1JHsHqm5f86Vlyst++8NKNR9JPDmaylH
	FL/26mWCYvSUNBCmJ1rV9QU95OrxX0IFLSEQUD0wA58vn67v/DotSkEFdG64=
X-Received: by 2002:a05:600c:a009:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-4854b0a3c2fmr63080555e9.2.1773247889801;
        Wed, 11 Mar 2026 09:51:29 -0700 (PDT)
X-Received: by 2002:a05:600c:a009:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-4854b0a3c2fmr63080185e9.2.1773247889392;
        Wed, 11 Mar 2026 09:51:29 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485419c2930sm275892925e9.0.2026.03.11.09.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:51:28 -0700 (PDT)
From: Paolo Valerio <pvalerio@redhat.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH v4 7/8] net: macb: add XDP support for gem
In-Reply-To: <20260310232119.1254817-1-nb@tipi-net.de>
References: <20260309144353.1213770-1-pvalerio@redhat.com>
 <20260309144353.1213770-8-pvalerio@redhat.com>
 <20260310232119.1254817-1-nb@tipi-net.de>
Date: Wed, 11 Mar 2026 17:51:22 +0100
Message-ID: <87cy1acnsl.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266707-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70DA12678F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 11 Mar 2026 at 12:21:19 AM, Nicolai Buchwitz <nb@tipi-net.de> wrote:

> Hi Paolo,
>
> Nice series! One issue I spotted that interacts with the EEE support
> that's currently in net-next:
>

Hi Nicolai,

>> +	spin_lock(&bp->lock);
>> +	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
>> +	spin_unlock(&bp->lock);
>
> macb_xdp_submit_frame() writes TSTART without first waking the MAC
> from LPI. The regular TX path in macb_start_xmit() calls
> macb_tx_lpi_wake(bp) before TSTART for this reason -- the GEM MAC
> has no auto-wake mechanism, so when TXLPIEN is set in NCR, TX is
> blocked and frames will sit in the FIFO indefinitely.
>
> This affects XDP_TX, XDP_REDIRECT and ndo_xdp_xmit. The fix should
> be straightforward:
>
> 	spin_lock(&bp->lock);
> 	macb_tx_lpi_wake(bp);
> 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
> 	spin_unlock(&bp->lock);
>
> macb_tx_lpi_wake() is a no-op when EEE is not active, so there's no
> overhead in the non-EEE case.
>

good catch! I'll make sure to add it to the next version, thanks.


