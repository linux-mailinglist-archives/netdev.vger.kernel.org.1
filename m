Return-Path: <netdev+bounces-96532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B798C652D
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E755282A31
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7891A60B95;
	Wed, 15 May 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAN9dlhN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517B05FBAA;
	Wed, 15 May 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770334; cv=none; b=qTFqU9uGQ1GITSzap82piDrvJysIh9mf8udSARYzLbQH+pErdEYSZb5UDrvkaapdN3Olr3gL+sUlZrW5L/SeAjYyatIyw4IYB8F9MoxSR6P3AmDi9V2jEavbk4hPTb/JyNFVMVIFZx8Ubqbo3XgyAjB1hwsgqNmHtjTOlTh2dJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770334; c=relaxed/simple;
	bh=lGHAt4xU2kIiopBIW1/Ux+TejeEfO1DXsnZmDmGzX/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpv/fwKnOtdl8CTQtqvtpF7mZeZPKYTAISqRW+23ZhnYTe8UW++rODAIT/74thcv0pUV+rCXIw5zjk2CNIx28cDjgRjzdhwo8ZNbLE5Zjl2dO3vbBEjjL8pKuY32gSXvnVzg4aDYYZIE41RmjtBTxSgG0vLqVOuDkdPWedoEefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAN9dlhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7805DC116B1;
	Wed, 15 May 2024 10:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715770334;
	bh=lGHAt4xU2kIiopBIW1/Ux+TejeEfO1DXsnZmDmGzX/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAN9dlhN15F5QZlsl8XIXBWLk9e78dI/D6EkVY5Bin55x/ZxBeryQe5UOTjKgWX7C
	 oNcWWMvO5aLR+OuBS3+A8v9PYsL2AAvMWcap1YUPry2Q3MQS07H/K9JqntpuC8R2Aq
	 2RJ1KVmCEtOQaOV6qDxb+Id/CNas/pKSjI6qO3h76BIdG1dViZCxqnFSUsh/dyxqRY
	 vRQMx0HteHLTN4Fyh9Ev8jCrRujXHiUzhv6meplYSpJ1oxWaivpeMErPu/Sq5dc0x3
	 loTGi2saRjGr+Lp+2b+NR5qznz6V+owg4pxMxoHf6XtYXuPZnIJCAU2sMPbpeBjeO2
	 UkzFJdFewVuXw==
Date: Wed, 15 May 2024 11:52:10 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/4] vmxnet3: upgrade to version 9
Message-ID: <20240515105210.GH154012@kernel.org>
References: <20240514182050.20931-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514182050.20931-1-ronak.doshi@broadcom.com>

On Tue, May 14, 2024 at 11:20:45AM -0700, Ronak Doshi wrote:
> vmxnet3 emulation has recently added timestamping feature which allows the
> hypervisor (ESXi) to calculate latency from guest virtual NIC driver to all
> the way up to the physical NIC. This patch series extends vmxnet3 driver
> to leverage these new feature.

Hi Ronak,

Thanks for your patch-set.

Unfortunately net-next is currently closed for the v6.10 merge window.
Please consider reposting as a PATCH once net-next re-opens, after 27th May.

In the meantime, feel free to post new versions as you get feedback,
but please switch to posting as RFC during that time.

Link: https://docs.kernel.org/process/maintainer-netdev.html

Also, not strictly related to this patch-set.
I notice that Sparse flags a number of endian warnings in this driver.
It would be great if they could be addressed at some point.

-- 
pw-bot: defer

