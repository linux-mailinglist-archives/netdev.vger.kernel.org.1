Return-Path: <netdev+bounces-49718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 990147F3321
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CDD282E2E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C637A59169;
	Tue, 21 Nov 2023 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igKOHqsV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791B56747
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 16:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60204C433C7;
	Tue, 21 Nov 2023 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700582746;
	bh=16pr1MX8oVpM3y0+o4vpm7KYAnFpcmdKABXSydPOssY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igKOHqsVCA1GyGQqVC4TqM6REuqtQa9mpNmfkcs/2gAeqIcH2rePn4FaAu3D3oWZb
	 kNxqEDjwHadpZslkMen/vPhI8RhbgB6ofxqGuWHeDREw6ezfdKen49JPyN1ZLf8xsx
	 AyVpGhrCLG1trGjsY7Xy5BsBNqXTlMR6xLatVwSR2aWXssU1IWbjPNVlKOtmc5Yt2i
	 rJgMNa1qyK3pEqoH0V3XOV20nJDRp2z1TEvSgOhNpS+XBHSpkO8qgblFpQxjiblPv7
	 UCVw3M9q7s4/w7d0ZibvRkmOyxDIxsw0DUAk+sf4J59XP8oiHxbnn48pjtYUB8aZdE
	 EAXB3m2EjvYpA==
Date: Tue, 21 Nov 2023 16:05:42 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Nov 21st
Message-ID: <20231121160542.GA1136838@kernel.org>
References: <20231120082805.35527339@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120082805.35527339@kernel.org>

On Mon, Nov 20, 2023 at 08:28:05AM -0800, Jakub Kicinski wrote:
> Hi,
> 
> The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).
> 
> So far the only agenda item is a minor update on CI,
> please send other topics!

Hi Jakub, all,

I would like to ask about the preferred mechanism for drivers
to dump state information from firmware to user-space.

I recall that at least for the NFP driver this was implemented
using ethtool -w/-W. But that was some time ago and I'd like
to understand if that is still the preferred method.

