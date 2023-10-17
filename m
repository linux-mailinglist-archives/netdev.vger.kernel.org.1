Return-Path: <netdev+bounces-41981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D0F7CC83A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680731C20A0D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F3045F49;
	Tue, 17 Oct 2023 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="SNdB5y6l"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28A1450F4
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:57:54 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1721B0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:57:53 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9a4c0d89f7so6852824276.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697558273; x=1698163073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTGS+worvlyfUvmNVg7PFChJ3UYGdgOJgVUDjJRO8aY=;
        b=SNdB5y6lB0sLl4awJbaNBgE/U/S/AofaIjC3NA13cDQQScnF4epinrFTlfb2aCnq+V
         CZxI5N5EKWCX4DUgjRvKm1uPUq1DP4UYOK+PjHPUl/A+IgBfW7enK7S2S1KyM7w8pEUn
         r/Ao1PiH/B3Qtbmws+35L+ZiuZ+9MxWRGblKwp6O2T6wi10Vkj7iSWbuZO0u///OSy5o
         8zxyHli77AephOZiYlM76kuA/g5W4MXF54yvzu7o2HqA92Rq00gY6xi52Lso3jVsHc7l
         3iMhdwDlIEpp2ditPN4Us2JMa2/eLx3+0tLRvNI+s/QiaP5JvRzCf+wR5taPzsp0T4kB
         uNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558273; x=1698163073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTGS+worvlyfUvmNVg7PFChJ3UYGdgOJgVUDjJRO8aY=;
        b=WIawu8F++grDKEdcH5+pHCwGFbVol+9oDKFLzOiH9wdPi6LzzDsfQmCMZ4aPyZZv9m
         3yLGHmeAifP7dF0MFp+sK+2dUomS1TfYiNWE8PR3s/N0JBt3QpmrhZUFzWvO4OJQKzdL
         lVqkO7WE8RtkjPm4rw3xcK+MbK4GqliSs2ETlisJ5r2FT/Hzg2c+pNOi+f8hGPibX6vl
         EeRf9kvauVJEbFUdELKPa2CsRg8kvHL7CdJBJkzZSXIzoWIkjRo4o+hiKbf00LNcC/iw
         rhdzEupE7AJkCTTxJIzfOu+TZdzy9wCJZQ3jVnNkFFCY1kfcKDdvwAoTTNJYx9qVtReE
         +aWA==
X-Gm-Message-State: AOJu0YxsNaajcXLt6/ww1VEJOpGFqkqtSs22YFLph30QZxtCG3sE0EhD
	DtHBN6KWFRTJh4Mi3El6UP4yeYGXpsC3KjJEP96IcFFb5nHwILpq
X-Google-Smtp-Source: AGHT+IFKYBTb1E7Xix0WaU2u81OClOQUoTvRBdQ3hqUez+ttUfANPJvbnbaLDi932DUFc0FO/aNl0CRcj14RhQYRjYY=
X-Received: by 2002:a25:7352:0:b0:d71:6b6e:1071 with SMTP id
 o79-20020a257352000000b00d716b6e1071mr2405823ybc.32.1697558272122; Tue, 17
 Oct 2023 08:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016093549.181952-1-jhs@mojatatu.com> <20231016131506.71ad76f5@kernel.org>
 <CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com>
 <9246d8a0-113a-9c71-9e44-090b6850a143@iogearbox.net> <CAM0EoMkJcVFx+u93T=PO_Q6BJuHe3h_GGW1=5h=asYFo--x=TQ@mail.gmail.com>
 <c8bfd660-96d1-3cb7-3f1e-44bc88af0007@iogearbox.net>
In-Reply-To: <c8bfd660-96d1-3cb7-3f1e-44bc88af0007@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 17 Oct 2023 11:57:40 -0400
Message-ID: <CAM0EoMmTG422piwXYB6jDrU_JQCphLjsAXXL55xBADd6j-vYSA@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 00/18] Introducing P4TC
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, deb.chatterjee@intel.com, 
	john.andy.fingerhut@intel.com, dan.daly@intel.com, Vipin.Jain@amd.com, 
	tom@sipanda.io, mleitner@redhat.com, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 11:54=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 10/17/23 5:38 PM, Jamal Hadi Salim wrote:
> > On Tue, Oct 17, 2023 at 11:00=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >>
> >> On 10/16/23 10:38 PM, Jamal Hadi Salim wrote:
> >>> On Mon, Oct 16, 2023 at 4:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> >> [...]
> >>>> FWIW please do not post another version this week (not that I think
> >>>> that you would do that, but better safe than sorry. Last week the pa=
tch
> >>>> bombs pushed the shared infra 24h+ behind the list..)
> >>>
> >>> Not intending to.
> >>
> >> Given bpf & kfuncs, please also Cc bpf@vger.kernel.org on future revis=
ions
> >> as not everyone on bpf list is subscribed to netdev.
> >
> > I thought i did that, maybe it was in earlier patches. Do you want Cc
> > on everything or only on kfuncs? I am getting conflicting messages, do
> > you have to Cc bpf for kfuncs?
> > Example, attached from (some fs?) conference last month i think
>
> This is extending capabilities of XDP and tc BPF prog types, so yes, the =
bpf
> list should be in the loop.

Roger that, makes sense. So all patches or only kfunc ones?

cheers,
jamal

