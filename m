Return-Path: <netdev+bounces-93443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062248BBC94
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 17:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FE81F218AD
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F623C467;
	Sat,  4 May 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW5sv/Ux"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8AF3C097;
	Sat,  4 May 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714834788; cv=none; b=kjHc3DlIHdZd4gMIaWPbBDFRbgoZWvl22BKATDWZDqI+P6p9BESvvVA9lqlAy1VL94EnpHwDOxJKkKHdwblsfKs3Drhp3lGAXGLIQqbupBqo7R8BRVPNhQrwxwed3nw3d9+OLiXIEKJaQEIUCk6SSCoMeH8dE2ZbVm4GTx8DV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714834788; c=relaxed/simple;
	bh=HHsW0IJoD6mpAsG5SH3R+eStVjuyTfImxq7iPfVAkWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSD7nHsNbDCHD9pEVgbK/D6Pcx3WgiyubxqO8t/9lNkE/Misvn6Ojnyew7vRTCJofksQ8GWKKfkPmUyeIAeItXBG1mj//TUif5yrhElRhijh2vjUV6O0tk3pZ5pJP25da8wQd3NhDf+Pcgj4EpFu98S36NfQ7F0pR2Gq9OzIooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW5sv/Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F383C072AA;
	Sat,  4 May 2024 14:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714834788;
	bh=HHsW0IJoD6mpAsG5SH3R+eStVjuyTfImxq7iPfVAkWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EW5sv/UxCSDm7MIUU4ZX9arENxb4qmjLtlIQf9HB7U/7aFRf3x4v6yb15mlURsJYo
	 WY87iUWUaE+zwsaRpPULpKY9D7n6QKsc/6/t8p8YTDDVopL491OfGm6WxEHJY7DnNl
	 lG4PXA9F6G8IWQjxVYhL30of075+CMaF3oV/Rw72auxT+PkUs78CRPXT1hz4OBUcvZ
	 t+CddtNE/FRWAEUU0PyEyfNKDDDzUA8jl/Hw/SzvqF4JBgpVX6A7n4zdO5koZb0G59
	 hugjYjzxiRNlz+Nj4SHJFIszBqkBQDQtVKKyHDH3ll3Ln1Q9GU/72BVQeo4OWFlHJY
	 f9eKQeXh/U5vg==
Date: Sat, 4 May 2024 15:59:44 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: Re: [PATCH net-next 3/3] net: qede: use return from
 qede_flow_parse_ports()
Message-ID: <20240504145944.GF2279@kernel.org>
References: <20240503105505.839342-1-ast@fiberby.net>
 <20240503105505.839342-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503105505.839342-4-ast@fiberby.net>

On Fri, May 03, 2024 at 10:55:03AM +0000, Asbjørn Sloth Tønnesen wrote:
> When calling qede_flow_parse_ports(), then the
> return code was only used for a non-zero check,
> and then -EINVAL was returned.
> 
> qede_flow_parse_ports() can currently fail with:
> * -EINVAL
> 
> This patch changes qede_flow_parse_v{4,6}_common() to
> use the actual return code from qede_flow_parse_ports(),
> so it's no longer assumed that all errors are -EINVAL.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


