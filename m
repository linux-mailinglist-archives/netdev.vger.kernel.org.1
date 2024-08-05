Return-Path: <netdev+bounces-115852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D4948162
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBBF2B257D7
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55748CCD;
	Mon,  5 Aug 2024 18:04:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB6166F1A
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881058; cv=none; b=Xb90NedTwuRYD2YjlIllPIpCENdAYRAR3hQ+4GSu1Qff9bukn+uH9uyiyo9eKdGYObTdY8t5NZbwqgpDd0/l53KEGLcUtQLOvaI7ogdodsLXVy13E0OSB332CW/rDfBXkbvNYQQnbOwHU/kSCMglEQfVmbww5uiwFqPInC/vPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881058; c=relaxed/simple;
	bh=F6yX2OYshGLRH3k/5XrjLiLOYlbk++KVZdKnII2ZNeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgK6EwqSimQpTJgIOgEwBUE6P03KOn66doH7QYoD/L5cYHb/70lCplgxZhQMtiN19COO43+bWW04zrNp9ZTW0mZiKTsgwhupXH29ALz4xUB5cxkZwbVP3U5r/B81PGZNFiUlJbMXxvejmpHwI2SS/P+/hNYNPrvp6j60ZLhf1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so5656866b.0
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 11:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722881055; x=1723485855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sn2AZlnh5z4oIQGvtIoaQe/yUrepeRQvLgvQ+H3JrHU=;
        b=K+MMco7hag+GI4h5ko/viud9Ucotw41nk6oPpLL+fED6P2NurVU4WPeyJD5eS0uBJM
         1mtxoggEQBDQLHf4OXOsxYFh/qHCa5DEE9oKtq/R9Sm5b9Jp26wCFhPQDHl3dgCFoCqT
         3kneIAfG+0zr+prHvaIbKhAyklM40sNtFRxPx8glbTo5T8ybXFGXBWddwlYaGUNGe0ID
         IV7Jjrcuz8YwrMA9dsA3+MyN2CWYH8C+uAc4MFdnsZazOYjvcTcQa3Sk7uA/O/ZKspwN
         F4m7VW1eMpWj7FtSTk26jNZ9HTmYsEn2Z52qSdJrmOKP1B79aF1zjfw4LlXnWoAwP3T1
         tAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWVeocjba+FAjUqZ7GqTj0ImCAl/Ixz+A3Bmarhpf+Dv7ywH11A72z9mk361vBbPxR0dsJB2oLeh6zQ4R9BgfVsD7ctmCQ
X-Gm-Message-State: AOJu0Yy7Oehitka0Ap/6X4AiC5W5lU9NQSorPdGeDGA/S7DP0pmso0CT
	nN4tg/+vPL7u74vx4fDH8aNKtFd/rDJEO5iDKWgSPLS692Wfl+m/
X-Google-Smtp-Source: AGHT+IHUzVOwDN4rd3aJJ+cKr6xkzcGlzqEV2rqTW86xLFAbEdYvyL4n2cYubFDBBTAN949ocPVL2w==
X-Received: by 2002:a17:907:9712:b0:a73:9037:fdf5 with SMTP id a640c23a62f3a-a7dc5f65bf5mr1177370066b.6.1722881054441;
        Mon, 05 Aug 2024 11:04:14 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4542esm477355566b.127.2024.08.05.11.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:04:14 -0700 (PDT)
Date: Mon, 5 Aug 2024 11:04:11 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net] bnxt: fix crashes when reducing ring count with
 active RSS contexts
Message-ID: <ZrEUGypU4miANEQ9@gmail.com>
References: <20240705020005.681746-1-kuba@kernel.org>
 <ZrC6jpghA3PWVWSB@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrC6jpghA3PWVWSB@gmail.com>

On Mon, Aug 05, 2024 at 04:42:11AM -0700, Breno Leitao wrote:
> Hello,
> 
> On Thu, Jul 04, 2024 at 07:00:05PM -0700, Jakub Kicinski wrote:
> > bnxt doesn't check if a ring is used by RSS contexts when reducing
> > ring count. Core performs a similar check for the drivers for
> > the main context, but core doesn't know about additional contexts,
> > so it can't validate them. bnxt_fill_hw_rss_tbl_p5() uses ring
> > id to index bp->rx_ring, which without the check may end up
> > being out of bounds.
> > 
> >   BUG: KASAN: slab-out-of-bounds in __bnxt_hwrm_vnic_set_rss+0xb79/0xe40
> >   Read of size 2 at addr ffff8881c5809618 by task ethtool/31525
> >   Call Trace:
> >   __bnxt_hwrm_vnic_set_rss+0xb79/0xe40
> >    bnxt_hwrm_vnic_rss_cfg_p5+0xf7/0x460
> >    __bnxt_setup_vnic_p5+0x12e/0x270
> >    __bnxt_open_nic+0x2262/0x2f30
> >    bnxt_open_nic+0x5d/0xf0
> >    ethnl_set_channels+0x5d4/0xb30
> >    ethnl_default_set_doit+0x2f1/0x620
> 
> I have this patch applied to my tree, and I am still finding a very
> similar KASAN report in the last net-next/main tree - commit
> 3608d6aca5e793958462e6e01a8cdb6c6e8088d0 ("Merge branch 'dsa-en7581'
> into main")
> 
> Skimmer over the code, In bnxt_fill_hw_rss_tbl(), bp->rss_indir_tbl[i]
> returns 8, but, vnic->fw_grp_id size is 8, thus, it tries to access over
> the last element (7).
> 
> Somehow bp->rss_indir_tbl[i] goes beynd rx_nr_rings.

I was able to debug this further, and the culprit is

98ba1d931f611e8f8f519c040 ("bnxt_en: Fix RSS logic in __bnxt_reserve_rings()")

