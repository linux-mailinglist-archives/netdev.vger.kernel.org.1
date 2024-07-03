Return-Path: <netdev+bounces-108966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8249292666A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C7A28148F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D311018306E;
	Wed,  3 Jul 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKl0AqKz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51E181BB2;
	Wed,  3 Jul 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025526; cv=none; b=pkWT/rLOOlwnyd9SS26ecQHJdT1KnbeENQ7QolJ2SUdTK8m4Uxa/PQMt+bfbx+9AIKB/ca1qbq3z0mBBVE/oRt1NNhEkJ8ZsbcobRBSBXnf0iK0QHS8uKXHcyAkBhRbJuo/g+V2vk6q1/cLhX/0NJX4gkxqe0JsUC2CH+su1jDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025526; c=relaxed/simple;
	bh=45hGldO5K81d38FFYKTRTVzerpPXNpoxZ066d26cjTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+cR60VXFwu6zgEjwJBlg/o/MwwTSCJNjpLH+CS6RRPeOzF0wmM8mwGcejSv4vaXVWohyExH1EU7Tk3n4cZhTQFUIDBDnaaIRY0iLPpvCXfkWXK9hiKtJqM8oyv1y52N5Dvd8eHgNItLuRWg0ebRCpOrDXijEL1YxUdmUwSEYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKl0AqKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F801C2BD10;
	Wed,  3 Jul 2024 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720025526;
	bh=45hGldO5K81d38FFYKTRTVzerpPXNpoxZ066d26cjTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKl0AqKzvGkTytdE9dvUEp6yFOhQPelKRz3Zkm3KjIbISPHuVyXnnRePgcJjGC5Bb
	 XFNoxUczkkIAAMsWOKN4Vy9Df4QE/TlQCnPbt25j126XSD3lne337rDdbJbaAoru/E
	 UHbRuj+MgwDatF5kkLWF3OoM6XGHwWMp02/ACFTcAc1M6VvKqN6OR8cc86usD53SIM
	 kA0IHyieqn+APaWBUUQ0mS8ElyS/ALv/jz8NHvDQ5KuJrzPCll2xjkx/TaV6T5C+q+
	 AGNNdlMb84ADWTjcl2og8YJj84lKu4bBwr/S+bf6O1o0/iuDy3xgDVdXb7y9lJkISB
	 JKFbzjgbHLh/w==
Date: Wed, 3 Jul 2024 17:52:00 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 02/13] rtase: Implement the .ndo_open
 function
Message-ID: <20240703165200.GR598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-3-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-3-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:53:52PM +0800, Justin Lai wrote:
> Implement the .ndo_open function to set default hardware settings
> and initialize the descriptor ring and interrupts. Among them,
> when requesting interrupt, because the first group of interrupts
> needs to process more events, the overall structure and interrupt
> handler will be different from other groups of interrupts, so it
> needs to be handled separately. The first set of interrupt handlers
> need to handle the interrupt status of RXQ0 and TXQ0, TXQ4~7,
> while other groups of interrupt handlers will handle the interrupt
> status of RXQ1&TXQ1 or RXQ2&TXQ2 or RXQ3&TXQ3 according to the
> interrupt vector.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


