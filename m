Return-Path: <netdev+bounces-195154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17AACE742
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 01:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D58617807E
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D43E2741A0;
	Wed,  4 Jun 2025 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw1Y5fVL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784F6F073
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749080624; cv=none; b=YYDfLVv/FE7TxTmtkGMCi6Lt/X2A1uNcBGW0LzaS25M9leehZTzpJyV6SVOhDaPM7vSN3eUsF9B9i4UaEtsZRWMWu9v5rewQku0e54rABJfr/bNrKTNXh5iFc4/sEvUxF3u1x6wLx+SnPRBl/Tc+PtEAJ/VFWT6W3mQlbexE5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749080624; c=relaxed/simple;
	bh=tVPIZUMq17NlNNXHw1eJDSOW8vm1oXoE8Eqc3CL8ma4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4b4qJ+/YRDT96T+Xv6Bpe82lEFPeEGQGP6piY6CFVxDFQfTJjtJ3o5nCfZgfMcvm1M2VQrcTvHmpu4MqWGKnVtD/HBypLegxMxL26Z71FxcN7i3qjr4zgTc8uc3VGSssbPuFrIG0QYYUlWyOJNMjLEcuP7ERl0qH2bt2n862XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw1Y5fVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0204DC4CEE4;
	Wed,  4 Jun 2025 23:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749080624;
	bh=tVPIZUMq17NlNNXHw1eJDSOW8vm1oXoE8Eqc3CL8ma4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lw1Y5fVL/p7pP0GyN2BWACuVPuI3o/ib7LC/YvI7+sDiMPbZkvoFbxDjhdbIGobzp
	 VXuqVWf4gUVkf2nm5JVQw8UXZYFGEKdV840NRtoFlnm1OMngr22WCCcp/x/kH0UPag
	 pDtlqKmWK4ME8BF+qNnS1Siw44gxrZVspCKMQpgwxGErzcxEfn21XVXndOMlfxuM4q
	 x8zlpx/6RpNo65VYdLgF/cDl35dnm2YHNays6pzTQb2b6Poq8kh8yi/+mPIq4yft/A
	 jYCnpbAVIHD9+LB3FjaQO7BBVBzq/q7D0h9QauhKNN3kYum8XdAzkc6nDw8vAdqiBY
	 vKDj3puVyUxUg==
Date: Wed, 4 Jun 2025 16:43:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [ANN] pylint and shellcheck
Message-ID: <20250604164343.0b71d1ed@kernel.org>
In-Reply-To: <m2ldq7vo79.fsf@gmail.com>
References: <20250603120639.3587f469@kernel.org>
	<m2ldq7vo79.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Jun 2025 10:41:14 +0100 Donald Hunter wrote:
> This is a possible config for yamllint:
> 
> extends: default
> rules:
>   document-start: disable
>   brackets:
>     max-spaces-inside: 1
>   comments:
>     min-spaces-from-content: 1
>   line-length:
>     max: 96

This fits our current style pretty nicely!

One concern I have is that yamllint walks down the filesystem
CWD down to root or home dir. So if we put this in
Documentation/netlink/.yamllint people running yamllint from main dir:

 $ yamllint Documentation/netlink/specs/netdev.yaml

will be given incorrect warnings, no? Is there a workaround?

