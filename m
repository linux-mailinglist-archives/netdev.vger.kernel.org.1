Return-Path: <netdev+bounces-99807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23FC8D68E1
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAF42884C0
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AD017CA03;
	Fri, 31 May 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLK6VLBJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307917D37D
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179489; cv=none; b=H1uXsRbUmlpk98wJjhioXUw6BGwLTVMUcRcnb4QJXMmJC7GwWs87er7FQEEqeqh51TbSCDXEqKoBoDNEJI67x3bEjzevUUPFFokuBwa9x+9jMVRN1mLs5oY6aaG7I8YzByMLXoIHgj/9naOikGKo6tc3a25eIAvb8Au4iw3kjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179489; c=relaxed/simple;
	bh=3D91g/xeI1LRPztWrq0QkS//sgRZFGWsOXXGLaURdJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnVBPmKY27/SsSekI6t40AxksdIPVnlBW6FfFD+MWMQoyl1yg7Ii6WU69OK3B9X4PHhyJdbL9nnMyxAsSxN6WWRo33gFrOhD6nAd9Zz+3n0vCmuvf8215nzywJipbLdi6Z/eypTn5ZJnkr7bit6M3VZ9bPJMl8QAaaYRT+WtbSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLK6VLBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB895C2BD10;
	Fri, 31 May 2024 18:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179488;
	bh=3D91g/xeI1LRPztWrq0QkS//sgRZFGWsOXXGLaURdJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLK6VLBJQvRBSt5Gqat0ByORiAnfGAwj5tVTFtH/7ufg2Qs57vSm422BoMSjv/Stz
	 uLYUuvFCzOWdh+VSzUMPfW3wD/au3iAs5gBkU8wzSmygtOdvrbq+E1scV8GZGlfWuv
	 tIOEugEKycnG44vzK18lAy/ZWvLtlExrXcl3EgGwcOkRbwDhum2xecIAtLIXN8UzxQ
	 67q8sop9LvxOURRYnX8ei/wzig3g9xa+G2XJMfvxDqUunp9nLiuUQJSoCMShJn6lnd
	 rjxTmU3JXDKQsl90ubv2W+M56mOzzBn3/O744DyVnSSRodQcL13qajYUA/SqITEGNI
	 Y4MW5kH3xKrPg==
Date: Fri, 31 May 2024 19:18:03 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 13/15] ice: support subfunction devlink Tx topology
Message-ID: <20240531181803.GO491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-14-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-14-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:11AM +0200, Michal Swiatkowski wrote:
> Flow for creating Tx topology is the same as for VF port representors,
> but the devlink port is stored in different place (sf->devlink_port).
> 
> When creating VF devlink lock isn't taken, when creating subfunction it
> is. Setting Tx topology function needs to take this lock, check if it
> was taken before to not do it twice.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


