Return-Path: <netdev+bounces-68959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9B0848F4C
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 17:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5461283AD5
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A84637;
	Sun,  4 Feb 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH/vAp6R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD4249ED
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064407; cv=none; b=BqgSszzzECRMHf2DgbdECH6UWpYFU6uvUMappNRMm4e0+kpmwoifynxjC6kJR+kqz2ewmxOikbSfVPz0apcwW+0O1lE5RpMSRM2jeXtT+PyUw+9gNjDzM+UTkUPnCcHhI0Eqt9miKRGOBP4l5BvL/4M/ybTt8uuz8rlMWmmmL3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064407; c=relaxed/simple;
	bh=tfnjmWsIi/q1EPiXUByxtO27LZ49cvRemo5MoqDdMII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwJ5dnfB2Fp61JrpkTKauGC5bodeq2R5KFyIwvcIz9G/jRXe7AN1tFbq48viIdzoUCzoHiJU/FlmsOxEXlGuMDY1h+/XSKs3ZuMdkzkekcpEDGKI/YO0yM+wZAGtTGXWO3OIALV3+FEeonGXu67snK/Uuo+ecgy46zYGmmqOdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH/vAp6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AABCC433C7;
	Sun,  4 Feb 2024 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707064406;
	bh=tfnjmWsIi/q1EPiXUByxtO27LZ49cvRemo5MoqDdMII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pH/vAp6R/ehaOxNV8IZY8DwxCKR9Ct+eRt+4wUsOoxng7H8isK2qMUJ26nMBHB5X2
	 wcD/DFZLq4eKjpkREP7YYA2IkhzlHXDmY/TIp1RRX8iwfE4VDjV/KDhSWUFdRZHNqE
	 ZNrHTXcv3mTQzXKhpBISiJFMHOETIc/GaCAeya8SjzzUQlM4nxIx2PXeknj+kMZdtP
	 GWdp+0Q2CkOKtyHjctWUkWvuRi45QV8SOCobHuOms8xXTBsI7cELppQwTt4mh2amlI
	 BG/LQY/KT0HzJSkik7nRrr4ZfxRmgShrNExOMciSciy/bi4Ro6WasrPJcnF7kBRZU1
	 +nupcHzpYu6RQ==
Date: Sun, 4 Feb 2024 08:33:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 kernel@mojatatu.com, pctammela@mojatatu.com
Subject: Re: [PATCH net-next] selftests: tc-testing: add mirred to block tdc
 tests
Message-ID: <20240204083325.41947dbd@kernel.org>
In-Reply-To: <b45bdefe-ee3b-4a07-a397-0b2f87ca56d3@mojatatu.com>
References: <20240202020726.529170-1-victor@mojatatu.com>
	<20240202210025.555deef9@kernel.org>
	<b45bdefe-ee3b-4a07-a397-0b2f87ca56d3@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Feb 2024 17:15:32 -0300 Victor Nogueira wrote:
> > I think this breaks the TDC runner.
> > I'll toss it from patchwork, I can revive it when TDC is fixed (or you
> > tell me that I'm wrong).  
> 
> Oh, I think you caught an issue with the process.
> The executor was using the release iproute2 instead of iproute2-next,
> which I tested on. I'm wondering if other tests in nipa are using
> iproute2-next or release iproute2. The issue only arises if you have
> patches in net-next that are not in the release iproute2. We will fix
> the executor shortly.

We merge iproute2 into iprout2-next locally and build the combined
thing, FWIW. I haven't solved the problem of pending patches, yet,
tho :( If the iproute2-next patches are just on the list but not
merged the new tests will fail.

