Return-Path: <netdev+bounces-97822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB0F8CD5DF
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2901A281BA8
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93ED1EA74;
	Thu, 23 May 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="XMTZ6+8i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CDD1DDC5
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474791; cv=none; b=mP2r2MY3E8mEGTTNlBao6CGdqxXBgFeo83L67qBGctqYdgbByuHDPdAJ07mVhDkobRdhNWTZCsshuw9GJPXYcFwcrz9MeB57LH1/bCvPuX4dIajU4OV8m5hit2J1NM1QQ+gT3qSBMnsbcTTNNmGyY3GyFS8iL2GuyHbB6kiRFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474791; c=relaxed/simple;
	bh=uf+1pKISWU1W1bsEZ9yu8nOnvfwvExxyGz5feHHQj0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1pLMkdJDsZ82l1b1nCUC5FwOpDEnvwKsu3caWJxCfAiWA5w833HiNPbJFc0NP2bPFh1z8r+db/ZfB6DtbpUcTez+W/exRuMWGp4NUG0Fr/DqeVsI3SjxNTFyPJK6H6IczuPXBmP2/RKajkX5lwyiJ9TaOtHgllPKPJq+OxTEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=XMTZ6+8i; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=zqmi0H1J3g3AdHqY0I6QaW6Pr8YwdrhqsT8pC/36uAA=; b=XMTZ6+8ips+zlMSCjd3+l50MiG
	iwgWAGj1+VZACRxGBj9lFqSb5GSZwAB8VsgrHpOlLOUgDE65hk7BcNsTgSAvZTN7douxbLyACS784
	coh5I7Bi9fvUScz/WvwFKoBrYUDq35klHyBvClijSKPLoeyQhAEQ0B3/E9kc7nwDEOx47wRkxqJrR
	JnsaxAvqJt3l9SNCRVElsNjxgK0tuHJfxkVmgKw3icDK45zbyccpndQfyfpJ8yP/TOIhDyAcut0Rt
	H4P8Dnpmw5CqokVD3GVwvWHC5daavAZ883wEVIZv1CT/L6t0j6VZrHgBMcy0F2TuY08a8wcayUD3q
	DAzQoy+Q==;
Received: from [192.168.9.176]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1sA9VC-000gLf-30;
	Thu, 23 May 2024 14:33:07 +0000
Message-ID: <94d43b6d-74ae-4544-b443-32d8da044b75@gedalya.net>
Date: Thu, 23 May 2024 22:33:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iproute2: color output should assume dark background
To: Dragan Simic <dsimic@manjaro.org>
Cc: Sirius <sirius@trudheim.com>, netdev@vger.kernel.org
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
 <1d0a0772-8b9a-48d6-a0f1-4b58abe62f5e@gedalya.net>
 <c6f8288c43666dc55a1b7de1b2eea56a@manjaro.org>
 <c535f22f-bdf6-446e-ba73-1df291a504f9@gedalya.net>
 <c41ee2a968d1b839b8b9c7a3571ad107@manjaro.org>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <c41ee2a968d1b839b8b9c7a3571ad107@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 10:24 PM, Dragan Simic wrote:
> I had in mind setting COLORFGBG to dark background that way, not some
> shell magic that would change it dynamically. 

It's far far easier to just do color palette overrides in your terminal 
emulator.

The "Dark Pastels" preset in XFCE Terminal makes everything just work. 
Both iproute2 palettes work fine.

Anyone who really cares about colors can and should dive into the topic 
(not me). Once your graphical desktop is up and configured you'll be 
just fine.

The only real issue here is force-enabling colors where they are least 
welcome (crashed server, vt, no mouse, black background, just let me do 
my work please).

This entire discussion has gone way way way out of control.



