Return-Path: <netdev+bounces-272266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNiTBEmtxWlrAwUAu9opvQ
	(envelope-from <netdev+bounces-272266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:03:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A4D33C31C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 646F8303D3AB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F198E33689B;
	Thu, 26 Mar 2026 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HheJeDSZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiPjsoJz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EB32A3FF
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562620; cv=none; b=q6kO2o1PP9APlhLwAMoFqYL5lQKLKuzmqbFa1FPiGrFB8Semjo74ZeM/Gc1YNj53dMHo6ZcIweGlHdbAKgVxZdeEHZflWlwMHcpbwfFxt74ATLs0eSMeTxwUhf2d4/L4/DbeTrj7a2GrUu+eyq+K41ikWhe3OfjZMldynzWq03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562620; c=relaxed/simple;
	bh=/0I5PlNTDmo42F78lIX7rXVUcj3Vn1T+pJs/PmebPl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmdrHJyjbeN/X8OQQyCDT9gGxMwCu+GjzyF9r4Ka4S0lLh2LJCjtNoOrOOG805R0LgsztoiXRX6PhFVzxxFXdDwYJeHyZrmCst4YcivsNngaczH5bDVoG2B8Bph+RYTEqYSjnDoFjCatQwoz/k7sF0NWzRQ5bpuxCnYbRccYoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HheJeDSZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiPjsoJz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774562617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lpgob1tvHT4IKRz9W+hPWJKbEluQbBFuXgVxhpqe0s0=;
	b=HheJeDSZXc+D2HUtSd8Ne+tBU418qwkpfwGl5vY29faBCl10gqqdA3rbsG87WwS9Ef50PI
	5n3ZFahDU6x9KhqFl1x7OASUwTCYsk45NDP7nc2NmJky/1SiBTokdg+a8fxSZH+nnOpX8b
	0iWFGrTdHIXiyQi47kW6ywaQnJqIhuQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-zBCwDhb9P2yScNGSmV8dNA-1; Thu, 26 Mar 2026 18:03:34 -0400
X-MC-Unique: zBCwDhb9P2yScNGSmV8dNA-1
X-Mimecast-MFC-AGG-ID: zBCwDhb9P2yScNGSmV8dNA_1774562614
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso15776615e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774562613; x=1775167413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpgob1tvHT4IKRz9W+hPWJKbEluQbBFuXgVxhpqe0s0=;
        b=eiPjsoJz10dXgxEAcpTuDqkDtqydJOTYGojrrxbVhxYA0GcO12tv70RlsMbeWavyvs
         wE7k8Pvrq/4CJagj9Wmt+KO8n1ZGCNNM6LrqoxiweOqf9a+3yyQyw72sU95EmiEN8Oz1
         WLGHBUBUBZuJJ05cxVdYhZWM89XueTwqnbmLmqhfrlq0JfohgYb2DnlosWotj6YfUrWK
         TZsMi5I7AYxzQsVi9ug32CUIaeLakfh2U/TKBUvPi8ILfUW1ktDqnvPjTXxDQf4aJXMS
         oAptCpjHe9/YGN6sMcbKo2+MEqJHB5bhwYOzYaJF75fgffd8NU3kf1oNNYbTrnuAc8bw
         1FDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774562613; x=1775167413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lpgob1tvHT4IKRz9W+hPWJKbEluQbBFuXgVxhpqe0s0=;
        b=qF7yOj1ge/mqMl8gaKQZh+H1u8x6+qjWefiFAlk9LtDuHDpuyz+6Ejs4jf//GcaIrW
         pZCM/lJOCXVXnOetEZ0TTlTQ6kttwGXqGO9gAZVW40nLHfaVtxP+fMUrv9weDfpLwwrC
         eZKvrwF8qmXognLrcQ5BRvFaRwPAUsCURdftWFl78YTDyADZi+wpVGR30HN8XzLoqJ38
         z0Pq6uV/gNcLmHOH6K3rL7YyA8vMuvnYppyoYmF8+jb8Ph4T8L5mWKUW/gV8uLJ//nht
         H44ZVgULAvZ1S3y1XrYal9m8/yKG0rsQhBvhnf7GLA405RPKe3xoAAUhOzY1T+fM7ctv
         bSFw==
X-Forwarded-Encrypted: i=1; AJvYcCU0PMPA6Sa+//LMtqsCda9+QmlFf89OOC0SwF2kW1NNoznjxukMQuh4SsFOOHSXzl48CO2Aj4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1eqouj/J9eVqwdgPd5z81r0+OkK4O9sQ7OjS1+2c/mhtI05d
	1EhhnHLBxDucQMvzYWtTX7c6/yaX65ObXSK4b5ZaaGUKKnnSSpJISv6DFtxwRXYNtGQ0S2qy5gi
	TUv1CnmKTIyC2cTX86jdTzdswPdjybT3H4vjBg0vzj+M8rwb7vsTqQhPpvg==
X-Gm-Gg: ATEYQzxhBtdCPx3fPaFaM5c3OcQ8vRERpfCEMgC811nQU3X3pPEUrZcrj2eAtr8NTub
	X0VCWcNPFdU45gf2bUTSjRBSharYnPlEIU6FDr1kYIXXIZ1wnmaBrV5DwfgpDpkDS2lhBqQzM+y
	SFNyrAshBYPved6yBaL6hdFBzesZVAUA8H0dUIRMnOIxbPpOuKtj200QuzA0nSifqYfYU/9dlQV
	c6dgjDMBk4RBcP0BM4j0q3x4haOxXuSMRBhNHHLCX5kCB7uS5e8vcyNE0mURvxC1/Bh7jzOS3ko
	uBUJvzBDFswMCI+yKwANMEuRMgbtx3AvcT+PVT25LdC0xWaYwBilNOEkY6afsxE4+lMflNo0BkT
	HgKGenyZk9b9tq+4b
X-Received: by 2002:a05:600c:3d87:b0:487:1114:d42f with SMTP id 5b1f17b1804b1-48727d59da0mr4643895e9.1.1774562613602;
        Thu, 26 Mar 2026 15:03:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3d87:b0:487:1114:d42f with SMTP id 5b1f17b1804b1-48727d59da0mr4643465e9.1.1774562613107;
        Thu, 26 Mar 2026 15:03:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f58fsm90811505e9.11.2026.03.26.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:03:32 -0700 (PDT)
Date: Thu, 26 Mar 2026 18:03:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, Omar Elghoul <oelghoul@linux.ibm.com>,
	Srikanth Aithal <sraithal@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Vishwanath Seshagiri <vishs@meta.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: sync RX buffer before reading the
 header
Message-ID: <20260326180313-mutt-send-email-mst@kernel.org>
References: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
 <20260326181736.GV111839@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326181736.GV111839@horms.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,amd.com,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,meta.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272266-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: C4A4D33C31C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 06:17:36PM +0000, Simon Horman wrote:
> On Tue, Mar 24, 2026 at 11:15:54AM -0400, Michael S. Tsirkin wrote:
> > receive_buf() reads the virtio header through buf before
> > page_pool_dma_sync_for_cpu() runs in receive_small() or
> > receive_mergeable(). The header buffer is thus unsynchronized at the
> > point where flags and, for mergeable buffers, num_buffers are consumed.
> > 
> > Omar Elghoul reported that on s390x Secure Execution this showed up as
> > greatly reduced virtio-net performance together with "bad gso" and
> > "bad csum" messages in dmesg. This is because with SE sync actually
> > copies data, so the header is uninitialized.
> > 
> > Move the sync into receive_buf() so the
> > header is synchronized before any access through buf.
> > 
> > Tool use: Cursor with GPT-5.4 drafted the initial code move from prompt:
> > "in drivers/net/virtio_net.c, move page_pool_dma_sync_for_cpu on receive
> > path to before memory is accessed through buf".
> > The result and the commit log were reviewed and edited manually.
> > 
> > Fixes: 168b61da6871 ("virtio_net: add page_pool support for buffer allocation")
> 
> Hi Michael,
> 
> The hash for a patch with that subject in net-next appears to be 24fbd3967f3f.

Thanks, will fix in the next version.

> > Reported-by: Omar Elghoul <oelghoul@linux.ibm.com>
> > Tested-by: Srikanth Aithal <sraithal@amd.com>
> > Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
> > Link: https://lore.kernel.org/r/20260323150136.14452-1-oelghoul@linux.ibm.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ...


