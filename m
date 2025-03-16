Return-Path: <netdev+bounces-175118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC9A635C3
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 14:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4320B3AAC17
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 13:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56B21EA91;
	Sun, 16 Mar 2025 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpiC0yMG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9FBC2E0
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742131059; cv=none; b=ZtThSSK043NWtHbxCNs3QV8XRrRKp9Ldnb+nd7pdNVFLTmFO3P8DA6CdN4bpkF4BHWjvojA5qeyM+EgSeySR6cYGKF8rGX/q3bzm/A3ScGjMA19En7mD9KatF6ZQ2Fd93eVYjtVGcXCvTFX42sYkrVrpnp27rmJ/eGQeu3Z+4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742131059; c=relaxed/simple;
	bh=PKUUgXA9OA5+r+vpNDDB5w3kgZ3XV3+4c34+grp8lfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA1LN4dqfqh1AAkX7bvnY8oP+7xfSaAGXL9345WE+/Zro4R8DP65XNjLubP0wTLkC/VQ1OvKKndWZhmJRa34PB6rml9xOGKwDyy/jJAKzXkBItbLZEhRZZXijRA7HZHPOm7QTFr2mUUbYw8z3yfYqAoNqzIblcu6DlhyRXPhxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpiC0yMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB08C4CEDD;
	Sun, 16 Mar 2025 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742131059;
	bh=PKUUgXA9OA5+r+vpNDDB5w3kgZ3XV3+4c34+grp8lfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpiC0yMGMsTCSmd72STalpBUZQTtZgMI/XBvQsksnu9dDRsSIp72f+t6f1c+7ttdT
	 JizGud6ED5v/FfvWaBBzDm/mOcpeX9d5/RODAaKD8FZAkmUdGMaShewRJgkgyT5x8T
	 Vdorhik0d8SrIxAzxM48lvnMX3bUOHjVXPHkx9iO3buMQ1jwW7kliGTALfnAQWaF6G
	 9LicpKyAPV9uI323RllTVOr2wO46eY3WhmF0Gsq3DLAHQtX0YEUJE1Z6Oj28RX3usb
	 Pq6gTHVLZhMMO2iK2daApQ8Kx7GxcQwcUWfxDNnNmafcxVep/twi8YcH3W1msSZkf6
	 NKJQoTUp2eN6A==
Date: Sun, 16 Mar 2025 13:17:34 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: move PHY package MMD access
 function declarations from phy.h to phylib.h
Message-ID: <20250316131734.GZ4159220@kernel.org>
References: <b624fcb7-b493-461a-a0b5-9ca7e9d767bc@gmail.com>
 <406c8a20-b62e-4ee3-b174-b566724a0876@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406c8a20-b62e-4ee3-b174-b566724a0876@gmail.com>

On Sun, Mar 09, 2025 at 09:04:14PM +0100, Heiner Kallweit wrote:
> These functions are used by PHY drivers only, therefore move their
> declaration to phylib.h.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


