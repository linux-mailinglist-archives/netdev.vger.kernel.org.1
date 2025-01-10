Return-Path: <netdev+bounces-157091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2EA08E2F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62EBA1883BE3
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE5E20ADC9;
	Fri, 10 Jan 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz3S44PX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA618FC80
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505577; cv=none; b=LRM3HjILCyz4ZeO2+SbUGe8vBsIzaMbVBl3CqWkARm/duAGyBcI1/XlG2igJcGP7KsDQ+sRtJqWYW37FJByQCUp6wPw2ELgpdDao/XeVwbX8z49XAhvnG1Wc0Eze18L+g4uIBfV2KTFJWPNurRH5m7FPb15z5vMsWmgY0dAks50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505577; c=relaxed/simple;
	bh=R5//g7pb8B2Ig4lyonqdeFtQmLozg5IYDiQXCFA81L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCSvvThNbxtcrDGaZHZNoBGA320SsrGz/liYsvwgZlKWSb17vlhnhfivxuFS/XUlmrJJK+YVCkIXBIw5frKJe86ZcYdfqESfkmfrk8fx2UEHnXwpTt3z1LYpNwqFZe6mzQw1t2Vgwo3BX0nSs6CIXlrgjpvx2ZXrt0mq6iCbEBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz3S44PX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0507C4CED6;
	Fri, 10 Jan 2025 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736505577;
	bh=R5//g7pb8B2Ig4lyonqdeFtQmLozg5IYDiQXCFA81L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uz3S44PXWFd20RzvW6febyrB0fXKWmVWBhtBCDInGNaD382zmmjEvDzd8u4HegI2+
	 4f5MgQGgkbo1piWZ0C3FIO0n9sIvDKcTx0nEMjslBUEz/ivh3wi9Eo8xI9jKm7SkfK
	 GwVdSD+cw/tzVIBy3H1xEGX38rY0ouSviIS6Di7em9FM0ZxyK043QkBJ8Y2v1ywDM8
	 IOWa/8qXo4bFfWtlngnyu9P7dxTVNIFrhys5nTQHB6jYnhms3j7Fk3L2RnqTcipvPA
	 7yPko8th03fax4w45DC8Kvm6dUYlUmSI0ajQFYo8gI/AwC6WVPCgA/FzC/PXf3hvCO
	 Q7+zeKCdg/AYw==
Date: Fri, 10 Jan 2025 10:39:33 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next 2/2] MAINTAINERS: downgrade Ethernet NIC drivers
 without CI reporting
Message-ID: <20250110103933.GX7706@kernel.org>
References: <20250110005223.3213487-1-kuba@kernel.org>
 <20250110005223.3213487-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110005223.3213487-2-kuba@kernel.org>

On Thu, Jan 09, 2025 at 04:52:20PM -0800, Jakub Kicinski wrote:
> Per previous change downgrade all NIC drivers (discreet, embedded,
> SoC components, virtual) which don't report test results to CI
> from Supported to Maintained.
> 
> Also include all components or building blocks of NIC drivers
> (separate entries for "shared" code, subsystem support like PTP
> or entries for specific offloads etc.)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


