Return-Path: <netdev+bounces-123582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FED9655DA
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 05:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8681F24637
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 03:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C40713A261;
	Fri, 30 Aug 2024 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sknFL3wB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703B3FF1
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 03:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724989576; cv=none; b=AltP4N22L2u8pSpbjMYKplx3QrtCLjbmERVK6hjrZPryeLCNqOfC0aHGMvapXMOPfgtetaOYNYmf4fBNauYFfvP4mZoh1/joXvm0ujGEgM9VK7vhWzKOvbKxVEt6LuSNAhq8auYRSjL3z95KlAaAjqL3yX9RyMVMbVOZGoHtpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724989576; c=relaxed/simple;
	bh=sAIqpGbTP7L75uX7OGa5lqtN6nQiRg1GmqvKR5tVo78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXMYcEQ2scDdKXtbJvXs3ZFOSQWlhe9klxBNlBBb1KQ7GiPlTsRIu4Qm8/SQBfTWQQwH16EztRrRd+V7sklABRxMq5Vf41oKUSuQ++e9Vh+Rju1tQhd99hvSeP5ivFlpx0lK0IVlgQbeTVv+OjNuFrS60jn1D7n9ERBTEBgvUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sknFL3wB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBB3C4CEC4;
	Fri, 30 Aug 2024 03:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724989575;
	bh=sAIqpGbTP7L75uX7OGa5lqtN6nQiRg1GmqvKR5tVo78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sknFL3wBW5FkneFacm+9+gBk9NyoLh172aqExfurPl5u1X5XXL/yP3ES2ssi7ja7s
	 6/HR5WVcTpxAEm3mEdZwIJFs2XlZ4hLbWFd/u+C8mT39hZVd9FQS1fP59+wbpm0B6W
	 KfHW8ZzDXmo2OHsU/F/Zi69ThfgCLMSkD3xvYRmjzAUbKUMMm7poZW3A8TG2BD9byW
	 cfPh2geW3DadToJBFM7o9JhpTnPjTsk+Prxhh/g1s9ol+2gezspxEWCs82yot1LVX9
	 tGf66hy3LHiKZzXtry+JB1WLCqc2AjjnqDpIV/+2RuUPLLKpd6XYItFgbkrL8juGM/
	 lMNe2YVHlxQcw==
Date: Thu, 29 Aug 2024 20:46:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, horms@kernel.org, helgaas@kernel.org,
 przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next v4 0/9] bnxt_en: Update for net-next
Message-ID: <20240829204614.4ef3da4a@kernel.org>
In-Reply-To: <20240828183235.128948-1-michael.chan@broadcom.com>
References: <20240828183235.128948-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 11:32:26 -0700 Michael Chan wrote:
> This series starts with 2 patches to support firmware crash dump.  The
> driver allocates the required DMA memory ahead of time for firmware to
> store the crash dump if and when it crashes.  Patch 3 adds priority and
> TPID for the .ndo_set_vf_vlan() callback.  Note that this was rejected
> and reverted last year and it is being re-submitted after recent changes
> in the guidelines.  The remaining patches are MSIX related.  Legacy
> interrupt is no longer supported by firmware so we remove the support
> in the driver.  We then convert to use the newer kernel APIs to
> allocate and enable MSIX vectors.  The last patch adds support for
> dynamic MSIX.

Some disturbance in the force on kernel.org, their bot isn't responding.
Applied a few hours ago, thanks!

