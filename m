Return-Path: <netdev+bounces-287547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pw+HB5hBGq6HgIAu9opvQ
	(envelope-from <netdev+bounces-287547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:31:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14544532505
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D5E13015719
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0AA3FE357;
	Wed, 13 May 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKgbEJgs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0D1ACEDE
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671900; cv=none; b=K+6aB9yw62S2ZKhx04SjqeyvuvpQ/KFgQRvvc8+vQTvp5qXpBWnRVqTaMtxdCRbCQJ12LBUZ1uU5HWXHO1PD78D1Nx9JNA/wJ2W+8GK9ZaeGoNyOnAVWTHUyrEiauoi3GIoNvE26QR8NIbEU+EbvHVmPD1406HBpfFuSvhrvFzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671900; c=relaxed/simple;
	bh=keic7NC2bQltPjnu9Fv/Ur43ojp6LIt9vJL/EMMvyXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDB848FaeU4lbic6m1rrdiVq3AUaOUVosnTyYuoxS2oX1Cc3U7fOa+FDPQoMb71rFAi4ooZetrEmxvjKNGKmZLQy5ig9qVs5Pc0uCUaoXNidf9QO6LKjHxYtuZK/Sbd7x3U5LJpWiUlVrJSLN80/jNkxe/j7wptqobzvqnvBFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKgbEJgs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so2934566b3a.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 04:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778671898; x=1779276698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D1OL7qFWQJ3zT2e13Gm/hEGbfNwIT5go0QnPp2L0iM0=;
        b=pKgbEJgssoeERRGWMGZaSf61nKaeBALMed5sTn1+RVG2c90tgm7fwE4gRq1vf5Z6ys
         8EUQ/U1APMsA5IOonjABTfyFtKl+BylM71UitizvRqOOQ0vAgVcEalgYLVSXuWYQllI6
         liwL2YpL5Db2lfv0L46CA+ltak5K4bRxfUu5AagYuP/lAJteF8Gw2zvMRUeCM+ybGjLQ
         Lofl77L9BhNfBfWiCjaYm78Vs+3avgroApz2b2dI53rIiujnlQVhve57mMSrgBmrENsd
         BN1QiUQv5XK3KVwJNySl3Zhrk4QiH+rYtA1ZsScu9lkGzecA36+a8u0Hd83bEvCdF+Ud
         vA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778671898; x=1779276698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1OL7qFWQJ3zT2e13Gm/hEGbfNwIT5go0QnPp2L0iM0=;
        b=pxS9hc5vYlvASMOgfOzn2XpOZdTYAmjyLy59x88J7xAWZQBIHYOFQ6YmLqpn/a2Y+1
         93SzrcALC/bpbQS4wHq4MvKMTnNYzogZV1qU2Bfa15tRsji7wOXputPXW5TaWNOZZCSS
         eo3hoRmIsDbvsn3kKYdolK7q254NVxaxLIJGBhDnTQTJy2M5GjcPqgby2fKU902R20OC
         JmV+/KlsJx2UbgO7uG7h7hntbh8wEaSbJOd+WfDpH7h1nXnLoSBSC6YVfNtGxsmkHXBw
         8PmAQvQHxGFDndLh3dXCpYz058HAdBJYpPaVhIO76mFPcmNVNVDrgxs/LPxDgnpfgCT9
         +BVA==
X-Forwarded-Encrypted: i=1; AFNElJ+5pyTh7NLpZW/IyyMbHDE7Nogmh9tztYKe1dRA4zhjAdDY2sfO4BZiy1M8FFPVP18qc37uX7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxISYQFfK93zikz4IwWfLlsyQ1MIv6Af8GoY/Lqak1nXnR+DNDH
	Yjnph5xHHtXyyiAAEbFgBVwSXIjAYiGpOLkOhOC+rpV9YVCRTMC19qOn
X-Gm-Gg: Acq92OFbk5DxkXgh/IR/bq2556eeBNAy1KQ1QFDeSD9dZ+P/iFrB2iGbDm7s8PJ53fi
	Ux4dgj9rEeJzdPaLBR1o4vEv8KtJt4JdLX5j2/OcYLNoUjVac4squpTHZh0/p0aI3s7HxSMAQfv
	8bfzsj0huH0ggNo4X+IEuF2+Gb501FzxqKp1Aw3c+mhtezQPEHHPo/bxRQxccmM6hsNp06nE774
	pNX17TtLQ60VKRM7Oz9fEBex1Pl3Sd4/j/lUWxvuF0zb8OEZ0/OUQ+ayGbX+1Ax2Zq0b0nIc3HA
	+HD3nQkpggmpHYpK2lSx3BD9TtPEEepIcT2AOCshaItjNZv1/YwYXaSd7EKsoklpZxU2LVR7rAa
	xgLOAdBWXbszXJ/P/+CJTYD11adpOIuIxvV1IR+FlEtYOk7jiEihbKHed9Ie1M7m2Y7ch1GVz6G
	W1jK39EMbD5IQWaxetv61EEVeaErRIVPnx7A0sXCG9qms=
X-Received: by 2002:a05:6a00:3027:b0:82f:1b1b:e166 with SMTP id d2e1a72fcca58-83f042b8e06mr3008862b3a.33.1778671898398;
        Wed, 13 May 2026 04:31:38 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a103esm33613589b3a.51.2026.05.13.04.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:31:38 -0700 (PDT)
Date: Wed, 13 May 2026 20:31:34 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: William Bowling <vakzz@zellic.io>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, imv4bel@gmail.com
Subject: Re: [PATCH net] net: skbuff: preserve shared-frag marker during
 coalescing
Message-ID: <agRhFtawP06hWyRa@v4bel>
References: <20260513041635.1289541-1-vakzz@zellic.io>
 <CANn89i+NMVb5EyfsLEfcBu=R+hrD2NPhrNSUwK3hHBWav68KhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+NMVb5EyfsLEfcBu=R+hrD2NPhrNSUwK3hHBWav68KhQ@mail.gmail.com>
X-Rspamd-Queue-Id: 14544532505
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287547-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[zellic.io,vger.kernel.org,davemloft.net,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zellic.io:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 01:03:00AM -0700, Eric Dumazet wrote:
> On Tue, May 12, 2026 at 9:16 PM William Bowling <vakzz@zellic.io> wrote:
> >
> > skb_try_coalesce() can attach paged frags from @from to @to.  If @from
> > has SKBFL_SHARED_FRAG set, the resulting @to skb can contain the same
> > externally-owned or page-cache-backed frags, but the shared-frag marker
> > is currently lost.
> >
> > That breaks the invariant relied on by later in-place writers.  In
> > particular, ESP input checks skb_has_shared_frag() before deciding
> > whether an uncloned nonlinear skb can skip skb_cow_data().  If TCP
> > receive coalescing has moved shared frags into an unmarked skb, ESP can
> > see skb_has_shared_frag() as false and decrypt in place over page-cache
> > backed frags.
> >
> > Propagate SKBFL_SHARED_FRAG when skb_try_coalesce() transfers paged
> > frags.  The tailroom copy path does not need the marker because it copies
> > bytes into @to's linear data rather than transferring frag descriptors.
> >
> > Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> > Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> > Signed-off-by: William Bowling <vakzz@zellic.io>
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> Thanks!

Dear Eric,

William's patch covers the shared-frag marker loss in skb_try_coalesce(), but a 
sibling defect of the same class is left uncovered in __pskb_copy_fclone() 
(pskb_copy()).  I have submitted a follow-up patch addressing that variant -- 
I'd appreciate it if you could take a look.

I confirmed dynamically that the follow-up patch resolves the additional issue 
(reproduced with a small PoC: unshare(USER|NET) + a single nft 'dup' rule landing 
a pskb_copy()'d skb in esp_input()).  Further auditing and testing for other 
variants in the same class are still ongoing on my side; I will send an update 
as soon as I have more results.

https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/


Best regards,
Hyunwoo Kim

