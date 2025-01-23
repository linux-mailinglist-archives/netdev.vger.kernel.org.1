Return-Path: <netdev+bounces-160552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7255A1A230
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6865A7A3C51
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D711420DD5D;
	Thu, 23 Jan 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbHXoFaw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC520D516;
	Thu, 23 Jan 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629474; cv=none; b=WwezPXOsI2hIbjYiu4DHC2jI37KDZiFPbALj7/Gnf0s1DWB7P922QmMMEgmfT8wIZhHUgNnWC3mu36Ggh7260o+y/AG3wTN2JRdtT+KFqjiCMHGiNWEMsKZB41slAAp6OeFMSQllme60ChiQHz/kBu2QPNx28822kNVxkAsg720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629474; c=relaxed/simple;
	bh=GH7+QfLvJMPrBgNn5eveHt6SbNw2WzYA3/W4Qv8B8I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7u9j7Y3kiJybwtD2xCLwWbmVCT6x+oXJOeDJppUXZNyT6BOTVNiEsFOQzd1VCTbVFacn5VZk7uQ0vPl04YHYxKhKdwK7NgCeUS0Ara/ffCBda2m2B/G/GOUZJDfIfLu+nw+/m+kIGBU2RKPEUZSzplEi2rplnW/wBAhyQNmgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbHXoFaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73075C4CED3;
	Thu, 23 Jan 2025 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737629474;
	bh=GH7+QfLvJMPrBgNn5eveHt6SbNw2WzYA3/W4Qv8B8I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbHXoFaw5TaHyYwZi2dQUEKonPqB2sQ9SjRaPaw+yXBWumXjyl045MpAp8QHMXaSA
	 poRXZai4h9j6LaWqOUe8t1t9IsDRRsSZ8CJodGAK4nRadkG4BzLxcvcoPZF/ub60BM
	 t10sQNKiG3rhvw099cj/swjjDw1Erh4uonn7O+klZ9zIKAgW9UybO3FTsw+PUx00HN
	 2oig51m+RF7kABv2JHxfODROKfK08DexUdqU1eQQScJtSxsC66S2+v1nuuxysAnNIB
	 2D7y0SdqhfRGxScvjpvvpt/bJC3iYxFw2CwDQyoYJzUXMu+kaCHV57etugGurgNRjv
	 Hv9U4efgesGPw==
Date: Thu, 23 Jan 2025 10:51:10 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] cavium/liquidio: Remove unused lio_get_device_id
Message-ID: <20250123105110.GN395043@kernel.org>
References: <20250123010839.270610-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123010839.270610-1-linux@treblig.org>

On Thu, Jan 23, 2025 at 01:08:39AM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> lio_get_device_id() has been unused since 2018's
> commit 64fecd3ec512 ("liquidio: remove obsolete functions and data
> structures")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


