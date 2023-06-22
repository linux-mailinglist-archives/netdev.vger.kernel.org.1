Return-Path: <netdev+bounces-13088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E5F73A1F6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861401C21130
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D29F1ED52;
	Thu, 22 Jun 2023 13:37:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC71D2D1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:37:56 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E5C1997
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:37:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-987341238aeso860083166b.3
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687441073; x=1690033073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fRg50miuqVjqdD4FkG2Hv1AXDgRWbP1CoJvjVBr+cDM=;
        b=2FUUfDJpabB+LcdeeugWcASPhmrC4HKr4zPHmmUG9Vf2c39jQsvCddzRTWGZ/G6IQo
         FHOk38NW9G4lFfODgeV8JhKlbWzxlCDha5XOTFK9GUe3v5kzGKQOj9BnHVpDJsnk34nm
         C4ZNV3Ubq0qAudjnzw5KOshBuZPg+b3BY7aTLHvDLIjxpbFRLjZk2kg6cxjQ2V/QSPzT
         /kSxGuFkiaGd19k+gLQ219a6NNZ78WP3BMpbwUH5g7iXZtAAl3CkVKGKmfvtn32bSUIX
         U4EUWGWdtmcDaMpFeq7nQHJZ+SBAdxCMPekbiQxhslh8MjIqMrpq1LQXONjPPYHqKhJT
         AGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441073; x=1690033073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRg50miuqVjqdD4FkG2Hv1AXDgRWbP1CoJvjVBr+cDM=;
        b=kybukjzSwBr4AEFse6h2Eipb3xG9xJxfMPySLUFhlbsCI1S7ECs4NK6dgNGMYX+U+O
         6uTm1Id/bdIeAhsDF4DbkcTqRuwf/QhIixzyuwG1wpRiA5T1hJqTz8ChZIcDHKzBlLxm
         rx7FhGMnc2izJPvb3E3VeNJeBFqzIYKmbNc5seNCvhWYojZ9tdqA/gxD/Sx0N/e/pgC5
         8eFwlwNpx5yUymakyB0GkXqKJd8GvIeSHHHbmUIgiLP3uJg69G/gahEQM/xGDSJzrRQ2
         RG8YaHNMeiKglLV8qFWF37R7GorHnIeZy1haPEZiXnYIVRyLihcL6AtykAnbZOoQKD3/
         OIJQ==
X-Gm-Message-State: AC+VfDydB5RN7cxVgHDis2FzjCAVWzU3DE1WxGbgIJrzsdWYcmeRy7KO
	xga3Djy2hVyTZpZyyDKjuo9pIQ==
X-Google-Smtp-Source: ACHHUZ5KDB5bJM/SVgDEl6LcPqOSWN5RVVQyzWixdBKUCHQHXYkFtqN5jCFzh3LjkP9Aby8SWO1mAw==
X-Received: by 2002:a17:907:86ac:b0:98c:ed39:3617 with SMTP id qa44-20020a17090786ac00b0098ced393617mr2822177ejc.46.1687441072790;
        Thu, 22 Jun 2023 06:37:52 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id cb14-20020a170906a44e00b0098d295d5908sm946156ejb.46.2023.06.22.06.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:37:52 -0700 (PDT)
Date: Thu, 22 Jun 2023 15:37:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Piotr Gardocki <piotrx.gardocki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com, michal.swiatkowski@linux.intel.com,
	pmenzel@molgen.mpg.de, kuba@kernel.org,
	maciej.fijalkowski@intel.com, anthony.l.nguyen@intel.com,
	simon.horman@corigine.com, aleksander.lobakin@intel.com,
	gal@nvidia.com
Subject: Re: [PATCH net-next] net: fix net device address assign type
Message-ID: <ZJROrq1c4eO7cLUB@nanopsycho>
References: <20230621132106.991342-1-piotrx.gardocki@intel.com>
 <ZJQE4ieud5Mf8iGi@nanopsycho>
 <a5ab1ef6-1bc1-3e98-7f8b-5c5a3678ca8b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5ab1ef6-1bc1-3e98-7f8b-5c5a3678ca8b@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jun 22, 2023 at 02:42:53PM CEST, piotrx.gardocki@intel.com wrote:
>On 22.06.2023 10:22, Jiri Pirko wrote:
>> Wed, Jun 21, 2023 at 03:21:06PM CEST, piotrx.gardocki@intel.com wrote:
>>> Commit ad72c4a06acc introduced optimization to return from function
>> 
>> Out of curiosity, what impact does this optimization have? Is it worth
>> it to have such optimization at all? Wouldn't simple revert of the fixes
>> commit do the trick? If not, see below.
>
>Thanks for review. My main goal originally was to skip call to ndo_set_mac_address.
>The benefit of this depends on how given driver handles such request. Some drivers
>notify their hardware about the "change", iavf for example sends a request to PF
>driver (and awaits for response). i40e and ice already had this check (I removed
>them in previous patch set) and we wanted to also introduce it in iavf. But it
>was suggested to move this check to core to have benefit for all drivers.

Okay. Makes sense.

