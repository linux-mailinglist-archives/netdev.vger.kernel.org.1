Return-Path: <netdev+bounces-36093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2C47AD2B6
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 10:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 20EEDB209E2
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 08:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C660A111A7;
	Mon, 25 Sep 2023 08:09:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14797FC0C
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 08:09:12 +0000 (UTC)
Received: from out-210.mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64833AF
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 01:09:10 -0700 (PDT)
Message-ID: <0b1ffbb6-12a6-22eb-f197-4a8f3bd2074c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695629348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpERSZPjS9SrT5Ng4mvbYMcfsd18YPCixhw2nkYJN5A=;
	b=Cr7G2KZPREjX8KAiWDkKy34BZegPhMZdrvvsF6gSLOarVhqcJw7Ho8I+fSTsGESaQA1djE
	PuPJDaxJMideDR1SnIRsNcdE6bjDQCRARuo0mp6KfkR+CEVmKSmJn99pN5JwxP2TCohh+3
	bOhln84/0Pjgpdt/r0upAGQ2E8+UwoM=
Date: Mon, 25 Sep 2023 09:09:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: adjust header file entry in DPLL SUBSYSTEM
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230925054305.16771-1-lukas.bulwahn@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230925054305.16771-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25/09/2023 06:43, Lukas Bulwahn wrote:
> Commit 9431063ad323 ("dpll: core: Add DPLL framework base functions") adds
> the section DPLL SUBSYSTEM in MAINTAINERS and includes a file entry to the
> non-existing file 'include/net/dpll.h'.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference. Looking at the file stat of the commit above, this entry
> clearly intended to refer to 'include/linux/dpll.h'.
> 
> Adjust this header file entry in DPLL SUBSYSTEM.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9aa84682ccb9..cfa82f0fe017 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6363,7 +6363,7 @@ L:	netdev@vger.kernel.org
>   S:	Supported
>   F:	Documentation/driver-api/dpll.rst
>   F:	drivers/dpll/*
> -F:	include/net/dpll.h
> +F:	include/linux/dpll.h
>   F:	include/uapi/linux/dpll.h
>   
>   DRBD DRIVER

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

