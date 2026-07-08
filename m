Return-Path: <netdev+bounces-305806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dm0JLIxKTmouKQIAu9opvQ
	(envelope-from <netdev+bounces-305806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:03:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C029572694A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:03:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Xb3DIokC;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305806-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305806-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9353049964
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A14611FC;
	Wed,  8 Jul 2026 12:57:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D444A730
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:57:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515466; cv=none; b=Adz8xSV+JaMVA1/VJhMMG/YYME6llK6L+fl8/N6tCehaUkej95U3a52WMoM+i/8+lCR+OFeEk3BFifF11U0whBcLlaFIusU9cZ8wMCStHVJJIqnzpQ5+HtGFFGx/z3rl6G/yzA8HRbl30as5GTZ5Ia2ML1HkOYT4NvVEarccoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515466; c=relaxed/simple;
	bh=p2sBG0EfGLaH6Y35Jnfm7LcczjHmXVGXkFdF7AVbxLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMSEec8yorUPNx0dNgNtKcXEe/rtiMeyZc96SZ45pxpOi8QtA6ysrNnrMQx+J/z/0iqJMoXzbgQmonwpfS80UcsNnwbSEPzQTU1snBOQIBWpxtlVZKZ+ufQKaw+hPtLCFQUjki8vit5HOecZSfXhTj5K1VmpWH/GAN9Nld4Supc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xb3DIokC; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so4735485e9.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783515464; x=1784120264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kbuub7RzesYOSTnZvhaXlscpLtvQ6nHc+kPlYrOavVg=;
        b=Xb3DIokCVEoZjy106BwrJ3Z5yfUa2cIug9ZiCqG94L3m8f7q2TrHicUCO7NDxs9aCq
         mvxewvrBWJ4jMBELHJ7HIURK+jUnLsq9W/TN/Auat3HiII7R117KprUi5MUOJQeJEJEh
         LPeHTfjOeYljyZ70NMHAsyN7o8GQiAjVysZn1YgjoWkm7cdXkBwQuKAo7pXC609etF3a
         iqprVQzj/rPZXGLoaFzvTRPttUWEvl0sSsEaQVEFt4U+63hkeaADz01w7OidQqk0fUOF
         Z3GYO2kPeP41kdo4OgM03+Wkid20p1ERnc+URU3bDy1OBAPHI/jh/+jBGCTA9P2lBfnB
         QfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515464; x=1784120264;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kbuub7RzesYOSTnZvhaXlscpLtvQ6nHc+kPlYrOavVg=;
        b=Qy0K3BT4X2L9cDFMsnA1KAyHZgeAR/TAwp/nXCpu7cFpu9zEev2i9GT8vPSUdcHOEL
         K/KeQwluXzpr3EOMaIHyOrXVoGmz9gWjoYo8FEO68TtvrhXaqUuK7n8mYex/eR/VdFEb
         ctA6IM017zuNkIal0U414aJJqls5d6sKSBDmAkylbUlfHgfXVK730DlZGBb6cbxsHQUA
         0TznXeqR+83vYn5qveu7u/ctyiW9f/QJUF+86FNeSNRFYU19YIfmE+Uj6Zw/ENpvX5cW
         tJF+EzLn0Dim7ABL8NiC2dlRAedV22BlTn+ZvNRgzvJL6GcpNPuRXzNnCeVRXuLYvpke
         NNhg==
X-Gm-Message-State: AOJu0YwvJVScyXGvF9G1blx2ZnICBPgwNtwnSLo5lAd4FYjernQRhBPA
	0fJcbJgfUtmV/zILQCIeSXjUgtw8Wok1MNsZS2Q2QF/UG5mVEqz6eY6J89KylQ5CTAw=
X-Gm-Gg: AfdE7cm0nqrxO3UmLcrIBUHidUz7mxDN1OAv6Wd43jQjuX36ZIytYtgh2CF22FSxGu8
	I3Z0PoATNGBxtDO24HUZNhLw1QFNWTy9VpKyi6w7p277LyacvPMVJtWII/+CbwF7+v6HorHuJdX
	GNm0ilCnhgkC/2ZE6oDtA0loKJeLp06BD6ylHqqWrVZPwkkdcXOcazXP+yFHJf8yOtr5/Ts01g+
	B7DpyxTj3gwA7mwmG1ie7yWw4MDiwDYu4wJ6pwhFpljgqP29QPhBEMP50xS0sJYtJS6cULECELW
	lOjxgxJP2m2kOmcv39eKrgYBY1b9wFDC6X7t0CyCl/ELeQAJNdBCNjIBezsn9nEzYwEQRY1Cdes
	Lr5ROhZPD/jhrVf7Za2Kx7XYyGP73Bnq16j60Ois2KyIRMVWv1lCE/i4itYu114hx8JhP8TmswH
	U2qDeoPIsz6EHkd55XtwzbN+aeE0+//65Ph8ceUPrafUKVB82XoNDC8MuW
X-Received: by 2002:a05:600c:34ce:b0:492:4911:8a with SMTP id 5b1f17b1804b1-493e68bfa4emr25852455e9.12.1783515463922;
        Wed, 08 Jul 2026 05:57:43 -0700 (PDT)
Received: from ?IPV6:2001:a61:1384:9d01:1a30:62e0:878c:ea70? ([2001:a61:1384:9d01:1a30:62e0:878c:ea70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e544837dsm51934925e9.0.2026.07.08.05.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 05:57:43 -0700 (PDT)
Message-ID: <2a0bacab-951a-48b2-8263-bad3088a29b7@suse.com>
Date: Wed, 8 Jul 2026 14:57:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/12] net: mctp: usb: Improve IN endpoint
 status handling
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
References: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
 <20260708-dev-mctp-usb-1-1-v3-4-9e710155cdbf@codeconstruct.com.au>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20260708-dev-mctp-usb-1-1-v3-4-9e710155cdbf@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305806-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C029572694A

On 08.07.26 11:58, Jeremy Kerr wrote:

Hi,

> @@ -198,6 +254,8 @@ static int mctp_usb_open(struct net_device *dev)
>   	struct mctp_usb *mctp_usb = netdev_priv(dev);
>   
>   	WRITE_ONCE(mctp_usb->rx_stopped, false);
> +	mctp_usb->clear_halt = false;
> +	mctp_usb->in_err_count = 0;

What allows the assumption that mctp_usb_open() does not race
with error handling? What happens if the device is still stalled?
It seems to me that you need to wait for the halt to be cleared.

	Regards
		Oliver


