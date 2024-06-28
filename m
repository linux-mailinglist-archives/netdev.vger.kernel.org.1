Return-Path: <netdev+bounces-107682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC5591BEC7
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07E31C20DA3
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E961586F5;
	Fri, 28 Jun 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym4Idk9Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827FE13E029
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578492; cv=none; b=FJW2ZtHAOmEQm+5O6uz8j5RWklJAm4bx4lTp5dyYRkfkQtG5B85EFxDbevZSXPeXutVYddspjteXQ+l2XKL6UpmTveapBUMgwLhHQn75O8DA59mF0TBC6zu9hKlZinx7KKxKXJ6PBpsv81B6w57pdLU2PQaBAyhg5Sbze3P5kJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578492; c=relaxed/simple;
	bh=Q3suI3/uSoSrj6ynfxHKkNKN26AZN/vpAs3rVKR4cMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z84pTA3szR8EFiX/wxWJC/JmzNtspNEScq8Yexk1AqZjJKyBzp4LDT9L73XzBbIGABi2B6+pYGGti/x+2M5rJMxc8Iu56sjRzwsngaM69wP8zy22WXYru6IuOjhfT2gG9peYsD90lGJDP/rf2TcsJp0z1VsFK8WN2TeJ6olRO9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym4Idk9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6C5C116B1;
	Fri, 28 Jun 2024 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719578492;
	bh=Q3suI3/uSoSrj6ynfxHKkNKN26AZN/vpAs3rVKR4cMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ym4Idk9Y1MgnjWmeTlzbm4DaUbXbQvF5R/n4DnJc0rGYa+JIiOrigb5i9Z/sBp5Qj
	 1mzNSHo84/D2BHY7TbhQDFvtJnzQpkwpGW5WoDH3MxurrE0XnqVLz6pcFBE0UohPBm
	 xrqNYkf1Ad8XzCEXcOES20Q+JCnV2NvliMTeOeagUz7K6byQK7etX55kMCMzVI8YZx
	 oo8D5nbb5UrZ9FLHG8wdddMUMhz/yeHLcqaL2cX3+rdFPcljw+iUa1GSMxdzZcHcTv
	 kAI//e3iszcWurbZRHfCu3y+p1/nGQUGFH5CRWToB1n8UdSNcrCWq7kHFIiAdG5a/6
	 zbHkeWsIlwZww==
Date: Fri, 28 Jun 2024 13:41:28 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next 4/6] ice: remove unused recipe bookkeeping data
Message-ID: <20240628124128.GC783093@kernel.org>
References: <20240618141157.1881093-1-marcin.szycik@linux.intel.com>
 <20240618141157.1881093-5-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618141157.1881093-5-marcin.szycik@linux.intel.com>

On Tue, Jun 18, 2024 at 04:11:55PM +0200, Marcin Szycik wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Remove root_buf from recipe struct. Its only usage was in ice_find_recp(),
> where if recipe had an inverse action, it was skipped, but actually the
> driver never adds inverse actions, so effectively it was pointless.
> 
> Without root_buf, the recipe data element in ice_add_sw_recipe() does
> not need to be persistent and can also be automatically deallocated with
> __free, which nicely simplifies unroll.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


