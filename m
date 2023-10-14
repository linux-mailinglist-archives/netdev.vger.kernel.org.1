Return-Path: <netdev+bounces-40925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 383567C91E1
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42835B20A9C
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EADD374;
	Sat, 14 Oct 2023 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVeNFWnh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360C7E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24854C433C7;
	Sat, 14 Oct 2023 00:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697244494;
	bh=dpbZVQj3qMQmGsLiSL0zW/jwtunvrJ6WzsKrq001a2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bVeNFWnhtNla8x0bipU3oTrrZoZ8mGSJbKnVxj7szcsKdETMW2lgbVE7+8U7p/8Im
	 tPtiPU6wKBYkLH5w5G6a6a2s/snBhvHm/utETKb0Exob+Tv5b0YfDkM+j/hdoA9cE9
	 WkHoJHyDdKZuDUri4uwyFKDDvwnlzOokqCAa9wJlqEphYcSNVymPO6NAAc3aLFDjvd
	 3I5WSWQHxrizOAbK737vtDITCrlqYLJ9VNMLvmAu7QHNQ0TTQs90K546/JnoYr+ttK
	 ijvQSQ6y4Vjfr5yQwKRJ5UUF+jkMR/mLxbHg5wqtqGa7tlbYBrP2Imuwh9X+aHXVDZ
	 HFOHrP8vTflNw==
Date: Fri, 13 Oct 2023 17:48:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Networking <netdev@vger.kernel.org>, Loic Poulain
 <loic.poulain@linaro.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Mat Martineau <martineau@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, "Srivatsa S. Bhat (VMware)"
 <srivatsa@csail.mit.edu>, Alan Stern <stern@rowland.harvard.edu>, Jesper
 Juhl <jesperjuhl76@gmail.com>
Subject: Re: [PATCH net 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
Message-ID: <20231013174813.5ccc3744@kernel.org>
In-Reply-To: <20231013014010.18338-2-bagasdotme@gmail.com>
References: <20231013014010.18338-1-bagasdotme@gmail.com>
	<20231013014010.18338-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 08:40:08 +0700 Bagas Sanjaya wrote:
> Emails to him bounce with 550 error code:
> 
> ```
> 5.1.0 - Unknown address error 550-'5.1.1 <m.chetan.kumar@linux.intel.com>: Recipient address rejected: User unknown in virtual mailbox table'
> ```
> 
> It looks like he had left Intel, so move him to CREDITS.

The driver was very likely written by an entire team of people.
I wouldn't bother with CREDITS. Also I think you have the entry
in the wrong place. It's alphabetical by surname.

