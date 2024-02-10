Return-Path: <netdev+bounces-70734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBED8502B2
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 06:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DCA1C21108
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 05:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7717ECA7F;
	Sat, 10 Feb 2024 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPzt6MVI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CDF524A
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707544466; cv=none; b=O0+m5QejKMN+DHY6BQ7UbfRCSquy+7C+hLLrED8hJBndEnwjLEwT26Gr4CTYrOujGn1D9IBa5MOmTdDEwZRVR1ld6kNR+f2JxDl85saZ9qN2DeCsTaB045MOLlSAMimMlOm6cwkOANuBpnv5WJAUqFggRe0iDyy/8TKeeWAjrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707544466; c=relaxed/simple;
	bh=ogHzlILkVckJC8opk/fqHfa0vMLpdIgxsxVG1/baE+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIcpQcs+IzzLKkTsGWHGO1l8l3o4UsbWbaS/3+T5MYx3IEcK9kymT+2xxHFrlkUxLX6jUBKSgYQ79a5QqY/orwihbx6LOUbrtBxwZZrRVJkN/p9zxtBEIH22TksfN4N+0udfSHkreXTKM4/dvseBhiT2tAxZtRELv2dF3h5tJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPzt6MVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BAFC433C7;
	Sat, 10 Feb 2024 05:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707544465;
	bh=ogHzlILkVckJC8opk/fqHfa0vMLpdIgxsxVG1/baE+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tPzt6MVIgvoqytglEjviET47BtBnHw6ZkTQ/QRQPWrfocc78+YHDXaz68T/vKeGKf
	 ExtZpbekhdX+PEKR4IpjRqi2tO6GX0ZFUayCulwJXhV2miBl8ogX5kdc3dvRiy6Qhs
	 l2wzsXSY25mQdKIwPDG5SrmQVP5VPivZK2USV+W7r8RYAKXh+IGe7gGa27qxkTDo1v
	 X1v2H0QlgqMlD2DUlvS2PzWMIoBGusby8nq0AK2JC/FND9saGzURFXHRRWAEf1Krpi
	 Txw5VGsmTRMrQH0HM6hnesrToHDTURMaWsBKrODbNdapVb6aMJRHjiFK5FOxUPSjFc
	 S3nL1Bj06Bn6Q==
Date: Fri, 9 Feb 2024 21:54:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 socket direct
Message-ID: <20240209215424.338ef812@kernel.org>
In-Reply-To: <20240209215403.04cf8f1b@kernel.org>
References: <20240208035352.387423-1-saeed@kernel.org>
	<20240209215403.04cf8f1b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 21:54:03 -0800 Jakub Kicinski wrote:
> On Wed,  7 Feb 2024 19:53:37 -0800 Saeed Mahameed wrote:
> > This series adds support for combining multiple devices (PFs) of the
> > same port under one netdev instance. Passing traffic through different
> > devices belonging to different NUMA sockets saves cross-numa traffic and
> > allows apps running on the same netdev from different numas to still
> > feel a sense of proximity to the device and acheive improved
> > performance.  
> 
> s/acheive/acheive/ throughout

Heh, I misspelled :) You know what I mean.

