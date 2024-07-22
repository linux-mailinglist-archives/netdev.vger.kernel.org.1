Return-Path: <netdev+bounces-112442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60866939164
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916EC1C216DE
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0A716E894;
	Mon, 22 Jul 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxhJhFkb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E116E892
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660785; cv=none; b=pcJuCAxLeWwvTHNLmUpRLHPPk/GQ2BRUiutOoCopJ0IvjWJ5v8va9laoknzzbkbSAJ+y3WAVp6g4fCSPvQ1kFV3VOH7kthIIop6dyKztKGM7eep39qD/KyyE/4vutSIBVckf0GtXvM1u2VtwFQ11HH+0fD255+PZdM7x4xXxUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660785; c=relaxed/simple;
	bh=eV6SBkcdq2vIP50+6k2wI6mdmx1QIj4OyeeqnK205Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT8wOyt9qazFPXznxb/lZfrLQ97cHLHlpH/DER6xKTzoVCqCvP4YUFWxtv6DvzWMqVbVxVD+swCAJ3cwUFOJZw2mpYHDAUwQEvyHlcR49yMWZVANzADJSpVKYurkNJpvw6Yqa2qKWKN8XwLvQ5yYjI87fiBF5RjLu6p5Myknk3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxhJhFkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4FFC116B1;
	Mon, 22 Jul 2024 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721660785;
	bh=eV6SBkcdq2vIP50+6k2wI6mdmx1QIj4OyeeqnK205Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxhJhFkbDWEMY4B2HRNKw/Y1iNBD2CWOeLtDdwyB2SX/ipGU+FQAVTO0ylQ38H7f7
	 49udyczUKLb3ZWXb6kYvGzZtn/U+WCWlzewlEIIz4kFsWmmbC+hgy/qUCWJ+0OJnhW
	 l736fmIlVpcrr+ukmA7oUPsVVi7FoX5DjGrNy4CNuqZVD6D5E4TaVqpq4eOyG4fjeT
	 6KbP4urbMh+K9tP9vbVdsq0VMjZTgBK85Cx1M4Mecfvex7mbQx7uyQ+XZERIwv0qcE
	 u1PJiy2ZpLTdNE13M1/QvOMWl4Ke7cX2JXIQkgHVZAucPA5MSlpFU0NAVazUNQDnJ+
	 Ams0BMPY4tuaA==
Date: Mon, 22 Jul 2024 16:06:21 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 04/13] ice: add parser internal helper
 functions
Message-ID: <20240722150621.GN715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-5-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-5-ahmed.zaki@intel.com>

On Wed, Jul 10, 2024 at 02:40:06PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Add the following internal helper functions:
> 
> - ice_bst_tcam_match():
>   to perform ternary match on boost TCAM.
> 
> - ice_pg_cam_match():
>   to perform parse graph key match in cam table.
> 
> - ice_pg_nm_cam_match():
>   to perform parse graph key no match in cam table.
> 
> - ice_ptype_mk_tcam_match():
>   to perform ptype markers match in tcam table.
> 
> - ice_flg_redirect():
>   to redirect parser flags to packet flags.
> 
> - ice_xlt_kb_flag_get():
>   to aggregate 64 bit packet flag into 16 bit key builder flags.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


