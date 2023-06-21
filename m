Return-Path: <netdev+bounces-12694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE2B738873
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088491C20E69
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F2618C35;
	Wed, 21 Jun 2023 15:09:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08818B08
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:09:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D89272A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687360089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uMB3ETdHgdD0tMcM81kCwTmy5JB6eW9+tHfNYuJVs80=;
	b=G3vzzLmbwDsThWUFSy6nleS4J6pIXt0nj00qugSCPcIyimMyYj4aN9bOSqD8SnQSnKZiLO
	yMnTbI4bDzt97ds8B9JtqEpWufi2jidqDiyOCi5A1fL75N+cPYyY1cgi2JTX8/8EtxRNYh
	+Aoi28PEAjOuqpAC3aND/acpb17fy8w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-kr9g0FRMMT2iS8qv0De9Yw-1; Wed, 21 Jun 2023 11:04:44 -0400
X-MC-Unique: kr9g0FRMMT2iS8qv0De9Yw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b46e684046so33223821fa.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687359881; x=1689951881;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMB3ETdHgdD0tMcM81kCwTmy5JB6eW9+tHfNYuJVs80=;
        b=RmKMMYnIEqrBHGSFZxggG9Sc+IjLiIphkpCrQjM7GaSFF+g+FYlqMIcqyftjv54W7P
         ibp14uwUf4z3ZjS1z0C8HsHT0MgkgvWolhB0El1COlrOtRfrWOsWHAqSFvssrvNbZUK7
         eo4DZVZieG0XbCA3alPWl6MF+L+Co2w2AUe7YP1zQhypXqYoLHHOs/9J1w3zsNmCIXjA
         EkSldpJOuBB3Ev6h8LK9gr1vOZVu1RYiytHk5IS33LKsuaEkfRRXOqanSTzno6Zm/iPc
         Eo+w+SZZo7fcvqsEsBveFBOLf0cdc/vQTTLY5yxz+usz2QVdQvzhAEwQZqxU3THsyF+X
         fpbg==
X-Gm-Message-State: AC+VfDwC/3QFv4D7uq9+nBll4xU+p57TIq/lOJlPiRoS6qd5LCOCUh9P
	2Nk6NZk8INH6tx7/yVvpQAjrGGx5b9uDpzwl9nWOoEzowgAbQr7RPgn0u9S4HCSH3TVfgCXbFcL
	wNTsRT7d7Y+aLxio/
X-Received: by 2002:a05:651c:8c:b0:2ad:9783:bca with SMTP id 12-20020a05651c008c00b002ad97830bcamr9809842ljq.27.1687359880944;
        Wed, 21 Jun 2023 08:04:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vuvyyKGk8qVbIbbO2C0uzdA3jUE5LT/K/8MPLqve8CmK2tHPbnZ1hPdf3acB2DVxep5kd3w==
X-Received: by 2002:a05:651c:8c:b0:2ad:9783:bca with SMTP id 12-20020a05651c008c00b002ad97830bcamr9809823ljq.27.1687359880587;
        Wed, 21 Jun 2023 08:04:40 -0700 (PDT)
Received: from redhat.com ([2.52.159.126])
        by smtp.gmail.com with ESMTPSA id e14-20020a50ec8e000000b0051a5c6a50d4sm2743117edr.51.2023.06.21.08.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:04:39 -0700 (PDT)
Date: Wed, 21 Jun 2023 11:04:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	edliaw@google.com, lkp@intel.com, martin.roberts@intel.com,
	mst@redhat.com, suwan.kim027@gmail.com
Subject: [GIT PULL] virtio: last minute revert
Message-ID: <20230621110431-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following changes since commit 45a3e24f65e90a047bef86f927ebdc4c710edaa1:

  Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to afd384f0dbea2229fd11159efb86a5b41051c4a9:

  Revert "virtio-blk: support completion batching for the IRQ path" (2023-06-21 04:14:28 -0400)

----------------------------------------------------------------
virtio: bugfix

A last minute revert to fix a regression.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      Revert "virtio-blk: support completion batching for the IRQ path"

 drivers/block/virtio_blk.c | 82 +++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)


