Return-Path: <netdev+bounces-189864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84073AB43A1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 20:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CE73B3715
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19117297106;
	Mon, 12 May 2025 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQuCVVu1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C68297102
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074350; cv=none; b=p/QDSaAmbo0D7c+T583S2i2p12jtUCQ4Mr/dEUfiPBMTKVZowlKO2ph/UshzArDypvrWaB5tiqZ+xvcLsFhy7Sh64FhjqZ/47WK/e5/aCGNQbMioq0GM/X963Z4cd1tRfIazAeu+HQ8FgqszYK8WXGDogHXKwj3ifwt9Yy8yFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074350; c=relaxed/simple;
	bh=ijlAtUA90mHPtD5jfjRNaWL6q7JoW9ZNCEruRTpoh9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8u4XrUNiZZVaiy1ZSq1UQRpjXPl62GlTZ5v+aI8vf2tXAymcWbHjwDXaT5e/rm+QG6QJ6GtI/2rO0WtCjr7NhVYW732KpcSp7pu5SN9aRhh0kH7BeVaC9Yv8phE4QNoPxsp59muoNtSQBss7Hbi8eogr0d/HRxaem74z8y0Nfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQuCVVu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47C3C4CEE7;
	Mon, 12 May 2025 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747074349;
	bh=ijlAtUA90mHPtD5jfjRNaWL6q7JoW9ZNCEruRTpoh9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQuCVVu1HJCAUFglrmDVEBB1Pk3xHDN0N06PjpDX4ONnvRi7KVffZ8Bxqhx2M+08h
	 U2LQou96lbxGyJLZrsRoDia1k0+gw3s6C9H04JDrwDxzJoU7Fv5M7naY+nW2u2hYnV
	 KaLIYPriCQyxPocJi7SrMkCPARhobjHTrDAYnjfXlv4ZJxGzml78ThuNYdkdXyztTP
	 2SA1uBDoCCXQ6b51IxC1D1++2+AonkGNoNPzyAIOpSBa0fzDsq52vFvgEd10mTwE5j
	 fm/S1ylaFqTVkQJvWSQU0LsmVfLZnjYG0ggfwfYkMx6Xn+vtVILiE8rrjjgtVjWoh8
	 hEw91bPaGaM7Q==
Date: Mon, 12 May 2025 19:25:44 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next PATCH 3/5] octeontx2: Improve mailbox tracepoints for
 debugging
Message-ID: <20250512182544.GW3339421@horms.kernel.org>
References: <1747039315-3372-1-git-send-email-sbhatta@marvell.com>
 <1747039315-3372-5-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747039315-3372-5-git-send-email-sbhatta@marvell.com>

On Mon, May 12, 2025 at 02:11:54PM +0530, Subbaraya Sundeep wrote:
> There are various stages involved when a VF sends a message
> to AF. Say for a VF to send a message to AF below are the steps:
> 1. VF sends message to PF
> 2. PF receives interrupt from VF
> 3. PF forwards to AF
> 4. AF processes it and sends response back to PF
> 5. PF sends back the response to VF.
> This patch adds pcifunc which represents PF and VF device to the
> tracepoints otx2_msg_alloc, otx2_msg_send, otx2_msg_process so that
> it is easier to correlate which device allocated the message, which
> device forwarded it and which device processed that message.
> Also add message id in otx2_msg_send tracepoint to check which
> message is sent at any point of time from a device.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

The cover letter and other patches in this series are n/4.
But this is patch 3/5 (there is also a patch 3/4).
This doesn't seem right.

