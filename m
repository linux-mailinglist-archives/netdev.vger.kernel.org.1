Return-Path: <netdev+bounces-28851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B1778102F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D3280F07
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8C719BBE;
	Fri, 18 Aug 2023 16:20:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC48374
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:20:40 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADE9420E
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:20:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdbf10333bso9078095ad.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692375631; x=1692980431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=655vCXzlM4zGCIr+EId94JG2RMV3apqow7OsWWd1+BQ=;
        b=IFzrmIuSIdxWGx8Rzabyq0A9s5OerROPDw4m8hWjgu5aYIxHfN1TuqV2kORDJmnwsk
         cQvt5s+0jRW5FtjHAC/N063mX5XqI/dmU/BmyMNy7R99eezWOhaLyn/sWvvNdTJbp7qd
         eV50Ika8zKu7ySGjf5Lp+lDlgkUXNMM9wQz3LQiKPHLDUEoAyFgjGBLXDIeaRQV5I7OT
         ZZ8BGkw/l77SPxoaskQ9U+Y0MuMU2gKae/kS1VgDSxN6eVi2lDH+nFWb6X0QeMS8FTQA
         4Yb4FMl8EHUQULDrtLoRKwHdS8vWt2XCE681EOaMhSGlyqIlHvXfGjRMW1vciAPnqNMk
         Lnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375631; x=1692980431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=655vCXzlM4zGCIr+EId94JG2RMV3apqow7OsWWd1+BQ=;
        b=MW+nJR7lqFkPvCxpdEBOoUW8mnXE1cpuc0GqGK7pO7ZbMBAbxyZnjqydabNHuyzwvB
         9QDCimlt/oA/1mf8EiQqHOlQRbxcwANYwYvqai44J+UXeJMe6RPyJ5Cwpfm/kIbD291P
         Jb5HjG9hD4atm9bi3OoI0sW3pZx4dUGpTvajCzWGUWOju6szxN0Z2O0VnM/oy1EgKDsv
         REyXRI5d23hBOnc7XloYa7dRDI7AAIhWzzALJtjbnYtqt29tjP8h9IAusVKVLVea/3Eq
         KiDZf6cfAyjPBmjoN5F2CkJFTze4xADHRLabIohKIQHzSbVq0Yz57d/4FckkTmDJ7fXc
         7+Pw==
X-Gm-Message-State: AOJu0Yzz8vjbPr2N2/uKtXiXTh4zuFAQMnOtydYYIwGKJzYpnzmCxlS9
	YtABFjpwV02ymQh2Yu9W6NGqyQ==
X-Google-Smtp-Source: AGHT+IG9Ye+ApJeXXzHhLEGgU/AMJkeLonjhnD8qZmzldIDtqoJ5L2O0SBxmlhwBPXw9h1d1+CNy3g==
X-Received: by 2002:a17:902:6b86:b0:1bd:b7ad:a584 with SMTP id p6-20020a1709026b8600b001bdb7ada584mr2766900plk.44.1692375631588;
        Fri, 18 Aug 2023 09:20:31 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id iz18-20020a170902ef9200b001bc6e6069a6sm1959031plb.122.2023.08.18.09.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:20:31 -0700 (PDT)
Date: Fri, 18 Aug 2023 09:20:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Rakocevic, Veselin"
 <Veselin.Rakocevic.1@city.ac.uk>, "Markus.Amend@telekom.de"
 <Markus.Amend@telekom.de>, "nathalie.romo-moreno@telekom.de"
 <nathalie.romo-moreno@telekom.de>
Subject: Re: DCCP Deprecation
Message-ID: <20230818092027.1542c503@hermes.local>
In-Reply-To: <CWLP265MB6449B1A1718B6D8CD3EBFB27C91BA@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
References: <CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230710182253.81446-1-kuniyu@amazon.com>
	<20230710133132.7c6ada3a@hermes.local>
	<CWLP265MB6449543ADBE7B64F5FE1D9F8C931A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<0cb1b68794529c4d4493b5891f6dc0e9a3a03331.camel@redhat.com>
	<CWLP265MB644915995F6D87F6F186BEF7C915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230816080000.333b39c2@hermes.local>
	<CWLP265MB644901EC2B8353A2AA2A813CC915A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
	<20230816101547.1c292d64@hermes.local>
	<CWLP265MB6449B1A1718B6D8CD3EBFB27C91BA@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 18 Aug 2023 09:35:02 +0000
"Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk> wrote:

> > > The protocol works at the kernel level, and has a GPL scheduler and r=
eordering which are the default algorithms. The GitHub implementation inclu=
des some non-GPL schedulers and reordering algorithms used for testing, whi=
ch can be removed if upstreaming. =20
> >IANAL
> >
> >The implementation I looked at on github was in IMHO a GPL violation bec=
ause it linked GPL =20
> and non GPL code into a single module. That makes it a derived work.
> >
> >If you put non-GPL scheduler into userspace, not a problem.
> >
> >If you put non-GPL scheduler into a different kernel module, according t=
o precedent =20
> set by filesystems and other drivers; then it would be allowed.=C2=A0 BUT=
 you would need
> to only use exported API's not marked GPL.=C2=A0 And adding new EXPORT_SY=
MBOL() only
> used by non-GPL code would get rejected. Kernel developers are openly hos=
tile to non-GPL
> code and would want any export symbols to be EXPORT_SYMBOL_GPL.
>=20
> I see, the problem centres around the implementation rather than the prot=
ocol, as the protocol itself does not need these non-GPL components. So, wo=
uld another option to the ones you've already suggested be that of creating=
 a repository without the non-GPL components, and consider only that for pu=
rposes of upstreaming?=20

Yes, the implementation needs to be aligned with the legal license requirem=
ents.
It might not be the ideal solution but any mix of GPL and non-GPL component=
s needs
to stay with in the legal constraints.

