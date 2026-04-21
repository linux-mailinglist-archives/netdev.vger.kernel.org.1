Return-Path: <netdev+bounces-280047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDCRDWQ652no5QEAu9opvQ
	(envelope-from <netdev+bounces-280047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:50:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4185043862B
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FE97300B286
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1362937C0F8;
	Tue, 21 Apr 2026 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZU3qDPJK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUZBopwT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AE1C84A2
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761370; cv=none; b=hGL1YQqIBg2jfHyUL44hvQXdkJNNIUoxmotRNWR4VuzomCjJIv2NXBlZI/VKmyn9cxQqBfg1MiE4tF04cUVBndcvuZXQ21/YCHnYmU5ItpUNP0OfQ6SJ9pY0CVeKhi4cdJwT+LRw6tZTOfetzqsGe6C5Jy27XCx6czVwHcOqbq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761370; c=relaxed/simple;
	bh=5JsshEzSWKkHHybeMjzuOi1TJBB5BJquoeXBOVXlaJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctlHJPVqE81YnfOy2IwvC8KRLbyWxUaY/qC54+4U2eFz20D3TXQv8fH1/Fb7GTB3FzFW3GYmN+LSZAa3CNBoOxcJe/5teUADk0GLySFyAWedabSdq+3qlrmXrgzCVTOtq9I+dMJGOdHviiQwuN006tcEilEEpqWyan7HoIbApgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZU3qDPJK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUZBopwT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776761367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dM9QpEa1glVvOOAGDNSNRupzn3Y+00X/KBAisgsGArQ=;
	b=ZU3qDPJKq1Ez26tTasFHZvjiaMP3B5FGUzu7PViUIhLAQA7md3EMCdVIDR+hwsXYn2la9f
	+K4hdb0+m280hx0LUWIgl1FgSBmIeLfDMQXht1x4uDMCPjVPqnHAs80OzN4UxkfhWFsPLO
	Gg257FMolqSFAuFeUbEGbse1+f6b1cQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-DxHDCFOmNAmYD2dS3q-ugg-1; Tue, 21 Apr 2026 04:49:26 -0400
X-MC-Unique: DxHDCFOmNAmYD2dS3q-ugg-1
X-Mimecast-MFC-AGG-ID: DxHDCFOmNAmYD2dS3q-ugg_1776761365
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35d9f68d00fso513420a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776761365; x=1777366165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dM9QpEa1glVvOOAGDNSNRupzn3Y+00X/KBAisgsGArQ=;
        b=GUZBopwT2Lqz7xmtwyln0Wd/xOyF8y0E2AetOfdfdfE3a/V4x9LHEF8kU6vwff6/rU
         4HcCYwl3o3cDKthaYV3Nl5ehhZ8tpyvmvg0OsMrGUqq5d9I9I5NFPyeOX6hYU2pyU6cg
         GnsIC/tXAqK8dn6iPlxIkuSqO/23oSuX/YpnGUmCC4zsuKz0EAsO89ueo4s3QIoowG2h
         6fK//Q4mu9v3oQKBDDaxJpX8Q/XIJi2Awl7Cb8ZISXdYVZD7bVjQ0gTqZok7lJATJTuD
         xaphl4Ewmu9PBPHb9Smi7RK0+jGG4TSt2au+KyqA3TjvlOhKsIYcbO2EgF41LNDoYf0C
         s3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761365; x=1777366165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dM9QpEa1glVvOOAGDNSNRupzn3Y+00X/KBAisgsGArQ=;
        b=nOaFTbry90dPufJYDbfobOmX6jM3FVAmQ+ymHkQl9rPl0qnX4k31iSx5fJbtSMLhAn
         WMDR8efxgyzm/KdNkwPWWWpI9TwJuw2hUbkj5q6dedoAsj9ROYItkrLqcmNjJeMvs37L
         Mxjyb7mZo06l2D9tL16RG/Xnmm2d1FvSLy0OsGRJXZmBuKOcbb7QPDDV2hqM7NRCeNck
         xzw8PDDv74+vzA6KLl6Dx/KtH7evxkhgPHQcNI8NzR6eZbY5VrqGkU0UdpLXKW7/KJDC
         2oPupPkPkV+7oJGt4zcpTroe2f4Zq+QVditHCSU27KzCJluHEUyciEWskGvtFIDccA4Q
         /X+g==
X-Forwarded-Encrypted: i=1; AFNElJ/8fdQVFtjHcRknKdu+6jFnKITCRS/l3Gur4eq98xV32aqpVgqhmNtNzE7bb2+5d5Qaw3dy3xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7e5u/Z7M/WBZlhkFbQuOWQzYl0ZmrQNPXVPzzV/aBOkeIigu
	OewZLl6EJqXNVz0ghMljXj4FsEuHoFF12o9a8n4j9vWas8kuSB0GNGC5iut2shpX/wu38swaws1
	nBDQ38OiIgcjteNZ0u1IW5zo1RJY1QeqjmfS37OMrnR1hhoeijGHJgVEukA==
X-Gm-Gg: AeBDieva/v/YwRDUlUXa9QPxQwFD6KbxaySSBaPBBOSBvimnaMtK8J7+clfQM7EoSPD
	5ZbNCFrHOP3TRUIcTi+pOifbuOxvPethwEj7Ud1k/NYGKeH6sQmTwnp0s0Lg6//tvMUTkkBtmvG
	WGoVvoYMtAK6H5HRIe0m/KgPNv6mzaLDeL3O0EYk1iFlvastpn06sPcSnSM3v3b0Hx5Tydxo5YW
	nci7Zn9bHoIJx5o4O427XgkRgm1XvzUXz+FJUzgvf3+rttoyIlLdDAnYwCtTgsl+gnAM/wD80CS
	iKM8Uu4j/d3AqGZU11mY+bzWS525Ox//IOzeGu3LJLA5Cek3vQmUkiP8bamWQBJCpsh2aweL+9C
	PU56ltfp7YHWuchcZ14YbYPb/G7lVp2yTLjO3faZ7+R54uIS7xw8W41Tnee9eRHMKfa4=
X-Received: by 2002:a17:90a:60f:b0:35f:b137:5a63 with SMTP id 98e67ed59e1d1-361403add26mr12204453a91.5.1776761365207;
        Tue, 21 Apr 2026 01:49:25 -0700 (PDT)
X-Received: by 2002:a17:90a:60f:b0:35f:b137:5a63 with SMTP id 98e67ed59e1d1-361403add26mr12204426a91.5.1776761364789;
        Tue, 21 Apr 2026 01:49:24 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141869e88sm12675045a91.1.2026.04.21.01.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 01:49:24 -0700 (PDT)
Message-ID: <d306bbeb-141c-4a44-bcc0-2e2c5d51efd5@redhat.com>
Date: Tue, 21 Apr 2026 10:49:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] net/sched: taprio: fix NULL pointer
 dereference in class dump
To: Weiming Shi <bestswngs@gmail.com>, jhs@mojatatu.com,
 vinicius.gomes@intel.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc: horms@kernel.org, vladimir.oltean@nxp.com, xmei5@asu.edu,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260416185501.647884-2-bestswngs@gmail.com>
 <20260416185501.647884-3-bestswngs@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260416185501.647884-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280047-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,mojatatu.com,intel.com,resnulli.us,davemloft.net,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4185043862B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 8:55 PM, Weiming Shi wrote:
> @@ -2196,14 +2199,14 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
>  	*old = q->qdiscs[cl - 1];
>  	if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
>  		WARN_ON_ONCE(dev_graft_qdisc(dev_queue, new) != *old);
> -		if (new)
> +		if (new != &noop_qdisc)
>  			qdisc_refcount_inc(new);
>  		if (*old)
>  			qdisc_put(*old);

Unless I'm lost, it looks like taprio_leaf() can now return
`noop_qdisc`. As a consequence, `old` can be a valid qdisc, NULL or even
`noop_qdisc`. In the latter case it should not decrease the refcount, as
it was not increased previously.

/P


