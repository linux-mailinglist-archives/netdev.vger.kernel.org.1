Return-Path: <netdev+bounces-39453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F747BF4A5
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E34E28172D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33CFBF6;
	Tue, 10 Oct 2023 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Fv1gD1zv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BE1D2F6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:44:05 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBAE9F
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:44:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so9161285a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696923843; x=1697528643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVEQlE8CCIVwnGqK4YUqVY53iGiWzOI0vN++OTPijXI=;
        b=Fv1gD1zvbwzj8xqoaspwQSGZfY/xNOAagvhZNyXStLh9LcYD30fCPwI1fgX2HnDV8G
         YZzkG/fzijPtnQ2eIajXgEsnrxZAowvLnHDDQ3CITSZsLVd8UiUHSWRrMIVDLkufYplz
         yFQUbrXLioql/QcPkARRgzPURLVTDRy2kDhieLH8hU1Xc0GsbXzqly/INX36zHCgBP+4
         UAGmGleelIZyiacwYv3v3NIuik5wCd/BEDF9C9+HUbzi/EaMnSktdjcAarneVzzlBa2b
         vbqQwlzT/CuMI6655GL8Te0lPGDuwD75ujlXZcp4DYHOIRP91YPb7dhs18fdQWWasVN9
         Gn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696923843; x=1697528643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVEQlE8CCIVwnGqK4YUqVY53iGiWzOI0vN++OTPijXI=;
        b=SQ3WoEQLotf3jwySJiqEyZ8rdFxq+/v7xdi3dqrC8TPSgeq3EY2My4y/nwRsRK6CsX
         MHztjcW+3fOoRpUcWWfy6gNfXpumVF75cr/5qLjKyMj5Vu/HoNfajTGoaibBuOVh9Ut2
         qD0DJdDzU8kmiHdBC2wNMv1NJM/dWO5ONw//hR4poxg/9E4tNf14QTBIVgAqLvlYH+4P
         CkEEObOKUCKQ2ooflyxiE92vj9vms7wkKo4Ieb5TCYD8G4WUMDfkUTfh3HpQRBncCq+V
         nld6yjTyFI+DoBXvS1br+6rTj1jFXd/fVVE66KmcbVGwIi5u4oR0SrJJopfMO1KD23wl
         UIXA==
X-Gm-Message-State: AOJu0Yw7QjrIumzomkRd9XcqLh0nwzCrsigcJ1rCt7KR49CXQmb2en2s
	QpRjflqby0CmPh8yyYBHp72kZA==
X-Google-Smtp-Source: AGHT+IFL1RLTSKOpPDsX7c9Y6kK6SnX0Eigk+JI0p0u06K7LwkxKxcdtMGpejJCVdqaTlJBwab2cTA==
X-Received: by 2002:a05:6402:1257:b0:530:c363:449c with SMTP id l23-20020a056402125700b00530c363449cmr13150716edw.40.1696923842725;
        Tue, 10 Oct 2023 00:44:02 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o14-20020aa7c50e000000b0052595b17fd4sm7153292edq.26.2023.10.10.00.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:44:02 -0700 (PDT)
Date: Tue, 10 Oct 2023 09:44:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 0/5] dpll: add phase-offset and phase-adjust
Message-ID: <ZSUAwPOy8HAsB4+8@nanopsycho>
References: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 12:26:11AM CEST, arkadiusz.kubalewski@intel.com wrote:
>Improve monitoring and control over dpll devices.
>Allow user to receive measurement of phase difference between signals
>on pin and dpll (phase-offset).
>Allow user to receive and control adjustable value of pin's signal
>phase (phase-adjust).
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
>
>
>Arkadiusz Kubalewski (5):
>  dpll: docs: add support for pin signal phase offset/adjust
>  dpll: spec: add support for pin-dpll signal phase offset/adjust
>  dpll: netlink/core: add support for pin-dpll signal phase
>    offset/adjust
>  ice: dpll: implement phase related callbacks
>  dpll: netlink/core: change pin frequency set behavior


I'm fine with the set at is now. Thanks!
set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

