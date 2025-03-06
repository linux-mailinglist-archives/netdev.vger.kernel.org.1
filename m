Return-Path: <netdev+bounces-172436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D6EA549EE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8EC3A321B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9663220A5F0;
	Thu,  6 Mar 2025 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCLXa+nz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC5204C28
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261656; cv=none; b=OGVOJj2VaXo8TwVDiLdW4fT41+EJJ5x7IUMfAZJqwRfRhSYuz8OU0dvRy+3XtNF1CxrTn3YWAVN6Ez3iznD8QbKpIPHqVRXTixgopJ1KnEdZHVH43R6BEBJiObyiqxQPx1rr9J+fkYqJ51O7VLikc/OqCd0nAMQqzXVOs7GWqlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261656; c=relaxed/simple;
	bh=UTh+0Zo9U5+ktJAQ16w7FzZ/V/OLvccdabZ2MgWYn4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTR6Dx9eTJFyhrmvowjQn+tNVqBqTrCtlu61qImUsDEKSgrdY0TTUoKZJDfe9ZfyKtvZpaZG25bstsfo3FQTF+z3OsS7FqhMPuWYKl3tE8gOPGXZHC2CSYfC1A1TlgtPoep0mgBy7FUjHDk3D7JzPEox37INwTaRIvymLEH6D7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCLXa+nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1B0C4CEE0;
	Thu,  6 Mar 2025 11:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741261655;
	bh=UTh+0Zo9U5+ktJAQ16w7FzZ/V/OLvccdabZ2MgWYn4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCLXa+nzyKf/wJaNPjU/crdU3OawzhGW1MhI0TsvhoOgkV5oQ9oZ6AnGr7cpWuQyz
	 d1p17V1lXb4hcpbuDMHJe1/OY+HL85ySZY3D9lqhk3pVn7V04+sJNqQeQqBEyZYtrW
	 k0S4bW19p6wVxXrPJfs6AznTeJL5CwzuR8W3POnKR9Rg5sE8QGOfVerqvWvs1Mk2lH
	 J0VcC/vnHs8wyz0p+8VaheiOORq6VcgRTb94Sdz40s4VrKe1W/nL/1l9fSXgE8rwOp
	 F73hh2zmdMnP/Ck/4xc5a4mLXjNHLuFS+BPK8B/TI8aZUYve9v6YVJ3eQIb5buF5EP
	 bn7A8qBLY4GTw==
Date: Thu, 6 Mar 2025 11:47:31 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix lan4 support in
 airoha_qdma_get_gdm_port()
Message-ID: <20250306114731.GW3666230@kernel.org>
References: <20250304-airoha-eth-fix-lan4-v1-1-832417da4bb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-airoha-eth-fix-lan4-v1-1-832417da4bb5@kernel.org>

On Tue, Mar 04, 2025 at 03:38:05PM +0100, Lorenzo Bianconi wrote:
> EN7581 SoC supports lan{1,4} ports on MT7530 DSA switch. Fix lan4
> reported value in airoha_qdma_get_gdm_port routine.
> 
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


