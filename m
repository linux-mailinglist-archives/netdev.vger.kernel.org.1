Return-Path: <netdev+bounces-84494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FAF8970FE
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170BCB28FA6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA54149C65;
	Wed,  3 Apr 2024 13:27:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rmail.be (mail.rmail.be [85.234.218.189])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4BC149C68
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.234.218.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150831; cv=none; b=Jy+hX/pqssc/xMsrFhk0al1OGl4jGDrQtiPHGkVidJiVIugEd0e8olD/lbpBPGEHj6dT0pUO5SoKLXOxV/X4Ig89FiWUPtI610nJgU0dNCBFxo1QZD7YjyjiBRJSGzarsQQW91pZHF7SmMqNEjDJLwj/sjP91Qc/iYs86Q3lfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150831; c=relaxed/simple;
	bh=OHungM9EBK3KdgCvTHFNx3SE52TLPhxcf7LeAEg0KZU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NNm4nKUBHEvh9Pp45PEVoy1hBuqf8lDgeq++XDD0B94nclkpsNw9lUqz674CMN37R3nKQRotLh5Gw5CCPy8o72yxP8UupnhEz84NDtYt/83+UxCs5BcaFEe01wz1pCFcggcjJS+yl2kW4qh85jeyiWWcWfD7MSJd/dUBzMMjrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be; spf=pass smtp.mailfrom=rmail.be; arc=none smtp.client-ip=85.234.218.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rmail.be
Received: from mail.rmail.be (domotica.rmail.be [10.238.9.4])
	by mail.rmail.be (Postfix) with ESMTP id 568CE5052D;
	Wed,  3 Apr 2024 15:27:00 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 03 Apr 2024 15:27:00 +0200
From: Maarten <maarten@rmail.be>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: patchwork-bot+netdevbpf@kernel.org, opendmb@gmail.com,
 netdev@vger.kernel.org, phil@raspberrypi.com,
 bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] net: bcmgenet: Reset RBUF on first open
In-Reply-To: <bf3276f6-3e79-403c-9571-b146c1d9c86c@broadcom.com>
References: <20240401111002.3111783-1-maarten@rmail.be>
 <171213902816.4996.4627354410898383893.git-patchwork-notify@kernel.org>
 <bf3276f6-3e79-403c-9571-b146c1d9c86c@broadcom.com>
Message-ID: <562153bceaef87d0e4eedb7fe3a59df8@rmail.be>
X-Sender: maarten@rmail.be
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Florian Fainelli schreef op 2024-04-03 14:58:
> On 4/3/2024 3:10 AM, patchwork-bot+netdevbpf@kernel.org wrote:
>> Hello:
>> 
>> This patch was applied to netdev/net.git (main)
>> by David S. Miller <davem@davemloft.net>:
>> 
>> On Mon,  1 Apr 2024 13:09:33 +0200 you wrote:
>>> From: Phil Elwell <phil@raspberrypi.com>
>>> 
>>> If the RBUF logic is not reset when the kernel starts then there
>>> may be some data left over from any network boot loader. If the
>>> 64-byte packet headers are enabled then this can be fatal.
>>> 
>>> Extend bcmgenet_dma_disable to do perform the reset, but not when
>>> called from bcmgenet_resume in order to preserve a wake packet.
>>> 
>>> [...]
>> 
>> Here is the summary with links:
>>    - [v2] net: bcmgenet: Reset RBUF on first open
>>      https://git.kernel.org/netdev/net/c/0a6380cb4c6b
>> 
>> You are awesome, thank you!
> 
> Good thing I had mentioned in v1 that we were busy with other things
> but that we would like to have tested that patch. I don't expect it to
> cause regressions, but I would have appreciated that there would be a
> mention or a github issue for the VPU firmware that indicated a fix
> was underway.

Eh, yeah, I had already sent an email to "David S. Miller 
<davem@davemloft.net>" indicating my surprise that this was committed.

I had added in the v2 commit msg a link to the firmware issue I created 
at raspberrypi and also linked to the lore of the v1 patch.

Should I have been clearer in some way or form when I posted the v2, 
(which was to fix the minor formatting issues and also add the firmware 
issues link to it)?

Regards,

Maarten Vanraes

