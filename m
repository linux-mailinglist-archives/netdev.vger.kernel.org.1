Return-Path: <netdev+bounces-140888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441319B88E1
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A74281BE4
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938C81C687;
	Fri,  1 Nov 2024 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giePI72i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47F17BCE
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425912; cv=none; b=MQpNPni/C9KhgzdaD9+6nh2tN4+bebiwP3Bz6LQz21GQiRVmMKVN3d0dpqOKvvRJkycsse7MC3p8jMgl3O7jBzpgDQfuBWlrXgDXC9+8h7WTfXTEW6NAmBWYsG5PeuDp6UkkY691Iek3KBq9mbYKOpFc+g48L4NAivOIzg86Dg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425912; c=relaxed/simple;
	bh=tXK/7nqEpwz2TcEyr9H3mzOgohqDogAx76vxMxbvd20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AveoKpiwXzZMb93KdU+AQdJwsPmsZ+C12O/lPHKt4tqHB+1pPB1oFZ/XDo23WPnBB9hnYevBdNVDsO9dH6mKoJTr5YRcdkYQ5lji4mcJfY2n55aAnjVrUskmxUTsqocdZuhMw+o+qJiyyxZFXc87LBr5Py7QQf7pNy18lOHk0z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giePI72i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F491C4CEC3;
	Fri,  1 Nov 2024 01:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730425912;
	bh=tXK/7nqEpwz2TcEyr9H3mzOgohqDogAx76vxMxbvd20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=giePI72i0ulqtcYect1ACj6IjNTtFq11gtGGGDS10PTzrDbuMANqy2C7koOyY4MoX
	 TyYEIyqb6kDK03T5RzErUONt3rkAnq68pxw9pEIFM0RxNzeJOF/vHRf1jVt158GSBD
	 ZCTinTZdoX1PYLqNI162lCItV6TcRLOKS8/ZuCSy//cgC1jTXFVCgLcobop94A8kVu
	 FutP1QoF8A23WAnEKEMmm+6uwo+hvRaU+faLnlFlkWbMk2fL98h1lFjPDvg6z3pIcy
	 AFWxeUPMRaqAttCWKnPYX+pWDduC0j27xgteBFU2YqfB+rK5MjeyJXEoPPF8fTND6t
	 J6+pi14D1Pgjg==
Date: Thu, 31 Oct 2024 18:51:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: wojackbb@gmail.com
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Subject: Re: [PATCH] [net] net: wwan: t7xx: Change PM_AUTOSUSPEND_MS to 5000
Message-ID: <20241031185150.6ef22ce0@kernel.org>
In-Reply-To: <20241028073015.692794-1-wojackbb@gmail.com>
References: <20241028073015.692794-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 15:30:15 +0800 wojackbb@gmail.com wrote:
> Because optimizing the power consumption of t7XX,
> change auto suspend time to 5000.
> 
> The Tests uses a script to loop through the power_state
> of t7XX.
> (for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)
> 
> * If Auto suspend is 20 seconds,
>   test script show power_state have 0~5% of the time was in D3 state
>   when host don't have data packet transmission.
> 
> * Changed auto suspend time to 5 seconds,
>   test script show power_state have 50%~80% of the time was in D3 state
>   when host don't have data packet transmission.

I'm going to drop this from PW while we wait for your reply to Sergey
If the patch is still good after answering his questions please update
the commit message and resend with a [net-next] tag (we use [net] to
designate fixes for current release and stable)

