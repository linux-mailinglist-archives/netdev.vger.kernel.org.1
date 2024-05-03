Return-Path: <netdev+bounces-93354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46608BB490
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3381C22F17
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66206158A07;
	Fri,  3 May 2024 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="kJOUuEZZ"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F41509AB
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767258; cv=none; b=fUcCBYb6iFHg5sxihzT+3iqi9ZDZRH8wMov7iJeZF20BkH++jkcrrIj8rJXelunYVowM2teMR6YTQq+LxCHHGOKHTCv3H1DqRn8T/VVmHpOeTIChGUoGeIsWN3ZvVlKzRufIsON4uK/vXhMhTZa04aZl5H8nJ93a5BjxMF8rr6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767258; c=relaxed/simple;
	bh=Qcg7eflHIxQk4jSI9NFTGP/XGw/RF+ah22Oriae+9CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWlWdl7+2YPL1mAH2oCz/xIjDDPDVWvc0t+FPD/j8p6/Z15re4y1DcMY6uOW4iSS7avXQhlMoWxuiPR5ZHc/xDH55XLhp5Msp1dIJb3JLidtrjjxnePeEb7rdpmle8atw9arcXzgDxgK5DdfhzifpTgh7+fvU4KEGMIQjBS3nLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=kJOUuEZZ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6F97088BE9;
	Fri,  3 May 2024 22:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714767249;
	bh=TzDQkNze3oblg3xgeptY0oYZlZZTBgW+bzQqgvlFZTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kJOUuEZZp5HCVjcfTz8uQBW792LxI78qIM8G1nAO5gJwXhUMdZuJbeiJEc8ewMmwa
	 4vHkI6CTbW7fiLI2ULe+h0MPaObo0kbERPszZiCfEtO3FHHwd+pVFaYDTAbTT706k/
	 z40lpK27XGpkwjQzvB1X07ABR+rUZaKeN3KPeXn50L0qMkqLPxQOYGNQYf7Pa1Q94D
	 wWLlyqt9HpTYyJS31iAdh1LTr8z4s8oQZ6M2hHBxNeGM3/TbXjvWPmannDNIqhEvdv
	 K/KHBr+l9kXvNMtjBLgCRvnRGMNCMAvcEU5+Z1VP8IYE0WbZXGI1tIrR25ab5yTkHe
	 DyGunUgFHwIrA==
Message-ID: <8de19188-577e-4e74-89c9-82755d0423fa@denx.de>
Date: Fri, 3 May 2024 22:03:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v3] net: ks8851: Queue RX packets in IRQ handler
 instead of disabling BHs
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ronald Wahl <ronald.wahl@raritan.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20240502183436.117117-1-marex@denx.de>
 <CANn89iJvQnjSm0wCQVyX+Q3VKSEHB1c=RVr11dSLoRUMPG-BzA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CANn89iJvQnjSm0wCQVyX+Q3VKSEHB1c=RVr11dSLoRUMPG-BzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/3/24 9:08 AM, Eric Dumazet wrote:
> On Thu, May 2, 2024 at 8:34 PM Marek Vasut <marex@denx.de> wrote:
>>
>> Currently the driver uses local_bh_disable()/local_bh_enable() in its
>> IRQ handler to avoid triggering net_rx_action() softirq on exit from
>> netif_rx(). The net_rx_action() could trigger this driver .start_xmit
>> callback, which is protected by the same lock as the IRQ handler, so
>> calling the .start_xmit from netif_rx() from the IRQ handler critical
>> section protected by the lock could lead to an attempt to claim the
>> already claimed lock, and a hang.
>>
>> The local_bh_disable()/local_bh_enable() approach works only in case
>> the IRQ handler is protected by a spinlock, but does not work if the
>> IRQ handler is protected by mutex, i.e. this works for KS8851 with
>> Parallel bus interface, but not for KS8851 with SPI bus interface.
>>
>> Remove the BH manipulation and instead of calling netif_rx() inside
>> the IRQ handler code protected by the lock, queue all the received
>> SKBs in the IRQ handler into a queue first, and once the IRQ handler
>> exits the critical section protected by the lock, dequeue all the
>> queued SKBs and push them all into netif_rx(). At this point, it is
>> safe to trigger the net_rx_action() softirq, since the netif_rx()
>> call is outside of the lock that protects the IRQ handler.
>>
>> Fixes: be0384bf599c ("net: ks8851: Handle softirqs at the end of IRQ thread to fix hang")
>> Tested-by: Ronald Wahl <ronald.wahl@raritan.com> # KS8851 SPI
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thank you and Jakub for your help with this.

