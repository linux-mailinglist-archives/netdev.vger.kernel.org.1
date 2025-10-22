Return-Path: <netdev+bounces-231666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76889BFC543
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17AC6253BD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9923E34A3C1;
	Wed, 22 Oct 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dolfmKRh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C334888D;
	Wed, 22 Oct 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140478; cv=none; b=WVvEUofcpfGCY8jt1zHjwG0g1GXlnuV4SiK1Y11gxc+Oh5Bn/7swbffQkdI0ea2NaYh8nKUvLFTpG66op0xjnobA9wYma1t1N+pHSPF9COEJgavM8VkJsFXjcuW73eQ6dTxSAOmKnV17hWqXgyuizkd2jU5f8RveDueW1liBn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140478; c=relaxed/simple;
	bh=eDxCvz9TluJgIeuHagk8eI4Yoe38i13kSOd0S+9fNAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9R7dGbk5dOMXvValtYo2vcBk0m9B0X+Kyp1FtCNJiXfAM6nfxsqxh/bwQYjISZBxll4xQl5XpDgT4/MvJU3mEiAyJhthuYpMcbvhxVqp9O8Ihxnv7onsP5LgwT9kgZ7Wg3W7qj/ayjw4IRLkUOeaLarXjEzebjBHT6s1gY5Ec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dolfmKRh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HC2Y7pPYmCWrDxpm1DRy8C0zQyQm5jdrXSGJjFSGdlc=; b=dolfmKRhjuHhkjc0YWY/4WjvQQ
	j1GTLIqdp6oS4MlyfqUXqMjroW17HMji5ZIEGzixZcxa40Hjl+PtFtRzJKT5JfuL1MubfupuO40OB
	0JFc2ADxqX6/mBTXxhwaZBIsBvCu2GT32UA3i5thzMnIT0qlirspD7zPqeWjMYGa4TMU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBZ5L-00BlU8-Gm; Wed, 22 Oct 2025 15:41:03 +0200
Date: Wed, 22 Oct 2025 15:41:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: net: snps,dwmac: move rk3399 line to
 its correct position
Message-ID: <8563e3bb-6249-4129-8fa6-53649e787b71@lunn.ch>
References: <20251021224357.195015-1-heiko@sntech.de>
 <20251021224357.195015-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021224357.195015-2-heiko@sntech.de>

On Wed, Oct 22, 2025 at 12:43:54AM +0200, Heiko Stuebner wrote:
> Move the rk3399 compatible to its alphabetically correct position.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

