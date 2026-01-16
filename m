Return-Path: <netdev+bounces-250532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C1DD31FBF
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D3D030A7C34
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7E283CA3;
	Fri, 16 Jan 2026 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU5Hai/Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851CB24677A;
	Fri, 16 Jan 2026 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570560; cv=none; b=HDaUcBBNMCVQPvZnqcLTZZCSWh/AWan6gP0E/4Q9ILHNDJyNHZ73390u9lDs3G52SxZ9M/upuFhePsn/Vzx8mDcVa6JZ4ASVTrsjFxFuUsv7Dkf1+jY+4hSk+v0KzsnXF640u4PVtdoN+TDLGnsDmdbjtuk13Nx3Gs6PW/nFZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570560; c=relaxed/simple;
	bh=SbmtYTTPQ1stPOU3kQK8bglzeiGQlhHbZoKysOoSWF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VArnbv7fVuF71JMsbLHGVI/ALn1fFWMjrM8xUYn7liW7BqiT6KuyzLvLFhv3wbjnC8dK6rmz3ozYSawV460dJf22K1goE5xlgG9AbxemIvJpNyPt8lfpIMPYgtC9du4FdZZ/mebmctZf38AM4z+qG2qBI3Mx01vrw/kkd+t1ico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nU5Hai/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD54C116C6;
	Fri, 16 Jan 2026 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768570560;
	bh=SbmtYTTPQ1stPOU3kQK8bglzeiGQlhHbZoKysOoSWF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nU5Hai/Zqwz8OuaOlWqis7wP08oXFN6dweFexYfMkjFR/zgPgq7VtwA1qdesVYdlp
	 VsbGSX5hxNSw5wsbixlBPX/2lXn7pt52P1v6B2bhCyGU9sh1UpYooM5nBU2bFH2FBf
	 1Lf6WYe9f1MStz+LM6b0WwWlzkxe6dfRHOtVk0mBksL33Eye6X+wiT3YoI1TmL/LR2
	 e4Dfiv9V/dro1h3NWq+7esw6o8FCW+J5UCqnQovAWttkBW9KuOiEV8u+AqxODR/RGf
	 O60igZnn3mk/DeliopX0pRPnw8Lfjlq2kqONODYmbQObw2QOKfDSdxNNb00RilcyHC
	 2Ik2aGk3+962A==
Date: Fri, 16 Jan 2026 13:35:54 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shahar Shitrit <shshitrit@nvidia.com>
Subject: Re: [PATCH net-next V2] docs: tls: Enhance TLS resync async process
 documentation
Message-ID: <aWo-unS9rhzTfzLU@horms.kernel.org>
References: <1768298883-1602599-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1768298883-1602599-1-git-send-email-tariqt@nvidia.com>

On Tue, Jan 13, 2026 at 12:08:03PM +0200, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Expand the tls-offload.rst documentation to provide a more detailed
> explanation of the asynchronous resync process, including the role
> of struct tls_offload_resync_async in managing resync requests on
> the kernel side.
> 
> Also, add documentation for helper functions
> tls_offload_rx_resync_async_request_start/ _end/ _cancel.
> 
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  Documentation/networking/tls-offload.rst | 30 ++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> V2:
> - Fix style issues.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

