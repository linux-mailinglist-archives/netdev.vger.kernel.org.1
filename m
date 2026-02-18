Return-Path: <netdev+bounces-259350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BQ4KDsNlmmNZQIAu9opvQ
	(envelope-from <netdev+bounces-259350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 20:04:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 131C5158E1A
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 20:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D5B530137AC
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3DB2D0C79;
	Wed, 18 Feb 2026 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0NuuTL5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968CE2BE7DB;
	Wed, 18 Feb 2026 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441404; cv=none; b=c2LSNjI1mav9ZKtbW5CsQbqK0C6GoUsLcG9O/XGXDbKLIIN3USfR6DULF9VtrJJc1c7BEKmb4rESyLzxm1enUkrlae6mj+Jfq4SMrDcE5/Fv5GmdbqHbhvCcWQPOazk4PM6QjtQxnui/R6eVC73MHTuzuNO5x1GmWP9ntaJGl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441404; c=relaxed/simple;
	bh=BAQtKcmUqn0rzieOnfXIH8svXhZHRYWkh8xiImtkSCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkvKIn6P9vnHPIMGTjPHW+FolbbS3m/Odb4uSYFdHoW5KW0T1UUvL8AMDiGg/YyUkAJPqD6yRIYghsCDxxQ///vtgvBUF/yCtodg6MgkdjY0A8GwRjGQhLDNPpcK/evsMrY0V2Jf9PcSUP+vfDO/paIxk2SuN+SovB+0l4e+nZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0NuuTL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521D3C19422;
	Wed, 18 Feb 2026 19:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771441404;
	bh=BAQtKcmUqn0rzieOnfXIH8svXhZHRYWkh8xiImtkSCg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o0NuuTL5RKY39y4U0t3bBDMTIIjT7Se1zgarexM4mBmr1bCyLhiQJUrJFy2PWSYUp
	 KwAfflmTqoNnbidvZ6edufO6WKSzpDNVh309jCgvrWf3ds+6K9WtgtMEmceUKj4EwN
	 YdOmEGJ8Eg3VMPWJI+7YpTm5p/8Yk84uymMnig7qIEvYJgGgMao3wJRmwBMgdgL51y
	 qhDKDQxYsJ9QX2OR58BvZKCmMqf8yw4eaNi96td30QPjsalfGY0fg5yx5X+WMWm7Q2
	 4vcPcRWSZevtVq1iCsA1AxYQv31u+rjjbe6L5ET//JQa2pF0pTZ2HZmKeoOSw2Hotm
	 X2KSiP8PLAgFw==
Message-ID: <a44c1f27-e9f0-4f33-beda-e5f611197e35@kernel.org>
Date: Wed, 18 Feb 2026 20:03:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH iproute2 1/2] mptcp: monitor: also show iface name
Content-Language: en-GB, fr-BE
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
References: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
 <20260211-mptcp-color-v1-1-01832777611d@kernel.org>
 <20260218103155.486d20ee@phoenix.local>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260218103155.486d20ee@phoenix.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259350-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 131C5158E1A
X-Rspamd-Action: no action

Hi Stephen,

Thank you for the review!

On 18/02/2026 19:31, Stephen Hemminger wrote:
> On Wed, 11 Feb 2026 13:03:17 +0100
> "Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:
> 
>> @@ -530,7 +541,7 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
>>  	if (tb[MPTCP_ATTR_TIMEOUT])
>>  		printf(" timeout=%u", rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
>>  	if (tb[MPTCP_ATTR_IF_IDX])
>> -		printf(" ifindex=%d", rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
>> +		print_iface(rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
>>  	if (tb[MPTCP_ATTR_RESET_REASON])
>>  		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
>>  	if (tb[MPTCP_ATTR_RESET_FLAGS])
> 
> 
> The whole monitor message output format here is divergent from what other
> iproute2 commands do. If you look at ip monitor there are no '=' signs
> in the output.

Indeed, the output is different from 'ip monitor' (but similar to 'ip
ioam monitor').

> Please fix the whole function.

Doing that would likely break scripts parsing 'ip mptcp monitor' output,
are you sure we should still change this output format?

Please note that compared to 'ip monitor', this commands can print quite
a few attributes, and I guess the '=' signs have been added to improve
the parsing (or even the reading?).

  [         CREATED] token=d8392d7c remid=0 locid=0 saddr6=2001:db8:1234:5678:302e:d9cb:3bca:3d88 daddr6=2001:41d0:a:ffcf:1234:5678:8765:1 sport=57432 dport=443 deny_join_id0
  [     ESTABLISHED] token=d8392d7c remid=0 locid=0 saddr6=2001:db8:1234:5678:302e:d9cb:3bca:3d88 daddr6=2001:41d0:a:ffcf:1234:5678:8765:1 sport=57432 dport=443 deny_join_id0
  [       ANNOUNCED] token=d8392d7c remid=1 daddr4=5.196.67.297 dport=443
  [  SF_ESTABLISHED] token=d8392d7c remid=0 locid=22 saddr6=2001:db8:1234:5678:20e:c6ff:fed9:8d06 daddr6=2001:41d0:a:ffcf:1234:5678:8765:1 sport=38949 dport=443 backup=0 ifindex=23
  [         SF_PRIO] token=d8392d7c remid=0 locid=22 saddr6=2001:db8:1234:5678:20e:c6ff:fed9:8d06 daddr6=2001:41d0:a:ffcf:1234:5678:8765:1 sport=38949 dport=443 backup=1 ifindex=23
  [  SF_ESTABLISHED] token=d8392d7c remid=0 locid=27 saddr6=2001:db8:1234:5678:d892:9a8:b192:3428 daddr6=2001:41d0:a:ffcf:1234:5678:8765:1 sport=53295 dport=443 backup=0 ifindex=5
  [       SF_CLOSED] token=d8392d7c remid=0 locid=22 saddr6=2001:db8:1234:5678:20e:c6ff:fed9:8d06 daddr6=2001:41d0:a:ffcf:1234:5678:8765:1 sport=38949 dport=443 backup=1 ifindex=23 error=104
  [          CLOSED] token=d8392d7c

The event type and the way it is displayed is also specific to 'ip mptcp
monitor'.

> Ideally all of iproute commands should
> support JSON in monitor mode as well. But that is a bigger effort.

I agree with you. I guess we copied the behaviour of 'ip monitor' here.
If there is a JSON support, we can probably more easily change the plain
text output format to force people to use the JSON one if still needed.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


