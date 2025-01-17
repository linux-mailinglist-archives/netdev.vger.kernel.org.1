Return-Path: <netdev+bounces-159393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D845EA15666
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64327A4167
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910061A08DF;
	Fri, 17 Jan 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlAs5YaA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF11A0728
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137909; cv=none; b=N8VJCH87m/FhAtwKX2Ly5pzfSHIm5VkbWM1pH2VoWgR+UowmuwKpEXORAAeyZflBH+Qym/KwhMwKSpD6+3bV2ERlW+TU3ULbQU4NJqKi7RtlsJQFDALA7AGh2DXdkKl+bfnSmkCnDLbMt4YKv2KTRxd78agJSLxZtC2Kymeqv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137909; c=relaxed/simple;
	bh=ssUlm6TCg8nfYOEkUY4H7jP/AmeIPSR+DXUYO6JTaWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKEExeagpCnYa+WTftgkycp8tSxU4pPKHNhlUE47TC6rqE0Xkc1OzDQdLMVyZi/Azz8nHpjfUTPknFWPQANKAxY05RsvrC+v6BAHwFVvfB2LOgqiQmRzrIVrcTItp7xMAlzF5edX/vkSxgYo0vgPZaI/pV/3GziH4hztidX3Mpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlAs5YaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510BDC4CEDD;
	Fri, 17 Jan 2025 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737137909;
	bh=ssUlm6TCg8nfYOEkUY4H7jP/AmeIPSR+DXUYO6JTaWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlAs5YaAp7McsTi9H3GaQopmmZj7dovHs1hMJ8binRuuBSHu/HCvqNkG+AivDK+9I
	 66DXqQRHjXX5Uub3VhH8zYUCjFhGOpeAJFKAp/KDRKHlQ6FL/TR9pehINedFh76AKu
	 hfn/2PwArfo66R8wKXGCQbl6JpFJD2/HqwZoB05OBclPgF4LZMSiKvzcyn09y1/OM8
	 Hu/nPGIUkqxtmJCOD5DmHOcIOJeydnyMORCbpkLmxdyrGFWTyl6lO3CsuvvNS2T+jv
	 u2wkykhaeXbBnT4M9VHLdKyxL75NHvCLmDVF8GH6Xm00UkRk4c6NH7K7+fuHyU8E3h
	 AqWgiBNBUnvIw==
Date: Fri, 17 Jan 2025 18:18:26 +0000
From: Simon Horman <horms@kernel.org>
To: Ales Nezbeda <anezbeda@redhat.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, mayflowerera@gmail.com
Subject: Re: [PATCH net-next] net: macsec: Add endianness annotations in salt
 struct
Message-ID: <20250117181826.GT6206@kernel.org>
References: <20250117112228.90948-1-anezbeda@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117112228.90948-1-anezbeda@redhat.com>

On Fri, Jan 17, 2025 at 12:22:28PM +0100, Ales Nezbeda wrote:
> This change resolves warning produced by sparse tool as currently
> there is a mismatch between normal generic type in salt and endian
> annotated type in macsec driver code. Endian annotated types should
> be used here.
> 
> Sparse output:
> warning: restricted ssci_t degrades to integer
> warning: incorrect type in assignment (different base types)
>     expected restricted ssci_t [usertype] ssci
>     got unsigned int
> warning: restricted __be64 degrades to integer
> warning: incorrect type in assignment (different base types)
>     expected restricted __be64 [usertype] pn
>     got unsigned long long
> 
> Signed-off-by: Ales Nezbeda <anezbeda@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

