Return-Path: <netdev+bounces-183458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902FFA90BA8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08ECD5A0559
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A263219307;
	Wed, 16 Apr 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPSinJp/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8110E9;
	Wed, 16 Apr 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829543; cv=none; b=rYVXjefX08Ndg7aC4xgl2NMEOzwtYhk5cqlGXR+/0jcMF4xiag8lDUlbFDUswiueTZjHPPCYXBVL8Qw8MWCkkx1E9hp32QHKiuESh4V47f5tDKXBLNxpWKlYsgyF3zE87I0uCXZSn/CTonQz7hE41A35ug6XYSW8xyzihI+w73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829543; c=relaxed/simple;
	bh=KGqNl821ddgSZBVNCHUvO7Z4iG/39cSW0Xl1OKTIdho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjxQIq7qfBBiGFhOQeOSgllBCR/GIrZPSViWTTjuR+IVDnhRpISx+MAZaLxJu21BcPRqZ8CeR7j1mQkb55pkFgc9aTSop8OwAWt50PFVq9W5te+HW4eBUR8BnVXm9b7BCrDVyO6n/US6pw82p/iqBSAcaTUePmRtjYDcmLWMzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPSinJp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5057C4CEE2;
	Wed, 16 Apr 2025 18:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744829542;
	bh=KGqNl821ddgSZBVNCHUvO7Z4iG/39cSW0Xl1OKTIdho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPSinJp/9vVOm3yPtC+YEIrTbgss6RY4MKmtPU4zOKsvXn6RLTqWb4UuA5lBIt4KJ
	 tkgxRo67TAXNNaFm+H21qQpvnfLVXxrFx/CY0mwKg2OQrECdrwwd3/iDctQujLn1vy
	 xUGfUIxZOYPuwkg5u4OaCDWh9iMNYqvpQ8HtVIx/9IxlTT8fIxZjg9hgNQUfpPJrNC
	 gUya3ffs/Jwb9GLBMgmp7D8X4G1RpCr+BPUPn8cWTegn7k/PoLQlsvKQiF34S5+ap4
	 kZLsvMV2ic6K1v3yth9e2rrQOCmcarQ1wE2cTH8MG+gZJ3yZ6HjfplO3c4jqt94xEY
	 78bRgI6qUsP9w==
Date: Wed, 16 Apr 2025 19:52:18 +0100
From: Simon Horman <horms@kernel.org>
To: zhoubowen <zhoubowen@kylinsec.com.cn>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] amd-xgbe: Add device IDs for Hygon 10Gb ethernet
 controller
Message-ID: <20250416185218.GY395307@horms.kernel.org>
References: <20250415132006.11268-1-zhoubowen@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415132006.11268-1-zhoubowen@kylinsec.com.cn>

On Tue, Apr 15, 2025 at 09:20:06PM +0800, zhoubowen wrote:
> Add device IDs for Hygon 10Gb Ethernet controller.

Am I correct in assuming that with this change in place these devices
function correctly with this driver without further modification to it?

> Signed-off-by: zhoubowen <zhoubowen@kylinsec.com.cn>

Please consider adding a space between your first and family name,
and capitalising each name in the Signed-off-by and From of
the patch. e.g. Zhou Bowen

