Return-Path: <netdev+bounces-18298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E307C756581
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2692810E9
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5DEBA37;
	Mon, 17 Jul 2023 13:53:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F910BA2E
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:53:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C5CC
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689602013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cxwNxY4JS8J6tPLEogfd2SFfXj3N8uNj2U1eKeq6+xE=;
	b=ZT0/q3Hm6A6x+fXO85NjueehKOONBOTowllaus6Dari7Gw+ILba2SlsKuJEm4Y7nV9wo6D
	Y+3FgPLkSxt++J6vcuxVQ5TBB7P/9XehKbFwzoc2jsj+3+e1xBvR6z0/YwF7i8Wes4Mvel
	y1fZIJqJyHLEDhM2td7TaQ8fbQS3hts=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-CIAoRRZoMNuBvZP3sIhB7w-1; Mon, 17 Jul 2023 09:53:32 -0400
X-MC-Unique: CIAoRRZoMNuBvZP3sIhB7w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-403a95be2e7so49429371cf.3
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602012; x=1692194012;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxwNxY4JS8J6tPLEogfd2SFfXj3N8uNj2U1eKeq6+xE=;
        b=i4OpxSLlGrhK+Ww+knyuzMRlI+Q9kzSX20ESMN1ALTs907zEU74jZqKD0c48P71HIo
         Ew1NuoqbG/i5Erw+XyMw+ASdvHggg90ZXQDLbA1XeHJNILUFIKdjRoyrIvg/wHwoTsH/
         gjcMWjvyhL6ePvyBj+NmHUHYp/28mWp7tMTUF3oM/fS/cHI9sp0jvJcgM0UJxKPlWa9s
         nP01awVMI1DWtvo9TZQAZiAj2QT3oEAF7Z0JIAENJx3EDlzejHUCsf814JEvKrn+wNJO
         3xYkKmAZsK5TZ9tDTE+jT/GF40vYGoPV8+pq1Q/dNrLHkO4oJZhV7Fk7s6Rlao8odJhj
         U0WQ==
X-Gm-Message-State: ABy/qLan7l+YabQNeijPirDRq/SH7iizBnbBmPrHH1J/hZlGz+GHiuUH
	ia0oYoBr7Eqn6Y2D6+OiOJ7jWG8YdrUFqab/FMkkJn2ICZTuVYrhdQEBs2VLt4S6orLUfxzj2py
	f67DM8bzItgHT8TcO
X-Received: by 2002:a05:622a:104c:b0:3e3:9117:66e8 with SMTP id f12-20020a05622a104c00b003e3911766e8mr15174570qte.35.1689602012082;
        Mon, 17 Jul 2023 06:53:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFQ6vap0ITLUfu8vhP2jR7nb8amW+13ht5RG1X59wHJKsZtwSGwA6x7Lps3sxW4+8YYauf9HQ==
X-Received: by 2002:a05:622a:104c:b0:3e3:9117:66e8 with SMTP id f12-20020a05622a104c00b003e3911766e8mr15174559qte.35.1689602011845;
        Mon, 17 Jul 2023 06:53:31 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id x10-20020ac87eca000000b00403b44bc230sm6250267qtj.95.2023.07.17.06.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:53:31 -0700 (PDT)
Date: Mon, 17 Jul 2023 15:53:24 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	osmocom-net-gprs@lists.osmocom.org, dccp@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org
Subject: [PATCH net-next 0/3] net: Remove more RTO_ONLINK users.
Message-ID: <cover.1689600901.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Code that initialise a flowi4 structure manually before doing a fib
lookup can easily avoid overloading ->flowi4_tos with the RTO_ONLINK
bit. They can just set ->flowi4_scope correctly instead.

Properly separating the routing scope from ->flowi4_tos will allow to
eventually convert this field to dscp_t (to ensure proper separation
between DSCP and ECN).

Guillaume Nault (3):
  gtp: Set TOS and routing scope independently for fib lookups.
  dccp: Set TOS and routing scope independently for fib lookups.
  sctp: Set TOS and routing scope independently for fib lookups.

 drivers/net/gtp.c   | 3 ++-
 net/dccp/ipv4.c     | 3 ++-
 net/sctp/protocol.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.39.2


