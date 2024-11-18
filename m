Return-Path: <netdev+bounces-145903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096AA9D14B8
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30531B2A0FC
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436381AC45F;
	Mon, 18 Nov 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7uQD4iJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB851A9B3D
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944103; cv=none; b=AKl0WdM1RFGlguvWLPIMckMAYSzwaqvIB18DDLa8YfYDwfOeFOdO6+7mSd9uk7v1WgHSzpd1ZF5/lZHsCWzfMGrv0bPK7K2iG1u6TWfdbIo+KB2q7TVL17ucfmGeyUF+hFmcGNJfXdvAbHgvXbkVy5UbsCgRPRbd4e1m9mE8rQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944103; c=relaxed/simple;
	bh=7pp04Y0ooCV1SNt28H7wvT/MMWqYI/3yIIEGxJN6g2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awi9/fyvnHTq2j0fRw37GpAwJ/S/KpsJYZR0Hdsm0VC8wpeuPr7RssHLcys5mV0RYNm28NHE50An2VsxKyyB9Zz/aJJt2L99OvB9tqyO/AiWlGBV5rc/ab8Wbt+qkFkUYtUef/FOrRaduvq8+OE3f8PiWINzygdw/8iz40EsAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7uQD4iJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C85EC4CECC;
	Mon, 18 Nov 2024 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731944102;
	bh=7pp04Y0ooCV1SNt28H7wvT/MMWqYI/3yIIEGxJN6g2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g7uQD4iJPyp2J8/5+vRliJxSn1Rrc0RfmMYP6yPhHaVRjqe7REeKrJvk3QN09DCX5
	 n/n6ZcSNW9obN9BDDdEv6+WuuEx9aFB1dXNUYCeVj8V8LjYCx88TvUwFSL0CDdmexl
	 gGu8LqBLcINP7qC8/iF6iN+jb0RN4jGeYjaGjnQnBm99BPY8qECyamlChe1AE81nFs
	 UsI76iKv4xlW6kyYh22qdw9BIbnzF7nItMGOgJ/mQFjq87LTEjnlAYYZKF0JvM5HKW
	 trGXZ74SAa4hXoNwD6dSCri0fMLTt2yYJn0bTe32fuKVcbt2B6BgZNWCHwHQc+2L4z
	 ox3Tt2TiCkGaA==
Date: Mon, 18 Nov 2024 07:35:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, alexanderduyck@fb.com, Sanman Pradhan
 <sanman.p211993@gmail.com>
Subject: Re: [PATCH net-next 4/5] eth: fbnic: add PCIe hardware statistics
Message-ID: <20241118073501.4e44d114@kernel.org>
In-Reply-To: <1ed2ba1e-b87f-4738-9d72-da7c5a7180e2@lunn.ch>
References: <20241115015344.757567-1-kuba@kernel.org>
	<20241115015344.757567-5-kuba@kernel.org>
	<1ed2ba1e-b87f-4738-9d72-da7c5a7180e2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 21:19:00 +0100 Andrew Lunn wrote:
> > +/* PUL User Registers*/
> > +#define FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0 \
> > +					0x3106e		/* 0xc41b8 */  
> 
> Is there a comment somewhere which explains what these comments mean?
> Otherwise they appear to be useless magic numbers.

The number on the left is the number on the right divided by 4.
We index the registers as an array of u32s so the define is an index,
but for grep-ability we add the absolute address in the comment.

> > +static void fbnic_hw_stat_rst64(struct fbnic_dev *fbd, u32 reg, s32 offset,
> > +				struct fbnic_stat_counter *stat)
> > +{
> > +	/* Record initial counter values and compute deltas from there to ensure
> > +	 * stats start at 0 after reboot/reset. This avoids exposing absolute
> > +	 * hardware counter values to userspace.
> > +	 */
> > +	stat->u.old_reg_value_64 = fbnic_stat_rd64(fbd, reg, offset);  
> 
> I don't know how you use these stats, but now they are in debugfs, do
> they actually need to be 0 after reboot/reset? For most debugging
> performance issues with statistics, i want to know how much a counter
> goes up per second, so userspace will be reading the values twice with
> a sleep, and doing a subtractions anyway. So why not make the kernel
> code simpler?

Right, there is no strong reason to reset debugfs stats. OTOH
consistent behavior across all stats is nice (from rtnl stats 
to debugfs). And we will need the reset helpers for other stats.
Meta uses a lot of multi-host systems, the NIC is reset much
less often than the machines. Starting at 0 is convenient for 
manual debug.

