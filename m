Return-Path: <netdev+bounces-30146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C566B78635A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 00:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609832813A6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 22:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0FE200BB;
	Wed, 23 Aug 2023 22:28:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B260FBE7
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 22:28:31 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAB3E6F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 15:28:30 -0700 (PDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 935D83F8E0
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 22:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1692829708;
	bh=beLfWqJuSAaRbPKt2DoWXPMUX0BJJQLMX+9svEh6eeQ=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=sJOEr/RFbOVwjIW+5iQWoAEG2Y6NbWq7oyQ96G+mXH95dJrmHwzpfXdVaaG5AaaZw
	 HouNSmHtlcytpJ0o6rE17HxllYTOCUanhHB/12YOsBvFaybpw3iaw0jxUzMxfQxxDF
	 3NCvAF4CLRM7Pd7PW3QEjg3D9xQFnaPeiVi05i4GbUtRdM/oBUP5DGrtrbo+DuH8Rd
	 5aN7A6NAcwRCb3yRDpMxAzFC+L2pIQGLx3uuh3e5AyXq5QHCcIZylU1lWL94Oq2toj
	 uXH9ZQmhtS+MkBI2GBfa4ndYIOzTBMJdNC37p6yTnHkCxaELPsB0CSy2XEB59wJRSu
	 0pNyoJWAywaNA==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68a4175e8c3so4853131b3a.0
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 15:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692829707; x=1693434507;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beLfWqJuSAaRbPKt2DoWXPMUX0BJJQLMX+9svEh6eeQ=;
        b=Wwhd8rHbN4m2h4S3MnsSxu4tE96nIx/L4Tj+OLh8oNk9mynJHfgwv2fXpcERoFlqxO
         BHqoe/yEntoCoAtvwsMXsyPv+nbp54qdRzsK64XnMXUhOHEXx/FNmgCzB3qweTh3XrTG
         oE9ENjb+4xQyaijOnEXMQQSR+0sGD5VoD7cX1fp2EAKZp0AD8zorOUwd8pT3oceGlMJW
         1lGZJUsGPDB5R00VfpKhxCvTaz8m1qpvcHb53iCgQg4YkqhIij6UwM1DtHMwW3j93xmp
         WrugKsGMdgLetYZxeNB8Ygjxjh8A6I0Ym5KtTTv+Pt48kQWdG9GGvD54kKLfN9D/wJAD
         PP8w==
X-Gm-Message-State: AOJu0YwNtc2dpwSsqpbU9xtOadzrEzPKpd/uK+Qa7anGWj0MSrbHO1hn
	nKudCD9emWuMhVg4iLK9/5jAh2u+JjfeVhWOL01K9XyYmKSZWS9hLSIDCGkjGDhSut9dWc33MRW
	AMCpXGZ7oT4R13ox4nBCIVupJq4u0FI+AQw==
X-Received: by 2002:a05:6a20:320e:b0:13f:9dbc:e530 with SMTP id hl14-20020a056a20320e00b0013f9dbce530mr10569540pzc.8.1692829707116;
        Wed, 23 Aug 2023 15:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv8I1ConDBRsKAijx6FdbhH6nMbHmYRJadjU7GWK1sh8NwWy01M+0kjlNW8tdp01W5BOXrsA==
X-Received: by 2002:a05:6a20:320e:b0:13f:9dbc:e530 with SMTP id hl14-20020a056a20320e00b0013f9dbce530mr10569524pzc.8.1692829706685;
        Wed, 23 Aug 2023 15:28:26 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id fk22-20020a056a003a9600b0068beb77468esm298006pfb.0.2023.08.23.15.28.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2023 15:28:26 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id E47EF5FEAC; Wed, 23 Aug 2023 15:28:25 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id DE7289F863;
	Wed, 23 Aug 2023 15:28:25 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
    Jiri Pirko <jiri@nvidia.com>,
    Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv3 net 0/3] fix macvlan over alb bond support
In-reply-to: <20230823071907.3027782-1-liuhangbin@gmail.com>
References: <20230823071907.3027782-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 23 Aug 2023 15:19:03 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30423.1692829705.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Aug 2023 15:28:25 -0700
Message-ID: <30424.1692829705@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Currently, the macvlan over alb bond is broken after commit
>14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mode bonds").
>Fix this and add relate tests.
>
>Hangbin Liu (3):
>  bonding: fix macvlan over alb bond support
>  selftest: bond: add new topo bond_topo_2d1c.sh
>  selftests: bonding: add macvlan over bond testing

	For the series:

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>


> drivers/net/bonding/bond_alb.c                |   6 +-
> include/net/bonding.h                         |  11 +-
> .../selftests/drivers/net/bonding/Makefile    |   4 +-
> .../drivers/net/bonding/bond_macvlan.sh       |  99 +++++++++++
> .../drivers/net/bonding/bond_options.sh       |   3 -
> .../drivers/net/bonding/bond_topo_2d1c.sh     | 158 ++++++++++++++++++
> .../drivers/net/bonding/bond_topo_3d1c.sh     | 118 +------------
> 7 files changed, 272 insertions(+), 127 deletions(-)
> create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macv=
lan.sh
> create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo=
_2d1c.sh
>
>-- =

>2.41.0
>
>

