Return-Path: <netdev+bounces-225305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60842B920AF
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050CF7A5928
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7D0302149;
	Mon, 22 Sep 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="peEGMHQ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C424DCEF
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556076; cv=none; b=B8aLkY1TS4pm/oOaEuf0gnZ3V+pZDgAjYgnt3gJtvYDGEJL/vT7MIR+uFXw77njCW/QnDhjZz2m/+z9/dgWD62XjmQZxvIpu+ksdJHK3lPx/uwivOvuM2RgkUr9Lg5qtVm1cVYarzTcgYzNIxx7jOhfxilOes0oEBWPsxyEjdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556076; c=relaxed/simple;
	bh=p8dGjIvELLqUwSneKb4V0JgYa4NvVZ5jWq+twYWX8M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVbOWqRqVfTAtV78KI8nf0ZPRx8vlAduuV/ZP56P30rSh/OhkTAX/A/XISWUnJoDcP+FMEjgwtEBSxq136TAx3ETP1NYlTvb2MHxbMEG0HZNfu4oaSJsZ9tjWtVJHiixBKONYHnNPOugjh5FaPRSSWZF2UaA3C6bbGQPVnKhum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=peEGMHQ/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8A5341A0F30;
	Mon, 22 Sep 2025 15:47:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E24160635;
	Mon, 22 Sep 2025 15:47:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DAB8102F1942;
	Mon, 22 Sep 2025 17:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758556071; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=5rWLXBJqsnecYedgGyIBaJrE9fWl5bXsub6l1YvDXgk=;
	b=peEGMHQ/mVcW/QinnHqxenxLVxtYomQrZVeCAC2FBZAFmKNfP58hnOU6d3V8+YhhkqhcHA
	OPhBGuzRnskaFGM8dVI4NrNqzjFQv0ixKhbg0FDJz7ZDxm30WY+fjbmBYZqNt1NK48ja/c
	+VfADwq08c0KFgUpVO511WaMKnR0O/MqX7b4QVxWd0PgrdaFQho7/8AWUm2MKTC2llrvkE
	ziHP1+EvNU6dU0/sZrJZWZHbqxeqp9yk5JCJJ3a1rgKbbDcwiD0NRb2IqlkTmyBLqumnnb
	ZaQX9cSw1gf7gtoFcpSQdj815hozDNMsqdl+B2uMwzsTBSb/QdM1CY1bPTU68g==
Message-ID: <c07c2263-3276-4c9c-a0c0-7a8c9580a4cf@bootlin.com>
Date: Mon, 22 Sep 2025 21:17:32 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: dp83640: improve phydev and driver
 removal handling
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Richard Cochran <richardcochran@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b86c2ecc-41f6-4f7f-85db-b7fa684d1fb7@gmail.com>
 <6d4e80e7-c684-4d95-abbd-ea62b79a9a8a@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <6d4e80e7-c684-4d95-abbd-ea62b79a9a8a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Heiner,

On 21/09/2025 03:03, Heiner Kallweit wrote:
> Once the last user of a clock has been removed, the clock should be
> removed. So far orphaned clocks are cleaned up in dp83640_free_clocks()
> only. Add the logic to remove orphaned clocks in dp83640_remove().
> This allows to simplify the code, and use standard macro
> module_phy_driver(). dp83640 was the last external user of
> phy_driver_register(), so we can stop exporting this function afterwards.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Nice simplification ! I've scratched away the small amount of hair left 
on my head reading this, and your changes look correct to me :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


