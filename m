Return-Path: <netdev+bounces-189123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B14AB07E5
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 04:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FB4188D64E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 02:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15AC2441A6;
	Fri,  9 May 2025 02:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxxpqy0f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2A78F40;
	Fri,  9 May 2025 02:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746757680; cv=none; b=oCxD1TVkzXwoMU7Xil9Mm5ldSANm5VXKp1pmDC8GnWnmGrCKzokHzmBEb8GYVR1zODnCDvl9LtUqfrktRz7nWIMyGNvuhpB865yNl7k5cx1SGbXZ4ZGr3IzZJ6wrcEnAq6B1ZIgF8bb7LUxMB8YAfvVZ+RULy+OuNcVtubIPCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746757680; c=relaxed/simple;
	bh=VWL+jkUVJq3X7vau08+JvoWcpHu2wVUgWOyX5rh+zoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfUDPFMxzAg1QKt/p45Bb00/3EAb+CWgQqC4U/9MRHH8JuXA1GdutGRXUbeg2tKr6wyPhqtTdlxQasQqp9WdCyNv5i7oEmGypnRRcM20keYYG2ZUSFP1Dmbe29dqLyY12SDrmeHQvEATDEXR1dzYgum8bYcWDNeZS5cE5E2lWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxxpqy0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B00C4CEE7;
	Fri,  9 May 2025 02:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746757680;
	bh=VWL+jkUVJq3X7vau08+JvoWcpHu2wVUgWOyX5rh+zoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uxxpqy0fs0R7mLaLN+fDvz1PSULjdIoYi2I8vEba4vrmEL/v03+lN0PrSz4zcxPZJ
	 xJGkjDLSAkvXTkniGXuB3L5QzmOk90hW8yMeTEJFzvSvKLfXBFba3N3GstjXrsxKri
	 Rpwz+OW/EJOCMgyFb5sLpdtVYVsfp2nPfMe/bZ8/+Wt56SWH6ANz+QQKKkRUk1yl7N
	 AAmKPKvn/cpmLio047dQusGOCsAax4bwH5vO0NVAX3vZnahdcN82I79FOrTO4MXnwu
	 ZWVqUpucBqRyGYCgtE6hmRqfAO0SacpUAzIbeu+zLjS/NRnCfZgn8YBkVHXBrvA6oe
	 mZUdzMuTcEaPg==
Date: Thu, 8 May 2025 19:27:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Siddarth Gundu <siddarthsgml@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH net v2] fddi: skfp: fix null pointer deferenece in smt.c
Message-ID: <20250508192758.0bf5014e@kernel.org>
In-Reply-To: <20250507203706.42785-1-siddarthsgml@gmail.com>
References: <20250507203706.42785-1-siddarthsgml@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 May 2025 02:07:06 +0530 Siddarth Gundu wrote:
> In smt_string_swap(), when a closing bracket ']' is encountered
> before any opening bracket '[' open_paren would be NULL,
> and assigning it to format would lead to a null pointer being
> dereferenced in the format++ statement.
> 
> Add a check to verify open_paren is non-NULL before assigning
> it to format

You'd have to explain where an invalid format could come from.
As far as I can tell they are all hardcoded (grep for SWAP_SMT)
-- 
pw-bot: cr

