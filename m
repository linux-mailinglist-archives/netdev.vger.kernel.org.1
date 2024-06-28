Return-Path: <netdev+bounces-107684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4816091BED8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E824D1F242B5
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D514158853;
	Fri, 28 Jun 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdFz05vr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F8515884F
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578669; cv=none; b=bMCeRqvGvgAowpHiQ/cENR+oUath0QRnlEC9nweEu7icGAYpA7P+qBukwrmYoiRW3FK60pj/2mcupySnhhz5r/tSXjQfh8V42oI24FGKrF+PPK5vxRzELtZfA7VusDvmK0SVxMSjC5e2HzxJfn1LYlB71yIiS9gLmJv+zLbmUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578669; c=relaxed/simple;
	bh=VpWvE7L2aKZqcvK+G9gnA0RyvcenJo16xdZeTu4gR8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG1PpgcgYt6SIni0gJre1cEIwRtLrj7GyatgtZSrNjMiK61Yi7wW6A0iFauNItUG7DatMq0D2kzaUaZi9G21fAxb23AGzHiTiazh/ysq0Wd99LpQw8sYTB8S03a1Vu4FhNtotvzmPljD7ZKqkqSkJaKhtk+lI+1KmROMdpJirnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdFz05vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05520C116B1;
	Fri, 28 Jun 2024 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719578669;
	bh=VpWvE7L2aKZqcvK+G9gnA0RyvcenJo16xdZeTu4gR8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdFz05vro1Q9b8sLcUoMuIllh0LQS76ALOWG62Pl03/CUMlvohDDg4ib0iqN3dlqK
	 q3hCMsyE9jcOtY6pz6BGiYx5rxBO2qO/AHrBW76nbBmZGrsPzi4m9DiLfUE0lNoyod
	 8B4U2cNud7pkBkh91rVds4cZ7ovMqe5IMcwa+pY1J2ykxUG/bOHpNq4GVGj9cvp+i0
	 3Q+QXvGhPDetH3efR+bkQsM2qIssUNCgsveK6m6xBRXyFlajudLk3k0f5s7u4R2moE
	 uPGtvbtfYtPE/msAJaswYH5l56vc6tn2ix888hXxtV9O6qnLGoD4xJWD/qtyK32wPs
	 BRyuI0PWaZTBg==
Date: Fri, 28 Jun 2024 13:44:25 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next 6/6] ice: Remove unused members from switch API
Message-ID: <20240628124425.GE783093@kernel.org>
References: <20240618141157.1881093-1-marcin.szycik@linux.intel.com>
 <20240618141157.1881093-7-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618141157.1881093-7-marcin.szycik@linux.intel.com>

On Tue, Jun 18, 2024 at 04:11:57PM +0200, Marcin Szycik wrote:
> Remove several members of struct ice_sw_recipe and struct
> ice_prot_lkup_ext. Remove struct ice_recp_grp_entry and struct
> ice_pref_recipe_group, since they are now unused as well.
> 
> All of the deleted members were only written to and never read, so it's
> pointless to keep them.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


