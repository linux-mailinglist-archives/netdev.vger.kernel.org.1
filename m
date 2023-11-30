Return-Path: <netdev+bounces-52318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C97FE481
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 01:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B33B20B7E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB62184;
	Thu, 30 Nov 2023 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCsQHIQF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44778180
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B910C433C7;
	Thu, 30 Nov 2023 00:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701302763;
	bh=6u44DYiZvsHHUFLjpV4+Vc4FcoKSEipA+Y8TxlLyMmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DCsQHIQF6mt4K4FKluE6wFxKfNyO4O+XPEb6plNaPcNo1/WZldmgb9DcCGzq4O9kp
	 bOf1VM0IrnV5BhFsSCPCAwuWMfPoECo0IZicE7HSxjpq09yQhs8uRFvImY27nKwBq6
	 61Ok9rvk3iGz1aHIaSNVvS5rveY7S3gG6GEPnq1FdQv92n3D7CKJXHK2YDY/YMQuVk
	 gdOskOXPFtWdPdrwWN6WDWwsOMpHvLvb66cTZ6m4JzXJ3eIG2exKevXbBHMRcMps0U
	 pjGYuOWX7JXqMDPOGUCeBuAN7CQUV4PFtuaut42mdZ6TzF5X2tKb42FnkK6ucP1ybf
	 DzzyoJDfrFnUg==
Date: Wed, 29 Nov 2023 16:06:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next 0/4] tools: ynl: fixes for the page-pool sample
 and the generation process
Message-ID: <20231129160602.0e3a1e55@kernel.org>
In-Reply-To: <20231129193622.2912353-1-kuba@kernel.org>
References: <20231129193622.2912353-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 11:36:18 -0800 Jakub Kicinski wrote:
> Minor fixes to the new sample and the Makefiles.

I'll apply this already, sorry for the rush.
I have stupidly activated a test in patchwork to catch breaking
the build again, without waiting for the fix to land.

