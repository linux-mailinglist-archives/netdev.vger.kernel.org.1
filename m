Return-Path: <netdev+bounces-282838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IzOLJtL82kTzQEAu9opvQ
	(envelope-from <netdev+bounces-282838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:31:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C610C4A2C57
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 648AD300D171
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B51E4AF;
	Thu, 30 Apr 2026 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgLyMkTi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18313DDAE
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552268; cv=none; b=cEi1MMuKTVFTaiFv/mpGOiQsZngyLRJfdBk1xN/RkcwXRkgrEW4EMK5O0v0kxRRFKczkjo8YxJjOUiC5NB+e4YFFNznYq9NXRcu+Uih/dwrOYebCYYHHDkqMjUy1j+iXh/9kcKczRS7XmUlecaAdfJT7ptSPJ9UBZc36w67ErMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552268; c=relaxed/simple;
	bh=Fp6nDvrdJ0an0Bdrc/rA4+2C/js0byI0WoX7NJWs4vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPqApafgJBdPDJEw3Ia25rIlgUzEbNV+hs7MNPcXAm4jal105TfYcAfNpClKRlFi87wEE5cPk3SwwfDipp4MR2PbhnYd9JHcVYVrm0tmK0tRQmZIHvppq9OxKPc7wVEKj1jgZtkv8chAMksD0TlASFDcihhJyZBX3TP7vmooBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgLyMkTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F14BC2BCB3;
	Thu, 30 Apr 2026 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777552268;
	bh=Fp6nDvrdJ0an0Bdrc/rA4+2C/js0byI0WoX7NJWs4vA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pgLyMkTiyi8SFM/bzhidlofi3hmOnpPZ3WgG6HpkNTBPvXBHcHxTy+xC5M9K7GCl4
	 C/Ak/Cwh885KmWBQoE8irULblICMT0ZhE1BV7RIH4yc6X4mihwtjms5GUG6oz+H49d
	 tOd30USNmI+S5VL06FfucLQxsBofO0UTl2t6zZxNy/xdne0CVusfq0+GSWuSmEB11i
	 Bsqt5Mf1YbrX05D883ueN7q8gEoQSBjV7bnEv7Aeev1OpUSiz1be7LGkjWWvNG7E9R
	 4B+0E3g+TjCDWitUoCjwlPqKvrBAP00KYsDBgGWPq0SPM8+dO/NkNhgwl3pjgBHN3m
	 CFIUu9smaMfcQ==
Message-ID: <e599e4e9-3440-4a20-9911-c75edad7850e@kernel.org>
Date: Thu, 30 Apr 2026 14:31:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] selftests: net: add veth BQL stress test
To: Simon Schippers <simon.schippers@tu-dortmund.de>,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 kernel-team@cloudflare.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <20260324174719.1224337-7-hawk@kernel.org>
 <02a713ac-f794-416f-9d69-95ea98d515b6@tu-dortmund.de>
 <1c435d90-8d08-4ac1-8b84-cc72c0b4e30f@tu-berlin.de>
 <7bc8edc9-1b46-471a-9a6e-cd2c27aebcfc@tu-dortmund.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <7bc8edc9-1b46-471a-9a6e-cd2c27aebcfc@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C610C4A2C57
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282838-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 30/04/2026 11.45, Simon Schippers wrote:
> On 4/30/26 11:17, Jonas Köppeler wrote:
>> On 3/28/26 4:19 PM, Simon Schippers wrote:
>>> Hi, thanks for your work! I am really interested in this patchset.
>>>
>>> I am planning to submit a similar patch set (see [1]) for the tun/tap
>>> driver, where I am currently implementing qdisc backpressure similar
>>> to that used in veth.
>>>
>>> Can you run pktgen [2] to see if there is a regression?
>>> I think that there might be a slowdown due to BQL not choosing a big
>>> enough queue size.
>> I ran some tests using pktgen by replacing the trafficgen from the
>> selftest with samples/pktgen/pktgen_sample01_simple.sh (Patch v3)
>> and used --nrules 0. In general the throughput is quite similar:
>>
>> BQL disabled (using --bql-disable):
>>    2378694pps 1141Mb/sec (1141773120bps) errors: 0
>>    2400898pps 1152Mb/sec (1152431040bps) errors: 0
>>    2358125pps 1131Mb/sec (1131900000bps) errors: 0
>>    2402034pps 1152Mb/sec (1152976320bps) errors: 0
>>    2362061pps 1133Mb/sec (1133789280bps) errors: 0
>>    2416301pps 1159Mb/sec (1159824480bps) errors: 0
>>    2398496pps 1151Mb/sec (1151278080bps) errors: 0
>>    2415200pps 1159Mb/sec (1159296000bps) errors: 0
>>    2375921pps 1140Mb/sec (1140442080bps) errors: 0
>>    2427419pps 1165Mb/sec (1165161120bps) errors: 0
>>    2382461pps 1143Mb/sec (1143581280bps) errors: 0
>>
>>    mean: 2392510pps
>>
>> BQL enabled:
>>    2159545pps 1036Mb/sec (1036581600bps) errors: 0
>>    2321899pps 1114Mb/sec (1114511520bps) errors: 0
>>    2477853pps 1189Mb/sec (1189369440bps) errors: 0
>>    2447857pps 1174Mb/sec (1174971360bps) errors: 0
>>    2400284pps 1152Mb/sec (1152136320bps) errors: 0
>>    2442841pps 1172Mb/sec (1172563680bps) errors: 0
>>    2442540pps 1172Mb/sec (1172419200bps) errors: 0
>>    2410585pps 1157Mb/sec (1157080800bps) errors: 0
>>    2395902pps 1150Mb/sec (1150032960bps) errors: 0
>>    2393260pps 1148Mb/sec (1148764800bps) errors: 0
>>    2401959pps 1152Mb/sec (1152940320bps) errors: 0
>>
>>    mean: 2390411pps
>>
>> BQL enabled is ~2099pps (~0.09%) lower than BQL disabled.
> 
> Sounds great!
> 
> One more thing:
> Could you check what BQL limit settles during the test run using
> something like:
> 
> watch -n 0.1 'cat /sys/class/net/XXXXX/queues/tx-0/byte_queue_limits/limit'

FYI: The selftest already tracks BQL "limit" and "inflight".
- Jonas can just report those BQL inflight logs

+print_periodic_stats() {
+    local elapsed="$1"
+
+    # BQL stats and watchdog counter
+    WD_CNT=$(cat /sys/class/net/${VETH_A}/queues/tx-0/tx_timeout \
+        2>/dev/null) || WD_CNT="?"
+    if [ -n "$BQL_DIR" ] && [ -d "$BQL_DIR" ]; then
+        INFLIGHT=$(cat "$BQL_DIR/inflight" 2>/dev/null || echo "?")
+        LIMIT=$(cat "$BQL_DIR/limit" 2>/dev/null || echo "?")
+        echo "  [${elapsed}s] BQL inflight=${INFLIGHT} limit=${LIMIT}" \
+            "watchdog=${WD_CNT}"
+    else
+        echo "  [${elapsed}s] watchdog=${WD_CNT} (no BQL sysfs)"
+    fi


> I guess it will just choose the ptr_ring size as limit in this case,
> but it would be nice if you could briefly verify this :)
> 
> Thanks!
> 
>>
>>> Thanks!
>>>
>>> [1] Link:https://lore.kernel.org/all/20260312130639.138988-1-simon.schippers@tu-dortmund.de/
>>> [2] Link:https://www.kernel.org/doc/html/latest/networking/pktgen.html


