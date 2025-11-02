Return-Path: <netdev+bounces-234893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8634EC28D84
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 11:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0836346ADE
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 10:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223E78F29;
	Sun,  2 Nov 2025 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9WlXQNB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1082AD2C
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762080318; cv=none; b=RgM8hQH8F16zbksZgCk1/4wNPMceqPdW1HIvh1Y3M3TOQLE4ZSt4xSE4Vc4IUq3vRTMoQ5tZO0plsrAoxwuy546CjZMGzEfD5KNLJL4ly2M9fzFbCIrDUYHCyabo486uFxEUgjA8I6KIbdK4XQm5ebSEBdusPjCuIUFFQ9VLkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762080318; c=relaxed/simple;
	bh=8jK0rJeS2jUNIamzEFE+gcTjjqz9JB0onrKgbKKYZME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o14mAXT8b3+u1OdRljKWf70SOkmOD4+13nSvvA0CdTSJ2R0gXG6N+m+0V3aNA19Jm/CegfhtXIRekqGuhR2Vl2bE0ALVnKZeLsQMVb/YqthG/4oFjN4bMpdLciq5cpRagTWlpM/QuRiFutnBzNyS035aBD+v52gZ286hNeBNE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9WlXQNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5582CC4CEF7;
	Sun,  2 Nov 2025 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762080317;
	bh=8jK0rJeS2jUNIamzEFE+gcTjjqz9JB0onrKgbKKYZME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9WlXQNBprfAMkYdEmI+avQWPJogIiWpJ61Q3pwh777spFQppz7D0NtWk0lbfcsSI
	 e1EEp8xyn3Q2zEcIez+5SuS77x/E+YUrn456JbsPy28jcaQwNYEurccZamlFjaIxPI
	 tnAvB6n5hSku9O0L2hSRot2HISbDsl4iEHXOLLPBhY/ZDOhlOrLaMtD/lTRqdX+ugg
	 OEJ8yfvykMFNyaKPyGoE1cju4Fdm7VjImTLpk9HRRRerwBSg3Y77vPeDi6te9ae0wQ
	 mFoh3+PjhOt3GHumn6EdYi+8PZpD4yX/fGHwvY7ozs6wivI1w95nSkG51pCyi3ixPz
	 sQjtTcTgMO7fw==
Date: Sun, 2 Nov 2025 12:45:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, michael.chan@broadcom.com,
	dave.jiang@intel.com, saeedm@nvidia.com, davem@davemloft.net,
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v5 5/5] bnxt_fwctl: Add documentation entries
Message-ID: <20251102104512.GB17533@unreal>
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
 <20251014081033.1175053-6-pavan.chebbi@broadcom.com>
 <20251028164651.00001823@huawei.com>
 <20251029133635.GM760669@ziepe.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029133635.GM760669@ziepe.ca>

On Wed, Oct 29, 2025 at 10:36:35AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 28, 2025 at 04:46:51PM +0000, Jonathan Cameron wrote:
> > On Tue, 14 Oct 2025 01:10:33 -0700
> > Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
> > 
> > > Add bnxt_fwctl to the driver and fwctl documentation pages.
> > > 
> > > Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > 
> > Would be useful to provide a reference to userspace code that is
> > making use of this.
> > 
> > Jason / others, did we ever get the central repo for user space code
> > set up?
> 
> No, we have some fragemented userspace repos at the moment only. I've
> been looking around for someone who'd like to take on the challenge

Once you find that person, contact me, I'll transfer an ownership
for https://github.com/linux-fwctl to him.

Thanks

> 
> Jason

