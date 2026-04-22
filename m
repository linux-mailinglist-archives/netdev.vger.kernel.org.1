Return-Path: <netdev+bounces-280544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOBcD1wm6WljVAIAu9opvQ
	(envelope-from <netdev+bounces-280544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 21:49:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F5F44A4DF
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 21:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4491D308357A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A215F3F1672;
	Wed, 22 Apr 2026 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGN1U7+J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0132A3E1
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887283; cv=none; b=Va/OvJDqtmFfwIbVq06D8fATjQHmvS+ICkjmSO6oQnsG8WyBcb4/BOgD38z6gNsjAwmvJ6YR/MVy0TfPXHmbkdFFl/j6MRmfNDH83m1/nMrdMKdHEnS8qWHGCJFVAL5sKkvsJueFx5xRV3cWGOejDI2QqbAdc+W1pYcJUACxH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887283; c=relaxed/simple;
	bh=UYFEUJpj8InblztlKOtLHHRF/Bp6neQJTZVCThAIqu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvARwNxkw2X5reAcc/pkfeKcIM0vZeVrJ/FMW57wv8Img/MVnIwP1g3Eqc699Hz5i225Zeweevpz1UmXbZcW/BtAPIBovVnxES4RwgKuckJQgnljryRc04ot7cgHVHje7Hiuk3Ikv/3KLKBaXx/auV07iiwLOORW7PZnSXvvkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGN1U7+J; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7dcdaf06498so1498512a34.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776887281; x=1777492081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+7OS+lL2EOg9mcVfDIVGq4tLvzNXXkUwwBpb/L+w5uc=;
        b=JGN1U7+J9w18ce0+TzsMKSY0AlCFnWWh8ZaWOzmkeRY93ZPHJpj+MgtDdxpLlSgMHb
         BzS7pswxawKww9qJINYRfy11NS/30uz3haxw4iaf7Sh7UVGLJSQOkV1Qa3sqq4xNy1ZE
         f4lTeRq/bxlLKTLpyum8Qed1GWWN5g4zNaBdMcb6W4/YiIW1r8gPafYWX7KuqE6t61FH
         DZsn+QZpYLQ8X6kQLLzjSE4wrQJIsZHVSis/qs3Tg/5PnNuA8d0EDECoONNWjHihTL9D
         FIMOkFQvJtFiy6tBjeI8i+XjhY7J0krvbrDR+AmWgOEtVVcxA+keUgVYgIpz9KJ9Sw8F
         jeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776887281; x=1777492081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7OS+lL2EOg9mcVfDIVGq4tLvzNXXkUwwBpb/L+w5uc=;
        b=qrlpGz8gABHtl3GSfqLvRY+o1vKP2Dd2hTPwEkvXDyX1thgPcqePUXBaiF5t0ckOb/
         ef9eCVdFfRs2YwY4Tts5ZZUNLnXRUs8cE0fbPuZBeTal39OgGFF7wRCMeVC/wv8zo42M
         cIymd92+y0epsHWvUyhcvA+ZZGADHwA5b3DH13pe330E6/Tc7xOYgVQKLwGkTX5iZFjT
         oWcwcBMxnyiKr98zYJODRrER+trpcGFsbe7aW5wp4941eU//zRpn+9hdnwB/2WRh3Seu
         e/jeDoQ3AwsmWIUw/kfS/+WaVe+bbGvxBsiHHYpeLwCIRWNNuLileXFg0vOOvanQ2a1D
         G4tQ==
X-Gm-Message-State: AOJu0YzkmYFJFsC5eYKhZxaks6cKUW4cvOaAqYP+3R7hkNGjdXStCRyt
	6PLF3E+OtwiQJ/hn5tPpFHsSiPOl/uKHZYVAj+HgUlu0NDnHJlMwUkHE
X-Gm-Gg: AeBDieun+s6ApGqZhxL4uWzINRVH61ajyiMAZPuEPxDcyAfLU9W9oK2BoDy9jQG381z
	j0uQsZve2QDzIcVUBBYHThjiaHkMic/3PXsJdRj8WadRrTp5O3AaYr8IRj9Q4D4Yd5zAlKHZQw0
	peucH67lxlI3M0RvGTQL5UENalbbZQlcsewiwA3wiTicB/he+yyUtdD2GRempM4KNc9bKgI/jl+
	TA5HW2BDTkHt+ur0jSd8e0HEHv5QQwIyz4PGueQgJU0ZTunDG2ANKynSpapHSH6oAZBX0Tgx22R
	H6kgE4Xf+yrCeANAE5H7sLAyTOmJkOHPiwHk/BPTZp45xmC18OOrB5biYBRm2A32G6IuUb3QehH
	uK8fqmMlCesFwViKCxc/831KbZA4+cmTK+mXGAj4UL8eS1cq9vz/J37cG4NCBNwSsLsMqXnRA6n
	ouKMxwis++Z99gOKHlSqN2vn/uSvRn
X-Received: by 2002:a05:6830:6112:b0:7dc:e37b:b5d2 with SMTP id 46e09a7af769-7dce37bbc0dmr4033283a34.8.1776887281063;
        Wed, 22 Apr 2026 12:48:01 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd5408b5asm5633716a34.11.2026.04.22.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:48:00 -0700 (PDT)
Date: Wed, 22 Apr 2026 12:48:00 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org
Subject: Re: [PATCH net v8 03/15] net: cache snapshot entries for
 ndo_set_rx_mode_async
Message-ID: <aekldWazLVNzh9cd@devvm17672.vll0.facebook.com>
References: <20260416185712.2155425-1-sdf@fomichev.me>
 <20260416185712.2155425-4-sdf@fomichev.me>
 <1d871492-2da5-44b0-b6fe-860966dff55a@redhat.com>
 <12244c7a-07c5-4d75-98aa-3fe35c149272@redhat.com>
 <aef3wzOywP8_LhCh@devvm17672.vll0.facebook.com>
 <27946411-c226-426c-9307-d2cf76b88b1f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27946411-c226-426c-9307-d2cf76b88b1f@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280544-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90F5F44A4DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/22, Paolo Abeni wrote:
> On 4/22/26 12:19 AM, Stanislav Fomichev wrote:
> > On 04/21, Paolo Abeni wrote:
> >> On 4/21/26 11:52 AM, Paolo Abeni wrote:
> >>> On 4/16/26 8:57 PM, Stanislav Fomichev wrote:
> >>>> Add a per-device netdev_hw_addr_list cache (rx_mode_addr_cache) that
> >>>> allows __hw_addr_list_snapshot() and __hw_addr_list_reconcile() to
> >>>> reuse previously allocated entries instead of hitting GFP_ATOMIC on
> >>>> every snapshot cycle.
> >>>>
> >>>> snapshot pops entries from the cache when available, falling back to
> >>>> __hw_addr_create(). reconcile splices both snapshot lists back into
> >>>> the cache via __hw_addr_splice(). The cache is flushed in
> >>>> free_netdev().
> >>>>
> >>>> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> >>>> (cherry picked from commit ba3ab1832a511f660fdc6231245b14bf610c05bd)
> >>>
> >>> Are you backporting from 7.2 via time machine??? :-P
> >>>
> >>>> @@ -611,8 +633,8 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
> >>>>  		}
> >>>>  	}
> >>>>  
> >>>> -	__hw_addr_flush(work);
> >>>> -	__hw_addr_flush(ref);
> >>>> +	__hw_addr_splice(cache, work);
> >>>> +	__hw_addr_splice(cache, ref);
> >>>
> >>> I think here sashiko has a point, with the cache size being unbounded. I
> >>> guess syzkaller or the like will find a way to make it grow too much.
> >>>
> >>> What about hard-limit it to some reasonable value?!?
> >>
> >> There are a few more remarks from sashiko at the driver level, but
> >> AFAICS are all pre-existing issues.
> >>
> >> I think even the above one it's better handled as a follow-up, so I'm
> >> applying the series as-is (I'll just drop the cherry-pick statement above).
> > 
> > I have a follow-up series to add retries here, but not sure it's the
> > right direction. I can send it once net-next opens just to opinions.
> 
> I'm not sure how you are going to use retries with cache access?!?
> Likely some code could clarify.
> 
> I was wondering about a dumb limit for such cache, possibly netns-wide,
> possibly with a paired sysctl.

Ah, you're more concerned about the cache growth. I'm more worried about
the failed allocations and failed sync :-/ Let me look into cache grown,
should be relatively easy to have some test that keeps adding mc
addresses..

