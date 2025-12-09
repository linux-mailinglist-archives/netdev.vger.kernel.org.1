Return-Path: <netdev+bounces-244072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C010CAF350
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 08:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87F4B302853A
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 07:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54767286D73;
	Tue,  9 Dec 2025 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE2APubI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F81274B59;
	Tue,  9 Dec 2025 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266689; cv=none; b=mJ/7Ld9QU98cT/R3hmZPPW6zapw4tW4hMKWuknkKXSzTv8BhfoZn1M0d01/XoAWZBLOFghJZUaeTNxbmcoa261eI09xf1pHlIf7/PFnUJpaJ9vqSwjAg4566J8Ed97MqvxZzB+NgAe7u/kR00uiuUHYJSzjWEwu+BejQpIPICwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266689; c=relaxed/simple;
	bh=6MwByzxxUsVWJLoFsFkjTsmnXKvbIoTKkkBvOmeHecM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnliLZoEkPGzmSXChXHaTjEozLnietYtEtb79aPdtpRDMu8IsDOOTKSA9x/tpPaBgxalpsSXgnh4F5v1Ib/amRHJeUvQCClBNfhL0/QuWte7yFG+4DfS4o/dP589rqKWMpmxs0HDqEQEeucvPlEgWMVMfMujs4Ndgroydvkkpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE2APubI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A70C4CEF5;
	Tue,  9 Dec 2025 07:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765266688;
	bh=6MwByzxxUsVWJLoFsFkjTsmnXKvbIoTKkkBvOmeHecM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PE2APubIr0rOtyg6fnySSSNJjMQw2FFaqKGE0XZcjL8rXylH8WG0bGTBTj6g6vj0r
	 oZbIZwVyDgy8xrDed45rthST8kWq2JLSEKPyGS5FjzeXwWxMYol2j9Ecd6RldCaQdm
	 vj42rpNx9/2QNHacnein9q5FiAzwvFjsdAbUyTZvs6Odqf5oe/tduwAj3nVheaFIot
	 hkNcLIzH5pKoe1Bi5lwk9YYjquQKBYJVZjwF349Ou7l7pmMs+OhaTuXSXt3akFf/V5
	 Ew39lPPgCsA3LcdQWLUwXJODi/GjVeV1nj6TkSIpFe+WGb3iFSgeTAOE49lJtpEzSt
	 cwFpphSTrwW+Q==
Date: Tue, 9 Dec 2025 16:51:24 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: chardev: Fix confusing cleanup.h syntax
Message-ID: <20251209165124.0dd5b027@kernel.org>
In-Reply-To: <20251208020819.5168-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251208020819.5168-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Dec 2025 03:08:20 +0100 Krzysztof Kozlowski wrote:
> Code does not have a bug, but is less readable and uses discouraged
> coding practice, so fix that by moving declaration to the place of
> assignment.

I disagree, you're making this code look much worse.
Also, kfree() handles error pointers now?
-- 
pw-bot: reject

