Return-Path: <netdev+bounces-162489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA45A27080
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C691E7A5A92
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4B520DD42;
	Tue,  4 Feb 2025 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNdXia6m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9720C03C
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738669028; cv=none; b=HtVEqjfRv0D0aevep3fDZbxY6VzDFoHoVcog54r+981LrgOza7QKdvb/NgVQLDuSaGXiiA0nZq5GQ7vCNUj+/0jeP1gTZa72rFn3WI7cJ4Abzou6ikRtTmDZ97Dw7/J+BXJqmGdL1l2NAV6GAaWtUYehUsweBmWt3yBSf9WvABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738669028; c=relaxed/simple;
	bh=ZdUSE4z9RynIxTEihC8Iydf5vdo/mkMPBIcizQElhgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTFISu3mCieC9floq5zJKUi8EA92mrb3WgDo9zwPuZo/sy1J003SMBCpKPiWwAbFQJdQ+nbO5kt78gaoY/H73jsQEwBxwmYn3ojlyebj4hY6eVoODx5/n9lYSEkp/tF6IJPcIBt4J4Ytiul1d8xweqf3ceGoWpbSfckiLIZKykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNdXia6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE141C4CEDF;
	Tue,  4 Feb 2025 11:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738669027;
	bh=ZdUSE4z9RynIxTEihC8Iydf5vdo/mkMPBIcizQElhgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNdXia6mgB2pwmLYKdhJZJbvEMwf9qRZkak8+h4yNxZ/fxPNGdkWNcsHLpDTaWGZK
	 DjXyHEDUHb7RLrGgGW33CyCAgFrixqLhZXyBCu+ZAWcLRV1+ZTZWsxE80JXOmNBs9Y
	 i3AQeDHLPvi+N0S1vcMrR2V95ArhREiwGxJtY6B7IIRhmBJ1iEtnT9Au8ATgjlpFfQ
	 ipfX4yLGjHRH/7nKmoMimIx3xPhOx3jJ6s2yVwPbpNAtMHZ0yJNMKHAozYxi43ongm
	 nkjUw7tqxh6ZkJ1x33wmRQf/DhVjTh+BHG7LCdZQ+IDgq47/BgBnlKlyPMornFzV7e
	 Fu94IywV2Zbhw==
Date: Tue, 4 Feb 2025 11:37:03 +0000
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	pctammela@mojatatu.com, mincho@theori.io, quanglex97@gmail.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net v3 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
Message-ID: <20250204113703.GV234677@kernel.org>
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
 <20250204005841.223511-3-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204005841.223511-3-xiyou.wangcong@gmail.com>

On Mon, Feb 03, 2025 at 04:58:39PM -0800, Cong Wang wrote:
> From: Quang Le <quanglex97@gmail.com>
> 
> When limit == 0, pfifo_tail_enqueue() must drop new packet and
> increase dropped packets count of the qdisc.
> 
> All test results:
> 
> 1..16
> ok 1 a519 - Add bfifo qdisc with system default parameters on egress
> ok 2 585c - Add pfifo qdisc with system default parameters on egress
> ok 3 a86e - Add bfifo qdisc with system default parameters on egress with handle of maximum value
> ok 4 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes
> ok 5 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets
> ok 6 b1b1 - Add bfifo qdisc with system default parameters on egress with invalid handle exceeding maximum value
> ok 7 8d5e - Add bfifo qdisc on egress with unsupported argument
> ok 8 7787 - Add pfifo qdisc on egress with unsupported argument
> ok 9 c4b6 - Replace bfifo qdisc on egress with new queue size
> ok 10 3df6 - Replace pfifo qdisc on egress with new queue size
> ok 11 7a67 - Add bfifo qdisc on egress with queue size in invalid format
> ok 12 1298 - Add duplicate bfifo qdisc on egress
> ok 13 45a0 - Delete nonexistent bfifo qdisc
> ok 14 972b - Add prio qdisc on egress with invalid format for handles
> ok 15 4d39 - Delete bfifo qdisc twice
> ok 16 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
> 
> Signed-off-by: Quang Le <quanglex97@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

Hi Cong,

Unfortunately this test still seems to be failing in the CI.

# not ok 577 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
# Could not match regex pattern. Verify command output:
# qdisc pfifo_head_drop 1: root refcnt 2 limit 0p
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
#  backlog 0b 0p requeues 0

https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/977485/1-tdc-sh/stdout

-- 
pw-bot: cr

