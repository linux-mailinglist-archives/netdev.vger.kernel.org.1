Return-Path: <netdev+bounces-131567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0859A98EE19
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD01F2832FB
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855D515443C;
	Thu,  3 Oct 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mqhirmrd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B44154434
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954793; cv=none; b=R5P0cdKxL9gtPBKsesd/foOoNxlQTOv17gTo852lRcv0dbKCyC4a68KZY0UpxqFoBHqFDlD9oEveFyClp6N3PMUptRY3867uukW2LQdgZb/9TEahPyEQXACJPA/n6wW19jYRIF6niVF5NafjEJkJh6GU9Cvhd2r4KM+n0++gn6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954793; c=relaxed/simple;
	bh=JMt/TloB0hYKVyJSxoCeU5XhLbd2/0Gg0/YIX5x56uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSrBmQI4lx+Qvuk2QxDgJ6cwpSSQcldHBDGqe4QttOGIS85PuHLLjXR0SgPVXXEHq1zkq4TVuYLE/6r+dp6w/UcID0AgQ5C5xTvN8WJss6vWtVIkPUF8dyhLV8A/AKSGSCpodCracIL5yHxSljKxxZp1iPXgINdbfJfsJR8+/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mqhirmrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8816CC4CEC5;
	Thu,  3 Oct 2024 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727954792;
	bh=JMt/TloB0hYKVyJSxoCeU5XhLbd2/0Gg0/YIX5x56uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqhirmrddhWR4F8YVG0JAh9ANwQmPK4Z2Sa7Ccv+/sg2gcF8tYRY4isqUqrt6nvKH
	 RVCtUbSHoZm5ijY1xdSQfYdx+7czoBZ1kliUFwsCKD4jp+bZ7HtlJi/o1BrPKG7KPi
	 6x5RtjDdWSbWZlaLgBs1i7e7nB9zCSIA8TlVUL1Vk1cDyN5914YfzoR7zQGVCvSn7X
	 1FPlunSGtqX3LCUPZhbzZY96R/cT1PYSO37eU2LdBepxIhZUvewwwxI66v+EPblIr2
	 RjhDYdk+bOMeC6vwp1sWO1QpekI/fkX1go7luOrM/EQbzVRD3MC+yt0oMak2kUwARq
	 rJUZOadLHr+Wg==
Date: Thu, 3 Oct 2024 12:26:29 +0100
From: Simon Horman <horms@kernel.org>
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] Create netdev->neighbour association
Message-ID: <20241003112629.GL1310185@kernel.org>
References: <20241001050959.1799151-1-gnaaman@drivenets.com>
 <20241001050959.1799151-3-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001050959.1799151-3-gnaaman@drivenets.com>

On Tue, Oct 01, 2024 at 05:09:57AM +0000, Gilad Naaman wrote:
> Create a mapping between a netdev and its neighoburs,
> allowing for much cheaper flushes.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>

Hi Gilad,

As per my comment on patch 1/2, This is not a full review, but rather some
feedback to take into account once a proper review arrives.

...

> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst

...

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h

...

> @@ -2399,6 +2400,8 @@ struct net_device {
>  	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
>  	struct dim_irq_moder	*irq_moder;
>  
> +	struct hlist_head neighbours[NEIGH_NR_TABLES];
> +

Please add an entry for neighbours in the Kernel doc for this
structure, which is immediately above it.

This is flagged by ./scripts/kernel-doc -none, and W=1 allmodconfig builds.

>  	u8			priv[] ____cacheline_aligned
>  				       __counted_by(priv_len);
>  } ____cacheline_aligned;

...

