Return-Path: <netdev+bounces-45222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 834B97DB937
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 12:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C70B20E16
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241BF13FE1;
	Mon, 30 Oct 2023 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="U+JTAThC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6114261
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:45:42 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCA9C9
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 04:45:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso6986957a12.3
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698666338; x=1699271138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AiylG7ZtMlRDqclVQltJ4x0/nBwWtxkIqAoroFN9v1E=;
        b=U+JTAThCPJMp9vHOGq5rKyIX0HI5pMCk316QWJE1JWbqJ5Wov6oVdNVa/u/qEuzjmq
         ODNK6bsOrZoBMrohRdTjbJ5JcmOByNGrFapi7pkld+HgckXLPbd/UiTI5ICcmEcjamoW
         B351wH9mdTldJu3vAY+apOBV7QV7Y/UAjJyrHO7VyYqE1DsDJNRa54NQkTw7wZZwARRT
         fhqIV8nn0NVAC9kdqKyREDojLcOkIEBPL7RMO3UBIMz4C2dyzKg5mLfstdOwlCUxxzbC
         QJ8ayDZ5WBTRZEI/CgYe0F5qyhNg/xO3y+uaSKnUITpNrsK1QVOrgzfDsfzAany0k5zR
         ksfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698666338; x=1699271138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiylG7ZtMlRDqclVQltJ4x0/nBwWtxkIqAoroFN9v1E=;
        b=QOiW2zPTyH3sAT2UCz5kFP8KJ5j0t5A/OcD55TajI7z1ijdpn/2w3ao8jaDs07m/7s
         /yhOrwogEP4x2KLKF+K/MBa4u3q7ilrAxKe8lwZlpHWPW9YNcWqg+NYE7KRQMLI6sehx
         p6xuozZNidp6ofRYvmLyFLOJymvd9tRmVuNXct8EnY11eo5W7ZHZUchShiNg/CKAfI8C
         YAFdE+vdK1wohcfcADVmUaDSR3OOE0WMUFvJg7WstMM5xFFAJPYtfRjqed2FC5oY2ToW
         My937gQB6UZgBnrAE3OjwkiYbgt9hhrmfb4178fXfkXJ2sSsMs7uJbiQEqBK1XgRPa8D
         YyXg==
X-Gm-Message-State: AOJu0YwVcv3mde4qi90l7KcRRkm+x9W8tFr10kv/O0NK1iCBdoO6mK3B
	Xl1pSnA40Cr8OUbgYBX71BBz5p9ii6WxQpNJ6WE=
X-Google-Smtp-Source: AGHT+IEGGU9xUizTxkLo6GkTDQLrsAc7vvie58exaccoIZ3H7OXTXBOMQE2/On03VfFr+XGRuUIjhA==
X-Received: by 2002:aa7:d84e:0:b0:53e:78ed:924d with SMTP id f14-20020aa7d84e000000b0053e78ed924dmr8152515eds.5.1698666338502;
        Mon, 30 Oct 2023 04:45:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f19-20020a50d553000000b00537963f692esm6136992edj.0.2023.10.30.04.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:45:38 -0700 (PDT)
Date: Mon, 30 Oct 2023 12:45:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, matttbe@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next] doc/netlink: Update schema to include
 cmd-cnt-name and cmd-max-name
Message-ID: <ZT+XYBiKTkdxUhOK@nanopsycho>
References: <0bedbe03a8faf1654475830b88e92ece9c763068.1698396238.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bedbe03a8faf1654475830b88e92ece9c763068.1698396238.git.dcaratti@redhat.com>

Fri, Oct 27, 2023 at 10:44:48AM CEST, dcaratti@redhat.com wrote:
>allow specifying cmd-cnt-name and cmd-max-name in netlink specs, in
>accordance with Documentation/userspace-api/netlink/c-code-gen.rst.
>
>Suggested-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

