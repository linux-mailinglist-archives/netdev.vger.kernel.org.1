Return-Path: <netdev+bounces-18185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CADA755AFB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D6A1C208D4
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 05:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D684D63DA;
	Mon, 17 Jul 2023 05:50:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06906FA6
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 05:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A20C433C8;
	Mon, 17 Jul 2023 05:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689573008;
	bh=pgl6PJoOSONOm5ZYiNl1/zgwYMgt+PVFhF2XdFTsRmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drfHxyfpLBlexRaMzwD9vdni2tKVQrVyWjmJvOIaIaC570HF8AEPx+DyyiiGtpLXz
	 ZaLQQEbtjlNnsS+0HqVSwroADG21yK5vBCK34CjPee33i4hzAt6mlv0GZspiVC1S+t
	 a51cxJs/j8CriNkDmRX/IcSzaktKqC0BNjQ+T3S1bKeFbCNe3ku3krbEMARFPHiaRG
	 rvW0mKAGG77yyBvKmofS+STs8waUaACFuLqgh5hcjBRb5WvUQMy+4VJAJlAukxf/8/
	 9B4Jp3LrbtuA6KoKJzTQwC9/hGBj9XCsRdKiemsQJaXyvxkDAgLSEG5honTsPA7UrK
	 S2TEBI9TS7xCg==
Date: Mon, 17 Jul 2023 08:50:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH V2] octeontx2-af: Install TC filter rules in
 hardware based on priority
Message-ID: <20230717055004.GC9461@unreal>
References: <20230716182649.2467419-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716182649.2467419-1-sumang@marvell.com>

On Sun, Jul 16, 2023 at 11:56:49PM +0530, Suman Ghosh wrote:
> As of today, hardware does not support installing tc filter
> rules based on priority. This patch adds support to install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> Changes since v1:
> - Rebased the patch on top of current 'main' branch

And how this patch is different from another which was sent two minutes before this one?

https://lore.kernel.org/netdev/20230716182442.2467328-1-sumang@marvell.com/

Thanks

