Return-Path: <netdev+bounces-34463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 188497A43F9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060031C20EA7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C681427E;
	Mon, 18 Sep 2023 08:09:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE4749D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:09:55 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F7C9F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 01:09:52 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41513d2cca7so421841cf.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 01:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695024592; x=1695629392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38st7+CwNWQl13xaTkpZZQeswKXbWoJIBIN4bsM6Emo=;
        b=m3DsUHkI15ViQGFCMSBgYCDmylYRsWAZdL9HyTH1gFEjtNYeiWhUlYNG2wUKvzCctR
         c0SV4XyBSV2tFxH+3eSJLiSZ3qBA+CcQ0XiBv2Pp/GY8lEhGUEaZ+ob34SF1W6BVecd9
         Wud8BA72hymy8kXJrGkyyS5Z/xn5p1+es5253JUkzuh/lx2qBjiOrUIkmix1WaTJoDCn
         c0jry9kGpdb2W4vhQNFtsq3a+0NfVK4Uf4V+bkUOg2lJTeZB+FZBpgUnjvqXo7cScaJB
         szVLk0w5Ro1RV41J3a7vi1OvOYudt04gmhCv3lfHxL2qeF6g5JPrAS7+ogn2JEl+QchQ
         5wOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695024592; x=1695629392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38st7+CwNWQl13xaTkpZZQeswKXbWoJIBIN4bsM6Emo=;
        b=ntu6E9R7zJBJiZcI8GaqPxYud3CDwcDV0In3myj4r9jHWw24iFuphnlbrhNysYtLhg
         IXgj0gffOQsgSA+e6nJXmy6pH70y9oO97EOfXYDcZZ/XycQgeIBLzRvR0jmLpaFo8SSl
         tToMghFg+ts47v/5H8aKPzpRho9xe8cmGQsuxQVcpN1wHlhYlZyVez2L0DkT1LpqDfEa
         0+yHuysg9WNwqXdQMUY9wHz+PlyXAmpBkWoTuP2l+MkT7MITm6zh990lWhlMf6uYGjiX
         VN042FwaCdz6/5rJjtirrbEkXIz0qSZtA5P+jEqVjphTFEWIiLQHh0pIclZDHVyqRfWl
         wJzA==
X-Gm-Message-State: AOJu0Yy4i+RcF3MmYy+/TLTRuDLlyOxQq3dT+vQa53aDBc6ELcT0Hfmx
	fRFkJ5wpQ/NHNY08SYsBNpbw2f7mneKVOPu/eRB0+Q==
X-Google-Smtp-Source: AGHT+IFlGfwR9VKfI97ywRNTNtaaOI6Ipg1gKde7gqFOeFzSJI/pU+LysoXQWS3rtxZdtS9fNlxrILghk8dzM2Hz8mg=
X-Received: by 2002:a05:622a:1341:b0:417:9238:5a30 with SMTP id
 w1-20020a05622a134100b0041792385a30mr384071qtk.29.1695024591626; Mon, 18 Sep
 2023 01:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com> <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
 <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
 <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
 <43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com> <5A853CC5-F15C-4F30-B845-D9E5B43EC039@gmail.com>
In-Reply-To: <5A853CC5-F15C-4F30-B845-D9E5B43EC039@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Sep 2023 10:09:40 +0200
Message-ID: <CANn89iLWi7yr184a52FRrO2QW=ffLEsy1DKj+f_Yz_nPuhaMPA@mail.gmail.com>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
To: Martin Zaharinov <micron10@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>, 
	patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, kuba+netdrv@kernel.org, dsahern@gmail.com, 
	Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 17, 2023 at 1:55=E2=80=AFPM Martin Zaharinov <micron10@gmail.co=
m> wrote:
>
> Hi Eric
> is it possible bug to come from this patch : https://patchwork.kernel.org=
/project/netdevbpf/cover/20230911170531.828100-1-edumazet@google.com/
>
>

Everything is possible, but this is not in 6.5 kernels.

I would suggest you start a bisection.

> m.
>
> > On 17 Sep 2023, at 14:40, Martin Zaharinov <micron10@gmail.com> wrote:
> >
> > One more in changelog for kernel 6.5 : https://cdn.kernel.org/pub/linux=
/kernel/v6.x/ChangeLog-6.5
> >
> > I see have many bug reports with :
> >
> > Sep 17 11:43:11  [127675.395289][    C2]  ? process_backlog+0x10c/0x230
> > Sep 17 11:43:11  [127675.395386][    C2]  ? __napi_poll+0x20/0x180
> > Sep 17 11:43:11  [127675.395478][    C2]  ? net_rx_action+0x2a4/0x390
> >
> >
> > In all server have simple nftables rulls , ethernet card is intel xl710=
 or 82599. its a very simple config.
> >
> > m.
> >
> >
> >
> >
> >> On 16 Sep 2023, at 12:04, Martin Zaharinov <micron10@gmail.com> wrote:
> >>
> >> Hi Paolo
> >>
> >> in first report machine dont have out of tree module
> >>
> >> this bug is come after move from kernel 6.2 to 6.3
> >>
> >> m.
> >>
> >> On Sat, Sep 16, 2023, 11:27 Paolo Abeni <pabeni@redhat.com> wrote:
> >> On Sat, 2023-09-16 at 02:11 +0300, Martin Zaharinov wrote:
> >>> one more log:
> >>>
> >>> Sep 12 07:37:29  [151563.298466][    C5] ------------[ cut here ]----=
--------
> >>> Sep 12 07:37:29  [151563.298550][    C5] rcuref - imbalanced put()
> >>> Sep 12 07:37:29  [151563.298564][ C5] WARNING: CPU: 5 PID: 0 at lib/r=
curef.c:267 rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
> >>> Sep 12 07:37:29  [151563.298724][    C5] Modules linked in: nft_limit=
 nf_conntrack_netlink vlan_mon(O) pppoe pppox ppp_generic slhc nft_ct nft_n=
at nft_chain_nat nf_tables netconsole coretemp bonding i40e nf_nat_sip nf_c=
onntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf=
_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4=
 nf_xnatlog(O) ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos [last unloaded=
: BNGBOOT(O)]
> >>> Sep 12 07:37:29  [151563.298894][    C5] CPU: 5 PID: 0 Comm: swapper/=
5 Tainted: G           O       6.5.2 #1
> >>
> >>
> >> You have out-of-tree modules taint in all the report you shared. Pleas=
e
> >> try to reproduce the issue with such taint, thanks!
> >>
> >> Paolo
> >>
> >
>

