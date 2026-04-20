Return-Path: <netdev+bounces-279849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPr6Jcxc5mmtvAEAu9opvQ
	(envelope-from <netdev+bounces-279849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:05:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A943082A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672E037051E1
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A841247291;
	Mon, 20 Apr 2026 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiwGyiA1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34722259F
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698532; cv=none; b=SUzS7mSe3iN9ed7VSo0IP3x71Apa1joT+Jc6dh1+qtsvCe+nKCGI+dBwqzfssBuBrlFghYAJ/Z/2UUHuwttvhh0uvx2DSY0fVAvsas+fNjFObLIFMRpBcummh+S+Sxx85ZOI9jTzFnNbFUZ/GYzj/vQK4ZSvKm3BpSkxKYUP4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698532; c=relaxed/simple;
	bh=AgRRhqr+xsgiNYhaHTvirxnepaiUqG3kn3v1saTxfJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seWt2qPKre4f8AIeEax42YWlcTJu83Yh+SrKi6JWcOXcuWfazZGBPsZijGPYpyRqQJEyHiUInVHe0xepeAh58npsq8AS7K38NXxEr5qxuuVQoPKijH+hXOLIbamXf3TvWxvspTVFbPXEgP/hKnflU8lt4WS8uVBARc6l5EB92TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiwGyiA1; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d9b21d1461so3378576a34.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776698529; x=1777303329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CmHj4qLUk/zUhVqmDWix9lzF21N06q4cYXnz7D8gDJI=;
        b=EiwGyiA1y831fauNR7yHPrVrXw/yLeg8qQFUlhLId50UO1bNl1YuNYOtRjB7bQx3yA
         lkMqYbJaK+ROo7Evn9Ce+cNeHXpBYKu5Zn7Q+Tri+SygF11Gh0cF14N/jHT84u7Yk6CQ
         7d5vNcKtl2WtgzlPiavTn6DL/xrxSy+tGUuSWUaDAdrK7BTSfoykR8Gr9BDpLNX1u9Np
         ++CMT8dvFAXAKrN+dcrbh78KSgbugLZIeyQTvUV6k2kH3bucEdtjVePQ1UhXkqkvCzLx
         +lHLnVMhLDo9ubmThfF0FmNr2i0fgiS1RNj9kRcYtE/1FMQwXi+j50h9RcJU0vijaEIw
         SGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776698529; x=1777303329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmHj4qLUk/zUhVqmDWix9lzF21N06q4cYXnz7D8gDJI=;
        b=jNKL024vOl+3PMYxgbIMcfALPatMUU1ELiHGjTvpPqbqLluyQjjq5ltmGTOpxpFLwL
         ZW7Q3HaOHyCR7aYS+bE6jdpNCunJKJqVteakQRRuF0DYtBCpROiep1Bni1IAqHY38LJ/
         oK4so1BwOFetisVoeJbKVjzFFrEunxP/6UUEMLYjWhnOnwt/m8m/3FYEi81SkdV7OPtD
         vXMtp1mfUxZbONP/+gVCp/0GKx2EGwIRyP6RsPvMzEt96Awo/grZN7HJFimUFaEKQQzi
         XBMCZpjQHr/7EbVnsrhJRr2JH7xhN2J552+h+utw+A2p0cDzngVmrad/2CQsAgIgPOzk
         sNMw==
X-Forwarded-Encrypted: i=1; AFNElJ/m7SxFekpJMYMgqPtTkdxXJE9AQIYmNOHDKg0ZWfuyKmjLMB4OCqL7FjNNmwmGabFdDsWTRis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRZ0hQbFtSd1vxGkm/bGt8QYrm04F5YjC9RvvsINnowsa39xaq
	KLklqPZIOgTefRfyudulx2k9YvRtQ4nz7Zznz7II4FzP47jfqpygAxg+
X-Gm-Gg: AeBDiesuBYh12ichzgkpA+68EUQ+l4ToQqNFwoOHKJNe83wJ4vd02hFxZQM+rWEaFdN
	XGyk+OEJ3BqGtn3cYI6PsSNQlDd/7Xu9jJ7L8e4JntuFeBDqDCQXNDOYBQf7wQWnwxcp+7liHoK
	X7T1/Hl1poBgsnF3nXAZL0a6YiwrCBjAmzWoo06s6Yt+D8eUzCz0pe6Q5fiSIQjjtV1LmVl9+/d
	Zwz+xL1K96tJN5eH5CTCg7wh10su072v6L7auEOI7ixjfwTuM4tqyH32e0uxdiTGDy0bgGtimLm
	vsceYOcQM3v6eS64NnoCc6kPi2D+Wu8B+4dmqAWYIFyjDCNLBR67hcXBoE63wQ+WmYH8YwE0aOC
	Xr6KXWlG4dmXGxEl3HsHyIJCwCV9IwjmVSS3XqsCxhZ+kN7M10E+wxrgTBvs7jEGCOtFy8poxWE
	68LUkAUB77MnCTV4cabr0OXbF2mh3D
X-Received: by 2002:a9d:4006:0:b0:7dc:cb0d:9e02 with SMTP id 46e09a7af769-7dccb0da338mr855442a34.9.1776698529551;
        Mon, 20 Apr 2026 08:22:09 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc953e39asm1510189a34.15.2026.04.20.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:22:09 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:22:07 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
Message-ID: <aeZEjZSsVIdpcbFF@devvm17672.vll0.facebook.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
 <20260418045644.28612-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260418045644.28612-2-kerneljasonxing@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279849-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm17672.vll0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email,fomichev.me:email]
X-Rspamd-Queue-Id: CC8A943082A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/18, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Fix it by explicitly adding kfree_skb() before returning back to its
> caller.
> 
> How to reproduce it in virtio_net:
> 1. the current skb is the first one (which means no frag and xs->skb is
>    NULL) and users enable metadata feature.
> 2. xsk_skb_metadata() returns a error code.
> 3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
> 4. there is no chance to free this skb anymore.
> 
> Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
> Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

