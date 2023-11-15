Return-Path: <netdev+bounces-47912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404597EBD7B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 08:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3581C20A22
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 07:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C382E2E856;
	Wed, 15 Nov 2023 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tyDtAudz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656D5CBC
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:16:33 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A794F8E
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 23:16:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso958204766b.2
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 23:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700032589; x=1700637389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HV8Eb4g7P4o9iQFCN+YkhdZXGat6CVP5qSXvbBBGeGg=;
        b=tyDtAudzOhKp0wu22SQh75suVspYOa/QaBTMyZMgal4flrEiyE2ug215deWuJcvWyG
         zgsIGSybKCERZui/uu7aDJPoAD9hTd70Pbuk+J4JLTXSBdCxACPhX2YhScJ3IPyrzZkH
         rh33eZqJtvv20ILCSelyw0Pv1PpHIBjxW46+xZPRIgF9yG2fhpbUTN0Q4qeKBE6Di9TO
         7ukKvofbSCBNBpu95SbB+q/n6lCD0TB/BAHIYABNd9Evz7rMrv2F3YgwNRpXzcepC0Yz
         O95YF8zcVxnrBRLDllmzPfXoe8JHK+Awykt180O7x/nMGHzvxb2B0ZN8opcyQJZRGkTA
         iqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700032589; x=1700637389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HV8Eb4g7P4o9iQFCN+YkhdZXGat6CVP5qSXvbBBGeGg=;
        b=AGziNE9E6sZdQ1m7y0kvWvZdH9GQnuCgxgGdnotROV8EAjCR3ZKGZJulkAI8eMShHQ
         JHYwelBDFSEMCWhduL/X0/Fsy/27/jsdm6nntDG7Sdh1Eif405CH3k1ryTxYH62IrLtI
         GVI+lXP40rkpEfd93d4Q1BoZEMAZ/NaO18C08Idt71Q9uFVQJTnA+rdCJSfkOqqifSih
         Fw65DkcHcw5UME8B9t8xBDapowMIelR3LUpNYbcWbWYAG0b61GK1TAso1LpfCsHeKqWI
         qpI+Utm5kqLBI0OdalgJzKjB6PmiM9rV+vCxTXU3T+9cpBa2eDhdw1DDd0LbWhDHeWOa
         KMFA==
X-Gm-Message-State: AOJu0YwjbtjdikhWrBQnw9r6tUxJfajR6YL3s/4abDmCWNEka9FdoA+G
	vZ2SYEUBQEtOzPvS0yMRrbM+Cw==
X-Google-Smtp-Source: AGHT+IFUVutrq51us2jaCCn3nKDzT/Gqmth/HhdBv1WwLpVgabZCQG38LXe0u1IYLY62df8jtIHOVw==
X-Received: by 2002:a17:906:fa9b:b0:9dd:6664:1a3a with SMTP id lt27-20020a170906fa9b00b009dd66641a3amr7938038ejb.51.1700032589035;
        Tue, 14 Nov 2023 23:16:29 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id dt10-20020a170906b78a00b009a5f1d15644sm6552546ejb.119.2023.11.14.23.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 23:16:28 -0800 (PST)
Date: Wed, 15 Nov 2023 08:16:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org, vyasevic@redhat.com,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] macvlan: Don't propagate promisc change to lower dev
 in passthru
Message-ID: <ZVRwS4wIy1ORH4jS@nanopsycho>
References: <20231114175915.1649154-1-vladbu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114175915.1649154-1-vladbu@nvidia.com>

Tue, Nov 14, 2023 at 06:59:15PM CET, vladbu@nvidia.com wrote:
>Macvlan device in passthru mode sets its lower device promiscuous mode
>according to its MACVLAN_FLAG_NOPROMISC flag instead of synchronizing it to
>its own promiscuity setting. However, macvlan_change_rx_flags() function
>doesn't check the mode before propagating such changes to the lower device
>which can cause net_device->promiscuity counter overflow as illustrated by
>reproduction example [0] and resulting dmesg log [1]. Fix the issue by
>first verifying the mode in macvlan_change_rx_flags() function before
>propagating promiscuous mode change to the lower device.
>
>[0]:
>ip link add macvlan1 link enp8s0f0 type macvlan mode passthru
>ip link set macvlan1 promisc on
>ip l set dev macvlan1 up
>ip link set macvlan1 promisc off
>ip l set dev macvlan1 down
>ip l set dev macvlan1 up
>
>[1]:
>[ 5156.281724] macvlan1: entered promiscuous mode
>[ 5156.285467] mlx5_core 0000:08:00.0 enp8s0f0: entered promiscuous mode
>[ 5156.287639] macvlan1: left promiscuous mode
>[ 5156.288339] mlx5_core 0000:08:00.0 enp8s0f0: left promiscuous mode
>[ 5156.290907] mlx5_core 0000:08:00.0 enp8s0f0: entered promiscuous mode
>[ 5156.317197] mlx5_core 0000:08:00.0 enp8s0f0: promiscuity touches roof, set promiscuity failed. promiscuity feature of device might be broken.
>
>Fixes: efdbd2b30caa ("macvlan: Propagate promiscuity setting to lower devices.")
>Reviewed-by: Gal Pressman <gal@nvidia.com>
>Signed-off-by: Vlad Buslov <vladbu@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

