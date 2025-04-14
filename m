Return-Path: <netdev+bounces-182500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0AA88E7E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696AF172F8F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5192A2356C3;
	Mon, 14 Apr 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANw6pMfs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273852356B4;
	Mon, 14 Apr 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667362; cv=none; b=HCp9baJMOtoIkrTG5aeHHVaRx13JgP6So7yGHJne6pJ1GDpXL6t/Rds6R157TGnkm2E7NgQ2FIvrlMy5blIUtDUUAP6KNjE2ihUaeGh52fh8JgvZgLihfi+XTgObD2iZ6VSuUJkWlOiek4UQKvv1lXj1txcRSGq3BLBfvbfwGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667362; c=relaxed/simple;
	bh=jFZt0KvrTr1LbLxZyMCPpQPqLXRpwCSYwOOLHWfTgZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPWbTJMGf6ZEp7OU0g9AcPq42o6zKhF+jpOQsk/v9x3kBVzD4kHQhXclVGMMROZEnqAupt8sEf+AKRXsOBBIhFX8CPdlwktS7Do/ZQmoq2rOmA+ROHxRYRykSumDGTUtXlX2j+fnRgaPc7GhiJMyUxcbDJ2HyCU+0r0M0q2XBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANw6pMfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C557C4CEE2;
	Mon, 14 Apr 2025 21:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744667361;
	bh=jFZt0KvrTr1LbLxZyMCPpQPqLXRpwCSYwOOLHWfTgZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ANw6pMfsVIpE/wWOtMamlbzbgieuaEftXKvj2PCs0yCDuvZ3grY6/jt44cr9ISSoV
	 9+yIrHEYNy/nA1PPL60ofRRfrRSYpzgcxpSTWmCWskfD4CHcccnpJN2B17yozedvNp
	 rNj9izSvDrYceI+UsCiklPIpkuFQAEIZrL3V68jXeSkDvOQA98Vt6YMsJpDau9Xxk2
	 sPYZXDrUgWnnogsf8nmgxgsO3k4vhJgRHo+0dH9+Hw6tZsi0UH5wBL/t3hox52OJiC
	 jWlut+RkV0EGi+fXwh7esjMKXXn7Oltqf/WX0LxxNAcnBTXR2H3PPurOQR29Xe7uQ2
	 /ypN5umsuTdPA==
Date: Mon, 14 Apr 2025 14:49:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v1 04/11] net: pktgen: fix code style (WARNING:
 please, no space before tabs)
Message-ID: <20250414144920.3bdd68bc@kernel.org>
In-Reply-To: <20250410071749.30505-5-ps.report@gmx.net>
References: <20250410071749.30505-1-ps.report@gmx.net>
	<20250410071749.30505-5-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 09:17:41 +0200 Peter Seiderer wrote:
> Fix checkpatch code style warnings:
> 
>   WARNING: please, no space before tabs
>   #230: FILE: net/core/pktgen.c:230:
>   +#define M_NETIF_RECEIVE ^I1^I/* Inject packets into stack */$

Prefer tabs, when possible

