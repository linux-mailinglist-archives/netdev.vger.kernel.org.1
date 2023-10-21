Return-Path: <netdev+bounces-43221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D422D7D1CC5
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810E32824D2
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F738DF45;
	Sat, 21 Oct 2023 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wA0wOA71"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6C0DDA7
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:23:27 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B29E19E
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:23:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so24710241fa.2
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697887403; x=1698492203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=auJxdlqCgjCa51dXoMwvYuZbIGGCcYwEiqzQrnnI3tg=;
        b=wA0wOA71XofW47gyE3EZrgkNKfdp6lUyXjp9gjQAnvRa+fHpRLYQlw/XHWtPINVZxO
         fqlA7NgsMjhJ4QzhyAYFIA2D9loMFPXDnaLtXF1u2Pn/59ZNbCWIkhVgqEHIuad17RnO
         pi5+W6oHqNJhLBbIk2+bjZYVUkN1Z9XmTk2exYsvHEXNOcLun4fBqJK8q+LKMkodfXzx
         Bn0JbnM501XUB/PyS1gIn1I9Uin+/VTZ/ZvbxzlSqWKhRjoHkuBDudSBf0+jkwpwSucX
         dfQFmuqjhVJpqgN7/R96g0n9cSdNUOaicKIeQrjFdd5PQZnAXSojnrA19Yn1kk2gaGn4
         ONCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697887403; x=1698492203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auJxdlqCgjCa51dXoMwvYuZbIGGCcYwEiqzQrnnI3tg=;
        b=fJSwc2k/E4+YV29eEOok8fYN+PvInOSPJ/XrTRVb8PyrNLPuMrQRl1NWrTlPmltN8q
         vJknApv6JJIKc6OJ0XXc0t5/UEEmufYcfSrf3o3DyeDEpvTFkbl6bfTG+lEjmjeP+bIA
         5eG8v57075eHvAeE8bHDkqPLHuV7rBQcWTnPTJWjxGtgIeSOAZtN7w0RQHV9tn5guita
         dLjiyuLZEUmmv8Xc0YL0wZSODtUrN1NpMYFBK8yay05N/F8Z3LGLhdNcBLjKPn1OJZKh
         AhuOFeEeMA6z9FWlLzN5IC+W6cnPk87XTwe4lucYUzQyQjlMPab7R/eLytalL3j2prCN
         LTsw==
X-Gm-Message-State: AOJu0YwEQThuv4ovy2UYtYghVkU9HvfBNoMH3kKdZSnKBNLGPIganC1P
	T8q/tSwrTk4du7TCrIevBuGYxg==
X-Google-Smtp-Source: AGHT+IGwO7ncLDRx5LQbKJ+3n+z05E1Fme4DWYSzI4K+ip7jz7ELeGmm6SWdpoRPFoi4MGcMMVuTCA==
X-Received: by 2002:a2e:b8cc:0:b0:2c5:1f57:1ef5 with SMTP id s12-20020a2eb8cc000000b002c51f571ef5mr3396213ljp.39.1697887402637;
        Sat, 21 Oct 2023 04:23:22 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c4e0e00b0040607da271asm9159864wmq.31.2023.10.21.04.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:23:21 -0700 (PDT)
Date: Sat, 21 Oct 2023 13:23:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, amritha.nambiar@intel.com,
	donald.hunter@gmail.com, chuck.lever@oracle.com, sdf@google.com
Subject: Re: [PATCH net-next] tools: ynl-gen: change spacing around
 __attribute__
Message-ID: <ZTO0qBkkSJGauYlU@nanopsycho>
References: <20231020221827.3436697-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020221827.3436697-1-kuba@kernel.org>

Sat, Oct 21, 2023 at 12:18:27AM CEST, kuba@kernel.org wrote:
>checkpatch gets confused and treats __attribute__ as a function call.
>It complains about white space before "(":
>
>WARNING:SPACING: space prohibited between function name and open parenthesis '('
>+	struct netdev_queue_get_rsp obj __attribute__ ((aligned (8)));
>
>No spaces wins in the kernel:
>
>  $ git grep 'attribute__((.*aligned(' | wc -l
>  480
>  $ git grep 'attribute__ ((.*aligned (' | wc -l
>  110
>  $ git grep 'attribute__ ((.*aligned(' | wc -l
>  94
>  $ git grep 'attribute__((.*aligned (' | wc -l
>  63
>
>So, whatever, change the codegen.
>
>Note that checkpatch also thinks we should use __aligned(),
>but this is user space code.
>
>Link: https://lore.kernel.org/all/202310190900.9Dzgkbev-lkp@intel.com/
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

