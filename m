Return-Path: <netdev+bounces-96528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082238C6521
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BB028179A
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F675F47D;
	Wed, 15 May 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfjiadzY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE85EE67;
	Wed, 15 May 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770160; cv=none; b=QfyQtAMUZ+3QPlI6kdlMn6mKDTDDVc67DabQFpeMBQxmJICb3IOkmlvdalaMSbpH5XtaP8CEebP3ErGtLj+mKXjTGojXJT4lGmxW0/VL68kpqyBD0zmRH+hNI7P1M4mMqkJOB2C1+BkEzsw2IXb4xHntjEBWQC77U7Bt0mKofYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770160; c=relaxed/simple;
	bh=eZAyx5iTU3+yTtK+BTheHtFXAm3+sugNJ4tGK3cekzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lmvts8uhQdj6rBdb5PXh5rDkbmPfwS1h8tkuxdUXraomFwH3u8l5miBWencLvPhoPzBqDUYmJdl4m+MzDcdY5nAZb7DL0N/CO1BDtvcNXzHGJ8Qc4LqI1U5id18i3zcouqTe1h0AFKLLeGbHrzxu6IhBp7hPWuZ+XblnF1UOzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfjiadzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F07C116B1;
	Wed, 15 May 2024 10:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715770160;
	bh=eZAyx5iTU3+yTtK+BTheHtFXAm3+sugNJ4tGK3cekzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfjiadzYc0Ni5F6hqm5RXpiqACkDCI7cbL0UjZMj9KOLXCmvOHqK3PRXKUuKPP0yz
	 s3x5bzvQAwrfFpt3JgrxhF3zRilfLHC9QGhk16hUznJyKA2Q8jGAMUgBXGSh+m7Z91
	 DDhFiKzURsSbxqPAMcISjvO+J9a8Y6t/x/M0tikzAISNbeBGlHrtXXGEbzXB+Qb0mv
	 MeMpcmjjvKfgN3u0xX2ROzZulbOeuuzWx2pLirrHJgbqNc4pht8lq9kFV0gCOgFJO+
	 d7brvsm80y5ZM9n277aL2YQq1fD9qcaNXAji6M0W7g6eFfkLlFpTeShX/QcvSuH9xj
	 C0BQGsnG4Q3ig==
Date: Wed, 15 May 2024 11:49:16 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/4] vmxnet3: update to version 9
Message-ID: <20240515104916.GG154012@kernel.org>
References: <20240514182050.20931-1-ronak.doshi@broadcom.com>
 <20240514182050.20931-5-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514182050.20931-5-ronak.doshi@broadcom.com>

On Tue, May 14, 2024 at 11:20:49AM -0700, Ronak Doshi wrote:
> With all vmxnet3 version 9 changes incorporated in the vmxnet3 driver,
> the driver can configure emulation to run at vmxnet3 version 9, provided
> the emulation advertises support for version 9.
> 
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Acked-by: Guolin Yang <guolin.yang@broadcom.com>

...

> @@ -4019,42 +4019,14 @@ vmxnet3_probe_device(struct pci_dev *pdev,
>  		goto err_alloc_pci;
>  
>  	ver = VMXNET3_READ_BAR1_REG(adapter, VMXNET3_REG_VRRS);
> -	if (ver & (1 << VMXNET3_REV_7)) {
> -		VMXNET3_WRITE_BAR1_REG(adapter,
> -				       VMXNET3_REG_VRRS,
> -				       1 << VMXNET3_REV_7);
> -		adapter->version = VMXNET3_REV_7 + 1;
> -	} else if (ver & (1 << VMXNET3_REV_6)) {
> -		VMXNET3_WRITE_BAR1_REG(adapter,
> -				       VMXNET3_REG_VRRS,
> -				       1 << VMXNET3_REV_6);
> -		adapter->version = VMXNET3_REV_6 + 1;
> -	} else if (ver & (1 << VMXNET3_REV_5)) {
> -		VMXNET3_WRITE_BAR1_REG(adapter,
> -				       VMXNET3_REG_VRRS,
> -				       1 << VMXNET3_REV_5);
> -		adapter->version = VMXNET3_REV_5 + 1;
> -	} else if (ver & (1 << VMXNET3_REV_4)) {
> -		VMXNET3_WRITE_BAR1_REG(adapter,
> -				       VMXNET3_REG_VRRS,
> -				       1 << VMXNET3_REV_4);
> -		adapter->version = VMXNET3_REV_4 + 1;
> -	} else if (ver & (1 << VMXNET3_REV_3)) {
> -		VMXNET3_WRITE_BAR1_REG(adapter,
> -				       VMXNET3_REG_VRRS,
> -				       1 << VMXNET3_REV_3);
> -		adapter->version = VMXNET3_REV_3 + 1;
> -	} else if (ver & (1 << VMXNET3_REV_2)) {
> -		VMXNET3_WRITE_BAR1_REG(adapter,
> -				       VMXNET3_REG_VRRS,
> -				       1 << VMXNET3_REV_2);
> -		adapter->version = VMXNET3_REV_2 + 1;
> -	} else if (ver & (1 << VMXNET3_REV_1)) {
> -		VMXNET3_WRITE_BAR1_REG(adapter,
> -				       VMXNET3_REG_VRRS,
> -				       1 << VMXNET3_REV_1);
> -		adapter->version = VMXNET3_REV_1 + 1;
> -	} else {
> +	for (i = VMXNET3_REV_9; i >= VMXNET3_REV_1; i--) {
> +		if (ver & (1 << i)) {
> +			VMXNET3_WRITE_BAR1_REG(adapter, VMXNET3_REG_VRRS, 1 << i);

nit: Please consider using the BIT() macro.

> +			adapter->version = i + 1;
> +			break;
> +		}
> +	}
> +	if (i < VMXNET3_REV_1) {
>  		dev_err(&pdev->dev,
>  			"Incompatible h/w version (0x%x) for adapter\n", ver);
>  		err = -EBUSY;

