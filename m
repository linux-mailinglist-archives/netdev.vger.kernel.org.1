Return-Path: <netdev+bounces-88008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A902A8A5323
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27DFCB21F7C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5331D78C72;
	Mon, 15 Apr 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mvRM0w20"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA077F12
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191081; cv=none; b=W6TbE5ZkxvAMGjp0ZF8QubrM1gqv8F9oNMltyWh6kq266IVQslITbGEX//eIisF0wxfdKrsaN8vl0TJ4fcjCcHTntGCWpa3/oSYuU8CIRHraHv5/fKCx4pjywada5NHT1y08QiICkemp48bwrogYjeJpaAy4I4R3LvvzzUNam6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191081; c=relaxed/simple;
	bh=noASy/cR+85arEP/K/cKtL5z3CRtztr0o8i7Mfqu+Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXnqW2hsI4Ov9B/8vywGiCg3Y1FSKdaBZl7gOh8AfSQMBVtvsfJIjpn6T5IjLpTYjrlto/3s086rxO0dCZ0ijAktRsCsTHM2Km79s1vhjtLTUFWRfiFXlB5BYBj2X/qD3L7QVGQ6/DR437Y+9QuGucgZAGAo9C9ed51ahLb/itg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mvRM0w20; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H9D7YhVmk8eZo1BnX0OBtEVg3u10WHWtEhMYgwpgXpY=; b=mvRM0w20yZwinUzRcDrhG+7alL
	Q1WgfUENal4yinOVRYDv5toSRWFLQkh/yFX4hQRatpvVYBBOD8onsKn595kZX1SVeZFHgBpGhXUke
	CYBIG5tdaZ9u+Mi5XnHujxQOAmnoz6jKim3sfhU5Ff/2dPhAW6JY/ybvR8jkcNY/kZks=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwNG9-00D331-54; Mon, 15 Apr 2024 16:24:37 +0200
Date: Mon, 15 Apr 2024 16:24:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/5] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
Message-ID: <6c6af0a9-4113-4408-8a3c-dd95a5410d07@lunn.ch>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
 <20240415104352.4685-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104352.4685-2-fujita.tomonori@gmail.com>

> +#include "tn40.h"
> +
> +static int bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

The name space prefix generally has something to do with the driver
name. What does bdx have to do with Tehuti Network TN40xx?

      Andrew

