Return-Path: <netdev+bounces-43870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3447D508B
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 15:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847D91F227D4
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA2128698;
	Tue, 24 Oct 2023 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iqQEM5+D"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7A27701
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 13:00:49 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F78310C8
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:00:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50802148be9so1640291e87.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698152446; x=1698757246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9mkSvzL5AlqEqCk4gL6PQxVO/Ut1Am/gjPnbui/hZY=;
        b=iqQEM5+DZq6rYuXpysfHPdOjEbXqRzY492KBz3FbKcY1PZAHYtnqFDhri13UbyGkLt
         9qMt8/4VtBKaoeFifAclx68R7mjIWG0ld1kf+xLkiZAoUiyeVTehC3qbBVIe+ZI5HN6g
         6GSuRNHMsTLoD6kaEJOkjGKq20YO0PVEEqF9SNILOpslZ2FUZDSnIW1AQnXFbxVizKA7
         HRPSFC7+/BOhKTA4rOe3CtH3OzY8OqZFhOQmW295bLsbrbqeqce0v6qYAfdS/tI7RIrM
         M06vk2cnSV7Ix3BNsXvryD6c/anf9JacFFn+zLyv8oS2zxKQuwh0qubEgj7ABIkFXQlf
         w3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698152446; x=1698757246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9mkSvzL5AlqEqCk4gL6PQxVO/Ut1Am/gjPnbui/hZY=;
        b=xQXwJ8jfwsIrO9EN+TwJhvQ292Oy6cW5bHcnRS1yGj3pMqmcDtTq9YN9reIlunO1xk
         oPiwM2o7Jnp+yKx4dKXYsf4vQglHtzDEluodK79K/S7uAcRSpy/NvTM7xTfKhSXXJn5Y
         3q+2SC1hz2JDFUP+Ak3Pajx9sThVJ9lcRNeRx7PnhXj56RvJAtVEEq/pPp2jVob87Y+H
         wnqRtNJLEJA3spvkU6LzyyZY+gVKoavLd2RvSPiLh0tM2KJYE/wNvmHJoSFpPzyI0p0Y
         5G3iCilWXoobqJwZTusCC7B3p0YUSjmqQNJZRw9zzsuoHsMQPsnrbFU1dVzlTt3hfJhc
         dotw==
X-Gm-Message-State: AOJu0Yy7S7lzwBbKDh5z6FCd6bRnKGu0P184cwpVNTo7ZZmWPCV47/jF
	Grd4nMq7pVsUyVvezxRWm0xeAQ==
X-Google-Smtp-Source: AGHT+IF0yE6XO/mX2TbNGtNxqeLgtwKSWDprIrmqOUxkx9EVlX98W4Y61rPzb7TU1zWbcCeFWoQKdA==
X-Received: by 2002:ac2:532a:0:b0:507:9777:7a7 with SMTP id f10-20020ac2532a000000b00507977707a7mr8516878lfh.17.1698152446332;
        Tue, 24 Oct 2023 06:00:46 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id gy5-20020a0564025bc500b0053d9cb67248sm7728993edb.18.2023.10.24.06.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:00:45 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:00:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 2/2] i40e: Fix devlink port unregistering
Message-ID: <ZTe//IyJUl10iFYI@nanopsycho>
References: <20231024125109.844045-1-ivecera@redhat.com>
 <20231024125109.844045-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024125109.844045-2-ivecera@redhat.com>

Tue, Oct 24, 2023 at 02:51:09PM CEST, ivecera@redhat.com wrote:
>Ensure that devlink port is unregistered after unregistering
>of net device.
>
>Reproducer:
>[root@host ~]# rmmod i40e
>[ 4742.939386] i40e 0000:02:00.1: i40e_ptp_stop: removed PHC on enp2s0f1np1
>[ 4743.059269] ------------[ cut here ]------------
>[ 4743.063900] WARNING: CPU: 21 PID: 10766 at net/devlink/port.c:1078 devl_port_unregister+0x69/0x80
>...
>
>Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

