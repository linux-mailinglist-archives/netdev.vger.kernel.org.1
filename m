Return-Path: <netdev+bounces-116560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8FB94AE6D
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881AC1C20DC1
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DA713C3CF;
	Wed,  7 Aug 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OexwvxQi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942F13A276;
	Wed,  7 Aug 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049517; cv=none; b=foM9H+Qn7PKosMYGDqA+4F3kEjRJKob+g3kFiFodKvZBagUA/iYWz31ulNmfmXOWWDIdVRflsI9x33SfNJKW5bt4BV/dh8m5MwPon8t6hvBHkXmzDHi4hkYPQCgf3F5pOABPYoJwF5W2MQFAIM1iMfCcDm+wpHXU24Wz9PDJVyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049517; c=relaxed/simple;
	bh=09PqWrqZPQEMxJ1qjYQqQEpqsKuuC0Q/dPyS6HwV5P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcklOqeoVT18Qs1KV37uEOzQdr9JQ2hOdpxLsU0C3Kf3mZlEmV+CBHZXTLD9elnfJgDmk82NMsUBsevl+9JgIs1sugAvkgRVlKqUzeNv/oweVkN+XgzzyNlYMkn/wTVQMU+VSw+ohhfWd2fK8NonMct7T/Lc0XHCG5727Ds2gig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OexwvxQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E20C32781;
	Wed,  7 Aug 2024 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723049517;
	bh=09PqWrqZPQEMxJ1qjYQqQEpqsKuuC0Q/dPyS6HwV5P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OexwvxQiPL+Ht/JWFcWXTCYt2qe7JhUfehWeQmvvKdjmneR1VkWf05AxBRyIr0s6d
	 TC0i/Qwd3xMCA8fmNb4xN3f2fyqOuuQeARWPQbe1N9xK6JUkXeKPW88W/uLFoSD4eA
	 BMcgyNYMmDeMzaKBHDaZlglFe1aXX35LFldiDWSJfmKCSAOeIvJQYqvNyCPupqs9Ti
	 LBCPakv5obBEAd+i1lDWqLNGvHE46PeCNhw6yyHp5QEcpNyngHe6jyaNd+22/X1v15
	 KpbPz5UfYXADLUe2ChhbNX1LcZNsp1djhCPwV4ZGfWxCRwMrfAJT72tTW6WxFCjDkE
	 VjhrMQWaePJLQ==
Date: Wed, 7 Aug 2024 17:51:52 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] cxgb4: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <20240807165152.GD3006561@kernel.org>
References: <ZrD8vpfiYugd0cPQ@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrD8vpfiYugd0cPQ@cute>

On Mon, Aug 05, 2024 at 10:24:30AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of multiple other structs, we use the `__struct_group()`
> helper to create a new tagged `struct tc_u32_sel_hdr`. This structure
> groups together all the members of the flexible `struct tc_u32_sel`
> except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct member currently causing
> trouble from `struct tc_u32_sel` to `struct tc_u32_sel_hdr`.
> 
> This approach avoids having to implement `struct tc_u32_sel_hdr`
> as a completely separate structure, thus preventing having to maintain
> two independent but basically identical structures, closing the door
> to potential bugs in the future.
> 
> So, with these changes, fix the following warning:
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h:245:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


