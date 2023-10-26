Return-Path: <netdev+bounces-44504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B98B7D8510
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1B4B20CC5
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00BD2EAFB;
	Thu, 26 Oct 2023 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXnHoNxL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1908829
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAC4C433C7;
	Thu, 26 Oct 2023 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698331599;
	bh=R7j1E4Pe6TaDP6bPCpx4JsfekHBRzFMiflGf0SnPlkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aXnHoNxLtp79xW8TdbOhFtFTSeQR3mk9MV9B5/dEfsKVz0048Tw4XM2qUfCsToxHs
	 acCqRaJ6HaT5pA1NDJWYdkn61W3FMFyLi6vLPxOYJDx91p2pWmwLm7PPrCAMkFikgh
	 C/+N8TVOTZUqkqb2J8cy0h+s9qA/wAXhCX7O+C84RKutUakFNqFQyT/X64pXv/KoWT
	 ffHj1U2GJCBAOZY3LKLg6E4bUR1i7M3+4pGWzOhcpRHkQDpY8Ctx3dw8US86k0F07s
	 Gdu6jADxjHKWt4/l1+R3WFbBbcbFzgtKgo6vcgcbxLjvRIBdhMYZ221sag4nWFV7tJ
	 R8OajH8rL/t5g==
Date: Thu, 26 Oct 2023 07:46:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next v3] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <20231026074638.2a5e02b7@kernel.org>
In-Reply-To: <20231026074120.6c1b9fb5@kernel.org>
References: <20231025095736.801231-1-jiri@resnulli.us>
	<20231025175636.2a7858a6@kernel.org>
	<ZTn7v05E2iirB0g2@nanopsycho>
	<20231026074120.6c1b9fb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 07:41:20 -0700 Jakub Kicinski wrote:
> > What is "type" and "len" good for here?  
> 
> I already gave you a longer explanation, if you don't like the
> duplication, how about you stop keying them on a (stringified?!) id.

Let's step back, why do you needs this?
Is what you're trying to decode inherently un-typed?
Or is it truly just for ease of writing specs for old families?

