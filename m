Return-Path: <netdev+bounces-34303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A057A30F9
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 16:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17D32823C4
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 14:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9007313FEE;
	Sat, 16 Sep 2023 14:52:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824C23DE
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 14:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DDFC433C7;
	Sat, 16 Sep 2023 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694875938;
	bh=s5RPDwmBuyoJEWWvgXj8NmOZVFaB6NfKR4yGxoqvfMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=moYawI2OExitQtpiehMqU+NuO418Y/1651GnXGvY2TAOz2WmjDlMhoaJFTz5gxtxW
	 3t+Drqe2+rOYOfbMvskyMLR9bm+C9TkALWshx8REPy5AJXhOCf4cpV4h2ph91Fs03E
	 /COAD8b/Dh7Ajx5PATMG/X0+nHGQnCkilV8zmJcU2kksMYisJ8dWdjXvWothuuMoM3
	 dTMhfZEcSlIydXXNYWHx3UDqVeGcMyzFvw6i+4B7455HInCW+9FYH5rGrfEaIk1fEd
	 WbN41VXMdYKeMcdfSY9b3M41qHHW4eLNmnFupq2R1M2KtjO1E+fkddaPSH+oWoxPlO
	 CaDHmHJpiqWtw==
Date: Sat, 16 Sep 2023 16:52:15 +0200
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 0/4] pds_core: add PCI reset handling
Message-ID: <20230916145215.GC1125562@kernel.org>
References: <20230914223200.65533-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914223200.65533-1-shannon.nelson@amd.com>

On Thu, Sep 14, 2023 at 03:31:56PM -0700, Shannon Nelson wrote:
> Make sure pds_core can handle and recover from PCI function resets and
> similar PCI bus issues: add detection and handlers for PCI problems.
> 
> Shannon Nelson (4):
>   pds_core: check health in devcmd wait
>   pds_core: keep viftypes table across reset
>   pds_core: implement pci reset handlers
>   pds_core: add attempts to fix broken PCI

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


