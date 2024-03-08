Return-Path: <netdev+bounces-78794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F99B876822
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 17:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A1E1C20B08
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6942D04E;
	Fri,  8 Mar 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGlppqUH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE4D2C861;
	Fri,  8 Mar 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914255; cv=none; b=lpL0H1yYL9hn3pUT3DRBjGxIhE+Jye/ehFt+5HgGhEqcNpjOoOaCKjwzh69wKflR95iO9TgjBERYK7y6Pw98+u7PHbkLnT485LP9ESA5tI/t9yuYO/7iZHKd7fbeHtvdMVslEfuKNU75N57s5aTHC5XwpzA1Erln6NgOlC/cT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914255; c=relaxed/simple;
	bh=Xk3ZB3y6Ff14jQaazQDFcBYY1c2u8+8pftYCTd9DlZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfRUyUMhvSNRzjNirUlyyrGBEbYbcYKkvcUh5194t2/QL+p+AfAoM10261ZkoJgoskr+mPMNj7umyjcTB9XmbbvJJEcSvV5T7r9j32LwCStv8Z6HwBAXfeWLLFaQTA8rCql9CXJ18LMYYesDnWdQcODPzsH8Io+kBEUAPjoW8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGlppqUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55619C433F1;
	Fri,  8 Mar 2024 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914255;
	bh=Xk3ZB3y6Ff14jQaazQDFcBYY1c2u8+8pftYCTd9DlZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GGlppqUHdX68uDcTX21we2uKv0j+xBbAtWWf+HZ+ySxgD08UhigsWnlNsIFyhTtpv
	 4AOdAanOr7GKa+vuislEEEG0na6Nj8kg2zKSWCPUxwK3GijlgYTJwt2GYIeCI31bxx
	 2eUTzPaUcIMFJWzievi0VtuKzbCD9XuuJvqgkfSSm7awaS3Fn5HZHMq3rlqnzMPRyY
	 bmsk0ong13OvzT7igQ0n9rR+5pofL7vaweusuCDMXS78i/keY9Q2kc7uAhpHxI7eLn
	 H/G6ze+iAaJtwXPMhi3gJUYPv0BzFlnDQg+LBPdFuTNJa3QX0KNGGgTnd00W23logr
	 yGkViBSUlPm2Q==
Date: Fri, 8 Mar 2024 08:10:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tools: ynl: Fix spelling mistake "Constructred"
 -> "Constructed"
Message-ID: <20240308081053.0be8732d@kernel.org>
In-Reply-To: <20240308084458.2045266-1-colin.i.king@gmail.com>
References: <20240308084458.2045266-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 08:44:58 +0000 Colin Ian King wrote:
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>

