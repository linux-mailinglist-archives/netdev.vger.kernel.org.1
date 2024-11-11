Return-Path: <netdev+bounces-143820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706D99C455B
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD4A28130B
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A789C1B86F7;
	Mon, 11 Nov 2024 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps+Zo5Z5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403719B3F9
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351035; cv=none; b=JiYWcMcVkrXSedBQbmP+G+nmhy6BvJ8mCxUa0RgCl8BdMRj+G+uDF8/T+nMoXRnVCg60I+JIUf4PHoMT0U6Rqu7rqtLmOykynOZwc4xAIhN8mEX1nK9XkxqiBFwxXOmemNcE+7i6NVFUgXAS6WXN5Wd2RiwXESMXG93yD/KobRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351035; c=relaxed/simple;
	bh=hrPRFx/wRlWebkrztq5J49RsB8Pqeaii8M8ChObOez4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sed5MLinS8RdjI1Xje3WR7qorWaEabLzpfSIcxbt+DFodFembt82e2cBpsTNXgr97Hucuv7TAEINUU+0YjR7U1Av0AWzQsRXep/ElrUCwCfaoaM/kfClW233Q5UFnwkZUwgwD692c8d831/hr7q29SiP4Whnxy4t7imyU9Y85is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps+Zo5Z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C086BC4CECF;
	Mon, 11 Nov 2024 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731351035;
	bh=hrPRFx/wRlWebkrztq5J49RsB8Pqeaii8M8ChObOez4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ps+Zo5Z55Z/6ksfCwC5NtZk5OAKQRmDn0Batv3PBZft1Zo+nfTnhx+jTF8h3Sanlk
	 qziPJMJRsaxpY23RmSTnu65aD1vw5a0x4NoLUo4EANLAm6LPhNjEJ+BbecxaOgAKZx
	 owFDa28aQPcyd4nEqzzeJEXJG7+7u52a8CZXbO5UokoqzsIh8p16SUYErE0pu6CE6l
	 IvDHS6NKQhFnkrQk2AFGZtyQBqts4FDzeIoslCmd5daWKCvJKsOBcgGw905tHx8WcZ
	 v6FkfnZthpxaUmqRx9oyPQ5eFDzRRzGsJhYIpXPJQrqlACcGRDeF6Nr3MnZio8j0dS
	 MdIP7TcS6ilLA==
Date: Mon, 11 Nov 2024 10:50:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: William@web.codeaurora.org, Mokhlef@web.codeaurora.org,
 wmokhlef@gmail.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH net-next] net/unix: Stylistic changes in diag.c
Message-ID: <20241111105033.79250f9a@kernel.org>
In-Reply-To: <20241110005927.30688-1-wmokhlef@gmail.com>
References: <20241110005927.30688-1-wmokhlef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Nov 2024 01:59:20 +0100 William@web.codeaurora.org,
Mokhlef@web.codeaurora.org, wmokhlef@gmail.com wrote:
> From: William Mokhlef <wmokhlef@gmail.com>
> 
> Changes based on the script scripts/checkpatch.pl
> 
> Remove space after cast, blank line after declaration,
> fixed brace style

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: cr

