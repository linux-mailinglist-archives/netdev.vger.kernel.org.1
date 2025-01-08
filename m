Return-Path: <netdev+bounces-156108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B8FA04FC0
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA91888808
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643521AAA1F;
	Wed,  8 Jan 2025 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlMTM+5e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81D1A8406;
	Wed,  8 Jan 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299996; cv=none; b=HV6/jLm9fdWqmryH2bLS+24KdFK5w7CFPk7j9amovPRvSpvBn89XcLlH3VlfQ6kF3MnjYqAkuKkw3ErAU1MtUr1GU37jdaG9Wl8JOdDi/U/7652mVZCCnAjAKJySwDfWN6TLWO8xxhF9GvH9dHNmPc1mJRI1rBa0FKYEknqULIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299996; c=relaxed/simple;
	bh=iocFTCxX0iNXGgkF8+L88YaBmXcr1I69TJZdl2BtGj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhauy04c8r3EKTJpNv1WhjKkq7w9RCZfWSzaho1ABTfkVNOu5rs9pNS+td9Vv7uvsUpVcqMPbP4aDrAYxi8gg3aZFDp4PeP4TrIBdqsIvOaSSvxPWiEwfXA4ko7h4OeFTR8T7hje5Oraq4HFY/tMTwwARtqhhstFFRpHSedd8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlMTM+5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273C4C4CED6;
	Wed,  8 Jan 2025 01:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736299994;
	bh=iocFTCxX0iNXGgkF8+L88YaBmXcr1I69TJZdl2BtGj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MlMTM+5e33I5EH4hZXZLXRZk3TABkqYVq5Qo/AMuxvCn7NO2K5IvQB8uEuIs68nkM
	 Zj9EcL8MZjKc8QvjxGzCnLtmUP/5ZbSYP44IvgqoXWKIFe9CRtcRm+VY+mMvoAheBZ
	 vSojB2F+OFJHUhddUOF4kCv+Pa1YYxIqhK/pCHJqWOzLzT79DEwzm/EUDaGcK4yVyr
	 SkupUWQrESwAJXUFPwtEuZtAg5DphyVFPIFbSfb8txuzzWJt6cOqgkjRPRh+GP8Fi5
	 xYViG5zAd8jUatQVT4xjZ03LV9p0OPzPCIJJbyDD7UxLOySUvpchz8HDE80WFOzbp3
	 ykUgx3ICShIVw==
Date: Tue, 7 Jan 2025 17:33:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <lcherian@marvell.com>,
 <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
 <andrew+netdev@lunn.ch>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v8 0/6] CN20K silicon with mbox support
Message-ID: <20250107173313.026109a9@kernel.org>
In-Reply-To: <20250105071554.735144-1-saikrishnag@marvell.com>
References: <20250105071554.735144-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Jan 2025 12:45:48 +0530 Sai Krishna wrote:
> 	2. Jakub also suggested to convert macros from patch1 into helper APIs.
> 	   Since this will result in lot of changes (at >100 places across
> 	   multiple drivers), will submit that patch as a separate cleanup
> 	   patch.

And then repost this set.
-- 
pw-bot: cr

