Return-Path: <netdev+bounces-190350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB4AB6689
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01DD4A5497
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26CA221547;
	Wed, 14 May 2025 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt+h7VEH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D221A428;
	Wed, 14 May 2025 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212826; cv=none; b=QPAnmvw0LGHz3Z4JMfr0eMtFgqEcm3qahkSFUDkWNgjbMcsqZe2w38Qn5clt5RwjNg6cVoFBVbdC9wmniU0Z16IaeUXkIeJOC9zZsbiQ02lnh53IBWqwLcL+X1faj8254HdsorLrvpRvgD2SHUp969529EkG/Ey3yj8Sc9895RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212826; c=relaxed/simple;
	bh=jphH8oNDnfTOFAMSK14ojGHuFyDi41SV2joIAPM1BkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrqf7t/lkVqD100N+He2YG+lblgILlFfhIz1jEz2kw6NPbPclzqUbjOdB+od2KMlYDLbwp7zskXwiWAJdI204qTddvma35HTBCfG0sYTfbYfaCD9DWNh8T6Q1OWf7WzYOeY/ggWMmWwsk34aG92ykV03IGZF8Oqk4u0fK6lbB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt+h7VEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16E9C4CEE9;
	Wed, 14 May 2025 08:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747212826;
	bh=jphH8oNDnfTOFAMSK14ojGHuFyDi41SV2joIAPM1BkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rt+h7VEHFJdQPrI6Kf86AYYBjHqfox+C9NRxYFga9cDEX1gOozmPpXGIYClSmPmxj
	 9o5lDQrBePdtCiacbDumjgZlzgKT8hPL8lti1jg3QaSTcmR3RblIng8Ky2boJtfQcM
	 e+c3GnI0jDmAkVnJhFJSOoknfGFEtU/haZK0duUDRBULcUFsVGBQu/B9HfiW3E2Zs5
	 7eM87gWvfq122VhNzWBhd6iy8II2LDzOBiWs44Hm4MdoqzscpSHuRV1KmC+J4JJRJt
	 8eBKj0XcOXACyDpljurHriQQEYyEapLi9TiJTbywtdoFkoYlC6CoHAjpMbIx7+lfGi
	 xLHbi1ajkoLhw==
Date: Wed, 14 May 2025 09:53:41 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net] octeontx2-pf: Fix ethtool support for SDP representors
Message-ID: <20250514085341.GD3339421@horms.kernel.org>
References: <20250512062901.629584-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512062901.629584-1-hkelam@marvell.com>

On Mon, May 12, 2025 at 11:59:01AM +0530, Hariprasad Kelam wrote:
> The hardware supports multiple MAC types, including RPM, SDP, and LBK.
> However, features such as link settings and pause frames are only available
> on RPM MAC, and not supported on SDP or LBK.
> 
> This patch updates the ethtool operations logic accordingly to reflect
> this behavior.
> 
> Fixes: 2f7f33a09516 ("octeontx2-pf: Add representors for sdp MAC")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

