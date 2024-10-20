Return-Path: <netdev+bounces-137261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1396E9A5333
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 11:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3967B22F81
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 09:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D36E2C181;
	Sun, 20 Oct 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ABnqR4/D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1BA38382;
	Sun, 20 Oct 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729415027; cv=none; b=AhoMVogd3QDz2XqEF9CTiP/ZheJgNxU/ol/Gi2AysIRYsfzVgloYKkX0qqUKbZXerfVDfj1hJZJ8FssGjo0/nT3POuG02IMwAIfJRZ5Kf0UVamaVeLgX3DF5G0I7ZKSkULIvU7QjaRvcM0q1wtaqb/Mvu4vpylLLZsXGSpNaMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729415027; c=relaxed/simple;
	bh=2FqtVqGI5ALEUUBzHiKJhLOhJHZebbxW2hSGJcknpSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuoP4kKZOk/p9HGpuuSUHzfcSfysncIj9RPg4Av3Vzk7c6y47MalnIwTNDc3jNIqpy5Fa9/DPP5W+3SeW8olFXVgrX8PSj5ylm7AaWJv9bViAwNFfIwdVJpVImbOmO1w/zV7DtmWyg9QeBA5ndKIgIxE/6CzS1XGbRuOZak+/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ABnqR4/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE79C4CEC6;
	Sun, 20 Oct 2024 09:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729415026;
	bh=2FqtVqGI5ALEUUBzHiKJhLOhJHZebbxW2hSGJcknpSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABnqR4/DcIl4vZxXQEgGmlBaIwwirdWADfje4NogCAwXrfQ2PlOdhh5cbTCBeNh50
	 S4aYxT2CS/8EN1AYcU2xaSLJ1Rknk6mkQCU+NUF4A84DZFF8+J8jAkxzoNgeXk44hS
	 1KWcnM2LoTF12xlNFH9tJpS4jBuGzBG9SKFQ47I4=
Date: Sun, 20 Oct 2024 11:03:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Grosse <ste3ls@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/usb: Lenovo Mini Dock, add support for new
 USB device ID 0x17EF:0x3098 for the r8152 driver
Message-ID: <2024102054-unclog-anime-05e5@gregkh>
References: <CAPvBWb=L6FVwSk7iZX21Awez+dwhLMAoGe39f__VC=g7g6H2+g@mail.gmail.com>
 <2024102028-postnasal-cruelty-8da9@gregkh>
 <CAPvBWb=roBghdC38d59V-OBBA9Z9ACCqtAVm-S_TX9WXzuR0fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPvBWb=roBghdC38d59V-OBBA9Z9ACCqtAVm-S_TX9WXzuR0fQ@mail.gmail.com>

Oops, you sent html email to the lists, which get rejected...

On Sun, Oct 20, 2024 at 09:59:11AM +0100, Benjamin Grosse wrote:
> OMG sorry about that garbage part, it's my first time submitting a
> patch, should I resend the email (for some automatic processing or
> something) or is it easy enough to be ignored?

Also, please don't top-post :(

But yes, you do need to resend it, our tools do not strip that out.

thanks,

greg k-h

