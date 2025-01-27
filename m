Return-Path: <netdev+bounces-161153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C0A1DAE1
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 17:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AFC165F3F
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F1433CB;
	Mon, 27 Jan 2025 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbzKQTuX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420318755C
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997078; cv=none; b=Mf9n+Ky4OkQWQ7FbfjJe/4jP4eI99p5/TaQIozzYLbekwnmKbKGDwH7UCkWwG2QzTXrp6NDPA0K5cbsJNcsJws3fProU/51M6lfu4eGm8sPXUh4gEub5ERaN1vZ/Sv4ODEynNGph8GGgPgbexkflUBggXS6TqUh5ubJ0eLw4k/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997078; c=relaxed/simple;
	bh=mL4/OH8Z2WOWG61KpaLz6kSmZV6Hlul0CKK/9oGGtWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXNHYftvMT8lj6lfe0C8kqxDbNYxtCyE/gqJvhykD69/n2f54AEp1qKkWWOzEfy68KrzLw8/+am5ep4LIDByiv5kl/xNgLohx/WHcOgm/4QTeAz4Axps/Eyfr3UG5U739xzPElZs+0DY/CrCdOiB22tsawxXG+ljINmbPg147pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbzKQTuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABAEC4CED2;
	Mon, 27 Jan 2025 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737997078;
	bh=mL4/OH8Z2WOWG61KpaLz6kSmZV6Hlul0CKK/9oGGtWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbzKQTuXnxNwAKm5HuDLbPuWiiFQH6tSKgSEMPsow81VtM7tGhhzrCzRNN1WJDS9c
	 9JhUiYAbkcrc+bQPZ0e8NqYUNhPaoa4IfRUW3pEq118OdlV91Epx9imdxURS9JT2qL
	 GcCkUIVFee8OzmJSG8Cgue+eGQpA+2ArCn4gp0zYMeCLXNep/24TsRX4Wsrj/Rj/I5
	 wdrKUON57iMqQH/bKp9kQcu5hDY1rYTkE3doPmlp4bo85cnP3bdBmmeWpdKbf41xKL
	 cGd3HYXB2N/XUKltxldnQ12AEpDT8SsRXHy4jaekCIhe373HFbwea0U0aZgYksPN+i
	 hFa2xIUoCpvlw==
Date: Mon, 27 Jan 2025 08:57:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 quanglex97@gmail.com, mincho@theori.io, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net v2 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
Message-ID: <20250127085756.4b680226@kernel.org>
In-Reply-To: <20250126041224.366350-3-xiyou.wangcong@gmail.com>
References: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
	<20250126041224.366350-3-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jan 2025 20:12:22 -0800 Cong Wang wrote:
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

Same problem as on v1:

# Could not match regex pattern. Verify command output:
# qdisc pfifo_head_drop 1: root refcnt 2 limit 0p
#  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0) 
#  backlog 0b 0p requeues 0

https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/966506/1-tdc-sh/stdout

Did you run the full suite? I wonder if some other test leaks an
interface with a 10.x network.
-- 
pw-bot: cr

