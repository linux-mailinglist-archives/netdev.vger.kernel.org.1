Return-Path: <netdev+bounces-105305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5E0910653
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C781F28925
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B491AD3EB;
	Thu, 20 Jun 2024 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ87azPA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44851AC230;
	Thu, 20 Jun 2024 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890651; cv=none; b=tCNyTT/sPV+srRFi3+Sa4wbDjkKAUKDnA8egT4IJc71+CYuYGy6obGyKqX0rFpp9gtX8d3SjLnT7fH06qMjWoqoZ5FVUizuSRTW1tYyhWOrPuHBE3BC/5Vx2Z6AzrFJCp6o+YzO/DpOYpAUJ6hQX4EEGhymgDWW0eb+arwnFhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890651; c=relaxed/simple;
	bh=cxA9qeex7zQ8JZ19/x1r+X8Z7iVYFPIwbUp5sBzinOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHh4/wK8qh/mgSnZ95xrxJzRHTB0tdpVIHzQ1OYWCf0j2O3Iq99YN2J6oTgScrcJz7RNFhFuCPhg32J/WbI2FzjOjygP/Gd5rrwA9Dp/6YpUpIY2qg5wN5v4dWt+IG8nFgcgVmsF37GKDYdnSTysSih45OoJST6qLRdoc6bRbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ87azPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69671C32786;
	Thu, 20 Jun 2024 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718890651;
	bh=cxA9qeex7zQ8JZ19/x1r+X8Z7iVYFPIwbUp5sBzinOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CZ87azPAEEPqLLHaAENbr2Pocud31sXetaaMKDH9nhIZVVh12OmlMEfgvDyvuuwhr
	 D3adxtVVoJgtVtameew3xuR1PUiepcux0XmUNj2yt30UgnBNaBBMJuXEsfGki5/m/7
	 RcLPCi3z6I2zG0Ak0K04EPbGYWY87zcgs4YLqnmq5HwcvDba1Y2Vtr/Qe4Lcsquvvd
	 3z3ADpq9nTkVKcQR9fklkCFomV2mRSFNrZNZDHV1Q4vvIEiSJyQ30XOGj+AuT1XCCq
	 cWN/fWZ7mxxYnlbsXxhqFY+QFCGyFGsPn5yR/U4/4+D7D8ANxD6HX7C6p3v6kqnPZW
	 /0fMS4LL29X6Q==
Date: Thu, 20 Jun 2024 06:37:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de, davem@davemloft.net,
 edumazet@google.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] net: ethernet: arc: remove emac_arc driver
Message-ID: <20240620063729.55702736@kernel.org>
In-Reply-To: <7d208e8c8bb577cfc790fd24cf990684020ee7c5.camel@redhat.com>
References: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
	<10d8576f-a5da-4445-b841-98ceb338da0d@gmail.com>
	<7d208e8c8bb577cfc790fd24cf990684020ee7c5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 15:19:24 +0200 Paolo Abeni wrote:
> AFAICS this depends on the previous DT patch, which in turn should go
> via the arm tree.
> 
> Perhaps the whole series should go via the arm tree?

FWIW Heiko said on patch 1 that the whole thing should go via netdev...

