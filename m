Return-Path: <netdev+bounces-296708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M56NKY0jJ2r8sQIAu9opvQ
	(envelope-from <netdev+bounces-296708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:18:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A265A5B2
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:18:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=Tuwt8g5T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296708-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296708-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D804330022B5
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 20:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090353C3452;
	Mon,  8 Jun 2026 20:14:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6794A3E7151
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 20:14:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949690; cv=pass; b=kJh8/QkDdd7vLCoQzYeJLKrbQyWlIdjAQpvSXTrLdx5xQmsKPf3OwouKCpXi5W1JkU7yTLGeeJPfEFAjBFDgLiuKMxuRvahjPGz1z8kb4F6X9YS68a+Dbr0L7a9KwgTHz8HoVX3lKsEk9f0TvVyQvV4/FcqAJvYD6U0RmJd1qGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949690; c=relaxed/simple;
	bh=kq9uRLzaMdAuuk8IlVYC3QJzmj2qbwdd5rShMGMYnWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxNw5RtczLtVT7iLOP1sKzMcsbjruiFxOWugbnkLYzCZyn4BCOCPPubHXzF+joZNoqoirdBT573pkA9pCtg97Srnf7YIMk9+u7jpyntMFx63V+KgyuP3Eg2w7PoAjMx2kwK1XoM7wIAXYO7yN3Jcd+EjG6FlFC+vWBKzhgBfsP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Tuwt8g5T; arc=pass smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423f236418so2550173b3a.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 13:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780949689; cv=none;
        d=google.com; s=arc-20240605;
        b=J37eO/EpSTTLrHM5jyuhk3yfpXI9J0MhV95I5mJATbY89Zing+DzlM0vmMpempfWcX
         0kT5eavsbbS6GKefBmrrfgaIXG0QXD4iHccFx2z4NTzk4SMuX/MV77KS8FQO3PUUewti
         g2wjp+TxmkDh2Kh9zyhsNw10jYWEGs7g8sMvY2lyMrKsdcoqJrhdsEv0/Twk9WTlBHK0
         /jyikWeCb0g5n0sXZDG16tGjL9ASdiaqxROuu+WT7wPHC9stPXOBV9Y0I9js/Ngs2dG0
         JbQeInS9TcaH7rkIRL/TQCim/vBPtPLVa3YgUX9O6dDP85JOSM0zUL1PMKV9QSHRpjQH
         ykew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4EipHquVVSvZ/f+Jv9NwCxpHXm3qd1HMWW1tFXTOg5o=;
        fh=Vny/eXAmIU3/qNw+sWgj4CJtkUtvxXxrSgGE4Sf7FJ0=;
        b=cxPUSc6mytZDgMDd7rZI6M1jTpYeF9Qpp/l5m8Cei3PEXamHXvrtgc7otPRE74oA8V
         MvYPE0CyWNwlzduCb9UdpsuZKOBoJDldquRKg7u0sakUuIQN3NODYI1fXiNqI2pAtlH8
         z2hM1j/mqa5norBmaFrCG75neT8nTiz2iA5R3b0mqowUOjnbXimy0S+0gaseYAnxmWSj
         GZbiOd3LekFypkqIsYC8EvDysG0LCzQysvLp7coayz+OiaS0nyhVF14wtZiKna8Mwj+B
         F44ELjx7vOOvVKjrzx2/Z7LShcLUC6upRNqwSS75+FX4URETdAsB/wrsJNmqrCEaZ3yZ
         Mm2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780949689; x=1781554489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EipHquVVSvZ/f+Jv9NwCxpHXm3qd1HMWW1tFXTOg5o=;
        b=Tuwt8g5TW4gKIY5C1XbDCmrSTxiP3G40EwggwFitSKbAka+h+nGBbVfHlpMEqqbNYZ
         ODMz93ici/p78CSmhatCk7OtXzOXrq/GgZ78lgRPp9Q9bZ5pRHGT6yYW7hGD5rfvT2r0
         Lwwzy3G4JxNpO6KzuKeO6AWC/A7Ji4KpW+z64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949689; x=1781554489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4EipHquVVSvZ/f+Jv9NwCxpHXm3qd1HMWW1tFXTOg5o=;
        b=g7VyOa/+xnc+DlQr6pAIrDS3rqmEN8I6p18w3JH98Abu1kqcPfLx2QN1IzS1x6/s35
         e0WYvA7VDmYo1wm8KGNZ1ypbd0tHpT1qNzOPTx6r6ZkBeHgq6i4zopqssEUiZnhqE9J4
         8b860ijmk8R3G7NhEsosA8QgRQ3jOkA60SsNyWUJPY+TFHsl59GlcDo2vu+lHex4JfIJ
         uc5J9OqLXuGHFS4dNyG4bo9AKKmrlQNS/HoTZSGLQ7X9g7kjInK7UxhVDpwgVLbMq/nb
         yB6PdHF/RfE1F6gB9z5Ft+j35gQw+1ZGk4HQ1dPWyqVbBLPf2N7Qfi8UgxoUpDtIILF7
         F3nQ==
X-Gm-Message-State: AOJu0YwF3jx0bm081By0kUQr/p0yPv5RuFGPcKjtYYAvIDvrqExpXIJk
	G6dOBDRqgGbx7DV9Y7UQyj+a9lLmOLWIIQm4M9CNqBQOZRBsniFwdNttGjDkEnPSFFNb+Qlrfp3
	pfMuju2V53cJf84Et/mRPLQTt53ApYgenazXKw6/F
X-Gm-Gg: Acq92OHsNox+DH8LLBxWDnK5kHj0s8YxDaAP+Ec6WlPq5+R2bVI/vaTzk3wLfbpDsAU
	j1FgYiB5lOjDm+GalpUcdzcZ3mf9weej4kMKCb6iF9CrZy9KnmII0skhDk7ncp+ttPDf4UKBjDM
	Hb/hSgEnkPByjzt3nUId76REBFt67J7SD0PcfN97OuPFvAf2TunUv+2AHaEAEo9FZZGbh38Pxqv
	pEPWa8EH9vQ/yvT/++IVPZwhXIq4se0iYWYylGAK0sUyHVgZ0vKuW0Jt/lDUdjEUFmeRTlgj+KY
	nNyaIYrhrPCsKg01Yhk=
X-Received: by 2002:a05:6a00:a227:b0:842:2cda:7aa3 with SMTP id
 d2e1a72fcca58-842b0f4d4f8mr16844403b3a.28.1780949688692; Mon, 08 Jun 2026
 13:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780901080.git.edragain@163.com> <cf59defd97a1ad7aed813573a24bccfa3e265e61.1780901080.git.edragain@163.com>
In-Reply-To: <cf59defd97a1ad7aed813573a24bccfa3e265e61.1780901080.git.edragain@163.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 8 Jun 2026 16:14:37 -0400
X-Gm-Features: AVVi8Cd-geYnXBF7jQMC7bNn32RlUGsUA7bVpvoN1cLEiZ1rmtXYTmkzIznVg2k
Message-ID: <CAM0EoMmY94w+0RCeKnBTaujqZEK8MQG+twVdahQVht_G81QZ-g@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] selftests: tc-testing: cover malformed IFE
 decode frames
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, kuba@kernel.org, victor@mojatatu.com, 
	yotam.gi@gmail.com, davem@davemloft.net, xiyou.wangcong@gmail.com, 
	yuantan098@gmail.com, bird@lzu.edu.cn, edragain@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296708-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:victor@mojatatu.com,m:yotam.gi@gmail.com,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:edragain@163.com,m:yotamgi@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,mojatatu.com,gmail.com,davemloft.net,lzu.edu.cn,163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 216A265A5B2

