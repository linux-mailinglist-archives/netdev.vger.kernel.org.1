Return-Path: <netdev+bounces-99769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096D78D64F6
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033A71C20CB5
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6255731B;
	Fri, 31 May 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBVzZkMT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880757C8E
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167344; cv=none; b=cmTNmNNv+c9ttr4A7tgH6W1T6yle53VdmsZbmKI9n4VASowHWf5I08YpkIF9+xIlw1D9/6OiYg0SLNcejv1aXkuN8wqjL7HSR+uf82CXmfzD+BzgiY1BDm1oXTskxWz13sNpL2rTJrPDuD/frzhB9KzIixyPOGxorV5epg1sCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167344; c=relaxed/simple;
	bh=Hv2gYHqbGfnlZ96RHSeNWv1lmd20D/5nqOqdbNrMRmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixJdh+G9QX37DTiF929RfIzgk5FbEewC8PhXuXXmbBOSg8nslXKf1lLMQIOBu87OnxDis3II+NYkOLuOrfJ4sNv0+oZHVE3di2amEJ4y35vxmxoM+O0uoh/gTJFD7PnyM3niDfuRMqR+2WljW6KlAZ0X+7tm3kcHqTGx10XvQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBVzZkMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28545C116B1;
	Fri, 31 May 2024 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167344;
	bh=Hv2gYHqbGfnlZ96RHSeNWv1lmd20D/5nqOqdbNrMRmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBVzZkMTtUWtbHT7zCGF8kEf6qNAMK0uagz5pr2tiurGqbCKw+QMNg8/gokzCtuyR
	 TY6As9J7mbi/toO/A2LGwu1Yj/tCfH5yPqpJ3nzvLg5bzTFiXr+eJFS14MKWdRG+vZ
	 yNiCJoTyiFcV2mK2xPSZTOMBnQfqLEOlJq9ifirSAfzStfYl4zhTlZ9KHYDlMA/UmX
	 +U42vlPzE3vngHef3tnNRwEEL1AeP4P0lYwHE6Ki6XsWtdRoyT+rzHpkSnfYpV0xwj
	 4l2wEddmbEgLqPVZOSDe1hLccoKZMd1z1uZZMkPZLW71HLShHy0lFaM+KproD2rjBg
	 CBlSXLSXX/Zug==
Date: Fri, 31 May 2024 15:55:38 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-next v7 4/7] ixgbe: Add support for NVM handling in
 E610 device
Message-ID: <20240531145538.GL123401@kernel.org>
References: <20240527151023.3634-1-piotr.kwapulinski@intel.com>
 <20240527151023.3634-5-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527151023.3634-5-piotr.kwapulinski@intel.com>

On Mon, May 27, 2024 at 05:10:20PM +0200, Piotr Kwapulinski wrote:
> Add low level support for accessing NVM in E610 device. NVM operations are
> handled via the Admin Command Interface. Add the following NVM specific
> operations:
> - acquire, release, read
> - validate checksum
> - read shadow ram
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


