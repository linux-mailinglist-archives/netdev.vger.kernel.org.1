Return-Path: <netdev+bounces-241550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8428C85AA4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B6564EB1A6
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B8326934;
	Tue, 25 Nov 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvhVu9Mj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BEF22DF99;
	Tue, 25 Nov 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083025; cv=none; b=CPOoMc1ILF71G118kIY8hbc8A89H0oT/20ioLRLOU99c2HZIl1tIrTmYmv3W1Ioy6gA8OfgZ6zsfqmGenPoomTvPFj8seTcxutsFuFc02zQrMz2aT9Z1smweCqID1UUXvgLYFH+pepI31lS5m7gPqMow9PLqnmNMkV+gjare9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083025; c=relaxed/simple;
	bh=RhmWVOiXLffJHAyEb03rsB54dnoWWSfIq0sUpCQDnio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERnsn9UgHC5jz62sPVcPKnYmcYhKNfResxOr8DK/keBapQPQkgIW+pOcfYr2nfdN40nm/O3x88OgFpNGfB+vmb9c8F9QWCF1+GLaQXeqMwa1eLIO+TRLq/J88BOzX2CLuBBi3eQRphVTNdvSJbC9HFWg+toCEEXRlq9dzvRSwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvhVu9Mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4B9C4CEF1;
	Tue, 25 Nov 2025 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764083025;
	bh=RhmWVOiXLffJHAyEb03rsB54dnoWWSfIq0sUpCQDnio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YvhVu9MjDRqlmuwu8LG4CNHqXYhwUeMiiMp4P6mJV2AIdMARH+SqPmMheePEwayMN
	 5kw4RqkaRAkMFEQ8/TiWbsWZb77TOFbsOYsHOO4BXCv7GiQgz1LhSu2K1N4TjlTB4s
	 zEZS5sjWKO/U7K3wAnm/mrpmVikZ9k2LrJOgupwrr0vckbKby3EzHDZzt1FdmdJTLO
	 28mFT0l4WMa2MRK8aTn4jW1OzBHniGqX0j2DKy2SunrCMccQsM60ISoLh1mli6ysiH
	 oQQmxFLvURJmVZmPsBCMa6HO2HFqXRh0O1GUBt5XGev5tTeYf4Vx3dMu7yin/uJxHp
	 /ZmN9A2jAxWaA==
Date: Tue, 25 Nov 2025 07:03:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Gal
 Pressman <gal@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>, Shahar
 Shitrit <shshitrit@nvidia.com>
Subject: Re: [PATCH net-next] docs: tls: Enhance TLS resync async process
 documentation
Message-ID: <20251125070343.47d9498b@kernel.org>
In-Reply-To: <1764054037-1307522-1-git-send-email-tariqt@nvidia.com>
References: <1764054037-1307522-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 09:00:37 +0200 Tariq Toukan wrote:
> Expand the tls-offload.rst documentation to provide a more detailed
> explanation of the asynchronous resync process, including the role
> of struct tls_offload_resync_async in managing resync requests on
> the kernel side.
> 
> Also, add documentation for helper functions
> tls_offload_rx_resync_async_request_start/ _end/ _cancel.

Documentation/networking/tls-offload.rst:342: ERROR: Unexpected indentation.
Documentation/networking/tls-offload.rst:344: WARNING: Block quote ends without a blank line; unexpected unindent.
-- 
pw-bot: cr

