Return-Path: <netdev+bounces-29689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215C5784590
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11C91C2090D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817521D31E;
	Tue, 22 Aug 2023 15:31:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD81CA14
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:31:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED8DCE6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692718266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqLO2V0ZPwoCiwmUHn1tH4GQt5T66HZTGlrG692z+68=;
	b=CsYnvAotBGwAq4d+OsW9ZNCQhC2EqNRKNfYqJofLdcUPa9j0a572E8TQU/xT35vAsX3Kdv
	9ixgh2YRKqqH7W7FoDbmjV3NheAFffOoTlMa9/k0B3PuslIA6OOJOSxbTHPsNaRadr+mNe
	rqKSBecuQipNUEGGp3XxXPVCgXH95uU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-yZnOcdHcOBKAWYtHnSPPxQ-1; Tue, 22 Aug 2023 11:31:04 -0400
X-MC-Unique: yZnOcdHcOBKAWYtHnSPPxQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a18256038bso42052566b.1
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718263; x=1693323063;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqLO2V0ZPwoCiwmUHn1tH4GQt5T66HZTGlrG692z+68=;
        b=jjTizP8IBKsUFHMda+3y2nHSyXavJQNvz5ICsOroHLnnDLJT+QdTiMNoB8OTt9sqI7
         TF2aXeE6/3xOfK38/j62ntpKzGG5R1T0ytturT7UClt/yZdNbwE0RsU0dYkrjKld79DI
         vK1veqac1/wG+Dtxd/NoyDE4Xfyzd/H3TIWryr31kC0JrMbIff85jnx7fPZKhgCTmAnO
         ym5OxZJbQVEhKxS6MtUoUsA4sgTt/U8cLcTqzrtVefjLBY9nGrcyUqPUdNfRHl3CiHEz
         GZIF3599SdXoAgXE+lSbebPKTs6wso0RKuuBhnX3LhesiwJRDstM2jw3B749k5F8netg
         CH3A==
X-Gm-Message-State: AOJu0YwApqDtXymY2Mez9p245q9btgXgJhPBe//QW2rBoq37JmsQL4nO
	z0+oB1XyfaQ3R0eX6CtiCGZ/QfOtXLWDawr5cpKjx3wY7UzYWdA5ABhu4Ix0uGly4kK9w64phTT
	iFje6vpeuO2p1xw2l
X-Received: by 2002:a17:906:51ce:b0:9a1:b4f9:b1db with SMTP id v14-20020a17090651ce00b009a1b4f9b1dbmr1930707ejk.1.1692718263252;
        Tue, 22 Aug 2023 08:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4qLldO9SHriB/biC2xhIUus+4dimS51pERtZRGR9Vw2TOIqYiK47v/foUI/IPbMNkxI46ig==
X-Received: by 2002:a17:906:51ce:b0:9a1:b4f9:b1db with SMTP id v14-20020a17090651ce00b009a1b4f9b1dbmr1930697ejk.1.1692718262982;
        Tue, 22 Aug 2023 08:31:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id c25-20020a170906529900b0099cf840527csm8299419ejm.153.2023.08.22.08.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:31:02 -0700 (PDT)
Message-ID: <f80fcd476a230c354bf9758762250c43a1f3d5cc.camel@redhat.com>
Subject: Re: [PATCH] sock: Fix sk_sleep return invalid pointer
From: Paolo Abeni <pabeni@redhat.com>
To: eadavis@sina.com, syzbot+666c97e4686410e79649@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,  ralf@linux-mips.org,
 syzkaller-bugs@googlegroups.com, hdanton@sina.com
Date: Tue, 22 Aug 2023 17:31:00 +0200
In-Reply-To: <20230822124419.1838055-1-eadavis@sina.com>
References: <000000000000e6c05806033522d3@google.com>
	 <20230822124419.1838055-1-eadavis@sina.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-08-22 at 20:44 +0800, eadavis@sina.com wrote:
> From: Edward AD <eadavis@sina.com>
>=20
> The parameter sk_sleep(sk) passed in when calling prepare_to_wait may=20
> return an invalid pointer due to nr-release reclaiming the sock.
> Here, schedule_timeout_interruptible is used to replace the combination=
=20
> of 'prepare_to_wait, schedule, finish_wait' to solve the problem.
>=20
> Reported-and-tested-by: syzbot+666c97e4686410e79649@syzkaller.appspotmail=
.com
> Signed-off-by: Edward AD <eadavis@sina.com>

This looks wrong. No syscall should race with sock_release(). It looks
like you are papering over the real issue.

As the reproducer shows a disconnect on an connected socket, I'm wild
guessing something alike 4faeee0cf8a5d88d63cdbc3bab124fb0e6aed08c
should be more appropriate.

Cheers,

Paolo


