Return-Path: <netdev+bounces-223637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FA3B59C88
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532351890F53
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA013705B1;
	Tue, 16 Sep 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc7r3J4l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9A28689F;
	Tue, 16 Sep 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037895; cv=none; b=ZV03t0MiMyw73c4VN1jRM2lz515uzFK7LgKPQkbL88W5oX3xVy6W9FpVFvI+5ZdrC/roEs3JerGUL7MfwH80wJxNSPVJ2pDyrwrN54RC4+rDa2Lljhl2S/Wtqb4uDYAcPnwDk9SbkRET2yeSctGrTAHxhp9Kc5zF0JdNFJ7FI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037895; c=relaxed/simple;
	bh=8juavChmWHBqFyDxWr5EPOHfD+FIWrNh53syoI4jNnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8fsf2ns7GuEaafZJkApDBQsHvz/Udo843CxlAXxQN98edbFaWtQ39s4soYcUR/ASB92V915mXYa7RUATwy3K735ABDdLDT3brFZ5bufvsMeW4ifYzudjLq4RLeCVJY2M6Tt4BC60cKYXVbrfGf6OnmGJbCWlXEhyZ3jtMQrTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc7r3J4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E5EC4CEEB;
	Tue, 16 Sep 2025 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758037895;
	bh=8juavChmWHBqFyDxWr5EPOHfD+FIWrNh53syoI4jNnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oc7r3J4lcgzyH4e6D1VJYr+pi5WzIgfShav1j5mvmdXXjtQCP0o5u6XXGJQpg5I3u
	 N2e2c4//obiTcEGh0EqSLoe0sdMqR9+qc6joQLjnezVBndmG2SrgNftHEtNbsHudLt
	 ErD2uzkV/49i3QN/YZ343TbJNmDYlW3QAWyAY7wrpXIY73dpiTux7PCdbz0l9VI4sz
	 8A343xccnrXLXzFrGECdhjtbsx+kZT/dxaFBrj6fvIMsoAt5t4c54Ya+iO5o8g8MIK
	 bx0wQNL4NfAdxUP5pvDk3gvvLMcNC7UXO02D8X1m1vnH5h3SIGlfWS6fZJvleKM22d
	 +ZF1ohmPFzM0w==
Date: Tue, 16 Sep 2025 16:51:30 +0100
From: Simon Horman <horms@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [v7, net-next 08/10] bng_en: Register rings with the firmware
Message-ID: <20250916155130.GK224143@horms.kernel.org>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-9-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911193505.24068-9-bhargava.marreddy@broadcom.com>

On Fri, Sep 12, 2025 at 01:05:03AM +0530, Bhargava Marreddy wrote:
> Enable ring functionality by registering RX, AGG, TX, CMPL, and
> NQ rings with the firmware. Initialise the doorbells associated
> with the rings.
> 
> Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>

...

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_db.h b/drivers/net/ethernet/broadcom/bnge/bnge_db.h
> new file mode 100644
> index 00000000000..950ed582f1d
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_db.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Broadcom */
> +
> +#ifndef _BNGE_DB_H_
> +#define _BNGE_DB_H_
> +
> +/* 64-bit doorbell */
> +#define DBR_EPOCH_SFT					24
> +#define DBR_TOGGLE_SFT					25
> +#define DBR_XID_SFT					32
> +#define DBR_PATH_L2					(0x1ULL << 56)
> +#define DBR_VALID					(0x1ULL << 58)
> +#define DBR_TYPE_SQ					(0x0ULL << 60)
> +#define DBR_TYPE_SRQ					(0x2ULL << 60)
> +#define DBR_TYPE_CQ					(0x4ULL << 60)
> +#define DBR_TYPE_CQ_ARMALL				(0x6ULL << 60)
> +#define DBR_TYPE_NQ					(0xaULL << 60)
> +#define DBR_TYPE_NQ_ARM					(0xbULL << 60)
> +#define DBR_TYPE_NQ_MASK				(0xeULL << 60)

Perhaps BIT_ULL() and GENMASK_ULL() can be used here?

...

