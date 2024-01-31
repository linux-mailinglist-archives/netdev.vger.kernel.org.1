Return-Path: <netdev+bounces-67665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9858447EC
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 20:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E0B1C22F2A
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 19:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7559038DD1;
	Wed, 31 Jan 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl5CLRc+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BF3770C
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728856; cv=none; b=DqfDMES8y8xSKvcegmlhVz0/9ZeVYyQ8jFbTPJkn9mAsoXxcKw1rPjePOlqD1uCIQzdyIMBydAkAHrVRNSq1MRgoFCxG+8SipBMZOlmu9pSUt8QOCKvLcvFQzGZn2p8H/MHr6kZvBBGp8Ae9s+DEMZewoDAVobM1e2rcwQ+OBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728856; c=relaxed/simple;
	bh=NPgmKSOan1dCkfJ4Sjy09Dw5yiqCcxmw3MaFtNqKDhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hc07Bw+cXNeWYggzlnOeJ65miOXXBk9b1a/+v7EcTCcvfN2Ydr1Gd7+p4Myj7eVlDRsTK5ljup3jhBcWRCZmfaHtxSHLi/ZCQsPfTmJAXWfnxRPxpl5finKy18bYPxPPZBjeY3OmIFJZiNI0R1Uav1//RMcbqLt8wIBbo3i5asw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl5CLRc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FDBC433F1;
	Wed, 31 Jan 2024 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706728855;
	bh=NPgmKSOan1dCkfJ4Sjy09Dw5yiqCcxmw3MaFtNqKDhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nl5CLRc+rUdzqH8AgqC8d9vvs7gkHwgmpIt9438RBc5ApSZPuIvdAJJ53LFkG6MF/
	 EzsOQAcH0GxftTzUTk+EV0LatmU0vBT80AcO/ezMuNfa2TcfeleYWe7Ej7Bfq8kJTq
	 Huh0O8FdzD00czrElcwf9DMTE8JOczcMTFEtZuXVhFjXPD1KmQNo90WW7BKtMOqBzR
	 I3r+pDzt2aqh8bKc2MMloahbWF5NZwMTXzPB+jbIBfQj1q1m4E4NmNw08JvIw7KErE
	 q+XyoQx/kOc8fRLwWivBbHY19FftRX2u+mE9Y0Mhxrkqd+/3RccO0E8zuuzOMSxI0Y
	 tPmJieXUyu+Gg==
Date: Wed, 31 Jan 2024 11:20:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, liuhangbin@gmail.com,
 sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH net-next 5/5] selftests/net: Adding test cases of
 replacing routes and route advertisements.
Message-ID: <20240131112049.2402e164@kernel.org>
In-Reply-To: <20240131064041.3445212-6-thinker.li@gmail.com>
References: <20240131064041.3445212-1-thinker.li@gmail.com>
	<20240131064041.3445212-6-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 22:40:41 -0800 thinker.li@gmail.com wrote:
> +	N_PERM=$($IP -6 route list |grep -v expires|grep 2001:20::|wc -l)
> +	if [ $N_PERM -ne 100 ]; then
> +	    echo "FAIL: expected 100 permanent routes, got $N_PERM"
> +	    ret=1
> +	else
> +	    ret=0
> +	fi

This fails on our slow VM:

#     TEST: expected 100 routes with expires, got 98                      [FAIL]

on a VM with kernel debug enable the test times out (it doesn't print
anything for 10min):

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/445222/6-fib-tests-sh/stdout
-- 
pw-bot: cr

