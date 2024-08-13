Return-Path: <netdev+bounces-118176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA6950DAB
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52DFB280E9
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166941A4F11;
	Tue, 13 Aug 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="imJ9oOJ4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838444C61
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579902; cv=none; b=eNNsuOFY4AkACTlsm7Zpm7k8DmW+Vphyp8PgDUUieGwDUiKTQnI0PxHN02o/aiQQ/MsHPqHMbFzMt3hrbcnQBeeQaVvw6Pk/UBux317XjnrS8UeFiFCtNO1A1fqZFc+xO+wuYN9q2IJvc+++U96VYOuXZ7usUva9ZZ9xMnEuUSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579902; c=relaxed/simple;
	bh=VYxU0sDs9fMLXzXxOk8nbDUAVvfeP6UWRyZlMynoy4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiVOzWxESrvjqjM0s/fedroNwYEkuHGxRM03MjsYal9YOfYwVN9SBa7Qu75bs3CCbMslHm4zQAWN3Ko2SXyTGblYuy446EcjmlJBIfLyxgvLiTj6HSC3/YbLse3g/tCn3n7oyV0yl2J5qH+r9nMe9qU100mmPjIq8pD67vV28Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=imJ9oOJ4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yOmu0YmhhXxaLvdqrwjFj56X6NnCjjMHZ3c02zC91d0=; b=imJ9oOJ4ASnbe8DmpMtrk62PNq
	P/3/7Hy3GaSt6/22ss5+eqTQ8CA0n5wojOQHJz0NUuAN8vRxn/RoGJC4PKiQ+b8bpSHqqQzXS+nKW
	Ca2zz3GzfcmmsNjf2jqFYCvF0+I3dx9yRbM6e56clq1bki3RFE5Y+WQo8NJdy2dRjAus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdxbi-004i6p-KT; Tue, 13 Aug 2024 21:55:02 +0200
Date: Tue, 13 Aug 2024 21:55:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Martin Whitaker <foss@martin-whitaker.me.uk>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, ceggers@arri.de,
	arun.ramadoss@microchip.com
Subject: Re: net: dsa: microchip: issues when using PTP between KSZ9567
 devices
Message-ID: <d42582f2-28c0-4a77-b4bc-1e5b31d9eedb@lunn.ch>
References: <7aae307a-35ca-4209-a850-7b2749d40f90@martin-whitaker.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aae307a-35ca-4209-a850-7b2749d40f90@martin-whitaker.me.uk>

> Issue 3
> -------
> When performing the port_hwtstamp_set operation, ptp_schedule_worker()
> will be called if hardware timestamoing is enabled on any of the ports.
> When using multiple ports for PTP, port_hwtstamp_set is executed for
> each port. When called for the first time ptp_schedule_worker() returns
> 0. On subsequent calls it returns 1, indicating the worker is already
> scheduled. Currently the ksz_ptp module treats 1 as an error and fails
> to complete the port_hwtstamp_set operation, thus leaving the
> timestamping configuration for those ports unchanged.
> 
> (note that the documentation of ptp_schedule_worker refers you to
> kthread_queue_delayed_work rather than documenting the return values,
> but kthread_queue_delayed_work returns a bool, not an int)
> 
> I fixed this issue by
> 
> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c
> b/drivers/net/dsa/microchip/ksz_ptp.c
> index 4e22a695a64c..7ef5fac69657 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -266,7 +266,6 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
>         struct ksz_port *prt;
>         struct dsa_port *dp;
>         bool tag_en = false;
> -       int ret;
> 
>         dsa_switch_for_each_user_port(dp, dev->ds) {
>                 prt = &dev->ports[dp->index];
> @@ -277,9 +276,7 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
>         }
> 
>         if (tag_en) {
> -               ret = ptp_schedule_worker(ptp_data->clock, 0);
> -               if (ret)
> -                       return ret;
> +               ptp_schedule_worker(ptp_data->clock, 0);

This looks correct. Please could you submit a formal patch?

https://docs.kernel.org/process/submitting-patches.html
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

	Andrew

