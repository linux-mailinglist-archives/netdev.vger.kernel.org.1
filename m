Return-Path: <netdev+bounces-198076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 398B7ADB2B3
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7781718847D6
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2AE2877DF;
	Mon, 16 Jun 2025 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE9qhnox"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321F2BEFE3;
	Mon, 16 Jun 2025 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082234; cv=none; b=WhaPbZivmZHk2ByELu9JlLT9rNbqpSuXsDJHiEniTl5y5r7fD12oJU1KOnlBeqOmFE3J5+vQmCG9+w3Kh66tNDSG6XPL2q5ykK/NaYJUHjYa66QCSbc+FLEVdq/Ncli79zb2IcWM1y7t1m2ArqWqsGz75vuN18FFsDn1i8e2uxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082234; c=relaxed/simple;
	bh=Hk7Va6Iu364kbEVxUitn8McLv5eF7J6RIuH3M1AERsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0VzSau54rP+Lv+NxMevu3YT4kg/ga5Nk6/W3TY5yrDfAXjLbLs5RpUOmbp9sreYG9Gup+HIcWtXosPfbQswxuv1EAJF8TdmB3+IRXrv/ONSuLMrSXj5t/2YVkl7cisCkFVMwr5d7FRtXCC5soumRnUTq8WPSVxBwfaqXds36jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE9qhnox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B69C4CEEA;
	Mon, 16 Jun 2025 13:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750082234;
	bh=Hk7Va6Iu364kbEVxUitn8McLv5eF7J6RIuH3M1AERsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UE9qhnoxXCy7fn7Vkg4R8LGvz1WsK4S0q+UOFp4Q28sm6seV5+oPaWpvdGvwff3KQ
	 cAOgU6Koid7IA9a06+w/va8VYZLjc8+X/LMP2AeK15Ya8jQN6zfL7gUISBucY+QDQZ
	 Ne/owr9ilELQreDyVs/XkDYNZRRlnFb81Yfvyeq2+Cjwc1DwWkWjJExhz4Yfxhn0wj
	 E/Mr4bCiaNR1K3tYvq0CyKX/j4/Gt880kcXT0Ugf5/BZhg1jqBE03n090NgCEl+oT3
	 sX5jk1NGT6kTmPcN1e5P6izNhkaZ30hI8/aMZ1DNiiJIjT1mTTd1Ua6jf35Ydy+lv8
	 K+ubGkgi/FIFA==
Date: Mon, 16 Jun 2025 14:57:10 +0100
From: Simon Horman <horms@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, asmaa@nvidia.com,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] mlxbf_gige: emit messages during open and
 probe failures
Message-ID: <20250616135710.GA6918@horms.kernel.org>
References: <20250613174228.1542237-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613174228.1542237-1-davthompson@nvidia.com>

On Fri, Jun 13, 2025 at 05:42:28PM +0000, David Thompson wrote:
> The open() and probe() functions of the mlxbf_gige driver
> check for errors during initialization, but do not provide
> details regarding the errors. The mlxbf_gige driver should
> provide error details in the kernel log, noting what step
> of initialization failed.
> 
> Signed-off-by: David Thompson <davthompson@nvidia.com>

Hi David,

I do have some reservations about the value of printing
out raw err values. But I also see that the logging added
by this patch is consistent with existing code in this driver.
So in that context I agree this is appropriate.

Reviewed-by: Simon Horman <horms@kernel.org>

...

