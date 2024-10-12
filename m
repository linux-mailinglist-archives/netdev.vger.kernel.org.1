Return-Path: <netdev+bounces-134873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C0A99B6B3
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 21:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FC21F221B9
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 19:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663684FAD;
	Sat, 12 Oct 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wD1PDiRv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66782ECF
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728759838; cv=none; b=BBOqnJXOecFhEzKcgA1V5/yHUVP2p+57fIejKxpgAC2w+v0ejIm8cLdAdC3WYadrgh6rxxhpZQdN33PTcy7KbyfOxm0A7Qao386k3hO8l5NvTYS+J3dMvkOQY0foJUjqFoDQ2glXPLdSnOT9ppuG2PaiAF72maTNQprBInpev8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728759838; c=relaxed/simple;
	bh=T5tBw4BQvXYt/tXF4PJxQdDcSPH3K/LOzjRwmhrCRgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkSk9OHYaKU8p2H+knw6dnnPYurCvuAqShPBZaNMno2T6fmr3nNMjru8q8vsVRZA52czQ5DiT1PHUXjXosI12ytrwosFhGiYBkmSo8hfujgHaap/bYMNwqr/vXo+7vv99IPaxfNn13WaEW77Ts+xUbztDHB6cc+/AYd3IPNYITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wD1PDiRv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l+/zR12Dsrn9e4h0UGZQ9rIztUeKCeAtbezsCV8Ydik=; b=wD1PDiRvD88m5/qvM8xOOfTaYV
	+Tr3owK0kqCD4En/sAzdRqs8XDr4MCl82r1sNOP+seFQ8EsPr55Qs+VBIXke50Jv6eeNV0+umhK34
	ZhQMORN6J6hWvG/ovHhRsYGmehqsCEPh6FrsyrCSfTClgASsSbL1InJJklrGe6D/wjy4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1szhP6-009oXp-AN; Sat, 12 Oct 2024 21:03:52 +0200
Date: Sat, 12 Oct 2024 21:03:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net] MAINTAINERS: add Andrew Lunn as a co-maintainer of
 all networking drivers
Message-ID: <99156f69-e168-4c77-90c0-fb2ab1de382e@lunn.ch>
References: <20241011193303.2461769-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011193303.2461769-1-kuba@kernel.org>

On Fri, Oct 11, 2024 at 12:33:03PM -0700, Jakub Kicinski wrote:
> Andrew has been a pillar of the community for as long as I remember.
> Focusing on embedded networking, co-maintaining Ethernet PHYs and
> DSA code, but also actively reviewing MAC and integrated NIC drivers.
> Elevate Andrew to the status of co-maintainer of all netdev drivers.

Thanks for the recognition.

Ack-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

