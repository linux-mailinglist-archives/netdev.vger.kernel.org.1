Return-Path: <netdev+bounces-39825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A346B7C499D
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6C0281C92
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E418D2F0;
	Wed, 11 Oct 2023 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="14LMyT0q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F42354F0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:06:08 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADC39B
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:06:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so5835404f8f.3
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697004362; x=1697609162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1eg1M4R5uFOM783RKzoKCL9tOzUime3qz3uWxmUMpXk=;
        b=14LMyT0q9EZlio2OXVZBAbZKsD/7J734pWb3BwSnpfzXsp2aaziiUXR1bX8poZgtuM
         a5UIb2oJbAgQvmEEFuX30eLQj3yYSKlNhFJgIQVbYMw+JpeGCaA5ydzXB18SnDeon/ju
         ZCk4q07pVUsaJETBzu7gZOXOEX3nO+LLRM9OsBxpfj8k7qJU2IgLKCLcf8x0m1ljeVGO
         CqjBK2U7UqVOMajv6mXKul39s8xK+Q2xxQrlm9pp07eVu81i90GhXEaJ2SMTj45geLMd
         NWyftiCICIsSUo+AH+qG6GmlkpAIypyzzaGUCSdofft2GlneRInzluULjVjmKEVfPON0
         X+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697004362; x=1697609162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eg1M4R5uFOM783RKzoKCL9tOzUime3qz3uWxmUMpXk=;
        b=hY1UpyhgtKABoQgY1AEdpTnl9qtuXXMh7TfP/iZ0bDzmyj7SYT1XdtVmHBHDENDatX
         p2+cnfgK1UBQzi1wGlr6u0qPm1ual+xJPcGM4tqMZjw8xOTLORjkjBCNgQUJbh8HCEbO
         Bv7mE1zQvzIV3ihH+WEkfnTIZGeVWs4ThYLZ9d7dCeCvwrPAluo8XvgmwDrYsweJiRqU
         nsqAL7k7RDL69LeCIRuMfnPab8ltGQ1D9PbV2Qq4Cjac5IQVmSxAWjsLEpI6/DURxOq1
         3HMTWhwt9eNK5FcBUX9/JzButGYX/UzmCdRweWKHyFURYnCBRvgcsEjCqgnHxpILuxDM
         HD4g==
X-Gm-Message-State: AOJu0YwKFA0ADCCdEMiFvyeL6Ky6i1NDlXWG0aAFh15O/6eQ6mzzabAT
	H4A8xsuF81CjHrLxmEP6DIcYtQ==
X-Google-Smtp-Source: AGHT+IF1L30Zex4zJZVUPZOTyrFes5sgAjeApt0opF9QRsIFDsjxtcipIrtc7JFegVyWv1VU0akCCw==
X-Received: by 2002:adf:f78d:0:b0:320:926:26d5 with SMTP id q13-20020adff78d000000b00320092626d5mr18167644wrp.30.1697004362353;
        Tue, 10 Oct 2023 23:06:02 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6190000000b003217cbab88bsm14294974wru.16.2023.10.10.23.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:06:01 -0700 (PDT)
Date: Wed, 11 Oct 2023 08:06:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Message-ID: <ZSY7SJW1J5fNPDQq@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-3-jiri@resnulli.us>
 <20231010120130.71918597@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010120130.71918597@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 09:01:30PM CEST, kuba@kernel.org wrote:
>On Tue, 10 Oct 2023 13:08:21 +0200 Jiri Pirko wrote:
>>  tools/net/ynl/lib/ynl.c                     |  6 ++++
>>  tools/net/ynl/lib/ynl.h                     |  1 +
>>  tools/net/ynl/ynl-gen-c.py                  | 31 +++++++++++++++++++++
>
>"forgotten" to add support to tools/net/ynl/lib/ynl.py ? :]

Will check.

