Return-Path: <netdev+bounces-42967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D22857D0D7C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB751C20F5E
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8BF14261;
	Fri, 20 Oct 2023 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ap8T4AUQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02AE17982
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:39:15 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EDCD5D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:39:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so868341a12.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697798352; x=1698403152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlt3dKdZAJnwjJTDglxbdWFabRE707sklJcoLLFAhQ4=;
        b=Ap8T4AUQyMZuKAE+Uf3n8ZMNTTAJ6LNTMAswR/c7cpJ1Q8Txk4DNdR492JW+28fw1W
         +bvfTz1uvQI9CBi4f61T97xbjmeoKqCY0Y0ua/+Lqau+I6ts9oNWYlGQi14/7D0zB0J8
         vEQDjIKtjDpFOHpmcqSxIRRJ2dtlLv9ITVJcEKLoW53oId9jWAfTx7/5QI7kxWpnwvdC
         OMB5SqNRLfyXg4V8ktfpNyaot+6+aGKfLa/Q55Jqb3FryqDzfGizF7Y6r0+IRuZPpeG7
         Pp02ahgnce1yhLws7t06Q8S0xvkWPNrwjSu3sDzbYMhvg/UJK9VS+BTzHSPt7gMGiCBN
         iLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697798352; x=1698403152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlt3dKdZAJnwjJTDglxbdWFabRE707sklJcoLLFAhQ4=;
        b=kObQf+fqXv9gf4doFNYREWKnyWftmS4fF4FwDRwGP1fdrZMiB+k9sqV0CL6VzMQmkq
         AVRx0lsxP21IM9CAA9Zkvi0+Mt9yGUUtA7p1G/sdFL873J8Uodapjgx0VM9INceQxhpe
         andZRZwqXFGzS81P+Sahpfyyo60pkgszU1f2BBNp1cVdGDCFyd/z1RcWglh6h7aaL1HG
         x0EFcG4NuiWbExz67srj76dCe9EIfgOt+oudA2AU1cEu82BkCmtJoSKypbY05jhgciHM
         psZkIcthuipPye3byKA+pqpCgBLjA/JiFIr3cnOAXCzZYxOo1C6xSuk28/kth2hyWBAY
         KelA==
X-Gm-Message-State: AOJu0YwVSERzEzgfYW0LawlPQeyd4SC8i6b/dgYfZekAIXwsFdZQtdBW
	Ci+TITNjpri1+Xh+7cOb0YY/59FR4vDeBk++qOM=
X-Google-Smtp-Source: AGHT+IHcEjj8FPIKIcnZ7gOZj19v/pBTRrbIQfw/oHSYIgq40O8QEjHVLtMrTuSsVgxipE99Xq8Y0w==
X-Received: by 2002:a17:906:7311:b0:9bd:9507:ed1c with SMTP id di17-20020a170906731100b009bd9507ed1cmr1110575ejc.18.1697798351840;
        Fri, 20 Oct 2023 03:39:11 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j14-20020a1709064b4e00b0099bd1a78ef5sm1223644ejv.74.2023.10.20.03.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:39:11 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:39:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au,
	j@w1.fi
Subject: Re: [PATCH net-next 5/6] net: remove dev_valid_name() check from
 __dev_alloc_name()
Message-ID: <ZTJYzc0O69b1zN90@nanopsycho>
References: <20231020011856.3244410-1-kuba@kernel.org>
 <20231020011856.3244410-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020011856.3244410-6-kuba@kernel.org>

Fri, Oct 20, 2023 at 03:18:55AM CEST, kuba@kernel.org wrote:
>__dev_alloc_name() is only called by dev_prep_valid_name(),
>which already checks that name is valid.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

