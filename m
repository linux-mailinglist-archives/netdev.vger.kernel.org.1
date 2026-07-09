Return-Path: <netdev+bounces-306211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NPpiLpmUT2pakAIAu9opvQ
	(envelope-from <netdev+bounces-306211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:31:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F646730FE9
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:31:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JQFdS78B;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306211-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306211-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A60F301187C
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F1F42189B;
	Thu,  9 Jul 2026 12:27:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7FE3F23AF;
	Thu,  9 Jul 2026 12:27:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600023; cv=none; b=P2MOHpyQdKYgsBHrSCEikN7rJv/3JyCwAyiPDD9B57Krg7MqUlNcD35tIThQVOn0RNUdQ7W8+nxEk563sm/XNmiGEWIOU9ArL8NbcT/px58DS6VvR8Ae3KkCO6ZooSyB20WlOZaG/18vRPghGG8nvJSfennm+piujyuZVZQ1yNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600023; c=relaxed/simple;
	bh=v1Fh7OWmq/hgyatfTis5Tnl4T9pLqRXS/pUE1Bio3gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDXTxznTcvKnda1I3PB8MpZKx4xg29AGVwGuG4KI3rt2vvnGeU3rLUWMtziPi3X7/S5UshaE6LJ3FmrLX8NAJIDH5oCUjNxfvgI8qJ5JkQtaqYnt9sYlAwKuMCUlncGWg+Piy2Y7J/iaNTIc2AC9jY9Zn1364YRTQXTjnMcLxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQFdS78B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128771F000E9;
	Thu,  9 Jul 2026 12:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783600022;
	bh=xVHh7g8SYwYGJGtfysLs07tEzq4wF0oBi4U8l3YY2Xc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JQFdS78BckhReHmupxhHrvodd7wWnuHp3wRPS/TNTgf3GSf1wjG1i/1JBAILu20qo
	 vCja3fQCT91vNvUOnZWkYHl7J+m2sUsE4ui/BOVqsY/DPELxBDUYnEy981fYuN/Yk5
	 TbmV6jjo0rW/j9qrKqAi4dvys1IK5Qv3Fiap2SDeTJjsFG9l8ntkPV+5uCLvL01rmI
	 i70oQfltPnA+7L3O/e5WnB8oiIu7yzmpWabl1FRWGU8E0AILItBI0Ca55bgmau/tnT
	 qQvHUdH8rtg6mMrcuZJi8OVKUCu3asPQJOZg14yipSb5pqwL4YRyXHNArsGjw4lWrl
	 Qeaknd+5Hqs6Q==
Message-ID: <8d735844-dccb-4a65-b7fc-468d144ebc02@kernel.org>
Date: Thu, 9 Jul 2026 14:26:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2] mptcp: only set DATA_FIN when a mapping is present
Content-Language: fr
To: gang.yan@linux.dev, Michael Bommarito <michael.bommarito@gmail.com>
Cc: Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 mptcp@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mat Martineau <martineau@kernel.org>
References: <2edcb1cd-f2db-4d0c-a0e3-fd2b4dd820fe@redhat.com>
 <20260707171730.2679013-1-michael.bommarito@gmail.com>
 <8155514655323d8c4a07da86d2b2ccdd7244c125@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8155514655323d8c4a07da86d2b2ccdd7244c125@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306211-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gang.yan@linux.dev,m:michael.bommarito@gmail.com,m:geliang@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:mptcp@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:martineau@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F646730FE9

Hi Michael, Gang,

On 09/07/2026 07:43, gang.yan@linux.dev wrote:
> July 8, 2026 at 1:17 AM, "Michael Bommarito" <michael.bommarito@gmail.com> wrote:

Thank you for this patch and the review!

