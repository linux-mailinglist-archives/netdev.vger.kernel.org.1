Return-Path: <netdev+bounces-138583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6466D9AE358
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC07B223EB
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1D21C4A31;
	Thu, 24 Oct 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBvKTFnQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190617278D;
	Thu, 24 Oct 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767830; cv=none; b=JWkKT+g68EOJdFqG2WH4ovW+/TOXWB25i/LEnKZtpbR/K5rx11jtUXfdRMYsi9ce83mt80u3M3VvdMLQD1LwxjVccGbIyW7+UibJOShcpeko2HdEUcWgsYGoEiRsgih0gTAPeigYKVSxtrwOHEqK89hie5WSTuMo7sT0Ng320pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767830; c=relaxed/simple;
	bh=3jcmu9B+YDq/pq3sbNH2BcfffEIp6frNx8Cuo6k0OXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4o3UNBdPS6HXxwV1IFC31Uz38+4z+r6NabpzyO/7GDCwXyMXPfNxjrh05/rD1QIJZMG/4DbSQNDLaSI6YXTL0vEbl5D32U2L/NhfcBALp04/u1R7u7FMn5aetMvKg4+PX6wKsuVFVDREFPvt+8sztke/Ub4wDGmubV9bXatv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBvKTFnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3205C4CEC7;
	Thu, 24 Oct 2024 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729767829;
	bh=3jcmu9B+YDq/pq3sbNH2BcfffEIp6frNx8Cuo6k0OXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBvKTFnQ4yyxz+WpcO5p6vd/GWK27Kvy0yKcE/2sfnVSurmBjqX4Wsk+BSnaV8fvO
	 W/NaNr7s2GBr0SbJfslc/zF3DdRtXFfX9MAL12I16eT2IBtlsL2w3uM965wADOLChB
	 L5mDtB2k1mS4FeOPjzpIt/eFI/9QxRA2irAMPaIYrEx1P8pxufYFWSecOzD1AwVwL/
	 OgC5B5h4XQ/hsM0HoPSEep1TC7F67JbiT07iXiOtVeEaDVaWRgNNd9x/f1z5motAT9
	 Xr3lxwPOWleqpX6GAZrHi6F4YUS5GcXYbwBnqRGVuJjnotMc/sUC5cFAb21WAIlF+K
	 giXqLIFCjtZLQ==
Date: Thu, 24 Oct 2024 12:03:45 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: fjes: use ethtool string helpers
Message-ID: <20241024110345.GC1202098@kernel.org>
References: <20241022205431.511859-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022205431.511859-1-rosenp@gmail.com>

On Tue, Oct 22, 2024 at 01:54:31PM -0700, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


