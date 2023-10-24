Return-Path: <netdev+bounces-43985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8917D5BCC
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340C1B20F86
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8923D3CCF9;
	Tue, 24 Oct 2023 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIO7y985"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAD266A9
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DC9C433C7;
	Tue, 24 Oct 2023 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698176933;
	bh=cD2e1TlbZi88hgt3F5DztT/T6aBFB6sAIbsycdAqO/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZIO7y985StqtaP7K3IB81DAD/vWjNY4//YfGcWMj8crooxjZlEQC4lwauoBgKY9ZW
	 ru7ZmkFntQx6t0alcSkFD+ekVmVJ0LwAT8dUV4j0GsTW25jv5XxH82p/2Wxzncf49E
	 9x1PJ/LnRxHHI4ebPsN3tbTUaOuUtf3SdUkQXbxDFlcB5IyjgZikEs9rLqOaABt0h0
	 0MB6Mlwm/P6YT3D9NsHH1/y+uU2e8pm1IGOhvh9p1tzpgaHHsANHl4jkc5FLjUHa6N
	 ttjbgZAs8eekiOe+S59U3wcjHLY16xuc3/xeripNJFtgYVgiL5jVba9a11Dt6gca0j
	 Q0JxWmHPo7kvg==
Date: Tue, 24 Oct 2023 12:48:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org,
 davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com,
 dsahern@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH resend 1/4] net: ipv6/addrconf: clamp preferred_lft to
 the maximum allowed
Message-ID: <20231024124851.354e2e09@kernel.org>
In-Reply-To: <20231024194010.99995-1-alexhenrie24@gmail.com>
References: <20230829054623.104293-1-alexhenrie24@gmail.com>
	<20231024194010.99995-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 13:40:01 -0600 Alex Henrie wrote:
> Without this patch, there is nothing to stop the preferred lifetime of a
> temporary address from being greater than its valid lifetime. If that
> was the case, the valid lifetime was effectively ignored.

Please:
 - add cover letter, with the changes from v2
 - PATCH net-next v2 in the subject prefix
 - do not post in-reply-to, instead put a lore link:
   https://lore.kernel.org/all/20230829054623.104293-1-alexhenrie24@gmail.com/
   to the v2 in the cover letter.

