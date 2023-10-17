Return-Path: <netdev+bounces-41910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF57CC2B5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A2B20FF5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA0041E34;
	Tue, 17 Oct 2023 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odlnoyZW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2141AB7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE65CC433CB;
	Tue, 17 Oct 2023 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697544842;
	bh=06J8CZ7VBYUbeatxCZl3b3oPCcMMhuL/w4M6oqMY6Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odlnoyZWBIfn8nUOA0iAKS1R0AJ7tigSUBqkmZVIK9mhCB5y5KT/iP8p4Luakd8yu
	 AuvDLKWXebOReVZIVR+secdb9roYWt2cu0OtuWW+v6WdLM31qyhO7aK5kN5UCObKFZ
	 aJq/pEO+sV0oa0EjKKRSWlqLqsWtKi9N3/GK8oFYIcLzkOHQD5YNcNGEFTV9v/Js8s
	 XwHFBSKcb9tvyqYilweNNGoSHIdQAt4oSEydPUZ+LuscsA4p33ibyGWCuBZH9XQ9RN
	 RC5vTiFeCUxDFXwXjiXMbrHw6njUYrtcf8zDIRKD4bdJCFxFhxaF708IyNHBY4D4N9
	 h3Zg/DEveIMIQ==
Date: Tue, 17 Oct 2023 15:13:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	Raed Salem <raeds@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH xfrm-next 5/9] net/mlx5e: Unify esw and normal IPsec
 status table creation/destruction
Message-ID: <20231017121357.GC5392@unreal>
References: <cover.1697444728.git.leon@kernel.org>
 <d0bc0651c0d5f9afe79942577cf71e7d30859608.1697444728.git.leon@kernel.org>
 <ZS5WK8V0+JoTlNmu@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5WK8V0+JoTlNmu@gauss3.secunet.de>

On Tue, Oct 17, 2023 at 11:38:51AM +0200, Steffen Klassert wrote:
> On Mon, Oct 16, 2023 at 12:15:13PM +0300, Leon Romanovsky wrote:
> > From: Patrisious Haddad <phaddad@nvidia.com>
> > 
> > Change normal IPsec flow to use the same creation/destruction functions
> > for status flow table as that of ESW, which first of all refines the
> > code to have less code duplication.
> > 
> > And more importantly, the ESW status table handles IPsec syndrome
> > checks at steering by HW, which is more efficient than the previous
> > behaviour we had where it was copied to WQE meta data and checked
> > by the driver.
> > 
> > Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> This one does not apply to the ipsec-next tree.

You are right, sorry about that. It is based on two net-next series
and I didn't expect such a fast response. 

1. https://lore.kernel.org/netdev/20231002083832.19746-1-leon@kernel.org/ - accepted.
2. https://lore.kernel.org/netdev/20231014171908.290428-16-saeed@kernel.org/#t - not accepted yet.

Do you feel comfortable with the series/xfrm patches? If yes, Saeed can
resend the series directly to net-next once patch #2 is accepted.

Thanks

