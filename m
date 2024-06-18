Return-Path: <netdev+bounces-104577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D290D632
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19F9290FC6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC08514F9CF;
	Tue, 18 Jun 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZaeeR7x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF3149C60;
	Tue, 18 Jun 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722122; cv=none; b=WlL7KXlOvMWdQS6lX2ZESKRR3iSdBCIsPvXfwL2nb/+hZPQ+c4vJCChFGEfavnIB+XASV8hoQpR8+PcUu1NsmT4a1C60pbyeonYi3Tnk8r8OYEAi7oREzwM3FOXqbvtTWDyNKZET9ruugAlWNAwLGWG7z31hcYc0LdeVwQkPfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722122; c=relaxed/simple;
	bh=/r/WrqFSK7W+9nRphWSvCHntDTG4Rm1XjhB1fPiGPzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lndgnqv0CF2rOPLpggNwJV4qYbnjOFIJjy4PL4gZASIulOm2/D9mECmBhDczSMdN6XRSI/0Hf9dVke6AztNsw98BdkZR9GzKCxIm9M7+hFxx0IP3Mf2oe9kC64Gpj8Xi7n2JK03H1kJR8x/Aw3hI+uU6LVcAhXfZ+IZHwjp0Y+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZaeeR7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954A2C3277B;
	Tue, 18 Jun 2024 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718722122;
	bh=/r/WrqFSK7W+9nRphWSvCHntDTG4Rm1XjhB1fPiGPzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qZaeeR7xKkpgI+ZyHAt7tWEd1D9P07PM1emtzCScGZgwCNL8LFhUq74UB9QIR2BUW
	 XS4QwFabNB/UMhyQOyMFj7it3udCc5SwLkI40SmQFuRoPLycf+MRH/A+8MNoBy2f4v
	 aXgBffwCuPPCRB7kXKCEFpxfZX0qVv8ShwNsDfrHx8z+E4r8GLxdLUnVFX00Vf5Xh9
	 QWATMEzg+DceXqgdC/Y8n7TQh+0Gto+ufz1uj5PXJ6mu6xUqTIeU35akN/hy8arHuk
	 mzmqH9ol5kSMY0Z1Y2dXgB/MFROECjt/MgtHo5iASofWgv5EdqdUXaO/9Ur9KCDz6k
	 IAVORsHD4vP0Q==
Date: Tue, 18 Jun 2024 07:48:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: core: Remove the dup_errno parameter in
 dev_prep_valid_name()
Message-ID: <20240618074840.536600bb@kernel.org>
In-Reply-To: <20240618131743.2690-1-yajun.deng@linux.dev>
References: <20240618131743.2690-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 21:17:43 +0800 Yajun Deng wrote:
> netdev_name_in_use() return -EEXIST makes more sense if it's not NULL.

netdev_name_in_use() returns bool.

> But dev_alloc_name() should keep the -ENFILE errno.

And it does.

I don't understand what problem you're trying to fix.
The code is fine as is.

