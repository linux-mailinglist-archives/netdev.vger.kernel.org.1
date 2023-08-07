Return-Path: <netdev+bounces-24813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B21A771C19
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729371C209F7
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D2AC8C0;
	Mon,  7 Aug 2023 08:13:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC7C2FA
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:13:20 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC4D1708
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 01:13:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3178dd771ceso3687329f8f.2
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 01:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691395997; x=1692000797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LLKodO4Y3hcUtlogMUbubeG9uU0/WvWNo//bCg4tNY0=;
        b=tzJVjpGeQZRB+HyRUl/cxeBbmjjpAOY6w8Cwclu6Fxy6+mCDgYJvAdKt2BwUENwXy3
         VxlMxFRi8Fv6Gzia94jeZsxwZtBoMJxLUWI2xrrgEGpXCh+l/5wmWiOir4WO+JPVjj7Q
         6r8foa4HRp6deN+LK62yvKBuq6zKywhh2F0F5m5PsHX48OMs2yD56iSftOrzJQCTlPSi
         9hvRdtTMOY6f4wvBrIR7uV+aaYpuVk9YMN0HYrcaE2+vu4NThj698t4i6/Sj2fp1YL5s
         1QUOYgH0VGAeqjI/P01Vb6MdwCN2KvkPu8gwN5le43YKVHTVtDwrtybT7bCMMOM1sFI7
         oF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691395997; x=1692000797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLKodO4Y3hcUtlogMUbubeG9uU0/WvWNo//bCg4tNY0=;
        b=VNirfJQ+dhhGC4MD/V7i4bK+Y67cxMhk0Qd+wwWWuQfB84VRh2ajzOhKtC8RP2v1kS
         0IdR9zRCaRHWrkprt35ENtHeU9d0J88XVJ7FQNI5jkKkCkwY9+dmnh9zBQmEzmUPBocI
         wlvU6/2vHj3+PkjMcrz5wC8XAfCpRDWF5wit6J5/r+26dPHYceh7PizQb5c9PeLKoXVU
         7TAgwnVTn+xXBriBAFif+7gP/qsZBmGsmstoIw8YbQrmoVduGrsL8pvxKQ6L94D6N/HK
         YGPYTU5SmlmtBKIjLZUYwRp1Wxoh6DuaeLp0JMw2wc/poqac21WRbvr8i8YD5/yzBW06
         EGIA==
X-Gm-Message-State: AOJu0YzqRw75g3TEFYwhrU+fcnQRghP4HDugtPyco1m14JhtgKeAkTk6
	qp8VdtAYG6loyZeyga8e0GM7Jg==
X-Google-Smtp-Source: AGHT+IEh/NmRuU56UfaanfHAex34soIf/oqYQk+L702Ab/SKUXoKFvsY3POfIQesJkVPB9pf6BWhiw==
X-Received: by 2002:a5d:4f02:0:b0:317:3d78:c313 with SMTP id c2-20020a5d4f02000000b003173d78c313mr5749499wru.60.1691395997351;
        Mon, 07 Aug 2023 01:13:17 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id s9-20020adfecc9000000b0031416362e23sm9782645wro.3.2023.08.07.01.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 01:13:16 -0700 (PDT)
Date: Mon, 7 Aug 2023 10:13:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v2 3/9] dpll: core: Add DPLL framework base
 functions
Message-ID: <ZNCnm9tPN1npIGUM@nanopsycho>
References: <20230804190454.394062-1-vadim.fedorenko@linux.dev>
 <20230804190454.394062-4-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804190454.394062-4-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 04, 2023 at 09:04:48PM CEST, vadim.fedorenko@linux.dev wrote:
>DPLL framework is used to represent and configure DPLL devices
>in systems. Each device that has DPLL and can configure inputs
>and outputs can use this framework.
>
>Implement core framework functions for further interactions
>with device drivers implementing dpll subsystem, as well as for
>interactions of DPLL netlink framework part with the subsystem
>itself.
>
>Co-developed-by: Milena Olech <milena.olech@intel.com>
>Signed-off-by: Milena Olech <milena.olech@intel.com>
>Co-developed-by: Michal Michalik <michal.michalik@intel.com>
>Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>Co-developed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Thanks!

Signed-off-by: Jiri Pirko <jiri@nvidia.com>

