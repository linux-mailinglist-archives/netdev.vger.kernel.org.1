Return-Path: <netdev+bounces-111449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB257931134
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7671F22A75
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDB9185084;
	Mon, 15 Jul 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gluRxgNs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6271836DD
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035828; cv=none; b=fRapIomNX3hI6t8x7fXVTdAVaB/FPDUIaigmvB90yIbfGkiKL7zTVaesub9a4ZCtOtSn002wSatSY5DjTBYw368SrXkmVSYIOKpXmDb4Qj9Pl3muOUwTmo+2MO0kdlBD2Nl7+vl13m3csbeoCPhvkjoP2St73IBRECE2spJWfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035828; c=relaxed/simple;
	bh=nfeQUMFJmI3cHPR6yI5IueMJEGOyNse7x+AwZr527Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRH8Jwm45GLDbWLFFBzF982+8Eq1cknKe8i7CTOyV1LHrs9iPcJvjyjg0b3TPDjIchTPiBdwJOoEyJMaHy+XzwcS0EeidsKlekmLQn9xYnVOduCm4UGqofER6TSYQN60Yz7x8evABDm3u8X65t94u1aCxm3yKt59ChkMCybwxiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gluRxgNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64BBC32782;
	Mon, 15 Jul 2024 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721035827;
	bh=nfeQUMFJmI3cHPR6yI5IueMJEGOyNse7x+AwZr527Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gluRxgNsuFULgTyFnScMYojYRWdAXjSKpe3Vn3SQD97jCt2VCv+ovvOreZi0We+Bd
	 WBG6gZ2hxsbIlMXTsqPCyrcB4oEN0QuuOO1d0rOlc2upUmlEQgBhC41971RrLmVpu3
	 MKC8BlOPgcauCpVmpbwxlFryWGeHLH+fy04zQFGxOaSUFsZXqcOVWoqDRetMmQTp99
	 YySvr6uiD5DeUzDjpV3esMySxKlbv6W+HjnZK1I7zamY9khBCA547Ym4pNHKQYNOA0
	 y/Wqt/tbSauK4KIUns1/8SmGkzK9/UQWL0jXIh6F8DyQGCkJC7vhrl76MLmI4Skz79
	 sRIluWj3zmMUg==
Date: Mon, 15 Jul 2024 10:30:23 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 7/9] bnxt_en: Replace deprecated PCI MSIX APIs
Message-ID: <20240715093023.GJ8432@kernel.org>
References: <20240713234339.70293-1-michael.chan@broadcom.com>
 <20240713234339.70293-8-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-8-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:37PM -0700, Michael Chan wrote:
> Use the new pci_alloc_irq_vectors() and pci_free_irq_vectors() to
> replace the deprecated pci_enable_msix_range() and pci_disable_msix().
> 
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


