Return-Path: <netdev+bounces-245841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D54A0CD9088
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 12:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A554E30136D2
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D01322B70;
	Tue, 23 Dec 2025 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="EzID2cVS"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F6302773;
	Tue, 23 Dec 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488205; cv=none; b=cOYdPjFT7g9jIPbeImKG4CHZxT5CKrJMjOsRmohyq0xkJDBDNTLEZTnyjS+AMiRiXNbZxcumxmRWRzMnsbreAVu22Prkq1job///LdQB9UXl8eHWlqeWVmBxtHEMTV/dWUTENfmKXe2c2D8r5r0hy7JvvvDuifAd6DmVdpRZH3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488205; c=relaxed/simple;
	bh=DCzJrlCFPHbdhH4pbfSMyoU+QTjhhTiWeIA0RAA5y+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6kG0efUTUKJSU6zuj9clHbxBFtUTPMI6dpHk0ijiRrwYei4U8bgm1kgtnx1dqKMS1pFhR+xr/8PDWhrN9GBNRZmItQwHelrcp6khxpY5hxFq9uglHm1WL08olWsp9Hqd81cg+tyjL4IxfOSQ2cxtc4xu43uLjOYuPGwC7ROTns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=EzID2cVS; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vY0H5-00ASKL-DL; Tue, 23 Dec 2025 12:09:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=1+u1IBrky6sWhAl4AMkGYqMEEOxNVXZ8krlwQcI38ww=; b=EzID2cVSOXnDT4F1sBDPCMd/z8
	OtqjC5JeuyMVmpkC7R5RSc+QzB4I12FZWJs5jcZmxfCwdLTIl+Im6RxZjTiqUEVlQvqTPrW/ZPuS0
	3vt/Ypyum3r+QnuirYmBxPreInRPgIIcQxVfJuTyhfdeQeQi+ogt3ZXoMEh9ErJ8GzhoDl7rQQ9bs
	5NfMonlaD5Cxo8fqcSGWw/Ve4gcHUEXQ81RM79l0uqKG04TW6MeQoLGaP8lksgw8/ZcXawTzoaD9Y
	lyzKlTF61XkGNl3KGJZ7wUhCR4YH4dlQLXsVXt4WDQy5bHCSNeVWuS5TcvDOIX0ISNzPTJS2GdN2X
	2gkgMG4Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vY0H4-0005Gl-Kj; Tue, 23 Dec 2025 12:09:54 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vY0H2-009YYH-NW; Tue, 23 Dec 2025 12:09:52 +0100
Message-ID: <ff469a0f-091b-4260-8a54-e620024e0ec9@rbox.co>
Date: Tue, 23 Dec 2025 12:09:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] vsock: Make accept()ed sockets use custom
 setsockopt()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-1-4654a75d0f58@rbox.co>
 <aUptJ2ECAPbLEZNp@sgarzare-redhat>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <aUptJ2ECAPbLEZNp@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 11:26, Stefano Garzarella wrote:
> On Tue, Dec 23, 2025 at 10:15:28AM +0100, Michal Luczaj wrote:
...
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index adcba1b7bf74..c093db8fec2d 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1787,6 +1787,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
>> 		} else {
>> 			newsock->state = SS_CONNECTED;
>> 			sock_graft(connected, newsock);
>> +			set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
> 
> I was a bit confused about next lines calling set_bit on 
> `connected->sk_socket->flags`, but after `sock_graft(connected, 
> newsock)` they are equivalent.
> 
> So, maybe I would move the new line before the sock_graft() call or use 
> `connected->sk_socket->flags` if you want to keep it after it.
...
>> 			if (vsock_msgzerocopy_allow(vconnected->transport))
>> 				set_bit(SOCK_SUPPORT_ZC,
>> 					&connected->sk_socket->flags);

Hmm, isn't using both `connected->sk_socket->flags` and `newsock->flags` a
bit confusing? `connected->sk_socket->flags` feels unnecessary long to me.
So how about a not-so-minimal-patch to have

	newsock->state = SS_CONNECTED;
	set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
	if (vsock_msgzerocopy_allow(vconnected->transport))
		set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
	sock_graft(connected, newsock);

?


