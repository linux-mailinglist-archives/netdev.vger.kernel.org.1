Return-Path: <netdev+bounces-216298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E9CB32EAE
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2509A446794
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD302260586;
	Sun, 24 Aug 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK+OVF4g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2625A2BB;
	Sun, 24 Aug 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027219; cv=none; b=d+a/2VuWJplY3PLerM6sAQjZpOnHxGmAgqwrBvVCItw6ciOQSLn8BPouZC3iYIROFSLbEUCbu40W7PVymsG9NaI2WMc4e1sVh4ZLI6vobQ/k/gBPERbw3c1WYrecsSS07lSeHFICeRvuzQUIJrQ7VGNu8uBLOrBaLSAMk+SOJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027219; c=relaxed/simple;
	bh=WaSgZUq+epVHd+XOSY4cRjhXqIGdC2DF15B/HTqUaPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdOi8+8oy1jsgHUisN0s23bTbWjGEkr8CJpYmdkwUTR9fDp094y8FsRsgkFBxIcO+to7BDIoqlgLXO9oe/Z+T8tkz42q8YwdtPNRo5ghK1tyhwvpeVKdE9Xc/CiFSsEMzjbJrU3MGOLZ623jDXw4vVgk1upFM4g/Dj7K8+dcJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK+OVF4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB27C4CEEB;
	Sun, 24 Aug 2025 09:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756027218;
	bh=WaSgZUq+epVHd+XOSY4cRjhXqIGdC2DF15B/HTqUaPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BK+OVF4glgIDv3gXlluxs5Zyg7N2lpSXPy9nlIYNvx3vZy8L9GIaOVBOzFZZRvrGG
	 C0hqtWILT8yjCQVGz4IluNEOPOmTc5cFUoa8uI3DfCHG8vWRsWvEpfbNoKdH4DXbSV
	 EhRoT3nwMagWk3OcNfi/SXK2MtszMpJgvosrPK+kIrRemdv2FOFw8vkwj+LbaXWT+U
	 +TULGREI8erBJsm1B4sTaenO/9TfKN/bW964+ZEaSJiiCY3qAiGUIb8bQwoEHKihRZ
	 f4m9Z3rIYldX1CWFl0+azL3s+31Ql/cqsucRGoUCsjUJDZJeksM9GpbBQjdHy6ovkV
	 f0Pegv8ehNbSQ==
Date: Sun, 24 Aug 2025 11:20:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/3] dt-bindings: net: dsa: yt921x: Add
 Motorcomm YT921x switch support
Message-ID: <20250824-jolly-amaranth-panther-97a835@kuoka>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250824005116.2434998-2-mmyangfl@gmail.com>

On Sun, Aug 24, 2025 at 08:51:09AM +0800, David Yang wrote:
> The Motorcomm YT921x series is a family of Ethernet switches with up to
> 8 internal GbE PHYs and up to 2 GMACs.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

*If a tag was not added on purpose, please state why* and what changed.
</form letter>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


