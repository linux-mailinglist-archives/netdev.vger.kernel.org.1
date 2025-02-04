Return-Path: <netdev+bounces-162646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3141A27782
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DF01653E1
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4B0214A61;
	Tue,  4 Feb 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0nUfAQB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB88086324
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687608; cv=none; b=pvBb30ZEqZn00TlppNm17w4wTYUXVy3MTAGGflKsIdnxSGvc9DDXejluFADWB1ybgXv4jlZlZwfbvSw3ZJl7pRJpiO1lv9PPjThG2cX0W/ngQGSiiaonXejUXUK86QUKpOYiGsIgwQ8w4guxCRQJwqSZgDJQ3dNxk+ztTuZy+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687608; c=relaxed/simple;
	bh=V8yQqj5EjGalPW31THbi5+RCQhCjgmiHk3K5nhps6TY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CA4Ay4FC2Zk8SabaQwBZYdeztvtgu9hEf4378GWfgL1Lseta2V3dz5U+39R1k1LvJdjfPe/zRVpDrNHtQQLHdTGJlHkHCiXSoJpTdbZgbJmoZvhaquVsQ4zi43pEO6ErNyQE9n970+oyQA/8b+goGrFcHHOY9h/uCtx52g3rVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0nUfAQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DF6C4CEDF;
	Tue,  4 Feb 2025 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738687608;
	bh=V8yQqj5EjGalPW31THbi5+RCQhCjgmiHk3K5nhps6TY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P0nUfAQB/EaauJMBRP+UutqFfbFSchjZjUcG8xjqgghB0i1nXe6fS9MAZX7BBbunB
	 SSGNInAWaZnE+PHLgaLhJVL1I/pMEG676Fo2DYGcX+kRIs6X4mvpbAeCyo1nVWzlpy
	 blUjxkrzwh+SRhSsV9j0Z5RbIx4g1+qjBCSwkJVMHR3u354znql2J92xQOgGRrFUhV
	 zhh0pw04y/0hi5rZlTJ1R8DaZ22bYFw7hHdBKkxmIHdLjlv3KiZCNUw0Dhpagd/C2Q
	 yUK8Ye8ib7AbeXtuOfWILnswkHPTl+dBN6uFUkNO8xPJZj7+UQuKkynNTpUsGg/fAd
	 CcjQHy7JLfipA==
Date: Tue, 4 Feb 2025 08:46:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: pctammela@mojatatu.com
Cc: Simon Horman <horms@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>,
 netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 mincho@theori.io, quanglex97@gmail.com, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net v3 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
Message-ID: <20250204084646.59b5fdb6@kernel.org>
In-Reply-To: <20250204113703.GV234677@kernel.org>
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
	<20250204005841.223511-3-xiyou.wangcong@gmail.com>
	<20250204113703.GV234677@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 11:37:03 +0000 Simon Horman wrote:
> On Mon, Feb 03, 2025 at 04:58:39PM -0800, Cong Wang wrote:
> > From: Quang Le <quanglex97@gmail.com>
> > 
> > When limit == 0, pfifo_tail_enqueue() must drop new packet and
> > increase dropped packets count of the qdisc.
> > 
> > All test results:
> > 
> > 1..16
> > ok 1 a519 - Add bfifo qdisc with system default parameters on egress
> > ok 2 585c - Add pfifo qdisc with system default parameters on egress
> > ok 3 a86e - Add bfifo qdisc with system default parameters on egress with handle of maximum value
> > ok 4 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes
> > ok 5 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets
> > ok 6 b1b1 - Add bfifo qdisc with system default parameters on egress with invalid handle exceeding maximum value
> > ok 7 8d5e - Add bfifo qdisc on egress with unsupported argument
> > ok 8 7787 - Add pfifo qdisc on egress with unsupported argument
> > ok 9 c4b6 - Replace bfifo qdisc on egress with new queue size
> > ok 10 3df6 - Replace pfifo qdisc on egress with new queue size
> > ok 11 7a67 - Add bfifo qdisc on egress with queue size in invalid format
> > ok 12 1298 - Add duplicate bfifo qdisc on egress
> > ok 13 45a0 - Delete nonexistent bfifo qdisc
> > ok 14 972b - Add prio qdisc on egress with invalid format for handles
> > ok 15 4d39 - Delete bfifo qdisc twice
> > ok 16 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
> > 
> > Signed-off-by: Quang Le <quanglex97@gmail.com>
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>  
> 
> Hi Cong,
> 
> Unfortunately this test still seems to be failing in the CI.
> 
> # not ok 577 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
> # Could not match regex pattern. Verify command output:
> # qdisc pfifo_head_drop 1: root refcnt 2 limit 0p
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
> #  backlog 0b 0p requeues 0
> 
> https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/977485/1-tdc-sh/stdout

This is starting to feel too much like a setup issue.
Pedro, would you be able to take this series and investigate
why it fails on the TDC runner?

