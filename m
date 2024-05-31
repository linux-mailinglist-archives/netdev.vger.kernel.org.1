Return-Path: <netdev+bounces-99798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDD28D68C4
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CF11C2128D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4B017C9F4;
	Fri, 31 May 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjviMxAx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A216EC13
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179291; cv=none; b=BqMC5RX2O0BblLObiLwfx4Rrdfw9bDWIyHVZApUn1ZHxsjbs6KEY0tK/kNCVCmPbYzcFZoYbT0lag64BbNXMNbLo1s8weXoEfxLilf7OIqk+iJuJjxxN6yxunZENXm+VqA/Wge1LovMcmPCQfalf32E1z5Qh9HuINXDZv2qfThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179291; c=relaxed/simple;
	bh=ZZvR5hCCeOMVzuUTYKdnIXfmM8hbHFrNxoMfE4gufUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3t9Gg6v+AmXtmCxDPEs0m7fl7MqUqUTFrWrgpbjpguB38pWbtol2VdryddSlYGWm3QrRjUUUkmncUkjYb9/9ERYkJ91VuTceFdVV1USb8Yg0ygoVycSv6nI4uZsgkf4EZSJAOvxLCMwPKocsY4NUadVUTkgU5VOtMnHvadmpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjviMxAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35411C116B1;
	Fri, 31 May 2024 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179291;
	bh=ZZvR5hCCeOMVzuUTYKdnIXfmM8hbHFrNxoMfE4gufUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjviMxAxsQffthwNIBsqlxWAFBkSC2RWapDMliPhAP8tmYy+hoCO4r9oStLM4eCzz
	 mYbQCz3DedSBlTQxqoZgrRfYTtYR7alHULtQzDQxgpKf+qoj6T1lJMpsM/sb4dseAf
	 zUwrOIJXAr5C4VP8asF5UYNZ6kDPwaoI1Zim+i+GmMnuc2Yl/cV02vxq7i3nJ1LqnW
	 ExmYuFOa9JHoOeAFU0JcTHMPEUYD8yTABmh4mSrTsYKxRakX8QhUNwLQl4CJIU2Y9/
	 x2Z5vp7jvBVU7jx8nIK4mnw8NSi2NjYDL9nsMcRUYiMYUJVB5EDTb10Sd1i6qDaM0Y
	 0jUKBXyp5hCJw==
Date: Fri, 31 May 2024 19:14:45 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 02/15] ice: export ice ndo_ops functions
Message-ID: <20240531181445.GF491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-3-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-3-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:00AM +0200, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Make some of the netdevice_ops functions visible from outside for
> another VSI type created netdev.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


