Return-Path: <netdev+bounces-205312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA07AFE2C5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834751895F04
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7FF26E6F6;
	Wed,  9 Jul 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM8QQVVq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852B189905
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050220; cv=none; b=TKFpKPZ1FdTUIqoikZERTrVVEOQ9GGuIgt+uJJ0Y5n+ArIE8A7p4nJ5is85lJq1OMYaMoryMuyOV18mff5pq37wOg31nVZGX1mANLQYVRmz09/IIQ77rDe38N2eqfu+rPiP8pyDqvwDXMeKB44GYYX8dHH2eKgTg5yr/Ys6hPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050220; c=relaxed/simple;
	bh=ry1qJ5VBhcHYmCscXS7PJebLLmxPME7+jSXy1wWKxCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3J2pulTSqammBvN9PpcEpKHtqkc43b4OWxAWqoAxKF7nJTq0udpOQST7c7cutM7MYUAxsAB4OS5hWvkX8z+StWR0+1yI3oIwcor1CZ2HFP3ft4xlWNfm1S6q8TDeunYl3drC+0QBzM8Y9MkTKAGLI7+Hl84UzuqyaV10NUm1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM8QQVVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14FCC4CEF0;
	Wed,  9 Jul 2025 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050220;
	bh=ry1qJ5VBhcHYmCscXS7PJebLLmxPME7+jSXy1wWKxCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UM8QQVVqjM34A0fuCNFMeMAVAl/JgSHtwauY3pUbQ0GN16VK6jz+FNPTA8w6N1GTJ
	 NmUTqiDK2a1SJvkinj6+E/GDmDhpVGr35LQ4vzjLhmEoplew6I6B0Ax9scWSXM1WNg
	 kjfoQVY08/ya9TaakNwwyXXuBfdNchuwJ8ZUFOXIRjDZEf42m2QAiS+BllWmFIfxMM
	 RaBcPCDDYgda05TkwrqP2yRFUyCHBkJWCHyvjyxRnTk+hiwfK866OQbzFOJrqXXBQU
	 MtS2lAWiSJt+yBEISB5yTD32koIySlh73ki3OnHilHv0S2763S7FRujx9WOQ41cMK4
	 5Yx8aK9d9o6+g==
Date: Wed, 9 Jul 2025 09:36:55 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Kamal Heib <kheib@redhat.com>
Subject: Re: [PATCH net-next V6 01/13] devlink: Add 'total_vfs' generic
 device param
Message-ID: <20250709083655.GC452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-2-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-2-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:43PM -0700, Saeed Mahameed wrote:
> From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> 
> NICs are typically configured with total_vfs=0, forcing users to rely
> on external tools to enable SR-IOV (a widely used and essential feature).
> 
> Add total_vfs parameter to devlink for SR-IOV max VF configurability.
> Enables standard kernel tools to manage SR-IOV, addressing the need for
> flexible VF configuration.
> 
> Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Tested-by: Kamal Heib <kheib@redhat.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


