Return-Path: <netdev+bounces-305490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kS0ZI4AOTWpZuQEAu9opvQ
	(envelope-from <netdev+bounces-305490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:34:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9478771CAED
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:34:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Bi2ADeJy;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305490-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305490-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 425283075148
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B717404BFE;
	Tue,  7 Jul 2026 14:12:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0EE3246F4
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 14:12:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433563; cv=none; b=PRZPT4jEJ1ccmd/OBTZ4hshWj8u1DReUg2ApCr10NC7mKpL2I37tZTJfiSs/3SbO7Cjb590KfxqtgHZtN+Bk+U4UWJD2+c0tAEXAcxm45ufSwh8xr+NPka2U/OUuMvbGiPWeQ/yvZn/RxkmB3JncsGLF4iFlWUqkWW/o8jIs6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433563; c=relaxed/simple;
	bh=rG8Tdl+tZqfoovKZdkpekPym+FhuY3fTAlZYSrZY4Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7Nz90uL50IhlOCMVkcyqDdXCkIClBjm5vsdwwq3+sOpwUeuWLHVsiqU61hMLQyWgB5MLe1VnpilN3LGgpWDCVQuRz7aFnyhF8yi5tr/GBmhx8SHLlGStlx2W8+B7yFSg9FPg45K7NBVTjx7qPhWyTAjaao5f60wcRfe6irv74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi2ADeJy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCB31F000E9;
	Tue,  7 Jul 2026 14:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433561;
	bh=0nivO2iTi1ZRv2pWGPLE8NuE24J+JRMV2eKwipgWWY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bi2ADeJyxhyP4euu6iPcMT8aYpNj+FA3vjKF/sHR+OKXr4O3MJKXsF3hBNG/fFmLH
	 n52XY0HRFc5p2jHTaxpiy31xYYeT09vI5o2mKQ02uecyksrlcFvexDB5hXlAXxuUZF
	 G8ikO9km1OYBeP4zISPKTy9YZrMSiB0MMCfWsS9gceWpJesWOvR+8ZiOvNUou0tpu3
	 PbAxSxD+qtMT+XAUa0d4TKpLJWxuCz2eMZYr1P1uD5a3dBJBmE2vzKMj98qOgIdSo2
	 b5zKigD0omxnkj+PQ2/IEcQ95SthvCnfdvPB5xSFmIs11sto4KMvOr8mPGt7xnkfSp
	 BONUiMs5wPbsA==
Message-ID: <f9aac06f-25ca-40fb-9e47-d12398262c61@kernel.org>
Date: Tue, 7 Jul 2026 16:12:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v8 9/9] selftests: net: Add a test for BIG TCP in
 UDP tunnels
Content-Language: fr
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <20260706181941.385672-1-alice.kernel@fastmail.im>
 <20260706181941.385672-10-alice.kernel@fastmail.im>
 <80222d3f-e6cf-408b-b42f-0a2a6afce297@redhat.com>
 <48f70526-e4f1-472c-86f6-72c105853a21@app.fastmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <48f70526-e4f1-472c-86f6-72c105853a21@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305490-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alice.kernel@fastmail.im,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:pabeni@redhat.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:andrew@lunn.ch,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com,redhat.com,iogearbox.net,davemloft.net,google.com,blackwall.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nftables.org:url,mankier.com:url,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9478771CAED

Hi Alice,

On 07/07/2026 10:40, Alice Mikityanska wrote:
> On Tue, Jul 7, 2026, at 11:06, Paolo Abeni wrote:
>> On 7/6/26 8:19 PM, Alice Mikityanska wrote:

(...)

