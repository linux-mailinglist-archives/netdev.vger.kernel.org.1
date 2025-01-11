Return-Path: <netdev+bounces-157331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1930A09FC6
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA62188F282
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA2B5C96;
	Sat, 11 Jan 2025 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlowhZL4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9123AD;
	Sat, 11 Jan 2025 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736556901; cv=none; b=dUXoHsXYszx4RZOiX5XrxzOxOrlVbLa9YiboeSQL/b7gxTO8G/S8WMBBce4/8T2YEhFR8wxcP59A4hui6Sir3i/VNu5jOQ/07DmZwXmXuKIumyd3/gFNhtjI+rB5NUZ9mcwHcT5qs3rSokrYnn6oAXTsWcrLFDQq2hBokOLxQd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736556901; c=relaxed/simple;
	bh=CkG+28v0Xsmx+G1hY6ksqsxQhYJLrdnOtXNrLCpY3+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbsluzFICLb0NJo0qRWTuhLVxGWjJVNSycpSUXKa2Knb5VsVd1QHU4h4Nhiyy0TIRpkBPtPNzMTFMrLCHxR1ACZqz6do1miUVUGNXXhG8LG9jb+X8oOl17rwGAuPdBsXyTcpbo8Tbrp0Hjmiht78K5QkhAULUa2Xox1pLz2BeSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlowhZL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE55C4CED6;
	Sat, 11 Jan 2025 00:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736556899;
	bh=CkG+28v0Xsmx+G1hY6ksqsxQhYJLrdnOtXNrLCpY3+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YlowhZL4FaEobNmzMvJhHPnW2a6PRFjeJtOlJueW9eWQnM1QyIJ9MKJ3s1+K9KVD9
	 uhs1Z3CSz4ervBDqGSNJW6I5Da78W6aavVhgX4o1IVdJ5cERS8UxjO6TlvFiV8Mqa6
	 CGkahmlYPX2RBRq0tIKAmrhtBRPU5My5v6ZrrI88EkSR2eva3PNkOYwZw7TY5+1Z28
	 5htiugR8Zmf1eHlF0Encxfr5ZLT7r9mv9Mhf43w9U4UnnEDBFMLkbF32T+gysHEb2I
	 fZ8Y0SXznlUbXUEhW2NDnkgMz1L410hKOtCSOeDN7ZD2IdlKcan421G5cvFm06HwZW
	 UMJwA34FSOoxA==
Date: Fri, 10 Jan 2025 16:54:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Huacai Chen
 <chenhuacai@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Become the stmmac maintainer
Message-ID: <20250110165458.43e312bf@kernel.org>
In-Reply-To: <5e1c9623-30cb-48c8-865b-cbdc2c08f0f3@lunn.ch>
References: <20250110144944.32766-1-si.yanteng@linux.dev>
	<5e1c9623-30cb-48c8-865b-cbdc2c08f0f3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 18:22:03 +0100 Andrew Lunn wrote:
> On Fri, Jan 10, 2025 at 10:49:43PM +0800, Yanteng Si wrote:
> > I am the author of dwmac-loongson. The patch set was merged several
> > months ago. For a long time hereafter, I don't wish stmmac to remain
> > in an orphan state perpetually. Therefore, if no one is willing to
> > assume the role of the maintainer, I would like to be responsible for
> > the subsequent maintenance of stmmac. Meanwhile, Huacai is willing to
> > become a reviewer.
> > 
> > About myself, I submitted my first kernel patch on January 4th, 2021.
> > I was still reviewing new patches last week, and I will remain active
> > on the mailing list in the future.
> > 
> > Co-developed-by: Huacai Chen <chenhuacai@kernel.org>
> > Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
> > Signed-off-by: Yanteng Si <si.yanteng@linux.dev>  
> 
> Thanks for volunteering for this. Your experience adding loongson
> support will be useful here. But with a driver of this complexity, and
> the number of different vendors using it, i think it would be good if
> you first established a good reputation for doing the work before we
> add you to the Maintainers. There are a number of stmmac patches on
> the list at the moment, please actually do the job of being a
> Maintainer and spend some time review them.
> 
> A Synopsis engineer has also said he would start doing Maintainer
> work. Hopefully in the end we can add you both to MAINTAINERS.

+1, thanks a lot for volunteering! There are 22 patches for stmmac
pending review in patchwork, so please don't hesitate and start
reviewing and testing.

