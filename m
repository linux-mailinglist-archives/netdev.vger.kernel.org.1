Return-Path: <netdev+bounces-19520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFCC75B133
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F79D281E74
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AE8182D7;
	Thu, 20 Jul 2023 14:27:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0E18AE4
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:27:50 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D03DE4C
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:27:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso7202475e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689863266; x=1690468066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5WWfwIVfYwNpWC/73ZexTnf1TNzuh2rkVyxUIJLBhs=;
        b=a3itkqlIEallbHXKevdB0icdt44rKzW4hra9ojx9EOHB8WPHh4Zdt8wCrVGevmFVRA
         3a27uTM7gw2vNlGfRCKahGI/6COpUiGZ+sLEf4YAoC3IjfD6XcaQU243Lc8ZA/R3/uda
         dw7H/F2TMkLlZnWLmPyP9VxoxkJ4QOzx7+eV6xuEPviHkOYdeI//8ya7UMCyHwFKIdgu
         x9HtT6fhDM6F0d7lwJbHV618Btgh75WHqxtvFC1FPqLHxDFbmf5jyRiX74vxMOrDuEol
         cKHp7KMXc72NOhmnEG8UY98eYNfKmI2dz5TlNmAMdR5f9RV5xx6EEmisOfGTbMe5cyAq
         5cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689863266; x=1690468066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5WWfwIVfYwNpWC/73ZexTnf1TNzuh2rkVyxUIJLBhs=;
        b=aMnNiejVtHuvu90cqQ+huWqxnLZFs/XJ8OD0qCeokTV53RiNX4IbPcKMKPzjLDjYAq
         Jx6eeC1SojrU2LOtvTi+m6OajWrMJHQxX9Y8PySlnGc4/Vtg2uvG4s0X1Of7B1Oy9w0d
         I8xv/On+EVGQFvTBx/tTsYjJb3Qp6Vp9SB0712W/Lba/NV8D9hHO0uHY4RQEihNqCFzQ
         or4QTBiOJJWd1gp3BIxSRk7LcgXotyBybxmJ5QvzSwA14+pHkZJdpX+krc5i4Ilebd5r
         LzdMHzKAbwOmiwyy9yNom0grslRjvN4vuTN+JvIjmqVkIywGgbNNaFvluk46/jglLF6Z
         aB6Q==
X-Gm-Message-State: ABy/qLZ9vLdmYShFyBQ8mmVMvMJKjoKdlK7NfCr0j+ADAcuoNrov8YrU
	OLvggQ5Y3gAOuzW1WSNtnAXfDw==
X-Google-Smtp-Source: APBJJlHCiSt45Namg0gRS54z+W/lxRyx1wwyHSMpe5cXdK5iBHGrwqkFMFJqHXOjwQcW4FQUD8YmlA==
X-Received: by 2002:a7b:cbda:0:b0:3fb:ad5d:9568 with SMTP id n26-20020a7bcbda000000b003fbad5d9568mr4478650wmi.38.1689863266567;
        Thu, 20 Jul 2023 07:27:46 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6046000000b003143b14848dsm1469166wrt.102.2023.07.20.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:27:46 -0700 (PDT)
Date: Thu, 20 Jul 2023 16:27:45 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, moshe@nvidia.com,
	saeedm@nvidia.com, idosch@nvidia.com
Subject: Re: [patch net-next v2 00/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
Message-ID: <ZLlEYdFXJIAd5q4c@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
 <87r0p27ki7.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0p27ki7.fsf@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jul 20, 2023 at 03:55:00PM CEST, petrm@nvidia.com wrote:
>I'll take this through our nightly and will report back tomorrow.

Sure. I ran mlxsw regression with this already, no issues.


