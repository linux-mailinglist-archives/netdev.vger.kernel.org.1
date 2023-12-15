Return-Path: <netdev+bounces-57855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ED0814542
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD95F1F23FB9
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016F18C3A;
	Fri, 15 Dec 2023 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1HvOOUN5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7919BA8
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a1e7971db2aso53219766b.3
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702635436; x=1703240236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3sdYjfrh0XIiJda1rBtqGHUSXAcGhSpafwfegt0TWAE=;
        b=1HvOOUN5uTR9RnrUYWd0aEapBeE7qGMLdpe0WyRh+oRnNrBjE96PR9SiOmeHZDKuQ3
         34wFfY3hj8WlX7vzHKBFFkwGs3dC0gDfAVtQNreIfAv5R86gAhBIRq16lxn/TdrIkSBA
         QIfb5h3HORKeJ65Cn6e7q1RzRgzs4L8MbyI9pSgwT1Qk+LGmhLucGgXh54xOaF2N/INw
         8PC+P65FM+ZF2qyiupsJ83ZjFf80c14AIZCvZJ/FXsKfIwTDNcy/sAx2ylE4Yi2uBnBx
         k0HjOK0X25QFGG5MVn0G0Yi4ArPKMJHtJdSkgLKjdJqNe4X3yqRDE8gkNuExlRPKd+A8
         zxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702635436; x=1703240236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sdYjfrh0XIiJda1rBtqGHUSXAcGhSpafwfegt0TWAE=;
        b=Xy1kQ27qkiD7IfOXgUXwdznOEBct5bzJ3vA2p/s59io1YKSPElyLBObHBIL+OeP8wE
         NSAhoQdz/3Ng4sh6RIa25Fv8CQC2OWr7bGvQKOx0WEqQga7sCFB7LE+8sLpF/VFYXba/
         5U3xIYStyEcLBWTKb8s6NdbGdf8Tu02RhVECLXZ8uDgMiE2no+2lHGL1CtrIp4X7dS6c
         hM22OPTOWjwmWXFayVq79SaRM1rPGnGa+/t5CG630VIouwTBi/1c2D3UUXcptkuu5bS6
         InchFuCb1yI0h1FUuP3ZLloTwvyjCdNwL3kDEY27H3JZ7fllOjnREGi6kfqQKgOAPLVG
         +okQ==
X-Gm-Message-State: AOJu0Yw9PjwMgOo7sX0lHdXDE8YblJRzygtx8oemJIupWb+lscsD9ASZ
	M48S5vFxDamBYc66sFJDdkg64Q==
X-Google-Smtp-Source: AGHT+IHibCH18swjfa/WQt80LZHdwmECUFEd4gr/XzUvkWY0+61WBlnitLsVCSNuRyHScuIIr/4N8g==
X-Received: by 2002:a17:907:2596:b0:a0e:d93a:3202 with SMTP id ad22-20020a170907259600b00a0ed93a3202mr4817885ejc.4.1702635436344;
        Fri, 15 Dec 2023 02:17:16 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id mt39-20020a17090761a700b00a0ad10b3f68sm10502879ejc.205.2023.12.15.02.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 02:17:15 -0800 (PST)
Date: Fri, 15 Dec 2023 11:17:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v7 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <ZXwnqqsFPDhRUNBy@nanopsycho>
References: <20231214181549.1270696-1-jiri@resnulli.us>
 <20231214181549.1270696-6-jiri@resnulli.us>
 <20231214192358.1b150fda@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214192358.1b150fda@kernel.org>

Fri, Dec 15, 2023 at 04:23:58AM CET, kuba@kernel.org wrote:
>On Thu, 14 Dec 2023 19:15:45 +0100 Jiri Pirko wrote:
>> - converted family->sock_priv_list to family->sock_privs xarray
>>   and use it to store the per-socket privs, use sock pointer as
>>   an xarrar index. This made the code much simpler
>
>Nice! 
>
>FWIW I think I remember Willy saying that storing pointers in xarray is
>comparatively inefficient / slow, but we can cross that bridge later.
>
>> +void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
>> +{
>> +	if (WARN_ON_ONCE(!family->sock_privs))
>> +		return NULL;
>> +	return xa_load(family->sock_privs, (unsigned long) sk);
>> +}
>> +
>> +/**
>> + * genl_sk_priv_get - Get family private pointer for socket
>> + *
>> + * @family: family
>> + * @sk: socket
>> + *
>> + * Lookup a private memory for a Generic netlink family and specified socket.
>> + * Allocate the private memory in case it was not already done.
>> + *
>> + * Return: valid pointer on success, otherwise negative error value
>> + * encoded by ERR_PTR().
>
>nit: probably better if __genl_sk_priv_get() returned an error pointer
>     if family is broken, save ourselves the bot-generated "fixes"..

Wait, let me make your suggestion clear. Do you suggest to remove the
WARN_ON_ONCE from __genl_sk_priv_get() as well?

To put it in code:
void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
{
	if (WARN_ON_ONCE(!family->sock_privs))
		return ERR_PTR(-EINVAL);
	return xa_load(family->sock_privs, (unsigned long) sk);
}
OR:
void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
{
	if (!family->sock_privs)
		return ERR_PTR(-EINVAL);
	return xa_load(family->sock_privs, (unsigned long) sk);
}
?

Thanks!

>
>> + */
>> +void *genl_sk_priv_get(struct genl_family *family, struct sock *sk)
>> +{
>> +	void *priv, *old_priv;
>> +
>> +	priv = __genl_sk_priv_get(family, sk);
>> +	if (priv)
>> +		return priv;
>

