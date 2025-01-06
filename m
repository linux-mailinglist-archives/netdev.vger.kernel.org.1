Return-Path: <netdev+bounces-155309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA704A01CF6
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 02:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E83A048A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 01:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A44735942;
	Mon,  6 Jan 2025 01:09:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DC12DAD2F;
	Mon,  6 Jan 2025 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736125777; cv=none; b=YMf0kfDJIOmvd7RvrDuns0nVh2tfKnkgRwXzn0WOvp389+58wfjHM6v6we2Av801opmYpPa67mXHS6CMbEYjBFQ9q2C0TI96JcYZ+CxV4ftSbZrWFgye5ApCWruncZLucvyzYLEeIk0JLWLmQ7zc720dza4+qRERJ77s2qJOt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736125777; c=relaxed/simple;
	bh=z9TQn+wR6GDTo6Lh2u6wPkBV3RfvghSf7MDcSQWyP6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=WFiWsBZXhgDOVRWOWIXzDAQFKh4hJvWMGqFgiC7aCagkUlk68Zz1ewrqQEyEhHmqRckxDedb8d28lZBx5bBMYXGe8AOBWIBlwthg5NXHaqDp/ZVAQhCW3ahkr5j5TJg3SB5QlQJdcVBy+xq5k3ea0zZbc/SaEH9bWL+wPLgOU38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id BA73260107568;
	Mon,  6 Jan 2025 09:08:58 +0800 (CST)
Message-ID: <793c3449-ba5c-9aef-90e4-1515e85cd822@nfschina.com>
Date: Mon, 6 Jan 2025 09:08:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2] eth: fbnic: Avoid garbage value in
 fbnic_mac_get_sensor_asic()
To: Jakub Kicinski <kuba@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Su Hui <suhui@nfschina.com>
Cc: alexanderduyck@fb.com, kernel-team@meta.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
 kalesh-anakkur.purayil@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Language: en-US
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <20250103100737.1f329212@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/1/4 02:07, Jakub Kicinski wrote:
> On Mon, 30 Dec 2024 08:52:49 -0800 Jakub Kicinski wrote:
>>> It is more like removing broken functionality than fixing (maybe whole
>>> commit should be reverted). Anyway returning not support is also fine.
>> I defer to other maintainers. The gaps are trivial to fill in, we'll
>> do so as soon as this patch makes it to net-next (this patch needs to
>> target net).
> Having slept on it, I think you're right.
>
> Su Hui, could you send a revert of d85ebade02e8 instead?
> It's around 126 LoC, not too bad.

OK, I will send v3 to revert d85ebade02e8 soon.

Su Hui


