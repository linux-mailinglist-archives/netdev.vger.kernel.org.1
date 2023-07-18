Return-Path: <netdev+bounces-18569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9363757BD9
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 14:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F8A1C20D0D
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C974AD4B;
	Tue, 18 Jul 2023 12:31:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2910C8E6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 12:31:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB11E7E
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689683491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3S7Kay2jll/I2mOMaN0zpbuuSsttp78iRORP+3eGLc=;
	b=dbP3NT0dO8sPDkXpPXxxOFpiz+ADZtbcy2mO+ivVrrAMuA5f96H7/F3AuRPtt1GpW0XxvZ
	CokFHSGI0n2+CZ+SJAZuVqZW5uStqyumorODEr8ogG/lBL3rxM1ceAHEZqcu3mPQ2HV2XH
	zowwAxpCo5+pK6mzv9YZlBDgnh05U4w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-1wUgGw50O9K3LqKtTjOggw-1; Tue, 18 Jul 2023 08:31:28 -0400
X-MC-Unique: 1wUgGw50O9K3LqKtTjOggw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-765986c0568so830894885a.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 05:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689683487; x=1692275487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3S7Kay2jll/I2mOMaN0zpbuuSsttp78iRORP+3eGLc=;
        b=DCqtwFxIPGUZ+1m0lHEYy2mBEmYTPbcMK61Hk5u6NqbDhGzCl/Lw5vNC+/xSGP+LLS
         JZS+9PYd5v1V0Umv0BIiwVe/vrK8ukCMpBumYrUCNF88k8HrKo705w5LqbaUjKwFKgfG
         qz91p57WECejW4ehf0mFt8yHiS60p6vyNsCy9lfx+388XPN15PFFA7XlCRH3ddoiPc5V
         TRkOsm+XS9EoZ9wOY/trBVtSCq1O+g9Eu3qFu8jkd/CiyMClkDpDQi6YlCLFWDMaLzjV
         95aPNdOZb7CJoARp5OLf47UixoqJVmFhrSimgPuVDX7uiW1SJmewDfEaWHj8itYmp/dh
         lPBA==
X-Gm-Message-State: ABy/qLaZqsc3zLyiG+4ibXa63NINHXmYk3LWK+iaNTWo3Td1jhieq6Fx
	VUumnETC8ml2y647RvLb4d6wofOV3/JcnVr3Dmpm3zUTlEjElIRuJic5cecza+1nL9WQyxiz5Iz
	YKy2vnRoMiIVaAL0e
X-Received: by 2002:a05:620a:1a09:b0:767:39c5:652d with SMTP id bk9-20020a05620a1a0900b0076739c5652dmr4137266qkb.64.1689683487267;
        Tue, 18 Jul 2023 05:31:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlESfB1eQagyz95lVJvGzD04E1ZtY2Yo3CL8N+9aNpcFEwiK2NCExW2TZ4NWibWjFAaV9ubNIg==
X-Received: by 2002:a05:620a:1a09:b0:767:39c5:652d with SMTP id bk9-20020a05620a1a0900b0076739c5652dmr4137251qkb.64.1689683487062;
        Tue, 18 Jul 2023 05:31:27 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id os8-20020a05620a810800b00767d7fa3d05sm529155qkn.136.2023.07.18.05.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 05:31:26 -0700 (PDT)
Date: Tue, 18 Jul 2023 14:31:19 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] security: Constify sk in the sk_getsecid
 hook.
Message-ID: <ZLaGF1uOIrnB9v9Z@debian>
References: <cover.1689077819.git.gnault@redhat.com>
 <980e4d705147a44b119fe30565c40e2424dce563.1689077819.git.gnault@redhat.com>
 <CAHC9VhTrfw+5XJ+Fr0dQg0XayiD5x4-SREjpjOGmqroEbScVgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTrfw+5XJ+Fr0dQg0XayiD5x4-SREjpjOGmqroEbScVgw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 12:05:44PM -0400, Paul Moore wrote:
> On Tue, Jul 11, 2023 at 9:06 AM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > The sk_getsecid hook shouldn't need to modify its socket argument.
> > Make it const so that callers of security_sk_classify_flow() can use a
> > const struct sock *.
> >
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> > ---
> >  include/linux/lsm_hook_defs.h | 2 +-
> >  include/linux/security.h      | 5 +++--
> >  security/security.c           | 2 +-
> >  security/selinux/hooks.c      | 4 ++--
> >  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> Thanks Guillaume, this looks good to me.  I had limited network access
> last week and was only monitoring my email for urgent issues, but from
> what I can tell it looks like this was picked up in the netdev tree so
> I'll leave it alone, but if anything changes let me know and I'll
> merge it via the LSM tree.

Thanks Paul, this series has indeed been applied to the networking tree.
So no special action is needed.

> -- 
> paul-moore.com
> 


