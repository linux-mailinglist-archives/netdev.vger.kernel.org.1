Return-Path: <netdev+bounces-39961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092567C5134
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AAB2822E8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33F11DDC8;
	Wed, 11 Oct 2023 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hVsCDzN0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB43199D2
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 11:11:19 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A448CD3
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 04:11:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32483535e51so6450711f8f.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 04:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697022675; x=1697627475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5GNKoDzJaHuzKJxlYhSGC/WySAPDC162s7razYkn5c=;
        b=hVsCDzN0YRLfpJ/2mKRa0JptbW02H7uwsNgSN4i7J4fO8v8Gmd6w/OYWFyv8WqwoGv
         fjuyaoSWI3dFodb0NOi3gELhxKON4D+y9yi3oo10xM07RXEqsfdDt7pn2i7n3o2ZBIVU
         Ot22K+hAZYKUvBkxDcY6sRHXJJkq2RmrX6AcZlawZYOTdeVmGtO5mXCiJE5wN6w7DNR1
         wbbAnqDveayy4LkKYvE7RvfxQaM+jTb6CPqYkSOir7xoW3lxyxClCRqqX3LdevL3WvU6
         0mLiogdLIeelDSJ+f2vtfl4djG+3BWyKPaaBla7cR8TGDAl2ZxFu/E6GADaX0+4SJWOq
         s2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697022675; x=1697627475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5GNKoDzJaHuzKJxlYhSGC/WySAPDC162s7razYkn5c=;
        b=c4pU2YVERY3h6rkp5z21Ke/u6WydDgtn0M4a4GPWnaWd5iPyMzBjlKQ5uIeeFr60BJ
         XObf39IzUVwtwUVaKqE2l19dh8ErnM7Ms1PV4+XxaEb9c9TaaNQAOtJNTITfsQMRuxa4
         X4n9U+62TdLS66PCgNMI/h/CEwuIz8vX4Nk5TwibK073XgdesFBf/kwv44dYr+H/Qd8i
         SfgRbQwWgIUNWLkhAuG3tspHud8oJfRfTEn3ROMT6KOwxGsxxdkx5ZOCYMHiLdfWOSTI
         02eD4P7f0qArLmNBTV88F3H3bXBrLSMFEthhIvnWBVTSVp+o2z0ZrBPajde/OJZIO0nU
         8J0Q==
X-Gm-Message-State: AOJu0Yxy5fstUbC26dyCiFMwi/Zk3OYqCUruGPDCvAnejVWr3ocjhxT0
	YJfHWcUKQgUU0wjt/FIaCGuJHw==
X-Google-Smtp-Source: AGHT+IFMWdRjvrgTbr57qIWQAFPotfX/2bryYCgBf8xJCd9HLat6ps/im4EniVGCVudDPL3jp6V+BQ==
X-Received: by 2002:adf:a152:0:b0:32d:8942:9ff5 with SMTP id r18-20020adfa152000000b0032d89429ff5mr720660wrr.14.1697022674877;
        Wed, 11 Oct 2023 04:11:14 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d698a000000b00327297abe31sm15135858wru.68.2023.10.11.04.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:11:14 -0700 (PDT)
Date: Wed, 11 Oct 2023 13:11:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v5 0/5] dpll: add phase-offset and phase-adjust
Message-ID: <ZSaC0Qg0UwHveMcz@nanopsycho>
References: <20231011101236.23160-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011101236.23160-1-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 11, 2023 at 12:12:31PM CEST, arkadiusz.kubalewski@intel.com wrote:
>Improve monitoring and control over dpll devices.
>Allow user to receive measurement of phase difference between signals
>on pin and dpll (phase-offset).
>Allow user to receive and control adjustable value of pin's signal
>phase (phase-adjust).
>
>v4->v5:
>- rebase series on top of net-next/main, fix conflict - remove redundant
>  attribute type definition in subset definition
>
>v3->v4:
>- do not increase do version of uAPI header as it is not needed (v3 did
>  not have this change)
>- fix spelling around commit messages, argument descriptions and docs
>- add missing extack errors on failure set callbacks for pin phase
>  adjust and frequency
>- remove ice check if value is already set, now redundant as checked in
>  the dpll subsystem
>
>v2->v3:
>- do not increase do version of uAPI header as it is not needed
>
>v1->v2:
>- improve handling for error case of requesting the phase adjust set
>- align handling for error case of frequency set request with the
>approach introduced for phase adjust

Again,
set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

