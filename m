Return-Path: <netdev+bounces-220520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A0B46782
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1415D176738
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED1482F2;
	Sat,  6 Sep 2025 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdD/5E+m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DB17E4;
	Sat,  6 Sep 2025 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757118310; cv=none; b=PebAS4MsD8bZVXVv8IDCb3xG9cXDJauKrwa0JiOCIHepD52SV/4KhkF13hWDbQp+7LBHeVViNLSeuz7/NndHi52TM9VDrtAGhKj+Wbbtt1KSp7z3pBw6iws1BmGWZZXZvsrix++zVIaU+e7gxWQ8llpuCxIuBU6Zz3vpv5RncnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757118310; c=relaxed/simple;
	bh=yP/GDoclDLsfsIo4nhpvDpvK7+Yf36VKXuayJgr73bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxnC46whsdwRVS99m+0/U15TtT/FaZ1Ek3WJOHJ5fLnKGu1sSNmwo/2ZV9i7p4oz6TvSePF/Qa0QX5BMNYmC3iF8Q6Nkrg5FJV56AEcuvY3HY6G7dHImcYxdc09r2e0CLBvNP6Z+erT1lD8dyykCYr0iM9cS465URdW5YOLPsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdD/5E+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4650AC4CEF1;
	Sat,  6 Sep 2025 00:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757118309;
	bh=yP/GDoclDLsfsIo4nhpvDpvK7+Yf36VKXuayJgr73bQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NdD/5E+mHevSw7FzcjQiumRERkotLTiplwKjQZ1RqAR++KZmRXYyEt13ydSu+2VPQ
	 kOKKSojwkEJEgli6vwAOE3d3ch99BDSpdjR4EhjCLGsQj8TkyoSK39wAPKon6N7XOp
	 dW28BImWwKZxRIGIi/Q/dnvWxS9mxnKhDCCmbk+4uWbMbCXwWiypn0+XfTSIVUrl45
	 rRlHx+8F7HUNrs9rw4v9gEqlh5jZ/YdYFESbbS82lLVRThHAEytm5WnyzlfwBBTej6
	 i2TlLh31TCMo3IJZul+zXG4gtAcNZlUQoXAF9f4PCGld0llyt53dLeZFFaL4BwQxsm
	 kN/7VkLBdTHEw==
Date: Fri, 5 Sep 2025 17:25:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/11] tools: ynl-gen: rename TypeArrayNest to
 TypeIndexedArray
Message-ID: <20250905172508.45bbb3ef@kernel.org>
In-Reply-To: <20250904220156.1006541-7-ast@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-7-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  4 Sep 2025 22:01:30 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> As TypeArrayNest can now be used with many other sub-types
> than nest, then rename it to TypeIndexedArray, to reduce
> confusion.

You need to also find all the local comments and variables which allude
to the name.

