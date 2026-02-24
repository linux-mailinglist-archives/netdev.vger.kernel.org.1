Return-Path: <netdev+bounces-260321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAVUNpgZnWlsMwQAu9opvQ
	(envelope-from <netdev+bounces-260321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:23:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 076461815EF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 424E7307B7D7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74E1299A90;
	Tue, 24 Feb 2026 03:22:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AECD23EA8D
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771903361; cv=none; b=upBG00NsHmQwQMGY+4O+aw4BWrt2QIeYWYFPTXzEGD091Vly3AQCqf1aIsh/rF8g/CVTRRTqLSRP7a/054mo0pgLdcexBF73b9ROkUi5RUgwfMjyXraXrOeocdKJZ89zN9EZnskArQ0S8chF8bL2Jq9yrXrWSxSsw3OQ4eSBDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771903361; c=relaxed/simple;
	bh=VJ6oFAd0OCXycErHfZaQRIDwPe8bvGtv8S7E/IuaV5Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=X0hPOz8HeQl5UvUFs2IdM5ituDO23qyW7XAUdWjvdwXikysC35ItckF1AwlBdeFyovQ+kAtcONzRf008jaiPfbrB06Q6t2yDQzki+dK0R++aGxBEyjnSrs8cZzMTnrLM0TAsmtknGlWivaiVN7wiB1h32Sa1RXdPMYC7mF1eDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz2t1771903343t3d98926f
X-QQ-Originating-IP: ZQx4IBOe+4kUPBHKmpjzKLPUbcFQzQbV43M3OCbSu3M=
Received: from smtpclient.apple ( [120.244.235.1])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 11:22:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2625102856121023082
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next] net: core: introduce the
 netdev_fetch_core_stats()
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <CAL+tcoDR2-WTmhBakWcvEuLCwAU7RGRA8syfor-+RJJq7_ZOKw@mail.gmail.com>
Date: Tue, 24 Feb 2026 11:22:09 +0800
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <65307E32-7AFF-44EF-B2BB-89AA15F3D0D1@bamaicloud.com>
References: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
 <CAL+tcoDR2-WTmhBakWcvEuLCwAU7RGRA8syfor-+RJJq7_ZOKw@mail.gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MIAHdi1iQo+zMN8wWtWW/+40/WbVYgnb1gjbaGko1dCs3J8Fwdtl313E
	EH5DEFwS75QZZ83OiggdnAUhJfbf6/IaBbiBpxeK037P4lnHApDJv+Qgh6grqFEGhSzEOeU
	XBRrxWitWjVfhz2J49h3SithWcEiQaIcdnj5GFq5kUpzgdJWuRVCGETUfQ1QNOWri9iupok
	BWIKt8FALOnjTSFU3CtronwQbegZDpMj2UI7AarpDQS/Ig3J5A/zPuIobyzSJjX2Loo6ar1
	k65py/em137MTNBbDu5aC9A9XeoENAgU9WbcGhz8uJ7tw3VvlmLKRjgpphN7NPOE/AKugO8
	duhdi+gT5wy6lnaSjgDGrUaaGqR7Uf7wAx89rWPbITn1Ay4j6Ip3jwqMk42C3jO3dTaeyp+
	zEYdGC5kFauyywYKuL6bAWyirt/0PWwSZxkvZwcevvPTJHwXd6ufgnVxQE0UqxoCZqJ09V8
	r+9608UJrrXn8ZoLXrFd7umrvX37XMd1xFxsc0kFmDlX6eFG9YiYdOGN8UVw7qGvXheA2aE
	kKI2tNVj5GL3LOBfQG0dGVwCDtR3MG7PdMcC5jJfpGtLnebalYIE/M5i7NSTJpnirCUotKx
	x2otkmjkbZfescJQCXFofaWYAYh98uvRgFYAvkv33L71TD0eECQqU7yvgFyRwvZtQEiVQ8w
	wkuscvbE/YnkwqN4hNd1r8QE0kLPoc2gFXPcVu0T7j2Zqra8Ev6hj3w3HgPQznrVCGa69Z1
	CC5NeMynCwp0NmbVCc6v8+4PLBrl87UYRCGfQGfCsR6fbVXvqSACHkmTVmTYssw5f85wfBD
	UAzIjal50EhL5+JNe5nUuaxr5PxR871utn6gWmFb3ojArt7Xqhz3GplwUkj0u5X+tIBTWhh
	0c5EUSNWvwWs3KkV0N29wET1DgkIOxr8rgTHJ2ljolgUN8SxdV7nDqCyKLH4L8FFt1QAOEk
	tb7hMpMMb/wH+guwSlM4h0ZJP03aj629ERskelh0pwhcEsB9VOszbEOA/l5sg+0O7M6Kk0J
	MecRFQYcG0O8EEaDu1Mm8I90W51QUdvkvrPXob8Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[bamaicloud.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260321-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonghao@bamaicloud.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,bamaicloud.com:mid,bamaicloud.com:email]
X-Rspamd-Queue-Id: 076461815EF
X-Rspamd-Action: no action



> On Feb 23, 2026, at 08:20, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>=20
> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>=20
>> Network device statistics retrieved via procfs, sysfs, and netlink
>> represent the combined total of core_stats + driver, hardware =
statistics.
>>=20
>> However, in some scenarios, when monitoring netdev metrics, it is =
valuable
>> to clearly distinguish whether the values originate from the =
networking
>> stack's core statistics or from the driver, hardware layer. This =
helps
>> improve debugging and addressing issues.
>>=20
>> Approaches were considered:
>> - commit 5247dbf16cee ("net/core: Introduce =
netdev_core_stats_inc()").
>>  This allows tracking increments to core_stats and helps identify =
specific
>>  causes of changes, but not provide the total counters.
>> - extending rtnl_link_stats64 with new core_xxx fields.
>>  This would likely confuse or break existing userspace applications =
relying
>>  on this struct.
>> - adding a tracepoint inside dev_get_stats().
>>  This implementation is not simple or straightforward enough.
>>=20
>> The solution in this patch is therefore to introduce a new dedicated =
function
>> for collecting core statistics and mark it noinline. This approach is =
simple,
>> clean, and maintainable to obtain driver, hardware statistics =
separately when needed.
>>=20
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Stanislav Fomichev <sdf@fomichev.me>
>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
>> Cc: Samiullah Khawaja <skhawaja@google.com>
>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
>=20
> It's a simple refactor patch that only moves that logic to a new
> helper. I don't see any new possible callers right now so could you
> provide more straightward/clear use cases and intentions behind this
> patch? For example, give us what kind of dumping stats you want to
> tweak and your next movements.
Thanks, Jason
This patch tries to add one helper function which marked as noinline for =
bpf tracing (this commit 5247dbf16cee also use the noinline for =
tracing). This helper is not used other place in kernel.

For example,
sudo bpftrace -e '
  kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)arg1)->rx_dropped);}
  kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)retval)->rx_dropped);}
'
We can use bpftrace tool to trace the rx_dropped counter from driver, =
hardware, and from netdev core_stats. Why ?

Locating where the kernel is dropping packets
- If packets are being dropped in the network stack, use the dropwatch =
tool to obtain detailed skb.
- If packets are being dropped at the driver layer, determine whether =
the issue is with the driver itself (no skb free) or with the hardware =
(use the struct rtnl_link_stats64* from driver)=20

Note: Not all network drivers use the rx_missed_errors.

>=20
> Usually, a refactor patch comes with a bunch of patches that are going
> to use this helper.
>=20
> Thanks,
> Jason



