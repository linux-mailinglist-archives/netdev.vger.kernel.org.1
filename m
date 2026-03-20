Return-Path: <netdev+bounces-269948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCPWD5BivWlF9gIAu9opvQ
	(envelope-from <netdev+bounces-269948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:06:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E4F2DC4CE
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE6BB316170A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6B529AB02;
	Fri, 20 Mar 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyNNB64P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC332DAFBD
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018888; cv=none; b=ZVmfIpJ0Rlr0+jqldgft30NJ7myMQSvjknPOvdcxpbnWhKSAqGnPlmkijugxez15pP75kH4jbvsyKFAdLC/eY8R9BHHbBGpTeHfZyy8+iHs0JPzivy2BAkjy/eAgxECeSKtv78Iz/HVyN3YjYW6qZLNfnPNpN/6k8zX+XMVwM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018888; c=relaxed/simple;
	bh=81fgBQ2PoBDRpMrjDmaoSF9fxh4ImUjoFWIayUMvmSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDRQvvenUdLn0upMBErne2rCEtaIBqn6cUbOmcjg+V/D/xpEIcv3FMsraDkpUt8B0vCQLyMKvcSsqzE6D1kUOh4RmjxLw2kHpEE6Lt7FFvY8G/3jsb+mbeCREcL5+xGGqx7bEJEb98MSMqh60uGaVmRHn4rRk9mKxJJOp0TKZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyNNB64P; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7c77fd31cso1810001a34.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018885; x=1774623685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+O+9zRpBumJjQs1Qrw2RwnISTo4eF51n2sz3tSLML3s=;
        b=GyNNB64PuGEBOqrvvoQG3v8Ini/H+i7p2Mtl1wv3kgLDxh0+KhJheSYhv8VQc5rEAG
         eBbYb15Zf2ekTiH9Xb6cR7Gg4RhpJhNf3OgaWtM5SRKYAODcT5toaAOM86RdD85dUDrJ
         1F83oTFTy2uCQFgtJNkE2Cnl+JA3gqC4Cp1YAeSdclMqpQE55XBMFNJotNuPOWKKNY+c
         5r4nndlK55DG9TfMf1K9h5INhdVa55o46eahwRCKu5DBi29c64tIt8pcs342s/pcNmoA
         eDWac1w7lk/Uj4y78M+iUwbm3O2yFcRvpVnrvLd7GKFNTtU+xnamryhB2PuNK7XaFWCZ
         5gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018885; x=1774623685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O+9zRpBumJjQs1Qrw2RwnISTo4eF51n2sz3tSLML3s=;
        b=Zt7Bs6m0CHfsw4kY3VN1bsvOg8TEm0muU3HOOjkHdQuoMO9BKTObmvYi6/44+F9NG1
         t5WEwDht1BMsZnXIiLzOEAK4sx28KXKidY0itPnRL5tLI77337zn/H9Zz13sgyZW72KJ
         qn/4ZhS/jbQmlrFdeRmXRebe2p/NkhREBYll6aV3slIh5M4tXAW6S0vNaxz8tmJBZ+t3
         GGAkv+DUVWYoo+d9u8sOwtM2ZGLCT0iQc8bG4FaaraA3G8aAvH7Wr04yRjyeMS892nuj
         wec7+RlJ5nPCZeddOn0erb+6jfXjGJmQHEehrV8i/Q0XHDtL67kfJeAmIyLpOnn8U3Rs
         s8hQ==
X-Gm-Message-State: AOJu0YxMDS/C4DXSxqrD/neo5WWBUMEKDo+VuKBNLau9bcOS+PRQKuQ0
	tjaT9BHVIxN+txL7exKKI5q2OL6SpTpJKAjVlR/SJ229/tmmySK0Tz8=
X-Gm-Gg: ATEYQzwvEKwvGjd+x2FSnuBzLCyx6qrmUOXmluciXCxVhc8G7kkqzYJOe/rgERpiVSL
	oYNkbZ+Ne9NpVQ1d2htKSNvjaDVcn0kYRqvdS+DWuduHJDjqjBgM8yD+/tFeYhZaXchWfeKVYan
	c9sRL9bDUOlAJ5FfuKmp+5sMOW5lYPW9ZPkIdoz5wDTPlB1t0U/VDLKWOrrMc/KI9CVP7D43bge
	7gysXwnsKr5t2GwZEieS16+q84j0ibSwJUNNVwrmfeLORiUbGNGjvyxtpY5tiLFfOXYrLbe4w5l
	7iOxXDuF16e23a36DtI0O8etwi5+jfPIyaMst3VPaHdsN++9lAaU4UWiJ7n/zlA6qxCl9cro4cl
	4sFa9/GhwpC+yppxnSpnYasqxq8lWD9F/zkrXXrmDyTkikF90tTRUwvLcfXVFREE3U6HJf3uKJV
	PAERpEmy3xtg5ti44KGQBK1W+TozBp9p9R4VaO7fgp/RKW9bi4EG/+g+1hzvoxEY9mIQI4CU8zj
	QPBWl/5GDjSvz35pw==
X-Received: by 2002:a05:6830:67d9:b0:7cf:da97:57d6 with SMTP id 46e09a7af769-7d7eae42d5amr2059854a34.6.1774018884112;
        Fri, 20 Mar 2026 08:01:24 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadfcf3fsm2296061a34.20.2026.03.20.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:01:23 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:01:22 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	larysa.zaremba@intel.com, aleksander.lobakin@intel.com,
	bjorn@kernel.org
Subject: Re: [PATCH v2 net 1/8] xsk: tighten UMEM headroom validation to
 account for tailroom and min frame
Message-ID: <ab1hQjHMj-LJJz0I@mini-arch>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319175538.479139-2-maciej.fijalkowski@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269948-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,fomichev.me:email]
X-Rspamd-Queue-Id: D9E4F2DC4CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/19, Maciej Fijalkowski wrote:
> The current headroom validation in xdp_umem_reg() could leave us with
> insufficient space dedicated to even receive minimum-sized ethernet
> frame. Furthermore if multi-buffer would come to play then
> skb_shared_info stored at the end of XSK frame would be corrupted.
> 
> Multi-buffer setting is known later in the configuration process so
> besides accounting for ETH_ZLEN, let us also take care of tailroom space
> upfront.
> 
> Fixes: 99e3a236dd43 ("xsk: Add missing check on user supplied headroom size")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