>>> +
>>> +cleanup_tunnel() {
>>> +	ip -netns "$CLIENT_NS" link del tun0
>>> +	ip -netns "$SERVER_NS" link del tun1
>>> +}
>>> +
>>> +cleanup() {
>>> +	ip netns pids "$SERVER_NS" | xargs -r kill
>>> +	ip netns pids "$CLIENT_NS" | xargs -r kill
>>> +	ip netns del "$SERVER_NS"
>>> +	ip netns del "$CLIENT_NS"
>>> +	rm -rf "$WORKDIR"
>>> +}
>>> +
>>> +do_test() {
>>> +	# When tx csum offload is off, software GSO is performed before passing the
>>> +	# packet to veth. Check BIG TCP packets inside the VXLAN tunnel to verify
>>> +	# the software checksum path: if the checksum code is broken, these packets
>>> +	# will be dropped.
>>> +	if [ "$2" = on ]; then
>>> +		CAPTURE_IFACE='link'
>>> +	else
>>> +		CAPTURE_IFACE='tun'
>>> +	fi
>>> +
>>> +	ip netns exec "$SERVER_NS" tcpdump -nn -s 256 -i "${CAPTURE_IFACE}1" greater 65536 -w "$WORKDIR/server.pcap" 2> /dev/null &
>>> +	TCPDUMP_SERVER_PID="$!"
>>> +	ip netns exec "$CLIENT_NS" tcpdump -nn -s 256 -i "${CAPTURE_IFACE}0" greater 65536 -w "$WORKDIR/client.pcap" 2> /dev/null &
>>> +	TCPDUMP_CLIENT_PID="$!"
>>> +
>>> +	# This filter doesn't capture all possible variants of SACK, but it's aimed
>>> +	# at the typical one where SACK follows after [nop, nop, timestamp, nop,
>>> +	# nop] (14 bytes after the 20-byte TCP header). IPv6 needs a separate match,
>>> +	# because man tcpdump says:
>>> +	# > Arithmetic expression against transport layer headers, like tcp[0], does
>>> +	# > not work against IPv6 packets.  It only looks at IPv4 packets.
>>> +	ip netns exec "$SERVER_NS" tcpdump -nn -s 256 -i "tun1" '(tcp[tcpflags] & (tcp-syn|tcp-ack) = tcp-ack and tcp[34:2] & 0xffc3 = 0x0502) or (ip6[6] = 0x06 and ip6[53] & 0x12 = 0x10 and ip6[74:2] & 0xffc3 = 0x0502)' -w "$WORKDIR/sack.pcap" 2> /dev/null &

The tcpdump commands might need to be used with ...

  --immediate-mode --packet-buffered

... but that's maybe not needed, see below.

>>> +	TCPDUMP_SACK_PID="$!"
>>> +
>>> +	if [ "$1" = 4 ]; then
>>> +		SERVER_IP="$SERVER_IP4_TUN"
>>> +		echo "Running IPv4 traffic in the tunnel"
>>> +	else
>>> +		SERVER_IP="$SERVER_IP6_TUN"
>>> +		echo "Running IPv6 traffic in the tunnel"
>>> +	fi
>>> +
>>> +	sleep 1 # Give tcpdump a second to spin up.

This is possibly not needed, see below.

>>> +	ip netns exec "$CLIENT_NS" netperf -t TCP_STREAM -l 5 -H "$SERVER_IP" -- \
>>> +		-m 80000 > /dev/null
>>> +	sleep 1 # Give tcpdump a second to process buffered packets.
>>> +	kill "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID" "$TCPDUMP_SACK_PID"
>>> +	wait "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID" "$TCPDUMP_SACK_PID"
>>> +	PACKETS_SERVER=$(tcpdump --count -r "$WORKDIR/server.pcap" 2> /dev/null | cut -d ' ' -f 1)
>>> +	PACKETS_CLIENT=$(tcpdump --count -r "$WORKDIR/client.pcap" 2> /dev/null | cut -d ' ' -f 1)
>>> +	PACKETS_SACK=$(tcpdump --count -r "$WORKDIR/sack.pcap" 2> /dev/null | cut -d ' ' -f 1)
>>> +
>>> +	echo "Captured BIG TCP RX packets: $PACKETS_SERVER"
>>> +	echo "Captured BIG TCP TX packets: $PACKETS_CLIENT"
>>> +	echo "Captured TCP SACK packets: $PACKETS_SACK"
>>> +	[ "$PACKETS_SERVER" -gt "$PACKETS_THRESHOLD" ] || return 1
>>> +	[ "$PACKETS_CLIENT" -gt "$PACKETS_THRESHOLD" ] || return 1
>>> +	[ "$PACKETS_SACK" -lt "$(( PACKETS_CLIENT / 2 ))" ] || return 1
>>
>> KCI fails here, see:
>>
>> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/722863/156-big-tcp-tunnels-sh/stdout
>>
>> possibly the above parsing is a bit fragile/tcpdump version's dependent?!?
> 
> TL/DR: I've seen this when I ran out of space in /tmp before adding -s 256.
> 
> Hmm, the changes I made in this iteration were aimed at addressing version-
> dependent behavior of tcpdump... I used to count the lines of its
> output. Newer tcpdump prints two lines per encapsulated packet. Older
> tcpdump can't parse BIG TCP in this test and prints one line per packet.
> To make it more robust, I decided to store the pcap and count the
> packets there (--count doesn't work with live capture when tcpdump is
> interrupted). The pitfall is that now it takes a few hundred megabytes
> in /tmp to store those pcaps.

Wow :)

If you need to keep tcpdump -- see below -- you can probably reduce even
more the packet size (-s 256), I don't know what's the minimum. And
purge the workdir in cleanup_tunnel().

> Now, seeing empty stdout from tcpdump could be if the pcap file is empty
> (doesn't contain the pcap header), because we ran out of space in /tmp
> (first two tcpdumps took all space, the third didn't write the header -
> I observed this behavior before I added -s 256). We don't see the
> corresponding error messages, because tcpdump starts with 2> /dev/null
> (otherwise it floods the screen with statistics). Could this be the
> reason? How much space is allocated for /tmp in the CI runners?
> 
> I can probably address it by limiting the overall number of captured
> packets with -c, but then I won't be able to compare $PACKETS_SACK
> relative to $PACKETS_CLIENT.

If you only need to count some packets matching a filter, what about
using Netfilter rules with a counter, instead of using pcap files?

You can have counters not attached to rules altering packets:

  https://wiki.nftables.org/wiki-nftables/index.php/Counters

It might even be easier to match the SACK packets, with the 'tcp option
sack' filter from nft [1]. And for the size, I guess you can use "meta
length > 65536" [2], or checking other fields from IP/TCP headers.

If you want to keep your cBPF filter, you can also use nfbpf_compile for
the translation, and use that with 'iptables -m bpf --bytecode <...>',
but it might not be needed.

[1] https://www.mankier.com/8/nft#Payload_Expressions-Extension_Header_Expressions
[2] https://www.mankier.com/8/nft#Primary_Expressions-Meta_Expressions

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


