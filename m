Return-Path: <netdev+bounces-92522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67F68B7BEC
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657951F2273E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EFB14374B;
	Tue, 30 Apr 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RLYwH+Dp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41677770F2
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491626; cv=none; b=B/SjokG7E4RFGb+ij3eRe/lPIavL3mAStbLXnoQ+lU8o8XpR/EnHu/ybmtgnZBuJ8qPKTmCzPnEMR6du6aVzg2ItWaXxVLHtmv4fhmU9TlU4sZAIW5/rGRVFuXZNYLYL1uFp/WnEb2tNDcRTKK1zLdBk6BIGti3UtFGaCnnvrQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491626; c=relaxed/simple;
	bh=Kd2uGLlNLKqJ9a2/6nan6ocu5HJt0iiXyTMO0Yk0+aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrvEq1nnV98KfdzWmVrJ4gb/wJ+Hj3leFKpAcKQHoJM2ktnHQ5gcH0LLUDUmJbe/BalzynSMppc1yBAWnDSDMZjE1wo+P+VufZmQ6R4VyBGya8gz3DKCQSusC+TOWoax4rS1+LVaiFHn+6EbuMI/ndD+STB428lzfj6PFqpypjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RLYwH+Dp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c9ia+Qd3W7222wslcjcKdplaG/8RR+FF2nujhuEA0wU=; b=RLYwH+DpT2iAG6PAzqeDG9FIVC
	KMoDsvs0W2jIhRTRyaxlrgscsHmoBtaxV+OFukErjRhnOb+FOlSh2oLSOYXLAOCl0qSaUOWRkHi7i
	txupTGawteEhEzqfPyZPhu4DCNVw+zIzAakNf02xq6XAz49Z8TxTojrLgEBGH4LrhNrs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1pad-00EM6m-4M; Tue, 30 Apr 2024 17:40:19 +0200
Date: Tue, 30 Apr 2024 17:40:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v3 1/6] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
Message-ID: <42a109d3-edce-42a6-bfcc-1924bb8ef8e7@lunn.ch>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
 <20240429043827.44407-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429043827.44407-2-fujita.tomonori@gmail.com>

> diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
> new file mode 100644
> index 000000000000..fe2c392abe31
> --- /dev/null
> +++ b/drivers/net/ethernet/tehuti/tn40.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) Tehuti Networks Ltd. */
> +
> +#include "tn40.h"

> +++ b/drivers/net/ethernet/tehuti/tn40.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (c) Tehuti Networks Ltd. */
> +
> +#ifndef _TN40_H_
> +#define _TN40_H_
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>

It is not the kernel style to hide standard headers within a header
file. These includes should be in tn40.c.

      Andrew

