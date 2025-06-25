Return-Path: <netdev+bounces-201080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDE7AE808F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68749189AE94
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AD12BD028;
	Wed, 25 Jun 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKPlsNCe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24551DEFE7
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849655; cv=none; b=n1YcplOhIcSVl4CreSUaJELtAMCC/TbJ28GeXAwsFvGumtMGgmP9Z4vhJtt6iIMIaJc+trlaqpObbcin2lEcZirWOO/Yn6a4oESP9JLh+YvCtur+c6mB1GGJmbHjyRwGi2bR38PbX8eOns22mM9SUos1Vy77yLpiR9euzU8PCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849655; c=relaxed/simple;
	bh=t3dBBkpxnIVTzGjSP4H3e0jZppycZZawznZHvCV7yn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nyb9vcf4xNt5pz3MlASHt+MM4iRfjEw89IPV42VkQjdTHYkHeFRz4srQyr8qNnUouvt14v7v+KEBk2lDSLu1CjBu/EtTzAEFBu4ST7felK74x+uhMKNvcIae5X0X2GYk0CmH3lrZwveZOOcmZrz2tj/XP9xG347Ko0PSLR++7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKPlsNCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0EC4CEF3;
	Wed, 25 Jun 2025 11:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750849653;
	bh=t3dBBkpxnIVTzGjSP4H3e0jZppycZZawznZHvCV7yn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKPlsNCe0FZDRgiF4OrPBz8lEneSkOVlNEMm/86eTl448TS7uZhAZGTFh9X9uCDVZ
	 Lt07WEWxwipjFE5HacuSF2bqyaRRgtbrUqA/fJjQJGJBpR6dnqlt13jdaExuJl9rHf
	 CHX67iH0wH4s4B+6zetQVfuOqBvfivsfpuDVMKr1kq39irSjz/HVef0NoEaGRWpZbE
	 FBBJNZGqhbQlUReKsnUOKnb8u2cjyerkeA3jeCsAJrtLFp/64iJwApOCHdmM73iY3u
	 drN579gnl13e8RzAYrMiqeyejEJLrUZzr/SLhYkw4wOwmQbFXORubfME2R8nXFJY47
	 TOsgh5vNZKyfA==
Date: Wed, 25 Jun 2025 12:07:29 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	mohsin.bashr@gmail.com
Subject: Re: [PATCH net-next 1/5] eth: fbnic: remove duplicate FBNIC_MAX_.XQS
 macros
Message-ID: <20250625110729.GX1562@horms.kernel.org>
References: <20250624142834.3275164-1-kuba@kernel.org>
 <20250624142834.3275164-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624142834.3275164-2-kuba@kernel.org>

On Tue, Jun 24, 2025 at 07:28:30AM -0700, Jakub Kicinski wrote:
> Somehow we ended up with two copies of FBNIC_MAX_[TR]XQS in fbnic_txrx.h.
> Remove the one mixed with the struct declarations.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


