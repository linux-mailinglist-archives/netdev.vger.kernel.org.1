Return-Path: <netdev+bounces-141372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79099BA98E
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 00:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A20EB21C3C
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA63B18BC37;
	Sun,  3 Nov 2024 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCt4MRAC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B154EB50;
	Sun,  3 Nov 2024 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730676134; cv=none; b=nEZ58wMfJFhWtXvD7fF/i/08T0ys9v5zvVF15b4ku9pd5zrMX9joaJnj0azVMfhiAj7FaWQO0fJ+3V5TjLrP6n1GFxL4jPMq32YWYNu+u4FWHgWNZQ/Is0EB2VC19OqbEHfxAjktXONyDShrXgHgNlvMA+ndt3z+FrpNZ9TIMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730676134; c=relaxed/simple;
	bh=nItcKCtCK7UcJQoxn+1Rntvi08C5l2LlJ+hNUZ0Cwa0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVMEQVNTacZPp+Ih9Wq0/mRWFFpJ3k7BsHuGT6uv0wMquz+rtWnb5sBLKcaM+5afDWcPXHBzXO3/M/Y0v2Zxfq9zTuHd37woe4/4nEtVFvjzszIMb1DTDXseB+w//nPS02Zq5jys7afgznTFv2ah4MSwkhobeZXRdNDzmmoMuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCt4MRAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219BEC4CECD;
	Sun,  3 Nov 2024 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730676134;
	bh=nItcKCtCK7UcJQoxn+1Rntvi08C5l2LlJ+hNUZ0Cwa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mCt4MRACdfOs4pFTOy9Mk5+zeokooxd72jBsCltqNJF47V7CqJA7aFvf3/p0pQv5Y
	 ETsav7iRpiGZYIGg3Njo33cjIy3C9usByzxFQu15ISsFIEdv/vrkZGrw2MM76BJTHC
	 YkwqIDjGL806k75f1Sn7HAj1sQuUSnFlHk/v2WsX69uBgr7MUmXRvsgJRId3klkpMd
	 PZ6AnkIuhokDEyfvbfUmTwZlYdAPEcOuyDFssy4PA3gELNyGXBWoiGigiKit5RttS+
	 ODb5Phsc71OAMTyVJRe9yMI7skII4BY9hNx1FNx5WCc34d4O9PqUrOlLAGt6ItjL0D
	 EJoNhPWLMqhHg==
Date: Sun, 3 Nov 2024 15:22:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: fix inconsistent indentation in
 ipv6_gro_receive
Message-ID: <20241103152213.2911b601@kernel.org>
In-Reply-To: <20241031065124.4834-1-surajsonawane0215@gmail.com>
References: <20241031065124.4834-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 12:21:24 +0530 Suraj Sonawane wrote:
> Fix the indentation to ensure consistent code style and improve
> readability, and to fix this warning:
> 
> net/ipv6/ip6_offload.c:280 ipv6_gro_receive() warn: inconsistent indenting

Warning from what tool?

Unless it's gcc or clang let's leave the code be, it's fine.
-- 
pw-bot: cr

