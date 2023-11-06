Return-Path: <netdev+bounces-46152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BEE7E1B36
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 08:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9FC6B20B57
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68687C8EE;
	Mon,  6 Nov 2023 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVnA1NEd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A1D2E7
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 07:27:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4491B1BC
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 23:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699255674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43URkpYtRBGE0OYmyASXAaiR9gWD2J5xkyb/eiFUiBk=;
	b=BVnA1NEdc+GZfSycS+0d/w27b/X5HY/rfxfOKGY/3cpyNKn7Y0+dpdXbgEOn+iwOF/XAwW
	9ZQFM9+fVvjhzh3Xn+8RYCrbjgopJu/pI3W8vy+IsTz48zLW6pCj/FKODymY90ypgsJ7Gw
	1YUOiAttWc2Iubkreq3cWa098slqm80=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Wn9xljC_NwyhPOjHLbFftA-1; Mon, 06 Nov 2023 02:27:50 -0500
X-MC-Unique: Wn9xljC_NwyhPOjHLbFftA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5079a8c68c6so3858150e87.1
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 23:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699255669; x=1699860469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43URkpYtRBGE0OYmyASXAaiR9gWD2J5xkyb/eiFUiBk=;
        b=Y4yl2pDM5uhu6YGSBXewzaRrlgNUEwDaNiD3DGebaxJNTqgRpsUVX2vGBq2PvCYEXZ
         PvOjBy6qnHL6XGEYshqvqMr3mnScA8dk6I4PrxRCnPoE1z1wNWxeGIrvdXSZAKjUdZGa
         ZV57S2+oQQDHX4Gou3cT2ZXcgcd4hd/yFMczabTc836NC3XDocEhyK+1dZbzhqh+c30y
         VrAanjruSUW1TkGn63RTtdb5IRnFrWV2ALwO1/btJu8crIgc3ICZj2kP30GfF9SdhU6q
         XsqjktatkyDmUnpNzfyBjDX3GJUYZxRu8I5rXxqiFhzSN/kE+TyKKm/U7BSpnxQUQP5q
         GAyA==
X-Gm-Message-State: AOJu0YzIslo3Ag+VtoVmRsmALstInCV5g5ilte2xVhGqWbVbozWoLDNg
	6Uudo+DZ+Lt+PwHgBywUVGT1Ewvgf8dE6iGz9oZHMG2ylZgyBqcgt2Qf2YwOedwHtwWbFJ6WtmP
	7+Do74ZZJdiuOCZQiahYAf0CO//PnIQ3z
X-Received: by 2002:a19:e011:0:b0:503:fc2:bfaf with SMTP id x17-20020a19e011000000b005030fc2bfafmr19235614lfg.33.1699255669565;
        Sun, 05 Nov 2023 23:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeuHCmPxbI1vFCSmuwsvTXlqbF/Vv6BpaewiH5OFPHTfdUlAVBDe19efaIgP47YNORg4NZHGPl5Yde3mGZKnw=
X-Received: by 2002:a19:e011:0:b0:503:fc2:bfaf with SMTP id
 x17-20020a19e011000000b005030fc2bfafmr19235608lfg.33.1699255669287; Sun, 05
 Nov 2023 23:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Nov 2023 15:27:38 +0800
Message-ID: <CACGkMEt+HRZbCDGUefu268P7+0QffDpMA-RHzArhjZ2i-zRWEw@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
>
> VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> address space specified by IOAS id.
>
> VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> from the iommufd address space
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

As discussed in the previous version, any reason/advantages of this
compared to just having a single  VDPA_DEVICE_ATTACH_IOMMUFD_AS?

Thanks


