Return-Path: <netdev+bounces-217299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89417B38404
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87044362155
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A1A35082A;
	Wed, 27 Aug 2025 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOtippKz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9AA2EACEF;
	Wed, 27 Aug 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302566; cv=none; b=XuKjvNp5qR4FoqyBo6tVutmXeRdF7hefYP4VVyH26X/hLesni/c3fR/kwxk9Uvcv4cvXasBdlPmWiJfFydwIIdX3olX1eD4CatyCrloJ/TPTcR9Q5pBjjZx9EHqQGJwuYIzTqkjY4Ha0rsqconkyC3NwiTie6lG1077sbmK3KSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302566; c=relaxed/simple;
	bh=Dpt8GGfeLnVmr0M6zmnyoYGC08US4tTed/rZezkvqNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbjWyfy8yG+iOCVI6iOwN3lyXRl5jTmfG96H9CSk/F8LnCXXIMvMVXX9HLf8slfinQSf2UBKJNNahl5+FWQnCCp5eAIEJqBN+MAvYs3Lp7EtwWbs3lHypwiKbVdnaAs3HMdMBvwljXCk5pxh1k6Ux2XgtQeLVSEAtRvSe2b88Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOtippKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3273BC4CEF0;
	Wed, 27 Aug 2025 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756302565;
	bh=Dpt8GGfeLnVmr0M6zmnyoYGC08US4tTed/rZezkvqNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOtippKzko2TKtCwDI35Ogr/YO2PjQWOoj13B8dT5h1/hATBhQfvwMJ08m+DKhXfn
	 cezFaKFTYtWm29o9AzkgTbr3+Kh3wVFClkJDPz3qVfSuuJ3Y8C8R7kZ4LJeIqBzIB0
	 +/9qdIedLLHPbQfeYd7biIoTgnUgYbk4uXAHbrT6AL5ZSixpxJqP0EzQXQ5YQoOWWD
	 OopFahUco65XVC+L4hmZaeYpBTao3oW2QEBorNtH8VtO3/uV68oEb68F0MYHgy4lBs
	 V/17hAgCznYPQWeAw9FByFMH9O9wLlwiK+2FoeFmKeTu2W+mIu9Bn70714b8z/jsVd
	 a5YdP4jMucoJQ==
Date: Wed, 27 Aug 2025 14:49:20 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kohei.enju@gmail.com, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2 iwl-next 2/2] igbvf: remove redundant counter
 rx_long_byte_count from ethtool statistics
Message-ID: <20250827134920.GA5652@horms.kernel.org>
References: <20250818151902.64979-4-enjuk@amazon.com>
 <20250818151902.64979-6-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818151902.64979-6-enjuk@amazon.com>

On Tue, Aug 19, 2025 at 12:18:27AM +0900, Kohei Enju wrote:
> rx_long_byte_count shows the value of the GORC (Good Octets Received
> Count) register. However, the register value is already shown as
> rx_bytes and they always show the same value.
> 
> Remove rx_long_byte_count as the Intel ethernet driver e1000e did in
> commit 0a939912cf9c ("e1000e: cleanup redundant statistics counter").
> 
> Tested on Intel Corporation I350 Gigabit Network Connection.
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


