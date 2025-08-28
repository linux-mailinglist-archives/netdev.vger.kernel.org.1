Return-Path: <netdev+bounces-217874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912B1B3A3DD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4505E1D88
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0C325A359;
	Thu, 28 Aug 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdSAlFdx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB225784E;
	Thu, 28 Aug 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394108; cv=none; b=tv+3U6XccFERFAgIAIsI/tWVPPvPmbHG0JUYTeAy77Bev40TEsDwLzX1liXQatw62drSiPYdwbOJh4ZxK5WuQgSPjsZEJQKoqwreTpDS6xKP3Ep/jjABK2HYBu5UprA6QA1BJicv0aItRnlg7nIXlaFBz76zbwGqhLAvc5/qKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394108; c=relaxed/simple;
	bh=mLxKV4LpvSwMMNcwdUhVM99uRq0HV3poFUxOBFdVrAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvjyQQqxCNXS+f+2ELpEXfzr0DckKMHrLqKjIhnS6DVn99BtCXmIEzjXFPu97csg4LUYzvARKEldLQME/ncrenCmtGODzThMv6WCl3+KtxSS2vANhakx1WD3OkelHUiUQEElrqb6NDjbZY/hpTxuDx8EexNp5vhsnP5TAIfgBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdSAlFdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E81C4CEEB;
	Thu, 28 Aug 2025 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394108;
	bh=mLxKV4LpvSwMMNcwdUhVM99uRq0HV3poFUxOBFdVrAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdSAlFdx5TTeeezkFOfD6UQKyO6VT03FIMli3Z1FBzYt2pIXlrU/4jOJAL/5LlL7k
	 2RjPYSPbwBjp03xuqhk0ESSuVBSlBXnBjjv6W3OmDdKGktUy7wG8nLvAjPPXudxNZy
	 l5PlV/ER1xTgZrkTyNbtv90TOViWylrDwwh3SoM6PFGPOdCfRHIEm8oGXt4QoHfSql
	 25XSyoKO/Tr4rzoSEXHeJwj8E8dkQcx5zE4/uuqxtW9puOMoNSPocrEGgcB3rOC3Jp
	 MUCfZZKIjOFgTqZnnLY3+VBUdAhsrVsBfKcPzy9clo2z4xIrbh8tRif2Q5YXe/3eSz
	 z5EnyPqMmkpgg==
Date: Thu, 28 Aug 2025 16:15:03 +0100
From: Simon Horman <horms@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MARVELL OCTEONTX2 RVU ADMIN FUNCTION DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] octeontx2-af: Remove redundant ternary operators
Message-ID: <20250828151503.GP10519@horms.kernel.org>
References: <20250827121552.497268-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827121552.497268-1-liaoyuanhong@vivo.com>

On Wed, Aug 27, 2025 at 08:15:52PM +0800, Liao Yuanhong wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:

  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.

  Conversely, spelling and grammar fixes are not discouraged.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
--
pw-bot: cr


