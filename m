Return-Path: <netdev+bounces-161412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93482A213CA
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 23:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F4133167B49
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 22:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B74195B1A;
	Tue, 28 Jan 2025 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL1sq3w2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFDF198E75
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738101613; cv=none; b=XRGzh3V6cBJRZVLuS9OhCnnIYCZi7m+TaQAfg1n+GvjU3w8g6jzxd2xj7t7aw5nL941b7sZGYZNAxkJ/7SC00BUy7c4yV1v6HRYZPDYEcGVgRi9BZY7HkwZf8ncvCaPBktHqZmVfQMav5hodVYMDElyKGfwVK9tL5xiHNJMryU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738101613; c=relaxed/simple;
	bh=TzaYQ3Ae+f6sa5sFP6BMyvaDIoYjCOl16y7IaTzgACw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmFVlU+DExD2sdbhDaIMKbBOXtkUSDjJ6v9Uz+CA6sxDX2fzDiB14F9R4U4Ao6zTgqw1xKJApxxoLkO020MoN3MjX8veJFOcmDhSCKBtBsdQ0VCgdpXmWNyX40koKGH7rFbmFwSPZcWiw17ci7uFIjKdQ6hTgNe3d/jaQZQQNoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL1sq3w2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14566C4CED3;
	Tue, 28 Jan 2025 22:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738101612;
	bh=TzaYQ3Ae+f6sa5sFP6BMyvaDIoYjCOl16y7IaTzgACw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gL1sq3w2a7M1b3Qi7Ipl3T4ZdusTa5/FUrS0b8LaRYIvqDnewzDov9RJ+KEVRXlCD
	 S620ju11vS8CBp/F+GYo2uasWKOrFjo8ldv2P4rtF+2fFDJ7ncTDU6+F2wvCRiI3hF
	 69XTmRh2+a9GnGHH1KYZp4q7dD+7hy7KAii8hG6dSdZ9ILSr/SuMcXgGVySXW+5y16
	 j3OgbUb2bIbcVRqGHL4bIc2FUiM4a59mGXa1jigW9Jv853ufeVPxjBD3E5FuLw4IX/
	 +vOjqNuNmJeYMgbVlttCV8jVuOI1c2KCAOxprZWoTP2t0lrly4r9yBaQovK3oPchPE
	 +k9gu5nAPV8Wg==
Date: Tue, 28 Jan 2025 14:00:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, quanglex97@gmail.com, mincho@theori.io,
 Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net v2 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
Message-ID: <20250128140011.221f4712@kernel.org>
In-Reply-To: <CAM_iQpXDtMngE1Pcf9KBmRpb5sZK4EJj6qgPgt1ioYW4QC9W3g@mail.gmail.com>
References: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
	<20250126041224.366350-3-xiyou.wangcong@gmail.com>
	<20250127085756.4b680226@kernel.org>
	<CAM_iQpXaf9132bjg=MkJYttoz7ikypmeJbpo=-t6qJmutYe9-g@mail.gmail.com>
	<CAM_iQpXDtMngE1Pcf9KBmRpb5sZK4EJj6qgPgt1ioYW4QC9W3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 20:25:09 -0800 Cong Wang wrote:
> > > Same problem as on v1:
> > >
> > > # Could not match regex pattern. Verify command output:
> > > # qdisc pfifo_head_drop 1: root refcnt 2 limit 0p
> > > #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
> > > #  backlog 0b 0p requeues 0
> > >
> > > https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/966506/1-tdc-sh/stdout
> > >
> > > Did you run the full suite? I wonder if some other test leaks an
> > > interface with a 10.x network.  
> >
> > No, I only ran the tests shown above, I will run all the TDC tests.  
> 
> Hmm, I just got another error which prevents me from starting all the tests:
> 
> # -----> prepare stage *** Could not execute: "$TC qdisc replace dev
> $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1
> 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0
> sched-entry S ff 20000000 flags 0x2"
> #
> # -----> prepare stage *** Error message: "Error: Device does not have
> a PTP clock.
> # "
> #
> # -----> prepare stage *** Aborting test run.
> 
> Let me see if I can workaround it before looking into it.

CC Pedro, in case he has cycles to take a look.

