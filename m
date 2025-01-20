Return-Path: <netdev+bounces-159761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0BA16C3D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADA83A5582
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5481E04BD;
	Mon, 20 Jan 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMm5FnHL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02991DFFC;
	Mon, 20 Jan 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375604; cv=none; b=EljCLG4BMi9WlfA5YuN8OWUB/M0pLx0CU3Rug4O8Bx352+sJRW0Vg9iY3NCJsLrQRm3S3mGwMfY8pA55xU+cIDSEFDm5+Oj7w0mIxZXP8H4ok7Dr/xuvfH/lNOLCK6KX+KRIx5iTDxHTK8xM1ZH+rVNETbWQPXXnhJit43NV8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375604; c=relaxed/simple;
	bh=rIhOLjr0fz1H1tqqXG7LJDy8uizqMip9o1axNsj3AGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FgLmrfHGDZOIFZpvcjcdnFydnrNiCvNDOTZ1D5OYyTnYxK1btco5aMC/FxZl/Ul2iHmEXxn1+8BpuwMHRF9MwWpmi8TBkJFIHufoYqQtABQOMdBCqZO88ZhIKFL3lPVVWBrPuP2VJMcHT2sUYOJ9Nc2NoKnMEzgYZ2FCPQ1l8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMm5FnHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC50C4CEDD;
	Mon, 20 Jan 2025 12:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737375604;
	bh=rIhOLjr0fz1H1tqqXG7LJDy8uizqMip9o1axNsj3AGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UMm5FnHLtBeDPAAMbzUpQKpKMGRs/g3+Sz2JW5Qt8b8cN7D1J7vsTtxIyNiLADv+n
	 NFnhbPyGi721p/OVUtvU0OKLXEwxOqbpWTalQPZAtlXxVPXrPUSjUYn2kzMDixyvPe
	 OlCpjnHQ4/R5WjNep+RQU9MfdcXLxbJej7Dq7peKRzL7JBQYBIq83sJJ31wGAuOMJt
	 Qfolq0GYvVUGQ0pif6Ds3/ehQhi0s8imDiM09Y26Nq77mDPAKalAzClhve+6HbZ8NZ
	 ONfVwz0YxBf4ZWPKhwbabOHbY/Zune5et6wNVphva+Xi6YdL/RTd6go26hy9WtF2lY
	 DEgAyYeKeTZCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5E4380AA62;
	Mon, 20 Jan 2025 12:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tipc: re-order conditions in tipc_crypto_key_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173737562851.3509344.1650987261849226694.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 12:20:28 +0000
References: <88aa0d3a-ce5d-4ad2-bd16-324ee1aedba6@stanley.mountain>
In-Reply-To: <88aa0d3a-ce5d-4ad2-bd16-324ee1aedba6@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Jan 2025 12:36:14 +0300 you wrote:
> On a 32bit system the "keylen + sizeof(struct tipc_aead_key)" math could
> have an integer wrapping issue.  It doesn't matter because the "keylen"
> is checked on the next line, but just to make life easier for static
> analysis tools, let's re-order these conditions and avoid the integer
> overflow.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] tipc: re-order conditions in tipc_crypto_key_rcv()
    https://git.kernel.org/netdev/net-next/c/5fe71fda8974

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



