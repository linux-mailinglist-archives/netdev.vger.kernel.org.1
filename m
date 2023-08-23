Return-Path: <netdev+bounces-30033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F7785B25
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0B31C20C7A
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E407C2C3;
	Wed, 23 Aug 2023 14:53:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C3BE60
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD18BC433C7;
	Wed, 23 Aug 2023 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692802400;
	bh=I5gnC4HdDcDja7RTsPupoGDGGaOrcVOx4WcW/IaqU98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfwUVW7aNhFc7JyfsLlxFJTpFofGXSWfZKfKN/8ish5Uu6TZqxKqasrSGVy8Gy6IQ
	 mHbAohqTOJxWAEx11kI9DClfk/krMaUk2wuJ3O/KM7Yz9WJNgzD7CCBo79Kd4vUg7J
	 vPaSHeEOqiKQ/z4FUc3kx7hydlCm4sDChyKO78gMJTR79o9jgox4iyurRSTJn3EKFX
	 gR2KPuu84DiZtyUAp7SvaNJD4Z7KC9tqC9srr4yxAX4Rw50ZMvqJ/AlaVEHEnnqE6G
	 aZ3RunTgbc22Q3uyaDl0/39aAePkk1TdfJT/lYfky+9sOPv6kvatfZGCkJwz2jrjJP
	 VCQz0dUTxLucg==
Date: Wed, 23 Aug 2023 07:53:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: linux@weissschuh.net
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Marko
 <robimarko@gmail.com>
Subject: Re: [PATCH net-next] net: generalize calculation of skb extensions
 length
Message-ID: <20230823075318.4860cebc@kernel.org>
In-Reply-To: <1e1dde74-edc6-4306-9b1b-0a1b5a658b67@weissschuh.net>
References: <20230822-skb_ext-simplify-v1-1-9dd047340ab5@weissschuh.net>
	<20230822184644.18966d0f@kernel.org>
	<1e1dde74-edc6-4306-9b1b-0a1b5a658b67@weissschuh.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Aug 2023 10:14:48 +0200 (GMT+02:00) linux@weissschuh.net
wrote:
> > Could you include more info about the compiler versions you tried
> > and maybe some objdump? We'll have to take your word for it getting
> > optimized out, would be great if we had more proof in the commit msg.
> > --
> > pw-bot: cr  
> 
> Thanks for the feedback.
> I'll send a v2 with more background soon.
> 
> On the other hand this function is only ever
> executed once, so even if it is slightly inefficient
> it shouldn't matter.

Oh you're right, somehow I thought it was for every alloc.
You can mention it's only run at init in the commit msg if 
that's easier.

