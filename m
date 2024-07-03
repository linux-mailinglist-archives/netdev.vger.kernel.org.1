Return-Path: <netdev+bounces-108987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295FC9266FF
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A921F2330A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C971836EC;
	Wed,  3 Jul 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evkFV+I7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D71822FB
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027367; cv=none; b=VAjSevVG2NkYtH/77CwnnFOwAY11r7F+jZZLEA2F/NImgxBVCywsO5xD5Dira2I0qyMBRFubjSWVl43ZJyfO6fDEkT+zIT/zev3NgmO53SHKqSCrXBQHc5INyFgsA9xSE14E11vbcoZPnwp6AdhMX+uawnxycujXgsdaE9MMSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027367; c=relaxed/simple;
	bh=baXKJdkCT9UM2CmgsOZQp1G4WvQyPOBd/uM2F+q0fbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sp3GvKlvVzKT/DcrnjXmiAl3IRXngM4pJd1dKBzvn4VZ4z8uvdyk5oqbtbzDeT+ZSt4D/3NT3ltAmZqmMq6wuaHqZMLlevTspebJjMtVpdtrTMXxEKKsQWsPM7aERu6+MDWRVkySDdI9U9GDH4TmTmE5nBMsXZDboer1YDzjBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evkFV+I7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E360AC2BD10;
	Wed,  3 Jul 2024 17:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720027367;
	bh=baXKJdkCT9UM2CmgsOZQp1G4WvQyPOBd/uM2F+q0fbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evkFV+I7NYa3wWnOAcV2oHDTkTTtLIVbce8LJkob+jkv0votp2d+sqz6H6x8j6ZvA
	 nZmImLXnxX3jsQBwf/4riu9urh5slpKk5XqbGYcWxcVQgkI5cZPJZ86rnTOqe9SVgr
	 aKEpWxDEeZKAc5AcMx5pHp2OqogFWAUBZO5XGQWVQcjRH1Jj1dFGCOepsiuNCrKHf3
	 MawPj/UiEBcU8I8Vk2Ytd+o00H87tGLnJeuGsc4R60skj02mx3cGxVF9sRuz8RumDq
	 4QdY7pHSQ5To4dvdDAqVwU3WCoBg5SiDa8RF49F8xL2MfFX0VLKkNUp9Zy7vomIbLt
	 8oxzktUr1ntSg==
Date: Wed, 3 Jul 2024 18:22:43 +0100
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH iwl-next] net: intel: Remove MODULE_AUTHORs
Message-ID: <20240703172243.GI598357@kernel.org>
References: <20240702213847.2607508-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702213847.2607508-1-anthony.l.nguyen@intel.com>

On Tue, Jul 02, 2024 at 02:38:46PM -0700, Tony Nguyen wrote:
> We are moving away from the Sourceforge email address. Rather than
> removing or updating the email for the affected entries, remove the
> MODULE_AUTHOR altogether as its usage is incorrect [1].
> 
> Link: https://lore.kernel.org/netdev/20200626115236.7f36d379@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/ [1]
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com> # libeth, libie
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


