Return-Path: <netdev+bounces-227072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ECBBA7EEA
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 06:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D7E3B8612
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 04:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22341F5433;
	Mon, 29 Sep 2025 04:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC0a7SHn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710333F9;
	Mon, 29 Sep 2025 04:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759119838; cv=none; b=KfmIm2DxdssUEtpNRG+x7FP7wp6QyR76Adq/HW+nkG14J3FtOdiTdKgAMJ6sOExKoQ+GPuWTF6WjOhMl/vV0j5bNlQP8NaFt35/0i25HhDBvzXyefC60xXtY2bfyCEkUPVauQedA0pmli17+RJR8vIz2ilXvVXs8fHkz3nI0GMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759119838; c=relaxed/simple;
	bh=+1YNLxg2avr4KjleA/PdfbQqRc6bmj4olzvcG6fj0gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWIdtKXsp+lQv145VqsWNqHnv3Qzj99fKQx5DGWi35U3j3tePT2kzoGacvANUfr9VwwHtBWP0nM9j9GBH/Tgjve+KxJF6r4EbF9CYZ6apJZ6N1Q10UbQ0XUcMnJW7H12MRHTeSwydewbpmUd9iSFGcjZCu7t7vbq4n8MQbZiMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC0a7SHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC84CC4CEF4;
	Mon, 29 Sep 2025 04:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759119838;
	bh=+1YNLxg2avr4KjleA/PdfbQqRc6bmj4olzvcG6fj0gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AC0a7SHnoIQcydziwGeEP2JLx/RXO3tHmMyLZX3zYicXxW6oAEvBscIRXRZwqmMy+
	 M+AX19T8zrUoav4TYP6woz7wqLV/0+eR10MnzjWab7tv1yx9qcwYVdP4syreZsORv1
	 x4RCOcQMPxhao9rVFGpDNtX4HX6NRU5cD9Mq9aVF+plobekRxuaJjSmr4jOAOyqpXc
	 oKmjLLMhJuo8UzesnZcIjXwO1iPsIeiw5wauvzjjvVl2xBr715+xHAYhiGtw9iYfA9
	 juee3C1YAOsIQdyPeLXHoPFV+cvShmn3OwIMOzpvGnMHQwsGds0BLFvaSIKXcZ8JGR
	 f4N2Kk1SeruRQ==
Date: Sun, 28 Sep 2025 21:23:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: yicongsrfy@163.com
Cc: oliver@neukum.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, marcan@marcan.st, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, yicong@kylinos.cn
Subject: Re: [PATCH 2/2] net: usb: support quirks in usbnet
Message-ID: <20250928212351.3b5828c2@kernel.org>
In-Reply-To: <20250928014631.2832243-2-yicongsrfy@163.com>
References: <20250928014631.2832243-1-yicongsrfy@163.com>
	<20250928014631.2832243-2-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 09:46:31 +0800 yicongsrfy@163.com wrote:
> +	const struct usb_device_id *match = usb_match_id(intf,
> +							 usbnet_ignore_list);
> +
> +	return match == NULL ? false : true;

coccicheck says:

drivers/net/usb/usbnet_quirks.h:40:24-29: WARNING: conversion to bool not needed here

this function could be simply:

{
	return !usb_match_id(intf, usbnet_ignore_list);
}

