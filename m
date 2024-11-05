Return-Path: <netdev+bounces-142002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED99BCEEB
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD818284414
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A7D1D5ACE;
	Tue,  5 Nov 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO94tLrb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F5433D0;
	Tue,  5 Nov 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816224; cv=none; b=qKZiKGc3i7I+xZdhP4cAiH1xkFX+tNckUMvQlLvQiNeHOeyqV33w+EpO6SL7+8RUqUIfHFEVhF9r3+wfplZZ/xBAyINjfLsFGqIlPWW6+BxPgXPWprX7ebde0MZW5Z9YHfBirWMLpfBmBEHMUdasQzHjrxd1DB8zIDc4m02Q114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816224; c=relaxed/simple;
	bh=0+L3qxW3NQK3xwclGQm/lsHI4QA8u4yxQmE9vqPlbzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7O0S6PZzgMlTMwSKQqoFw02CRhzzctYvukN4l3NAQYb4/X7RfETusKmCSJ9kkaeaEB8IuEqeLEuUr6rvbn3PO+87o+ccSU79NWT4YJitWEq023zOBdCfvJnJBSKbXxC1QBovItV3H8muGPOHJWRbYUDoptaSMM6sY0suEHHlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO94tLrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79348C4CECF;
	Tue,  5 Nov 2024 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730816224;
	bh=0+L3qxW3NQK3xwclGQm/lsHI4QA8u4yxQmE9vqPlbzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mO94tLrbQ9WmePaEa5eTBKLVjfQxFcuCIRtio8hjyC5O/0QAdX3EkZynfMXe895PN
	 Y1qeG64q0N6B7Pean75rt6wr9aSZkV70WsgRSkFH1BNGSQy+ghxENRg1GUa9IMwz0d
	 kTjNJUTa0csHEZPfMLsuKKQ99Xy41X6JlogDhdsNvxeBbYiYti9Zc7Ea0qRL0Qq36v
	 KCb2dLREDogLwLmd40EuokeN62+4htEbh1wcPrfJJ7zprseiz6jqWqVzNNhe+NYsgf
	 70NCBcnoUctJhM7nfFLXysBcH5HUIcCkRmxgRZrFte7dGjIysBZgziwMwqfvaAv5Fo
	 Nqj8Rrk+kKSvQ==
Date: Tue, 5 Nov 2024 14:17:00 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Karsten Keil <isdn@linux-pingi.de>, Jakub Kicinski <kuba@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] mISDN: Fix typos
Message-ID: <20241105141700.GG4507@kernel.org>
References: <20241102134856.11322-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102134856.11322-1-algonell@gmail.com>

On Sat, Nov 02, 2024 at 03:48:24PM +0200, Andrew Kreimer wrote:
> Fix typos:
>   - syncronized -> synchronized.
>   - interfacs -> interface.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Hi Andrew,

I'm wondering if you could make this a bit more comprehensive by addressing
all the non-false-positives flagged by codespell in this file.

With your patch applied, manually filtering out the false-positives, I see:

$ codespell drivers/isdn/hardware/mISDN/hfcmulti.c
drivers/isdn/hardware/mISDN/hfcmulti.c:28: otherwhise ==> otherwise
drivers/isdn/hardware/mISDN/hfcmulti.c:29: otherwhise ==> otherwise
drivers/isdn/hardware/mISDN/hfcmulti.c:44: ony ==> only, on, one
drivers/isdn/hardware/mISDN/hfcmulti.c:85: busses ==> buses
drivers/isdn/hardware/mISDN/hfcmulti.c:903: syncronized ==> synchronized
drivers/isdn/hardware/mISDN/hfcmulti.c:986: syncronized ==> synchronized
drivers/isdn/hardware/mISDN/hfcmulti.c:2004: maxinum ==> maximum
drivers/isdn/hardware/mISDN/hfcmulti.c:2565: syncronized ==> synchronized
drivers/isdn/hardware/mISDN/hfcmulti.c:2568: syncronized ==> synchronized
drivers/isdn/hardware/mISDN/hfcmulti.c:2738: syncronized ==> synchronized
drivers/isdn/hardware/mISDN/hfcmulti.c:2740: syncronized ==> synchronized
drivers/isdn/hardware/mISDN/hfcmulti.c:3235: syncronized ==> synchronized
drivers/isdn/hardware/mISDN/hfcmulti.c:3938: syncronized ==> synchronized
drivers/isdn/hardware/mISDN/hfcmulti.c:4006: syncronized ==> synchronized
drivers/isdn/hardware/mISDN/hfcmulti.c:4532: syncronized ==> synchronized
drivers/isdn/hardware/mISDN/hfcmulti.c:4556: syncronized ==> synchronized

...

-- 
pw-bot: changes-requested

