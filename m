Return-Path: <netdev+bounces-283088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JHPLQwm9Gnb+gEAu9opvQ
	(envelope-from <netdev+bounces-283088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 06:03:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F104AA036
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 06:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4FA63012E8F
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 04:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E030125393B;
	Fri,  1 May 2026 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ixYVRtGg";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="N0b6FK6+"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE91CEAC2;
	Fri,  1 May 2026 04:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608201; cv=none; b=sD2s/pz2Ve8NnV0qkHtR/YyxSFd+p6UcCadfVDiuGPlkgE7y58h7ZFsFc4nDO4ABona3eUGonhugrwVcTwb9d8LrPknAwaW861o5Ovw1LaTiXKQgVeTq1z/fzROrC0OX1rexEcqv2GJU4W6rr3NL8QlIule6H4ns1AvGRkxm4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608201; c=relaxed/simple;
	bh=FkIxgPZlZNy64mEA07cC2VpF4xRbXLaoWWOeyCQgk1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsckGrt8lBk3YiVGy9GL/Q3ePI01e0xDGoDeewe+8USYxmDVVfH0axck9jUMlWaDkP+oOiUeDj6RInW6bp6+G4jBHcPOrSDWR86AAZoWLkZeZI3nzFirenLH24Hu3OtYrZCbbPRtmoF05XJhh9v5CGAtmpsxgZvzxdQzsDGFRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ixYVRtGg; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=N0b6FK6+; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777608191;
	bh=FkIxgPZlZNy64mEA07cC2VpF4xRbXLaoWWOeyCQgk1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ixYVRtGgkBET00Q4AbEsrUJk9AOdaklU904nO4naDnLvq4HEGt48ZgSY9gLcxYpE8
	 qCn5Z8EMBRIu4lzcMLBb6GAs5UGLBVNLiaKvD4BISWKil09GyKyY+nxwROAqtVAjn8
	 gyKwcEXnGkbuQ5oDsad34HovW1DszAemz5e6r5HX4y73NpibOHV/AbkCqPidbju/5c
	 YNT70hOJ+eBlJZz2JudQoyPSvXZKo6Z1zMk/2AdrBwU/L+MxyMMIyVKpJxnRHbXKCV
	 8mVODifCq0mITCLiAvxOISerwyvmO7egq+9jhRiXK9GgSEFh3W5JFjvXZDCxIrkl8l
	 dl1U+1ibk3N5w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C24EB4820C; Fri,  1 May 2026 04:03:11 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777608186;
	bh=FkIxgPZlZNy64mEA07cC2VpF4xRbXLaoWWOeyCQgk1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N0b6FK6+2HOT6vbT0CJcphYs3A3x/ed1irb9MFPYdl5mrF1Ux7r8nUfqgudWHahUA
	 ula31Ro25Ht52XBGTyepJVSxM6rdIvAMs7GbjhFikwNq4BXTVXW7/WUm8Qh1HAR6rf
	 6XcQk0onWv5EYyiXMA1oXnIDSQA//vJh8laksMq3I48zXGycTr0UX+krD7D5/v+zDz
	 ZOFH9dKbuuIXqvyaJ7wA23fZmkz7C4EB+kzs5Ce2V+DsSldLB+HmQxMDdmh9BFKmuo
	 Vf6z8ZkoWrgj7hGYqu+zvHFmQHE9HOlc9QJ7IHmnDUDKRC55Pay9TWcQxtwrdTLkgt
	 FU6SNPqj0hq3w==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 1A7294120B;
	Fri,  1 May 2026 04:03:06 +0000 (UTC)
Message-ID: <7b3d3fc6-bbed-4a75-ac19-33fa910359c9@birger-koblitz.de>
Date: Fri, 1 May 2026 06:03:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: usb: r8152: add TRENDnet TUC-ET2G v2.0
To: Aleksander Jan Bajkowski <olek2@wp.pl>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, hayeswang@realtek.com, hsu.chih.kai@realtek.com,
 kees@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
References: <20260430213435.21821-1-olek2@wp.pl>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260430213435.21821-1-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 17F104AA036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283088-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,realtek.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,wp.pl:email]

On 30/04/2026 11:34 pm, Aleksander Jan Bajkowski wrote:
> The TRENDnet TUC-ET2G V2.0 is an RTL8156B based 2.5G Ethernet controller.
> 
> Add the vendor and product ID values to the driver. This makes Ethernet
> work with the adapter.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>   drivers/net/usb/r8152.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 7337bf1b7d6a..1ace1d2398c9 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -10138,6 +10138,7 @@ static const struct usb_device_id rtl8152_table[] = {
>   	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02b) },
> +	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02c) },
>   
You may also add my Reviewed-by: Birger Koblitz <mail@birger-koblitz.de>

Birger

