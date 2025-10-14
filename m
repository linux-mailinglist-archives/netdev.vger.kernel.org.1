Return-Path: <netdev+bounces-229238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2E2BD9A7C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D7684FC472
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D78314A88;
	Tue, 14 Oct 2025 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJOb/j/w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689FF3148B4
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447624; cv=none; b=WQU4v66hCBY0Zor8/9iblc6jN81Twk9JjQBeL0RiXx09FOv8a8vIsrrSaTaFUgVxNACQBnRByeWQnfGGE8MnjsHaTNM/HwuHeCT1vLpzeCfFBtHIRZzTmx3aymn9os+7Oc+bChmewZlMsJFCUV0cn7gRvidmxzNYeBVliY79tNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447624; c=relaxed/simple;
	bh=1NlxeOqeQiFxRLAP2yxqVfyQqZhyV/xS9d6HjjcCO1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2IyAMaSs9u+MU5yyMrWJ+af2fmQM4oGFcUAFeo2/7UL0m24uvfJ4BKt+MOHIHuU/itSVLOzYKxJej635ubN0/+qbIlcW8d2mtl3VlwP1SVDt4aW0vQerK1FQufZLKCvlZI7i64lRJqDKigg5zuB5MPE6Nf/OwuX4ULJ5+Z6NPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJOb/j/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AAFC4CEF1;
	Tue, 14 Oct 2025 13:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760447624;
	bh=1NlxeOqeQiFxRLAP2yxqVfyQqZhyV/xS9d6HjjcCO1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJOb/j/wohDLOyhZTQ+TEAiv4CHc1u4luqQLkmtXnx+Ro3JOVurSGihbRTnFwLBJ5
	 V82EIJSQeXZvXvEI1TalI/7AS68XnI4Y3f693KJVZGQ/zApPpQVjgipAM10wUoKrWo
	 2XiUKqUA8/fOim3Wx4PagbbWsorqFkhBu3EKvn77KJ+oqvmiv/c5Fm7t5uCrKZEPFQ
	 HshfOEniH6GTAwjvF8pHFM/EHet7lqIVzbWnBzLhER1rzW/tLfYg18b4kNUkWYv6ut
	 bsY5FqjYNyIUjg5uaJIQDCmiv+fmLj+9xNmyiMqmjoqjgRqjLquansqpmv7CE34oTP
	 suju+cv/sWZnA==
Date: Tue, 14 Oct 2025 14:13:39 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: bcmgenet: remove unused platform code
Message-ID: <aO5Mgy4VLgtQ2ErN@horms.kernel.org>
References: <108b4e64-55d4-4b4e-9a11-3c810c319d66@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <108b4e64-55d4-4b4e-9a11-3c810c319d66@gmail.com>

On Tue, Oct 14, 2025 at 08:02:47AM +0200, Heiner Kallweit wrote:
> This effectively reverts b0ba512e25d7 ("net: bcmgenet: enable driver to
> work without a device tree"). There has never been an in-tree user of
> struct bcmgenet_platform_data, all devices use OF or ACPI.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

I'm actually kind of surprised platform driver support was added as
recently as 2014. But I guess there was a reason at the time.

Reviewed-by: Simon Horman <horms@kernel.org>

