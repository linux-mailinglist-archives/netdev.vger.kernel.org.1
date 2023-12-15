Return-Path: <netdev+bounces-57907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AF1814778
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F308CB203DE
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D3E25566;
	Fri, 15 Dec 2023 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyDWZFRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEB325555
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63C3C433C8;
	Fri, 15 Dec 2023 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702641515;
	bh=YJY76vt7H3j6oGuRLu81CEKXBfUgk4Szi4jplBZI9pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyDWZFRqg3c//x1CR/YL23ymPmlqcMhhK60UXjM8pkIo4RDyxRWGewgsoiT0vQF4M
	 bqCXZT+itqK6BUT/KIJn7xuVGrbyK0JCwqOBrp4AlDgRgqMm+8Djl7PlJk24VtxjiX
	 6oJU3ALPKSod1FOCQqNZw10BBNoN2HTpLNMq5HCgAoZxrd2Fv9I61coml6JekQRKo7
	 9Hn1ZhO3tQMjXMQgtWknYCmwifwHoDHjJrL1o2NyG0rfaoG9wOxqYWEGJhvrY8icA5
	 Eypx/3vlPqM8585WpJebb2ZzvSTBw1V+nNnqPOrDoQtwNtoTRoJsthkkRQ3jwR+4MZ
	 jGtsMXkwUooXw==
Date: Fri, 15 Dec 2023 11:58:31 +0000
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/8] dpaa2-switch: move a check to the
 prechangeupper stage
Message-ID: <20231215115831.GG6288@kernel.org>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
 <20231213121411.3091597-8-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213121411.3091597-8-ioana.ciornei@nxp.com>

On Wed, Dec 13, 2023 at 02:14:10PM +0200, Ioana Ciornei wrote:
> Two different DPAA2 switch ports from two different DPSW instances
> cannot be under the same bridge. Instead of checking for this
> unsupported configuration in the CHANGEUPPER event, check it as early as
> possible in the PRECHANGEUPPER one.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


