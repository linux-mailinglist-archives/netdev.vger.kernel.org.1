Return-Path: <netdev+bounces-16845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCB074EFD4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1C91C20DF5
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6688D18B19;
	Tue, 11 Jul 2023 13:06:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604418C02
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:06:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A5195
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689080774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=621jpeg8rXw1HoMqyF3Cr2cXzc4xRe3exawPPb/GBlI=;
	b=CO9VPmomMST9WOSn1yeg3KIJQf/GtfLzu360nk4k6Vk/4C8M14s0ppbH50Ih0fbXau2CMY
	NrlZJ6jBGpk214eS63IXf5jJm87WexH/lKOa8Dt5krRoxWjbhqgeE9t0r4bOaiozCQw66g
	Tl1TIux7VesmkSgUWVkgO7qrai7F9yE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-9dkDs-WjM_aM3POxk13ZOA-1; Tue, 11 Jul 2023 09:06:10 -0400
X-MC-Unique: 9dkDs-WjM_aM3POxk13ZOA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-765a44ce88aso388646885a.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689080769; x=1691672769;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=621jpeg8rXw1HoMqyF3Cr2cXzc4xRe3exawPPb/GBlI=;
        b=M+Uv1E52X3tRJRrutgiIyQqCn2Qhr17uq+xC+EWZ4765gbczdCo9batcPhz4vkitt/
         f/FL1frOpHbQyoNkvLRyadYRFelHoeSxu25bRSs6QmBpBJcDQ/Rsr/Ie/IOBB7Mdp3ot
         Irwa3bOmw86NSJeVflssgloNulB2OebHTt7aoCi/h1M7rwqPUVaM9lY+uuG9Gu5VdCsa
         rXOihWkeeYiP2KPpJhBkzWnYtdThpwGfuYn43/9twUevRlzbvZlIsuPEwroG1DDG46Tw
         lG+0LegpfTo/Py5zUnvbEdLpZR55LG4E/VfN3Vl+S2QWsBrbeSTQgZEkY7roAFtVUaVK
         SEbA==
X-Gm-Message-State: ABy/qLaxgMNsGxA8iXAmy/vck0Mk0PKLb8LWUB8oHCcP0AXCRQY6tP2J
	h3dMfA26N3XH7K33a/239wHLqpr4/fG3YJ5b6ZbqL3HU1tk2KF8aw223HEClEaNayAqJHCse8tS
	mJp84ylCkFEXWNDtb
X-Received: by 2002:a05:620a:2a08:b0:765:734b:1792 with SMTP id o8-20020a05620a2a0800b00765734b1792mr23405413qkp.23.1689080768678;
        Tue, 11 Jul 2023 06:06:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKsAEoYjCuBe/RLC+s8vVfCSnBTIjmYs9lUXherbrMHdd/xt8k/DuInjKGuiKn/ST+FGm8LA==
X-Received: by 2002:a05:620a:2a08:b0:765:734b:1792 with SMTP id o8-20020a05620a2a0800b00765734b1792mr23405385qkp.23.1689080768414;
        Tue, 11 Jul 2023 06:06:08 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id g6-20020ae9e106000000b00767dc4c539bsm970048qkm.44.2023.07.11.06.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:06:07 -0700 (PDT)
Date: Tue, 11 Jul 2023 15:06:00 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, Dmitry Kozlov <xeb@mail.ru>
Subject: [PATCH net-next 0/4] net: Mark the sk parameter of routing functions
 as 'const'.
Message-ID: <cover.1689077819.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The sk_getsecid security hook prevents the use of a const sk pointer in
several routing functions. Since this hook should only read sk data,
make its sk argument const (patch 1), then constify the sk parameter of
various routing functions (patches 2-4).

Build-tested with make allmodconfig.

Guillaume Nault (4):
  security: Constify sk in the sk_getsecid hook.
  ipv4: Constify the sk parameter of ip_route_output_*().
  ipv6: Constify the sk parameter of several helper functions.
  pptp: Constify the po parameter of pptp_route_output().

 drivers/net/ppp/pptp.c        |  4 ++--
 include/linux/icmpv6.h        | 10 ++++------
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      |  5 +++--
 include/net/route.h           |  6 +++---
 net/ipv6/datagram.c           |  7 ++++---
 net/ipv6/icmp.c               |  6 ++----
 net/ipv6/mcast.c              |  8 +++-----
 security/security.c           |  2 +-
 security/selinux/hooks.c      |  4 ++--
 10 files changed, 25 insertions(+), 29 deletions(-)

-- 
2.39.2


