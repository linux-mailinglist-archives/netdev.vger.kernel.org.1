Return-Path: <netdev+bounces-207929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CF0B090BA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A464E4345
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916452F85E7;
	Thu, 17 Jul 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya7g2T5W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A42F85D1;
	Thu, 17 Jul 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766739; cv=none; b=smyVeRRYsRKi/6rxaD8c1yKhF5FkX6n/fwGT0J7Ccb7oWATiNZz8wluiXhaLxH/+k34qkGRf6itMyKuTMXx/9loXuNbp3ZoKLOwIWKfY7bb5Wzu+xPA0LAKpcumeV66npeaE7csCSJh64X9HgrpBhREyj3IM2z/mW8E8CIhZ18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766739; c=relaxed/simple;
	bh=JsArtl/0wqJQfiQAPasL7s1pYePwWwnuYwM40fW4Wrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCkOUcelxr6x96gWE6PNVA8kuwA64pO6Xb6U78U0odkfEE/TJKZ4sC5tgdcjD+S5g2Cg5UFmd2gLfpYV9KlY4S4Ukd2Tk5Ogai1iZEq/m6mQ2Jpd0ne4j9iSm1K+9SI8royeOON8XqigHEK/dc6FrHPrcXMfBK9ECCNJHtVQsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya7g2T5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1ECC4CEEB;
	Thu, 17 Jul 2025 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752766738;
	bh=JsArtl/0wqJQfiQAPasL7s1pYePwWwnuYwM40fW4Wrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ya7g2T5WZuhlcBhVDsLaEKaZjcI+I4ATDO47sVaAMKMwKrQuARtw7eX0zbD1swUFq
	 Ukrd2eVv3pGgMNBCCGISfppZWlcwc/vVRacU7h6h0dfvjITx0KMEZG0I/ARDxGXRNc
	 dWhJZe4/R7m6BgT+1ZghTkpb0lUnFeEBF0Feii9Ss1cjD90Y8Iwzl9PxDf3ATQa22m
	 /wa4XeYvV1Sxz8hoqwy511M6FB7q+QHlWCoyHcQH/u2KZGXVItK8W9Sldmt9rV1Eao
	 AujehcDFDRlUvZPNIL90fEV6J359qGoMfht5Hmz2aW0+GairbYNMpJcFEgl7KTNzSh
	 q7WB5PCNBkG9A==
Date: Thu, 17 Jul 2025 08:38:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2025-07-17
Message-ID: <20250717083857.15b8913a@kernel.org>
In-Reply-To: <20250717142849.537425-1-luiz.dentz@gmail.com>
References: <20250717142849.537425-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 10:28:49 -0400 Luiz Augusto von Dentz wrote:
>       Bluetooth: hci_dev: replace 'quirks' integer by 'quirk_flags' bitmap

FTR this rename and adding the helpers does not seem to be very
necessary for the fix? I know Greg says that we shouldn't intentionally
try to make fixes small, but there's a fine line between following that
and coincidental code refactoring.

