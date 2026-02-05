Return-Path: <netdev+bounces-257051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HmTM5lZhGl92gMAu9opvQ
	(envelope-from <netdev+bounces-257051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:49:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35521F0053
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5327301724A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB93195FB;
	Thu,  5 Feb 2026 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+l6F4Ey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE8155C82;
	Thu,  5 Feb 2026 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281329; cv=none; b=LoNxJoMFxk1GwupV/iWgdYhI2wHREueHFt6+B64+IxMo5iZsM2tR83tPDICBBUtpKx5l49rbruRQZw0Zmak3OGx0jr+Q4AFY+jGVuwyUZjwskjwNZCcGrjU8T5UTh9xbISunCqLa1S4urDv1q5EAOZJ/jmU2dklhh07sNe5OaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281329; c=relaxed/simple;
	bh=7WGYzvj+SUhdfVxlowxaOV3IwVaL8lRhNVvTBxDsSVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fv3TMPsnszBXhXMlL6PGhSZBNP9UG53RW/Hyjiwm6EUlyLPkiYbbvDl0JKCiEBhEjR5AADezqWQNfKaIz6GIFNcpkCsIbgKglDvniuFszXxjVK+ua0ziFp+jeMQXXLyncKtbIO+gUbxYja975E8t7VwYHFt3WUKxW5RtQ7z68TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+l6F4Ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8E6C4CEF7;
	Thu,  5 Feb 2026 08:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770281328;
	bh=7WGYzvj+SUhdfVxlowxaOV3IwVaL8lRhNVvTBxDsSVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k+l6F4EyooXlpS+/zHTNpbn/px1aM8VPaUxyL/6CWk53EfJFBeK1qcC63fnYMEzU8
	 XFuUw4/Z0FotaeLYdvRzu7022j32Gx7uZpcglnk1BZMTL2Xn/62OQCXvaewgEP2KV8
	 ZN5Oym/SCBdBTxkyQ1GYoJqGA6goeQ+SoAf/j0VPj3ymMRFIAXQsQ+dcpihxh3sZ3O
	 ultYYlMHUrNdvEUZQ5KBq7foxItCnvLt/fT/vHLuNC3RkiXNmZjRNs8+nfVUa7bdGk
	 aeMBRhHsSX4cB0CDdqZ/VfLAaQV0nSsifwhziLq9XYnGnzz/xi8tv9TFP2XJd88Rcs
	 8iUno/2u1zZxA==
Message-ID: <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org>
Date: Thu, 5 Feb 2026 09:48:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, carges@cloudflare.com, kernel-team@cloudflare.com
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260204190417.110f5498@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257051-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,toke.dk];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,redhat.com,kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 35521F0053
X-Rspamd-Action: no action



On 05/02/2026 04.04, Jakub Kicinski wrote:
> On Wed, 04 Feb 2026 18:02:49 +0100 Jesper Dangaard Brouer wrote:
>> RFC: Seeking feedback on this refactoring approach.
>>
>> This series refactors qdisc drop reason handling by introducing a dedicated
>> enum qdisc_drop_reason and trace_qdisc_drop tracepoint, providing qdisc
>> layer drop diagnostics with direct qdisc context visibility.
> 
> I like this!

Awesome, then I will continue in this direction :-)

> It will presumably require existing users to migrate over
> but sooner we do it the fewer users that have to move?

I agree. Existing users will loose some details, but the patchset
results in fallback to SKB_DROP_REASON_QDISC_DROP as a drop reason,
which existing tools/users will still handle.
(The more specific drop reason is now avail via trace_qdisc_drop).

Eric and Toke is this acceptable for your users?

In patch 1/3 I kept the qdisc "name" as part of the enum for FQ and
CAKE. IMHO this should be changed for next patchset, but I offer you the
chance to review and suggest generic naming (else I will choose).

--Jesper


