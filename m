Return-Path: <netdev+bounces-30419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA17872C8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FAE2815F9
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA311197;
	Thu, 24 Aug 2023 14:57:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5855F11CAE
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:57:34 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D8619B2
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:57:31 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58d70c441d5so73511027b3.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692889051; x=1693493851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFHmAqEtcB5SKJFZKlXSyxDA5+Wgl4kTCcp+DD4uPDY=;
        b=xSdOEaHVgj5+vr0C1SnqQ31p+4cmWOK/vd17KCabm3eszYOSF6cv14HjHKfYKcAxtU
         wTpEgMGZXhnEtmtYlcrw/IOk/d6deaa5fy+BRrLOVPs65bAP87sCwlXeWWwLGOjTLJYr
         UZLkV5vb7ZDll5nP+DNa0liYIUVWYMow38dbBguJ/vkF4XWKUsasCJqznWWXbXZPExmf
         6HKesoAquxT91f3QZFgw7FThxMIqo1FzxINfSMTO/7GqiLMoiy0lRoy4lW6UDS1F3Dsn
         BZee5HbPQi2FwqeEq+jw1N3X3pdolmSmj/obnaSFleZIBMe7K+ewT2xtFf7o1EPbxk37
         l+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692889051; x=1693493851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFHmAqEtcB5SKJFZKlXSyxDA5+Wgl4kTCcp+DD4uPDY=;
        b=fl+5nRBo9POvNir0YKl2a7kcYn4inZnJKonsifBvefBIOUy0JTF5nb9NnJc4fDWGrd
         lyG2HlSRpFQNWntNyzm1OUmp26wjtds6hT/x0y4DNT7RHn7nfQ+B4wj40jHuyRJG6uT0
         sZ0ZmG9TgaJVmrQv03NH14w+OqNPKllPtKQP6zgnWG/XTORPoLsFJnwG6/Mn9E2Q1jUJ
         N4c9prws/b5g+xzmmw+ppzrj0r3JdGmcCgIXeT7bnhQjzQUDL7iRkq17bE1nbmcajFv/
         t9fhy6/LkHcTIlxY8ykYg6KrY+FfWXJBbtdjBt+Q5WBpa/VBvgElWdzu1k7Xg/PwnIED
         IuhQ==
X-Gm-Message-State: AOJu0Yw3HaIjyN8rHhxaCuX/5uoWyM8AX6aDggW+2MA9dD7uvTG7+oMj
	GYxPsF+TeJ/y375KIrMkkfiGKddNjH6hCoumMtpMHQ==
X-Google-Smtp-Source: AGHT+IEAWyvj3lNN5ewLBwwOaVYqKevHoJl4afs4RvLOaLwWKEt6oQNescVw+KzwTJO4az8fgF5d9bOHkFzfuwp+BMw=
X-Received: by 2002:a0d:f446:0:b0:56d:9e2:7d9e with SMTP id
 d67-20020a0df446000000b0056d09e27d9emr17587282ywf.21.1692889050931; Thu, 24
 Aug 2023 07:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230819163515.2266246-1-victor@mojatatu.com> <20230819163515.2266246-4-victor@mojatatu.com>
 <CAM0EoMnXUSkE2XjWusrkUgyQqaokT8BEnt+9_cAeNMXa8fd61w@mail.gmail.com> <4cbd35c1bb2dd8b0a8bea85d32e3d296fac5f715.camel@redhat.com>
In-Reply-To: <4cbd35c1bb2dd8b0a8bea85d32e3d296fac5f715.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Aug 2023 10:57:19 -0400
Message-ID: <CAM0EoMnO6m06r9vngnkCdOsMc8HYKh6i5xsWTfeHs+O=zBPFiQ@mail.gmail.com>
Subject: Re: Weird sparse error WAS( [PATCH net-next v2 3/3] net/sched:
 act_blockcast: Introduce blockcast tc action
To: Paolo Abeni <pabeni@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Simon Horman <horms@kernel.org>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 10:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Thu, 2023-08-24 at 10:30 -0400, Jamal Hadi Salim wrote:
> > Dan/Simon,
> > Can someone help explain this error on the code below:
> >
> > ../net/sched/act_blockcast.c:213:9: warning: context imbalance in
> > 'tcf_blockcast_init' - different lock contexts for basic block
>
> IIRC sparse is fooled by lock under conditionals, in this case:
>
>        if (exists)
>                spin_lock_bh(&p->tcf_lock);
>
> a possible solution would be:
>
>         if (exists) {
>                 spin_lock_bh(&p->tcf_lock);
>                 goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto=
_ch);
>                 spin_unlock_bh(&p->tcf_lock);
>         } else {
>                 goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto=
_ch);
>         }
>

aha;->
Thanks - this should fix it. We will fix it to follow this pattern.

> Using some additional helpers the code could be less ugly...

I think only one other action(ife) has this pattern - we should be
able to fix that one instead.

cheers,
jamal


> Cheers,
>
> Paolo
>

