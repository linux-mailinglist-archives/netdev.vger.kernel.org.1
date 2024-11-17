Return-Path: <netdev+bounces-145670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AFD9D05BA
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF901F216B8
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 20:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8094C1DB551;
	Sun, 17 Nov 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ft3vuJ6F"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1542C1DA116
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731874746; cv=none; b=OVZb+2rCqodHnlTWlbcBfEoLKww+ou1NGq//kW8y0H/PzDj6XJbvpIWAg6E3hry8TvltVolQPGCuhY/U3kcqIaXm5s4KBUyV2n7VNPkrFhTjM9brM7cQOAX5hbZ9SnNOzv3bcYvV9LnqPh2LfqB06sxGacLK6QjvOYKxHyPZ+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731874746; c=relaxed/simple;
	bh=+U8mlBn0TYsqHVHpjyE8SFPumhoE4+BBj15UaG1mS2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1JyitILdK/bF1NNM6bhU+jFcT9pDmXweMnQe/7oYTF4YKtC/GsoYNUo0ywMhjI3WnyMX18KsVb28KLHaMdy1n676QDNFhTr8hCuNId8B7xgc9/mLAkVzofSxsxrdoslMU6WqLUVbXANDhBJPxWdfZTxirZFPqMRTORZ8KevrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ft3vuJ6F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qaG3qaMEiySHAE3tz6+LhoNg1EXWW9SYLDw7qQrHdPg=; b=ft3vuJ6FsFhYywMuXsg9DuF/Dv
	uQ4c1IDckUogEduSM7doHPJgW7B5f8jI2V8L6HoojJ3aVC3ucJiHUXptzy/P9Se0b09WJRjbRuVPD
	sC1bG1Uwe0HfW0UcOPrnfqIO0P1aO3Js8VFUY0T2QWMCv3I471zoygofHDwHyROBLj9I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tCljY-00DbLl-8r; Sun, 17 Nov 2024 21:19:00 +0100
Date: Sun, 17 Nov 2024 21:19:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, alexanderduyck@fb.com,
	Sanman Pradhan <sanman.p211993@gmail.com>
Subject: Re: [PATCH net-next 4/5] eth: fbnic: add PCIe hardware statistics
Message-ID: <1ed2ba1e-b87f-4738-9d72-da7c5a7180e2@lunn.ch>
References: <20241115015344.757567-1-kuba@kernel.org>
 <20241115015344.757567-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115015344.757567-5-kuba@kernel.org>

> +/* PUL User Registers*/
> +#define FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0 \
> +					0x3106e		/* 0xc41b8 */

Is there a comment somewhere which explains what these comments mean?
Otherwise they appear to be useless magic numbers.

> +static void fbnic_hw_stat_rst64(struct fbnic_dev *fbd, u32 reg, s32 offset,
> +				struct fbnic_stat_counter *stat)
> +{
> +	/* Record initial counter values and compute deltas from there to ensure
> +	 * stats start at 0 after reboot/reset. This avoids exposing absolute
> +	 * hardware counter values to userspace.
> +	 */
> +	stat->u.old_reg_value_64 = fbnic_stat_rd64(fbd, reg, offset);

I don't know how you use these stats, but now they are in debugfs, do
they actually need to be 0 after reboot/reset? For most debugging
performance issues with statistics, i want to know how much a counter
goes up per second, so userspace will be reading the values twice with
a sleep, and doing a subtractions anyway. So why not make the kernel
code simpler?

     Andrew

