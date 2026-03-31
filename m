Return-Path: <netdev+bounces-273432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ufjKCxYly2lnEQYAu9opvQ
	(envelope-from <netdev+bounces-273432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:36:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7547C3631A8
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65988301158F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9142C22B8BD;
	Tue, 31 Mar 2026 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhWFJowV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC31D416C
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920871; cv=none; b=pHZLqdwlcFQgoZrH/Lklxow4/QfDTG4lyBuLD3cXSrcjadxLMpAPFewwReW46HWfKgkhnmwZlDwIadc9j0xlzOzyW4Xoct68JnARZBi78dRDyjAAJJS6OQJBSZGK/ee6aguDvYfo2dHA8dM6nxgtHQSpYgSRZSzXIwLgIQFEjvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920871; c=relaxed/simple;
	bh=FYk+decOiXv+8xnv+BvgZE/TlqYk9oygaqDmoq1JjiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rql0zhRWOHNI1qvWmi4lAoPkB287+gwN/02+scm7/CLB6sq7+hFCDHM9fqq4FBBFbze2utLxXZ/cg3o6cApwfHrq4t4KQUckR5ooh4AELH4GOhhWZxxkqYMaqJIlSkmYlBZGLS7vcPiN7O4UoYegUygbtpF74bZ/Y8qWDRboPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhWFJowV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d9827661bso1235963a91.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 18:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774920870; x=1775525670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zj8A8/B1hK2sNcQ2UY18qL8YDsFqA2hJyd+WwZkuce8=;
        b=WhWFJowVge2Ie+YGnEJLRJS7ZRWwDbp5qHh8r8Mfk9zWdZ0842V2v09iCvdLylCuLn
         kv4vQDMSPimxKAnSAfc2saMJtnOjw1XXFc7+XuFHU5zkmS860SBTzKd6+U28UXL/eU9g
         o+6wh2hwRQvsJhize4Db27qKJKQTi1OCRpQdxPCg9V1sgW6AvrIIGafwkz0Ksd3VWhek
         /VEA7ElfsWrRUp1DXr+x6lDyRbveWcxjK/vLOnImRz3odJMW8KrLyLpZYhAC0ldbKVgj
         D7SVUM7VzUTmepQ5ZJmyRnIVkZJlfgvP1HVvqY0NZb39Ym76/gV3yAAy5oEpAbeMNtgX
         Fv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774920870; x=1775525670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj8A8/B1hK2sNcQ2UY18qL8YDsFqA2hJyd+WwZkuce8=;
        b=L4YhxqXWp4nj/jSeymUoulikwc6lR2KD27gecZZhJsK1u7smwLQXUk6qnSeXLQxA5M
         UAOrJsFBYamo4yv6RJzDQmjeYt4krw/+amIXiYCEQoIuqENgWxOSUQ9DyI+YS8xbBA7C
         4hKAgc80ZFrqmO40qjbDEQ+c/GyF7iv/hvzogfV6Wlcvi9B5i5LWbWvtUpxp3k6enI3E
         tp5VrSGfomdYWo5LMA5X6djlhVKN+i/A5h8ruzv2PSNwR9xp+gZTkxykjNlA3Mo+3raw
         InmtsfgdE1Xxmn5jN+p9tp2hoi6Widgvlqlsr/ocLOoBV4lpr4JKS972fLvyi42FBOUs
         UqQw==
X-Forwarded-Encrypted: i=1; AJvYcCWJe4uudmw4eIzD/XeWDR5KHJ7J2pzhG3B+y9YwR/2rt/ZrxHBE8bXUpZsINDukxicCLhnibwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybhryq3SFjdxqNU+rQNnLg37GProLN+TB0yl5Eg2H5rj5K0aQH
	H+IqEEwIBiP8ze4xuawhfMyPv84oVfg0voNdet9CZ3Jkms8YA6m7iTf+
X-Gm-Gg: ATEYQzwOWrCPBlxvRTTqwOCHQHWC87InE/K1aJedLFfCjWujjNXOG8o2YFoz6DIxFi+
	zAMY8USURtY5eY6kxmXjKu80G30vcCg6MI/Lb1G42hYJHLrfWMFQfd6wLE0plDJ9MpftrrTvbCC
	X/C5iKGkxl7SOe9naTnidxUCQCM6qiLmlFkUYYorlyoy+5PnrODpV96VC+dT8VB8Q8kFfV89e9m
	lueq5U5Z3owlX11abk8V1CI3LZ4ODSSvm+i9N0QaVf+n/ofNi1QDC2FZJtuU71Vc/ezBCHyvv+4
	NSX7O+DbUXMabNhHBAuDn2OJse0KSc/8jyCE86tSKRWrwJUM8KaYKvkedZ7h/fcOjShmY2DKfGe
	fh5k+9srGAWwkKxjjnjYnP0qEj7zlwDkaH2kY2aU7QqzVl8if0JuXpWD5I1eMyLzkgmwqx9FnzM
	5OSzHy0WuB7+xCIsbqqvel61xtCbo=
X-Received: by 2002:a17:902:ef0c:b0:2b2:5637:1487 with SMTP id d9443c01a7336-2b2563716c8mr49870375ad.34.1774920869737;
        Mon, 30 Mar 2026 18:34:29 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277fb3asm99887165ad.57.2026.03.30.18.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 18:34:29 -0700 (PDT)
Date: Tue, 31 Mar 2026 01:34:21 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Fei Liu <feliu@redhat.com>
Subject: Re: [PATCH net v2] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
Message-ID: <acsknTbxa3REYrlS@fedora>
References: <20260327-b4-fib6_metric_set-kmemleak-v2-1-366b2c78b5c2@gmail.com>
 <7e8c45cb-b5dd-4694-80e9-7c8e5ad9ade7@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e8c45cb-b5dd-4694-80e9-7c8e5ad9ade7@163.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273432-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,linux.dev,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 7547C3631A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 07:22:48PM +0800, Jiayuan Chen wrote:
> https://sashiko.dev/#/patchset/20260327-b4-fib6_metric_set-kmemleak-v2-1-366b2c78b5c2%40gmail.com
> 
> 
> The concern about reader paths (e.g., ip_dst_init_metrics, fib6_pmtu)
> lacking READ_ONCE()
> annotations is valid — if the compiler reloads from->fib6_metrics after
> inlining, it could produce
> an inconsistent pointer/flags combination in dst->_metrics, potentially
> leading to a refcount_dec
> on the read-only dst_default_metrics.

Thanks, I will fix the reader path separately in case I missed anything and
slow down this one's process.

Thanks
Hangbin

