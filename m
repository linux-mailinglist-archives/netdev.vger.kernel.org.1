Return-Path: <netdev+bounces-301920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i6NuH7P8PGqgvQgAu9opvQ
	(envelope-from <netdev+bounces-301920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:02:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D236B6C4761
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:02:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=DjyEQ+ve;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301920-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301920-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 105933055D50
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D983CDBB7;
	Thu, 25 Jun 2026 10:00:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA96387345
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 10:00:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381633; cv=none; b=NsMa2BfDGQYywBOgr9yJOOfTjOfmCQi7fwagGldPR2RP7oEalsikRjg7gEv/GTEmsKjR80Y+Du4CJ8CdWWXlUyEuO59sp8/kMexH79+IRnFf8pO1qC8xYcySjbt6vl2vSy9mcRnkY/y3ZfYkXHTC7bAYd+FdGLPJNxKUwPwsgh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381633; c=relaxed/simple;
	bh=mM4Erhdqs5dGAvX86t2HWhP+eYFqprApKsJva3KiiJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAzZmVvklJpAmGv90KvnrxqdOB2Z2AbC6J0SpFFP/0Ya4uAq7/8X2XIq8PuOGINowSap5AntnsbpQbLzgOrTLBdeKaxZR6G5tJRLCXN2Mmmwf4iCc7ImlkdS+IzmyN1PrPHL8IhZqk4BUIJRtpdbdl40hTALujNmC1ElELFTklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=DjyEQ+ve; arc=none smtp.client-ip=209.85.167.41
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aea177627aso447347e87.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 03:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782381629; x=1782986429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kfvqp0FMHwIzAEoP9ZK6/aC9uV9vpu6XtwDN93+Lfpc=;
        b=DjyEQ+ve5w+KMkF8luduSW1EnT5DDISka7eRRP8A7+inBrsxgtgr8WIb0Dhl8fNtIi
         SkQrpEXB+M93y/UTcvqFuN3l/2ruLID3CawE0h7f9RAe85itLQc1zu0DWquCOIspql3I
         t9GhFQSfsirLWRs7GLOgJ4G/E+lhCRbwUQwAC/a8xjyOCusCusBs1cJd/jS9tBcjhXTK
         7o1ntwHhJV3+U6GGXeuPN8eLKEfb7op/9lS5e8FAXJ/1Hjzt5DQZs23sIkEJyZn3aGTG
         kJOzgwvhM3yKPKoGnBTbonG5h4gNKtRbIxleTEPYCbLpdpcNHJ+Cs3oXCKAzC20kZ/vG
         aMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782381629; x=1782986429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kfvqp0FMHwIzAEoP9ZK6/aC9uV9vpu6XtwDN93+Lfpc=;
        b=jxkQkXJY+aBZ1crh8chhGIsijhNA52S9a31ki2xUN50Ml5ywBwdjXcs5KW769EYKyh
         +QUJsTB07mFvRG/lNFbKthegwBtksS4U2mOIJF2qgo/R10N4Y0xo1o+r92Aw4mt4e3Aj
         lbKzcwI0hDc0QsYrnW0oFr13ei8+R6wPOaRszRuu5iUFHRdKgTSLOIdLVd0esqsAeYJy
         GHBOl44XghPZoeS+fTju5CXuyPw/zahTdrJ5PuejIzmJCSLrt0FEBH4cOHb4L0Im7JtA
         uByppFXfaj5INT97JHvIyuicBJeeobGkiH1f8/N5mzYFxMZmT4CiCdo7B2X32as94n4Y
         faCw==
X-Forwarded-Encrypted: i=1; AHgh+Rpdh6On6GWRGDgedoq0hxUchUdOO1lAYpaHZU2c5UyYALb4upTshwM54xixFGX7/EqQq6YsLbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1eLa8xZmIr6u6l4Wd1ilrBUF1U5lH1WecG1wqZ5Nx0P3mHh+
	kfWWYExydq/DypIxgwON7xAKicwtoDsKRlvWXecLHlmKPz9eZxmdJcoqRkxGNBt+gCvd
X-Gm-Gg: AfdE7cmJtynQVPsURU0ijWsi2a1wfnYGHdGhOt6sTfHGAH0qJcyT7XEZWx8RUs4kc5Z
	5g+/7oLr5Q2JSy9Lw7ZwxGcpbLwfCfeyTpR82nZRLYt0U7DBM3fN0j71VqGxi0Ch/K6iXBDOSBq
	BMYRc4xsrWj3WbOhzWFgR06q8hYXnqrn4cQJMNTdMx5w72aNFpjEFLYgRIWyt8o9WI954u6OTNL
	TlrkFQXWfQrPn7n8ri8SvfUc0z+5QTlfL0U46sEOfC09Gk9My8tF4RHkbysnfoW+fM8cZZVO9Fk
	4qCVAjbvHucYnKKYItZ2Jp5erUNZS63pzH1iQq2fSXipoE+8LxUPj7wjPjFYtsrh09i20InObRB
	6XFA0C7VpaxGCG9fywK0ni2GqEVgpOezuhKmRIzfPafR9vcct4bG/mIP31eG1mMb+i3V6ta9RRY
	GqOSATrV1QCHA7EHnMqRvgb/o3OdWyRME5Ma9aNrSAlA9YEw==
X-Received: by 2002:a05:6512:8342:b0:5ae:9d52:8ce with SMTP id 2adb3069b0e04-5aea1f290e4mr378980e87.1.1782381628133;
        Thu, 25 Jun 2026 03:00:28 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ae9d8fb537sm1407079e87.21.2026.06.25.03.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 03:00:27 -0700 (PDT)
Message-ID: <a0e53c0f-c4f0-4200-a88c-61469687269a@bynar.io>
Date: Thu, 25 Jun 2026 11:00:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tipc: fix out-of-bounds read in broadcast Gap ACK
 blocks
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jon Maloy <jmaloy@redhat.com>
References: <20260624135629.727262-1-sam@bynar.io>
 <GV1P189MB19881AD711511094760906DCC6EC2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <GV1P189MB19881AD711511094760906DCC6EC2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301920-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[bynar.io:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,bynar.io:dkim,bynar.io:mid,bynar.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D236B6C4761

On 25/06/2026 10:23, Tung Quang Nguyen wrote:
>> diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c index
>> 76a1585d3f6b..08637c3c9db0 100644
>> --- a/net/tipc/bcast.c
>> +++ b/net/tipc/bcast.c
>> @@ -497,11 +497,12 @@ void tipc_bcast_ack_rcv(struct net *net, struct
>> tipc_link *l,
>>   */
>> int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
>> 			struct tipc_msg *hdr,
>> -			struct sk_buff_head *retrq)
>> +			struct sk_buff_head *retrq, bool *valid)
>> {
>> 	struct sk_buff_head *inputq = &tipc_bc_base(net)->inputq;
>> 	struct tipc_gap_ack_blks *ga;
>> 	struct sk_buff_head xmitq;
>> +	u16 glen;
> 
> Move this variable declaration to the bottom to follow reverse xmas tree style.
> 
>> 	int rc = 0;
>>
>> 	__skb_queue_head_init(&xmitq);
>> @@ -510,13 +511,18 @@ int tipc_bcast_sync_rcv(struct net *net, struct
>> tipc_link *l,
>> 	if (msg_type(hdr) != STATE_MSG) {
>> 		tipc_link_bc_init_rcv(l, hdr);
>> 	} else if (!msg_bc_ack_invalid(hdr)) {
>> -		tipc_get_gap_ack_blks(&ga, l, hdr, false);
>> -		if (!sysctl_tipc_bc_retruni)
>> -			retrq = &xmitq;
>> -		rc = tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),
>> -					  msg_bc_gap(hdr), ga, &xmitq,
>> -					  retrq);
>> -		rc |= tipc_link_bc_sync_rcv(l, hdr, &xmitq);
>> +		glen = tipc_get_gap_ack_blks(&ga, l, hdr, false);
>> +		if (glen > msg_data_sz(hdr)) {
>> +			/* Malformed Gap ACK blocks; caller drops the msg */
>> +			*valid = false;
>> +		} else {
>> +			if (!sysctl_tipc_bc_retruni)
>> +				retrq = &xmitq;
>> +			rc = tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),
>> +						  msg_bc_gap(hdr), ga, &xmitq,
>> +						  retrq);
>> +			rc |= tipc_link_bc_sync_rcv(l, hdr, &xmitq);
>> +		}
>> 	}
>> 	tipc_bcast_unlock(net);
>>
>> diff --git a/net/tipc/bcast.h b/net/tipc/bcast.h index
>> 2d9352dc7b0e..55d17b5413e1 100644
>> --- a/net/tipc/bcast.h
>> +++ b/net/tipc/bcast.h
>> @@ -97,7 +97,7 @@ void tipc_bcast_ack_rcv(struct net *net, struct tipc_link *l,
>> 			struct tipc_msg *hdr);
>> int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
>> 			struct tipc_msg *hdr,
>> -			struct sk_buff_head *retrq);
>> +			struct sk_buff_head *retrq, bool *valid);
>> int tipc_nl_add_bc_link(struct net *net, struct tipc_nl_msg *msg,
>> 			struct tipc_link *bcl);
>> int tipc_nl_bc_link_set(struct net *net, struct nlattr *attrs[]); diff --git
>> a/net/tipc/node.c b/net/tipc/node.c index 97aa970a0d83..2887f94ee28f
>> 100644
>> --- a/net/tipc/node.c
>> +++ b/net/tipc/node.c
>> @@ -1831,12 +1831,13 @@ static void tipc_node_mcast_rcv(struct tipc_node
>> *n)  }
>>
>> static void tipc_node_bc_sync_rcv(struct tipc_node *n, struct tipc_msg *hdr,
>> -				  int bearer_id, struct sk_buff_head *xmitq)
>> +				  int bearer_id, struct sk_buff_head *xmitq,
>> +				  bool *valid)
>> {
>> 	struct tipc_link *ucl;
>> 	int rc;
>>
>> -	rc = tipc_bcast_sync_rcv(n->net, n->bc_entry.link, hdr, xmitq);
>> +	rc = tipc_bcast_sync_rcv(n->net, n->bc_entry.link, hdr, xmitq, valid);
> 
> 'valid' needs to be checked after this call. Then, return immediately if it is false.
> 
>>
>> 	if (rc & TIPC_LINK_DOWN_EVT) {
>> 		tipc_node_reset_links(n);
>> @@ -2140,12 +2141,18 @@ void tipc_rcv(struct net *net, struct sk_buff *skb,
>> struct tipc_bearer *b)
>>
>> 	/* Ensure broadcast reception is in synch with peer's send state */
>> 	if (unlikely(usr == LINK_PROTOCOL)) {
>> +		bool valid = true;
>> +
>> 		if (unlikely(skb_linearize(skb))) {
>> 			tipc_node_put(n);
>> 			goto discard;
>> 		}
>> 		hdr = buf_msg(skb);
>> -		tipc_node_bc_sync_rcv(n, hdr, bearer_id, &xmitq);
>> +		tipc_node_bc_sync_rcv(n, hdr, bearer_id, &xmitq, &valid);
>> +		if (!valid) {
>> +			tipc_node_put(n);
>> +			goto discard;
>> +		}
>> 	} else if (unlikely(tipc_link_acked(n->bc_entry.link) != bc_ack)) {
>> 		tipc_bcast_ack_rcv(net, n->bc_entry.link, hdr);
>> 	}
>>
>> base-commit: a986fde914d88af47eb78fd29c5d1af7952c3500
>> --
>> 2.54.0
> 

Thanks for the review, I'll address this in a v3.

