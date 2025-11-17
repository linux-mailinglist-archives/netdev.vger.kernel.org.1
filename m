Return-Path: <netdev+bounces-239274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7803AC6695A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3699529889
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE3929D268;
	Mon, 17 Nov 2025 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fJErVpZR"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725012949E0
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423234; cv=none; b=EiF9+cO0Ym1VX+RcwCb2Mt6krllraeDQDeG09iH9kDUTg9exk3OkJ70E49M2vJCmhD60qiD3J+c+dtq2QuOww7RYD9kFciAtiLaxyY6F/wPl8i1sssszUD3+Dr9Ry+doXhYJCI0kkf12VgfSZxYwICa9uBNMx1svwaQ6v3QkpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423234; c=relaxed/simple;
	bh=qHbQWa8oDveacpXLroAVyPiK+q4rhR02EvggKBZ4N/4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=sF8Qc4zpeAwc3u7WDz+iZxoLVZyI6dA9jzon69nSnm7Te4/XVswA2LpnDrWctXw/BqlqkE6s6HLPH4oLbv2epBb9k3kJ+8rjk4v3lfDpW/sYuAJtYdx0FtwRYRwXtamWufVyF5Zyx/4jcsw/k7kVgixQgt8btS8OIU4eS0MmF5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fJErVpZR; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b0df39ab-fdee-4b48-8739-74192cf5a26c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763423216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5L3fmoWKUNAJOBUlqJ5Dno0qPktD8xRVoa8UchMFYCk=;
	b=fJErVpZRKABGxPpie+A08Vfho4Iaf6MQGGFqMVml5yEQ4p9k2kWSB3N+W0U9EGbiVgVsQL
	VvHOz/efoWVx2yrXPQtwZ/nnPbSaBQl7z8MMGbQdjt8cJEAGqekgp3OQ5rEn7BWDUxN2kz
	LM6dJ8vy9N9uTPXDyUgc/UygpOlW0cs=
Date: Mon, 17 Nov 2025 15:46:51 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Announcement: BPF CI is down
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf <bpf@vger.kernel.org>, netdev@vger.kernel.org
References: <938dbf1c-d2b5-42db-8ceb-0121e0cac698@linux.dev>
Content-Language: en-US
In-Reply-To: <938dbf1c-d2b5-42db-8ceb-0121e0cac698@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/17/25 8:26 AM, Ihor Solodrai wrote:
> Hello everyone,
> 
> BPF CI has been down since Friday, November 15, because GitHub appears
> to have disabled the "GitHub Actions" feature for the kernel-patches
> GitHub organization without any prior notice. We do not yet know the
> reason for this.
> 
> Currently, the dashboard [1] shows the following message:
> 
> "GitHub Actions is currently disabled for this repository. Please
> reach out to GitHub Support for assistance."
> 
> This means that no BPF CI jobs, including AI reviews, will run for an
> unknown period of time.
> 
> In the meantime, please be patient with patch reviews, as maintainers
> will need to run the selftests manually.
> 
> [1] https://github.com/kernel-patches/bpf/actions

GitHub support re-enabled access to GitHub actions for kernel-patches
after a manual review of the account.

The workflows are able to launch now.

However please note that BPF CI did not automatically run for patch series
submitted between approximately Nov 15 @ 1am PST and Nov 17 @ 3pm PST.

