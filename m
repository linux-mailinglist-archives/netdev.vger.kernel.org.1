Return-Path: <netdev+bounces-254014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMNnJGo6eWkmwAEAu9opvQ
	(envelope-from <netdev+bounces-254014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:21:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F949AF98
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BB8E30087A6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1296635CBA5;
	Tue, 27 Jan 2026 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="lIsE0a8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA03570AF
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552486; cv=none; b=VHEWGvZFYfthlVGMp0gwD8q4XYnXKtvxDyxFz0HHQipLbaRiP6CBNo3BuJpigoRrFDoW3UvMc3OzCAS3C9l3QsjbuYl7BXvCdW/x5dkj6nxy2pUld5jMZ5w9ZWp5lbodffoR782JFfbKKGIDiqLs3/74TlTtRiA5jw0ntAtei04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552486; c=relaxed/simple;
	bh=0bm1KvZ9RZh+xJqSgyXeAsRJGQKVVQZF2EVdIgQxwkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md2zcJsU3HOGnxKBEaLg8ik0GpMVPSTk2pR/0L1Vo8aYIS1hVkwyUg4khNvQnixWxe6AOW81HOetwTEOL+2mUifGxtzefG3CW6qWaO0NWM+Wq9BvquiRiqWKhSWayAfnxEOin+9Lz1R9CvQZ1V6Yq86oPygepvwlR1R0vESr/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=lIsE0a8v; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d2670932so5612797f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769552484; x=1770157284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10rIsxSqD2RcmvyIQ1g7gwllyOY4QtznnQ8CJGOxXHQ=;
        b=lIsE0a8vtGfxgWhJd2XCOu0CqTKG292Z6LSsyne/BmKtMXaYiZhyHvqFG+DuQtxvgp
         8Csf31JXsDroMezDJkym0SqWE4C+DD3WXG8AJt5PC082N+egd5CPtazXFUgMLbWZIVov
         Xt7o1cX4nab6/AwGsO08pRs5UXLCB/FJTGo9sbamjZfEHM4GzF8AJzonchjSPv73UBgy
         P6ydSG2T2V80Sz94q2StwQ1uNDHiC3VePWMZh6RlAsSCBhEOBXa6mrGtX9NokyREcqmf
         nEAG+ToR5Hj31CHK1nhDn7buC2nIAA1bngGo1Ic374EI5ShexxaWFy0/6IwlbMKm1AXk
         P6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769552484; x=1770157284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10rIsxSqD2RcmvyIQ1g7gwllyOY4QtznnQ8CJGOxXHQ=;
        b=Lg0tOR8UFnSI5B0ZLzfULUR2+12OxDmwYfCeWjzH70nJTOA+hNMEpP5B6EDwKhsmcH
         8xatVejBwJXEW88BRxK7XwtBkalXdEokr+hzclBwgdHLY0JDwqnIYEtawqp3kxg/Tz+u
         Wk/QEayBcXfb+IqSFhKPiXXt2lQ+mUqQgRv2LTOWJ8Q/BZSrbWm/lQ4s0H9wwsYXsK/C
         L/FTgi8tY26NrXZNZNX1aOArzM3xC1LUNszK0dXWKRCoXwp/CY0idAB74le5u+UEkPFd
         NSL6YU4AK+HnaUd8+ms3pcEAX1l5BkVoO3uBPXO/AO813A7Ip29VkjjuXQQqAMP3pXs7
         Zm4w==
X-Forwarded-Encrypted: i=1; AJvYcCWFdoHlSOJW7Mh4r/RMUpNQP1nfad5jQMzybYPg9HysE7rSEJnK1+SHw/lfr6VfiidzS7189C8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1BC3Bb7R9WC+PtS5IhQJJMTTJIqd9nq+g7LqjZXTGE21EKuMJ
	XcuRUv5SWyLfb1rvLuS8NLA/77S/g7lyIvRTaJpXJCFsW+N4+guKZVPn0cBEoFTtkMk=
X-Gm-Gg: AZuq6aIjalroKVPmAfieeLZ2AQ4KkfNU4IFQky/Q0sDdkkgG84CXR9m77OWl0A2dfET
	dz5KCQH5HWuBSLy+3IagteMUuez3taSPdAIrU7OCxV4stWfNz8Ag3k/oqFjt7NOzpOkw3ISYlZ5
	2eohZ7Yk9Jky87Gaw/yFQdsaVRx4p57233X4L/8xsxFBJ6CCl7vE0z/qln3270zcik+OKsS2qPj
	DWUNYXUhxOqnMjVvNLfuPhRkWEdx2eP2KYJACe1ETHPV4P0gI+dmxZNuduGK5+NUqi5TXA10Tw2
	dBVun+Zjbgx8py3aNjw7jiNU5D0leVrRbTZkCCQw8DfCMqxFiG+YxaN/aEZCVTy3kkD/KWdo8V5
	tnTSzBlbnbu6mU8+hmncL+bMosFv5lVOaDOYBsqGXtKE/bF+J/u+63Mz7AOGZf2pZwLvQ1PCkD9
	KYQbrbQTVisd/JILmpTyhvbZ/6Mv7p027s4k1EqPF+Fc/7QBG/P1/B
X-Received: by 2002:a05:6000:22c9:b0:435:bd00:3978 with SMTP id ffacd0b85a97d-435dd1d3268mr4741687f8f.60.1769552483523;
        Tue, 27 Jan 2026 14:21:23 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e483asm1844349f8f.3.2026.01.27.14.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 14:21:23 -0800 (PST)
Date: Tue, 27 Jan 2026 14:21:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, "illusion.wang"
 <illusion.wang@nebula-matrix.com>, dimon.zhao@nebula-matrix.com,
 alvin.wang@nebula-matrix.com, sam.chen@nebula-matrix.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, corbet@lwn.net,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, hawk@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, sdf@fomichev.me, daniel@iogearbox.net,
 john.fastabend@gmail.com, edumazet@google.com, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 00/15] nbl driver for Nebulamatrix NICs
Message-ID: <20260127142113.3309fc99@phoenix.local>
In-Reply-To: <20260127105304.21279cc2@kernel.org>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
	<aXj-uam1HodC0851@horms.kernel.org>
	<20260127105304.21279cc2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254014-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D0F949AF98
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 10:53:04 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 27 Jan 2026 18:06:49 +0000 Simon Horman wrote:
> > As per Jakub's advice in his review of v1 [*],
> > Please try to create a minimal driver in the order of ~5kLoC.  
> 
> Perhaps other maintainers will disagree, but for ease of review
> and to avoid the huge reposts perhaps we should consider merging
> something like patches 1 and 3* first, as the initial series.
> And then you can build up the driver from there in reasonable,
> 5kLoC-at-a-time series?
> 
>  * patch 3 currently includes things which do not seem machine
>    generated / like register descriptors like structs added to
>    nbl_def_channel.h and nbl_include.h
> 

Part of the size problem is that the driver has multiple layers:
resources, channels, etc and lots of code that tries to be common
across OS's. This can lead to bloat.  Very few drivers have done
that successfully. 


