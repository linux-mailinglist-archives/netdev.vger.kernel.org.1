Return-Path: <netdev+bounces-132035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 207939902F6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA46CB219E0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1559142AB5;
	Fri,  4 Oct 2024 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3+ws2tK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602918E1F
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045225; cv=none; b=siU2RHaXwLm+1wrUywfZUYzbEr+puO6oZl9bGYD53HcaZ4dLelYoYG2g3siR/fm3rMGQRbDeHBOFnigNuMS0gHOkUlGM8EdsxV23x6but0b/SSr8jsm8pUgDyeTUJQFDQePmyI1D9t/8ztdqYEL+TfXmMR55SZ5XZK4STZJLk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045225; c=relaxed/simple;
	bh=9DlAI+R0PWDvT9YhUeEPFvBb0TPq3ZflRnkFW+QULHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMto/4Dy5VH50vjFPeYvukiMsKBNj1m05euK4zYczbFPwri7BpddczSz8SQHVSAHhxKiLjHbnZ/4swDxeuG/CY9bUG6tb05P+5NhclUdp6Za0PGSKNKq5coCnECFTQZmNAKmmAj3YF7dPayMZ1x4KgE1QkDJkhqiddnbY/soqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3+ws2tK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474A2C4CEC6;
	Fri,  4 Oct 2024 12:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728045223;
	bh=9DlAI+R0PWDvT9YhUeEPFvBb0TPq3ZflRnkFW+QULHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3+ws2tK+CIEb5jWcNCzPrUtfMTxpf5JwzajlQnOS2xyt3jqrGMV16zSWUKz09jpL
	 Cs/jFrUlwzy7V2xDxCa1oJHQUyjvmrBge4Bvsuyh8WYBh3AAU7WE5BdUvSZFrXTP/C
	 cObzi2IuifcCPbYjXAkBCXl1LwpAwURZFwuPIO1c9eSqmRHeL3F0n8OzjofipOXac+
	 EOz1XpF0F4vR7TS6nYfjuXihiruu3szf0nPwhBEKBVMy+cFJCxMM+lOoMAFhyV8oTo
	 hFQU45DYWIJ8SrgbS3LUTaKfIwlI7yMMl9FVGc0c+QmEl/DXtnHHfnssm0jwN7iqj7
	 aEklM8sG89fTw==
Date: Fri, 4 Oct 2024 13:33:40 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next] ice: Add in/out PTP pin delays
Message-ID: <20241004123340.GH1310185@kernel.org>
References: <20241004064733.1362850-2-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004064733.1362850-2-karol.kolacinski@intel.com>

On Fri, Oct 04, 2024 at 08:47:13AM +0200, Karol Kolacinski wrote:
> HW can have different input/output delays for each of the pins.
> Add a field in ice_ptp_pin_desc structure to reflect that.
> 
> Implement external timestamp delay compensation.
> 
> Remove existing definitions and wrappers for periodic output propagation
> delays.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> @@ -1767,6 +1778,7 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
>  static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
>  			      int on)
>  {
> +	unsigned int gpio_pin, prop_delay;
>  	u64 clk, period, start, phase;
>  	struct ice_hw *hw = &pf->hw;
>  	unsigned int gpio_pin;

The local variable gpio_pin is now declared twice :(


