Return-Path: <netdev+bounces-220903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C5DB496CD
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 19:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E0318973D2
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A350311580;
	Mon,  8 Sep 2025 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="onefen4E"
X-Original-To: netdev@vger.kernel.org
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BFD225403
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351728; cv=none; b=UE2QtsubGJeJrD+GYW4UXA49BLU3q7CgGdPfrANNtOWIlDY5VW3OsqP6D8JO9DFznCCg8ko8+cT+gbbjJ0k88Kw2ozMLpNJtqly19XCGDpeV4tDwwqI8EfvNpuWikS2wJvJB+WsmV8O1n4dkAZ8UKlPoFapR/L6q90jRopP+D9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351728; c=relaxed/simple;
	bh=IwxkXHKQgZdNPoeUFzCpLIC+PgktDvbJCeeqhmt/Jo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AK+oEyI+kzCherNYSr1l55wEPh3kXwDTc32u47GK3FPbFQX12r0udTNK/WDLKV2T91O/rI3SNlpIRHnx5qoqSoti1U8qNh4fS8lN+R4QDn0v97OTIQ3Itar1uTsROa2vkDYzPsQggaRwKYxqphD0Ubxhtq7Ez20/hfFqzj50bbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=onefen4E; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:ba5:0:640:b177:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id EADCF810C4;
	Mon, 08 Sep 2025 20:07:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id H7pdvNiLua60-V3v8grAK;
	Mon, 08 Sep 2025 20:07:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1757351239; bh=XqP3OqKB7h/2ZWNFM/KYNZeZeieHGJ0PBR3jZbPyNAQ=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=onefen4EhUREMfHEZBIKv1hHWrNwda0GfMa4FfAQSeJOnZ1nMSjjIM6/mG/OJkqCq
	 8GVTaalLZH0xWtIKIiUxnNn1cIpgZhBXnu+NC0jw3c9k5zBIC1yvcL1YXP00NtVSbJ
	 OPWXTkJytqXtU7inwIGYSuB2ESE70e0JJBcHdet0=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <681fb4fd-a864-436e-bb13-adbdd4e9b769@0upti.me>
Date: Mon, 8 Sep 2025 20:07:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: phylink: disable autoneg for interfaces that
 have no inband
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hkallweit1@gmail.com, kuba@kernel.org, matt@traverse.com.au,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <E1uslwx-00000001SPB-2kiM@rmk-PC.armlinux.org.uk>
 <7e463b05-ae28-4a98-b8fa-bdff266aa62f@0upti.me>
 <aL6JSEhTRh2q_Jxe@shell.armlinux.org.uk>
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <aL6JSEhTRh2q_Jxe@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> 
> 10GBASE-CR (based upon BASE-R) has no inband signalling for
> autonegotiation.
> 

Ugh. Sorry, that got me to the right idea, WIP driver was misreporting capabilities. The fix turned out to be trivial: https://github.com/K900/linux/commit/15406149c6e45de3884f1ccdafa1920da37d1bf

