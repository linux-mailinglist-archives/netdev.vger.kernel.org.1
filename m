Return-Path: <netdev+bounces-41682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE887CBA94
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36972813EE
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 06:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06C6C8EC;
	Tue, 17 Oct 2023 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lDMa1So1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9181FA2
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:10:50 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58D8B0
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:10:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so9102862a12.2
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697523046; x=1698127846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1s53oEMh5V2p+5Wch+/BP0DtHv7CDJ24f+zn1j5seak=;
        b=lDMa1So1th1WDgMunnM6XAa354KVuoF/x0ohJnriH8EiK4KEolgUhzmB/LpzJ3aTsT
         APVn+VpMgrm0URayn+8JW2tk4vCl90v+1unHL9TAOqcSPDquOfIxHbI8O1qKJJ6uzG/f
         Z3LjrURnY83GLCfZ9yMbaDMqgq1zm84jSLwH2RCdIwU2i+bmhPtpHziZDPGj4qGiuOro
         z98nlrWBvIVr0dzk4RD//SUw4GieGQPwsLcHhy6SIrO4JJ9VsB0o5xpJKiX+1rlaFKnd
         I0fPP0sTy05YLXwpA4bXz5/RYc6EtoE/2TRnpPBrRgkFdgycUvun5ILp6kaVyXFdTF0w
         dA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697523046; x=1698127846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s53oEMh5V2p+5Wch+/BP0DtHv7CDJ24f+zn1j5seak=;
        b=wopwxLOyWQJoaw+Y/xLArqLnFSPfqRwZwCwyWq4fLYUud7M6WyU70CrjaBxCV9GhBu
         /bVGfe5K8KHydSj5U7S1MbWZkVRkpkA9wIdoIIc7VQLjL7gZnH5fUep2lDoViqtVm4gN
         GOJVPgyVbrNgZXuQ3PXxaZbUfPLV43PR6/DmHpl5X3+u+sIXzOwD8sTfI/DkteGMotGx
         E7XlQtukzrSBT57JfBlhiTUDn2bf9YDo0FfTj2UgFcgqRmaCkkHaAisb3wilTcHMdFW7
         YhlVoODd6Eb+rimoaPey4NMEbIE00d0m7dS5dv8IzN++JJVhova6EZcChQciVk8ApZxA
         ONSQ==
X-Gm-Message-State: AOJu0Yyj3CeSQ0cQFMuxyN4HcGaL2AdU4TvJ0OA87v1TPhn1XhC12Rq7
	T6mYjgxAayAQ3qumGjz2SQtZCw==
X-Google-Smtp-Source: AGHT+IFIEb1I1DfKdQW12i9ZqQUMZZmfxglGYTdvc1nDAadlbxmuxBmr/0rWQnVCV928jNiMOLhJVA==
X-Received: by 2002:a05:6402:2687:b0:53e:1388:e04e with SMTP id w7-20020a056402268700b0053e1388e04emr1011037edd.37.1697523046079;
        Mon, 16 Oct 2023 23:10:46 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s26-20020a056402037a00b00532eba07773sm559273edw.25.2023.10.16.23.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 23:10:45 -0700 (PDT)
Date: Tue, 17 Oct 2023 08:10:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2] docs: netlink: clean up after deprecating
 version
Message-ID: <ZS4lZGuZPnO/9NC+@nanopsycho>
References: <20231016214540.1822392-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016214540.1822392-1-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Oct 16, 2023 at 11:45:40PM CEST, kuba@kernel.org wrote:
>Jiri moved version to legacy specs in commit 0f07415ebb78 ("netlink:
>specs: don't allow version to be specified for genetlink").
>Update the documentation.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>v2:
> - s/Gobals/Globals/
> - breaking changes are -> compatibility breaking changes are
>   I think it's plural but the omission of "compatibility" made it confusing
> - not changing the wording to "should never be used", I prefer existing
>v1: https://lore.kernel.org/all/20231012154315.587383-1-kuba@kernel.org/
>---
> .../userspace-api/netlink/genetlink-legacy.rst     | 14 ++++++++++++++
> Documentation/userspace-api/netlink/specs.rst      |  5 -----
> 2 files changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

