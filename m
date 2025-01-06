Return-Path: <netdev+bounces-155631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B24B3A03358
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D701882DC8
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8EA19049B;
	Mon,  6 Jan 2025 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrV726eR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9BEEB3
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736206482; cv=none; b=ufyS/NcGYlUpIczRDuVQH6zdEWztuUd170kYe36XpB2myvLYJrY/JI12ZOA4HXJk7rSZ/NEePyF2zLeANdkhe8hydJAfgqNug/PRtTRNWcfSfYanu19rssBO8yc6aKWVHNfNHoLS5RfL5x2IoKT66PqwK9SIOq7Ne1V2JyzXShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736206482; c=relaxed/simple;
	bh=3wjdi3U7Au29+JVL0O0V4Aygk+/wXGkZSdgOirp2CIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+Zy/aPbY+14CbIqadMT5W58LLHErKgEAoQMa8AkF+WGsRPRus2r9r7AxgfvqbVp85usCojspd6tEaT3Q4xVu1S58+jLfj/Pnfe26gCjDAekLrwWywWVwv8DYObRM6xTKlo781sPlB6LfrH5GHku0Lqsm3+8MW/x+mNaDGVw1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrV726eR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F54C4CED2;
	Mon,  6 Jan 2025 23:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736206482;
	bh=3wjdi3U7Au29+JVL0O0V4Aygk+/wXGkZSdgOirp2CIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YrV726eRjZS2D7/emnL46Sm7D1uQO3CoOnsim19RuhdoRnIqT3rHop7bZmQ+ZJ6Jn
	 NjSLG6Go+yW4ORdZE63JTjR8Y5VjG4MvSNysJjgOrsNTLotpGfgavcCrxJYiGKoTyk
	 pnOVzfmJQrxXLQ9dtY22BPSruuePJOsONrxNg3C9e9/3mjYCQfdr243quSY65ycBTh
	 9wZplWLmBdZmLT6OUQBr+aOb1otZxTX8cAOhtihWUJLlaj1jA/RXWZEdWIRbfDbQXW
	 NdDr+RgfPA/m8QlMmhGiielFFVGTm32HQFLTm3dnOEDiBf73/tN1LMi8OGlAeVNR/D
	 Cp67rmS1GK7MA==
Date: Mon, 6 Jan 2025 15:34:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jay Vosburgh <jv@jvosburgh.net>, Nikolay Aleksandrov
 <razor@blackwall.org>, andy@greyhouse.net
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net 3/8] MAINTAINERS: remove Andy Gospodarek from
 bonding
Message-ID: <20250106153441.4feed7c2@kernel.org>
In-Reply-To: <2982753.1736197288@famine>
References: <20250106165404.1832481-1-kuba@kernel.org>
	<20250106165404.1832481-4-kuba@kernel.org>
	<2fda5a09-64da-40a4-a986-070fe512345c@blackwall.org>
	<2982753.1736197288@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 06 Jan 2025 13:01:28 -0800 Jay Vosburgh wrote:
> >>  BONDING DRIVER
> >>  M:	Jay Vosburgh <jv@jvosburgh.net>
> >> -M:	Andy Gospodarek <andy@greyhouse.net>
> >>  L:	netdev@vger.kernel.org
> >>  S:	Maintained
> >>  F:	Documentation/networking/bonding.rst  
> >
> >I think Andy should be moved to CREDITS, he has been a bonding
> >maintainer for a very long time and has contributed to it a lot.  
> 
> 	Agreed.

Sorry about that! Does the text below sound good?

N: Andy Gospodarek
E: andy@greyhouse.net
D: Maintenance and contributions to the network interface bonding driver.

