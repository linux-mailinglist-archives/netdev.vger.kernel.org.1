Return-Path: <netdev+bounces-46677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0547E5BB6
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 17:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190681C209D3
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804FC17999;
	Wed,  8 Nov 2023 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="JYSBMuLT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD1D52A
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 16:50:40 +0000 (UTC)
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEAB1FD5
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 08:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=npID7pT4ODmNwHE726DAZIqDF6WPOCvYfyMieum27+s=; t=1699462240; x=1700326240; 
	b=JYSBMuLT9VettR/BZRWc2xZHC9Ul0Vou4EV/TkhyubfobnAohhnGXBoi0fZ3P2dlgiDxbeROx8a
	QqO5/tziglxvaFvzcTWktzmdTRI3RanETqzNzpKGPMlg6c59jQmzRERSPRqi6Yq29d20VBMwZLOH1
	e7+aVja7YbHSjqAwzhxJSFE0lzY6sIyhGcEID+SA7RrLnWbFi7IZVfiZ3e+LpmfqzJIy3RfYNKEX6
	T3D3d6xOHhdCcHbTSfWCGmCqN/75gx6QrTgRT3Xxf9se7RsrO0vvswC/le6sAXSyODkHCMWei/JKI
	D+eYP8N0imM9yttXagUKJBzh9SIYIJXuOR3Q==;
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46218)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1r0llH-00013u-QC
	for netdev@vger.kernel.org; Wed, 08 Nov 2023 08:50:40 -0800
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6d31f3e8ca8so4214394a34.0
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 08:50:40 -0800 (PST)
X-Gm-Message-State: AOJu0Yyidgw/ELg66MzIebiAmB6zDA8U/UN/Fo/GQj8EyfV75Qx9rw9j
	83kPNIygCxZYft7nKmV+JGO5XxQJHz92zrMDSs0=
X-Google-Smtp-Source: AGHT+IHSW3HyWK9eojS6qcdjgyXuROfFl/cRgaatdofPVX2NyUSB9//ygWPxSnVyzo3qoM3me1LMNn6q/usJx+9XCU0=
X-Received: by 2002:a05:6870:110b:b0:1e9:c7cc:df9a with SMTP id
 11-20020a056870110b00b001e9c7ccdf9amr2076416oaf.11.1699462239621; Wed, 08 Nov
 2023 08:50:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
 <29217dab-e00e-4e4c-8d6a-4088d8e79c8e@lunn.ch> <CAGXJAmzn0vFtkVT=JQLQuZm6ae+Ms_nOcvebKPC6ARWfM9DwOw@mail.gmail.com>
 <20231105192309.20416ff8@hermes.local> <b80374c7-3f5a-4f47-8955-c16d14e7549a@kernel.org>
In-Reply-To: <b80374c7-3f5a-4f47-8955-c16d14e7549a@kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 8 Nov 2023 08:50:03 -0800
X-Gmail-Original-Message-ID: <CAGXJAmz+j0y00XLc2YCyfK5aVPD12aDcrNzc58N1fExT6ceoVw@mail.gmail.com>
Message-ID: <CAGXJAmz+j0y00XLc2YCyfK5aVPD12aDcrNzc58N1fExT6ceoVw@mail.gmail.com>
Subject: Re: Bypass qdiscs?
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 8e086a056c9d4443aaf3b84243aabc30

Hi David,

Thanks for the suggestion, but if I understand this correctly, this
will disable qdiscs for TCP as well as Homa; I suspect I shouldn't do
that?

-John-


On Sun, Nov 5, 2023 at 8:27=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 11/5/23 8:23 PM, Stephen Hemminger wrote:
> > On Sat, 4 Nov 2023 19:47:30 -0700
> > John Ousterhout <ouster@cs.stanford.edu> wrote:
> >
> >> I haven't tried creating a "pass through" qdisc, but that seems like a
> >> reasonable approach if (as it seems) there isn't something already
> >> built-in that provides equivalent functionality.
> >>
> >> -John-
> >>
> >> P.S. If hardware starts supporting Homa, I hope that it will be
> >> possible to move the entire transport to the NIC, so that applications
> >> can bypass the kernel entirely, as with RDMA.
> >
> > One old trick was setting netdev queue length to 0 to avoid qdisc.
> >
>
> tc qdisc replace dev <name> root noqueue
>
> should work

