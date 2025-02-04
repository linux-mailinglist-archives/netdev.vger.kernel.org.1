Return-Path: <netdev+bounces-162352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4202A269F8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 03:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DDFC3A5F3A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 02:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10342132117;
	Tue,  4 Feb 2025 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeXYe8eM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC14179BD
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738634570; cv=none; b=hF1APEcys29ofPf/PH2CmswPqJoj9Pqh7mtpYTqqW9rWct0zaBTikixsBcobEyldwanHqdnpykXCziwmiP1TpFnnGEbXtKxvHNtR292fdYphKq3dH2Djti+KtXNNCim0vnYk0kGG9LtAvU5TWb/p5jeCmAXFcgi2urZM3VP2RSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738634570; c=relaxed/simple;
	bh=4qDfb29xZX8UqWL3cJUmD/m39Ufu8vINallOiNmLzMY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mwgdOHa4VBdGz+iEifXUYy3rlEE2xbkkmmC8VgTaQxXD4Lx1Ecs5TDRft1/C3FLwJ8+M/+F34YwUmIzy9c2vOBG/+9el5ZpQIAzSFXsg+sHu/J2G2iXSoobJM7kyVkqCsyXpisLW/M5BKUPPQdnkdgDCeppCFnmAfZXvzxRSfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeXYe8eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123E6C4CEE4;
	Tue,  4 Feb 2025 02:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738634569;
	bh=4qDfb29xZX8UqWL3cJUmD/m39Ufu8vINallOiNmLzMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GeXYe8eM7SMZCN1xYSCKTtFSJHxzYqpGyvWIIbiVz6Rv6SPGGfuWRdx/ig3WXeiMB
	 nznSMfdvMEHH9TpMp2OshaI3u7k95SzibF10PxfHDFMHMRCD1KPJ4wuzTCAk2FIAlJ
	 toUUtmU+nQD2Ho8r3SfUpgFVGlPoI9kK/XFR1Ks5aRAzgjSM1FTjFwEwEBDI/zWmah
	 WFGbL+qQqKA5Iq4RkUDqbVdasSCy8nq71GYmFvHZ9/OKN3O+aSlT4ROGSIvAOFZg48
	 6GDFy8600v72LyMnkjJa/lO0r0Ia5RXCTtRdEtakLYIN1PsTedposnaW/qjXMa7Ddz
	 tqLE8D+HzzEJg==
Date: Mon, 3 Feb 2025 20:02:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com, horms@kernel.org
Subject: Re: [PATCH net-next v3 00/10] bnxt_en: Add NPAR 1.2 and TPH support
Message-ID: <20250204020247.GA819839@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204004609.1107078-1-michael.chan@broadcom.com>

On Mon, Feb 03, 2025 at 04:45:59PM -0800, Michael Chan wrote:
> The first patch adds NPAR 1.2 support.  Patches 2 to 10 add TPH
> (TLP Processing Hints) support.  These TPH driver patches are new
> revisions originally posted as part of the TPH PCI patch series.
> Additional driver refactoring has been done so that we can free
> and allocate RX completion ring and the TX rings if the channel is
> a combined channel.  We also add napi_disable() and napi_enable()
> during queue_stop() and queue_start() respectively, and reset for
> error handling in queue_start().

> Manoj Panicker (1):
>   bnxt_en: Add TPH support in BNXT driver
> 
> Michael Chan (5):
>   bnxt_en: Set NAPR 1.2 support when registering with firmware

Is it NPAR (as in subject and cover letter above) or NAPR (as in this
patch subject)?

What is it?  Would be nice to have it expanded and a spec reference if
available.

>   bnxt_en Refactor completion ring allocation logic for P5_PLUS chips
>   bnxt_en: Refactor TX ring allocation logic
>   bnxt_en: Refactor RX/RX AGG ring parameters setup for P5_PLUS
>   bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
> 
> Somnath Kotur (4):
>   bnxt_en: Refactor completion ring free routine
>   bnxt_en: Refactor bnxt_free_tx_rings() to free per TX ring
>   bnxt_en: Reallocate RX completion ring for TPH support
>   bnxt_en: Extend queue stop/start for TX rings
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 531 ++++++++++++++++------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |   8 +
>  2 files changed, 408 insertions(+), 131 deletions(-)
> 
> -- 
> 2.30.1
> 

