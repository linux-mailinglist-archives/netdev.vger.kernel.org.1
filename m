Return-Path: <netdev+bounces-300669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qm7dI24NNWq+mQYAu9opvQ
	(envelope-from <netdev+bounces-300669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:35:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F23606A4FA7
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=ZwlTEYlX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300669-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300669-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 050953018437
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B973655FC;
	Fri, 19 Jun 2026 09:35:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1636606E
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:35:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861739; cv=none; b=ssb+g1xCqTN4/YQECoauSCxrKqHkRy245DSGCK1MwMQYRVj4eLymYdV81chGhu3XviIS2jrsL/LkuL6RdXBoM81LlEDWTZD+bCcST1UJW1Pdnj1hUePM8JeSgDJAmW+j8sGk5x5c80/lWip9x/RHJNAuV2OgUSJKYqbf24pqlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861739; c=relaxed/simple;
	bh=80sKzv5WazwtYgx2xTbQqEd2UYPHbUZ1umJ5ETjTfYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSuoqOybxI57zxDI9ZFEbM8nufdn5wl+Q4ZNhKYxSOp5HtQV4CR+D6Y1LLKfGX07KfQfdEeo4UGt0WMN4WCBsE/2NfYtdvZQ7VYl6zkrRe6LiTPKcC3SFeMX4ElraeMmifd7eieDxAIpyayFmHQG/nd42Xbp1vgWR+krldeIKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ZwlTEYlX; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45efb47aa6fso149778f8f.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781861735; x=1782466535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RPYEHxh1HZ2EjQRFuWBnZ2e+0iA1b2k740lZpfAohOA=;
        b=ZwlTEYlXk+uBei5D2aFw5o2QiX7RUv5a3w67CZh1syN9/ctBsj8zxBVImpYEmwURbw
         n+bI/15xeLtKTg8Ilx8qjrF+vh2VCUFPALd6D7wB4Qn68fQXlV3Zsx8rFgzBwzGrQMW5
         DGmtbMX6aTAUFtiCtE36BosJ89GtrHCzy+RbOHtFG9JXHYg4nRTe+KXnnhfRUWcUxQ3e
         jkOke1kDyQHPV/D4AU5hy8qOOQEa7Y/wQFL+AhpPZDloz1ZRReeW8LO0rkuVfRT6A2Jf
         WUVaXhtr88XpUFBaXFffjPydGuyd3uNHawbllM8mSwXFWRv/WRicbAug8taKYFBIJYk/
         WQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781861735; x=1782466535;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPYEHxh1HZ2EjQRFuWBnZ2e+0iA1b2k740lZpfAohOA=;
        b=cIllR79hBBut6m4fmuHsIUjonqkltvYZybB3/x6lI8LqkoW3+CrOKurU9q0FrVc5AA
         nVGEzAvpEDmyt/mYH+qpCG7NNTvwTpV/B9RQltXvVM69JgnrmNtxF/8XDhRmzeW6kUlW
         QLdoWVrbLNGqcVGi1SDEvr9KYeDDVTTqeenao4kF4dRtShS23Yb6JwHG2xLhuN0IuKT+
         msrY5COJEwyG0sBKUV1RCjiSNPVjFleMuinhAvRFmWsZZjo2kcH3npqUzUJ8UXlVojFq
         kLmdICv5g3155KbQgfoOZIzVXSDO9o4u3LgM2NPDdRXwyh5TfatZvqSGZ6s8Rry3UAAJ
         3ooA==
X-Forwarded-Encrypted: i=1; AFNElJ/fgjLyB8AAsU5cEVVuaemGH6Fl5WPFCRL8SvU8y/Bs5cDkVUwohXFq5pStOH/LlKHmPWYAXkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd/Q53JMmBhBq/tU82vE+K7aIL+c0P46Pi64fpl48kTExZxPHP
	zUMqxzsRt9Pk5Oa0LRbDZ7L+Rf7Y4UhZ5PuGjk0jPXVsNjLUVqK4GfkESKhQSPMrzck=
X-Gm-Gg: AfdE7cmd2BXV/wa85yRPvmN2kDkpOEuXkHy5GpIMYS5MWpMatdis38CaDZubs/PbzRb
	Oz+cDxvThSwa1htWkzlBeqeou15OTTVk1HUcc8DxwuxEXYDL/6Le4PC3uFF4CA4J5KTM9qcBFHF
	nYcKV3p6kditQ3TvxsT+3RcjY9REWvPQgw2eejVKdsX3L5jhY1N4R6AyGzMG62RIt4g0rPYg5xc
	UTIA9kxUYPwqlwJErQq61Uk5zX+sK/pksUl1ZMuYauxWRqKNSQ14+9fJHUwdo6NldOob3LvjDdy
	cEPGv9s2Cj302YwV/sr5ySf5pafHlDroeJFBk1AIPverZl+2HcOhS6xkvXhmMHBJfYoUJax1EgA
	QTdROgNZ/oVjDWKQ+4G0+IiBiFDOkiTYSApfg9dKP3VhMSreJTSLnS/QwMIHTfpQASWiKPhK2sU
	APXAsfZmbTtkg7/m93+f2gNZR6vcKCKqdHF1dKNsx8pp1Q9YkV97+/NvKfvtfLme9nag==
X-Received: by 2002:a05:6000:46db:b0:461:a159:4a76 with SMTP id ffacd0b85a97d-4650005cbd3mr1261851f8f.1.1781861734702;
        Fri, 19 Jun 2026 02:35:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-465090c0f4esm6300085f8f.14.2026.06.19.02.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:35:34 -0700 (PDT)
Message-ID: <e4084afa-0f03-4dbd-a849-f4d4a0005262@6wind.com>
Date: Fri, 19 Jun 2026 11:35:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 4/6] ipv6: fix error handling in disable_policy sysctl
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: shemminger@vyatta.com, dforster@brocade.com, gospo@cumulusnetworks.com,
 ddutt@cumulusnetworks.com, brian.haley@hp.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org
References: <20260618162225.4588-1-fmancera@suse.de>
 <20260618162225.4588-5-fmancera@suse.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260618162225.4588-5-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TAGGED_FROM(0.00)[bounces-300669-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:shemminger@vyatta.com,m:dforster@brocade.com,m:gospo@cumulusnetworks.com,m:ddutt@cumulusnetworks.com,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email,6wind.com:from_mime,6wind.com:dkim,6wind.com:email,6wind.com:mid,6wind.com:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F23606A4FA7

Le 18/06/2026 à 18:22, Fernando Fernandez Mancera a écrit :
> When writing to the disable_policy sysctl, if proc_dointvec() fails to
> parse the input, it returns a negative error code. The current
> implementation is resetting the position argument even if an error
> occurred during proc_dointvec() and not only during sysctl restart.
> 
> Fix this by checking the return value of proc_dointvec() and returning
> early on failure.
> 
> Fixes: df789fe75206 ("ipv6: Provide ipv6 version of "disable_policy" sysctl")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

