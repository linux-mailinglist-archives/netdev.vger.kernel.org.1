Return-Path: <netdev+bounces-32381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1E579733E
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65101C20B53
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C033B10971;
	Thu,  7 Sep 2023 15:11:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80195C8C7
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B527C4E66F;
	Thu,  7 Sep 2023 15:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694099510;
	bh=5fMuwD96ds3a8EcXw2VTRST/WxuhgKs05phn7bNlpRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlUT2Q2rPWsCArl4Ps1Ib7BKAZALnSAq90OTnwyOVQwKZcHVHj+ET+cTl3UoyiRTN
	 cZzEBLA2wrd4zL2ZdcauyQVJt8nfOow67jThC8HNBlYVzN6c+8eWL9TrrT63dq7MO4
	 NYSoIIh2JtnS9z2H1J2BOXd6b6st8LwAT212kl7Zvj/+oApHEXqVvz4ADiN6C3dsY4
	 XOmqY4EMQxtbJiu2yPOA9Y+7S25M3pJG/qg9ijJ7PjnB4Ib0dJcJX+mMnGARFvO/GX
	 A8f2eUq/rEgVuG6lNG670d6lmilEJVqIYPLZLr5TvjeyPXTPxaKH/5Jxzm62sshqA/
	 MroSoVs8CWANQ==
Date: Thu, 7 Sep 2023 17:11:47 +0200
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Dave Watson <davejwatson@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net 1/5] net: tls: handle -EBUSY on async encrypt/decrypt
 requests
Message-ID: <20230907151147.GG434333@kernel.org>
References: <cover.1694018970.git.sd@queasysnail.net>
 <9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>

On Wed, Sep 06, 2023 at 07:08:31PM +0200, Sabrina Dubroca wrote:
> Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
> requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
>  -EBUSY instead of -EINPROGRESS in valid situations. For example, when
> the cryptd queue for AESNI is full (easy to trigger with an
> artifically low cryptd.cryptd_max_cpu_qlen), requests will be enqueued

Hi Sabrina,

as it looks like there will be a v2, checkpatch --codespell, asked
me to suggest:

 artifically -> artificially

...

