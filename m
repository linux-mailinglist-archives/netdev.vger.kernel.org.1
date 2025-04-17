Return-Path: <netdev+bounces-183826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C24A9226A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F89A3A372D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D60254862;
	Thu, 17 Apr 2025 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3t5H8dG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17841F463D;
	Thu, 17 Apr 2025 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906440; cv=none; b=loAt+4f2GN+ARWQB7wJcFZBGoBsqpj4DS/S/kLNRXaAnndQG5GoD7MVcDFrZAIno0vqdb+E4eXWT1W96MnxdwhB3ws94CFkrE7rTZx2nHP/QI2Or8RirnIQyR3CQt/+cqboqLWiqBWybRyM5rc3TSF+htgvnmjBOFrFRFiu98sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906440; c=relaxed/simple;
	bh=dF5zKEgbrCzKFWBhVkcf46aE/op9JDA8TSByk+hkA4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVCvlmd/aBVNAd6B/nZWXmrjPbNg/lt1KasP5hwY6CN6GG2qNzR0z1jW6QRA7kdaXqEdsC1tn4rvfeTxH9RaXUH/h5CqmkBEAzKjvKTqLE5/s7jJLYyoqAoTybi8a/lYPz1ZX5XoXS/Rz3apjfTf5mN271cDIwFG70mUE37OHUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3t5H8dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F09C4CEE4;
	Thu, 17 Apr 2025 16:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744906440;
	bh=dF5zKEgbrCzKFWBhVkcf46aE/op9JDA8TSByk+hkA4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3t5H8dGUaUqklAbXEvHhseo4XcV2hw4gHpfEy/k0DfICyQ3QTeK21zwgNv0rV/u0
	 yl4kozrNVlNxW2kq+kVmAR5w7Y8GfVOCnqpfhjQO2DMMT3/wPB8A+18HYYd+9ZhgHv
	 kjF4qe+Cwcnh136y2EZQEOJm/myjBBo+YpxCbZ/erXNsTh8As0oGeQUdtWuTGEj3A7
	 5ADgnr/fInKHi5oIvH0T4+pfhbJa9nKFGRF/e34RW0X1h9HdqNn9JsT5EKKgJuw5p6
	 crYScCIzN2fcDXjTWcuQcgQz1PWP4SPzdMRjkpKz2runtZ+i5KFLZXaWQG7T32zqNh
	 RgGYGohFwDnhw==
Date: Thu, 17 Apr 2025 17:13:54 +0100
From: Lee Jones <lee@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <20250417161354.GF372032@google.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-6-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416162144.670760-6-ivecera@redhat.com>

On Wed, 16 Apr 2025, Ivan Vecera wrote:

> Registers present in page 10 and higher are called mailbox type
> registers. Each page represents a mailbox and is used to read and write
> configuration of particular object (dpll, output, reference & synth).
> 
> The mailbox page contains mask register that is used to select an index of
> requested object to work with and semaphore register to indicate what
> operation is requested.
> 
> The rest of registers in the particular register page are latch
> registers that are filled by the firmware during read operation or by
> the driver prior write operation.
> 
> For read operation the driver...
> 1) ... updates the mailbox mask register with index of particular object
> 2) ... sets the mailbox semaphore register read bit
> 3) ... waits for the semaphore register read bit to be cleared by FW
> 4) ... reads the configuration from latch registers
> 
> For write operation the driver...
> 1) ... writes the requested configuration to latch registers
> 2) ... sets the mailbox mask register for the DPLL to be updated
> 3) ... sets the mailbox semaphore register bit for the write operation
> 4) ... waits for the semaphore register bit to be cleared by FW
> 
> Add functions to read and write mailboxes for all supported object types.
> 
> All these functions as well as functions accessing mailbox latch registers
> (zl3073x_mb_* functions) have to be called with zl3073x_dev->mailbox_lock
> held and a caller is responsible to take this lock.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> v1->v3:
> * dropped ZL3073X_MB_OP macro usage
> ---
>  drivers/mfd/zl3073x-core.c       | 232 +++++++++++++++++++++++
>  include/linux/mfd/zl3073x.h      |  12 ++
>  include/linux/mfd/zl3073x_regs.h | 304 +++++++++++++++++++++++++++++++
>  3 files changed, 548 insertions(+)

> +/*
> + * Mailbox operations
> + */
> +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index);

Why aren't these being placed into drivers/mailbox?

-- 
Lee Jones [李琼斯]

