Return-Path: <netdev+bounces-178620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B74A77DF6
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738841670F5
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB05204C07;
	Tue,  1 Apr 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Etfcpbf7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36302204C06
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518230; cv=none; b=QPlYMjpbMALW+ic07PTrX1nwQNX62LsuQ4gnlx1VWOKI3KbE0pvflyv07SULaLafK9DJS55XyUEi2w0RSQMexnk11MtkeWEqCO3DelFldtFBHmceWuRldCMJqvmq61mN3bIOXbioHMhzMs4FHDYnphNZW6h4yFKSPeieqrG7gp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518230; c=relaxed/simple;
	bh=IvLMe0bubmbI0HQbfuN1MwHM7bErWt7uBgp5ukSA7wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+7KMNCS4VZL8s8lB+0C1KskvCWSPS7rOqzUO5byUaR2luDC/szOnIcWHwgox69SvVRN9MjrMVYg4Q+lbJs+ufaawhvs8U0gOOU3/Wcff8ZXj8/VC2LoG+Ptxvh+836NwUKXeGEd+Ec9d/1CwF9eHVsjzVp5zdBdhowC3MSXi14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Etfcpbf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBB4C4CEE4;
	Tue,  1 Apr 2025 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743518229;
	bh=IvLMe0bubmbI0HQbfuN1MwHM7bErWt7uBgp5ukSA7wQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Etfcpbf7AovVPgPG9nEbIWEjMx/TD9qJnpa2Ui73tbIHLPHsWog4r30K6xAC+HkeY
	 4OtXFBlO8jjybzCvp6CdmqBHkNAfFQCK+jifRTy17LQ29yMHvrxhT4SGTI7TA7af4Z
	 nYRuoqTkM7DCh2qXQt/XkSnD+gu5x0n8q/CWA7BZlEKYrlC6RDMfDAXsWF5wDM1n3x
	 bvwxXMckfBZo4c3fN4/bQ32JE1GXlRn43hqW4mnGoI+1Idw8Eu2UWH2k6+En+YjuyX
	 fjq9yCBHv8HzeR3u0zEEaL4IufFt++lZ7a+LwebTC7avJ/L/5ukDv2EAstt4m1a4Kq
	 XIzvg3O+ytwhA==
Date: Tue, 1 Apr 2025 07:37:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 yuyanghuang@google.com, jacob.e.keller@intel.com
Subject: Re: [PATCH net] netlink: specs: fix schema of rt_addr
Message-ID: <20250401073708.495798f3@kernel.org>
In-Reply-To: <m2msd0i8v9.fsf@gmail.com>
References: <20250401012939.2116915-1-kuba@kernel.org>
	<m2msd0i8v9.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Apr 2025 09:28:10 +0100 Donald Hunter wrote:
> Fixes: 4f280376e531 ("selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support")

My bad!

> I wonder if the op name should be changed from getmaddrs to getmaddr,
> removing the plural to be consistent with do/dump conventions, or to
> getmulticast to be consistent with RTM_GETMULTICAST.

Well spotted! I have that change queued for net-next, but you're right,
we better send it as a fix, before too many people depend on it.
-- 
pw-bot: cr

