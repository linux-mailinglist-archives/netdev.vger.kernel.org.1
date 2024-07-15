Return-Path: <netdev+bounces-111601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD36A931BC0
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 22:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0821C21BD8
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118641369B1;
	Mon, 15 Jul 2024 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Uw2tFpXR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94236282FD;
	Mon, 15 Jul 2024 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075093; cv=none; b=TDZei5c7a4/GiCmMITsVgtRmm8HFQZjFEdxBH9ynt9wiRhA87YFGGEh2JfF08S32LZshGNv+fc35BwaL6orUJvw0CU9e2xw7N8hfsmI93IoagSvd4FXgD5RvqmNccv6IUOJK/1yKrhDu3Wk9cE+L1gh4XGj6HfxQT++BiQqu4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075093; c=relaxed/simple;
	bh=osTrVHiIObgI+vHOvHyIs7DuJMj3b0dBdNKtsFr9owU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VahCbY1KFf/uhEeCp8lh7x3VpUBlyvKk9Yw5pcD/QWIlHlX0r+1FglreDH6AZ0KfYpvSFgKluDXYLN+tJGeqIOZlJObFIspxfKiJGNtFQczdNqX2MkPoqZogte0yLLf+FJx+cgQpXIUVYcCETqPc+ql9BKj+SnyMrqxsF5NqHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Uw2tFpXR; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id TSFTskNDCj4pfTSFTsXq55; Mon, 15 Jul 2024 22:24:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721075082;
	bh=he6gmmUMbwqSQvrMV8Ht1aTxpX0j3zxi5MrnSEMUtK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Uw2tFpXR0tt0oeSW7GCyQ4KbPzTV1U03xlQVSUohBFjERXVY/VyzYpNkxkOflO47/
	 S9OW4zOii+LNuEWk+KIFMOTK7oMVoRZQc/MIOQ36wNBLq8b/PpCi/d5zGHQONMpLhU
	 DNHkW9VEU/k4yiF6CmGRfxDJmwtONicerc3g6o06U8EE4qBmnPBLN5uf8amKg4ejXi
	 w1Z4reb1ppUjvcDdaLrHomrr/aCkBhevHMGpw2biRNQdUnclfa/yBbSz1KzlARjB8k
	 w9IE7w+CKpcgx/sKHa3A5j4YORzeD9qUnqxSn2a5zOiW8pBgvG5mmb6loPtA22oKjG
	 wJnekI47YlphA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 15 Jul 2024 22:24:42 +0200
X-ME-IP: 90.11.132.44
Message-ID: <b3fa592d-91d7-45f0-9ca2-824feb610df8@wanadoo.fr>
Date: Mon, 15 Jul 2024 22:24:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-netback: Use seq_putc() in xenvif_dump_hash_info()
To: Jakub Kicinski <kuba@kernel.org>
Cc: xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Paul Durrant <paul@xen.org>, Wei Liu <wei.liu@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Markus Elfring <Markus.Elfring@web.de>
References: <add2bb00-4ac1-485d-839a-55670e2c7915@web.de>
 <20240715090143.6b6303a2@kernel.org>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240715090143.6b6303a2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 15/07/2024 à 18:01, Jakub Kicinski a écrit :
> On Sat, 13 Jul 2024 15:18:42 +0200 Markus Elfring wrote:
>> Single characters (line breaks) should be put into a sequence.
>> Thus use the corresponding function “seq_putc”.
>>
>> This issue was transformed by using the Coccinelle software.
> 
> I prefer to only merge trivial changes like this if maintainer
> indicates their support by acking them. Since the merge window
> has opened we can't wait and see so I'm marking this patch and
> your pktgen patch as deferred.
> 
> 

Hi Jakub,

Most of the time, this kind of modification is useless because it is 
already done by the compiler, see [1].

CJ

[1]: 
https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/seq_file.h#L123

