Return-Path: <netdev+bounces-159584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B68A15FC7
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7561881BC8
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8BDD2FF;
	Sun, 19 Jan 2025 01:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncye3MpV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB17EC2C6;
	Sun, 19 Jan 2025 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737249579; cv=none; b=I6mYGdMAM6+NmEZrry5ERc4B/GiPDk9WKzsA5gSM7Id6uB/EkVcZLkw7Qlf99uV3iVfOO18qN1DRelJllVzu0Of2CHH3p0mrnVjYCH/duI/LT+lqVHwK+ahkwa93tCXR8K8m9Tstyww5JY5ZkGCFp9OkcLj3sTVDjQVPzLCCvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737249579; c=relaxed/simple;
	bh=zuZ5zwiixBLUBOdkaV2voEo3Uvmifp61w4fBs1tmlt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efbgRaHRFcZCFKsye/usrNm3EwRNuXzmzHzz1C9l0KOQnvcrZAraYQKMmOnFktSuWJR8j+TVfdUp7/n1YgtX6MCNKs25Ea/wKzpbCNZZMzE5/IEAUQXsOd0kUqcM+aNQIQTp+Ygg7vrd735R89fUESk/osi9vN/rOnOmPicF3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncye3MpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968EFC4CED1;
	Sun, 19 Jan 2025 01:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737249578;
	bh=zuZ5zwiixBLUBOdkaV2voEo3Uvmifp61w4fBs1tmlt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ncye3MpVSvdthtZ+cEXLDaJwbvuk73NKy7yFEiQwrK0YE9op5uImyWgTg0w3IDvlJ
	 oy3bMvyxRpkY4uL8PuGSmCvGqbWcYqT+P3OcZ8bINXlRVrm90sBYTQtit0Wrcgl+8a
	 YHfBPI46JwJVSjAana8O1riKwpra4kC3i3eg6XyKbV+yxvHrWiSfSXjMrSJwOSR1jl
	 O5WQWLNZcxs1fHq4pwsaxkCCg2DZwTKMksrvlJlIrwv66tWZHNm+rvsOS4FrgY0x1b
	 Na0NUVbrSnqEaqJItNIZhimp4kbizW2AjdH6ZC2tRu5AliC8yxR8U3zBXz6S2v+NO9
	 qgwdqslQFEmEA==
Date: Sat, 18 Jan 2025 17:19:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org, Michal Simek
 <michal.simek@amd.com>, linux-kernel@vger.kernel.org, Shannon Nelson
 <shannon.nelson@amd.com>, linux-arm-kernel@lists.infradead.org, Heng Qi
 <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 0/6] net: xilinx: axienet: Enable adaptive
 IRQ coalescing with DIM
Message-ID: <20250118171936.703c0a27@kernel.org>
In-Reply-To: <20250116232954.2696930-1-sean.anderson@linux.dev>
References: <20250116232954.2696930-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 18:29:48 -0500 Sean Anderson wrote:
> - Fix incorrect function name in doc comment for axienet_coalesce_params

Huh, I wonder if you sent the wrong version..

