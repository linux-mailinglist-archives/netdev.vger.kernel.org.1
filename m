Return-Path: <netdev+bounces-82096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3734388C50B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7E8B2280A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334DD8061E;
	Tue, 26 Mar 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/tDP5Kp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9812D1EC;
	Tue, 26 Mar 2024 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463014; cv=none; b=bpobLEvFobWeI6CXOOZj4TeR4RI0dHh6ZUHd6jZp271C68V+WXkQvnDlCfb6s+O7O0hLr2ZO1VFdJaOYbZvPQ6QDS+G8VTE18AMATJdEQ9EW4anv3PkE92+8AZhIWWv4MSHOmfayDqex570CJ54D5ABGjAaSrWgYz4cSstpR+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463014; c=relaxed/simple;
	bh=XdKfUbEA/jzMBhPvbRzdoiWa0RgM42GTVwq0+Wg/sd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTTYrbkYunuwfheYW7Twqs7HNl8jDpuqtb2ri9hpbAvwFO+FT+9ZCI6DsVaMAFno3ixWHvtmmaGXefpOpnBCvN8APx/8PYO1scBvhqQkm5x5VIB/iOVByp9gvP20CHHNZx7EbASWAU+y+ynDeASaNB05NQxGrZDhoGpuDhvaT04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/tDP5Kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7015CC433C7;
	Tue, 26 Mar 2024 14:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711463013;
	bh=XdKfUbEA/jzMBhPvbRzdoiWa0RgM42GTVwq0+Wg/sd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T/tDP5KpP6h2nmPhaOnze2z/DH8wNlEKG1d0pZn2cQ7GfTIO/7BZwB5WF5F9dKTjQ
	 mWXZ7hJ1VjBPjpuHaQ4FDibZVImKvxCW/1u/Iah7seTe/tmOskX8yvUkqEXs9zW4uW
	 URy+avXOCDCrQYbr5gQ6IkA8oaYywO1zvCGGJtv+hyt8SbwPjnqFLweeAhyO5xbg2w
	 hTyLE82Pd7M3OMg/6Np7BQwgda4tVLqVjhDx3SpOkUMZgUy8kcSwl5sgQ7d9rnrCsc
	 IQvN8aJ5fFFNdReSW9CwcAP13KORRkMuA71DRx5X4jmJtLUaPJI5We+YqSGlPRli9o
	 mqRkLo7ZqsC9w==
Date: Tue, 26 Mar 2024 07:23:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [TEST] VirtioFS instead of 9p
Message-ID: <20240326072332.08546282@kernel.org>
In-Reply-To: <60c891b6-03c9-413c-b41a-14949390d106@kernel.org>
References: <20240325064234.12c436c2@kernel.org>
	<34e4f87d-a0c8-4ac3-afd8-a34bbab016ce@kernel.org>
	<20240325184237.0d5a3a7d@kernel.org>
	<60c891b6-03c9-413c-b41a-14949390d106@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 11:27:17 +0100 Matthieu Baerts wrote:
> > "All you need is to install" undersells it a little :)
> > 
> > It's not packaged for silly OS^w^w AWS Linux.  
> 
> Thank you for having tried! That's a shame "virtiofsd" is not packaged!
> 
> > And the Rust that comes with it doesn't seem to be able to build it :(  
> Did you try by installing Rust (rustc, cargo) via rustup [1]? It is even
> possible to get the offline installer if it is easier [2]. With rustup,
> you can easily install newer versions of the Rust toolchain.
> 
> [1] https://www.rust-lang.org/learn/get-started
> [2] https://forge.rust-lang.org/infra/other-installation-methods.html

I know, I know, but there's only so many minutes ;)

> Do you need a hand to update the wiki page?

Yes please! I believe it's a repo somewhere, but not sure if it's easy
to send PRs against it. If PRs are not trivial feel free to edit the
wiki directly.

