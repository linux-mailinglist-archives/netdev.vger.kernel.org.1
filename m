Return-Path: <netdev+bounces-81995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9978788C080
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548B130211F
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFB86CDAD;
	Tue, 26 Mar 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bjq6Mgyp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474376CDA0
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452015; cv=none; b=agSKGZ/I/+nqk1VSbPuTlTGmYWdOLghLkU+wOKQC7kDvllA9dxLrGs+o6ALjb2hbBtsOW0/M7NkZjfL4/M6ubHmofj1HDWEastT5waKfNPcinye9DsPrunegtjSd1w2fbUiNyZ/oGXCaFFVjw6TAWbs9CQK1fXx8cmxg7Bkkrjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452015; c=relaxed/simple;
	bh=01/BEHa9F9gCUEBCWWK/wR+sQ3S7GO2TUEPteNvdMbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBWU3qza4Bgs6VERN/iIxKnU9CCG3TdP4MIQPzKktZdeFmxCOMe114MUTVuX9rkOgUvjkYM4GQAvve1nTvDTga8aIvuW3Yp6gtwYfg3oW0YWHQDhhyEuaEk3USlzndFYxfGP11Ck0GXwA6TRZ0lB6IPCFb2C3AW0whYSvmA15ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bjq6Mgyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B73C43394;
	Tue, 26 Mar 2024 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452014;
	bh=01/BEHa9F9gCUEBCWWK/wR+sQ3S7GO2TUEPteNvdMbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bjq6Mgypitwq+GXodBGgYQK4M7Do7yHs+qtmL5GyiS2EBEJKv4gQjCaIihUF4fKuB
	 3/FVhIC2qsNQlsQ7fuX58Gdk1VaKcIVwW0w1bvPsAv51O2Be2wdwtvTD7XkHs/pPdR
	 qVyPWOdDaodH/KzRurkAPgAOzrhNlJZZCvMxeiNT81Vio4iCh6LXb34mS8mGGZ2DqJ
	 nUO27lW0j3brcFJnN7I5M7TYUcTW4hRzuvmPRla2a56hfrA+6NJ8htrIMJdAAs2CY9
	 pjlJGtNmhHYDCBKRgCXV45SdEijEpDTcez6WJDz8nSl2dyhfuZj+lEBG75hUHZUF3S
	 RgpQGvL32SM3g==
Date: Tue, 26 Mar 2024 11:20:11 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [iwl-next v1 2/3] ice: move devlink port code to a separate file
Message-ID: <20240326112011.GK403975@kernel.org>
References: <20240325213433.829161-1-michal.swiatkowski@linux.intel.com>
 <20240325213433.829161-3-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325213433.829161-3-michal.swiatkowski@linux.intel.com>

On Mon, Mar 25, 2024 at 10:34:32PM +0100, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Keep devlink related code in a separate file. More devlink port code and
> handlers will be added here for other port operations.
> 
> Remove no longer needed include of our devlink.h in ice_lib.c.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


