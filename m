Return-Path: <netdev+bounces-41848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060747CC0B4
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407F21C209C9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FFC15AD0;
	Tue, 17 Oct 2023 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jmp5fcJr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04D41751
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:31:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6F89F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697538701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PQNd65jbO86OIlgL0xtBIZWLMK2wzq1JGDzpYDTVTc=;
	b=Jmp5fcJrPfFMNPbKcZuL9uRcr9sRggSsp1ldicQ2LLZRDLfNpCwxMkLhsRrzrSjEMSxROq
	XtHyydhKPB6MA7wkaTvSVk6a+MFUKa06PVLik3Ldic5MunKCO1U5S+0mDrH8z6y3FhGIuD
	S5iGY99o0sGOMHyZR5iml1vmn+DVfVQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-TZlbg4tHOJO7ga5WTucmAQ-1; Tue, 17 Oct 2023 06:31:39 -0400
X-MC-Unique: TZlbg4tHOJO7ga5WTucmAQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-53d996a15e1so1039272a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697538698; x=1698143498;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PQNd65jbO86OIlgL0xtBIZWLMK2wzq1JGDzpYDTVTc=;
        b=nwBE8gRMIJOVeI1WZcK4JRknIZlCAA3Ck1HG3dPbBpsnxjLb6TFlax7wpcG9EVfBvK
         EOqRe7aHy5IFGraS/K25mAbziwNHGh8sWd3Sxu/M+E310ENbuGhuRzs5Isvm+/VaOxYD
         jANX9a/+D753IGtAXj67fEBsSHanP5wiLwGv5yB0ZZQToaCuM+Wm8mvh26/wrtzZAUlV
         HWwhOQg1libV2yDAoOw7ABYmgCMxGvlCYOnby+rNn6I45ghlZeeaSNW05p+0cp+88K/x
         Ze3GwubtbqpJLH7/3u/VsZWTPw8Jqv9hG7KoquE6EopswSKzB9hUgSK/I4WcmS4lNDu/
         gixA==
X-Gm-Message-State: AOJu0YxlhGaWLkwFdf83t8ftTFQru4RrTxtVO+UqMGe9KVlwhYmL3DXA
	1o/xq0KcOtRRdx/fntMs+NVi3gkKMxWJwYpAMxct8raG7QulzG9g+Xa8s7B7xgurg4x9G0Ql4sw
	9EsEqaa4b+OsZ0dYv
X-Received: by 2002:a05:6402:31e1:b0:53f:12e0:fba3 with SMTP id dy1-20020a05640231e100b0053f12e0fba3mr1304502edb.1.1697538698491;
        Tue, 17 Oct 2023 03:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAbwOnF0ogNOzyxOwQAvKPzIBz3SQuwXSsW9rlIJHyh123Wldx7SAZ8wGa6WB5E/6ljLTIkA==
X-Received: by 2002:a05:6402:31e1:b0:53f:12e0:fba3 with SMTP id dy1-20020a05640231e100b0053f12e0fba3mr1304490edb.1.1697538698147;
        Tue, 17 Oct 2023 03:31:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-87.dyn.eolo.it. [146.241.233.87])
        by smtp.gmail.com with ESMTPSA id eh15-20020a0564020f8f00b0053e775e428csm928723edb.83.2023.10.17.03.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 03:31:37 -0700 (PDT)
Message-ID: <20aed7c604115c7f346cdbbe848c37feded3cf21.camel@redhat.com>
Subject: Re: [PATCH] net/tls: Fix slab-use-after-free in tls_encrypt_done
From: Paolo Abeni <pabeni@redhat.com>
To: Juntong Deng <juntong.deng@outlook.com>, borisp@nvidia.com, 
	john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
Date: Tue, 17 Oct 2023 12:31:36 +0200
In-Reply-To: <VI1P193MB0752428D259D066379242BD099D3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
References: 
	<VI1P193MB0752428D259D066379242BD099D3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-10-12 at 19:02 +0800, Juntong Deng wrote:
> In the current implementation, ctx->async_wait.completion is completed
> after spin_lock_bh, which causes tls_sw_release_resources_tx to
> continue executing and return to tls_sk_proto_cleanup, then return
> to tls_sk_proto_close, and after that enter tls_sw_free_ctx_tx to kfree
> the entire struct tls_context (including ctx->encrypt_compl_lock).
>=20
> Since ctx->encrypt_compl_lock has been freed, subsequent spin_unlock_bh
> will result in slab-use-after-free error. Due to SMP, even using
> spin_lock_bh does not prevent tls_sw_release_resources_tx from continuing
> on other CPUs. After tls_sw_release_resources_tx is woken up, there is no
> attempt to hold ctx->encrypt_compl_lock again, therefore everything
> described above is possible.
>=20
> The fix is to put complete(&ctx->async_wait.completion) after
> spin_unlock_bh, making the release after the unlock. Since complete is
> only executed if pending is 0, which means this is the last record, there
> is no need to worry about race condition causing duplicate completes.
>=20
> Reported-by: syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D29c22ea2d6b2c5fd2eae
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

Have you tested this patch vs the syzbot reproducer?

I think the following race is still present:

CPU0                            CPU1
tls_sw_release_resources_tx     tls_encrypt_done
spin_lock_bh
spin_unlock_bh
                                spin_lock_bh
                                spin_unlock_bh
                                complete

wait
// ...
tls_sk_proto_close

                                test_and_set_bit(BIT_TX_SCHEDULED, &ctx->tx=
_bitmask
				// UaF

regardless of 'complete()' being invoked before or after the
'spin_unlock_bh()'.

Paolo


