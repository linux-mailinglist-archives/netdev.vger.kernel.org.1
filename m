Return-Path: <netdev+bounces-155514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF269A02AD1
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EBF3A5A6F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84FB155352;
	Mon,  6 Jan 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRCW7VJu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA473451
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177802; cv=none; b=Yg3H8D0bVlbdGJVFEAzVaq8ADH2a0oT7iflUSE9mgFa1KMBwLGR+YX/uoGlpz31eed78Ifzo5Nl5U7vT0dFRUWHuz5ep+WMqlBbhcZYx+hhwXJyIgCJ6X2sBtPe88uWN4C1hv5m2ta79QQm52XMqqlku0uk/QTlix5Rs1zxCEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177802; c=relaxed/simple;
	bh=JX0f0fwl7i/VR7uY9gT8UtivfDQTVqBs7+8po+lffYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiQfYsPIbF40T55KtTffEXNNIowOBGii0FP2DSYZQRwFsruxlG0ynslohb03ttq74qlj09GrOhCtUUaeYnetuN44VIGzp4qhu9Lb/mFZ9kH2S7CbqmmCROsFiyDRGPVznp8c6ZMSlxq4oqz5DO9N3nwluoMyrthuN6kAUFZVr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRCW7VJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4F2C4CED6;
	Mon,  6 Jan 2025 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736177802;
	bh=JX0f0fwl7i/VR7uY9gT8UtivfDQTVqBs7+8po+lffYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bRCW7VJuEW8JAVlhK5z7TIbkiVwSVHMZqjbKLhw3uf2K30PxorV5Ki9U2i1F+QOx3
	 2u6DBogV5nk8oAZcVxuqiPAWHh87pj0Wq7BWZFPNTh9DfS1okGzLaAUHH4NCdGqD0U
	 qNTWLoiy5Kxo6db+XuIqzWMxcJwtty5RtbyhtCACtOazLqyn5Xq62SG8w/TFNaiyEF
	 3MSzU1VyTesV3kkO0a2kOMHXUsboxW79c8IrDcZH1nmX8HI3DBASQfZInxt3Q9VXGI
	 wgalXO/rKLl9kliaRkBW8kAlDmw7NrIo7I5pNqleuZ7gL9dpatpH8Bn2PnxttenZKa
	 SNIoZU5hoa5Qw==
Date: Mon, 6 Jan 2025 07:36:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 1/3] tools: ynl: correctly handle overrides of
 fields in subset
Message-ID: <20250106073641.1003e36b@kernel.org>
In-Reply-To: <m2a5c4nkbu.fsf@gmail.com>
References: <20250105012523.1722231-1-kuba@kernel.org>
	<20250105012523.1722231-2-kuba@kernel.org>
	<m2a5c4nkbu.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 06 Jan 2025 13:27:49 +0000 Donald Hunter wrote:
> > We stated in documentation [1] and previous discussions [2]
> > that the need for overriding fields in members of subsets
> > is anticipated. Implement it.
> >
> > [1] https://docs.kernel.org/next/userspace-api/netlink/specs.html#subset-of
> > [2] https://lore.kernel.org/netdev/20231004171350.1f59cd1d@kernel.org/
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> I guess we're okay with requiring Python >= 3.9 for combining
> dicts with |

Ah, I didn't realize. Does YNL work on older versions today?
I thought we already narrowed down to 3.9+. That may have
been tests not YNL itself.

The "oldest" OS I have is CentOS 9(-derived) and has 3.9,
so from my selfish perspective 3.9+ is perfectly fine :)

