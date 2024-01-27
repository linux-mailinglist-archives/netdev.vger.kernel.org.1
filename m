Return-Path: <netdev+bounces-66339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E6883E8E1
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 02:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6CF28B7C5
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 01:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AE44A30;
	Sat, 27 Jan 2024 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqVMxD+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23104698;
	Sat, 27 Jan 2024 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318028; cv=none; b=AvEmHhYX434N2CI5Bo2dMprXPujKv9o5NWFPNohviCXbs6UIGlOti/8oG8vPinAXt+icifQZC5COuq4Puu0wGcD6/evmbnRobtqO5cak5Uyx3eKwELVMqMimKMYF3Zljj+qKrNzYgAVcJSBLYBnY5CE3ucccz7oUuKDXng0KHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318028; c=relaxed/simple;
	bh=wnDdHhp/RzpO6XGj5kibCVgWjaWRJabq+TxvWfoS/A8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oE8Hc3faYtXHwbNUXDGdJewGvM2HObqXfmgegi6aZoQ9TN3wiP8jTxNRxXUZcKlayB33hemlEWMkWl3Ub58fuBIbZZ3QokRp4irWGCZwzpd/Vla5eh3raQDbKZAHkFhCYEBHo5RRgb4RWJaDlQifMPDNSSiHhAxVrTuJDbUwsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqVMxD+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F65C43399;
	Sat, 27 Jan 2024 01:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706318027;
	bh=wnDdHhp/RzpO6XGj5kibCVgWjaWRJabq+TxvWfoS/A8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WqVMxD+nWpGFwvHbXdU04TjRnGNjrBhg7mBc660rNdaP6wwoKLcfx53hzi7ufRTYS
	 AaFKX6qEDr5CUyFKmz6McIK7Hcs+px3mqOqTNVo92MV0xtcaKL4sYAhXdJsBMBcYnr
	 qKxOtYyyK0z8SGw0ohjhxuZnDHU80WWvGaNPodnlx9c0eaN+xQwQY3Vq0Fj4eCqgmc
	 1vXw9vu1xzaa3XOvL8N8uH7Ml2fN8flWYKLxAVyrd3cHcpftm+VNmv95N884zAbv+4
	 rPpMkqvqiKKTuDAYFExtsD+E3O/FXhqaXiKzKKfkBMqXLZOn+xEAHcgwUNiiLxbVpI
	 dc9ndGwCahr1g==
Date: Fri, 26 Jan 2024 17:13:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240126171346.14647a6f@kernel.org>
In-Reply-To: <c8420e51-691d-4dd9-8b81-0597e7593d07@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
	<Za98C_rCH8iO_yaK@Laptop-X1>
	<20240123072010.7be8fb83@kernel.org>
	<d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
	<20240123133925.4b8babdc@kernel.org>
	<256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
	<7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
	<20240124070755.1c8ef2a4@kernel.org>
	<20240124081919.4c79a07e@kernel.org>
	<aae9edba-e354-44fe-938b-57f5a9dd2718@kernel.org>
	<20240124085919.316a48f9@kernel.org>
	<bd985576-cc99-49c5-a2e0-09622fd6027a@kernel.org>
	<c8420e51-691d-4dd9-8b81-0597e7593d07@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 17:56:26 -0700 David Ahern wrote:
> On 1/24/24 2:48 PM, David Ahern wrote:
> https://netdev-2.bots.linux.dev/vmksft-net-mp/results/438381/1-fcnal-test-sh/stdout
> 
> still shows those 4 tests failing. since they pass on default Ubuntu
> 23.10, I need some information about the setup. What is the OS image in
> use and any known changes to the sysctl settings?
> 
> Can I get `sysctl net > /tmp/sysctl.net` ? I will compare to Ubuntu and
> see if I can figure out the difference and get those added to the script.

Here's a boot and run of the command (not sure how to export the file
form the VM so I captured all of stdout):

https://netdev-2.bots.linux.dev/vmksft-net-mp/results/sysctl-for-david

The OS is Amazon Linux, annoyingly.

