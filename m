Return-Path: <netdev+bounces-37507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D770D7B5B86
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 1269B1C20860
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674001F958;
	Mon,  2 Oct 2023 19:46:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD71F94D
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 19:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663C4C433C8;
	Mon,  2 Oct 2023 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696276011;
	bh=oLEsUduYmZvOUTMGg/IPA5u/JdFmXhsFK4Vy4fxeEBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FwzIk0vvuyoVEz/UQXyfotIbZRBMlZe7W4puzXNQBxo/1fGDpyx4uqXVsy6c3sn9g
	 riH5w2DFjMLKN1EjjOhaHb24ZGJXTU9A4G3bWu0RvMGbTrfRtCjvkzSex412sz7NxB
	 Sdkew70XsnZVZ6veNBwoNz4XskZbs84LMyAozi1Lpjbok6/nA3vumIYLsEMj1nXbjj
	 jqp84QnQUHrW9UmhrjArf+VgkgTk4fXsh1sHMkJhUWIQEB5arGAUgXUri2Dg3NPLnd
	 NCTs65VGhYiL0tUictU44v2eq424mDDVtGmUNCY3iGHmrsMFbOs+wlK67pwdkloU/L
	 6aq5SPWmQ+Tmw==
Date: Mon, 2 Oct 2023 12:46:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sven Auhagen <sven.auhagen@voleatech.de>
Cc: netdev@vger.kernel.org, thomas.petazzoni@bootlin.com, hawk@kernel.org,
 lorenzo@kernel.org, Paulo.DaSilva@kyberna.com, ilias.apalodimas@linaro.org,
 mcroce@linux.microsoft.com
Subject: Re: [PATCH v2 1/2] net: page_pool: check page pool ethtool stats
Message-ID: <20231002124650.7f01e1e6@kernel.org>
In-Reply-To: <abr3xq5eankrmzvyhjd5za6itfm5s7wpqwfy7lp3iuwsv33oi3@dx5eg6wmb2so>
References: <abr3xq5eankrmzvyhjd5za6itfm5s7wpqwfy7lp3iuwsv33oi3@dx5eg6wmb2so>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Oct 2023 13:41:15 +0200 Sven Auhagen wrote:
> If the page_pool variable is null while passing it to
> the page_pool_get_stats function we receive a kernel error.
> 
> Check if the page_pool variable is at least valid.

IMHO this seems insufficient, the driver still has to check if PP 
was instantiated when the strings are queried. My weak preference
would be to stick to v1 and have the driver check all the conditions.
But if nobody else feels this way, it's fine :)

