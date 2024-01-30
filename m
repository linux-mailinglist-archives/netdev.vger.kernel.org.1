Return-Path: <netdev+bounces-67239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232284270B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0F51F27AAE
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435C57C0A9;
	Tue, 30 Jan 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="F1OWWn+b"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D457C08F
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625634; cv=none; b=aW9+WngSfSWlo8ssgUVya4EpKq5CojJ4AkCuNub/0vnycD7eFI+EH+463hgCKmpoKTZLy6zI52FIIqWbVdl+Axnyo+CyA/dmQ6O/eOvfIOWm4r1f2+m4hkXwx22z3dwVHybKf61/OXd8EX74J9+f3gmRXcUvnF6dKH6h65aikoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625634; c=relaxed/simple;
	bh=i4+1Ka55hQ4mmOr5XOnyhyHAsoBzYtZ5wMpGJQ70dgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGMGplxv3itlefmPXPn6YhMIBkAu/E9bLcK6wy7jImd3trYAox/7e0s/4AlXAAfi32M0zobH999CMdbQugoVIzOUpC1g/6jfmBMRnpNSKHH+9mGFJ07XsK9D3j2gQiri9MJ7yhcgRFvknattCjI/wQNRb4W8gYxG3OAeXO/Z3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=F1OWWn+b; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 806941C0004;
	Tue, 30 Jan 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706625629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1l5tDQUKbgnU5aEDhh4VtwiHbVjP5XifbDmxmGNGJ8=;
	b=F1OWWn+bWfkCvfPbGz/q4Mnx+rUdsZM5BR/ZAUIwALmCeqrQIedzinQjAuyr9SSnq9k+Hh
	E8p2UWsFP+j7goKN4xgow/JU30i242qqG2GTfKW5e33CqmN2IBL4ZYfBQJ35SDGwcK3Wh7
	pEWtQ4ycIMssoynSrKuTP2mbdwMpnlVtaiQuolOYPdDxaQmELxD7R3asfbAjfAHRbvPRst
	13CZbXGuGIkjf8ABGTEdzUhMu99M/mNbD0tc3wxyfz5fxfCHc4vQwDH4O6xnImDCUDgk7q
	ManXfw9DFT/sld3mUmlQBBrFXgyA7CV6hgYBZNKvmtmzNv9vAgwXGKLeo+dINw==
Message-ID: <a50ca71f-e0b9-43ad-a08f-b4ee8a349387@arinc9.com>
Date: Tue, 30 Jan 2024 17:40:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 08/11] net: dsa: realtek: clean user_mii_bus
 setup
Content-Language: en-US
To: Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ansuelsmth@gmail.com
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-9-luizluca@gmail.com>
 <20240125111718.armzsazgcjnicc2h@skbuf>
 <CAJq09z64o96jURg-2ROgMRjQ9FTnL51kXQQcEpff1=TN11ShKw@mail.gmail.com>
 <20240129161532.sub4yfbjkpfgqfwh@skbuf>
 <95752e6d-82da-4cd3-b162-4fb88d7ffd13@gmail.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <95752e6d-82da-4cd3-b162-4fb88d7ffd13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 29.01.2024 19:22, Florian Fainelli wrote:
> 
> 
> On 1/29/2024 8:15 AM, Vladimir Oltean wrote:
>>  From other discussions I've had, there seems to be interest in quite the
>> opposite thing, in fact. Reboot the SoC running Linux, but do not
>> disturb traffic flowing through the switch, and somehow pick up the
>> state from where the previous kernel left it.
> 
> Yes this is actually an use case that is very dear to the users of DSA in an airplane. The entertainment system in the seat in front of you typically has a left, CPU/display and right set of switch ports. Across the 300+ units in the plane each entertainment systems runs STP to avoid loops being created when one of the display units goes bad. Occasionally cabin crew members will have to swap those units out since they tend to wear out. When they do, the switch operates in a headless mode and it would be unfortunate that plugging in a display unit into the network again would be disrupting existing traffic. I have seen out of tree patches doing that, but there was not a good way to make them upstream quality.

This piqued my interest. I'm trying to understand how exactly plugging in a
display unit into the network would disrupt the traffic flow. Is this about
all network interfaces attached to the bridge interface being blocked when
a new link is established to relearn the changed topology?

Arınç

