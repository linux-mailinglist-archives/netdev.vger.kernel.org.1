Return-Path: <netdev+bounces-215607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B5FB2F7D8
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F27169A45
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA822DEA8F;
	Thu, 21 Aug 2025 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bfm8/3wy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7D91DF26B;
	Thu, 21 Aug 2025 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779006; cv=none; b=HVIYphJ+eOI2tA6G5C/pZ3gXPbsbN3HUr9gj4o+ecnkH9LfqafkIvacRTezNTM/Zq4akTEuBO/B42y1w7I1pIvDIoJY0IRRWauknk6IqRhJLkokLdtmCjFxEmGsM1OEzu2iI6L/gTzc271ffUxXwM0hGtkFUAuyrXlYC29oIw7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779006; c=relaxed/simple;
	bh=l2yz/a69BmD4Ap543b3wumRHAgCXRYK9lk2peNqvSic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuofQT+u+KoGIrLpP/0/qRopbrNNqSwX/lNuSWLfQNKsgq2TDfUHC0UZPe6YNulG3WNNOyQf7t9U3BlRtCTaHk02Ct74qOCNLVt4XoO31QfBhX1DZkHblQDq/WQGkPTx0KfVbhhGt+cCC22wou8cL/7N4W+NhA/qHaLkxjEcYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bfm8/3wy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2q2P01PAZaHRC8b63asCNXKZdiT130xikH730RPz13M=; b=bfm8/3wymYYWrDTTgNV6ri/Ql/
	rm93ez6iCzuiHPaZUiyavg76FknwamCULF7ZRSZqIBvDt/HCQrb5sZj1fGCr+g5ubLWdjzBJnpnIs
	x0GnhYG6A79W27WACTgdaYDSVmPfsmtwbBYHuuKbYR0ivoVtWGpFs/05Wu8j12lpqwyA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1up4K5-005RtG-Qj; Thu, 21 Aug 2025 14:23:17 +0200
Date: Thu, 21 Aug 2025 14:23:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 2/3] net: dsa: tag_yt921x: add support for
 Motorcomm YT921x tags
Message-ID: <5c5d3ef2-cb58-423b-b57c-737b01ba482d@lunn.ch>
References: <20250820075420.1601068-1-mmyangfl@gmail.com>
 <20250820075420.1601068-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820075420.1601068-3-mmyangfl@gmail.com>

On Wed, Aug 20, 2025 at 03:54:15PM +0800, David Yang wrote:
> Add support for Motorcomm YT921x tags, which includes a proper
> configurable ethertype field (default to 0x9988).
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

