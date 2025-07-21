Return-Path: <netdev+bounces-208635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1006DB0C763
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AEB3ACE1D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBF2D9ED7;
	Mon, 21 Jul 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMXW3vAZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902842D63F9
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111205; cv=none; b=gtQk4HaKwVxFYIO4/E7kkoVJjMxj2eijbyqwLOAuHdYF7XuyYW9eynIXkfA0nf6VTVNS13jQWMjFzeN2NxKmVvSjcVvhOK9ae7EjK5+oKI4H5XrmVirqYf71dzrLau8orpcBlTXgK023dAVAzuE1TVdVplWz1/y/aqxVguTZrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111205; c=relaxed/simple;
	bh=ZoWlpKeLbHg/s/cvBebvxdga2oGtYKkylxePT3bGoi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ita4ylEVCgb2NihAbs510ob4lmYCpwNaHAdjCpIVbaTJmJXHYkSAl/ysxGmDgiLfazQXgUt0xnJhox/f/rQviDx44nEqknGKyYEQ+2Dts8DAc4ynBb6osTTVTHjZLdYmyswsgSG5dgbBEAhVwKE/XbbCo4yKDjPfN4GwFOORN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMXW3vAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFC1C4CEED;
	Mon, 21 Jul 2025 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753111205;
	bh=ZoWlpKeLbHg/s/cvBebvxdga2oGtYKkylxePT3bGoi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMXW3vAZZTWFe3/zVWcPxs67VrfrFG6SqkN7xaJcI4k+TlZEhA1ZesnekejeLJmta
	 /2lzpVZE2vOEEEmsefUoFpFd6bBOSa8g2RgU2I/7qjLfa5ah0q587kdJWoD/UJyeD3
	 i37/Ho4OrO1YvwX6EL2piaXpa2eki/vz4Cm8JTy9HVGCkygAjA99BKbUGFXLfRbxbX
	 jI2Qbf0Mhc7K/D31dXkLTTOtApHsBb22UvPqhePOHUPv69Eyl1ddixir4X4hJk5j74
	 qmFMQsBqKrXWe5b5pUC1GEdWm4iYh9DJ6y+yqKwQnXchYCV38/7XtD4mI4R7WKLQyi
	 6TrnixQWZpDyg==
Date: Mon, 21 Jul 2025 16:20:01 +0100
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v2] netdevsim: add couple of fw_update_flash_*
 debugfs knobs
Message-ID: <20250721152001.GD2459@horms.kernel.org>
References: <20250720212734.25605-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720212734.25605-1-jiri@resnulli.us>

On Sun, Jul 20, 2025 at 11:27:34PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Netdevsim emulates firmware update and it takes 5 seconds to complete.
> For some usecases, this is too long and unnecessary. Allow user to
> configure the time by exposing debugfs knobs to set flash size, chunk
> size and chunk time.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - added sanitiazation of the tunables before using them

Thanks for the update.
This version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


