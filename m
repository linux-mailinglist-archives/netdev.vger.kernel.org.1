Return-Path: <netdev+bounces-96527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68C78C651C
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF941C211C1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848A5EE97;
	Wed, 15 May 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTGE0UVz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E745BAC1;
	Wed, 15 May 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770064; cv=none; b=R895O1SfgZ3Bjtm5fw3wJRFnCHFfBDagF6TJMcDMWABz7qWTGP/M/GMQmRWPYTr0J2UxAXbj+ph0gO30SgsG6Pkfc6fXydgzyh1dimlr0EtrMRqOXjrO/+6n0yqAlfzTNRM7ulsW24refqTuv4F6vt9wUbzMWpAZc+IMa7+X2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770064; c=relaxed/simple;
	bh=OVc0SjeM+ZeAib1XM/4Emc9EBI0b3W3xsd3Rcxp7QN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9WNB7MujhWvzZENJFG7EaO2cIc7+pl3fvnghPlUGXaWFAQ2X3btb8ur35K3hAj8oWJbL9L5B75MdEs3bJRIai5hfECUhgeVeK/0tTbAnFQBmvZ963Zr2o1YvIwYzVKVZzwwD1l2h0oD95q2QbjdMNq5vrqqq6J5OLL7ZxcHZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTGE0UVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34372C116B1;
	Wed, 15 May 2024 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715770063;
	bh=OVc0SjeM+ZeAib1XM/4Emc9EBI0b3W3xsd3Rcxp7QN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTGE0UVzoyhFPb7JNFksZLa+nr7u7TtvgcxbUPmnD1asJ04lObp1Li9lBW6HBKuAO
	 ijsari/KYBoXZhBGaxbpG8Z431huT3fu3UdoE4McQYpYVOEY/g5x9uKTPER6wj3Oqr
	 tpqsBbxTZCkLCgXsi4b4leppdS1SzLalSujSSc+udn2jNYeS5Kb1bEHpv+TxUDZ4Fa
	 2oDvQfbSr2XWEhRAxAI3gaoFO1qOURJvqQTz6BdUJgaS24OHSYwUv13NElc+HClOOF
	 OrNs4s/f4GmiMslM+h68066n5B/02957U6hjiGY/rDSKwmTTWi/lOhG3ibutuRvlpc
	 IdKPioq9kEfWg==
Date: Wed, 15 May 2024 11:47:40 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/4] vmxnet3: add command to allow disabling of
 offloads
Message-ID: <20240515104740.GF154012@kernel.org>
References: <20240514182050.20931-1-ronak.doshi@broadcom.com>
 <20240514182050.20931-4-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514182050.20931-4-ronak.doshi@broadcom.com>

On Tue, May 14, 2024 at 11:20:48AM -0700, Ronak Doshi wrote:
> This patch adds a new command to disable certain offloads. This
> allows user to specify, using VM configuration, if certain offloads
> need to be disabled.
> 
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Acked-by: Guolin Yang <guolin.yang@broadcom.com>

...

> @@ -912,4 +913,7 @@ struct Vmxnet3_DriverShared {
>  /* when new capability is introduced, update VMXNET3_CAP_MAX */
>  #define VMXNET3_CAP_MAX                            VMXNET3_CAP_VERSION_7_MAX
>  
> +#define VMXNET3_OFFLOAD_TSO         (1 << 0)
> +#define VMXNET3_OFFLOAD_LRO         (1 << 1)

nit: Please consider using the BIT() macro.

...

