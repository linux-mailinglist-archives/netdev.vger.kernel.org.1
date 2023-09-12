Return-Path: <netdev+bounces-33128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2444879CC83
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B49B1C20D09
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC6168C5;
	Tue, 12 Sep 2023 09:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67A213AF4
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:56:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 193F81BB
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694512581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwbY5T4S7HVWeFjupYj7Meyn2zny3d5w0hwW7I2C90g=;
	b=SdMNSE9GBWv2fut0Z1HVmPSLJUq/jL8rUc1SkQnFGcGrR9TOv4SGkZRIyjdSyJ+5jic35t
	Ui6pdVO5sRcZi2346diYGNqJVIvvWkKKl28iRCCfuCopKCTaWG1jO8wXXE5jzv6r/HoOTB
	n+7FrssSayyw0GVE4P+ijUUrYM4MG5I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-fB47JSSoMCOysyBhLwuFLA-1; Tue, 12 Sep 2023 05:56:18 -0400
X-MC-Unique: fB47JSSoMCOysyBhLwuFLA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-525691cfd75so1055627a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694512577; x=1695117377;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwbY5T4S7HVWeFjupYj7Meyn2zny3d5w0hwW7I2C90g=;
        b=KF6sUN0NxMseyPqr3incgjg7MXB2m6WyGyIPR/fnL4Mbi9LLA/K4817KkkFzI8V6KU
         /6YMwKWMR/NId9MjgQQwGWPLSEReQqtobUU7RSRbyI+duma7EEWbDDMu53I3R+8LZ8BP
         YE7NeyO8tFyIFj7g7v5/6OsPCGl8kFSuS7P8fLIu63wnijSZi5WqLBOod3RRyAEBdA+W
         ZUwOCtVcSGBZrvDxjR6Tu65QUy3FSYanMlmOiZbOzyP9Zp2ri2oYxXCQQDqbxVv31J+9
         Bw/yZAjUJeQCsdfkxUGpRUQDImXNfnDB1FwP9ZR/klcw/tPfmprYRQ4Grz8HQdo6CFRH
         trwg==
X-Gm-Message-State: AOJu0YxJlbnuJ/VuJYnZpq0+2aDVdTA0Xly1enfmdAMncgZCn+TDqYVr
	Nu5L7uis76BPuOfiE11/gKoNWL8i0PvdOaMqm+JhJxYouaG7ux4PI1B/SyKdFkxAHcsE+Ud7ZwD
	3ZD+LsHuxNLcwtHfb
X-Received: by 2002:a05:6402:26cc:b0:514:ab8b:ee78 with SMTP id x12-20020a05640226cc00b00514ab8bee78mr10100851edd.3.1694512577547;
        Tue, 12 Sep 2023 02:56:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL6yEqSITkrMXY37tjjUVT9sr6X+90RRvmipG1uMwsARpI1raoLpntc8EIwiFYT+PS/8a0Qw==
X-Received: by 2002:a05:6402:26cc:b0:514:ab8b:ee78 with SMTP id x12-20020a05640226cc00b00514ab8bee78mr10100843edd.3.1694512577268;
        Tue, 12 Sep 2023 02:56:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id l9-20020aa7c309000000b0052a19a75372sm5664844edq.90.2023.09.12.02.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:56:16 -0700 (PDT)
Message-ID: <0168a988486f4bff08bd186d5aea1cfe4900a2c3.camel@redhat.com>
Subject: Re: [PATCH iwl-next  v2] ice: Add support for packet mirroring
 using hardware in switchdev mode
From: Paolo Abeni <pabeni@redhat.com>
To: Andrii Staikov <andrii.staikov@intel.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Tue, 12 Sep 2023 11:56:15 +0200
In-Reply-To: <20230912092952.2814966-1-andrii.staikov@intel.com>
References: <20230912092952.2814966-1-andrii.staikov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

On Tue, 2023-09-12 at 11:29 +0200, Andrii Staikov wrote:
> Switchdev mode allows to add mirroring rules to mirror
> incoming and outgoing packets to the interface's port
> representor. Previously, this was available only using
> software functionality. Add possibility to offload this
> functionality to the NIC hardware.
>=20
> Introduce ICE_MIRROR_PACKET filter action to the
> ice_sw_fwd_act_type enum to identify the desired action
> and pass it to the hardware as well as the VSI to mirror.
>=20
> Example of tc mirror command using hardware:
> tc filter add dev ens1f0np0 ingress protocol ip prio 1 flower
> src_mac b4:96:91:a5:c7:a7 skip_sw action mirred egress mirror dev eth1
>=20
> ens1f0np0 - PF
> b4:96:91:a5:c7:a7 - source MAC address
> eth1 - PR of a VF to mirror to
>=20
> Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>

The amount of patches that IMHO should land only into intel-specific
MLs and instead reaches also netdev, recently increased.

Please try harder to apply proper constraints to your traffic, netdev
is already busy enough!

Thanks,

Paolo


