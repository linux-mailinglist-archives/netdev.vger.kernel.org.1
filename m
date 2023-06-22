Return-Path: <netdev+bounces-12947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5137398CB
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 09:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43ECD28186E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D92112B77;
	Thu, 22 Jun 2023 07:59:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5EC8CF
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 07:59:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEF319AB
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687420738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0n7PyA/M8hLaxtJFsgSGnQX7yagRPt4nSsarvEnfSG8=;
	b=U/bcrXNoqoc9z4cF7sOAGtmtVgMHaNzC16osOO1F4kfchW0oaMAFH2kAuM7ALkm69XqLRg
	viryicV/pFa/Y3AVVSuuJoMxUQD8lckjiJKgkcgGEK394ZOxIAp6bkf/3e6L72ZEMwTIj0
	MBukcGnd/dyXJkK1cjIdzb0OHzL83ns=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-x-v58MYjMJW7686O9Tl_yw-1; Thu, 22 Jun 2023 03:58:56 -0400
X-MC-Unique: x-v58MYjMJW7686O9Tl_yw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7639e09a3a8so85010485a.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420736; x=1690012736;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0n7PyA/M8hLaxtJFsgSGnQX7yagRPt4nSsarvEnfSG8=;
        b=hs5RfELSrBhBWHjMhf+isHxsYlXWaIsfTHh21cumMsOD+mNk4JcLW6hu2W1D+5fyaj
         UWQR+Oozh1FHnDfok2abeCZFUIY9TqoQLwuTD+LSwadfQD74pwB6ZPhs9Lu3wUWT/3SM
         Ughl/BddV9QOrnyU7DCAGmO51Z1ufwvFSzrNPEHtSTV0lqCoY0tFvKs3Gg9hwTZnn+ol
         Ui5fPp7pmWb78p3czQQnhoa29mlyFarMlpgSZ2HhPXLYV6ABMViUZr7oXhXdExwbrrGz
         impvfaVklhqxbkhk68prFJ8ZHqelXkHoBoeVGnkJHbm7cyYqnHt+uHadSldBcFo4BB6+
         pwQA==
X-Gm-Message-State: AC+VfDwwxgtJfI1yvbr9dLNVlQMrjgNlv0OOMjkYfWBsLCeCJhc/nbdZ
	XxQgiVD+2yD+33qgrYqL+I+XgSrSubPJxlz2Y0VxA1AiLL+SIN7szuE2ZV0gQxd/vIhrVKX/HeG
	g55h1GAzGkQ+iejTC
X-Received: by 2002:a05:620a:46a2:b0:75e:ba30:8ccc with SMTP id bq34-20020a05620a46a200b0075eba308cccmr22205494qkb.1.1687420736293;
        Thu, 22 Jun 2023 00:58:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4agR3caB7V2MIqUMqHw9+6NSLVQwRG9oWz1O08dHClbzb+bu7Gn2/wzdPDy3AQCnxmF2ujbA==
X-Received: by 2002:a05:620a:46a2:b0:75e:ba30:8ccc with SMTP id bq34-20020a05620a46a200b0075eba308cccmr22205486qkb.1.1687420736000;
        Thu, 22 Jun 2023 00:58:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id v20-20020ae9e314000000b0075b168fcde9sm3142227qkf.77.2023.06.22.00.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:58:55 -0700 (PDT)
Message-ID: <746941b24732655c51dee68ed442bfc14a82e303.camel@redhat.com>
Subject: Re: [PATCH v1] net: nfc: Fix use-after-free in
 nfc_genl_llc_{{get/set}_params/sdreq}
From: Paolo Abeni <pabeni@redhat.com>
To: Lin Ma <linma@zju.edu.cn>, krzysztof.kozlowski@linaro.org, 
 avem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org
Date: Thu, 22 Jun 2023 09:58:52 +0200
In-Reply-To: <20230620025350.4034422-1-linma@zju.edu.cn>
References: <20230620025350.4034422-1-linma@zju.edu.cn>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-20 at 10:53 +0800, Lin Ma wrote:
> This commit fixes a use-after-free for object nfc_llcp_local, the root
> cause of this bug is due to the race in nfc_llcp_unregister_device.
> Just like the buggy time window below. Since the nfc_llcp_find_local will
> not increase the reference counter of object nfc_llcp_local, UAF occurs.
>=20
> // nfc_genl_llc_get_params   | // nfc_unregister_device
>                              |
> dev =3D nfc_get_device(idx);   | device_lock(...)
> if (!dev)                    | dev->shutting_down =3D true;
>     return -ENODEV;          | device_unlock(...);
>                              |
> device_lock(...);            |   // nfc_llcp_unregister_device
>                              |   nfc_llcp_find_local()
> nfc_llcp_find_local(...);    |
>                              |   local_cleanup()
> if (!local) {                |
>     rc =3D -ENODEV;            |     // nfc_llcp_local_put
>     goto exit;               |     kref_put(.., local_release)
> }                            |
>                              |       // local_release
>                              |       list_del(&local->list)
>   // nfc_genl_send_params    |       kfree()
>   local->dev->idx !!!UAF!!!  |
>                              |
> To avoid this, we can add a check to dev->shutting_down inside the
> device_lock critical section. Therefore, the nfc_genl_llc_get_params will
> surely error return if it grabs the lock after the nfc_unregister_device
> releases the lock.
>=20
> This patch applies such check for nfc_genl_llc_{{get/set}_params/sdreq}
> as they all use nfc_llcp_find_local and suffer from the race condition.

It looks like the mentioned race condition could apply to any callers
of nfc_llcp_find_local(), is there any special reason to not add the
new check directly inside nfc_llcp_find_local()?

Thanks!

Paolo


