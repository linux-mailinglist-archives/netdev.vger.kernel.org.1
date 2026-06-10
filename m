Return-Path: <netdev+bounces-297504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JPYjBGQWKWpDQQMAu9opvQ
	(envelope-from <netdev+bounces-297504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:46:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAAA666BFA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:46:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=NlTKYY+Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297504-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297504-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D9B0300145F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE28379C48;
	Wed, 10 Jun 2026 07:46:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B340D579
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 07:46:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077598; cv=none; b=HGewuwAkBPcnxxkSyzd3F4oXh6abUomSI40j88y5KjntIAgaJNdreXd2hTAURpjpdvqedu96Lp3XhebKsqPnGbR7ewadr02miyyZ+24VrvFwsYPoCLERBYxNdBheSWIclg1pzxFKiUvSx8gBgVynj0v60xyHSmOxD1HGXHrhLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077598; c=relaxed/simple;
	bh=BGxOPzKCsGSWGDDVbrx1+2glkJU3h3SG7ZpZIDJEFuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h499morTqnv+2MoU3+FeqE9yhYtjA5YuLRPNe3x/owMHI6hG4oGU76JoO2uKiDropRBjuEhX0HdlK9i/Uq/Smj68ZI1Mzfh4LxYvg39TQRiHzQhp3usCoXGWqqZdKVegiEfU2UBwerIyr8Un5wsOYm/+El04E1x1ze8JTSti9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=NlTKYY+Z; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef93a0b0fso466094f8f.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781077595; x=1781682395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SObXAXUcSqE1fMMR5i4St6mHoA5lmoaB8Ys6HIQuvLk=;
        b=NlTKYY+ZJmBVPq6CRE6F9Mydpj97/iT9TQ/Cz5sBYcvhw89drc3+Lmw5kiRc/2/gSR
         +0gXorVd3llJqB22HZkmA937fvjq10IWNUeDu35C9ubn7p0ZwnEmcyt1HvLp+GmOYor0
         H5d12GFBjaZMB+5MDOW7CCspB3vPOm/lunfc73wtpwBYdwACdnRecBEGYxJUMYhOwo+F
         HIUvQsIasKqhCOTV1MpLQMwd2huIgjPTcxeK6MFF9ruqJFJ6P667NAukKpYPn9CMrhlL
         FSXkX/pJ44yYpxMR95zXp9DVQ2Tn8f2l0qFjBWSOGEGALCG5DUWFgJyeb8rrcZyXr8Ho
         Lw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781077595; x=1781682395;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SObXAXUcSqE1fMMR5i4St6mHoA5lmoaB8Ys6HIQuvLk=;
        b=pOA51OgrGjUrs5gx53zj5SIy15qECqldfgU9TDr3iyhFEWq71Tvtel9gcjWG4LdU6d
         Jjnt8ewLaffdioHp7m1PuM/Ecq83GLBBfh7mCOjlw3p1McvgPVsAGsOSS7bdDkWObOmm
         SZpyqzQrq/BT6iAIZpC/LgpxhkgD6+sitFDloU35G5eLpXwEyBeiVIF+c94LS0lZrs3G
         blIEGJnv6WW9n7bUsDE1Ra3g4y/d+5MIO5LbDJcF8GVeSio0iizS9KIwD17Bih0P3+8U
         7aFee5DRrrl/8LvvrwIr1gCqDr6ADbFYt9Mzzr6APm5fKP40bPmNV9So2lxgH5EjpyEx
         K4CQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FCPTERlHroGfcQscTg6p/lub+tsqCP7q4qlmVF/bO5SyqHluVcOC2RQc2oQaZ0VnsbdeVKiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSLSmF8MaMDuwHjEj/mdaRXwwHrwZuOlmTVKQ+TpkJYS44AQOF
	4seklWt+HLbLPOLUeT2FfNWrCX7WEzFVNMX6fsRmMdg7lHTteSJhcTCboAZTdOHsfEo=
X-Gm-Gg: Acq92OHtCOOLZo1Lt+RumvLlVAwdHcGLIrOT41XbJSEW0J8JjLBcSszsV7R08GrdPfW
	qsHCWEvRQJcg1X+JZVpZnVyfDlrXxgL/CuY1Uc6OXLpYpODGmuRqDUhO+qePQ7ustpmpQ8R62Qx
	M439v2v9hG6cmqdjuc42g0dyYrIWfIWMFGvAmP8hv8izTzFRNZqkYhHBNbi1gqy07KO2M2Tl68m
	c+hrZMWkXuUCerwbl1h5jcRgvcRB199/rvxiaZUUlFRAvtErLsd7DDY0TL6Kz3mpmeqxR1Wfvx1
	bxR7YODSUQV3rAP8IPcuGgxFAdycm53tV5nQzeS+iDuvX7JCvPiU9hUeOkOmszWqhc5BVbK3kqN
	j+t4dTpwEtZkUrtOCDbBeBW/2hdXJ9Q+JJmfM62B5+ypfp6tDYLCIeYcQv59gvru9SSJV97mjes
	IwEBpud/th5FoWmReDWFFJ1MhNV7BerATE7g5kjtUu/tm/dcw2vFUXBOmi+d8MYZyExCTAmVHmZ
	TTz/vm1dynyFTs=
X-Received: by 2002:adf:fcc9:0:b0:45e:91ec:d4c4 with SMTP id ffacd0b85a97d-4603065c0d9mr11649970f8f.7.1781077594792;
        Wed, 10 Jun 2026 00:46:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm122564997f8f.27.2026.06.10.00.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 00:46:34 -0700 (PDT)
Message-ID: <bb33e686-c00b-47e1-82a4-716ffb529d5c@6wind.com>
Date: Wed, 10 Jun 2026 09:46:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] ip6_vti: fix incorrect tunnel matching in
 vti6_tnl_lookup()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Steffen Klassert <steffen.klassert@secunet.com>
References: <20260608164613.933023-1-edumazet@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260608164613.933023-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297504-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:steffen.klassert@secunet.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,secunet.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AAAA666BFA

Le 08/06/2026 à 18:46, Eric Dumazet a écrit :
> In vti6_tnl_lookup(), when an exact match for a tunnel fails,
> the code falls back to searching for wildcard tunnels:
> 
> - Tunnels matching the packet's local address, with any remote address
>   wildcard remote).
> 
> - Tunnels matching the packet's remote address, with any local address
>   (wildcard local).
> 
> However, vti6 stores all these different types of tunnels in the same
> hash table (ip6n->tnls_r_l) prone to hash collisions.
> 
> The bug is that the fallback search loops in vti6_tnl_lookup() were
> missing checks to ensure that the candidate tunnel actually has
> a wildcard address.
> 
> Fixes: fbe68ee87522 ("vti6: Add a lookup method for tunnels with wildcard endpoints.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

