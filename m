Return-Path: <netdev+bounces-31320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE8B78D12E
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 02:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E2E2812D4
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 00:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC85CEA1;
	Wed, 30 Aug 2023 00:38:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160EEA0
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 00:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9FCC433C7;
	Wed, 30 Aug 2023 00:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693355901;
	bh=n9REtxpPEEcpgNQqc/Ep7uBG/38Dz7iopZPknXcvA2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IwBl9zNkyRUx0Xluqb39Ilk2HLALCBnds271r75FiLGSzLE3NMSs+ELHU933rqsqy
	 qcnUCPn4LkKK+wsRD5M3Gu+WyI4UxWckztXZiq12M64lb0HBt7+v9rr2iDbbwvw3g5
	 UrAfrfladyOiguMKSJPSCybVVJ9zccNPM6vVzANv9zrsQS65yNFkF9eo7BYwx94yQk
	 QeTIaDQdFFlHQeTatUtN7isL88D3ZLD0/SCLlPWNeM9xgoVVGvXQ395jFbFmCinFH0
	 rJ05YmK6CUNirAJJ3z4WcKG+BBwnExMJ0fODtnF6KjDCdmGEKc9ZINBNHHuzguHJRY
	 8O+UdGEfJ4Z+w==
Date: Tue, 29 Aug 2023 17:38:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Paolo Abeni
 <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian
 Westphal <fw@strlen.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Rakocevic, Veselin" <Veselin.Rakocevic.1@city.ac.uk>,
 "Markus.Amend@telekom.de" <Markus.Amend@telekom.de>,
 "nathalie.romo-moreno@telekom.de" <nathalie.romo-moreno@telekom.de>
Subject: Re: DCCP Deprecation
Message-ID: <20230829173819.5ddb6497@kernel.org>
In-Reply-To: <CWLP265MB64494218BFFF89EFB445543EC9E7A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
References: <CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230710182253.81446-1-kuniyu@amazon.com>
	<20230710133132.7c6ada3a@hermes.local>
	<CWLP265MB6449543ADBE7B64F5FE1D9F8C931A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<0cb1b68794529c4d4493b5891f6dc0e9a3a03331.camel@redhat.com>
	<CWLP265MB644915995F6D87F6F186BEF7C915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230816080000.333b39c2@hermes.local>
	<CWLP265MB644901EC2B8353A2AA2A813CC915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230816101547.1c292d64@hermes.local>
	<CWLP265MB6449B1A1718B6D8CD3EBFB27C91BA@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230818092027.1542c503@hermes.local>
	<CWLP265MB64494218BFFF89EFB445543EC9E7A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Aug 2023 15:17:08 +0000 Maglione, Gregorio wrote:
> For the purpose of upstreaming, the repository was forked
> [https://github.com/GREGORIO-M/mp-dccp] to remove non-GPL components
> and to update the license to show GPL-2.0. Is this enough to solve
> the license issue? If so, is it still agreeable for us to upstream
> and maintain MP-DCCP, so that, once DCCP deprecates, MP-DCCP becomes
> the sole DCCP enabler in the kernel? What steps would the upstreaming
> involve? Do you require any information about the MP?

Who is going to use it? Your earlier responses gave me the impression
that you just need a number of implementations for the standardization
process - apologies if I'm mistaken - but we suffered thru maintaining
the unused DCCP code for years, we need real users who will care.

Please use a sane email client you're responses are very hard to parse.

