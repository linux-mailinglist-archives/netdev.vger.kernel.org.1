Return-Path: <netdev+bounces-30416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFC678721F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57880281616
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8864810979;
	Thu, 24 Aug 2023 14:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74028911
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:41:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA81BC6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692888113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O77VDoQsJ5CTSmvV+GLqqEGiI0r/X9wLaybA0ZqkGBY=;
	b=VMMY4jKagcnL71PPk8Jg+ZqMNVlV4Xk2WLprPYfKxIwXPihZ3nIy0T8u6CYdXCpCN+6iGE
	voq7pqSDMyu4ZU3te92ZsKVG3f1ht/kLHujTs3U46d8bStvLPQnJLHRI64cw+ByvsmcWao
	Q0ulVbTPVqUQIjybZXavVJquUDXWWsY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-dYiorHW5Pai5XODYVA_jcw-1; Thu, 24 Aug 2023 10:41:49 -0400
X-MC-Unique: dYiorHW5Pai5XODYVA_jcw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5222c47ab80so1188508a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888109; x=1693492909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O77VDoQsJ5CTSmvV+GLqqEGiI0r/X9wLaybA0ZqkGBY=;
        b=gmFaRihjsiMUf0gHpxSLO5S29iEzIGP5+eQ0Jxy9fjfso1i5zUYcAyp+SgGH9eVKgz
         FctYJgc8xpk2QubZh7O3zpS8qZAIkZmbMhLaAvUtRzcUd1OGgIioFSQ4MJJv6RqwCU2i
         eabqKVvcx8o26TO1ybMbGk0oyM3F2kECWwxJrwCogsfiNabanKbHN/5zXmzVujJnicEo
         ToQjywymX1Uyy/hcOgEUd8Fq5pD2lhGNlplKHVuHEW+tAltuqGRVVrXTMCeuQ1oI5qKd
         5o5eAkUW+YDmpczxyEaysB1NLBil7phezLSHPCrb8yrHHWcDa2fviaZgx2PdL27PGFjJ
         UG1g==
X-Gm-Message-State: AOJu0YyM8AYANLYBFMNwqLUcW0QUdUaD7kMxCKjq6w71mp7HIWS7FHKe
	GrIHIlqzi1uVHy0xBhlfehSlpEzPX2V2i10thTalwfheOl6i7+uxzCBZYuS8F8i+mX+WqRdEe1Q
	Xt7+DomUP9N/Cr51e
X-Received: by 2002:a17:906:1017:b0:9a1:f96c:4bb9 with SMTP id 23-20020a170906101700b009a1f96c4bb9mr2576460ejm.6.1692888108934;
        Thu, 24 Aug 2023 07:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgSovT9W/LBF474xUHvDh6FL2/3TbJZ9zlACRQ8AHV+LJZiHtTA8p94JnFu6c7K4czguS6Nw==
X-Received: by 2002:a17:906:1017:b0:9a1:f96c:4bb9 with SMTP id 23-20020a170906101700b009a1f96c4bb9mr2576451ejm.6.1692888108639;
        Thu, 24 Aug 2023 07:41:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id y12-20020a1709064b0c00b009a1bf608ff3sm3546170eju.132.2023.08.24.07.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 07:41:48 -0700 (PDT)
Message-ID: <4cbd35c1bb2dd8b0a8bea85d32e3d296fac5f715.camel@redhat.com>
Subject: Re: Weird sparse error WAS( [PATCH net-next v2 3/3] net/sched:
 act_blockcast: Introduce blockcast tc action
From: Paolo Abeni <pabeni@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, Dan Carpenter
	 <dan.carpenter@linaro.org>
Cc: Simon Horman <horms@kernel.org>, Linux Kernel Network Developers
	 <netdev@vger.kernel.org>
Date: Thu, 24 Aug 2023 16:41:45 +0200
In-Reply-To: <CAM0EoMnXUSkE2XjWusrkUgyQqaokT8BEnt+9_cAeNMXa8fd61w@mail.gmail.com>
References: <20230819163515.2266246-1-victor@mojatatu.com>
	 <20230819163515.2266246-4-victor@mojatatu.com>
	 <CAM0EoMnXUSkE2XjWusrkUgyQqaokT8BEnt+9_cAeNMXa8fd61w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-24 at 10:30 -0400, Jamal Hadi Salim wrote:
> Dan/Simon,
> Can someone help explain this error on the code below:
>=20
> ../net/sched/act_blockcast.c:213:9: warning: context imbalance in
> 'tcf_blockcast_init' - different lock contexts for basic block

IIRC sparse is fooled by lock under conditionals, in this case:

       if (exists)
               spin_lock_bh(&p->tcf_lock);

a possible solution would be:

	if (exists) {
		spin_lock_bh(&p->tcf_lock);
		goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
		spin_unlock_bh(&p->tcf_lock);
	} else {
		goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
	}
=09
Using some additional helpers the code could be less ugly...

Cheers,

Paolo


