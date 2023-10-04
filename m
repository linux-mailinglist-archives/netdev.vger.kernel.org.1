Return-Path: <netdev+bounces-37925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1E17B7D6F
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AB0C42814FF
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AAC101FB;
	Wed,  4 Oct 2023 10:41:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1135395
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 10:41:44 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C28A6
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 03:41:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53636f98538so3451871a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 03:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696416100; x=1697020900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzXarj/dIrLAH4tPhBh7BzTA1z+2WH5X+IxGm0B65kk=;
        b=T/zXgeT6z6FNVR/DpzhL5vkl53Fs6zDhInbzmklFqSVzlqvJtMfbpJRf2yuvOL41/h
         aV13GoWIPIB/flXQLSBF+2tY6WFfi37t5CBzs4x18OZzR3p19KcKNWaMlvP/6EMeQgwt
         batpT45rM0YprrV3jvhkBEy3yqsxaKQskMnMnxJtQcEjFxFXdYV761S/7HqioUW9GAC+
         5oB+Ip46bLQ0Sq8bLVhiwwhRNNtsX+9C28cV5/XsmIc2GRiCARf7mGkEIkLSbxVHTiag
         FRS+UTYedZGfR1/o4np00II2ah/9LWJqP7cToOxz9Y9mByJ2mFBXpA6i2GJ9l8hJ1Cvq
         +MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696416100; x=1697020900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzXarj/dIrLAH4tPhBh7BzTA1z+2WH5X+IxGm0B65kk=;
        b=VX7Gf+tlFx1xQdB/9u3m29Ez9YrGh4WqLKs1VvGN6ICjsOnGttH3TAJhP/8E3/eNpG
         CfUc/egMrxybuwiGuFCj7cLOXoOoAHOTubkizvF2kqpl0LHRRHQ5MLFlBCOtnJTZqMza
         QmSG8DRbniH2Ag7qU/o0PzXi+m47rwV14h7dESWv7dws426EKjnuyqyzyh/J40X0WTEC
         JAq7jX7jaGmnlXJjPjIRK8qLJzbWVO+ra0P9wHXD+WwzdQTSqdiRhq3LooDnTHF2U1vL
         Y865BSLJ2qrcFbJMKBCAJtpwmvqc0bEzIqqoqMpJlgU1gbBEeaiL8pgkS4VHtlGvJcOs
         1gKg==
X-Gm-Message-State: AOJu0Ywwq/WPpE/XQMwofRTyNTgJ261IujT0N3VDQ+4Zxnj7Q00iISAw
	/N0ALvOChl35PxukK0DKXhHQYA==
X-Google-Smtp-Source: AGHT+IHLpWQ5S4hZp+7IuOHxp4blL7eubhAEfZYoixgG+l4TPda7KJJaiRndD6JAp2v+zJQCW100Kg==
X-Received: by 2002:a05:6402:1257:b0:530:c363:449c with SMTP id l23-20020a056402125700b00530c363449cmr1453487edw.40.1696416100316;
        Wed, 04 Oct 2023 03:41:40 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g13-20020a50ee0d000000b0051e1660a34esm2227535eds.51.2023.10.04.03.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 03:41:39 -0700 (PDT)
Date: Wed, 4 Oct 2023 12:41:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v2 2/5] dpll: spec: add support for pin-dpll
 signal phase offset/adjust
Message-ID: <ZR1BYQuSfdMdDimH@nanopsycho>
References: <20231004090547.1597844-1-arkadiusz.kubalewski@intel.com>
 <20231004090547.1597844-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004090547.1597844-3-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 04, 2023 at 11:05:44AM CEST, arkadiusz.kubalewski@intel.com wrote:
>Add attributes for providing the user with:
>- measurement of signals phase offset between pin and dpll
>- ability to adjust the phase of pin signal
>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> Documentation/netlink/specs/dpll.yaml | 33 ++++++++++++++++++++++++++-
> drivers/dpll/dpll_nl.c                |  8 ++++---
> drivers/dpll/dpll_nl.h                |  2 +-
> include/uapi/linux/dpll.h             |  8 ++++++-
> 4 files changed, 45 insertions(+), 6 deletions(-)
>
>diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
>index 8b86b28b47a6..dc057494101f 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -1,7 +1,7 @@
> # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> 
> name: dpll
>-
>+version: 2

Could you reply to my comment about this in V1 please?

