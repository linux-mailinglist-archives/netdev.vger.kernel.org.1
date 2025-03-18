Return-Path: <netdev+bounces-175793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F3A677A5
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFADF3A9261
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48E20E706;
	Tue, 18 Mar 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ28CrdD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2120E6F9
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311405; cv=none; b=DPU5PnbkGbEtDaEAc4FOn3pAFM8YCZOPjNlgrxtkGck2qmJ1Yz+oabuNOdHL0azWUevotirAOQtfaIN/yr3hnJGnlD2HL+kCpw9j3GdLF6O09WBtSmpkzrQXSB1EEv/jLqix1NZhLYcMNbfYuVA6vc3ELbQJEdyDDSOGEYU713M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311405; c=relaxed/simple;
	bh=NSn77dprZE47x15imTAgkQ7QqmIV6qgxr8wuRb9XVm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psVVmh7aq4KUKWcHIEsXfR3Y252mVrPXf1m4EfacQ/kDDLI8R4n/6Lbepa6YVv59I4esQeOHBpvdkyLR4j6Kop6mvB22yzoYP3HF+rptKFjF4SqVH27/dbFJ5oogRD8YrnhJLTmf6YLweDwYmk6kKMjw+CKMk+mGLw3ac7QPqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ28CrdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B59C4CEE3;
	Tue, 18 Mar 2025 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742311404;
	bh=NSn77dprZE47x15imTAgkQ7QqmIV6qgxr8wuRb9XVm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQ28CrdDjjpSQc0ea4Ta0klZCMeNKOOiMn3aYK4/BmuRdqpyvkFi4xfeoVesjB0YT
	 Oz3rf9hgLKq+6vtbF9RQ2UO3XPyFTNFVgOQMAfBZdM1N+qf/LD+vQizZuyoEMRagG1
	 mHcxRxrUFjeXvZ0fF0eB02Gx9lngBY8/IfW8TBnRo24pg0tGp6dknHETUD2qTzfL3I
	 9omlx8pZUxZ1q641SO/aavX48ElaSGUMQKR/wK38mPjo53FidPpdHeZuK+ILiaWGTA
	 4W2h0qXi/7tDkendcXrUUcPTas1t46D/976erYXqCR9637J9ztZDPpX88/QwQTvE6T
	 MfjTY2ieaLmTQ==
Date: Tue, 18 Mar 2025 15:23:19 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, jacky@yunsilicon.com,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
	kalesh-anakkur.purayil@broadcom.com, geert+renesas@glider.be
Subject: Re: [PATCH net-next v8 02/14] xsc: Enable command queue
Message-ID: <20250318152319.GD688833@kernel.org>
References: <20250307100824.555320-1-tianx@yunsilicon.com>
 <20250307100827.555320-3-tianx@yunsilicon.com>
 <20250310063429.GF4159220@kernel.org>
 <69c322e0-7e38-4ac6-b390-7a9b294261b3@yunsilicon.com>
 <c94717a8-0d96-4914-8e24-9eb2959aa193@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c94717a8-0d96-4914-8e24-9eb2959aa193@yunsilicon.com>

On Tue, Mar 18, 2025 at 06:06:07PM +0800, Xin Tian wrote:
> On 2025/3/12 17:17, Xin Tian wrote:
> > On 2025/3/10 14:34, Simon Horman wrote:
> >> On Fri, Mar 07, 2025 at 06:08:29PM +0800, Xin Tian wrote:
> >>> The command queue is a hardware channel for sending
> >>> commands between the driver and the firmware.
> >>> xsc_cmd.h defines the command protocol structures.
> >>> The logic for command allocation, sending,
> >>> completion handling, and error handling is implemented
> >>> in cmdq.c.
> >>>
> >>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> >>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> >>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> >>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> >>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> >> Hi Xin,
> >>
> >> Some minor feedback from my side.
> >>
> >> ...
> >>
> >>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
> >> ...
> >>
> >>> +static int xsc_copy_to_cmd_msg(struct xsc_cmd_msg *to, void *from, int size)
> >>> +{
> >>> +	struct xsc_cmd_prot_block *block;
> >>> +	struct xsc_cmd_mailbox *next;
> >>> +	int copy;
> >>> +
> >>> +	if (!to || !from)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	copy = min_t(int, size, sizeof(to->first.data));
> >> nit: I expect that using min() is sufficient here...
> > Ack
> 
> min(size, sizeof(to->first.data)) will lead to a compile warning.
> size is int and sizeof(to->first.data) is size_t.
> So I kept this in v9

Ack, thanks for checking.

