Return-Path: <netdev+bounces-289524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULF0AhCWDGq/jQUAu9opvQ
	(envelope-from <netdev+bounces-289524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:55:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 782A3582B1E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B13363165CC1
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C58C369D48;
	Tue, 19 May 2026 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL0iXLDq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B17340404
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208746; cv=none; b=PtZXkGmf17yemKyNhm1BhgJPadUswW/HebV7skOT3AHNQ9i56E5iqZwtf3f24PD05wipdkG9Wrldniv31kU2WFPXgCbBMt1oWq6da3c3QukrRnrdrTrbhUQ0H7ewyp6w6DSg2noD3e6UtRBHMine63ct26xgGukQPuZSfBVSVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208746; c=relaxed/simple;
	bh=pqo6nhEaFqwKk9CGwK2WDegDArNbEt3Qy3PntN8qD+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gM79t9f3hUS9S/wt7y81FB7ZAebyQaIB7DH7JUtE8sFnGWWZzV8MlpAbunPy5q049HfYoX9dOK/pt5QtOQvaRxN6iffY78o20mgMIK4Oh2irk8mon77HKdolJfF1s7gn5MpJIH4dIx64dNysIcNCdIimDcqMVa8gRDLvHN8VvUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL0iXLDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650D9C2BCB3;
	Tue, 19 May 2026 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779208745;
	bh=pqo6nhEaFqwKk9CGwK2WDegDArNbEt3Qy3PntN8qD+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mL0iXLDqWvANbd6oQdqycxw1DJ6oYcRPmqvhDpQSMzk+ziCEcDBCyn52aHrmmzIuK
	 ZrESgKRkjdA4DDN5c78Ej8OqNm05bolqRa67ant65XDkiLCVRhp9la/Hlode5a3IlA
	 SXsLbED/s7IJ35gpMghUwCR0m8DOF+n4KLZiBTiR61Ziq7ITWNgglocD5Pg/cxR9fw
	 vaFOevhWjhDRqGA9SCT7w62YOV0byywoLj2LIiI9W81GYAMBG9jWvDB7UJ8FgyAf6e
	 18wejEa1BJnCAQmGacrxyg9JDVXzbnDgXxMQraIX4ISmsAR0qKIsQX7fyLQ6pfFUkU
	 +b2ehgzHxdCwg==
Date: Tue, 19 May 2026 09:39:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 1/2] rtnetlink: use nla_nest_end_safe() in
 rtnl_fill_prop_list()
Message-ID: <20260519093904.49298543@kernel.org>
In-Reply-To: <20260519114355.2769474-2-edumazet@google.com>
References: <20260519114355.2769474-1-edumazet@google.com>
	<20260519114355.2769474-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289524-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 782A3582B1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 11:43:54 +0000 Eric Dumazet wrote:
> Avoid corrupting a netlink message and confuse user space in the
> unlikely case rtnl_fill_prop_list was able to produce a very big
> nested element.

Should we not prevent it from happening in the first place?
IIUC otherwise if user adds a lot of altnames ip link will no longer
work?

> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 6a5e9ace55a0880d7b1e4303d12dc0a8b8b7c5ed..ae0254f19178735b2805a8189e81a960a49b2858 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1971,7 +1971,9 @@ static int rtnl_fill_prop_list(struct sk_buff *skb,
>  	if (ret <= 0)
>  		goto nest_cancel;
>  
> -	nla_nest_end(skb, prop_list);
> +	if (nla_nest_end_safe(skb, prop_list) < 0)
> +		goto nest_cancel;
> +
>  	return 0;
>  
>  nest_cancel:


