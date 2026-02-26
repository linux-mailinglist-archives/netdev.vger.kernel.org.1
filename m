Return-Path: <netdev+bounces-261282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJU0Et0joGkDfwQAu9opvQ
	(envelope-from <netdev+bounces-261282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:43:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3E1A474D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9953F3049265
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F93A9D83;
	Thu, 26 Feb 2026 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBoQo9jy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9198C3A6404
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102611; cv=none; b=Mcvuw6u6vwkpYiChoGHNnO34NdUYKRfgYqRj86uWBXOWeqbBsbIHYgLlogtJW5rqhV7Y56zPWiy+sLgzdvWwaZmHF5nW3iRj/zPzFPxN2FSwtTwzHpQFlCl1cMb4kcRevRrGSQl2vSxfLhRqDPrMUr8pNR4UZj4EZl9UmCEpyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102611; c=relaxed/simple;
	bh=RujNMISISbGmip+gsV3i8B5HSZDusgL8kyOq5K5N+GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAdxvC6SzW8rYfP+H8WuaqWbJweWt7gxqpZdU9Sp9p/C8Ipr4+BFFVvF4FNzl7wfK6CKy7xhjvsHd2qozjyiaMLDuDkQ9+z63bFj5FK3R9xavdcUsHeXBe6T4ykoxPDmBsov9NVhYPqa+LUM4CMbo5ZM6Vhe6iCWFyHCUv8NM78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBoQo9jy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-436356740e6so722833f8f.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772102609; x=1772707409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYnij3WUKIrhr1paKuZQio94gFo5v03yqnu75blnTg4=;
        b=CBoQo9jyM2yTd9XTP3GjFZB0m9pMVVnC2KlMwc2WiZ7WiOUQpGdw7D+lYXneZRk5f0
         wxkMaw4uvOPqZqMYYYOCI1O6ho0Lzzki+UltNWUG86IdXkudyPunvO3pqAQloLHfaovc
         q5HpYO2LLE5fFSqLQqZZNlHAyFhzpF+JaDP87ntt/cmGLiYoPFhzYAPlE3ppb8T2qt9o
         DTDNBtRRk0cRb/d5DGG5ySIr+L5vYHVdZsGJvtlZepby9vw7hPrIi4u/nYQi6o9EvG+F
         4NA36HIucCRbzCPXhgOfULLFLOd/UykxGn9CkyF6MGX64m/7jU/S2vV2d9e4M7JZYMwZ
         UMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772102609; x=1772707409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYnij3WUKIrhr1paKuZQio94gFo5v03yqnu75blnTg4=;
        b=VRZRuQBcT0DJ9IqKAe/3ACBi+X3xbxUgh1f3E18xdhmPXspBiFAHEzoJmpPubuL/qk
         YPJZ8CouAXBeKLzjBZfi1yRGNpizcjNjvFZQF2V/Pe8f9WRCfqJAjLqCwcb4rg99Q79B
         qTk1PkL0vuubsCwTbgza9z2NhITDWDIIBTMba97pRooUJovc+Xhj1gMFaCbf/Bz/1t8s
         udpl6hmqUMLPHuuq1Q98SlSmEtnpn3g1U3M5vhM1RFmH47UI7WvADb3fI3yUREhFhceI
         apIpcnUQ8UwEDkbqsDHj1IAUzkOLvyNmjzU6foBOgYH4MQ8L/CocA6QAsmpjcsWMD6aD
         0lCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnEATxYa2PWwzu0590l38Wi1PejrSxLaNPJ14sMOD3f3PNOqBLBZ22vQ0Gx85Zp211TdVc8aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5fyhhMsdVAqJcb26UvqaI4phmha0HJhk9VMjtcPgii6lNpli
	o+aBsLyQlMSvhYSRqnY7+pQiREPJngMFFeOoAo5CFpisVACAwaq3ZFee
X-Gm-Gg: ATEYQzyIbXGqppcAt3NotCN0J8yrRoz20eKFq1EUzkEkXpQghHvYsoB43l+8BuwtlJ6
	PotE2KJuzxXQOzpm2ph34XlSLaVfe1Iq2tGBVYr1rGLk/6/fZrmX2R6T37zzfUqG6vzQf2THPxs
	pAMesEDyy1Vg6a0Xsmuostja4Slpe19VCt0MmKWz/mXbzQzdoq0KLz6D9qfGPXEPRyYU6nGZr8B
	ln8aEo4zio+A4zpyduBK8DO/fSstugXD4oeNURMkr26C/5IqJvDgaG5/BQLS0rWb1qklcVHOC74
	8vE2LtalDlcoBUkX9JONeK7HjHVQT9YZ+CCxx6QkZjX1kdcJkxrmGYThwOeXF51cNk6zu4vC5h1
	dgoLfj5sky2/B8qLYmazUJpwMF284BOIyZagV8T/gmpZ2pNpySKJcGWV42Oi1LYEXst6AZstjUA
	xIUMOhNk8xRYd8ODmH2twNyWQhkUwnxX6dDjBJxoZzrFUDM6AUA+TfoJWliKRRI9tANQkGZPQyH
	5p1ObaE3m2zBVDA9xFlN4E=
X-Received: by 2002:a05:6000:25c3:b0:439:704a:9838 with SMTP id ffacd0b85a97d-439942a422fmr6869715f8f.19.1772102608659;
        Thu, 26 Feb 2026 02:43:28 -0800 (PST)
Received: from gandalf.schnuecks.de (p200300c14f1996009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f19:9600:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9ff5sm42355609f8f.4.2026.02.26.02.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 02:43:27 -0800 (PST)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 840D52FE34AD; Thu, 26 Feb 2026 11:43:27 +0100 (CET)
Date: Thu, 26 Feb 2026 11:43:27 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>, Jon Maloy <jmaloy@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
	Shuah Khan <shuah@kernel.org>,
	Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 0/5] tcp: RFC 7323-compliant window
 retraction handling
Message-ID: <aaAjz647AueLYvjl@gandalf.schnuecks.de>
References: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-0-aa3f8f9cc639@gmail.com>
 <dffe019f-93be-4fa8-aa29-743450f6c05f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dffe019f-93be-4fa8-aa29-743450f6c05f@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,proxmox.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-261282-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ietf.org:url,gandalf.schnuecks.de:mid]