On Mon, Jun 8, 2026 at 2:35=E2=80=AFPM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Yong Wang <edragain@163.com>
>
> Add a tc-testing regression case for IFE decode with a malformed
> ETH_P_IFE frame carrying only the minimal IFE metadata header followed
> by a truncated inner Ethernet header.
>
> The test installs an ingress flower rule with "action ife decode pipe"
> and injects an IFE frame from scapy, then verifies packet accounting
> through "tc -s -j filter show". Using JSON output makes the check less
> sensitive to formatting differences in tc's text output.
>
> To let the testcase send the larger frame shape it needs, extend
> scapyPlugin with an optional "mtu" field and apply it to the transmit
> interface before sendp(). This is needed because nsPlugin creates DEV0
> in the root namespace, so testcase setup commands executed inside the
> test namespace cannot adjust DEV0 directly.
>
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Yong Wang <edragain@163.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> Changes in v2:
> - add a tc-testing regression case for the malformed IFE decode frame
> - add an optional mtu field to scapyPlugin for the reproducer
> - v1 link: https://lore.kernel.org/all/6200dc9e5ea7a85d500e72543d897c2d93=
0fcdce.1780809474.git.edragain@163.com/
>
>  .../tc-testing/plugin-lib/scapyPlugin.py      |  6 ++
>  .../tc-testing/tc-tests/actions/ife.json      | 62 +++++++++++++++++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py=
 b/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
