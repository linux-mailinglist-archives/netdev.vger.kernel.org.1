Return-Path: <netdev+bounces-123847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4C6966A93
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429A31F235F5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177931BD00F;
	Fri, 30 Aug 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KqcLce2X"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05B155C80;
	Fri, 30 Aug 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050085; cv=none; b=B903+MwvxC4qeGbvqx30PkVq3THo/SbzvtCbpz4h8ITRZORV3zkRtfkgBbM4GC0CKSaa6bGMrlCgu7Umw5cgu5AHIFwgVlNNpf5kHNwiH72ZIs0L+Czy6MTfKo85JS4FFRqNTr5u2RoTzbTneghTyw2ab0ggg+qW1l8AscD5quQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050085; c=relaxed/simple;
	bh=XVcXmMQg/JA0zOiwLKUeapBVJY+VU4c9iUfQQnkFCO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9tViLBD1F08t2WE/BN2kkauLrLyHIwuTBbYsf8hcfN55W1F2vriNuboN7NR6lyjdC8cJf8RY1Ff8ERZ0jT9DK12KFSjX2xYjuNI2iy4XOLEOJUxKFapf2AerkIar0cwE0bz5NQY+94Zo9tpTs/hbfFb3OBHsdOY//0et4uL9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KqcLce2X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dzhlgHFYyjKehOX4ltLZZbG76ccSCY8TFHFaHrHyOQc=; b=KqcLce2XfynqYOiiS1mQntAyWa
	99pY8aMGmJWsVWUW9/GRedoe8hGYc/7V2znBxwsThwzCOyAvuUxGXWXDvNLltFNlqbxAYCvTgCtrX
	gE9sUWrbXOmqCst9C+f3qhVTE6+PBoIToF83P6JwssT6YGgkW5Ez1r/3f4r5+HGrQjXE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk8K0-006A7F-QO; Fri, 30 Aug 2024 22:34:16 +0200
Date: Fri, 30 Aug 2024 22:34:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Yang Ruibin <11162571@vivo.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: alacritech: Partially revert "net: alacritech:
 Switch to use dev_err_probe()"
Message-ID: <0f8fbbe7-4a91-4a18-a277-06d144844c2a@lunn.ch>
References: <20240830170014.15389-1-krzysztof.kozlowski@linaro.org>
 <20240830182844.GE1368797@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830182844.GE1368797@kernel.org>

On Fri, Aug 30, 2024 at 07:28:44PM +0100, Simon Horman wrote:
> On Fri, Aug 30, 2024 at 07:00:14PM +0200, Krzysztof Kozlowski wrote:
> > This reverts commit bf4d87f884fe8a4b6b61fe4d0e05f293d08df61c because it
> > introduced dev_err_probe() in non-probe path, which is not desired.
> > Calling it after successful probe, dev_err_probe() will set deferred
> > status on the device already probed. See also documentation of
> > dev_err_probe().
> 
> I agree that using dev_err_probe() outside of a probe path is
> inappropriate. And I agree that your patch addresses that problem
> in the context of changes made by the cited commit.

Maybe device_set_deferred_probe_reason() could call device_is_bound()
is check the device is not actually bound, and hence still in probe,
and do a dev_warn(). That should help catch these errors.

I assume the developers submitting these patches are also using a
bot. It would be good if the bot could be trained to follow the call
paths and ensure it only reports cases which are probe.

	Andrew

