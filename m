Return-Path: <netdev+bounces-153198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A649F726A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DA6165EE0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E824B7081C;
	Thu, 19 Dec 2024 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4LdgTts"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB469D2B
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573595; cv=none; b=MZmvRvMBog3G3GhWJB8gd1yxQnk4kVV0Bf6j8Yl3JQGxiUhuqwr/ezV8M+GZ13QKH70XHdKiW3//y9ywUU74yMygVD/Do484Jcl7yjbfOMtkyHjoh4YAca9FWEwfdCOqa5T8q5BHGznVhSkNcO2eYfInhiYo/0L9JPixZphmsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573595; c=relaxed/simple;
	bh=pktD9tMB/NkIA24GcTNudFt0kYH6590n4rXQZVZy5Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uw/9gwverwtKSlEoSzk3gSo/gPQSmjQ7pqZH/eW7KSMqt6S/BUk43MuYtiVsAmxz0tiqkJd84KA12ORSQR+oLIbZHaHDEncRQBwHDhJ42tOsUnzgRv1Wf6URXkboa/II5tYfjK9aamU4Y3/OLjzQnv2Tg89TYTHR4VVEW0LJDCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4LdgTts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2E6C4CECD;
	Thu, 19 Dec 2024 01:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734573595;
	bh=pktD9tMB/NkIA24GcTNudFt0kYH6590n4rXQZVZy5Xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E4LdgTtsbkMKdioeAmYB8lQWJpPTV/Gaj/Usy+7dMJeWFdycJfWIgI4P3m0eDgtxl
	 dYEvcPDypEeiZBlR7yMJZRHT+iYgohlDdcovU6GFTPkFiJM8buLg9xETxOscpSi9Wb
	 +W+Hs7/XmuVWEnvsaInEcHR2sQBTOeu7G5osplb3gy2fG/VWkCtWB2z+5iV+bJ8lhc
	 s2lbR6uthBiJQAKtP4ZV1qYy5gohwf2Likwosgr6F4HduevedYG73DUr17VcDO/P10
	 pyBn0fmltb6M6mRCMK2btbpGewTy0UN1dbiSjusSRqkv3ID79ClxfpVJCjDUKTfCqe
	 CH8CzMHNv9K1Q==
Date: Wed, 18 Dec 2024 17:59:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@lists.ozlabs.org>, <arnd@arndb.de>, <jk@ozlabs.org>,
 <segher@kernel.crashing.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 24/25] net: spider_net: Remove powerpc Cell driver
Message-ID: <20241218175954.3d0487c1@kernel.org>
In-Reply-To: <20241218175917.74a404c1@kernel.org>
References: <20241218105523.416573-1-mpe@ellerman.id.au>
	<20241218105523.416573-24-mpe@ellerman.id.au>
	<20241218175917.74a404c1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 17:59:17 -0800 Jakub Kicinski wrote:
> On Wed, 18 Dec 2024 21:55:12 +1100 Michael Ellerman wrote:
> > This driver can no longer be built since support for IBM Cell Blades was
> > removed, in particular PPC_IBM_CELL_BLADE.
> > 
> > Remove the driver and the documentation.
> > Remove the MAINTAINERS entry, and add Ishizaki and Geoff to CREDITS.  
> 
> Yay! Please let us know if you'd like us to take these, otherwise I'll
> assume you'll take them via powerpc.

I meant to say:

Acked-by: Jakub Kicinski <kuba@kernel.org>

