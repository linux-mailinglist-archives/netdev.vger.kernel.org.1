Return-Path: <netdev+bounces-44622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21E97D8D05
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 04:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C76B21262
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 02:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CF21115;
	Fri, 27 Oct 2023 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klr+QpIl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019810F7;
	Fri, 27 Oct 2023 02:06:25 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65257187;
	Thu, 26 Oct 2023 19:06:24 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-457c441555cso694860137.3;
        Thu, 26 Oct 2023 19:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698372383; x=1698977183; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZs7O2u/plePQaOCB1yVLsFRWwAAB+J3QFH9mqRARyE=;
        b=Klr+QpIllrk3zH9s6uTRwqHYUOI57/pNUGEMjsaOCtV4rTuJg3cHIDgQAZn/QX9EMK
         HsGyS5lXrYeVEcNIRP6rn0ba5RNglM0XumNqpwIoLQrWK+FW6MP2d2i8BQrp9ftoMCxZ
         ibKoBPR3WKtYdMUQoZzjU58Kn6OK0L2k5/QsGBRU/l21uzp/3nNNeK/u4PBpc4DxgLVo
         RqWlrYs7rbFskFTq/SYLybrfEYMeuGSYsK+rg1iMDtVIaQ2rosNKXHOhUqLXatXbLQus
         aavDwUOOUgVwU5TnKndIAbztVIW9GWQXwEIDv1gtcD/IAIoGMARLVaN3IXGaRD+sWQ+u
         A/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698372383; x=1698977183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZs7O2u/plePQaOCB1yVLsFRWwAAB+J3QFH9mqRARyE=;
        b=sTjf6YYqMaUtNkts6fDMvHHkBWXm1rQhjYKQRdSq6c+NbOax/sxg3w7bqjGZO2esKt
         ViB2Pt33O8bujRXpLeHvxaYmED8W7BTsZRifAaIqbQDfOKqcMJzFcQcoHgCJGHk4vmNj
         hoJs7hkxMFCJVL1isOmUq64Ew1RFu6HdMqNDyZXlzgF3w4LBtA4ozSwcomStNvzwCN1u
         wZ3NKDRnPvDYFc9u6oA3/N8P+XITmT+MO99RBTwZmLO+i6d7UbiDl8B6poqp5ZU9NZMQ
         v5Nag9pmjr49qJzidQtEl+sSWcKL4QZ821g+DAXLTqLX51A3aJouEtk7awGEJt05Mz1Y
         j53Q==
X-Gm-Message-State: AOJu0Yx4Ri5t3OXRQNdEPj+YkFovRWrYHqF9tf2WxrYw+5JEPbOENbLL
	jREtOOxn6Wgi1K0ikGzLkdc=
X-Google-Smtp-Source: AGHT+IEp5rB+0mmnsNUP7K9wy+H1mibKGdaEWvD1isMfVpg01Lhz1LLWfTnEcH1VGWR3kxmrew1IiA==
X-Received: by 2002:a67:c309:0:b0:454:5a16:890d with SMTP id r9-20020a67c309000000b004545a16890dmr1493417vsj.24.1698372383301;
        Thu, 26 Oct 2023 19:06:23 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a16-20020a5b0ed0000000b00d8674371317sm270303ybs.36.2023.10.26.19.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 19:06:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 35B1027C0054;
	Thu, 26 Oct 2023 22:06:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 26 Oct 2023 22:06:22 -0400
X-ME-Sender: <xms:HRs7ZfPhViSRhPruAI_NsRT6pjjS5gTZNLBUuDrgp43m0hBTIbgP3g>
    <xme:HRs7ZZ-i-NWkeqiZ_bpWDvITUqoxZLbCuE7f9NuyR8qP0BK-woHNAQdyOUPIq265_
    LrfMavJSb8BkZRkpA>
X-ME-Received: <xmr:HRs7ZeRv7EBZbUfjdbJDnZBJF5nv8b5QzwRulvQ_wTce-QgLpl13TSdYCQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleefgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffg
    geelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:HRs7ZTvoRTRgfjMX_gjgvyEztzhbDLxa_idbz8pdcGQKdNYbUf2HUw>
    <xmx:HRs7ZXenEI2Jt6W1QuQcQhmrm3tYqyCIxtg0JO_Z_SDOd1vS-N7LCw>
    <xmx:HRs7Zf3TJhvvES4R4F6TQIycaHmDhS068vGhHr5B9LkWkxEsMSrfYg>
    <xmx:Hhs7ZZsS3Idzc2sf1sHmxGAu2GQvTM_1_2kvl5BmSncazErxet-jAw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 22:06:21 -0400 (EDT)
Date: Thu, 26 Oct 2023 19:06:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Message-ID: <ZTsbG7JMzBwcYzhy@Boquns-Mac-mini.home>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>

On Fri, Oct 27, 2023 at 01:48:42AM +0200, Andrew Lunn wrote:
> On Thu, Oct 26, 2023 at 12:39:46PM +0200, Miguel Ojeda wrote:
> > On Thu, Oct 26, 2023 at 2:16 AM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote:
> > >
> > > This patchset adds Rust abstractions for phylib. It doesn't fully
> > > cover the C APIs yet but I think that it's already useful. I implement
> > > two PHY drivers (Asix AX88772A PHYs and Realtek Generic FE-GE). Seems
> > > they work well with real hardware.
> > 
> > This patch series has had 8 versions in a month. It would be better to
> > wait more between revisions for this kind of patch series, especially
> > when there is discussion still going on in the previous ones and it is
> > a new "type" of code.
> 
> That is actually about right for netdev. As i said, netdev moves fast,
> review comments are expected within about 3 days. We also say don't
> post a new version within 24 hours. So that gives you an idea of the
> min and max.
> 
> It is however good to let discussion reach some sort of conclusion,
> but that also requires prompt discussion. And if that discussion is
> not prompt, posting a new version is a way to kick reviewers into
> action.
> 

I wonder whether that actually helps, if a reviewer takes average four
days to review a version (wants to give accurate comments and doesn't
work on this full time), and the developer send a new version every
three days, there is no possible way for the developer to get the
reviews.

(Honestly, if people could reach out to a conclusion for anything in
three days, the world would be a much more peaceful place ;-))

Regards,
Boqun

> 	Andrew
> 