>> mptcp_get_options() clears only the status group of struct
>> mptcp_options_received; data_seq, subflow_seq and data_len are filled in
>> by mptcp_parse_option() exclusively inside the DSS mapping block, which
>> runs only when the DSS M (mapping present) bit is set.
>>
>> A peer can send a DSS option with the DATA_FIN flag set but the mapping
>> bit clear. The parser then records mp_opt->data_fin while leaving
>> data_len and data_seq uninitialized. For a zero-length segment
>> mptcp_incoming_options() evaluates

By chance, do you have a reproducer? Maybe using Packetdrill with MPTCP
support? [1]
If not, how did you discover this issue?

[1] https://github.com/multipath-tcp/packetdrill/

>>  if (mp_opt.data_fin && mp_opt.data_len == 1 &&
>>  mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
>>
>> which reads the uninitialized data_len and data_seq; KMSAN reports an
>> uninit-value in mptcp_incoming_options(). The stale data_seq can also be
>> fed into the receive-side DATA_FIN sequence tracking.
>>
>> Record the DATA_FIN flag only when the DSS option carries a mapping, so
>> data_fin is never set without data_seq and data_len also being present.
>> data_fin is part of the status group that mptcp_get_options() clears up
>> front, so on the no-map path it stays zero and the zero-length DATA_FIN
>> branch is simply skipped. A DATA_FIN is always transmitted together with
>> a mapping (mptcp_write_data_fin() sets use_map along with data_seq and
>> data_len), so legitimate DATA_FIN handling is unaffected.
>>
>> Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
>> ---
>> v2: adopt Paolo Abeni's suggested approach - do not set mp_opt->data_fin
>>  at all unless a mapping is present, rather than gating the consumer in
>>  mptcp_incoming_options() (v1). data_fin then defaults to the value
>>  mptcp_get_options() already clears it to (0) on the no-map path, so
>>  the uninitialized data_len/data_seq are never read.
>>
>>  net/mptcp/options.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index dff3fd5d3b559..6d003b24b969f 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -157,7 +157,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>  ptr++;
>>
>>  flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
>> - mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
>>  mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
>>  mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
>>  mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
>> @@ -178,6 +177,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>  }
>>
>>  if (mp_opt->use_map) {
>> + mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
>>  if (mp_opt->dsn64)
>>  expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
>>  else
> 
> One minor thing I noticed while reviewing: Sashiko previously pointed out
> in a comment that the 'pr_debug' logging 'mp_opt->data_fin' might be
> problematic because it's printed before data_fin is actually assigned
> (since data_fin is now set only inside the if (mp_opt->use_map) block). 
> 
> I think it would be cleaner to move the pr_debug call after the data_fin
> assignment, so the logged value is always meaningful and consistent with
> the actual parsed state, like:

(...)
> This change isn't critical to the fix itself, so feel free to let Paolo/Matt and
> other Maintainers decide if it should go in now, later, or not at all.

Probably best to fix that now, to avoid getting confused when looking at
debug info. Do you mind doing that in a v3, please?

pw-bot: changes-requested

> A couple of additional notes for future submissions (just friendly reminders):
> 
> - The subject-prefix convention for MPTCP patches is typically [PATCH mptcp-net]
>   for bug fixes targeting the net tree, or [PATCH mptcp-next] for new features.
>   Since this is a fix, something like [PATCH mptcp-net v2] would be more appropriate.

For a "one-off" or urgent fix for MPTCP, that's OK to send patches to
the netdev ML directly. In this case, please use the "net" prefix, see:

  https://docs.kernel.org/process/maintainer-netdev.html

For other kind of patches specific to MPTCP, please send them only to
the MPTCP ML with the 'mptcp-net' or 'mptcp-next' prefixes. Just to be
clear: here you can send the v3 to the same people and lists -- you
missed Simon apparently, did you not use get_maintainer.pl script? --
with the 'net' prefix ([PATCH net v3]).

> - It's also helpful to include a Link: to the previous version (v1) in the changelog,
>   so reviewers can easily track the discussion history.

If I may add, please also send new version in a separate thread, not as
a reply, not to confuse various tools, as mentioned in the same doc.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


