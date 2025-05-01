Return-Path: <netdev+bounces-187255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F78AA5F95
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 15:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AD13A7C37
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF9F1A00FA;
	Thu,  1 May 2025 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS9/ZkL+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761FB28382
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107872; cv=none; b=Efb7tb2JhAkHJHdZvj6QXHX77XORXL21gUkhUydBhLRoZjrMte3SIcR3zpciFgXCtk8ULXUurRpquLxU0XlnTpVScARfvdY/bzj4bw8EXHaFMWNUR0Hi39GIpinpo3WEbybTOAR/IYQOy2qLaOWw2GiLr54pN0fl9dysm9fHlQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107872; c=relaxed/simple;
	bh=/QNEplS92oXN6N1YLknlm4ZYkKG5830q9Ytw0C/zqoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5CIXEvWmgkona+kcWzRhvxT1P2SMokYwLKumgkQ3C1U4In6ZkZukyfDxRWlC3iMJM8oc3a56B/AWVoXyuxrcDaAe8qwEISeu/UclCi2MiWUlFJIByiuN3RXoFYMf7qVTU4zw4B5925BM3RvzWXnhwLiY2h0begGnncosA6ySPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS9/ZkL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1EFC4CEED;
	Thu,  1 May 2025 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746107871;
	bh=/QNEplS92oXN6N1YLknlm4ZYkKG5830q9Ytw0C/zqoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bS9/ZkL+7SIMntZ5TPQSqZlCTAoL1lq0oJYVYY4yd/HrxHUyiqrMAT3T7SBRRwgkM
	 1nx60wGK9HC/FfIsS2MUL0iyyqj31Tki0RUl1AkCcjN5eaNk0D2Mn3geSx7yq5a+Cf
	 C2cOgKGlKED2Dzpiavx8iBwoDcr78IOuziOAA+VGKXp5gVJEVF31QrN2dy9uhKGxpI
	 WJBiPMPLe4xCMckAJu6s6dwp9ggzBt6ywvSYSRuwOMkqOkOKv3mWzM7LSMkXRmktWm
	 xKqE+UnzPJ/pjbDzMsDufgGMpm1Zk2DFeTWKMZGycwOv7OS9rSzBkMGKqenK9RIQgS
	 iSavVQEKv4ouA==
Date: Thu, 1 May 2025 06:57:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 0/8] bnxt_en: Misc. bug fixes
Message-ID: <20250501065750.088f4156@kernel.org>
In-Reply-To: <20250428225903.1867675-1-michael.chan@broadcom.com>
References: <20250428225903.1867675-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 15:58:55 -0700 Michael Chan wrote:
> This series fixes a bug in the driver initialization path, MSIX
> setup sequencing issue in the FW error and AER paths, a missing
> skb_mark_for_recycle() in the VLAN error path, some ethtool coredump
> fixes, an ethtool selftest fix, and an ethtool register dump byte order
> fix.

Applied by Dave last night, thanks!

