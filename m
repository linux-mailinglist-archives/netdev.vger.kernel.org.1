Return-Path: <netdev+bounces-197294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1485BAD8058
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F9F1897792
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB791ADC90;
	Fri, 13 Jun 2025 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy1C8XhS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4F2F4317;
	Fri, 13 Jun 2025 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749778356; cv=none; b=MbCmg3jTLwfkFHLWVp/0HApTQ5KbMNLiXOBELc2whsPfrwtrINJFoOL/MdnugHFy9QcyJrrr75oxnItj4n0qs+nLVlkdEnwIC08LfCMi1/LjxtDucSg91zqcKP6f1vIsiPPeO26XHmZx6MDPS+5nc6akOEhnNcs5FT7D6QGR2pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749778356; c=relaxed/simple;
	bh=gRJU3XqgcGq9/qTNTjyXU0nsOx7CKZlGWoNnKB8LoFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0WnDHw47CvF4m3OtfPF+ZSz9aQesN4Lx27JMPTNt8GqAx/dThf6/BdacF5xCUwa3jLLWkzpNK8bnj0E7u6i9Oofx2/ppxHVpiSrCTQt2YC+2hWANcBzqHGNcWvk2FZLOQ0Wua9NMtAbuxkZyahj+Y/AfgvJGm2+Xro9H6mmqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sy1C8XhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879BCC4CEF1;
	Fri, 13 Jun 2025 01:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749778356;
	bh=gRJU3XqgcGq9/qTNTjyXU0nsOx7CKZlGWoNnKB8LoFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sy1C8XhS/8l6N5BLjORFAN5Z5CTIBVtAvx8cuhDwhfFV5iI3CLrN5K4qUerqYePER
	 cclzA0bnMQB0uxZ3dtc/eUMTXddTP/QulqZ2gyMafq+Twmp9MOLQiXVXH9pxmbZNaR
	 puIkEJ5OZvPRCArrRCu0jJdE7plXCAl6WB4Tcu+LeIyC0P9/X7lsxab0EgZM7phMNo
	 Mrs53pjn9OdLInykvTtga9e3sYTs/rwz8aR7qYnyIkTbUNoIm+Ll6QhD3lt5mDmwGp
	 8+YFi5do69enNNxm9BPfdsrJget+BQVgKJtQwgnDw8+e7xTaf3vtRwvlnaY4AhKjni
	 JFM5gX2ruEb4Q==
Date: Thu, 12 Jun 2025 18:32:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: Thomas Fourier <fourier.thomas@gmail.com>, Chris Snook
 <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (drivers/ethernet/atheros/atl1) test DMA mapping for
 error code
Message-ID: <20250612183234.51a959e9@kernel.org>
In-Reply-To: <87jz5gyitp.fsf@posteo.net>
References: <20250612150542.85239-2-fourier.thomas@gmail.com>
	<87jz5gyitp.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 17:24:02 +0000 Charalampos Mitrodimas wrote:
> This doesn't seem to build. You can also see it here[1].
> 
> [1]: https://patchwork.kernel.org/project/netdevbpf/patch/20250612150542.85239-2-fourier.thomas@gmail.com/

Please don't share links to the patchwork checks.
Confirm its not a false positive and copy the output into the email.
Patchwork checks are *not* a public CI for people to yolo their
untested code into. Sharing links may give such impression.

