Return-Path: <netdev+bounces-110864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B092EA6F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 16:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6AF280FEA
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4906161939;
	Thu, 11 Jul 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBtUnfCO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E1161901;
	Thu, 11 Jul 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707297; cv=none; b=GncJYKwa8R7kgDa26By8PZkUiriCStB0kqDQ7IhY731WacUe21wl/ZohBBchPKj7abe414HLdShw6OiOzpEFG3nnY2vhaXxsOxxpp0ck4UY0vpLyVtslseflD1NmQe28oRIbXPjqRQqMxMtyPPQ/g2YKrBL9wCw5vFGYvoCgfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707297; c=relaxed/simple;
	bh=qqeKOSq0+dWEqdLcvtzfIzKAluC8hZVWXdKiFnn7c4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5d30Y/sSWCjXjQJ66D0Avwjk3kXdPxWGWYB7NX2jiGRi1iAvg9bO7VpVCPhnmSmNj77zaoo3kcDU4fuMX6viAKHvDWsvDj8Dh4RTm26KZwkcfqaL6UrsEzviHM6/xdXi6cABntkMJY2Q68q84Q5bHhC5ufNoG1LyTClNw3tI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBtUnfCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7265C116B1;
	Thu, 11 Jul 2024 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720707297;
	bh=qqeKOSq0+dWEqdLcvtzfIzKAluC8hZVWXdKiFnn7c4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oBtUnfCOx5MHv7tNKr9gCdFxoCYP+2Blc1btkO4hssb1sqPQN0LPn6I2N59PjMwRz
	 yGgJ6kkRYJ4Zu5is6PboEil9wneWkTsWoAhuzsEEvGHJ+Tm+IlN7j0VfoYokworAN2
	 ENFukGLfTonlBg1ValoJjei2T4OYTvOF8bQUq6SywPZiXSWpa0khIluAHiYgBJhuX2
	 mcMdfskFtPl4hKWRV0hYau5wiZpJtSukUsvdYS0rkVarBdwryscecsACIgT/vosUNk
	 vMJUgVaf0m9dCcsw5GCMlp4YKah4F0vW9KX7wjZIGQVE1EWfAAsiA350UuGhz1znX8
	 JV1s8+R1777+A==
Date: Thu, 11 Jul 2024 07:14:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Peng Fan <peng.fan@nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <20240711071455.5abfaae9@kernel.org>
In-Reply-To: <20240711133801.GA18681@fedora.redhat.com>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
	<twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
	<PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
	<pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
	<PAXPR04MB845955C754284163737BECE788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
	<whgbeixcinqi2dmcfxxy4h7xfzjjx3kpsqsmjiffkkaijlxh6i@ozhumbrjse3c>
	<20240710190059.06f01a4c@kernel.org>
	<hxsdbdaywybncq5tdusx2zosfnhzxmu3zvlus7s722whwf4wei@amci3g47la7x>
	<20240711133801.GA18681@fedora.redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 15:38:01 +0200 Stefan Hajnoczi wrote:
> > Usually vsock tests test both the driver (virtio-vsock) in the guest and the
> > device in the host kernel (vhost-vsock). So I usually run the tests in 2
> > nested VMs to test the latest changes for both the guest and the host.
> > 
> > I don't know enough selftests, but do you think it is possible to integrate
> > them?
> > 
> > CCing Stefan who is the original author and may remember more reasons about
> > this choice.  
> 
> It's probably because of the manual steps in tools/testing/vsock/README:
> 
>   The following prerequisite steps are not automated and must be performed prior
>   to running tests:
> 
>   1. Build the kernel, make headers_install, and build these tests.
>   2. Install the kernel and tests on the host.
>   3. Install the kernel and tests inside the guest.
>   4. Boot the guest and ensure that the AF_VSOCK transport is enabled.
> 
> If you want to automate this for QEMU, VMware, and Hyper-V that would be
> great. It relies on having a guest running under these hypervisors and
> that's not trivial to automate (plus it involves proprietary software
> for VMware and Hyper-V that may not be available without additional
> license agreements and/or payment).

Not sure if there's a requirement that full process is automated.
Or at least if there is we are already breaking it in networking
because for some tests we need user to export some env variables
to point the test to the right interfaces and even a remote machine 
to generate traffic. If the env isn't set up tests return 4 (SKIP).
I don't feel strongly that ksft + env approach is better but at
least it gives us easy access to the basic build and packaging
features from ksft. Up to you but thought I'd ask.

