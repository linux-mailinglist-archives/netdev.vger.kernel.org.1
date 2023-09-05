Return-Path: <netdev+bounces-32045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4505679220B
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798F11C2095E
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F500CA5F;
	Tue,  5 Sep 2023 11:07:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216ACA49
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAC6C433C7;
	Tue,  5 Sep 2023 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693912021;
	bh=DDzwoo0FWxIxZY0Djnf1lKgvlQdoIiE5NmUgemTY2K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4/KyZjmezRdHoqSSz7CoXGkF5qGYBwE6ppEJhKPrQZJ5aPzapGta1hGLFC3l5jkL
	 r0/n5VrD9jQ8bab6VU69k9Y/WdvTUAQaWy19a1H+2erX4hRM7xbjSRVL7YqiIxj1TH
	 iv/r/gj9smxte/CIwmsUPVIWS6zqksgg1us5VIPuPxDe04BsYY+PDeO5TzbYIm/sSl
	 pXTkS4H+/G5FWhBNexuUqDbJYbCUxwkURLaIrKVh0AslVkY8T6B3nX8XfMnqJthrNm
	 OW0Cy4kC/cNYx9zwOVbQG4olf8aPdD0GSTLNZQOz++b47sp/oTPycHZkB5pSno0NpO
	 tvjMglqY8zR4g==
Date: Tue, 5 Sep 2023 13:06:53 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	David Laight <David.Laight@aculab.com>,
	Kyle Zeng <zengyhkyle@gmail.com>
Subject: Re: [PATCH net] igmp: limit igmpv3_newpack() packet size to
 IP_MAX_MTU
Message-ID: <20230905110653.GD2146@kernel.org>
References: <20230905042338.1345307-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905042338.1345307-1-edumazet@google.com>

On Tue, Sep 05, 2023 at 04:23:38AM +0000, Eric Dumazet wrote:
> This is a follow up of commit 915d975b2ffa ("net: deal with integer
> overflows in kmalloc_reserve()") based on David Laight feedback.
> 
> Back in 2010, I failed to realize malicious users could set dev->mtu
> to arbitrary values. This mtu has been since limited to 0x7fffffff but
> regardless of how big dev->mtu is, it makes no sense for igmpv3_newpack()
> to allocate more than IP_MAX_MTU and risk various skb fields overflows.
> 
> Fixes: 57e1ab6eaddc ("igmp: refine skb allocations")
> Link: https://lore.kernel.org/netdev/d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: David Laight <David.Laight@ACULAB.COM>
> Cc: Kyle Zeng <zengyhkyle@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


