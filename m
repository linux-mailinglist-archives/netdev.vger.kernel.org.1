Return-Path: <netdev+bounces-296952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jx1xAVvJJ2rQ2AIAu9opvQ
	(envelope-from <netdev+bounces-296952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:05:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBBA65D8D1
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:05:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=W21gvgDW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296952-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296952-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D639D309C7EC
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484A63E6DCF;
	Tue,  9 Jun 2026 07:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CF3E2765
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 07:55:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991745; cv=none; b=DT8QFCfNBJP8I2qNahQtwXnq40yclKW9/jibGHK/4NQCZ7lVW6wauv2+zItzkwOyBRveL4jz4KN2dUPhHF6iW0hnjkhXWLuRinT+ahZb3Ks/2RgtlQHh2TAr12p99cX9yEuLtmaObsyem/VZ7TEwPXbTcxzKcgm57F6wNIbvlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991745; c=relaxed/simple;
	bh=kNtcLPrqR1o6eBXFhKD6liUxhudNZZ2FtPtlu4s7Zig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kU0oj9VUGOx23ZjgY5kNvCKif91WNzHvUDxnwUvR7il/ItIUOIttUNRmMaDxJKdw8sRB4bK368WQzN81i+eJRoUOYnDJsRdi3AfLc+1n8YXrH4NcBVQtzwKtT1D3Xu8Rlb/p32SFLPGcGPIm8WnxncNVgunY/22ObaFVsyOxHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W21gvgDW; arc=none smtp.client-ip=117.135.210.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=hHba986NCcVmqx1DRZPfhhXqGJshO3QKKvka3mdsksM=;
	b=W21gvgDWBVmf1iJqASIKBxH1O1oSlbTUClqywQ/pgqoFbsEguV1HG5yjWLyx1I
	grg3vlbxhi1UnxxFfNDjRueip9g3+nqj//g7y+IBPREJOky7Kriy168NOMW2JxHG
	/y+TzU0HPW1/SR+ceeY5DuRPcQJy3E4EDp2asjqUnnNKw=
Received: from [113.54.240.206] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3frraxidqa2NwCQ--.56434S2;
	Tue, 09 Jun 2026 15:55:08 +0800 (CST)
Message-ID: <fbba10bb-ed0e-4181-ba42-a08c050ef676@163.com>
Date: Tue, 9 Jun 2026 15:54:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] selftests: tc-testing: cover malformed IFE
 decode frames
To: Jamal Hadi Salim <jhs@mojatatu.com>, Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, kuba@kernel.org, victor@mojatatu.com,
 yotam.gi@gmail.com, davem@davemloft.net, xiyou.wangcong@gmail.com,
 yuantan098@gmail.com, bird@lzu.edu.cn
References: <cover.1780901080.git.edragain@163.com>
 <cf59defd97a1ad7aed813573a24bccfa3e265e61.1780901080.git.edragain@163.com>
 <CAM0EoMmY94w+0RCeKnBTaujqZEK8MQG+twVdahQVht_G81QZ-g@mail.gmail.com>
From: Yong Wang <edragain@163.com>
In-Reply-To: <CAM0EoMmY94w+0RCeKnBTaujqZEK8MQG+twVdahQVht_G81QZ-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3frraxidqa2NwCQ--.56434S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr4xGw17Xw1UCF4DXFykAFb_yoW7ur15p3
	y8Ga1qyrWUtry7Aw1xX34qgF45XayfZrW7AF1Sqryjva95uFn3XFW7tr4UuaykWrWFv3ya
	ywnFqa17uw4kAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zReT5LUUUUU=
