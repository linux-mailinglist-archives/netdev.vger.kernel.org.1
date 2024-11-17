Return-Path: <netdev+bounces-145671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438269D05C8
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50D11F21669
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91A1DB551;
	Sun, 17 Nov 2024 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m5qQSH2G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A41DB34E
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875058; cv=none; b=jQkHluyJzOr1+CX9hVduVGZ+VGYLeUBIclFjY10h3UiFSoj3EcKxVF8B+zJw5Gr09Mk1Jn0lGrmHZTeE5WI6WENpj9m8Y3fspsSu1NLiWSRJd2s42oBoxSI/KoGcyHIALoCKsIZvlcIPCB+4/qCZXgd64QKdQMEioiSSpNfHgaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875058; c=relaxed/simple;
	bh=ZynhXoeRkbUXJFE+t9UO/vqMnS0k5Ou0Jps1uL4Pz08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am8iFlpJZo3yJTi9zxjeBMVVZAqac6Md5RpgFAxrpNQeaPP5U/grKw97iYf4NBagfuql6Lt1ux3jXMCsuUfi/IO2lnCrf8eJcIZzIXKQ7Vxrd214P7M3Va8DJYj5zMzYS8u/TnefIrACdska54ImiA0/c9ZneRiAwdXLbZpTIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m5qQSH2G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UrYnO1sMkLjzI3H2EnRccCQ68OIMCfWBUXyluSXaSKU=; b=m5qQSH2GgMoAhH4vepxiYZcMXS
	cB0IevZw95LjIeSm58JYISBXO3LpSjEW1CjjW05VcfVQo5VMSC7Koqn2U8hRAvnJs0YoZXtwvWhoq
	2k+Txm6yMUx55QfFm4gdkehkUfndcBjM1tWwM5Fb2dsuVGeu2eFRsTazhM6e58ThlMgE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tCloa-00DbNx-Ar; Sun, 17 Nov 2024 21:24:12 +0100
Date: Sun, 17 Nov 2024 21:24:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, alexanderduyck@fb.com,
	Sanman Pradhan <sanman.p211993@gmail.com>
Subject: Re: [PATCH net-next 5/5] eth: fbnic: add RPC hardware statistics
Message-ID: <11bde0d3-f067-4854-b979-262ed2c3f8da@lunn.ch>
References: <20241115015344.757567-1-kuba@kernel.org>
 <20241115015344.757567-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115015344.757567-6-kuba@kernel.org>

On Thu, Nov 14, 2024 at 05:53:44PM -0800, Jakub Kicinski wrote:
> From: Sanman Pradhan <sanman.p211993@gmail.com>
> 
> Report Rx parser statistics via ethtool -S.
> 
> The parser stats are 32b, so we need to add refresh to the service
> task to make sure we don't miss overflows.
> 
> Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

