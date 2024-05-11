Return-Path: <netdev+bounces-95637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898C58C2E75
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8AF1C212F8
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 01:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14774101D5;
	Sat, 11 May 2024 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8cDSJwf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECE320E
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391344; cv=none; b=BjIWvLQP/BjH4/0wivueQlJRd964ZqO5jytp1fXaZUvxGt/Jp4Ozk55Auqq3/p0ICbe2snRVoq6WJnQ/ULaipLk1YV6kTOvlXKY69Kv6pQUoenyIn2L1W0y3lv3V/PZiqxl+lSN0j4y4Pf+RWJ4QKsBIHOkkgv/UZMOwI3w4YFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391344; c=relaxed/simple;
	bh=U8vbSB31xOiAcentt6ly4kV+tG0iJ3j+OpuleLjraGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhXkzt60va+mkalzFcfCDk/kZbtEH9W0zgag4zZ3Ub9wu7zSZJRtLjdPTr6TzHgVatFTJPhli4//+s4Eg6zO+ByHLvIDQ2qY23JuFa9lEUl/W98wc8V99izb8KbEupV7V5AZrjqVq6CG32YatKGomaKiQd7nC5+jrffIoS4PD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8cDSJwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFD1C113CC;
	Sat, 11 May 2024 01:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715391343;
	bh=U8vbSB31xOiAcentt6ly4kV+tG0iJ3j+OpuleLjraGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r8cDSJwfDd786vR9pviS9ICEDaa5kBKtj2367q16zwpLAfqo8iKcS3CudZY5xSMlC
	 v6I7GA0pMG2rrhB2KAIiHQfOdWbmdbK2p14jr5V5ud4O6EN7R27YN7NQDBlQBPvYyR
	 r4vOGmq5T/51AVP/TvgkbaS0+mst+gAMeDCryhTLstfS2kfajd4GleBaPvj6qycRiu
	 20YnarvWVT0ecpByGteZyCQwRbUi0N/yhsLEluo97wRnPHUlkkLtGQslM63KjIwu1V
	 b6dtV6Rx8LMy/XL4sHhAmbZ4r7Ey06uQh24PGlBOcMNh8abpgO/hOlMEU1EeaxHnME
	 DvnGcg/ZO36TQ==
Date: Fri, 10 May 2024 18:35:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH, net-next, 2/2] net: stmmac: PCI driver for BCM8958X SoC
Message-ID: <20240510183542.3165bc96@kernel.org>
In-Reply-To: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
References: <20240510000331.154486-1-jitendra.vegiraju@broadcom.com>
	<20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 May 2024 17:03:31 -0700 Jitendra Vegiraju wrote:
> + * dwxgmac_brcm_pci_probe
> + *
> + * @pdev: pci device pointer
> + * @id: pointer to table of device id/id's.

the kdoc format for probe and remove is not completely correct 
(try ./scripts/kernel-doc -Wall -none $filename)
I'd just remove it, it doesn't explain anything of importance.
-- 
pw-bot: cr

