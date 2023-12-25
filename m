Return-Path: <netdev+bounces-60196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D65081E0E1
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 14:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BA928227F
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 13:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E68524D5;
	Mon, 25 Dec 2023 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzZ1bJHu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5410524C7
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703510874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=eQrFSUCYGMhy2SsSQLQNb28k56c6BCyeTM61vN0o41o=;
	b=CzZ1bJHuPzKHG3Lc3rE2lRL8EU8g5Dyp8ySd6DEIbmIA9uIxYFUARTigI9D6Oc0JcEdwdN
	D7wUB8/QqterrH43aUwYUYC7xMzl9J/wNjuBHBe0aUnDsC0P1gs/exdK71UgC5ewS8zJyu
	QJ7gReiFl2ervZq9eJr+QqGLShh+EGo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Cn1MIgN9OjmVNkGQakqBRw-1; Mon, 25 Dec 2023 08:27:53 -0500
X-MC-Unique: Cn1MIgN9OjmVNkGQakqBRw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33680996d4fso2845321f8f.0
        for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 05:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703510872; x=1704115672;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQrFSUCYGMhy2SsSQLQNb28k56c6BCyeTM61vN0o41o=;
        b=JuU3JIGDTNxqKBZn8SfV5wYHtAXrJYbA6JxTnBdi/hH+NSGg8Q8naX2kD28JCY8EUU
         O+NvAo2+3gq05xxz15RK5VM8k73nF2UqSbDSNa+WdhRNa0UeSn2gVuJIYxRj3A4Fy0dt
         e+Mp47a6JjQZPZmr1UXdqgVM+qbTwFQaHqgtRpA8erF1rh85Zq3oFOoYBNh1s7ZFN5zD
         YdE3oiib2hcSsW62eiJ8Z+b3/PTpDHQH0cX4VCkeNA4R6LJumlSyf/Fnpsq8OkhI2Aa6
         UJn9Xbsb5swiejomPtQFNp0LfWALL+bEQFq/Uc2ex+imhwQenuP9JSbGkRbFPTnonUOC
         9Vqw==
X-Gm-Message-State: AOJu0YyPyjo/LUly9MRo2+2AmUQlRf3oVpUQmRE8MiSLiC7gYb3FBf4K
	uNQd6FH//htVpuCqnVa/0dE4i3zSM5uf3MB7sDxi+XxFZRSeRBwSpxONY8aRCyTYCqZQpno6DFW
	j88ATfFMjG3tCluqyL1RyNDxc
X-Received: by 2002:adf:efc3:0:b0:336:6413:682 with SMTP id i3-20020adfefc3000000b0033664130682mr2892629wrp.42.1703510872094;
        Mon, 25 Dec 2023 05:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFADLrFfKMHOhtA8f351FSOXWF1tCR+mhRQi9Bja66IW8vKteZ/pT7INfLkesHcwbnd7uOsEA==
X-Received: by 2002:adf:efc3:0:b0:336:6413:682 with SMTP id i3-20020adfefc3000000b0033664130682mr2892612wrp.42.1703510871682;
        Mon, 25 Dec 2023 05:27:51 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id t16-20020adfe450000000b0033666ec47b7sm10354728wrm.99.2023.12.25.05.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 05:27:51 -0800 (PST)
Date: Mon, 25 Dec 2023 08:27:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	hongyu.ning@linux.intel.com, jasowang@redhat.com, lkp@intel.com,
	mst@redhat.com, stefanha@redhat.com, suwan.kim027@gmail.com,
	xuanzhuo@linux.alibaba.com
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20231225082749-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit cefc9ba6aed48a3aa085888e3262ac2aa975714b:

  pds_vdpa: set features order (2023-12-01 09:55:01 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to b8e0792449928943c15d1af9f63816911d139267:

  virtio_blk: fix snprintf truncation compiler warning (2023-12-04 09:43:53 -0500)

----------------------------------------------------------------
virtio: bugfixes

A couple of bugfixes: one for a regression.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Stefan Hajnoczi (1):
      virtio_blk: fix snprintf truncation compiler warning

Xuan Zhuo (1):
      virtio_ring: fix syncs DMA memory with different direction

 drivers/block/virtio_blk.c   | 8 ++++----
 drivers/virtio/virtio_ring.c | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)


