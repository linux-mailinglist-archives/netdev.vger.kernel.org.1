Return-Path: <netdev+bounces-211296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7520BB17ACA
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 03:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2874D5A33B0
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 01:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50404207F;
	Fri,  1 Aug 2025 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXCoGzbI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45D1367;
	Fri,  1 Aug 2025 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754011502; cv=none; b=bbOzLOv1YkXmxxifnmSoPlJctxC+JSqeXG/84YpTFQkJ1MgJFNOcaBG+79RFcb9WDNc67mm21GDiEmoX8prE09GVBTA/aBWvYx6wpfUGgRn6FMekck4GHIwfME4x7+6uHzSfXLCxnvgJqWsiTCAFEr91zXbd1rLWpHNyx+KTSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754011502; c=relaxed/simple;
	bh=8cUxSdbnq0t89qNCQvMvcW5UWvly+yHg6Vt67RVTcmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzGhGPoLVFmU8+yUGoQX7eTFWAPT6idD60qkDMsEyJtiTC6GdtsLzqw4IXbh9qUKNKedSLM9DmFjnVG59ntEylbDT0NkgYyXmUp0eBr8Ft8GtSN6QaD6JRlIlw+S2effhQS0Pf1U/RI2+m4VvzZG1/aWg6f3lW2pjL5IWhdwJN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXCoGzbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86E0C4CEF4;
	Fri,  1 Aug 2025 01:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754011502;
	bh=8cUxSdbnq0t89qNCQvMvcW5UWvly+yHg6Vt67RVTcmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lXCoGzbI5kA+p6RK8PAW58+KuLPX2jbiY1CYHnOd0dfSvTJBOCGYdKqtISMT3EJ80
	 fLgjl6Ip2z/YKg75n7U2/QHQLawjBOftiWRUNgFWl62wbt9tCW0veNYXTPPb6wYOgk
	 NrS9OKb3bbMU/WfRn44va4eQ9qnyFM79ZFpdy5sui5XJBZoUEGueWBg2x4AdmNSEQM
	 pJm23NhmglbfNoaaGvbL5zWlQvF/CRQKARe9ump49OuZLfwLaXwm/82QSsicGw4T4u
	 6k8P/eg7EHCVXe3EMN5U0d+F1bA0RzLpwRYsCKcHpigjzWL/L7mo/82fNUaw+1i+M5
	 tEEyJCHkmKFbg==
Date: Thu, 31 Jul 2025 18:25:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH net-next] amd-xgbe: Configure and retrieve
 'tx-usecs' for Tx coalescing
Message-ID: <20250731182500.6b646977@kernel.org>
In-Reply-To: <20250719072608.4048494-1-Vishal.Badole@amd.com>
References: <20250719072608.4048494-1-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 12:56:08 +0530 Vishal Badole wrote:
> Ethtool has advanced with additional configurable options, but the
> current driver does not support tx-usecs configuration.
> 
> Add support to configure and retrieve 'tx-usecs' using ethtool, which
> specifies the wait time before servicing an interrupt for Tx coalescing.

If you're reviving this patch in PW I strongly advise you to stop.