X-CM-SenderInfo: 5hgutwxdlqqiywtou0bp/xtbC1B1NbGonxt2LBgAA3z
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,mojatatu.com,gmail.com,davemloft.net,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:victor@mojatatu.com,m:yotam.gi@gmail.com,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:yotamgi@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edragain@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edragain@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[163.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEBBA65D8D1



在 2026/6/9 4:14, Jamal Hadi Salim 写道:
> On Mon, Jun 8, 2026 at 2:35 PM Ren Wei <n05ec@lzu.edu.cn> wrote:
>>
>> From: Yong Wang <edragain@163.com>
>>
>> Add a tc-testing regression case for IFE decode with a malformed
>> ETH_P_IFE frame carrying only the minimal IFE metadata header followed
>> by a truncated inner Ethernet header.
>>
>> The test installs an ingress flower rule with "action ife decode pipe"
>> and injects an IFE frame from scapy, then verifies packet accounting
>> through "tc -s -j filter show". Using JSON output makes the check less
>> sensitive to formatting differences in tc's text output.
>>
>> To let the testcase send the larger frame shape it needs, extend
>> scapyPlugin with an optional "mtu" field and apply it to the transmit
>> interface before sendp(). This is needed because nsPlugin creates DEV0
>> in the root namespace, so testcase setup commands executed inside the
>> test namespace cannot adjust DEV0 directly.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>> Assisted-by: Codex:gpt-5.4
>> Signed-off-by: Yong Wang <edragain@163.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>> ---
>> Changes in v2:
>> - add a tc-testing regression case for the malformed IFE decode frame
>> - add an optional mtu field to scapyPlugin for the reproducer
>> - v1 link: https://lore.kernel.org/all/6200dc9e5ea7a85d500e72543d897c2d930fcdce.1780809474.git.edragain@163.com/
>>
>>  .../tc-testing/plugin-lib/scapyPlugin.py      |  6 ++
>>  .../tc-testing/tc-tests/actions/ife.json      | 62 +++++++++++++++++++
>>  2 files changed, 68 insertions(+)
>>
>> diff --git a/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
>> index 254136e3da5a..e84b344dd1fa 100644
>> --- a/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
>> +++ b/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
>> @@ -50,5 +50,11 @@ class SubPlugin(TdcPlugin):
>>              if '$' in scapyinfo['iface']:
>>                  tpl = Template(scapyinfo['iface'])
>>                  scapyinfo['iface'] = tpl.safe_substitute(NAMES)
>> +            if 'mtu' in scapyinfo:
>> +                subprocess.run(
>> +                    [NAMES['IP'], 'link', 'set', 'dev',
>> +                     scapyinfo['iface'], 'mtu', str(scapyinfo['mtu'])],
>> +                    check=True, stdout=subprocess.DEVNULL,
>> +                    stderr=subprocess.DEVNULL, env=ENVIR)
>>              for count in range(scapyinfo['count']):
>>                  sendp(pkt, iface=scapyinfo['iface'])
>> diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
>> index 808aef4afe22..062efbe284dc 100644
>> --- a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
>> +++ b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
>> @@ -1378,5 +1378,67 @@
>>          "teardown": [
>>              "$TC actions flush action ife"
>>          ]
>> +    },
>> +    {
>> +        "id": "8a7c",
>> +        "name": "Decode malformed ife frame with truncated inner ethernet header",
>> +        "category": [
>> +            "actions",
>> +            "ife",
>> +            "scapy"
>> +        ],
>> +        "plugins": {
>> +            "requires": [
>> +                "nsPlugin",
>> +                "scapyPlugin"
>> +            ]
>> +        },
>> +        "setup": [
>> +            [
>> +                "$TC actions flush action ife",
>> +                0,
>> +                1,
>> +                255
>> +            ],
>> +            [
>> +                "$TC qdisc del dev $DEV1 clsact",
>> +                0,
>> +                1,
>> +                2,
>> +                255
>> +            ],
>> +            "$IP link set dev $DEV1 mtu 65535",
>> +            "$TC qdisc add dev $DEV1 clsact",
>> +            "$TC filter add dev $DEV1 ingress protocol 0xed3e prio 1 flower action ife decode pipe"
>> +        ],
>> +        "cmdUnderTest": "$TC -s -j filter show dev $DEV1 ingress",
>> +        "scapy": {
>> +            "iface": "$DEV0",
>> +            "count": 1,
>> +            "mtu": 65535,
> 
> I am not following - why is this the mtu being set?
> 
In this setup, nsPlugin creates $DEV0/$DEV1 as a veth pair. A veth device uses the normal Ethernet default MTU via ether_setup(), which sets dev->mtu = ETH_DATA_LEN, and ETH_DATA_LEN is 1500. To send big payload(>1500), setting mtu is needed.
>> +            "packet": "Ether(dst='ff:ff:ff:ff:ff:ff', type=0xED3E)/Raw(b'\\x00\\x02' + b'\\xcc' * 14 + b'\\xdd' * (5000 - 16 - 14))"
> 
> 
> And why do you need such a big payload?
> 
I tested this locally and found that the minimum packet length that reliably triggers the panic in my setup is about 4080 bytes.
I guess that is because the reproducer needs to cross the AF_PACKET allocation threshold in packet_alloc_skb():

    if (prepad + len < PAGE_SIZE || !linear)
        linear = len;

Below that threshold, the packet appears to stay fully linear, which does not reproduce the non-linear inner-header condition needed for the eth_type_trans() crash. So the crafted frame needs to be at least that large to reliably trigger the original panic path.
> 
>> +        },
>> +        "expExitCode": "0",
>> +        "verifyCmd": "$TC -s -j filter show dev $DEV1 ingress",
>> +        "matchJSON": [
>> +            {
>> +                "kind": "flower"
>> +            },
>> +            {
>> +                "options": {
>> +                    "actions": [
>> +                        {
>> +                            "kind": "ife",
>> +                            "stats": {
>> +                                "packets": 1
>> +                            }
>> +                        }
> 
> Should you not be checking for a drop here?
> 
Yes, I will modify it right away.
> The AI didn't do a good job here.
> Please use Victor's patch and resend. Also the tdc testcase should be
> patch 2 not 1.
> 
> cheers,
> jamal
> 
I tested Victor's testcase locally. It does cover the truncated inner-header case, but it did not trigger the panic I originally observed.
Would you prefer that I resend the series using Victor's testcase anyway, or sending a tdc testcase which trigger panic? 
Also I will adjust the patch ordering.
Thanks,
Yong
> 
>> +                    ]
>> +                }
>> +            }
>> +        ],
>> +        "teardown": [
>> +            "$TC qdisc del dev $DEV1 clsact"
>> +        ]
>>      }
>>  ]
>> --
>> 2.34.1
>>