> index 254136e3da5a..e84b344dd1fa 100644
> --- a/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
> +++ b/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
> @@ -50,5 +50,11 @@ class SubPlugin(TdcPlugin):
>              if '$' in scapyinfo['iface']:
>                  tpl =3D Template(scapyinfo['iface'])
>                  scapyinfo['iface'] =3D tpl.safe_substitute(NAMES)
> +            if 'mtu' in scapyinfo:
> +                subprocess.run(
> +                    [NAMES['IP'], 'link', 'set', 'dev',
> +                     scapyinfo['iface'], 'mtu', str(scapyinfo['mtu'])],
> +                    check=3DTrue, stdout=3Dsubprocess.DEVNULL,
> +                    stderr=3Dsubprocess.DEVNULL, env=3DENVIR)
>              for count in range(scapyinfo['count']):
>                  sendp(pkt, iface=3Dscapyinfo['iface'])
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json=
 b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
> index 808aef4afe22..062efbe284dc 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
> @@ -1378,5 +1378,67 @@
>          "teardown": [
>              "$TC actions flush action ife"
>          ]
> +    },
> +    {
> +        "id": "8a7c",
> +        "name": "Decode malformed ife frame with truncated inner etherne=
t header",
> +        "category": [
> +            "actions",
> +            "ife",
> +            "scapy"
> +        ],
> +        "plugins": {
> +            "requires": [
> +                "nsPlugin",
> +                "scapyPlugin"
> +            ]
> +        },
> +        "setup": [
> +            [
> +                "$TC actions flush action ife",
> +                0,
> +                1,
> +                255
> +            ],
> +            [
> +                "$TC qdisc del dev $DEV1 clsact",
> +                0,
> +                1,
> +                2,
> +                255
> +            ],
> +            "$IP link set dev $DEV1 mtu 65535",
> +            "$TC qdisc add dev $DEV1 clsact",
> +            "$TC filter add dev $DEV1 ingress protocol 0xed3e prio 1 flo=
wer action ife decode pipe"
> +        ],
> +        "cmdUnderTest": "$TC -s -j filter show dev $DEV1 ingress",
> +        "scapy": {
> +            "iface": "$DEV0",
> +            "count": 1,
> +            "mtu": 65535,

I am not following - why is this the mtu being set?

> +            "packet": "Ether(dst=3D'ff:ff:ff:ff:ff:ff', type=3D0xED3E)/R=
aw(b'\\x00\\x02' + b'\\xcc' * 14 + b'\\xdd' * (5000 - 16 - 14))"


And why do you need such a big payload?


> +        },
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -s -j filter show dev $DEV1 ingress",
> +        "matchJSON": [
> +            {
> +                "kind": "flower"
> +            },
> +            {
> +                "options": {
> +                    "actions": [
> +                        {
> +                            "kind": "ife",
> +                            "stats": {
> +                                "packets": 1
> +                            }
> +                        }

Should you not be checking for a drop here?

The AI didn't do a good job here.
Please use Victor's patch and resend. Also the tdc testcase should be
patch 2 not 1.

cheers,
jamal


> +                    ]
> +                }
> +            }
> +        ],
> +        "teardown": [
> +            "$TC qdisc del dev $DEV1 clsact"
> +        ]
>      }
>  ]
> --
> 2.34.1
>

