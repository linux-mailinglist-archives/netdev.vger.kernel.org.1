Return-Path: <netdev+bounces-42568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28AA7CF573
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31911C20E63
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E32617747;
	Thu, 19 Oct 2023 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrptVJtO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463D18C15
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:35:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25639119
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697711735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpEQnQGcZBGxUIaYWGMcy9n7tEk18RvnwU74mxj0B5I=;
	b=IrptVJtOtJ/DyhEAwMgzzTVwrScT9qcpEDMwnBMrfO0sTrvVZ3RjHPTVu/VTRZ8KGmWMBI
	3fu09aQAqzlwkR1IiZZInrpH15Ih3fweqb0HJXLl3ILdqXX+R0n0juT4pjH/+PozUoHQD8
	OJhrZFbEwAmwJsAe/G/BtYdika9JVs4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-B12c6t8sOJKgA3BaBsw3pg-1; Thu, 19 Oct 2023 06:35:33 -0400
X-MC-Unique: B12c6t8sOJKgA3BaBsw3pg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51e535b143fso891324a12.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697711732; x=1698316532;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpEQnQGcZBGxUIaYWGMcy9n7tEk18RvnwU74mxj0B5I=;
        b=j35/dOu7KBgO7gzrTqBOEJZZ//SYAYfkfeDnV0gZT+xPyiUT8gXbV2QOD3WwQGQjwt
         i1hguuZPDlM0eNua/9kWRJcKTRhH2WWNUTUrLW9xM3tN8ffOdSaHdj/5AcHOKoS6rzBS
         Wnd2pcRkBfTUVr6k/XpEqNvo6dzP6dIf8/KKl+K6t+rdACPnpfEeX3Pk7VHzVjwYuT4R
         WVXmPFHqKejsTK3jyKK9sKyhJOOh7ak2Qc70enSWG4AWQ4AcJQO7GjEicgzz785wS+m1
         aVoI8DxlzNZi7KWtCgT9coN4O8Nk8+AQHuZjRA9WdhOYtw5HS5NuJBKWiJUln0ww0Quh
         BTng==
X-Gm-Message-State: AOJu0YxU6d3GQiuFHjXGkNj1R9RLFPc8u9fKjs/dfMwftcLdIOOt4id1
	4jcueAxYsY9vQxCbp9O62FoqLeljIvjsQrozsCAuXyCq/2d6xtl9QiIlyAsycKdew5/q0rxor2Y
	aC1LxX5SsI4ZL0XHX
X-Received: by 2002:a17:907:9708:b0:9b2:bf2d:6b66 with SMTP id jg8-20020a170907970800b009b2bf2d6b66mr1550683ejc.7.1697711732639;
        Thu, 19 Oct 2023 03:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+uzuwow9Q+Q1sZxE0P8RlP/h4HgXhv3+NSLWInRWptB+qhUaWBzKH9pRXhnnfPJAbD+He1g==
X-Received: by 2002:a17:907:9708:b0:9b2:bf2d:6b66 with SMTP id jg8-20020a170907970800b009b2bf2d6b66mr1550657ejc.7.1697711732210;
        Thu, 19 Oct 2023 03:35:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id gz21-20020a170906f2d500b009ae0042e48bsm3330617ejb.5.2023.10.19.03.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:35:31 -0700 (PDT)
Message-ID: <bca0aca50914367fffccf33b2f2ac880808d6cd9.camel@redhat.com>
Subject: Re: [PATCH net-next v2 1/1] taprio: Add boundary check for
 sched-entry values
From: Paolo Abeni <pabeni@redhat.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>, Lai Peter Jun Ann
	 <jun.ann.lai@intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Jamal Hadi Salim
	 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Oct 2023 12:35:30 +0200
In-Reply-To: <27912b49-eb1a-4100-a260-03299e8efdd4@engleder-embedded.com>
References: <1697599707-3546-1-git-send-email-jun.ann.lai@intel.com>
	 <27912b49-eb1a-4100-a260-03299e8efdd4@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-18 at 19:56 +0200, Gerhard Engleder wrote:
> On 18.10.23 05:28, Lai Peter Jun Ann wrote:
> > Adds boundary checks for the gatemask provided against the number of
> > traffic class defined for each sched-entry.
> >=20
> > Without this check, the user would not know that the gatemask provided =
is
> > invalid and the driver has already truncated the gatemask provided to
> > match the number of traffic class defined.
> >=20
> > Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@int=
el.com>
> > Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> > Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> > ---
> >   net/sched/sch_taprio.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >=20
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index 1cb5e41..44b9e21 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -102,6 +102,7 @@ struct taprio_sched {
> >   	u32 max_sdu[TC_MAX_QUEUE]; /* save info from the user */
> >   	u32 fp[TC_QOPT_MAX_QUEUE]; /* only for dump and offloading */
> >   	u32 txtime_delay;
> > +	u8 num_tc;
> >   };
> >  =20
> >   struct __tc_taprio_qopt_offload {
> > @@ -1063,6 +1064,11 @@ static int fill_sched_entry(struct taprio_sched =
*q, struct nlattr **tb,
> >   		return -EINVAL;
> >   	}
> >  =20
> > +	if (entry->gate_mask >=3D q->num_tc) {
>=20
> As far as I know within gate_mask every bit represents a traffic class.
> So for 3 traffic classes at gate_mask of 0x7 is valid but this check
> fails with 0x7 >=3D 3.

Additionally whatever check we put in place previously just ignored by
the existing code, could break the existing user-space: we can't accept
such change.=20

Cheers,

Paolo


