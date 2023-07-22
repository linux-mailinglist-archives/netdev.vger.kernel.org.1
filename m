Return-Path: <netdev+bounces-20134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441375DCA0
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 14:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B411C2099C
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5481A1D2F0;
	Sat, 22 Jul 2023 12:41:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA9DF44
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 12:41:45 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A518810F4
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 05:41:44 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57712d00cc1so33096497b3.3
        for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690029704; x=1690634504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tw44aXlg8gAMzgUVzVnv1pe0LbuYKmIGs6de9+fTS+U=;
        b=BNhKfBTcYqhQg6aD/B/rWrQSsvy09pRyXt/cSy4slxfSX96hHrKBaNCFte1N/RaTM9
         tM9fQUUlH7MBAbDH8J/br9fmNVj4mruayvX+gZe/nQ4i+S3nvdZKb+p7RzVSv3fY54Us
         K97cvID3Jxid7Yj/9Vt0SUwANkVXkIFEWyIZULO07bzgCC6gOiJmd6hr308RRcrUmYsn
         0GKjgVsdqSTSB6jTejMThU5nLTvUqKVMCEkLykRwRHUTOCUjX4DC18FdxU2JqPBk+Jw8
         mf5rwycJkLNoDV2X6OyXoOkrkUEUyvSMKe2aW9Ck9NuVYJjRoiD0Zqq6D+LdDFyZeRZb
         px5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690029704; x=1690634504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tw44aXlg8gAMzgUVzVnv1pe0LbuYKmIGs6de9+fTS+U=;
        b=jfxSvHw2YUord0foDB8AKGDtCvyubI35h0u/AevAkQV4YZb1z4rph0wxXAFwkyZJpP
         XAxWErd4itqPQjy3NafqXQ1288jYkO39og/OYqYRV2WPssYzWZHWkNws635DtlrpnElI
         fnVHJdT25npS5idRtXTvKhejQDgGNIB7hIBHqORYsyw/AfM+QlYE5HZIRQ7JoauwSlAo
         67YjE69lg2deOiPnE74aRdm053mMcES1y50k85nxGEr7s4/Il/Jq/skCYFqEdaMXCY3a
         uHK0hMpcId0ufWrnDPu/PgHBuZb9rg4FVi1m4ftL1wy85ackJbEDiZNk6NBJ07AQi0Vn
         K6ow==
X-Gm-Message-State: ABy/qLbDygZDAYsK741p1/mtiHNiheXk44mnKmgtq3oYtWK/ZkTP1yJy
	NrCM4eXx0fdaf6GJTs81K0SWVsLYo9HkHgI4wh4nAA==
X-Google-Smtp-Source: APBJJlFLRcK0PTW3rXRlXEVuhZbSDeAz1r+wYEiUTMuEJ/0ZALvGdn5Anu22rwC2BFpOv9XEVyOd1awikgxviyEecjg=
X-Received: by 2002:a81:4655:0:b0:57a:3dd8:1038 with SMTP id
 t82-20020a814655000000b0057a3dd81038mr2816134ywa.12.1690029703870; Sat, 22
 Jul 2023 05:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721191332.1424997-1-pctammela@mojatatu.com>
In-Reply-To: <20230721191332.1424997-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 22 Jul 2023 08:41:32 -0400
Message-ID: <CAM0EoMnOpd4hAgPWoiEsFmJBF93_qeBonQvDZTBjyvmN-JCwmw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] net/sched: improve class lifetime handling
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 3:14=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Valis says[0]:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Three classifiers (cls_fw, cls_u32 and cls_route) always copy
> tcf_result struct into the new instance of the filter on update.
>
> This causes a problem when updating a filter bound to a class,
> as tcf_unbind_filter() is always called on the old instance in the
> success path, decreasing filter_cnt of the still referenced class
> and allowing it to be deleted, leading to a use-after-free.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Turns out these could have been spotted easily with proper warnings.
> Improve the current class lifetime with wrappers that check for
> overflow/underflow.
>
> While at it add an extack for when a class in use is deleted.
>
> [0] https://lore.kernel.org/all/20230721174856.3045-1-sec@valis.email/
>

For the series:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
>
> Pedro Tammela (5):
>   net/sched: wrap open coded Qdics class filter counter
>   net/sched: sch_drr: warn about class in use while deleting
>   net/sched: sch_hfsc: warn about class in use while deleting
>   net/sched: sch_htb: warn about class in use while deleting
>   net/sched: sch_qfq: warn about class in use while deleting
>
>  include/net/sch_generic.h |  1 +
>  include/net/tc_class.h    | 33 +++++++++++++++++++++++++++++++++
>  net/sched/sch_drr.c       | 12 +++++++-----
>  net/sched/sch_hfsc.c      | 11 +++++++----
>  net/sched/sch_htb.c       | 11 ++++++-----
>  net/sched/sch_qfq.c       | 11 ++++++-----
>  6 files changed, 60 insertions(+), 19 deletions(-)
>  create mode 100644 include/net/tc_class.h
>
> --
> 2.39.2
>

