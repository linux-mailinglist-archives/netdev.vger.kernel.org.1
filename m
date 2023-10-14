Return-Path: <netdev+bounces-40978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A867C945B
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 13:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375CD282587
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E4A10794;
	Sat, 14 Oct 2023 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0hRndqV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0895D10781
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 11:38:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2B983
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697283478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7OKQnwlDTZH7fc4ejRpfuY4K+3qj8VyeLuTkuv/YT4=;
	b=b0hRndqVkZXyRS2AOwigUS3NmKX35gYxt1WHWITNraMyxnv1axknG/1Pfm98CZOAGhXnGN
	wAOVABT2VVgHHZ8rP7F8sUTKhMJxeFb3TBO1f7pjCzsPC4wf/n1PjKOS/jXX/KehihbwBy
	yW8EIcJc+Htgv0dIBCYxUBtuGPRgXPg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-PNnvohm7NsC2KvEIwYKuYg-1; Sat, 14 Oct 2023 07:37:57 -0400
X-MC-Unique: PNnvohm7NsC2KvEIwYKuYg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50796a717f7so1899274e87.3
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 04:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697283475; x=1697888275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7OKQnwlDTZH7fc4ejRpfuY4K+3qj8VyeLuTkuv/YT4=;
        b=rnbjTGeFQbFQzrpo7CwD7KjNRcUWn2f55J9VZLocwex9bnZPJWNIJnjhLWhvguOwBr
         JOJCS4c0r/0zcS5IsK2Bd/RxTjlKVPU4TDB91ZUniJ23ogzS0jn+sZYqm/9dQpyf718R
         Y9YSrZ2ljV3WA1JyP7mfQIgcg9/dqtWyRofMohYiESIarbbMoxs014w9GWTmSZQmz96y
         /qDM5oeIEBAQ/D/SkKpZjENXWJZrqU58TvNZr6DUt349lo1A6w2tt/WE7zwtUeXPhE96
         XjgL4ZthJ4khyEx/e/jyYtwTM4haMlUalnBi5b7W8jyoKO8UyeEVPuFYAT9YhwyQVsyQ
         lLLg==
X-Gm-Message-State: AOJu0YyegLXHXibyyDxHS3tlCspjzsR1rmJgxcODtG035UKeVtd+4U1g
	DJR7j7l63ABVo4pM4ZiJLA9LbHq+ot08PCTvpmyJ2czFKitbs2rUVH5I0iwWobYnykT0JFsuPwP
	JBIUDXzX5uuMAuMeFnGuB2yAuFNPTEZem
X-Received: by 2002:a05:6512:32d1:b0:500:c292:e44e with SMTP id f17-20020a05651232d100b00500c292e44emr28662166lfg.54.1697283475641;
        Sat, 14 Oct 2023 04:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUFtQ6aw9XDovPqLFwY8Aolbb7Mfxyb/ninQMxSK4uIoJcgAKOlzcZJRVXLp7OZ8LMV+1Ilz7gTIWednQhLPc=
X-Received: by 2002:a05:6512:32d1:b0:500:c292:e44e with SMTP id
 f17-20020a05651232d100b00500c292e44emr28662154lfg.54.1697283475322; Sat, 14
 Oct 2023 04:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
 <20231010-upstream-net-next-20231006-mptcp-ynl-v1-4-18dd117e8f50@kernel.org> <20231013172823.GR29570@kernel.org>
In-Reply-To: <20231013172823.GR29570@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Sat, 14 Oct 2023 13:37:43 +0200
Message-ID: <CAKa-r6uYbhF3zZrDaZdCE1fo4A8WF0MHNGmLS21fh11WcSfqOg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] uapi: mptcp: use header file generated from
 YAML spec
To: Simon Horman <horms@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

hello Simon, thanks for reading!

On Fri, Oct 13, 2023 at 7:30=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Oct 10, 2023 at 09:21:45PM +0200, Matthieu Baerts wrote:
> > From: Davide Caratti <dcaratti@redhat.com>
> >
> > generated with:
> >
> >  $ ./tools/net/ynl/ynl-gen-c.py --mode uapi \
> >  > --spec Documentation/netlink/specs/mptcp.yaml \
> >  > --header -o include/uapi/linux/mptcp_pm.h

[...]

> > +/**
> > + * enum mptcp_event_type
>
> Hi Davide and Matthieu,
>
> I understand that is autogenerated.
> But it is missing an entry here for @MPTCP_EVENT_UNSPEC.
> Can that be addressed somehow?

probably it just needs
    doc: unused event

in the YAML file, I will add it and regenerate the uAPI header
--=20
davide


