Return-Path: <netdev+bounces-65562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160E83B06F
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AF71F21CD7
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9CC12A170;
	Wed, 24 Jan 2024 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0QT1Gf+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9712A173;
	Wed, 24 Jan 2024 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118562; cv=none; b=GmSQMS/7vatGCxHgjif+An6C29/pgah1KTmhKwlEmemN+Y0e2BjxKrRuNojJ6LMpGAKC50q1yAvHsvN1+29Z5nAq2bm3HHNPZ8ApqdbpXUpwqKLsMrPm36nj6mpo9xlG9xI9DMgayNx2Ma/XnC3S7HmQXF18xC2dQp3fXrmDSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118562; c=relaxed/simple;
	bh=3hqcFW9MFEt8NDYqZH9gctuv5FdtWm0NfQ0rEi8qqGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjBZVJjQ+860QDqKkK1DEtdJfD1qGu7j3iJKvV241PGwuVDSrhtnWDGOHHsJLRCEaSZ/hfd8VUZnrGoaiViDRHm5UKqa6s5fEo/W0ZRxJOy0qO1jTg1u0lL8tWfn8PcYt+bTm1hC2SU+hvGmbArdtkPidSvb4O22WhzSm3G7Sas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0QT1Gf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60FFC43390;
	Wed, 24 Jan 2024 17:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706118561;
	bh=3hqcFW9MFEt8NDYqZH9gctuv5FdtWm0NfQ0rEi8qqGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0QT1Gf+zL5KJBReam4s+r1rtChIyCb2BMK4e5ett/VTa+2Iiyyw/QG6t+PbEbitW
	 nLYakVNgpvpAUBBfFDbJDOSJNPvUlE7HuHJvdkTZukzg62APRaTARfrL5kdkXem6O7
	 itEvKbQj2R3CNTfyn92Jz4uKxryI/nGXTTfkn//WIPr2fiWqekasKbGmS5lWz6K3jt
	 RU0DCQyWU932dsirIOlfkrDJZmsKXsKvU8U7cM3Pl+8AKGhwm2mZ2dCVmW2j5NV3TT
	 G/rBaZhFpMfTuq164K21QYBWM5CN0nyJNM8dpH2QSfLYw9O5aoCFDvu9+9l8er02/D
	 CBaiZZ+uCrAIA==
Date: Wed, 24 Jan 2024 09:49:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>, pabeni@redhat.com
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240124094920.7b63950e@kernel.org>
In-Reply-To: <65b14c16965d7_228db729490@willemb.c.googlers.com.notmuch>
References: <20240122091612.3f1a3e3d@kernel.org>
	<Za98C_rCH8iO_yaK@Laptop-X1>
	<20240123072010.7be8fb83@kernel.org>
	<d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
	<65b133e83f53e_225ba129414@willemb.c.googlers.com.notmuch>
	<20240124082255.7c8f7c55@kernel.org>
	<65b14c16965d7_228db729490@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 12:42:46 -0500 Willem de Bruijn wrote:
> > Here's a more handy link filtered down to failures (clicking on 
> > the test counts links here):
> > 
> > https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-01-24--15-00&executor=vmksft-net-mp&pass=0
> > 
> > I have been attributing the udpg[rs]o and timestamp tests to you,
> > but I haven't actually checked.. are they not yours? :)  
> 
> I just looked at the result file and assumed 0 meant fine. Oops.

Sorry about the confusion there, make run_tests apparently always
returns 0 and the result file holds the exit code :( It could be
improved by I figured, as long as the JSON output is correct, investing
the time in the web UI is probably a better choice than massaging 
the output files.

