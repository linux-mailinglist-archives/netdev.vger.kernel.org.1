Return-Path: <netdev+bounces-177434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E1A7037F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80643AABD3
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA525A2A3;
	Tue, 25 Mar 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Szp6NE+L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6398258CFF;
	Tue, 25 Mar 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912051; cv=none; b=ZKfSTlCfuB4sa3yo7UhTVMSYs+JPauo9eg45vtev7P6Xf0cpWguDEzHduNIio7J7byPzmbqZB19v/orOrJr12/Wzi5Xmtiw7f2R6i4xiSx3E5gRiA39nRcNuBIVMjCGt856qBvniIxHLjf8sU2JJVfeYcfeNtsi9RSetuIMfLzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912051; c=relaxed/simple;
	bh=FAjJm3hPXM900MHml7URqkCvInQ6IhhZUvxXtEojK+c=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2Fttmn5VaQ1ehDlYJALBbmjst44hUwjlEqdd9ViHnv6Y0wdZlsIF7tKL42n3tLrvHqx/jYt4wxTJwx27/dRSZf/0b2MYxYKAbCawi/AkzwTCCdSgHN9gEV7jJ6Ks00zxsQOVb8SQzElgK6URawscv5ll3Pxwz5QpoMIHYr8akU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Szp6NE+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC89EC4CEE4;
	Tue, 25 Mar 2025 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742912050;
	bh=FAjJm3hPXM900MHml7URqkCvInQ6IhhZUvxXtEojK+c=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=Szp6NE+LPri/om/IjldJd7PXb48QadbUuzX8Bd6j/+KoB0ZRIcP3LPEbLb1cxPaUT
	 tun2ijCwBsXuK8fYxm7PQZfCWnp+qOycWkkJqz20Re4q6wZpkkVpzvfdtr913VI4nJ
	 qdMgscA8FeWCKMVdFrO8O1IVwU1+o8/S5d9Oi2lN+PANpXqEWbYU82Bafpz2CEXDuQ
	 AhhYFZSaP3V0VkpFR8MH8h2BntIX/FqFDHcc+OJtxQn+beljrRAARtwkVyNntOdyk8
	 kx+Ccm0yENZbdQbwlUhNIN1aub4eNUF9ExX2SamVadn0gyaQYv5c5LLmam9AxpNKP3
	 SFkVLGbBdd9Ew==
Date: Tue, 25 Mar 2025 07:14:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Mar 25th
Message-ID: <20250325071404.4ceae2dd@kernel.org>
In-Reply-To: <20250324063300.6d0ceb84@kernel.org>
References: <20250324063300.6d0ceb84@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 06:33:00 -0700 Jakub Kicinski wrote:
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 4:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> 
> Note the timezone misalignment!
> 
> I'm not aware of any topics so please share some, if nobody
> does we'll cancel.

No topics, consider it canceled!

