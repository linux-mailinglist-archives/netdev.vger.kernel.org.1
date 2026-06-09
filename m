Return-Path: <netdev+bounces-297062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vjzwMZ8fKGpp+QIAu9opvQ
	(envelope-from <netdev+bounces-297062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:13:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A07660E26
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:13:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=PcGj+pTC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297062-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297062-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C8F3040476
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B77309F09;
	Tue,  9 Jun 2026 14:04:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF403093DB
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:04:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013850; cv=pass; b=RgR2R+u3id2Nk0kH4oyznqoe4sTJYQfBX9np7r2noxkVg2LluWksMsUwdogo8OVireq2JdU69+WFaXPLkXUgc3ug5/XHMcRo9UMIv1Ko1kzrqjGNvslO3D/9BlsX+lFz+g4LPwsR+40L61pFXG9B/rJr9gmobiv18edcywmkkHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013850; c=relaxed/simple;
	bh=E147MXD1i20hShpRY2Y0iYb19lpswGGhWj7BdFKy4DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nt476uSX99oOvmmz/uuPIP9Ysw2Dz06l6G44+OoPbYdsPr+NSwX/edgjESBUJmmtof19hqsPsNdGC66AdqyXMzRISYrvoDP5SgMUwsbzuCtR59yana3l9YR9SohfigHAADBZecw7XKEKNpgF1lXKSC1/2gbuxkLwyYoe/c7Upl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=PcGj+pTC; arc=pass smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so3714033b3a.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781013847; cv=none;
        d=google.com; s=arc-20240605;
        b=F6ntZljUpZ3BuXdEP+2UTh6tjiyNPy4/oeFHWQrKsteVWSoL1cpkUgiZJ0wtlJgXXC
         qFtvJVHK0aPHtlk6xbR9ETr489vhEe7c/DAWo0784KD2xvOxLw6zhM/wrd8K1nklTKbD
         eZsk8ywLjU1e3FdxGTmsf2AY5KRSByo3OGmmkSQG52orTxYPNosf5uG8M83faobzeuOi
         yF3gp4y9smjNK9hdSkxiW/FZ75z8Et20p4OaJ0Pun3CC5z/0A+utE+L+R3z5ky2W6Jwe
         /MRhERXSaoBca3rs+lNlcOSigN6b6nDha+GyBsxIGd8xyjLRc8PCFVdwmfjdtoZDZ8vg
         ahJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D6dUyOGttN87UBKwyarkfkYbV8keuUVXPEzAs+08V7o=;
        fh=/m2+7tdrZJQufXCeXofuTxce4PNF5+s7+X8CsEKtECk=;
        b=ZlJsyGY5kys5pfMM7FYxtwu3mkQmctyAjlHjnA+Nz1e32EZjnswixwCA/S4JtjaFiR
         /6HYA3xuenRHpfFmWy9yjKIc0q2YSWruA2az4Nu0+Wg/5dv48w253F/86ash/eqnmo1F
         vjqUptliWWDFrhVVMX5Oc4k4802f+BkgKkhm3Fd+/YcVLvCfA+VxxQFCg4jqV1L8wtla
         BcyMy5xdsIRLmTs8g6/UHnRFD5TCrYz9xZXFZODASY6gfLVNVlT+wbICfyboQDYWBoHx
         rpsXbhtxBAisGepL7LO8v5EhvYjktF6OUUHrosgS1gSUpeteMCpiTWphsjJBik+9SU0c
         mKOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781013847; x=1781618647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6dUyOGttN87UBKwyarkfkYbV8keuUVXPEzAs+08V7o=;
        b=PcGj+pTCuBNZUEJ4FVj2bjc3G3E2HuP5KWiCgtr0brVnVoBU2zeVEkX0CgmdNxxQ7g
         8/UAJfCckDZH3BpAifAv+fzrumIym117ir6/eer/p/pYkxxjWyIGc28zhLF+he+YrIm4
         nhAQYBILgT9q/fzhhd/O+nNKt5SY3o5ohMpDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013847; x=1781618647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6dUyOGttN87UBKwyarkfkYbV8keuUVXPEzAs+08V7o=;
        b=UTcmgiiQ9HkSUUpibRweclHFRHNJ/kwgibmeLdzMUc89SP6aaKqUiwiXUIvrnt3XUo
         Whkqy9vv/r196+Iiq6wXwXnqllB2jefuOPThgcW2ZiNIwTUn/ZI9EPWyP4iM9hcX42xg
         jMik+qRF5hkfLY0LRJJHeken05L+lv0IVOHbMiSf6fUZdmpSgtX2fYef2A6QuUxtuIGi
         Bm2J2X0yrGJBxut6k6Y5qVJd3r1JruBWjqvjlKYX+YqNyPhcQ9crMYRC2qsHwUFKCb4A
         asaFHA9g3O1z8EvKvP4r/4GVvoYxEF6U+SvjuN1sfRlArluEUL4DVALejGld3BzF24AP
         lQPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+twa1FvtkA/CKDkrmvKb8eQChQXp5UsLBXW7yLjVhI1Bz7mwgQ0TW/xCthkNriHDKbBPomNIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9+sSxmCKgEUMNg7v9kOXmeibFzv/JTBXUIxjq++FnY/i3UeR
	DEYrYcyjYz7kk+VFIx31JXBIUbzrUPDeReVxTaKaV8JsS19lh6nQx7ORICL/6MQLiKFgteSPgrm
	igtzTpTOTe5liX/SvD+LiqqPlRkCIIzGtQ0jwjWlrTK6LpReuner5eA==
X-Gm-Gg: Acq92OE2UMH6h/xqUMqaUkBMdmrEMY3PaDXszQ0zcUPBlUAhHUy61C0/Q99sZNC2tNy
	Un+I1aSK3qXNT+hHtuVFiN4GhR2hhI0OZqeUYwa1OP/fvH2XmsAXpfvAlbwpM90aPRa7HGd7PbT
	owIB8GIKWyS34j1YFOiT9dCqtvlzUtYPaZZxu74InU/ZtKk2BRrnwtjzRcfzF67z11FO9yYgLUK
	ZcKIScUJZIW7bWbR0l34uUGbq5szCdIRoS7ep5Ibo8SXoAKTkRPVYlO4Jk6iE+/E/ut8DfY+JPp
	QwOU/sgebylqOuyJSqo=
X-Received: by 2002:a05:6a00:895:b0:835:45bf:9659 with SMTP id
 d2e1a72fcca58-842b0e957c3mr21438428b3a.41.1781013847062; Tue, 09 Jun 2026
 07:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780901080.git.edragain@163.com> <cf59defd97a1ad7aed813573a24bccfa3e265e61.1780901080.git.edragain@163.com>
 <CAM0EoMmY94w+0RCeKnBTaujqZEK8MQG+twVdahQVht_G81QZ-g@mail.gmail.com> <fbba10bb-ed0e-4181-ba42-a08c050ef676@163.com>
In-Reply-To: <fbba10bb-ed0e-4181-ba42-a08c050ef676@163.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 9 Jun 2026 10:03:55 -0400
X-Gm-Features: AVVi8CeaHhu-m28J_BOQQ6fOwoYqDMn3zjDyHzcFdZCMP0YwdifcjtBejvDCCsw
Message-ID: <CAM0EoMk6gB9CozxVEZk3HXiMG+6TH-n8T9mHiPdaMzf_Offv6Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] selftests: tc-testing: cover malformed IFE
 decode frames
