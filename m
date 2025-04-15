Return-Path: <netdev+bounces-182539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B1AA8909B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAEA87A67B2
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037E214A0B7;
	Tue, 15 Apr 2025 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtagIO5B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37891A262A
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744676906; cv=none; b=SQak2vFt5wWSrdr8q494jLJmgXL0nMoyXYx4jrrNmRSCD4kP+N6Om87ABtt9IMacTuYrxKDKxsGftlIUDJfdUwK0IL6Mo4ExKljAZ+KUZsEM6iPFcpUQqlNElWBRYTgToN84JwckSEsKiw9xI/7mnY8qmTwaI3IAhprMOT9e9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744676906; c=relaxed/simple;
	bh=oTSg9PqW0ApH3vnGI6tALTZWS8FtlZGVOxGxV9UY+jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEcZqO1qwTGevWcDRZSfZ2Inwlbe4q938XosiUf03c+dpn3V03NkJ5e203/aV8WpEOoObi9n4qtBG2G0D0Kyce5UwfpmlpMWSvsEIAyUmHSDJ3ooLd7RixHrjiexbtDOY0ElYGvrXeWIJEQp1EwXY1ssKqjB/LAyOq2NCdmNbW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtagIO5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137ADC4CEEA;
	Tue, 15 Apr 2025 00:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744676906;
	bh=oTSg9PqW0ApH3vnGI6tALTZWS8FtlZGVOxGxV9UY+jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qtagIO5Bh7tMHKi76J3YLNRJu/3t/BRs4z1UzaiAraTJ+hPcaxx0OIajVEibTOH5e
	 59dtqk0lh2FBBcjbT+9y6BRdtvfnUBGTjN2pGulH3F7viPa9nBpyqAhQ2s3N07MNmk
	 /o45dsInA0EOks4tv4+ubezigfwC26jnlO9OBln0EBZHMOhwVm4saUnA47V7IlZrOA
	 /ZLeNyrFDlCeik8kvNWcwnjBJQQr1K2bcphwUORVp+AG4FWumoBEr944qZC1B8yVZJ
	 GzFcJyDRVwpfbta4iJ6lAC8euzpTLW5W7ebrJKx/AtR9WnHIIHUyKa8iVsMpRrQ/eB
	 LHOHe5tXRRMtg==
Date: Mon, 14 Apr 2025 17:28:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Davide Caratti
 <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v3] net: airoha: Add matchall filter offload
 support
Message-ID: <20250414172825.028f019f@kernel.org>
In-Reply-To: <20250410-airoha-hw-rx-ratelimit-v3-1-5ec2a244925e@kernel.org>
References: <20250410-airoha-hw-rx-ratelimit-v3-1-5ec2a244925e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 17:25:37 +0200 Lorenzo Bianconi wrote:
> Introduce tc matchall filter offload support in airoha_eth driver.
> Matchall hw filter is used to implement hw rate policing via tc action
> police:

Does not apply, probably due to net merge..
-- 
pw-bot: cr

