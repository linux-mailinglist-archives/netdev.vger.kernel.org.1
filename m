Return-Path: <netdev+bounces-141210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1314B9BA0DC
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9961282449
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6C215D5CE;
	Sat,  2 Nov 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfXkafPr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE5C82890;
	Sat,  2 Nov 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730559188; cv=none; b=GKVIDBWDMtJ/jV3w6kJYkv92kyoOsWjgIxIkIGkDD4Bu6ohJA3w4FU0GZ2OpNslCf4hs1WFH0bHJdMvdiTRhPmQX66ahvstqNbZeNCFzA8U6geeANHFkoPYjFiXHz3O3TvUYV9G+W8c8bFR2W6lwV6TjhfXoxs84XOqqzEyAlN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730559188; c=relaxed/simple;
	bh=KdVZx9KOewaJHKZ9U9QpZ3K3GtA8HvD2LiFPLZ4uB2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3MqpBTejh6B3rjc1I5hBWYUrGFUSjEaUmwiZPPWLTngSCkW7mjqq4plIpfvHZLfYyD/4Qi0aZ+i2fFCx+GftwSa5ih9uIKV55ii1Mrlb99gjUA9Z8p8echClQCSwUEaj0LOmMnPk/3m0pATHKU0LrLtFeaFTmzallmnf4yAR+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfXkafPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2985C4CEC3;
	Sat,  2 Nov 2024 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730559187;
	bh=KdVZx9KOewaJHKZ9U9QpZ3K3GtA8HvD2LiFPLZ4uB2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfXkafPrb+YOSs7GbRKVEqaOxcZKwpxjrGn0Fq+o5E9iFxBoeNWO5S9QEe4Drezvj
	 UH4W/0HFYVm5XDHpGrQI556dzfe7Vlc7FOHGwPTAOerrms9b/NjosEpZPvHC/XO3u1
	 B6vq3k4wNrxFBkVdvOuKyxYgFGSa+guKl9QjHYEha4ZPEas+6ycdo6Sh2BkBoS9Nbf
	 nKbmhW/aY7QWWwPW85maWQTztXSwIgQ2uQXQ2+QU9QWSvcYQdxiUEQkUbeRznNxLZP
	 PgtEaicKtEx0bfjXXnf/uh2+VMov0CxtfrJTwIRzLsgtpqNBn9TieyYq2yhxmU79Uf
	 zftvvh3FXZS0Q==
Date: Sat, 2 Nov 2024 14:52:59 +0000
From: Simon Horman <horms@kernel.org>
To: Linu Cherian <lcherian@marvell.com>
Cc: davem@davemloft.net, sgoutham@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gakula@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, jerinj@marvell.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.comi,
	jiri@resnulli.us, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 net-next 3/3] devlink: Add documenation for OcteonTx2
 AF
Message-ID: <20241102145259.GN1838431@kernel.org>
References: <20241029035739.1981839-1-lcherian@marvell.com>
 <20241029035739.1981839-4-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029035739.1981839-4-lcherian@marvell.com>

On Tue, Oct 29, 2024 at 09:27:39AM +0530, Linu Cherian wrote:
> Add documenation for the following devlink params
> - npc_mcam_high_zone_percent
> - npc_def_rule_cntr
> - nix_maxlf
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v3:
> Newly added patch

Thanks for addressing this, much appreciated.

Reviewed-by: Simon Horman <horms@kernel.org>