To: Yong Wang <edragain@163.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, kuba@kernel.org, 
	victor@mojatatu.com, yotam.gi@gmail.com, davem@davemloft.net, 
	xiyou.wangcong@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:edragain@163.com,m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:victor@mojatatu.com,m:yotam.gi@gmail.com,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:yotamgi@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	TAGGED_FROM(0.00)[bounces-297062-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[mojatatu.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,kernel.org,mojatatu.com,gmail.com,davemloft.net];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,mojatatu.com:dkim,mojatatu.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24A07660E26

On Tue, Jun 9, 2026 at 3:55=E2=80=AFAM Yong Wang <edragain@163.com> wrote:
>
>
>
> =E5=9C=A8 2026/6/9 4:14, Jamal Hadi Salim =E5=86=99=E9=81=93:
> > On Mon, Jun 8, 2026 at 2:35=E2=80=AFPM Ren Wei <n05ec@lzu.edu.cn> wrote=
:
> >>
> >> From: Yong Wang <edragain@163.com>
> >>
> >> Add a tc-testing regression case for IFE decode with a malformed
> >> ETH_P_IFE frame carrying only the minimal IFE metadata header followed
> >> by a truncated inner Ethernet header.
> >>
> >> The test installs an ingress flower rule with "action ife decode pipe"
> >> and injects an IFE frame from scapy, then verifies packet accounting
> >> through "tc -s -j filter show". Using JSON output makes the check less
> >> sensitive to formatting differences in tc's text output.
> >>
> >> To let the testcase send the larger frame shape it needs, extend
> >> scapyPlugin with an optional "mtu" field and apply it to the transmit
> >> interface before sendp(). This is needed because nsPlugin creates DEV0
> >> in the root namespace, so testcase setup commands executed inside the
> >> test namespace cannot adjust DEV0 directly.
> >>
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Yuan Tan <yuantan098@gmail.com>
> >> Reported-by: Xin Liu <bird@lzu.edu.cn>
> >> Assisted-by: Codex:gpt-5.4
> >> Signed-off-by: Yong Wang <edragain@163.com>
> >> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >> ---
> >> Changes in v2:
> >> - add a tc-testing regression case for the malformed IFE decode frame
> >> - add an optional mtu field to scapyPlugin for the reproducer
> >> - v1 link: https://lore.kernel.org/all/6200dc9e5ea7a85d500e72543d897c2=
d930fcdce.1780809474.git.edragain@163.com/
> >>
> >>  .../tc-testing/plugin-lib/scapyPlugin.py      |  6 ++
> >>  .../tc-testing/tc-tests/actions/ife.json      | 62 ++++++++++++++++++=
+
> >>  2 files changed, 68 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin=
.py b/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
> >> index 254136e3da5a..e84b344dd1fa 100644
> >> --- a/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
> >> +++ b/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
> >> @@ -50,5 +50,11 @@ class SubPlugin(TdcPlugin):
> >>              if '$' in scapyinfo['iface']:
> >>                  tpl =3D Template(scapyinfo['iface'])
> >>                  scapyinfo['iface'] =3D tpl.safe_substitute(NAMES)
> >> +            if 'mtu' in scapyinfo:
> >> +                subprocess.run(
> >> +                    [NAMES['IP'], 'link', 'set', 'dev',
> >> +                     scapyinfo['iface'], 'mtu', str(scapyinfo['mtu'])=
],
> >> +                    check=3DTrue, stdout=3Dsubprocess.DEVNULL,
> >> +                    stderr=3Dsubprocess.DEVNULL, env=3DENVIR)
> >>              for count in range(scapyinfo['count']):
> >>                  sendp(pkt, iface=3Dscapyinfo['iface'])
> >> diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.j=
son b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
> >> index 808aef4afe22..062efbe284dc 100644
> >> --- a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
> >> +++ b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
> >> @@ -1378,5 +1378,67 @@
> >>          "teardown": [
> >>              "$TC actions flush action ife"
> >>          ]
> >> +    },
> >> +    {
> >> +        "id": "8a7c",
> >> +        "name": "Decode malformed ife frame with truncated inner ethe=
rnet header",
> >> +        "category": [
> >> +            "actions",
> >> +            "ife",
> >> +            "scapy"
> >> +        ],
> >> +        "plugins": {
> >> +            "requires": [
> >> +                "nsPlugin",
> >> +                "scapyPlugin"
> >> +            ]
> >> +        },
> >> +        "setup": [
> >> +            [
> >> +                "$TC actions flush action ife",
> >> +                0,
> >> +                1,
> >> +                255
> >> +            ],
> >> +            [
> >> +                "$TC qdisc del dev $DEV1 clsact",
> >> +                0,
> >> +                1,
> >> +                2,
> >> +                255
> >> +            ],
> >> +            "$IP link set dev $DEV1 mtu 65535",
> >> +            "$TC qdisc add dev $DEV1 clsact",
> >> +            "$TC filter add dev $DEV1 ingress protocol 0xed3e prio 1 =
flower action ife decode pipe"
> >> +        ],
> >> +        "cmdUnderTest": "$TC -s -j filter show dev $DEV1 ingress",
> >> +        "scapy": {
> >> +            "iface": "$DEV0",
> >> +            "count": 1,
> >> +            "mtu": 65535,
> >
> > I am not following - why is this the mtu being set?
> >
> In this setup, nsPlugin creates $DEV0/$DEV1 as a veth pair. A veth device=
 uses the normal Ethernet default MTU via ether_setup(), which sets dev->mt=
u =3D ETH_DATA_LEN, and ETH_DATA_LEN is 1500. To send big payload(>1500), s=
etting mtu is needed.
> >> +            "packet": "Ether(dst=3D'ff:ff:ff:ff:ff:ff', type=3D0xED3E=
)/Raw(b'\\x00\\x02' + b'\\xcc' * 14 + b'\\xdd' * (5000 - 16 - 14))"
> >
> >
> > And why do you need such a big payload?
> >
> I tested this locally and found that the minimum packet length that relia=
bly triggers the panic in my setup is about 4080 bytes.
> I guess that is because the reproducer needs to cross the AF_PACKET alloc=
ation threshold in packet_alloc_skb():
>
>     if (prepad + len < PAGE_SIZE || !linear)
>         linear =3D len;
>
> Below that threshold, the packet appears to stay fully linear, which does=
 not reproduce the non-linear inner-header condition needed for the eth_typ=
e_trans() crash. So the crafted frame needs to be at least that large to re=
liably trigger the original panic path.

The bug is obvious - triggering the panic is not the right thing to do here=
.
The one Victor sent will work with a patched vs not patched kernel. We
will know the bug exist because the drop counter in one case goes up
but not other.
So resend with his patch please.

cheers,
jamal

> >> +        },
> >> +        "expExitCode": "0",
> >> +        "verifyCmd": "$TC -s -j filter show dev $DEV1 ingress",
> >> +        "matchJSON": [
> >> +            {
> >> +                "kind": "flower"
> >> +            },
> >> +            {
> >> +                "options": {
> >> +                    "actions": [
> >> +                        {
> >> +                            "kind": "ife",
> >> +                            "stats": {
> >> +                                "packets": 1
> >> +                            }
> >> +                        }
> >
> > Should you not be checking for a drop here?
> >
> Yes, I will modify it right away.
> > The AI didn't do a good job here.
> > Please use Victor's patch and resend. Also the tdc testcase should be
> > patch 2 not 1.
> >
> > cheers,
> > jamal
> >
> I tested Victor's testcase locally. It does cover the truncated inner-hea=
der case, but it did not trigger the panic I originally observed.
> Would you prefer that I resend the series using Victor's testcase anyway,=
 or sending a tdc testcase which trigger panic?
> Also I will adjust the patch ordering.
> Thanks,
> Yong
> >
> >> +                    ]
> >> +                }
> >> +            }
> >> +        ],
> >> +        "teardown": [
> >> +            "$TC qdisc del dev $DEV1 clsact"
> >> +        ]
> >>      }
> >>  ]
> >> --
> >> 2.34.1
> >>
>

