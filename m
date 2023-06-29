Return-Path: <netdev+bounces-14624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE2A742BB2
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89616280E3D
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E90E14268;
	Thu, 29 Jun 2023 18:06:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD27134B0
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541ACC433C8;
	Thu, 29 Jun 2023 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688062009;
	bh=7Ks0hv1XTuN4Iv5JUqC6lvcE81ZceWI4a8y/7x9CqXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XiK70HkCWF5/YqgANZx6p+vSgxyyYySejOV90UW5Cteyg9yOE12bXdoaIUi0cs6vE
	 EhOv/rqi+Q86KbzKnbN1a69O7Jw82DKwXBDvUpcNBfPDnYfrU8TJwRK5PARlT9j6Mh
	 AuAjvMCIcPeXAmOLkn02O/miOgo8aafKMJ/h282aBbkrNr4yngH45sYQD8fJFRR4z8
	 4R3ILpuJ+RhPEnsv8RWtqYSnSXdZzmnEkTN4MIkdmzrsNxUABmHZq6BbZUGfr6mFq/
	 3fohSdcMPq1svVgzCdnzM6N5L9uUBMT0+npsS2h+89gDwJwhlTFzUlYC1ETX1Zs4E/
	 l0nCV4+zM/oPw==
Date: Thu, 29 Jun 2023 11:06:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>, Saeed Mahameed <saeed@kernel.org>, Gal Pressman
 <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 lkft-triage@lists.linaro.org, "LTP List" <ltp@lists.linux.it>, Nathan
 Chancellor <nathan@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
Message-ID: <20230629110648.4b510cf6@kernel.org>
In-Reply-To: <20230627232139.213130-1-rrameshbabu@nvidia.com>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 16:21:39 -0700 Rahul Rameshbabu wrote:
> The .adjphase operation is an operation that is implemented only by certain
> PHCs. The sysfs device attribute node for querying the maximum phase
> adjustment supported should not be exposed on devices that do not support
> .adjphase.

Richard, ack?

