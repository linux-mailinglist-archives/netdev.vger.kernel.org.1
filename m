Return-Path: <netdev+bounces-149750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6A79E72AF
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D6E28725D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D82207E05;
	Fri,  6 Dec 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFJYQ/Wj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765F207658;
	Fri,  6 Dec 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497912; cv=none; b=ul6dBQ3eWNy07Vdo5njyEtqkVL2DX7llxe2gPOpe8Bu1yZVBSVeHUNQ2cqp+DBqXHxOlbLqRfuwGtnGtyq3K+uVK6VIKpfH5uBM8x+WCDnUGBqLvie7jvcjWvjFuxZQHMtFkDdzGK9ZtT4fZRQPy8mwro5WaIkpc31XQEtCTBlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497912; c=relaxed/simple;
	bh=rLWDrmR3zcc9vc638sdeGxk8lA7epp/bmqbSnvfZP+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9bsNkoVfQS8pS2c2Pmxb1d29MK6JcFIDTiNyzO71xpEhWwB0yBbBsTRa4jxrX25PGFnx2VmAjYuR1aKFnne5GQ452OoaI1lPKaRhPrbICvxeqAdgbEF4JJyNLyJ+BjQh2+YbyPR/ErzojJqFv/p9VpHN62A5GwnSSrj9rShPXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFJYQ/Wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E9EC4CED1;
	Fri,  6 Dec 2024 15:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733497912;
	bh=rLWDrmR3zcc9vc638sdeGxk8lA7epp/bmqbSnvfZP+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iFJYQ/WjdZDkPHG+AIBFmZL3Y+5Bb9IjO3j6XUrLY2weCp/01Np/t173fOVunnKh5
	 PVtjtXSamZQz773ei78wwuR9B2U12VlF979jtUA7IHuCOyoekMxFy6Fgm3HMEgHJDI
	 oZ2coAFV+6RprlWGhOQZoTGge+NiCwkExJhcwltryRAeBedP38xCuOpDayOPsg/Z4E
	 i8tNiFBTHBR/zkDI9ATYd1JPYZ5ej1wlLgPGIrl0WCulpfOpMrpnMgtdUre8ZS88bO
	 zcJagLiUmh7Bu//vzMmXG3hMYPUqGxIzk/MBVH+JN4LmZNjUHw3UntKKCZByHJ7Jvj
	 fkz4EF8sWxC6g==
Date: Fri, 6 Dec 2024 15:11:48 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] netconsole: selftest: Delete all userdata
 keys
Message-ID: <20241206151148.GX2581@kernel.org>
References: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
 <20241204-netcons_overflow_test-v1-3-a85a8d0ace21@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-netcons_overflow_test-v1-3-a85a8d0ace21@debian.org>

On Wed, Dec 04, 2024 at 08:40:44AM -0800, Breno Leitao wrote:
> Modify the cleanup function to remove all userdata keys created during the
> test, instead of just deleting a single predefined key. This ensures a
> more thorough cleanup of temporary resources.
> 
> Move the KEY_PATH variable definition inside the set_user_data function
> to reduce global variables and improve encapsulation. The KEY_PATH
> variable is now dynamically created when setting user data.
> 
> This change has no effect on the current test, while improving an
> upcoming test that would create several userdata entries.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


