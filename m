Return-Path: <netdev+bounces-274134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEDtApc3zWlwawYAu9opvQ
	(envelope-from <netdev+bounces-274134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:19:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F1A37CE84
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6096430107DF
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41C4328B7F;
	Wed,  1 Apr 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Y6huQ0Sr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA01E1E12
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054799; cv=none; b=NvhSvvcKTztkWJKQ+kT1qgKJAtN+5q+ihW2rCVcduKpzfbwSTFo5CjIXEcjIla+I1p34YIHaQOIaI9U5reUUr+seSYjjHnaLi2Npkq9l0SXV1EfWYk6zE3vYxj7FsSnR1MIuRfbQygFtB2YIDR6I6DzjckNB8GO3TqCt1Sn1LcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054799; c=relaxed/simple;
	bh=JiSXnswUDUF47LO23pImSu3SMOjwZCmHwgX+M1cp5eY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROV9vm90ky3rxKggk/DfEmmYtd4obZWEjW968MrY1pDOEQ3bF4oV6ZL/bVlL5mQLkzL3KhlGOns9FCfq38pvTx65G3RF/wd4mUQ05iYKHLgzdlbHOi/tXEoUExvMMXmIWnY7lBRS11f87LWyO/Qkm7ec7Gh3FI5G13GY6lIrunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Y6huQ0Sr; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso6271795eec.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775054797; x=1775659597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft4oYfRoZ/X9cwiRcAvC3uw1qVfkVHb2EItjBcnB5Qc=;
        b=Y6huQ0SrZOlhVH09btc87C+QiKPBFSb9f89bHHnDwM6d9CZO8G73IgA/LMatlTuLCY
         1yCKc6UoMVywnPGhp/I0H+kkFnr1hBeI+Isks+yuZuoFkxGRR06ja7nmkPIbu/ZvuGRT
         B6ALOM6kHAkeJr65NRRvzL2hQK1n+wEH5A7KIWSeCmQayb0rCp0RsBGdZ4FyDFVYNxMd
         uHvCFSS0EwbeU6LT3OJDUUxa8LOiYq75SkG1dsHO3Mb4FQn74ci35ZhBTOGcKwF6UwXc
         1lKDA+XKmglVpBN+kEXhDob4dj0mN9XK8C+qxMprbM84QRMdYWeeQMzu1LfnvwyBfJeU
         D6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054797; x=1775659597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ft4oYfRoZ/X9cwiRcAvC3uw1qVfkVHb2EItjBcnB5Qc=;
        b=P1TyFxAowWTGhSzNdIth2iEgDn1XzXiDQQRXY/B3E9vVG3Ymi7yAXl3k/EzkGSKAby
         09X3EyOBbFliH3QMGzJUW5wSHRUr68SduH9gTn0eGzXvh6EIoywcfk5EDAqdBkkHORgb
         uAjZ2xTxK8lNciAAjQRUVxVTHWGtQQfiwzcai7+sQk0pp4ERrQ8CZQRSAfYFMLTJAArE
         5nWyHi0U7Ws9ugKC99zj1rf+nn6sdg8OiGOfKFeuUJMynJq/V6TJ0DZt/+LIfXVe3W6F
         1iphGFX/3nfBwuR8pj0zfkGIIYSP+SGV7XCamldAGWNiM59MPy1LQpVpc0SILiMo4pGI
         3ZGA==
X-Forwarded-Encrypted: i=1; AJvYcCVpSWG36GPNEaW83W9HikbnnBRpKdwSK15ynGYPNHTt35Y0fXTyr4tM4NVRjXnGsojaBy4yYLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLUiIm7pA0Qguxin4BHn6d0+M65INInxm/PI+WDxFZ9pazJxI1
	yXtPj6Uq4z4uwskx6+1kntEUIVMUf7+zxipF+JjtsfXilDN1Fek/n1JAoH/VTW/dmcg=
X-Gm-Gg: ATEYQzznAN44YD7LFuKrd6z2M5hdhCrTeKgTFmvcY4de/hjbHAtv9j6qLFDqBbOnXiq
	KAKGbWkiyPSJSFi+CjXi5Tb2gtQ34WfoLq/JMSJ7XTVxkYn2VJ9IYSs24X9N1Aj+ttgt3/gXDb5
	S/3qRpDpIF+Y3vslfMZccYINtePDoCg0vZQUUExiRRJXcpNxiYkAROBXXoQ29bYxy+xqUkXJ25M
	z65z7peDBIuYlpP3Qtki3pIXvnTvrD8qKo8DPwfXivMqbN20W3ZO6kGgLdfVqUlLTSVbNHpM/rX
	xW6pzmd8bdn8puzWantkycgI8Abizo6xVjnGR+BcrSzHU02s7BiUTZrtXoSZ1KKAT0Kr76iDW/B
	Z/LGOZzKnkxlbHRarThp0GiVQP+ouufJ9psRqSD8wmALDforkp/MwryE6hi/fC2hUfN37PVIzl9
	/Z2OYRdkdD42l3TwF8J6xWZLHGeEhYfgA0cBw=
X-Received: by 2002:a05:7300:2391:b0:2c7:2cac:8123 with SMTP id 5a478bee46e88-2c9307905d6mr1980236eec.4.1775054796800;
        Wed, 01 Apr 2026 07:46:36 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c8d8776daasm2917590eec.1.2026.04.01.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:46:36 -0700 (PDT)
Date: Wed, 1 Apr 2026 07:46:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yucheng Lu <kanolyc@gmail.com>
Cc: security@kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, davem@davemloft.net, Jason@zx2c4.com, kees@kernel.org,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, tanyuan98@outlook.com,
 bird@lzu.edu.cn, z1652074432@gmail.com
Subject: Re: [PATCH RESEND net v2 1/1] net/sched: sch_netem: fix
 out-of-bounds access in packet corruption
Message-ID: <20260401074631.60d11dff@phoenix.local>
In-Reply-To: <45435c0935df877853a81e6d06205ac738ec65fa.1774941614.git.kanolyc@gmail.com>
References: <cover.1773323637.git.kanolyc@gmail.com>
	<45435c0935df877853a81e6d06205ac738ec65fa.1774941614.git.kanolyc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274134-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,mojatatu.com,resnulli.us,davemloft.net,zx2c4.com,gmail.com,outlook.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 53F1A37CE84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 16:00:21 +0800
Yucheng Lu <kanolyc@gmail.com> wrote:

> In netem_enqueue(), the packet corruption logic uses
> get_random_u32_below(skb_headlen(skb)) to select an index for
> modifying skb->data. When an AF_PACKET TX_RING sends fully non-linear
> packets over an IPIP tunnel, skb_headlen(skb) evaluates to 0.
> 
> Passing 0 to get_random_u32_below() takes the variable-ceil slow path
> which returns an unconstrained 32-bit random integer. Using this
> unconstrained value as an offset into skb->data results in an
> out-of-bounds memory access.
> 
> Fix this by verifying skb_headlen(skb) is non-zero before attempting
> to corrupt the linear data area. Fully non-linear packets will silently
> bypass the corruption logic.
> 
> Fixes: c865e5d99e25 ("[PKT_SCHED] netem: packet corruption option")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
> Signed-off-by: Yucheng Lu <kanolyc@gmail.com>
> ---

This is the correct fix for the net tree. Will make a more robust
fix for net-next which handles non linear packets better.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>


