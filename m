Return-Path: <netdev+bounces-165769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14CCA33523
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7781889330
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD314A095;
	Thu, 13 Feb 2025 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxF7CT3v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488081494C3
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412554; cv=none; b=XS7/ysKV+VCJYdpKqfjNt4njMUaLf/sHO35efYcJRpiuVcZ919d08LH8CWMGvhvBKqlKL1itHrHia6pwIDwaJ+4LkEuvOgGeih8Hw4cmWEvhbh0D/3EEyi/p6UpnyEufA0j8VVR5j9fWdwdZ4tS0AhlPMLRVDIl9LXv0K1ePhG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412554; c=relaxed/simple;
	bh=MpXHxY8lXOL0qK4ijqCbhMb4gs1/hlqrSeyrCqMA+Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRqcm140+ahsXB+vhuzUttpTxbOp1cbLlm7AyxJP373ifRiv+69qZCEhCrV5XQLvs3mItVi54vndgpgFrA16CMOtC0lfU8lliWxMG7YeAOo0hsGQxLFn2T5BYpTydqAHM/QpGnsUm3+D7h6RSf9OXZK6FrPEjh+neFoEwfdvdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxF7CT3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C75C4CEDF;
	Thu, 13 Feb 2025 02:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739412553;
	bh=MpXHxY8lXOL0qK4ijqCbhMb4gs1/hlqrSeyrCqMA+Ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TxF7CT3v2DQEsB05C5O52qGzhRkrCUn7ZsNYZsATZLZ+ho1oPfNaVnl5pzrJb31cB
	 4kAzkDXeajOIZHngMn6yeyUZAw7W/l4baiWHpD+9n8oQLn3Fggu0ub+9eGxzfu4tmq
	 hdJpbeXhP/MivY/GV0Ly9t6M5LLlmUY89uKeNz7ioZ/xX7OZyLqS0GTu+yM1Cuqs2A
	 CvWQVLOKrbGSEc/IxmD6bAPBnRL9/s1g0ynFANJk7btbCpm6WgT9QFrfiTgHbybd2f
	 now6zc6uBmAKtp9BtxoG7bBnG9Jm+omHcWF6SzuRqZhyuj2AnK8IMwXQ065EDtDFhG
	 RKaoXLpWwjSqg==
Date: Wed, 12 Feb 2025 18:09:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v7 5/6] net: ngbe: add sriov function support
Message-ID: <20250212180912.7dc3e3cf@kernel.org>
In-Reply-To: <DF81ED4C-F36A-4D6C-8993-0389E2F39615@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
	<20250206103750.36064-6-mengyuanlou@net-swift.com>
	<20250207171940.34824424@kernel.org>
	<09EC9A07-7DA7-4D3E-85EE-F56963B54A66@net-swift.com>
	<20250211140652.6f1a2aa9@kernel.org>
	<DF81ED4C-F36A-4D6C-8993-0389E2F39615@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 19:06:52 +0800 mengyuanlou@net-swift.com wrote:
> > The goal should be to make sure the right handler is register
> > for the IRQ, or at least do the muxing earlier in a safe fashion.
> > Not decide that it was a packet IRQ half way thru a function called
> > ngbe_msix_other  
> 
> Whether the first way(Alloc 9 irq vectors, but only request_irq for 0
> and 8) can be better than reuse vector 0 in the real?

I don't understand, sorry.

