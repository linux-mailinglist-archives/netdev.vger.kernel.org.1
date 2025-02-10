Return-Path: <netdev+bounces-164910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACE8A2F978
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9505D7A31D4
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F0224C66F;
	Mon, 10 Feb 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZk4iaZT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC325C70E;
	Mon, 10 Feb 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217073; cv=none; b=H+p9tLl4XeetyoEgl1QJeqZUNqaTFPMaZxKVCaEdkwSPLFMSkBmwmRjGhIBboDlynzZlZOo8KwA9Sxc/pbkdphJkKtN+J3IVuDKQmB8c39we0Z1dFnFfRAhUR7Q7TR5UINE0hgBXYuJMdzIWCkiK1p95+lYMcWprvofCVxIgXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217073; c=relaxed/simple;
	bh=gdf7/NvYbbGHKFilEVhS91pFQ2iYyOi/5a8Mn0DRqwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIsErSF5M9DE+1nVktz+2BuEZrs2+xHN3FV/pvNAZ1PwcoNyEdcg7rbBg3y/WkOr6PZCyX1wH9MazLKnziWVSN/Smit40V5CPaLL4kCBjrdpa2tf526e2oAN+JyFPvp8e/h3QEnMPBTCW4jXIGzSUKk24INMMlDFxpJ/zKIiZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZk4iaZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAF5C4CED1;
	Mon, 10 Feb 2025 19:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217072;
	bh=gdf7/NvYbbGHKFilEVhS91pFQ2iYyOi/5a8Mn0DRqwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZk4iaZTYhRAu9q6mHp1kDkPvItzYC1Z7VGpBJSIc/nFX7bBgDN7yDBfF5/l9RKEn
	 ABSeK0/W1mO4zv970Tatg6RQk1yrMUfP7UAVqJVE3VIbYu9N4xBlVvAkPKCLS9HUfA
	 VEmkwEdK3ZbT6IOHXIMdCSoMwvnAMRi0b3dfNG9eG7h9hqIriOS9ldwNLwKViduKI1
	 NgfZXyCbJ4zyinz7iUnd7afHBvtHS1mB5rXF9NnJdW/58k3/Qf/SdYm3qiQBXhyRic
	 iD74DIZkm5cO768C5RBuz3RdcS/tQVoE7rGlE1+4ElHwdReuwhROj7J6x8dNC8Xpcf
	 jHtVpGMYOQ1Gg==
Date: Mon, 10 Feb 2025 19:51:08 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 07/15] mptcp: pm: mark missing address
 attributes
Message-ID: <20250210195108.GU554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-7-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-7-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:25PM +0100, Matthieu Baerts (NGI0) wrote:
> mptcp_pm_parse_entry() will check if the given attribute is defined. If
> not, it will return a generic error: "missing address info".
> 
> It might then not be clear for the userspace developer which attribute
> is missing, especially when the command takes multiple addresses.
> 
> By using GENL_REQ_ATTR_CHECK(), the userspace will get a hint about
> which attribute is missing, making thing clearer. Note that this is what
> was already done for most of the other MPTCP NL commands, this patch
> simply adds the missing ones.
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


