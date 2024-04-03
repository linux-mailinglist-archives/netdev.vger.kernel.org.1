Return-Path: <netdev+bounces-84522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E9589725E
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A87CB2A079
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE4E149E13;
	Wed,  3 Apr 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot9UQ/gL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14365148FF5;
	Wed,  3 Apr 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154030; cv=none; b=GquriMBpLAr2I9LKULywDQmrHhiLNSwb9tW/lbHEJfxRZjnLJ3Dv99LvfzjL/aHmeajWO2L/oJX+UJuKIYLESK/Y79R0Nc3n1LX3R92DXFHF0hIpr6UXVqiTW4fvRiElTjllaoIUzuQH0O0PDXiKAboBy8g0UGihMCY9ScJX0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154030; c=relaxed/simple;
	bh=Ur+vOFJmzpEfXxoh+VrFj3KA2v/03Irt0g71jewvQsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HmRoO24DOSR7mihNDFGXePDtJzM15OoiHe1TIANBx7e146hhzNHSf3m/gMNjqr4QD7fZrDz1BPjhF5l31U5YycAJ4412x8sEEQqJIBH1tvI98ljlPA7HwXwBFsvLmkLZUVTe3tqOCh1qkQ4f9PD7PYb0F4nuvblgg5vS/K82SnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot9UQ/gL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CE3FC43390;
	Wed,  3 Apr 2024 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712154029;
	bh=Ur+vOFJmzpEfXxoh+VrFj3KA2v/03Irt0g71jewvQsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ot9UQ/gLyy84yq0PB9Yp0SpdH4SJSrnF20dUhghc/N2qDtQRKkX+dJmoI2PbD1FRI
	 EqEL+rDe+DTNQhJzDjMHtpPDkCGjVlt8qTC2n4Dpjr5szde97PjJxvl272o4q+m/BU
	 j3TqoMytl9/2kzfFEyubsbQ6Ry+qWhn5r7eUWe+292FbZ20lwS/+BFIhCsQIM63IhR
	 jUjLMQeUyj16AO32v89+f125E1tpWpqqjrrsb/+5Pea+7RMmQfWd0b+wJzRSFuoc4x
	 2E/21wNo+KjozqLvEKCTH5gb+/6LbHFjAJJm0ZJeNK0bcMNoa86MyG7alN0kqZXwix
	 T3wQlSU04z+xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EA3FD84BB4;
	Wed,  3 Apr 2024 14:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/7] Selftests/xsk: Test with maximum and minimum
 HW ring size configurations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171215402958.3229.14901300049067345284.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 14:20:29 +0000
References: <20240402114529.545475-1-tushar.vyavahare@intel.com>
In-Reply-To: <20240402114529.545475-1-tushar.vyavahare@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 tirthendu.sarkar@intel.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  2 Apr 2024 11:45:22 +0000 you wrote:
> Please find enclosed a patch set that introduces enhancements and new test
> cases to the selftests/xsk framework. These test the robustness and
> reliability of AF_XDP across both minimal and maximal ring size
> configurations.
> 
> While running these tests, a bug [1] was identified when the batch size is
> roughly the same as the NIC ring size. This has now been addressed by
> Maciej's fix.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/7] tools/include/uapi/linux/ethtool.h
    https://git.kernel.org/bpf/bpf-next/c/7effe3fdc049
  - [bpf-next,v3,2/7] selftests/xsk: make batch size variable
    https://git.kernel.org/bpf/bpf-next/c/c3bd015090f2
  - [bpf-next,v3,3/7] selftests/bpf: implement get_hw_ring_size function to retrieve current and max interface size
    https://git.kernel.org/bpf/bpf-next/c/90a695c3d31e
  - [bpf-next,v3,4/7] selftests/bpf: implement set_hw_ring_size function to configure interface ring size
    https://git.kernel.org/bpf/bpf-next/c/bee3a7b07624
  - [bpf-next,v3,5/7] selftests/xsk: introduce set_ring_size function with a retry mechanism for handling AF_XDP socket closures
    https://git.kernel.org/bpf/bpf-next/c/776021e07fd0
  - [bpf-next,v3,6/7] selftests/xsk: test AF_XDP functionality under minimal ring configurations
    https://git.kernel.org/bpf/bpf-next/c/c4f960539fae
  - [bpf-next,v3,7/7] selftests/xsk: add new test case for AF_XDP under max ring sizes
    https://git.kernel.org/bpf/bpf-next/c/c53908b254fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



