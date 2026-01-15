Return-Path: <netdev+bounces-250341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4DCD29101
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029863026AE0
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670BE324B34;
	Thu, 15 Jan 2026 22:40:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934A0272813
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516842; cv=none; b=kzcfXnqf+vgbGl4V8mE3JKSfkfsOLrW0UBaKe/t5KVkH/NfcD8e7JqeRFBRXj1bQOHdPtkO3bcfn/2grngRjBv5G7duLuK5fMXaiPU3JXLxs9diYbjsM2q8AiZe6cV/LakM/7V2MNhN94TIVUfosWUB4daVHp2mYouTYeScc6m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516842; c=relaxed/simple;
	bh=+A9IVwTGEFmtoKsr44bgekdGezzmkSg4IkHyXvorUcI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JvomLgw7XZVwkymtRNfpIncYLxqpnId3BnFxw7lIx7LnVnr/7UvgGO87dTlr4dCErhzdahegaNcum2z5wS65shrftlmpsVNsTxz+VGyNsexC4er9DmLXNglk6tDi6gBBTu25+DfG2/p19l3SExl8tRO/UbiPJevJPxHUF6Z8hZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id B6CED92009C; Thu, 15 Jan 2026 23:40:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id B018B92009B;
	Thu, 15 Jan 2026 22:40:37 +0000 (GMT)
Date: Thu, 15 Jan 2026 22:40:37 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: David Laight <david.laight.linux@gmail.com>
cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] pcnet32: remove VLB support
In-Reply-To: <20260115222954.248e9f79@pumpkin>
Message-ID: <alpine.DEB.2.21.2601152236180.6421@angie.orcam.me.uk>
References: <20260107071831.32895-1-enelsonmoore@gmail.com> <20260115222954.248e9f79@pumpkin>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Jan 2026, David Laight wrote:

> There are two variants of the PCnet/PCI - the '790 and '791.
> Each had its own quirks, I later thought that the 791 might have
> been intended to support 100M - but didn't work.

 FWIW the 79C973 device the Malta uses surely does support 100Mbps 
operation.

  Maciej

