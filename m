Return-Path: <netdev+bounces-230203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE086BE5493
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E67419C5469
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC82D9ECA;
	Thu, 16 Oct 2025 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvKU2EsD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32EE22068F
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644532; cv=none; b=aGOwonhu6HFg5OvDhWjqaHgnPPNiYIkXrS5Z7bE+DMa75fNrfppUmARG2b6VZzPs+Nf3qXcUe6te2UZfNC33fwbxmxg5HpMNCoeRJaoXzpV9qekwICgY2uR4/P9YY0IlPGgv9m6ux+Hsyq8HiHyzyi/qnh1xxHLPFfVuxCY+iNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644532; c=relaxed/simple;
	bh=hZSmXladyKgEFllZdlGDz7bcaCzmzj6Btx/snCWNZGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLJFSQ4Qmdtw+w/zMkB1UPRJvIlKJPxd9vOG1szi0ELqIQli7bL5ve7sWdlA1TsF8532EZuaTS8iXg1U7yNc/22guL99SvoJoDe5yUqpEMovv2N+HmgCD1c9Shj2+CY9Q3vnTF3o0gvP98RQsvEgze71TCqoRfR43ms5VF833ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvKU2EsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D41CC4CEF1;
	Thu, 16 Oct 2025 19:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760644531;
	bh=hZSmXladyKgEFllZdlGDz7bcaCzmzj6Btx/snCWNZGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HvKU2EsD8Gyf17lIk/uVYcCRXuEziYtr//SgrJdAYRBU3DUVlw88Qyo98R2SZIoMQ
	 2/Nz9TcxC0VnzC65l1CKt3A92GPoRvDKSO7mp2KHYUdfpHYq8G7rqYOvn860oSjEaF
	 +c6Xa+x0WU5+mYxuMEJBvJWgtt2mkXB1PYu8NtLBa/RTrVGvQFnyLTxK7e6p2wK2zS
	 U5Obbh30yOxDZ1dJ/nz5w9FnIuYBpzFSgpo8GJcn5k4kF/aSQ7mT4nklhGWN/VPv8d
	 VrhwVgLwrYz2InzrCQblrGhdXmR4Nzjc2gvHbt4zpj94EkaykuSrV7GKM0clDq9lcp
	 UPBhEylW55ykw==
Date: Thu, 16 Oct 2025 12:55:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>, John Ousterhout
 <ouster@cs.stanford.edu>
Cc: Netdev <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: Build commit for Patchwork?
Message-ID: <20251016125530.44f9934b@kernel.org>
In-Reply-To: <fe1c04ba-3964-4293-b2d2-667fdbdc8f8a@ovn.org>
References: <CAGXJAmwrPr46Ju-ZiLa7prnNFAcGr7Hu-vpk1B6-Q9Ks8fu8wQ@mail.gmail.com>
	<aPEcgcsqFJAEYD_2@horms.kernel.org>
	<fe1c04ba-3964-4293-b2d2-667fdbdc8f8a@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 18:57:31 +0200 Ilya Maximets wrote:
> My understanding is that it just builds on the tip of net-next/main
> whatever it is at the moment the build starts.

That's right. Check out a branch matching net-next and you can run all
the checks locally:

https://github.com/linux-netdev/nipa?tab=readme-ov-file#running-locally


