Return-Path: <netdev+bounces-125015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F62496B974
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0915AB2709C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592DD1D0169;
	Wed,  4 Sep 2024 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRP+TUHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCF1D0146;
	Wed,  4 Sep 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447374; cv=none; b=upzimyoNOljlkkixeX73tltS7qcuwNYsuTjaViTfGYJODmTDTw4bQDRf5CGRXqQ9A1qZGoR7waeBD0m6t4jWoOD9dmDEXTcu6HFnu3Ls3lKGzADmiN4hxhLFzZo52g1LruzlsgXyYhl64ht4A5VNKGLf9wxX2sXW2cNYwzwW2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447374; c=relaxed/simple;
	bh=qv1/E32WXsiSpzQGsM1bWkTrPOIAMqNTvcwvhb/DNqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1Phfzn1w0TG4sMbX8Ac7qRCZ9q28H6n7PKarCSoWq9ud9dAr4kKWUBjByRAFH6sVzaGsChZ/wA9VwInIYGmQ/HPcQGgEYsrEadnWhBttUIUdUP0n8Wf75bzmUEuARp9kAwrJXsLiWLvGifm4QuQBDJlz9N/gIG59xya8k6bK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRP+TUHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754C5C4CEC2;
	Wed,  4 Sep 2024 10:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447373;
	bh=qv1/E32WXsiSpzQGsM1bWkTrPOIAMqNTvcwvhb/DNqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRP+TUHrzHl6otBagaXLbmHIdPtFWbubjxMmrCobrugpWiqCIf8WaKZTAj4hAXGoq
	 ekXhopZIK4tgpyFVUjqLuU2GW5odJaOzBbyybpaJyyL/zeDq/aPolg77O2aC5g1KHe
	 PsLiwGXiqz216HrXFRQTG86LGDbXCt2y38ReECSHOyE4xP9YbIJ1Itye0lciGjGUNJ
	 YRsGy/rhzt8r35CBSukEAXRAk9vLwSMWbnvLj1bte9W6J7+yjFmSmkhH7LqnnDR4zN
	 WlwhkYF8NBqfp/J8Je7J+BUE7OAToYXCvWEAi17rXDp3Ph0agefV31OhdadbflQiim
	 Si02NXjOKO/1A==
Date: Wed, 4 Sep 2024 11:56:09 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	thevlad@meta.com, max@kutsevol.com
Subject: Re: [PATCH net-next 1/9] net: netconsole: remove msg_ready variable
Message-ID: <20240904105609.GP4792@kernel.org>
References: <20240903140757.2802765-1-leitao@debian.org>
 <20240903140757.2802765-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903140757.2802765-2-leitao@debian.org>

On Tue, Sep 03, 2024 at 07:07:44AM -0700, Breno Leitao wrote:
> Variable msg_ready is useless, since it does not represent anything. Get
> rid of it, using buf directly instead.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>

