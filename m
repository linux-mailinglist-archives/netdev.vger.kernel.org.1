Return-Path: <netdev+bounces-13821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF9173D188
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 16:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5F41C208FE
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258D35664;
	Sun, 25 Jun 2023 14:42:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142FA3D71
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 14:42:18 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF6197
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 07:42:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98746d7f35dso361379566b.2
        for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687704136; x=1690296136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PbaLf2lspvngdj0j2iAG03daGXryA/uCfUY0C6tfZp0=;
        b=B9rEdFogic+FNsm/URdDObZCiH3jMnEnrHExd7zQQkY8Ap9WfIt5GXjkMcA1d3tRv0
         w0+aXgEWWnUoW7YRmZrS82HgUpWKSUK/m4wIUU1VEdS0tK6oG2LTyZ4uUAQxZ6uexvXR
         PE9jjxN+4xiuYspMixwrsePjpEuBSiVYdVZYD1+lDD+HBnYtSvwd1sOXkhDXKmFyx5IB
         jBw9fduidIgkEZlct/XO6bRQ2xVWgc+e4rJQ/0qZtlhZVvHguKf157HVZEMycUSwEpSE
         XTLMxF0X8NoxdaorCb/92yFZzZMakGe5Oemo46++1wVf8LpmloqQtSQ/1qal9s/FUSUN
         3qgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687704136; x=1690296136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbaLf2lspvngdj0j2iAG03daGXryA/uCfUY0C6tfZp0=;
        b=bl6kKtXyFACHKbpSIf1EkLI/4I30VNHQiqrc664R1kdQF0gB88mCvr79OWKwaJricm
         HZYM//dtLvKozI1/BrxftTaJZSi6bX7saKJTadClK7JV1T/Z/awoS02+odSy9PCPAj25
         o743YY4p38lR/OfPlZnAdWEeUoDD8YXudQbmTvZBHiB1w9hUhGV1khLXFuGfMR+wdHkt
         Jy0vI8/FwaImKiY/Gb+DynRhPHPG1PwRbAhWDfbmxfyd1w+5DLUsIKcIDCISO2Nb53/4
         gSNgFwThNzwYNBhjPfL8MWYMuIfnDhUhV6eiF6EwfUw6y1cMffu4hzsuZdB/bg+stGcT
         df+Q==
X-Gm-Message-State: AC+VfDyBW+xtxH3fSjLcQoxXYi+Sd97vUU4iCixvNRGWCaWJXUYwLTPi
	emFwg8d2iRkf9B6BCfk/r80gH+CwuNI=
X-Google-Smtp-Source: ACHHUZ7kGmRhSuO0Y052KhJbrMiUgQabsZoNPWGNxop9GRYhZovGo/721CN+M5cubKzuYQZ169QK2Q==
X-Received: by 2002:a17:906:d0ca:b0:96f:cde5:5f5e with SMTP id bq10-20020a170906d0ca00b0096fcde55f5emr20929464ejb.29.1687704135576;
        Sun, 25 Jun 2023 07:42:15 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906085900b0098e42bef736sm788987ejd.176.2023.06.25.07.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 07:42:15 -0700 (PDT)
Date: Sun, 25 Jun 2023 17:42:13 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/7] net: dsa: vsc73xx: Make vsc73xx usable
Message-ID: <20230625144213.szmy2uulqhgeifa4@skbuf>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-8-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625115343.1603330-8-paweldembicki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Pawel,

On Sun, Jun 25, 2023 at 01:53:43PM +0200, Pawel Dembicki wrote:
> This patch series is focused on getting vsc73xx usable.
> 
> First patch was added in v2, it's switch from poll loop to
> read_poll_timeout.
> 
> Second patch is simple convert to phylink, because adjust_link won't work
> anymore.
> 
> Patches 3-6 are basic implementation of tag8021q funcionality with QinQ
> support without vlan filtering in bridge and simple vlan aware in vlan
> filtering mode.
> 
> STP frames isn't forwarded at this moment. BPDU frames are forwarded 
> only from to PI/SI interface. For more info see chapter 
> 2.7.1 (CPU Forwarding) in datasheet.
> 
> Last patch fix wrong MTU configuration.

It is considered good practice for the people whom you've selectively
copied to the individual patches to also be copied to the cover letter.

