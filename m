Return-Path: <netdev+bounces-80481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D50387F0BE
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7BEEB22D4C
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 20:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A857326;
	Mon, 18 Mar 2024 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kORWP9pQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F7059B5B
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792143; cv=none; b=eyfz6F8RCsYttpm68cpkyBuu2j29Hy9WbQWBV3i0wGCbzHQRSKD5TIIEvfwWZkyXO/xyjaUQ/V/zQ90nSRaueEdOtjJNYWtxM03ptNcJP0FsVYN6XHQaGbtfvKdb+nbC+BrklrMIS0j+G429F5jcJ752Kk0BiG+PS4MXoWriiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792143; c=relaxed/simple;
	bh=4M30qJs3MhfwH6o1pNlm9jq/i1wEFxv2FMm/CPETW/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz7ll966g4rJiUdFIk72KaCfBRwPgYA+JKZIC/dOn1qIIrmM2mw1KO/ox9ulTs8th2ZIFVoZI/g44BQQWiSwVaR5yOXMSalNTr4Vkh58qsH8CTvt5AFLopVLi1g5nIxWQTnYmOYpFb8i5EE5nnD4xCXvyPbiCFzjnzIJoahAdB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kORWP9pQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEC5C43390;
	Mon, 18 Mar 2024 20:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710792142;
	bh=4M30qJs3MhfwH6o1pNlm9jq/i1wEFxv2FMm/CPETW/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kORWP9pQFM9AzKD5QcuSi8LIAmHK/Tr0ixrLcuhvlOiIgnPM/VTnimS8udP1Ec5qp
	 +HCa/Lyi/cSr4yQb3I2WsHxPtpt4CoGXOQ5p2BpvB+4amJy87ADb+x6O/YD+mvCnv4
	 oYrs0epOAYLhBhuh0cG3eBBfgEt9ASB4KV4BYqTXeFSM37hooYFvis2jNZwFPQJsfJ
	 2yNzVCAob5xofUoFcoBrgaDhaX07vw+1IocZe5zc+GRTAxFSY/Nr+76Unoha8R783k
	 3SZGawFEEgdF/Je2xJ0rBb1vpp4w7bOniPxUYUTbU9te1wfx2wcG1mTHzQahDLDnh6
	 xHZAGszKndZbg==
Date: Mon, 18 Mar 2024 20:02:18 +0000
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, kuba@kernel.org, jiri@resnulli.us,
	przemyslaw.kitszel@intel.com, andrew@lunn.ch, victor.raj@intel.com,
	michal.wilczynski@intel.com, lukasz.czapnik@intel.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 1/6] devlink: extend
 devlink_param *set pointer
Message-ID: <20240318200218.GB185808@kernel.org>
References: <20240308113919.11787-1-mateusz.polchlopek@intel.com>
 <20240308113919.11787-2-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308113919.11787-2-mateusz.polchlopek@intel.com>

On Fri, Mar 08, 2024 at 06:39:14AM -0500, Mateusz Polchlopek wrote:
> Extend devlink_param *set function pointer to take extack as a param.
> Sometimes it is needed to pass information to the end user from set
> function. It is more proper to use for that netlink instead of passing
> message to dmesg.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Hi Mateusz,

FWIIW, I think there are several (new?) users of this callback
present in net-next now which will also need to be updated.

