Return-Path: <netdev+bounces-34340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC7C7A356B
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 13:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0858628164C
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28753C0B;
	Sun, 17 Sep 2023 11:55:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84383290B
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 11:55:40 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF9A126
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 04:55:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a645e54806so439913066b.0
        for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694951737; x=1695556537; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGDVdE8MBVyhDYJiGJCU+gdHXhqBgu97DlCVywOnJKA=;
        b=kI8k3VJ63ijsbgb9Tkj64uKBKEd0dCvZZrLSo09nEiAxaVNITmdLWWd0c7AHNBAiXV
         h8w4pk1cXj7cwLBJW4oV9n1eICNFSz80PLsMMSNcV+ZmikXqlMilG0zQfrbNoshLzQgU
         QhoEdCX0UchXxCP8ErR3gLaZi4/KfdImSMpWVort+mxWpwgybTDxz5L9ghvb7GJ/ekLy
         /Ao6IofeLu42DVc0kWoBl4WlPxhXTIcgPfe2GkGtFOm4Mx+v2HNl52YN18YwovFvQc0y
         gdDa8h7zQJzTsP1x3KEg9aGrQgkkKMmR79vmQSfaCi4xhS+TUOGuqZwL6ijy0gt6q3kI
         YmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694951737; x=1695556537;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGDVdE8MBVyhDYJiGJCU+gdHXhqBgu97DlCVywOnJKA=;
        b=MYeUDVGjLbYHn0/3fnv3gSyyYyx+/eyx0gGjTYgyO1V1pHHJ9gVeDRylMfn0IlhIHo
         fKrG+75e9FGW9oXd009e9FrP504g/UZxRmEhCtN+sVpsdRVFCV1OvSITYSf5g9pZHcxU
         L59ceRV6b+r7Bj9RMQbgrCjK0SylZHN0e27Gxni4Hm+NmOCGAN1qwPs7xwIy85PuNhgJ
         C8fFAxo723ayiq4YOHGaeCZ6wd1D5735MP7bJGEM3KXiVIGy5rZo4rZm86l7fTDw7jyv
         4Y3GfYN6tP1hg0jNtxWd+6n2PAQgLtcBWr5HYKofEsAoFTSSpDbAYRB+YFXXdTPyT1rD
         5FqQ==
X-Gm-Message-State: AOJu0YzRLDWEYgLoe+df4w3o4MT9QiQqy4RbIF+40i06c+ll2LhoRlmX
	JTmE/PW6gl+bq4m4/sUOQdNgqv6XHvg=
X-Google-Smtp-Source: AGHT+IHdJq8/FghWABbWDvAU0fJzeg+4D47ll+fRxGwRO0RFXspyVGAPqazd/3BT+2ECCtmNIARArA==
X-Received: by 2002:a17:906:3158:b0:9ad:c763:c3fd with SMTP id e24-20020a170906315800b009adc763c3fdmr5331685eje.28.1694951737475;
        Sun, 17 Sep 2023 04:55:37 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id y13-20020a170906470d00b0098884f86e41sm4831164ejq.123.2023.09.17.04.55.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2023 04:55:37 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com>
Date: Sun, 17 Sep 2023 14:55:25 +0300
Cc: netdev <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com,
 Florian Westphal <fw@strlen.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A853CC5-F15C-4F30-B845-D9E5B43EC039@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
 <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
 <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
 <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
 <43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric
is it possible bug to come from this patch : =
https://patchwork.kernel.org/project/netdevbpf/cover/20230911170531.828100=
-1-edumazet@google.com/=20


m.

> On 17 Sep 2023, at 14:40, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> One more in changelog for kernel 6.5 : =
https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.5
>=20
> I see have many bug reports with :=20
>=20
> Sep 17 11:43:11  [127675.395289][    C2]  ? =
process_backlog+0x10c/0x230
> Sep 17 11:43:11  [127675.395386][    C2]  ? __napi_poll+0x20/0x180
> Sep 17 11:43:11  [127675.395478][    C2]  ? net_rx_action+0x2a4/0x390
>=20
>=20
> In all server have simple nftables rulls , ethernet card is intel =
xl710 or 82599. its a very simple config.
>=20
> m.=20
>=20
>=20
>=20
>=20
>> On 16 Sep 2023, at 12:04, Martin Zaharinov <micron10@gmail.com> =
wrote:
>>=20
>> Hi Paolo
>>=20
>> in first report machine dont have out of tree module
>>=20
>> this bug is come after move from kernel 6.2 to 6.3
>>=20
>> m.
>>=20
>> On Sat, Sep 16, 2023, 11:27 Paolo Abeni <pabeni@redhat.com> wrote:
>> On Sat, 2023-09-16 at 02:11 +0300, Martin Zaharinov wrote:
>>> one more log:
>>>=20
>>> Sep 12 07:37:29  [151563.298466][    C5] ------------[ cut here =
]------------
>>> Sep 12 07:37:29  [151563.298550][    C5] rcuref - imbalanced put()
>>> Sep 12 07:37:29  [151563.298564][ C5] WARNING: CPU: 5 PID: 0 at =
lib/rcuref.c:267 rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
>>> Sep 12 07:37:29  [151563.298724][    C5] Modules linked in: =
nft_limit nf_conntrack_netlink vlan_mon(O) pppoe pppox ppp_generic slhc =
nft_ct nft_nat nft_chain_nat nf_tables netconsole coretemp bonding i40e =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 nf_xnatlog(O) ipmi_si ipmi_devintf =
ipmi_msghandler rtc_cmos [last unloaded: BNGBOOT(O)]
>>> Sep 12 07:37:29  [151563.298894][    C5] CPU: 5 PID: 0 Comm: =
swapper/5 Tainted: G           O       6.5.2 #1
>>=20
>>=20
>> You have out-of-tree modules taint in all the report you shared. =
Please
>> try to reproduce the issue with such taint, thanks!
>>=20
>> Paolo
>>=20
>=20


