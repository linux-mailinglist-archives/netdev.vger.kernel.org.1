Return-Path: <netdev+bounces-163311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB724A29E54
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC52165C04
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD629CE7;
	Thu,  6 Feb 2025 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpvdxJiZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F7151998
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805382; cv=none; b=JBmLTOAp51Vlb9DJAztP49zvpGf6byRKeEryAze09yR1kOKOd8W7lGr2E3Il/jjRxFD5mtLQyHlDuZPMaej1q8Pcyx67WbAQ3DZxtygV8cN73O+/xy5Tspx71DkCl7yrfvCslIqvAiNm1NV8ylkRA6s+buCfm6jJg7O289BAJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805382; c=relaxed/simple;
	bh=/cRh4sbZHxCAs3P1wejlY352AZcyw9BAUG8P/YoEsCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyRA+Lpi21FEbMYi1bamRcLEjQRRzogznPmOViBoMl5nn366MKz3Wz8H5ReP7QxK7mSqNM2zuK/T1TwTKb9p8tnRHLdcTaflwmQEP0HUjlyO/Q7kyu5GAoCEc1vUU/KTN2Ap+v3+qKjrquJKezNMf4NEZKpAI6rJLT9wW1U0WGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpvdxJiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EDFC4CED1;
	Thu,  6 Feb 2025 01:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738805381;
	bh=/cRh4sbZHxCAs3P1wejlY352AZcyw9BAUG8P/YoEsCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kpvdxJiZ3COuV0BOUGpB2Vo60jnr3NiDsqWmkYW7WcDYsxcWoGeF3l0bHBkJuM43c
	 UTslHz53LlBeK/yANjc7KOjJG1RlqhFjRjdO+sK77ol07cvzPvEzr/VLH1GjA66hLB
	 i+of44hvLHnlihdwFS7vWnLflEfW+hlL39ngr15yspCwPkQKhYOFQwSomr73arpU2R
	 CxKZpht//05l/fjZ/ci4rclgw+Ud9VFxptzAYLIKRjrBOmYgQsJcTwKMKB4HNp1iNY
	 5U/WXX+Xmxp2Mng/YjD0k6GeRoUzpqWKRQKLs/adjMNN3CryI6UTLHfmg0/dJ9Ku7k
	 ZklfpOZoq3gsw==
Date: Wed, 5 Feb 2025 17:29:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ian Kumlien <ian.kumlien@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 saeedm@nvidia.com
Subject: Re: mlx5 - kernel oops on link down and up?
Message-ID: <20250205172940.2a48e075@kernel.org>
In-Reply-To: <CAA85sZtE+qmv94hQgpiWtBFvG7tOdngao6Lxkrw-3Ry-fKvvSA@mail.gmail.com>
References: <CAA85sZtE+qmv94hQgpiWtBFvG7tOdngao6Lxkrw-3Ry-fKvvSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 12:49:17 +0100 Ian Kumlien wrote:
> I have two machines at home connected with two mlx5 cards - 100 gbit,
> for testing things like rdma for nfs etc
> 
> They are directly connected, so no switch is involved.
> 
> So, the machine on the other end had a bad harddrive - so it was
> powered down and up...
> To my surprise, my desktop broke in the process (network traffic
> stopped working)

Should be fixed by 979284535aaf12a.

