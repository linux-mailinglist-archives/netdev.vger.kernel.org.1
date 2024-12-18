Return-Path: <netdev+bounces-152796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84E79F5CE0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8F3161196
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3483597B;
	Wed, 18 Dec 2024 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2UDFyGf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F0D35945
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488944; cv=none; b=fZeXKmpBFuCd86/OnLQLLmAJ+BtdU/kGX0afgH4qghtIVHPB9PZb++C/mQyDeFArM6h6a+2l2kbv5bDN1E9llRPmUcGmtSA6l19f7KUgrT1hi2GjTA4IinR9g6n8zTy1YvbT1NgeLYI3pZmSDE0BoGle1PO7LOE4s8wrcbk4dNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488944; c=relaxed/simple;
	bh=oPbQa5DP0MkHYM7KbpOxIT/1VGUpvIeYyPQPH7FY4Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNXd9IZucGgEIx3vbPtLomCFLPrIIUK7kGXCjF900WgObHB+MgaFMXM7vuZ57UQgVWwj+iif5KrnkLsqicqcwFJSqZACgJY2Les+pbo8+GtrBehQIjyX7W5fVSwMLCxZQI71AuF1qqYt4xLcMwnMPNw3G08FLJtCHsvm8MRyCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2UDFyGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC6DC4CED3;
	Wed, 18 Dec 2024 02:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734488944;
	bh=oPbQa5DP0MkHYM7KbpOxIT/1VGUpvIeYyPQPH7FY4Ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k2UDFyGfe2fUn7M1y3glGEhbmU41RM9iuBKwbpPXAfQDTxEyCUecUdaH7jaa1BF+c
	 +c+L7JmF1HLyM5zhwivIFrT2KdipE9n/YsMe2oXQ/Ebs6a+kXM0h4tKYXQOqylUteA
	 JUsiov/NBAqNIMQVBRhT/WuOV3xsnH1xcHXeCRLwUyK4COQqIGTx7BCPjhH5S8R0L1
	 QC7mT27rKdd06d7OKQ3rVmTFtMeJ4qnvoJ5C9eo4W2SRFxrk1e9JDZPto30L/4g0b0
	 Nj1GZagiBSeESLw+DqtEKtUchBieofpuHCy7QyVE87vpB8hyl4qg2Yfhxd1G+n09m6
	 wOi11ZwjptHdQ==
Date: Tue, 17 Dec 2024 18:29:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com, jdamato@fastly.com,
 almasrymina@google.com, sridhar.samudrala@intel.com,
 amritha.nambiar@intel.com
Subject: Re: [PATCH net] netdev-genl: avoid empty messages in queue dump
Message-ID: <20241217182902.4379679f@kernel.org>
In-Reply-To: <20241218022508.815344-1-kuba@kernel.org>
References: <20241218022508.815344-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 18:25:08 -0800 Jakub Kicinski wrote:
> Subject: [PATCH net] netdev-genl: avoid empty messages in queue dump
> 
> Empty netlink responses from do() are not correct (as opposed to
> dump() where not dumping anything is perfectly fine).

Well.. I shouldn't have said "dump" in the subject, then.
Let's see how the review goes, I can adjust when applying.

