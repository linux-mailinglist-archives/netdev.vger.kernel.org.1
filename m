Return-Path: <netdev+bounces-228712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE47EBD2ECF
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8BD1885331
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB56626E6E6;
	Mon, 13 Oct 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpf/i9CY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216C26CE2C;
	Mon, 13 Oct 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357486; cv=none; b=ac1r6LKbJQeTUQqHLNEsdDBtWuzT9tUeD1+PnfXpfDOmVdiHIafuC3igseYmLhLTEaZkaDENsk/rbSqjN6TdDHkCqel8TOo3Fa09LXwLXbILP49XxJuMYz9fURpywlW5AK1NSGTeDo4Jm175O6Ml3touHrJ3KSk7CeFFlpbcQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357486; c=relaxed/simple;
	bh=FHPbcE/kJT0CJg69NFhkZRj6oDXaJKFMg5/ZC3/o6t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD5dgGs4RcFQUqxqWuRXRq6tuYUwQnqeG/hOAY1313sKnnJY8d12590XQUFY/y43P+0VSyFAKiRuI7cMfG5dVak/CLoT1/cGv/92blnC6hK7NFTKIHFiGQPQWQ54RkBettL2ACTGOSwoL7fnxVfecDaDTAl+APp5y7MlyxSfk3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpf/i9CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553DDC4CEE7;
	Mon, 13 Oct 2025 12:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357486;
	bh=FHPbcE/kJT0CJg69NFhkZRj6oDXaJKFMg5/ZC3/o6t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpf/i9CYf1aXgXRqA2LOl1jOtLRPUKAj25e2BlpQn4bbNXH53n2wFayYZHGeOqVjP
	 onPRWP++15+eF54fABbsyIzx9Q7zW+nMpZV6GAFaAxo3rA9O0WjTGwsa+YEfXPf0TX
	 ggJ4Z0YMM7SGTpzREi9oEd98wyEEAlKm9V0RmBpY0WsGakpBiq9iJEw2msIkrxRN3e
	 wcuAKbWpL+T8sSg2zdcsZ4Fi0s5AwmS4csusD33QSQamFiN+x5uPgkm6FDlJrBI+0X
	 hO2CURZKdmGBj8J4Zt4Az6a2zWy00VdWcn1pjp2Qhpx7GNkkPF6XHsy7ojjZbri4Nj
	 ML9mwQDc0VCYA==
Date: Mon, 13 Oct 2025 13:11:22 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: idosch@nvidia.com, razor@blackwall.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: bridge: correct debug message function
 name in br_fill_ifinfo
Message-ID: <aOzsaqMGpVL5HnZq@horms.kernel.org>
References: <20251013100121.755899-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013100121.755899-1-alok.a.tiwari@oracle.com>

On Mon, Oct 13, 2025 at 03:01:16AM -0700, Alok Tiwari wrote:
> The debug message in br_fill_ifinfo() incorrectly refers to br_fill_info
> instead of the actual function name. Update it for clarity in debugging
> output.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>


