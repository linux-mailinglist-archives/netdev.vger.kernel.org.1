Return-Path: <netdev+bounces-91300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D352D8B2208
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 14:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A491F2420E
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884A1494D1;
	Thu, 25 Apr 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E3Ksafa7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879741494C3
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049653; cv=none; b=jiUxyerWFEu3JEnvU4td3t6jQw9m3DkXO2yoR9b8aW9Tns8XfJziCOTzb8eOYXVyCUC4NoW24vhaRF5qBngkMkvJvtmje/QAvwU3tvjZFJiqz0RLM9MjD14YgJywjMGSOGPHvqtBfGUF3v6KjAAOMJWDuwGdyp6N6coon/4ErxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049653; c=relaxed/simple;
	bh=4Y9zQf6Y/4P9ssIMmnjME/mV9Gt9hLsKZvQ7C0EgI8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sShtIz/EenVvoCxB71OSvSkSb6WfNFfNMOZ0I67QgGyK1wqKi69NLddXFJIZ6JzXaFcfztatukRhnF2Ax3TKHXiftNoPt/IX7wlRlRuyoatDPx58OaFD31P1WSYPPX7GW5smFrvIAEo5HjgIu5YL6+wCN5CbzsXJ/JBb8VkZgGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E3Ksafa7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dfx44uPwnpl8vb9PB+owbd7WACRF7aT5W/pLet1/vk4=; b=E3Ksafa7rG8AULvIsDAltESaQa
	Lu8TLNbjBqYquxJMq6MqJUbkOq0LtCHQfpIRejZx9ZcU7bGwsxyIpmeU4WseXqNch0y3NvDDeC9f1
	3X91jwCBTroy9PaaofLn7msdGlv1ZWEuXb5wYZKGxGQcCEq5MhMoM3bzqK0faWYS24gw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzyc5-00Dz0w-1x; Thu, 25 Apr 2024 14:54:09 +0200
Date: Thu, 25 Apr 2024 14:54:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next v2 1/6] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
Message-ID: <966aaf2a-a21c-4e8f-9ddd-a4541cfc94d2@lunn.ch>
References: <20240425010354.32605-1-fujita.tomonori@gmail.com>
 <20240425010354.32605-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425010354.32605-2-fujita.tomonori@gmail.com>

> +#define TN40_DRV_VERSION "0.3.6.17.2"

A version is generally a bad idea. What does this version even mean,
given that you are re-writting the driver? You might as well call it
0.0.0.0.0.

We recommend that for ethtool, you leave the version field
untouched. The core will then fill it with the kernel version. That
version makes sense, since it gives you both the driver and the kernel
around it.

       Andrew

