Return-Path: <netdev+bounces-72987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047CE85A87A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345161C20928
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7F23A29A;
	Mon, 19 Feb 2024 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBgV9BYG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C443B786;
	Mon, 19 Feb 2024 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359262; cv=none; b=ewZAn11dOw7ysgQhQEJRNqiZwZvwkXDpO2UFj1osbPOhHnShfsbX1me0lyetrCEbQ+ggTe8eOdJP6VLPKgbUMz9gYhJwXnlzfBgJRrTvf4xvbK1KS27cmjuG1uHFh6LLz/kw+rm2oxg6nzsryZHPOzYSGD2+bXJECbLNyJl/jJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359262; c=relaxed/simple;
	bh=CjV/Q5tIGqEo2SgRvMzAGZhlSstVhiuysZf91I8p+VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfuK0OfQibaPVBJyXoSatPLxI5f1qxne2WDSYnbkBXETOjuc0x0Ej2rwbs11kkBPkV5mm7R1n/8AeMy7yc5q1TCCUFgKSkAFiWCdR4+PuTTM/LywcuvVfe6G5YAgzJf7fCOKQENoOIUrIy3ut5VR0RR987PrINRFRdfEMAQ1Gck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBgV9BYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0CCC433F1;
	Mon, 19 Feb 2024 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708359261;
	bh=CjV/Q5tIGqEo2SgRvMzAGZhlSstVhiuysZf91I8p+VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBgV9BYGdv5+7+L1V+WdAYNwrx2x/X/1YIVY0S7LvqsrSpWXdIQaNG0UEixAqNv7y
	 ZrnBihAWQI75HWzBI815Auh1vQxkPXbZycbFA/sCLa82/KzDj2S2u68ft8PY67AeDC
	 Um5EEt1Yo3iFDyCDvEph8H/hUL8w35YRqQh++vTrffzhr+LtU7puJXmLIaI9mFAum7
	 +vHl3u/c/IuNss4A4mxNpaecn/6cxWh7uiO/DJU9TxMYHcFeNm8Alw5Mqu3WxT21V4
	 VOq7ud+x3rg45oWO3pa7/rA0D7HjVy7DIc08NQvkUgqiVM9NW8enssJ71bliSe1G0a
	 Uc18LCe/igK5Q==
Date: Mon, 19 Feb 2024 16:14:18 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: update the link to the CI repo
Message-ID: <20240219161418.GG40273@kernel.org>
References: <20240216161945.2208842-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216161945.2208842-1-kuba@kernel.org>

On Fri, Feb 16, 2024 at 08:19:45AM -0800, Jakub Kicinski wrote:
> Netronome graciously transferred the original NIPA repo
> to our new netdev umbrella org. Link to that instead of
> my private fork.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Although I no longer represent Netronome, I confirm that this is the case
based on a discussion I had with Netronome to facilitate this move.

Thanks to Netronome for their help.

Reviewed-by: Simon Horman <horms@kernel.org>

