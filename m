Return-Path: <netdev+bounces-172418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E63DA54858
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292F918954D4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250692040BE;
	Thu,  6 Mar 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nht+QJLj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7E53BE
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258058; cv=none; b=d003/a7j08ALo3DxmB3nfno3TEKJo6yEq8nsT4gGVHiPhk7LXwtTwDLAeaPc7Vvm86qfhSjJ0acbkvWgrX44K6zlOcJQq32pX0jtSm/Zc/AhKN05K89RvERS0QM4LYYqm2GL7POOWVZ8YgfPHGBwhnp5ILS8amK2wCtZdswC8hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258058; c=relaxed/simple;
	bh=T/1QmVeK5w5QSu5QS4tpyh+ePvgPEY6/GihtUvQpwI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si+eIGL4tTZ08OZ+tJMjFi5dhg2uKE6WlVAQUa1Fyap6eXXXj/4IZwAIipH/EU9LyLsKabNPweVlOjk+8FY+mGOKXTJ5cCTbUrEwqGMaBPKnApL8F3//Qy9Gl3N8OjAgYzOwgJ0pDUY0eyRBZagajqZvIioK/qmQGH32prMPY5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nht+QJLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EDBC4CEE2;
	Thu,  6 Mar 2025 10:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258057;
	bh=T/1QmVeK5w5QSu5QS4tpyh+ePvgPEY6/GihtUvQpwI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nht+QJLj9547qhLfAg8XWRZwrTPhqPqb4sxeQganjJl8xHwGPTLAarwMSFPkg8MTZ
	 EFmA7brUSqJGUXBdyzuv7r0JnC+SS/4CSbf8C4rTxRjVnA9c4ADbnMa14ULA39F5Zd
	 oNyyt5h66sWqZGtuxTTdukGJTsP1H5scNlr0rP2uDNHVUY3QOtYcKeSZ07q+swPPzx
	 RMLLJvxjfR6pGAtZf05Bqr2R6CQSv7R4mmujTItRHeTYrl+HcZe15PLF75wR5RgpdC
	 Ksu7QAbqC8QkiPZyzFdujtGf3p1nGpBVGfXZe5NgarwfYLqcNlG2BsaiItbkueMmf7
	 /P/AnJnUOFt+Q==
Date: Thu, 6 Mar 2025 10:47:33 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: airoha: Introduce
 airoha_dev_change_mtu callback
Message-ID: <20250306104733.GU3666230@kernel.org>
References: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
 <20250304-airoha-eth-rx-sg-v1-3-283ebc61120e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-airoha-eth-rx-sg-v1-3-283ebc61120e@kernel.org>

On Tue, Mar 04, 2025 at 03:21:10PM +0100, Lorenzo Bianconi wrote:
> Add airoha_dev_change_mtu callback to update the MTU of a running
> device.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


