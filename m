Return-Path: <netdev+bounces-23378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B32A76BBC7
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1791C20FDA
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ADC2359A;
	Tue,  1 Aug 2023 17:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B822EF0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF40FC433C8;
	Tue,  1 Aug 2023 17:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690912649;
	bh=tw2ZYxvTVSxFPFx5zqO5kWykO1CaGqAJdfqNsvzpC+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G6oM5htN3cIsRrR7bpzcSTjQdPLgnDezapGDV1KSaZ4doJvlYGdyNKxk6q4YXSUbI
	 CxMUuFUEoS2Bj5we6fpnM/RPrLAeoHz/wkHPOy+mml1eKJ3soiEiTHEPzOWIN4MciY
	 9h5CkO9IqjmtiyzvZFgdtSHCVXkCNVX5AkZ7cmQcodS3+8161DRbKZ2mC/uFs0+wan
	 4rLtLaXq1YH5bnDfc9PBtmv/SNpoyfvDwAXCcKV5efn2vuR7fRl11q1ZgpXBjxlPI6
	 nV+NJbyITbiSU4IEURk/MkiIBXLXPlC1EERcGTUN1U5oEf7gw/PENFu2rV5kSVqK8I
	 d+Cv4VduRME9g==
Date: Tue, 1 Aug 2023 10:57:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, fw@strlen.de, yang.lee@linux.alibaba.com, jgg@ziepe.ca,
 markzhang@nvidia.com, phaddad@nvidia.com, yuancan@huawei.com,
 ohartoov@nvidia.com, chenzhongjin@huawei.com, aharonl@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
Message-ID: <20230801105726.1af6a7e1@kernel.org>
In-Reply-To: <20230801081117.GA53714@unreal>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
	<20230731120326.6bdd5bf9@kernel.org>
	<20230801081117.GA53714@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 11:11:17 +0300 Leon Romanovsky wrote:
> IMHO, you are lowering too much the separation line between simple vs.
> advanced use cases. 
> 
> I had no idea that my use-case of passing nested netlink array is counted
> as advanced usage.

Agreed, that's a fair point. I'm guessing it was inspired by the
ethtool stats? (Which in hindsight were a mistake on my part.)

For the longest time there was no docs or best practices for netlink.
We have the documentation and more infrastructure in place now.
I hope if you wrote the code today the distinction would have been
clearer.

If we start adding APIs for various one-(two?)-offs from the past
we'll never dig ourselves out of the "no idea what's the normal use
of these APIs" hole..

