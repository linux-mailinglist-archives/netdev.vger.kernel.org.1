Return-Path: <netdev+bounces-191449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7ABABB837
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4373F16F834
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0670426AA93;
	Mon, 19 May 2025 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfEJgBfP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A835957
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645641; cv=none; b=ku9FVUF0wIOIUN0cF7pv30Iruga/yXPWNsMC5TQxs2l2Y423UO2MYwGmyVZL3cVlN2C5WA/ZuDp2yeqwWiqaGXnNUchT0pPNAK/L1MRERw+zLVmXWjk36J+0PoD9v2FouH9X2nMOf/qHmF+jMDeuoPOezwPJziYv0Gx+/u//LpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645641; c=relaxed/simple;
	bh=CY5hZNk7BtIXQNCriJ9WT8EywUZQlHQRfgpoWPjAgU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gda6wyrn4I68v6DAoRTvDn+RgOhFvuYGwHPP+xHAH7YxzP3XbE9Q6nYFuY4+IjFvxeqjxeDSA5uYRaqruUx5G5Wsdg0ZkdTTjiMrddIYjL+ozx8/Ab6el61QoRn77NYc3PArUnDfNKh+uNLdgAz/zQVg+kBFmZU3QFMhaeN6Gts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfEJgBfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C735C4CEE4;
	Mon, 19 May 2025 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747645641;
	bh=CY5hZNk7BtIXQNCriJ9WT8EywUZQlHQRfgpoWPjAgU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfEJgBfPqXUCSqXQLtWgDk8jplfJhbaV9iiHt0v060V3mMYHdGIHR0ImBocR2w4dU
	 O6Ma2v8DF488tlgw2vbN6aDv7SEk+kPAx9+u45Z3s8PNG+UlxHOKD8bgtxgjI21nQy
	 +I04SD5Enmx0hdnYvPuou/AeEqRqP+nxj9O7FEfo1032LMwmGH2z6V3ZIsJNpfGzrL
	 G0LD3ANQPlPFHaYEztI0PrYGq9Bcw2LnConjOW5TS+Pk7w8MqljzIwfp3qtLZX/a8w
	 rUeYUlnSGrLUdb39FJG6Rogfv/8f4Ljh8Hmn5ojw13EmpCqDonV1R4b+f2sN83h+8j
	 qqqBt32aIM5Og==
Date: Mon, 19 May 2025 10:07:18 +0100
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-next v5 3/3] ice: add ice driver PTP pin documentation
Message-ID: <20250519090718.GD365796@horms.kernel.org>
References: <20250422160149.1131069-1-arkadiusz.kubalewski@intel.com>
 <20250422160149.1131069-4-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422160149.1131069-4-arkadiusz.kubalewski@intel.com>

On Tue, Apr 22, 2025 at 06:01:49PM +0200, Arkadiusz Kubalewski wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Add a description of PTP pins support by the adapters to ice driver
> documentation.
> 
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


