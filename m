Return-Path: <netdev+bounces-61888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EFD8252A6
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 12:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A6E1F2643B
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC6822EFC;
	Fri,  5 Jan 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wlss6fsb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D528E3F
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e54d40cca2so13221127b3.3
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704453621; x=1705058421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AASAQevZkEA/jAvcdCUwsQhC+FdwxIs0F8YQ1mFnqRg=;
        b=wlss6fsbslR/cafESlxDxENxd9eAPOPdTxVaASdxOWHI3cHxUlL+TCM4q82tYywbuT
         /mYeAP2gbU7BDpkYrHQ8Shhp2Ww+NIDf0Y7KlkaVaaNqMO6ofRLfeubi4RDI07IWPMLz
         MwEmfeQnw/6u5XVTv+4LU8F5e7W3x1HUUwFzTT8eCqDamNWVkylwAXRczzxiLF4jUvfz
         d0z/Vqgtq/1rH8KEVFFqgC15noW5/b86zZRXz9ens2vxkZhDqoTajHRBVtmmLlRd5PBb
         TU5prFcbUISz7XZd22iEUqz8pktBUnUE88ddLHwEow0mFboQS6s0kEVIEwcRj+lR7qqK
         +9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704453621; x=1705058421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AASAQevZkEA/jAvcdCUwsQhC+FdwxIs0F8YQ1mFnqRg=;
        b=BqPTW4qvlqageS2dRa+CxWEzzhpyhvFohbEkI/DCdInghTvdOqhMXNw92sSXTArkoF
         7xyVuM0vBJ5L+mE/qqOUCB6OLAeReQdM++9R+10YGCFIRNzx7LVuszD3ggBeA/vx1ML5
         yBsmiY+bh0gQDTAyKNO9LVsBJLCpNxAXIE3Ukd8bQ3pBmRf6xM32SlP32PWbVJqR1FKk
         EgkGxnPnLHdSqUuVo3WYZBnX2xZJ12nFQyjkWjfeJ5AeyJbZFB1umg/l/NF+cHuxx1Lj
         5vGkL9HS9P0vag2D0Jo/mE0b5zp3LYVWOFCFDUxqikBwfuVSGO+LlbNvK/Peq0UDYyNt
         /sSw==
X-Gm-Message-State: AOJu0Yxn9KYFNLyTU0iCKjQTcuKV9RRogaSLsInV1bczcTN3ahZBCpLa
	gQhAflwqIH7k5jov0EpbhcFyu91wnS+lAC7g+vghRSYYSAhG
X-Google-Smtp-Source: AGHT+IEVimvhEIo2vCrPkccQw8sHek6eo7kk2eU804ahxxW7HDhbSkTaFotGuwHNpMdDwm1SUYuFPq1ZIMKav0v2iyI=
X-Received: by 2002:a0d:f3c7:0:b0:5e7:d248:6b8f with SMTP id
 c190-20020a0df3c7000000b005e7d2486b8fmr1604999ywf.33.1704453621235; Fri, 05
 Jan 2024 03:20:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226182531.34717-1-stephen@networkplumber.org>
 <CAM0EoMmH-5Afhe1DvhSJzMhsyx=y7AW+FnhR8p3YbveP3UigXA@mail.gmail.com>
 <20240104072552.1de9338f@kernel.org> <CAM0EoMkP18tbOuFyWgr=BaCODcRTJR=rU6hitcQSY_HD9gD87g@mail.gmail.com>
 <CAHsH6Gsz7ANvWo0DcfE7DYZwVzkmXSGSKwKhJMtA=MtOi=QqqA@mail.gmail.com>
In-Reply-To: <CAHsH6Gsz7ANvWo0DcfE7DYZwVzkmXSGSKwKhJMtA=MtOi=QqqA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 5 Jan 2024 06:20:10 -0500
Message-ID: <CAM0EoMnSVQHyQy37OoznsF15+M84o7L2c6UwtKL1Fcuwev4rHA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] remove support for iptables action
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 9:33=E2=80=AFPM Eyal Birger <eyal.birger@gmail.com> =
wrote:
>
> Hi,
>
> On Thu, Jan 4, 2024 at 8:15=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > On Thu, Jan 4, 2024 at 10:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Wed, 27 Dec 2023 12:25:24 -0500 Jamal Hadi Salim wrote:
> > > > On Tue, Dec 26, 2023 at 1:25=E2=80=AFPM Stephen Hemminger
> > > > <stephen@networkplumber.org> wrote:
> > > > >
> > > > > There is an open upstream kernel patch to remove ipt action from
> > > > > kernel. This is corresponding iproute2 change.
> > > > >
> > > > >  - Remove support fot ipt and xt in tc.
> > > > >  - Remove no longer used header files.
> > > > >  - Update man pages.
> > > > >
> > > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > >
> > > > Does em_ipt need the m_xt*.c? Florian/Eyal can comment. Otherwise,
> > > > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > >
> > > Damn, I was waiting for Eyal to comment but you didn't CC
> > > either him or Florian =F0=9F=98=86=EF=B8=8F
> > >
> > > Eyal, would it be possible for you to test if the latest
> > > net-next and iproute2 with this patch works for you?
> >
> > Sorry bout that. Also Florian (who wrote the code).
>
> I tested and it looks like the patch doesn't affect em_ipt, as expected.
>
> I did however run into a related issue while testing - seems that
> using the old "ingress" qdisc - that em_ipt iproute2 code still uses -
> isn't working, i.e:
>
> $ tc qdisc add dev ipsec1 ingress
> Error: Egress block dev insert failed.
>
> This seems to originate from recent commit 913b47d3424e
> ("net/sched: Introduce tc block netdev tracking infra").
>
> When I disabled that code in my build I was able to use em_ipt
> as expected.

Resolved in: https://lore.kernel.org/netdev/20240104125844.1522062-1-jiri@r=
esnulli.us/
Eyal, if you have cycles please give it a try. Jakub, can we get that appli=
ed?

cheers,
jamal
> Eyal.

