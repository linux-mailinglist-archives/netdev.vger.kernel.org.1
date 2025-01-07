Return-Path: <netdev+bounces-155807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2473BA03DD9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6956188171A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E6C1E9B0A;
	Tue,  7 Jan 2025 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL1jUOiA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3011E4110;
	Tue,  7 Jan 2025 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249664; cv=none; b=cB3PbnwYHw5+fdA3+vG0FQo+HM16Ha39GkASRsLNYnZmlc0DXr8pKFmkm8rRUD0/o5OkQdj0MGMAHN7QIZC302xpBT8WwZAaoWd/XPo6beWEPqAPEeYpxtW3uiRbgF+HsC11qDN3+K9173aIZyeRhWD2W+9R7IhmrCaVQtYIFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249664; c=relaxed/simple;
	bh=GUZFf46UPiqzPrPwgJP/xPQ9lqA1URaAsO8R1+0MaLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJstis5hlAQrrlu2IYeWieD25CHbgxKew90RbBdloqLvjZk6HD9MQhnFZjS+YEt0Nw9PCZUdt6z690qiAVETr1KgEUt5dFnfov06j+WJZhg+TOtrC8siEnXo62XI6i+oX0W4lLx4rl29SnTFET7gZfK67ynhRyJ/piqXX4Kiflo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL1jUOiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ABEC4CEE2;
	Tue,  7 Jan 2025 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736249663;
	bh=GUZFf46UPiqzPrPwgJP/xPQ9lqA1URaAsO8R1+0MaLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HL1jUOiASoq9LAqdgS1lybwiAJ9p1y8B6tdKkvMKVa3v8r236GfyZEL4ht5ZCffMT
	 E4MlBGXmvUp1oC5NswbO4GQ3L441qsN9gi8pAgMNMSii/AvjeQkepHjm5/G2tgOZD+
	 9yBjWIkrgWep38SKW6ngXTPUDmV7qjR88lsCNhUrMEIJYDGqJT15WYNKzZxOggl5nT
	 jcIZ8/utCmO3sJCm4BsXbYyHPBmxNorxSSmOTVct36l8Wb3S/b3cPNvp/4ZPLDHkxC
	 +YSeHfdPrgfOQT5pxw7sSuX0vIVIoKFCck58fHUrVJaShV1eBUxovlYTR8ieKAiZQ+
	 R2sE4PbQgp4oA==
Date: Tue, 7 Jan 2025 11:34:19 +0000
From: Simon Horman <horms@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v8 18/27] sfc: get endpoint decoder
Message-ID: <20250107113419.GF33144@kernel.org>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-19-alejandro.lucero-palau@amd.com>
 <20241217104225.GP780307@kernel.org>
 <bdb7427b-22f1-9c1d-8990-9f8287fc5fd4@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb7427b-22f1-9c1d-8990-9f8287fc5fd4@amd.com>

On Wed, Dec 18, 2024 at 08:22:05AM +0000, Alejandro Lucero Palau wrote:
> 
> On 12/17/24 10:42, Simon Horman wrote:
> > On Mon, Dec 16, 2024 at 04:10:33PM +0000, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Use cxl api for getting DPA (Device Physical Address) to use through an
> > > endpoint decoder.
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> > > ---
> > >   drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> > > index 253c82c61f43..724bca59b4d4 100644
> > > --- a/drivers/net/ethernet/sfc/efx_cxl.c
> > > +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> > > @@ -121,6 +121,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> > >   		goto err_memdev;
> > >   	}
> > > +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
> > > +				     EFX_CTPIO_BUFFER_SIZE);
> > > +	if (IS_ERR(cxl->cxled)) {
> > > +		pci_err(pci_dev, "CXL accel request DPA failed");
> > > +		rc = PTR_ERR(cxl->cxlrd);
> > Hi Alejandro,
> > 
> > Should the line above use cxl->cxled rather than cxl->cxlrd?
> 
> 
> Hi Simon,
> 
> 
> Of course. This one has gone through a lot of eyes undetected!
> 
> 
> BTW, apart from the fact that I should use Smatch from now on :-), out of
> curiosity, is Smatch only detecting one problem each time? Because this
> patch had another flagged issue in v7.

Hi Alejandro,

It does seem that this problem was also flagged when I ran Smatch of v7.
Sorry if I didn't pass that on at the time, it would have most likely
been an oversight on my part.

In general Smatch can flag more than one problem at a time :)

