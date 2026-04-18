Return-Path: <netdev+bounces-279501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFHuA7KA42kFHwEAu9opvQ
	(envelope-from <netdev+bounces-279501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:01:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338C4211FA
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 277A0304D422
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9443612FE;
	Sat, 18 Apr 2026 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oh6D9G4K"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C59360751
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776517151; cv=none; b=K4KGKu5HuRLtpucHx3e1kwdsUia4cseYwRwrlL8of8BO2dgZaB5ZqKIPlkwZDLfVW6pamenHlTMM0+GbGjlf6j7Z3PpCUfYix07zi04rjyKq/U+csJSuROflCGqCWxKU7ixU7QRv5AilHm99MQWIQzaig9O44x4vHdFeE1NQCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776517151; c=relaxed/simple;
	bh=NACCEhgMB0fi3KwjcL+tN0Fu1vQMiLUW+qExAieSYjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3nIV/vAALUVo20A8Lf4aZts4rFaS/ZOE7CErkPGoq9vtZXeG9N4tzYSOSYY92b6ktus7Gqpej4PF1jTcen1M19dobeKdEJQpy5zyhrxYg0IHk5t0zD6yo7vG9aqjDa6wOUo64B6ToXzg5PTryzAErDYvkkPza9jamxwRyb3LN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oh6D9G4K; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Hb/OQb50dQR9oEezvreYZuE7Wc7pCcqweV6KumSEwG0=; b=oh6D9G4KpJdlsQMcAsyRgBU97D
	5XFDbUF8v91h19mkDwd0kJr8CytirXDikGG5IDgZBaD6KcOgTac3NizS6M5qD3OThKPHWmRjNqUmp
	65KqIP34nR6KSX/RLUd01+sRHzDGmcJ9F/8gXZqO6NuGsEm4X2Vp9kkkhnT3JQElewrpTP06Qgnhe
	I+StsutjP1ThuEZkmEX5CwjU+JvwXX40HQv3nEzfrhYpcn2pcfRJJHE5RX20RDB6BLkjUXxptCNAE
	vbszFuQvWHO+B/NwKrbbBcRvLVKAoG3NTHdHxwEBIAA1XUG9eDW7CR82RDpUaKU0Gj3Db2HJKWd1f
	4TmVi4nA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wE5GO-000CgE-2H;
	Sat, 18 Apr 2026 14:59:08 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wE5GN-000BLb-18;
	Sat, 18 Apr 2026 14:59:08 +0200
Message-ID: <d4c72730-2d74-4efe-8ede-50e3fe9658c8@iogearbox.net>
Date: Sat, 18 Apr 2026 14:59:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Implement limits on extension header parsing
To: Justin Iurman <justin.iurman@gmail.com>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260417171831.687053-1-daniel@iogearbox.net>
 <60b47924-dae4-4a10-b977-75b92e1094c0@gmail.com>
 <ae053593-907e-4891-90fb-03b4c5d8f5e1@iogearbox.net>
 <b57f31a2-456e-4727-839a-bc2f0fb07855@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <b57f31a2-456e-4727-839a-bc2f0fb07855@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27975/Sat Apr 18 08:26:10 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-279501-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5338C4211FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/26 2:50 PM, Justin Iurman wrote:
> On 4/18/26 14:26, Daniel Borkmann wrote:
>> On 4/18/26 1:45 PM, Justin Iurman wrote:
>>> On 4/17/26 19:18, Daniel Borkmann wrote:
>> [...]
>>>> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
>>>> index d2cd33e2698d..93f865545a7c 100644
>>>> --- a/net/ipv6/sysctl_net_ipv6.c
>>>> +++ b/net/ipv6/sysctl_net_ipv6.c
>>>> @@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] = {
>>>>           .extra1        = SYSCTL_ZERO,
>>>>           .extra2        = &flowlabel_reflect_max,
>>>>       },
>>>> +    {
>>>> +        .procname    = "max_ext_hdrs_number",
>>>> +        .data        = &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
>>>> +        .maxlen        = sizeof(int),
>>>> +        .mode        = 0644,
>>>> +        .proc_handler    = proc_dointvec_minmax,
>>>> +        .extra1        = SYSCTL_ONE,
>>>> +    },
>>>>       {
>>>>           .procname    = "max_dst_opts_number",
>>>>           .data        = &init_net.ipv6.sysctl.max_dst_opts_cnt,
>>>
>>> NACKed-by: Justin Iurman <justin.iurman@gmail.com>
>>>
>>> +1000 on the need, but NAK on the way it is done. IMO, we don't want yet-another-sysctl for that. Instead, we have (well, not yet, but it's about time) this series [1] to enforce ordering and occurrences of Extension Headers, which is based on an IETF draft [2] (FYI, draft- ietf-6man-eh-limits is dead). I think we should enforce ordering and occurrences in this code path too, instead of relying on a sysctl. Let's keep both code paths consistent.
> 
> Hi Daniel,
> 
>> Hm, that series [1] should probably go to net instead of net-next, but atm
> 
> +1, would make sense.
> 
>> hasn't moved since a month. I'd still think max_ext_hdrs_number would be
>> useful given it has less complexity also for stable, but I guess ultimately
>> up to maintainers..
> 
> In the short term, I agree. What worries me is that we end up with a redundant, or even useless, sysctl once the other series is applied, which will only increase user confusion.
I'm thinking even if that series lands, and there is still odd hw out there
where the enforcement of ordering is not in place, and users might be forced
to disable net.ipv6.enforce_ext_hdr_order, then the limit would still apply
and protect them.

Cheers,
Daniel

