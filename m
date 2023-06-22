Return-Path: <netdev+bounces-13202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18F073A982
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 22:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C8F1C211C0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA9522544;
	Thu, 22 Jun 2023 20:32:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5EA2254D
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 20:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66DEC433C8;
	Thu, 22 Jun 2023 20:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687465926;
	bh=UIN7vbEVF4QwHSBcKRVm9rZeEKOWGNBryfxnm2JqxHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VfzrcJNDTADNxZLzWKciLQRYu+9nq1/G4islfOdNF43uWQdxT0kHF3tQn9mCixHWV
	 xZTEn3AWgWdN4D/DB+CFPlVlwmLV3DRAVex3AkpjMh5zJoxWP6nHE0SW80Qe0Kgza+
	 ZJP8xwy2+AR/jv9XxjkMYN+jy48KK83wZAW4YLbTPfk5Cl9PpWhFov9dzd6wQ8DHMb
	 i2liKBmsuV0ZGkdNCWEP08f9OnIYIhkDiAsHtFtPqU+mSE3gOFsZ1HhsBVF/y6jdce
	 NeKzNaf3EJQfx8sThzuALfLD5h04GAVz4kw8ZOmCPRR+sGgFdSWInuoElCE5RKW8uj
	 NSfvuvNQVY51g==
Date: Thu, 22 Jun 2023 13:32:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: netdev@vger.kernel.org, Robert Hancock <robert.hancock@calian.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Andre Przywara
 <andre.przywara@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] net: axienet: Move reset before 64-bit DMA
 detection
Message-ID: <20230622133204.2ba95c21@kernel.org>
In-Reply-To: <20230622192245.116864-1-fido_max@inbox.ru>
References: <20230622192245.116864-1-fido_max@inbox.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jun 2023 22:22:45 +0300 Maxim Kochetkov wrote:
> 64-bit DMA detection will fail if axienet was started before (by boot
> loader, boot ROM, etc). In this state axienet will not start properly.
> XAXIDMA_TX_CDESC_OFFSET + 4 register (MM2S_CURDESC_MSB) is used to detect
> 64-bit DMA capability here. But datasheet says: When DMACR.RS is 1
> (axienet is in enabled state), CURDESC_PTR becomes Read Only (RO) and
> is used to fetch the first descriptor. So iowrite32()/ioread32() trick
> to this register to detect 64-bit DMA will not work.
> So move axienet reset before 64-bit DMA detection.
> 
> Fixes: f735c40ed93c ("net: axienet: Autodetect 64-bit DMA capability")
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> Reviewed-by: Robert Hancock <robert.hancock@calian.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Quoting documentation:

  Resending after review
  ~~~~~~~~~~~~~~~~~~~~~~
  
  Allow at least 24 hours to pass between postings. This will ensure reviewers
  from all geographical locations have a chance to chime in. Do not wait
  too long (weeks) between postings either as it will make it harder for reviewers
  to recall all the context.
  
  Make sure you address all the feedback in your new posting. Do not post a new
  version of the code if the discussion about the previous version is still
  ongoing, unless directly instructed by a reviewer.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

