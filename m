Return-Path: <netdev+bounces-113323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF893DCE8
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 03:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D0E1F226C9
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E05F394;
	Sat, 27 Jul 2024 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCmKEyPo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C2415C9
	for <netdev@vger.kernel.org>; Sat, 27 Jul 2024 01:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722043629; cv=none; b=nAbqu2P9M5W6Q2d+UdkYC9RbYUIR3rbF7Hi0oE3Oqh9/I6dw9vzf7OgzZAn6a3BypsYRZKKNMgiZuEvzjwrwbnLuP5l+Ffquu8WhvG57vqYnYe543ULA/98ANYuz0ESZDu+vpUC4UD6tm5sylA7H8ytbg/NoBKqh6ya7S3cQurg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722043629; c=relaxed/simple;
	bh=/nkPQplRr0kQcwMlESKxzV+yQ/BKLpoyp5XqEsf75RI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuLYCOAI91FVnWQ70c46jOp0otjUKoEThlrjgH/uJ0fsRvPTlWWqPm8ZLNCgjqSv0RyXWaVuIQDusY+qoMKcGAAhLFuaxCcPJXCRUjBBsLAjVdnK43NlUvodgDug5SHEzbpAEtZrgF9XXtzfvNCLmAPq0Ygan2I6aoeERI3O+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCmKEyPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A650C32782;
	Sat, 27 Jul 2024 01:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722043628;
	bh=/nkPQplRr0kQcwMlESKxzV+yQ/BKLpoyp5XqEsf75RI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCmKEyPohth76iUicajbc4jFMnEku/GO5kWDgbWeE6P0k5PWvFBorjbKPCS4y3LT3
	 6SoJ39WXEInF3J9m3rUQGOd9WTZ/n2P54z+6nWmzE9A5Dv2Rd8BYCjCpx9uaXkZfYC
	 j4UtAaghsNPqS5Yz9pV0JpBCqBM1lqPdD1euWwpQ1g2F9j4V2fRq2eJcH2IxyYy9PN
	 2yxmoFgRvtBV9xRr4CyuRnGF6QOef8NJrpA2XIU/O3LfVOykiS9lzVcerxDDOHCH0g
	 uOHhWfiMhNzBbJTrMZBn9mtgzcVLsKPHDSqkf5t5JGbN4ndU34oFTQZBnxubmIRrh+
	 acJj6KwtgaxNw==
Date: Fri, 26 Jul 2024 18:27:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, kernel-team@meta.com
Subject: Re: [net PATCH] fbnic: Change kconfig prompt from S390=n to !S390
Message-ID: <20240726182707.61025a69@kernel.org>
In-Reply-To: <ZqPhHMaeTcgwEJnY@LQ3V64L9R2>
References: <172192698293.1903337.4255690118685300353.stgit@ahduyck-xeon-server.home.arpa>
	<ZqKIvuKvbsucyd2m@LQ3V64L9R2>
	<CAKgT0UdyHu3jT1qutVjuGRx97OSf+YGMuniuc2v6zeOvBJDsYA@mail.gmail.com>
	<ZqPhHMaeTcgwEJnY@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 10:47:08 -0700 Joe Damato wrote:
> > I will add it and resubmit if/when the patch is dropped from the
> > patchwork queue.  
> 
> Sure; makes sense. I honestly have no idea -- I think maybe Kconfig
> and docs are special cases or something? Just suggested the Fixes to
> be helpful :)

The driver is unusable without this patch, so I'd say it's a fix and
needs a Fixes tag. Since the ML traffic is low I'll just add it
manually when applying.

