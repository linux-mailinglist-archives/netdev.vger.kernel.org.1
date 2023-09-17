Return-Path: <netdev+bounces-34338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8B7A355E
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 13:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5EA2816B9
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300F22594;
	Sun, 17 Sep 2023 11:40:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D241877
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 11:40:54 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873D1120
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 04:40:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso4296118a12.0
        for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694950850; x=1695555650; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr/Pw2eP+hXtNULq43VQt5WuV8h9UDltzQ9I4y7geKE=;
        b=Ki14abauKgVDI3sqAbzp0y3QIlNvq9Hcep18tTmK3T8KoTlH11ca9PAnCjhn6JaDw1
         ijb9sqwQyguYbWxXyp8hzlyDaLO+M2ZsKROJG13BXGupSu3QqmXG8hCrJJOLdU0SyG84
         s1gSp4EVEoJgp3jPgXPgrFucagxwLL/Cu5OnNLJsvgZVMBScfMOtulWmXIidCpHp2hZS
         +u3+BegHJ0i2nSUR7QMClG55bKVJGg+95npTGzUh3FmXv/VjBweMhEMhUYtKVeRP4Uux
         vVmuZZIVh0l24KE1BV0pWxOStm2TaDN3aKZmjYOpfgVNIKq/tZEqrtNmM7tX4f6bI6ma
         c4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694950850; x=1695555650;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vr/Pw2eP+hXtNULq43VQt5WuV8h9UDltzQ9I4y7geKE=;
        b=YHbN2Fgjod6YZ+crhEwg3baI4VPth4jcz9sgDdx+30THKKj2TNsQA4lV5Mw/MfbD6w
         vVw+PYguxJD848bJpxEQydYMYHXBO0bvBJL1A5CWWJMZc3C8xRbnv9VFfgfNpcULTEdY
         8ZfSmcergKLJXUfNhFL+FLVPT5hu6Xps/opgr23aFMzi+2XAVrN2VQhkeotKtMlcbzi6
         FDLuSyAY+e4xIqa1BFFpkLPm+mTHzSAZLPpB9pnJcjDHuDQFrUmOX41yn0mmDK2k9qye
         BOnoPjbwqZa5IjveY3dzyhp8Wzamd6pN9EeYXRdZfD2XG1RNbXnyq9a9OKkXS+P2NAaK
         2mZQ==
X-Gm-Message-State: AOJu0YyPTZXGONDrFkZxBmXZCj4MxGYFqyjcwZJfz7M8BGfg2nYj8xkJ
	mE5JmSCVfExZ3TGEKejf3O+G8Wea10s=
X-Google-Smtp-Source: AGHT+IE5WzMeN4WWSKHlNVBiEi86ST1QVHV4A10pTxXitOM+zh8CPcmppibnbnxDroLa0TNkYwby+w==
X-Received: by 2002:a05:6402:207a:b0:530:e090:1370 with SMTP id bd26-20020a056402207a00b00530e0901370mr1955676edb.35.1694950849678;
        Sun, 17 Sep 2023 04:40:49 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id w21-20020aa7cb55000000b0052ff7b17d38sm4540781edt.63.2023.09.17.04.40.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2023 04:40:49 -0700 (PDT)
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
In-Reply-To: <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
Date: Sun, 17 Sep 2023 14:40:38 +0300
Cc: netdev <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com,
 Florian Westphal <fw@strlen.de>,
 Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
 <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
 <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
 <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

One more in changelog for kernel 6.5 : =
https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.5

I see have many bug reports with :=20

Sep 17 11:43:11  [127675.395289][    C2]  ? process_backlog+0x10c/0x230
Sep 17 11:43:11  [127675.395386][    C2]  ? __napi_poll+0x20/0x180
Sep 17 11:43:11  [127675.395478][    C2]  ? net_rx_action+0x2a4/0x390


In all server have simple nftables rulls , ethernet card is intel xl710 =
or 82599. its a very simple config.

m.=09




> On 16 Sep 2023, at 12:04, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> Hi Paolo
>=20
> in first report machine dont have out of tree module
>=20
> this bug is come after move from kernel 6.2 to 6.3
>=20
> m.
>=20
> On Sat, Sep 16, 2023, 11:27 Paolo Abeni <pabeni@redhat.com> wrote:
> On Sat, 2023-09-16 at 02:11 +0300, Martin Zaharinov wrote:
> > one more log:
> >=20
> > Sep 12 07:37:29  [151563.298466][    C5] ------------[ cut here =
]------------
> > Sep 12 07:37:29  [151563.298550][    C5] rcuref - imbalanced put()
> > Sep 12 07:37:29  [151563.298564][ C5] WARNING: CPU: 5 PID: 0 at =
lib/rcuref.c:267 rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
> > Sep 12 07:37:29  [151563.298724][    C5] Modules linked in: =
nft_limit nf_conntrack_netlink vlan_mon(O) pppoe pppox ppp_generic slhc =
nft_ct nft_nat nft_chain_nat nf_tables netconsole coretemp bonding i40e =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 nf_xnatlog(O) ipmi_si ipmi_devintf =
ipmi_msghandler rtc_cmos [last unloaded: BNGBOOT(O)]
> > Sep 12 07:37:29  [151563.298894][    C5] CPU: 5 PID: 0 Comm: =
swapper/5 Tainted: G           O       6.5.2 #1
>=20
>=20
> You have out-of-tree modules taint in all the report you shared. =
Please
> try to reproduce the issue with such taint, thanks!
>=20
> Paolo
>=20


