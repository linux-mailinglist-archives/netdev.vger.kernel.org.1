Return-Path: <netdev+bounces-192780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67767AC118B
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C473D7ACF09
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E287429B8CD;
	Thu, 22 May 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4dNHBqY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912C29AB18;
	Thu, 22 May 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932796; cv=none; b=VWZVRGzKhAhYiTf4KMVFlNqBJAnbfcyD015C8IvIf4pkY5qVttptKoMmrrY5rvA1MprCau3JdorGAVqfXtEGaY5nr6InyXyHeYAQaREn8ulGOZURXcVZwaHUCKBNYufHlDB0MsRjeKgYqjWZGHbXP0n3QLdXlIFdiYcxDYpT4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932796; c=relaxed/simple;
	bh=juvqWSPNWD/ccSpR9ISmWR8Y4Q3DJg9JBvnzG2537c8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCx89ABDpELsn0WVb4uEmjscJnTCcpwLdr0rbqgHGdR86yQy8oFoxNmR4QVxHeMGF0x7Jo5ORTwPbvBdpOfRN3giS6N5+7/pwCkOOEQo/aQfokyvUEUjamv+5uDIV5Y9nG7Kaw33U2TRLUOUkQz41ek4LXbBq+XFs125FjUNA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4dNHBqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0438C4CEE4;
	Thu, 22 May 2025 16:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747932796;
	bh=juvqWSPNWD/ccSpR9ISmWR8Y4Q3DJg9JBvnzG2537c8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y4dNHBqYxnxmaFdUD1GR6qSkiP9YbInQFEqpBDd2+yrdlrC5ysIcJm9yNWtf6KgkH
	 arZ1TDCuDG/rpISvcVhj8NxlCFwDK39ITYcj7cFDoc8f4IP0kRZ3GOGuBWSCpPekFw
	 /e4J/yIGu7Xd3k0OCucv5wtikIs0Vob6WjzHlKeEVupjDKe7n2ChJIDwRElhAOsxUA
	 F0jwfxGVnLUim4tgv+n7iKoVK9daGXEER3aCXqgQ+uWTi48APwVZz3MdAysukrdKVh
	 RkMkriuJjkMsdHIpOVCGkQ6rwhuzUYA5RUAeqTr11wnqm+m+ypkZCfPhiPqa8tflR0
	 j/99g8iWMXOCQ==
Date: Thu, 22 May 2025 09:53:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: bluetooth-next 2025-05-21
Message-ID: <20250522095315.158eee1a@kernel.org>
In-Reply-To: <20250521144756.3033239-1-luiz.dentz@gmail.com>
References: <20250521144756.3033239-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 10:47:55 -0400 Luiz Augusto von Dentz wrote:
> The following changes since commit e6b3527c3b0a676c710e91798c2709cc0538d312:
> 
>   Merge branch 'net-airoha-add-per-flow-stats-support-to-hw-flowtable-offloading' (2025-05-20 20:00:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-05-21
> 
> for you to fetch changes up to 623029dcc53837d409deb70b65eb7c7b83ab9b9a:
> 
>   Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach() (2025-05-21 10:31:01 -0400)

Another bad fixes tag :( Time to automate this on your side?

Commit: ee1d8d65dffd ("Bluetooth: L2CAP: Fix not checking l2cap_chan security level")
	Fixes tag: Fixes: 50c1241e6a8a ("Bluetooth: l2cap: Check encryption key size on incoming connection")
	Has these problem(s):
		- Target SHA1 does not exist
-- 
pw-bot: cr

