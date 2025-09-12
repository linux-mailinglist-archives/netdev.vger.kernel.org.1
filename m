Return-Path: <netdev+bounces-222684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FC4B556EA
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0204BAA6680
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39D033438D;
	Fri, 12 Sep 2025 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N50HqNa5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7D334391
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757705273; cv=none; b=oFYmtWc//nmWK5o3/Ueg0/mjUZWiX8/X9hZWbJ3elKsBwD0jUw03RsfutGFTpXzVwS/ONtBBEf4TEhebaUxL+WwIfO8ob9FFKHS4Tf4MEA5cw3XAGQN88Kpj0ahoFxDahJ3EHKLRqh3gZIYBgGWs0/N1naIAbyzkvgdehCzwhcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757705273; c=relaxed/simple;
	bh=Offzq5wcB5YoFm2ei1LDECZLm1E5fyDUrq8HlN64GO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4F91cjJ2sc2Re7FRIcQTJRKT9xv7IaFDpOGIMOseShuHoTyPzbAwDQxdAj3RIrReoZ0zvxNLD1cFPvkLoKG6Tzixt+H8DkcLMSZjTAT0t4xFXOoG9b1bfXGg1EeLP9iLO0HTwdQ3YkL2uRwzAkvu/TYnQUEafcvFlMPEauu198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N50HqNa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6843C4CEF1;
	Fri, 12 Sep 2025 19:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757705273;
	bh=Offzq5wcB5YoFm2ei1LDECZLm1E5fyDUrq8HlN64GO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N50HqNa5X71MrKfNqIhwwqUxYCxFLmNxejVrbc+l0FqQGdQdf64xcN0TssTALrYVO
	 yQVo2APwtAjgOQKPGIpR7/DhbyyBrz7PE73cD8K9nj2OZ3HDPkpK4RPPwTXWUs0Q3w
	 L5p0LRB36+bDcfjt+dYCoxVIDOuV9WeOoaYN2Lmot7/2h0LMpcHyu1NYY2oqrC6AFy
	 pMErUmAIDq3RewctxsChBBngeoxL6jCk0NUalXc6VKTTmQpUJHtvaSX6e25J778uH6
	 /wwotGYlGQoLgrOUUAnY4YvrcP3ZzhL7cJgJQX/za7dNP6YJfxj/NshDty7rHyGwPM
	 3c9cTUMWGIKoQ==
Date: Fri, 12 Sep 2025 20:27:49 +0100
From: Simon Horman <horms@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	willemb@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: Use NAPI_* in test_bit when stopping napi
 kthread
Message-ID: <20250912192749.GG224143@horms.kernel.org>
References: <20250910203716.1016546-1-skhawaja@google.com>
 <20250912192603.GF224143@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912192603.GF224143@horms.kernel.org>

On Fri, Sep 12, 2025 at 08:26:03PM +0100, Simon Horman wrote:
> On Wed, Sep 10, 2025 at 08:37:16PM +0000, Samiullah Khawaja wrote:
> > napi_stop_kthread waits for the NAPI_STATE_SCHED_THREADED to be unset
> > before stopping the kthread. But it uses test_bit with the
> > NAPIF_STATE_SCHED_THREADED and that might stop the kthread early before
> > the flag is unset.
> > 
> > Use the NAPI_* variant of the NAPI state bits in test_bit instead.
> 
> I think it would be useful to mention the difference between 
> NAPI_STATE_SCHED_THREADED and NAPIF_STATE_SCHED_THREADED.
> 
> For me, that would be that one is a bit number, while
> the other is a mask with only the corresponding bit set.
> 
> > 
> > Tested:
> >  ./tools/testing/selftests/net/nl_netdev.py
> >  TAP version 13
> >  1..7
> >  ok 1 nl_netdev.empty_check
> >  ok 2 nl_netdev.lo_check
> >  ok 3 nl_netdev.page_pool_check
> >  ok 4 nl_netdev.napi_list_check
> >  ok 5 nl_netdev.dev_set_threaded
> >  ok 6 nl_netdev.napi_set_threaded
> >  ok 7 nl_netdev.nsim_rxq_reset_down
> >  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
> > 
> >  ./tools/testing/selftests/drivers/net/napi_threaded.py
> >  TAP version 13
> >  1..2
> >  ok 1 napi_threaded.change_num_queues
> >  ok 2 napi_threaded.enable_dev_threaded_disable_napi_threaded
> >  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> > 
> > Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is disabled")
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> 
> With the above addressed, feel free to add:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...

I now see that this patch is present in net as
commit 247981eecd3d ("net: Use NAPI_* in test_bit when stopping napi kthread")

So I think we can safely ignore the comments in my previous email.

