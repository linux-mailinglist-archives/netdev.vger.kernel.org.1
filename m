Return-Path: <netdev+bounces-186103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEADA9D32E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BAA4C5CDB
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ACC217677;
	Fri, 25 Apr 2025 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDRsi8wu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16161AC458
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613930; cv=none; b=dMYnL0dyFLp4qJnj01BbMerK0jXMn+Rv4S0pvGpnQKkYgpVUsmP4tLOTfVe244SKHZc5d1F/8KqfCSo6wyk/U3EHkajbAU1Vnvwr3a+BjZN2QLw68CKIauQrqlPNt/Vim/x7VwajIPuqtxE7nWthMEtkBuaFgVsvcjJdDuv1nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613930; c=relaxed/simple;
	bh=NVLPY3TQPPA+5Xr9dGwt3+rlY84P57YWNlBbnitEeaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TybJBZieTvuYjdeCnBwPsUiNEOnJ02FLg7d/Swnx+Soxb8LjzD6th9WjHuW0Kg9ZDoCn2W4NQ5W+ywoHn9YRVKKfkdVdRRu4ee4vtVT7UOqd/FruIKz++hPmFq8DJxkdvSJow9m4OqQd1RnTxALZHfauxfrj++MVXEmXqEltd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDRsi8wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9234C4CEE4;
	Fri, 25 Apr 2025 20:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745613930;
	bh=NVLPY3TQPPA+5Xr9dGwt3+rlY84P57YWNlBbnitEeaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pDRsi8wu1cBk/m2SJI252C6SMpnxgD4h7JTqprXGko2ySluwcQvpDeSDBPAs3IALS
	 JZtiInDasXFHNgNRmhxCUsoVI9Hxf5IPB/HZWlI1aj3R22FZ1KCXWtS3NF2tYxc0pu
	 bmmoENGsmRfVZjW07GWP5WVtSTJxG4x43qOUY/eg2t5nQ3CfygdcllsXSp0R31Y1WW
	 Esb64E9KGK41ZjsxmfAdERFI7p+gAWDFwsk7nbKTP7bjFnKC6VIQ9MfNYuhJVxcJfU
	 OM2NjabrELorBLDGlt/77GMbZb8FWztkQktO9sAvYRq+3ytcSI4Ty+7gnSEIcYK/to
	 pWKvJlMyq0pCw==
Date: Fri, 25 Apr 2025 13:45:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 horms@kernel.org, donald.hunter@gmail.com,
 kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <20250425134529.549f2cda@kernel.org>
In-Reply-To: <kxyjur2elo3h2jkajuckkqg3fklnkmdewhch2npqnti6mylw6f@snsjaotsbdy2>
References: <20250416214133.10582-3-jiri@resnulli.us>
	<20250417183822.4c72fc8e@kernel.org>
	<o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
	<20250418172015.7176c3c0@kernel.org>
	<5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
	<20250422080238.00cbc3dc@kernel.org>
	<25ibrzwenjiuull524o42b4ch5mg7am2mhw5y2f5gb6d6qp5gt@ghgzmi7pd2rw>
	<20250423151745.0b5a8e77@kernel.org>
	<3kjuqbqtgfvklja3hmz55uh3pmlzruynih3lfainmnwzsog4hz@x7x74s2c36vx>
	<20250424150629.7fbf2d3b@kernel.org>
	<kxyjur2elo3h2jkajuckkqg3fklnkmdewhch2npqnti6mylw6f@snsjaotsbdy2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 09:27:19 +0200 Jiri Pirko wrote:
> info_fuid is the devlink info function.uid I'm introducing.
> the "fuid" under port is the port function uid attr from the RFC
> patchset.
> 
> Is it clearer now? Should I extend the diagram by something you miss?

Yes, it is clear. The eswitch side makes sense.
You just need to find a better place to expose the client side.

