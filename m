Return-Path: <netdev+bounces-43836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 831C37D4F38
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364D9281867
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A967266AE;
	Tue, 24 Oct 2023 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IQrY0IyI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A1224EA
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:50:25 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042DF10C0
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:50:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40839807e82so25430825e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698148219; x=1698753019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2XdxedmWSwH4vw/QHp+RZVDywlMbPNif4GB1QAW8hE=;
        b=IQrY0IyImyLc6pGoBPpjx83YZgUEScTt/bUeURAsWkzl3C60838zMcarlim3WjXNq+
         2X9bJGqnor4L4FUnkO7O5h08nfoV/qnV1jjHqkPdFZ/9uCtBHTqKIkIYtQZ9lHeauWOo
         itHm34kWEQ/kL7/w2+lXWLGcaQyTljH1nMDRdjDbU9YcSgRfYQx/QP2O7HMbUJ3CAQ3M
         SoJO236n8wZCD7eXhUaC3jU+o291X5gjiJPiQOiKPQai9UaKONNlaDzMj0LeolKGLF05
         0qHdGTNgIbTNNf+dsTcX9+iEdoT2XVQ1DGeYRSVqIOTeSsHw+DZyxhj5iCTwp5G+CPOY
         Mi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698148219; x=1698753019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2XdxedmWSwH4vw/QHp+RZVDywlMbPNif4GB1QAW8hE=;
        b=Ge+Ui5TLGi4YOui9JQR7k5gF372DTD0Wg7+wDX2JaGHAyCNbiaEC0OzfWYsLUK11wC
         DYwH0tr88HEcPrjYV0v1JLwEZF9LlvwT2IsGZM1f/58mgfMWxct+w0aHyEIfzX/0oY4L
         VL0B2xyWtRuuiizK+uMRWKsNgvhg0mR7/o56qtMBssu4KzEIeMf+OqZXXkdD24D3Wngl
         41aM69qMef+oxWiPtcQCulbyb96gDwr3uXVMWmTXNGrOtzi3SaCUP5wepd+62vuxFyzQ
         PCf7vXKQOexyn/OxyI0zwhk8S9aTjj4D9/7BfAGUiIEZMH9W1aJRQpTov2VcCW/OPqKk
         BNHw==
X-Gm-Message-State: AOJu0YyjbR7wCYO06xsr6gtSAqTs7VjTufpL29iLuBEqYiP1s6th5tRP
	8LFxrDoIRmYFaZH5SmT2t5GTbg==
X-Google-Smtp-Source: AGHT+IFYLVTxRjI85SHP8iUKKoWYZ69YKRQqPUSXVKzjW23w/XZMU4VToX0MAPWkBNL+z3sQ5mm9AQ==
X-Received: by 2002:a05:600c:602a:b0:407:4126:f71c with SMTP id az42-20020a05600c602a00b004074126f71cmr14878834wmb.6.1698148219327;
        Tue, 24 Oct 2023 04:50:19 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c16-20020a05600c0ad000b003fee567235bsm16537251wmr.1.2023.10.24.04.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:50:18 -0700 (PDT)
Date: Tue, 24 Oct 2023 13:50:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	piotr.raczynski@intel.com, wojciech.drewek@intel.com,
	marcin.szycik@intel.com, jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com, jesse.brandeburg@intel.com
Subject: Re: [PATCH iwl-next v1 00/15] one by one port representors creation
Message-ID: <ZTeveEZ1W/zejDuM@nanopsycho>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>

Tue, Oct 24, 2023 at 01:09:14PM CEST, michal.swiatkowski@linux.intel.com wrote:
>Hi,
>
>Currently ice supports creating port representors only for VFs. For that
>use case they can be created and removed in one step.
>
>This patchset is refactoring current flow to support port representor
>creation also for subfunctions and SIOV. In this case port representors
>need to be createad and removed one by one. Also, they can be added and
>removed while other port representors are running.
>
>To achieve that we need to change the switchdev configuration flow.
>Three first patches are only cosmetic (renaming, removing not used code).
>Next few ones are preparation for new flow. The most important one
>is "add VF representor one by one". It fully implements new flow.
>
>New type of port representor (for subfunction) will be introduced in
>follow up patchset.

Examples please. Show new outputs of devlink commands.

Thanks!


>
>Michal Swiatkowski (15):
>  ice: rename switchdev to eswitch
>  ice: remove redundant max_vsi_num variable
>  ice: remove unused control VSI parameter
>  ice: track q_id in representor
>  ice: use repr instead of vf->repr
>  ice: track port representors in xarray
>  ice: remove VF pointer reference in eswitch code
>  ice: make representor code generic
>  ice: return pointer to representor
>  ice: allow changing SWITCHDEV_CTRL VSI queues
>  ice: set Tx topology every time new repr is added
>  ice: realloc VSI stats arrays
>  ice: add VF representors one by one
>  ice: adjust switchdev rebuild path
>  ice: reserve number of CP queues
>
> drivers/net/ethernet/intel/ice/ice.h          |  13 +-
> drivers/net/ethernet/intel/ice/ice_devlink.c  |  29 +
> drivers/net/ethernet/intel/ice/ice_devlink.h  |   1 +
> drivers/net/ethernet/intel/ice/ice_eswitch.c  | 562 ++++++++++--------
> drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
> .../net/ethernet/intel/ice/ice_eswitch_br.c   |  22 +-
> drivers/net/ethernet/intel/ice/ice_lib.c      |  81 ++-
> drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
> drivers/net/ethernet/intel/ice/ice_repr.c     | 195 +++---
> drivers/net/ethernet/intel/ice/ice_repr.h     |   9 +-
> drivers/net/ethernet/intel/ice/ice_sriov.c    |  20 +-
> drivers/net/ethernet/intel/ice/ice_tc_lib.c   |   4 +-
> drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   9 +-
> drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +-
> 14 files changed, 553 insertions(+), 422 deletions(-)
>
>-- 
>2.41.0
>
>