X-Rspamd-Queue-Id: 99D3E1A474D
X-Rspamd-Action: no action

Hi Matt,

On Thu, Feb 26, 2026 at 09:12:07AM +0100, Matthieu Baerts wrote:
> Hi Simon,
> 
> On 26/02/2026 01:49, Simon Baatz via B4 Relay wrote:
> > this series implements the receiver-side requirements for TCP window
> > retraction as specified in RFC 7323 and adds packetdrill tests to
> > cover the new behavior.
> 
> Thank you for looking at that.

Thank you for chiming in; I know that my comments are somewhat
provocative. :)

> > It addresses a regression with somewhat complex causes; see my message
> > "Re: [regression] [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks"
> > (https://lkml.kernel.org/netdev/aXaHEk_eRJyhYfyM@gandalf.schnuecks.de/).
> > 
> > Please see the first patch for background and implementation details.
> > 
> > This is an RFC because a few open questions remain:
> 
> (...)
> 
> > - MPTCP seems to modify tp->rcv_wnd of subflows. And the modifications
> >   look odd:
> > 
> >   1. It is updated in the RX path. Since we never advertised that
> >      value, we shouldn't need to update rcv_mwnd_seq.
> 
> FYI, with MPTCP the received windows are shared between subflows. This
> might be surprising, but maintaining per-subflow receive windows could
> end up stalling some subflows while others would not use up their
> window. For more details, please check this section of the RFC:
> 
>   https://datatracker.ietf.org/doc/html/rfc8684#sec_rwin

RFC 8646 has several pointers to RFC 5961 and in section 3.3.5 it
says:

                                                 ... Each of these
   segments will be mapped onto subflows, as long as subflow sequence
   numbers are in the allowed windows for those subflows.  Note that

So, I assume that on sub-flow level we are still supposed to do
the standard TCP sequence acceptability checks with respect to
the advertised window for the subflow.

If so, my concern is that raising rcv_wnd in the RX path means that
we may accept sequence numbers that we never advertised in that
particular subflow.

> 
> >   2. In the TX path, there is:
> >   
> >      tp->rcv_wnd = min_t(u64, win, U32_MAX);
> > 
> >      To me, that looks very wrong and that code might need to be fixed
> >      first.
> The capping is explained because the MPTCP-level ack seq is on 64-bit,
> while the TCP level receive window is on 32-bit.

The issues I see here are:

1. When calculating the usable receive window in TCP, we use 32-bit
   signed arithmetic.
2. The max. window size with window scaling is around 1GB
3. As said, rcv_wnd is used for acceptability checks.  In standard
   TCP we ensure that rcv_wnd is aligned to the window scaling
   factor.

So, I had assumed to see the "reverse" of the current TX raise window
logic in MPTCP: First, calculate the advertised window to put into
the outgoing packet and then update rcv_wnd accordingly.
 
> I hope this helps better understanding these modifications, and
> hopefully not introducing regressions on the MPTCP side :)

Yes, thank you. Regarding regressions, I couldn't agree more.


- Simon
 
-- 
Simon Baatz <gmbnomis@gmail.com>

