Return-Path: <netdev+bounces-97788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C73D8CD32F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC211C22038
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8F314A0A7;
	Thu, 23 May 2024 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="pe/eF0DU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6D13C8FF
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469510; cv=none; b=OKrsxWAXtDC/AEMseoG3NViT5UcQPpHXyl4/LZ6U0Dj1+hdK14Wr1+p+jqsNanCAO7J/n8Af7W7D5dGRKCdLKGP6j76zmanjs32VDwGalsRcOe38H4grQ07bM2KJnVGVl3aoKmjJVZ5mRRIb/r6ExBpMGDIHfA3OxlVY7/W/vX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469510; c=relaxed/simple;
	bh=6vEZzTaijTyKXAYqYlDMK49YRLDu/o2gsAv6eRuZYr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gG5DJ8nZ1Eh9XrnmCfIqHrYy+97iSQ6BOGR6AHaN351CD4Sk/mAC22HA0R6FXzzWXmPF6lNrpLFjp5+ido5jKFErylOxte2loQ/zl4lLl4nzjy0a/5E0Vp2WdMN++A7ThCfW16zfDPHOkJcb4jlOI5XsjfR+2eKDlv9EQJnoUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=pe/eF0DU; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=ymebLM3yZTqICl4ZqpFBiOYYJPRxb3xsXwsSZMu+b4o=; b=pe/eF0DU8vR7idT7lm5VCBo6TA
	rl19V4ffZYhsIWEHL9VK3wiWgWPN3a+jKMH/Lr1MZepqoozE2P95GlH0JcdsRplzVscfiHggA+1Xo
	f/91ZMG5GC8HpjK61so9N2gtOaoh5sciJEMALxC9mDPmLorWqIRqs4dpHspobRE1RV7uhKu+7z02B
	TMQ5H7nLVNgpQ1AJN7HKFzr/Zv5EsdpFafJZNnM2vlCkNDTz1YHqCPE2P16OWt12Upp4PA5jNypLO
	6WLC4YcUPhi4KpIWsNDI92VWHwiMwaYpg3ZT0vI0UFDnwwdQUJmwkSDiSW0wYX3hPNzg5a7/ttYQG
	sa7OwTUQ==;
Received: from [192.168.9.176]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1sA87u-000gCg-2N;
	Thu, 23 May 2024 13:04:59 +0000
Message-ID: <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
Date: Thu, 23 May 2024 21:04:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iproute2: color output should assume dark background
To: Dragan Simic <dsimic@manjaro.org>, Sirius <sirius@trudheim.com>
Cc: netdev@vger.kernel.org
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 8:36 PM, Dragan Simic wrote:
> On 2024-05-23 09:57, Sirius wrote:
>> Maybe colouring the output by default isn't such a wise idea as 
>> utilities
>> reading the output now must strip control-codes before the output can be
>> parsed.

No. Debian is building with --color=auto, with which colors are added 
only when stdout is a terminal.

Just do `ip a | cat` to test.

>
> How about this as a possible solution... 

For what problem?

Yes I asked Debian in the first place to leave colors disabled by 
default, but nevertheless `ip` is still broken for most users if and 
when colors are enabled, whether at runtime or build time.

> If Debian configures the terminal emulators it ships to use dark 
> background,
Do they? Or is that the nearly universal default?
> why not configure the ip(8) utility the same way, i.e. by setting 
> COLORFGBG in files placed in the /etc/profile.d directory,

COLORFGBG where set is automatically set by the terminal emulator. It 
would be more sensible to add this feature to more terminal emulators, 
upstream.

Should Debian come up with a patch that magically adjusts this variable 
every time the user changes their background color (in one terminal 
emulator... and another color in another terminal emulator...?)

And what about linux virtual terminals (a.k.a non-graphical consoles)?

In summary, if the best we can do is manually set COLORFGBG when using a 
light background then that's the best we can do. I don't see how Debian 
can possibly help with that.

On the iproute2 side, a rock-bottom ultimate default background color 
assumption will always be needed and that should be dark.

Yes, echo -ne '\e]11;?\a' works on _some_ (libvte-based) terminals but 
not all. And a core networking utility should be allowed to focus on, 
ehhm, networking rather than oddities of a myriad terminals.



