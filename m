Return-Path: <netdev+bounces-303191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TcmEJkPJQ2qRhwoAu9opvQ
	(envelope-from <netdev+bounces-303191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:48:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DFF6E5094
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:48:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=clw6wptu;
	dkim=pass header.d=redhat.com header.s=google header.b=eZfAZj9Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303191-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303191-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9FD2300B538
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9240B6D4;
	Tue, 30 Jun 2026 13:44:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95C40B36D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 13:44:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827099; cv=none; b=g6VEOOM6E+0Z1t8Ro5Wf4N8Ar2nHQu4/HiBbmeZhal9EHNkirIN+G1OgtsQ3N7Dmwkj7sHUIf/hWmjy+9wV135pnkiRsLrxocj8ZgVs1Vk2Rf6qvR3bKQ8+gmsfnAAl0nHDKIlcSouH/3Kk4j2uOsD/pnXQcE9xiVXDAXVT8QOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827099; c=relaxed/simple;
	bh=RNPdt2HnyVOABAodLZxb6B2fL4fbL8igULWr0b8w+u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2zvwgRtUpTKJt0jlxg+lPxjYZx/YyXbFUkMNTcy8pmHnyt7UipNBx81L7VnY4+vSnac7PXAFcQOpvWRqo4xlA1MzJx2PJoHws70fvektgmyeOC3P/Iw+r66rQ9OBTtO6XfqsRQXBUrYYN7PLX7WbXkxl2tw2iTDgdKNqEE0PUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clw6wptu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZfAZj9Q; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782827097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXLaTYlnLvmlrMc9lJjuVsUwudoVr81cKx9gTU2bmR8=;
	b=clw6wptuelluQNeGvfZiuwdSe9s1mjGcjFfy4VYfMgUas+mxq7PR4i3kGP/umJ3ENeB3Se
	HgH78dGBw/m7IEcBlGVnDF/jAgeF1AAhpYsyqXGEgOWThU6FkuseaR1KLyGnhz/kGQfYu/
	/E5k3pSjUUbP+VtOTGrtkf01uHZFZAA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Ob2QSBdINwySTHYIDlic0A-1; Tue, 30 Jun 2026 09:44:55 -0400
X-MC-Unique: Ob2QSBdINwySTHYIDlic0A-1
X-Mimecast-MFC-AGG-ID: Ob2QSBdINwySTHYIDlic0A_1782827095
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4744b72f90bso1349596f8f.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782827094; x=1783431894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXLaTYlnLvmlrMc9lJjuVsUwudoVr81cKx9gTU2bmR8=;
        b=eZfAZj9QhxoStgMAi9G/072Hpqn6Su99tCV+gPmWPAm97qXERdurRncv73e4MDnPKi
         Gymmoc54m7GbgFDvt2nUQXdCmrV2jLEWagYWjhIAhcqagJYwRqcPWVUjiid7gEY/q+Ux
         o901yAqdCKp5teHBiM83J3uZfwmsr48gbc/RTlLKoyy0w9z2V49b3dVMDjUu8+b92dwF
         gG8b6bpaQiVg25gdh98pKrdQwgqOfT0QZAzXPf/RFusNw/pOVDe+vxrS4Mj+QapLVRlp
         Bamy1oprQvfe++8DDbc8s9uRGgcTWWOy7KX3e+VQ/qj0JOBaM29OmXcqE1JqakKQyUaU
         xRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827094; x=1783431894;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXLaTYlnLvmlrMc9lJjuVsUwudoVr81cKx9gTU2bmR8=;
        b=dRzUSNliMbC2H0vz60DdUFqbz4Qbkze31lj72kP26t1QVwNi2+TNtzZxA+mz2eoW3m
         owc88knUuPaIAYgf05RNfQGVXAnfPrU49vih53yuii0Mk+6zWfr6vVD8jz/YACMUofax
         51mQNI6B1T41vH5cNFZ4NmJ2jJR8iZ5tH+o2kjwaCJvYJqmB9tCVjBlKs3ijybL2EOa/
         oFGiUxPw8xxREHINS25hnM7tSEdhXX/zZqeloVpHyUIGHN4B2JNvphrgieW2z/SbG3Yh
         DpL7sr+20DeGsfzjhfgri2KsHe8X0W7jgRyxd2fDhwmQMiGwn1V/fGH9XCw1im4Ot+Ld
         pq+A==
X-Forwarded-Encrypted: i=1; AFNElJ/juON+Q3TjVjNIip5BgYXR2POciN4jv5VBtYW4h+yjRSgHD2fJFtEuAA0e0Fvp1YnL2dlr7NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5hrJuvLzuKCoibpAy45N7/u7nXMUEqXeO5zb47y4oTVGhd6n
	xH/ojPoqUJWPfBNqxVQ7ql81VP66cbAl4vuiz3vEJHWWgZjCPzF1wZq9/ynWoM9f9M1EtXUCLHw
	aO6Ka4yKyY5diaunU2dhDhzJa/prJy1ej1m2JyStlOI0BWljf+n4/fsrwug==
X-Gm-Gg: AfdE7cm29KF621aB/xHW6OvwrQcIg0QtL9ijgKoNUQIJ3hhVxoRLITSUt0LKTyfuMcm
	2KYtJDBR62kV0ejv57eJ6ucXJtxaLvfThw1Ewbes2Xc4vgKPXR5RU3yWcw9bcsfv2aQPEUc7Q5H
	DUHWDaapwmVGQ8cEdYZNVNjWPevZIbf8iiwX2xrplj+cigEkrj6+DlVEc8NFxFtgnS4RuiQ52wB
	y/hwSUw6BbUStZ2cFgXGtmou9DC+DxbaEOb1cP5nRlkRFxBfNQh2ldS4w7DdzLoLcP461UGisKR
	lWmh5b01k4m6/tP8GX0cH7b08SaAPW6tACWGo5oQx/yMl8dk9IGLVL4OR00aVANS1m+sePfdhXG
	Bg9Jc7K/NkVEQeeAH4bgHBt0L513w7O49Lh5nz/nG4HVBjkRG6tvFwVAEFFFE/3LTOiynM4PxVt
	5xAg00786aLg==
X-Received: by 2002:a05:600c:3546:b0:492:6113:d4fc with SMTP id 5b1f17b1804b1-493b82ad209mr54241625e9.17.1782827094568;
        Tue, 30 Jun 2026 06:44:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3546:b0:492:6113:d4fc with SMTP id 5b1f17b1804b1-493b82ad209mr54241175e9.17.1782827094116;
        Tue, 30 Jun 2026 06:44:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8c79baasm72553465e9.7.2026.06.30.06.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 06:44:53 -0700 (PDT)
Message-ID: <ecafc86b-c6e5-4225-afda-4a1fb02eb7c9@redhat.com>
Date: Tue, 30 Jun 2026 15:44:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/sched: act_nat: only rewrite IPv4 packets
To: Samuel Moelius <sam.moelius@trailofbits.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 "open list:TC subsystem" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260628132029.2209612.f2aaf6467355.act-nat-non-ipv4@trailofbits.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260628132029.2209612.f2aaf6467355.act-nat-non-ipv4@trailofbits.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303191-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,trailofbits.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91DFF6E5094

On 6/28/26 3:20 PM, Samuel Moelius wrote:
> act_nat can process packets whose protocol is not IPv4 and then
> interpret the payload as an IPv4 header.  Non-IPv4 packets may be
> modified based on unrelated bytes at the network header offset.
> 
> The action is documented as IPv4 NAT and should leave other protocols
> alone.
> 
> Check skb->protocol before parsing and rewriting the IPv4 header.  This
> keeps accepting hardware-accelerated VLAN IPv4 packets whose network
> header already points at the IPv4 header, while still rejecting inline
> VLAN packets because act_nat does not adjust the network header offset
> before using ip_hdr(skb).
> 
> Fixes: b4219952356b ("[PKT_SCHED]: Add stateless NAT")
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
> Changes in v3:
>   - Check skb->protocol
> Changes in v2:
>   - Check skb_protocol(skb, false)
> 
>  net/sched/act_nat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> index abb332dee836..1bf4a5853617 100644
> --- a/net/sched/act_nat.c
> +++ b/net/sched/act_nat.c
> @@ -142,6 +142,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
>  	egress = parms->flags & TCA_NAT_FLAG_EGRESS;
>  
>  	noff = skb_network_offset(skb);
> +	if (skb->protocol != htons(ETH_P_IP))

AFAICS, in the xmit path, for actions applied at the H/W NIC level,
without vlan H/W offload, the above test check will fail, even if the
current code would work just fine (skb->network_header points to the
actual IPv4 header).

My take is implementing a robust and safe check here would be overkill.
Users should attach the action to the correct filter.

/P



> +		goto out;
> +
>  	if (!pskb_may_pull(skb, sizeof(*iph) + noff))
>  		goto drop;
>  


