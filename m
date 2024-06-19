Return-Path: <netdev+bounces-104948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAD590F3FE
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073672811F3
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577D115278D;
	Wed, 19 Jun 2024 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7dX2nzW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1161848;
	Wed, 19 Jun 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814425; cv=none; b=XlVyGI4QDZhHYhuSFhKLuU3lvSmcnCt69WxnHRlnp/I8JtVlH1U3nllSVCrKxfPxlmGoFWSNDNbxRbE//QijeUgh8cuOZtgKcCzAC6BhA4kt9j5U9KOJ/Wl8RafM/h2NiyTq3hAq9VfNxUWrTeP6rBb9PjBHgaHP51whhmkWcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814425; c=relaxed/simple;
	bh=rvREcV9Poe7/yAflI6h5ifaCriJuE5pL4OCGiawDh08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ed6SCT26d/717VqkSVdG+hGwon7jErKj10ix2MuwTaBaTqj0Fr9v+9noVC7fyScTmVP7djC1p5CKwscsBr+Yni2wIYNgl22Kns9/ZZff1XSW24ioAAVeD/vYAtzPIzIjtOKgMBH3YCIvF+XNtay3fRjbxwc6hmO23CC1XeHPu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7dX2nzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE0AC2BBFC;
	Wed, 19 Jun 2024 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718814424;
	bh=rvREcV9Poe7/yAflI6h5ifaCriJuE5pL4OCGiawDh08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p7dX2nzW9eHjOjbAaynegGPrcjtLDWEFk1mPC/AWbHaLYptH4uODsIkBDOWzVQnhe
	 SsJi3lO1GBTTwdkvTSNIo4vn6N/6tnmPuRgqvueVXTuTTZJEBgwbR1ZoSoTSaudzx/
	 ZGp/xMPoYTaBY7EnNCRFeYGsnphjhG9ki12JSC9yVZwTNFLuccX9+XCS+LhDYOFTqh
	 inL+dsXQ9S/J6B6ZPxk377MhFtLu2RMy/EL1T8UjDU57VKWjO3giK88vraYYIFDrNn
	 1RSlPYfed6enPEs9e5idaPCNnMKH2XOg2r1Y0GdMyxpSxMbhAXjj6q1kM7D9IMSOcQ
	 yHYzUVuLCDtHw==
Message-ID: <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org>
Date: Wed, 19 Jun 2024 18:27:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: XDP Performance Regression in recent kernel versions
To: Sebastiano Miano <mianosebastiano@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Toke Hoiland Jorgensen <toke@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 18/06/2024 17.28, Sebastiano Miano wrote:
> Hi folks,
> 
> I have been conducting some basic experiments with XDP and have
> observed a significant performance regression in recent kernel
> versions compared to v5.15.
> 
> My setup is the following:
> - Hardware: Two machines connected back-to-back with 100G Mellanox
> ConnectX-6 Dx.
> - DUT: 2x16 core Intel(R) Xeon(R) Silver 4314 CPU @ 2.40GHz.
> - Software: xdp-bench program from [1] running on the DUT in both DROP
> and TX modes.
> - Traffic generator: Pktgen-DPDK sending traffic with a single 64B UDP
> flow at ~130Mpps.
> - Tests: Single core, HT disabled
> 
> Results:
> 
> Kernel version |-------| XDP_DROP |--------|   XDP_TX  |
> 5.15                      30Mpps               16.1Mpps
> 6.2                       21.3Mpps             14.1Mpps
> 6.5                       19.9Mpps              8.6Mpps
> bpf-next (6.10-rc2)       22.1Mpps              9.2Mpps
> 

Around when I left Red Hat there were a project with [LNST] that used
xdp-bench for tracking and finding regressions like this.

Perhaps Toke can enlighten us, if that project have caught similar 
regressions?

[LNST] https://github.com/LNST-project/lnst


> I repeated the experiments multiple times and consistently obtained
> similar results.
> Are you aware of any performance regressions in recent kernel versions
> that could explain these results?
> 
> [1] https://github.com/xdp-project/xdp-tools


--Jesper

