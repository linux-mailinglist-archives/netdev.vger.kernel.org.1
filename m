Return-Path: <netdev+bounces-25471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BD4774377
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21A428173A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D82171C0;
	Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFD14AB7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA7F8C82
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:19:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so7828844a12.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 10:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691515178; x=1692119978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3OPgb2HQ+t387eoSZTX+wcRSoe+lj7bGiTd7wo/Njss=;
        b=qSXZFEr5410mkrUwem71+lMPchtqJjGv712MLlMvZHrZtCfO7+TeW0pVvaG9hFrarn
         nSGQrmbPC8bhL0jr6vDv/gS9FADjwU6df5pC/QdV2G5rHc7BwWz2qeOdZyXGb5vuGe7j
         3OqZaGQ9lOzpsQq4KsVeu9V/QlNh6mnTibxG796Lkbr1zBoJ6rd9SIIRjpTlqlXi9TrW
         VSICBbBbtaAEFQtl4E1Lu8oTgtTJTsPIpQBjLX5FiXleihCcgqvWZvLaJr3um2s6otF6
         DEpa8uC+7kVBmOUeMl9RHEG/mGUnxgT1O3HFThWgSUvVJtsisNGmYj0cEClTfXLBUNSP
         AI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515178; x=1692119978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OPgb2HQ+t387eoSZTX+wcRSoe+lj7bGiTd7wo/Njss=;
        b=gxWlVxNkVlaLC5eFEvLaMdmWQcOrqTAS8W0uq2xmeke24FX6wqqvY2rFgEs4pxqsV5
         Ma7TscNPDhRc1Q8CcTaRLchMY2n+Ks8XwjAkm7YnUrEO1KssTDEvjB4VwZ+waFkAdzm8
         SniKFJZtoDHfxtx69F1KT4OOcfE9VRlbAJiDPu6LDF39qP6h2JPYwXbxUtui/+79Nquo
         1blunqsBck8tOkTZ0zB1ludhw4BCGaDSS05B1JizWWm8fhrG/3dWwNL0wgFm9m3uMzK8
         SQD//VeIVNyubXe86p+WvmS4IvE9WtoTNs8IAYwgrgNM+UjhtRm466cYmKrOSUV1PLTr
         27CQ==
X-Gm-Message-State: AOJu0YzYgDm2Dh1B+G9OYiGv3kZOgnEufNI6dzSv2Wa905Trv0AYaoGK
	IbWEhxT9P1L84i8pnaEGLbO2w1raFcgBflOZgVfoDQ3t
X-Google-Smtp-Source: AGHT+IG8a7QbQWQjSHodoX7FrG7QQFnQfrbkQw8lfsNHueaJPV6IMLPo763323hGGM5k8Eb6sSbyzg==
X-Received: by 2002:a05:600c:210a:b0:3fe:26bf:65ea with SMTP id u10-20020a05600c210a00b003fe26bf65eamr9203930wml.29.1691480328981;
        Tue, 08 Aug 2023 00:38:48 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q1-20020a05600c040100b003fe29dc0ff2sm12886853wmb.21.2023.08.08.00.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 00:38:48 -0700 (PDT)
Date: Tue, 8 Aug 2023 09:38:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: ynl - mutiple policies for one nested attr used in multiple cmds
Message-ID: <ZNHxBxSJboYfDA0V@nanopsycho>
References: <ZM01ezEkJw4D27Xl@nanopsycho>
 <20230804125816.11431885@kernel.org>
 <ZM3tOOHifjFQqorV@nanopsycho>
 <20230807100313.2f7b043a@kernel.org>
 <ZNEl/hit/c65UmYk@nanopsycho>
 <20230807102406.19a131d3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807102406.19a131d3@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Aug 07, 2023 at 07:24:06PM CEST, kuba@kernel.org wrote:
>On Mon, 7 Aug 2023 19:12:30 +0200 Jiri Pirko wrote:
>> >How does the situation look with the known user apps? Is anyone
>> >that we know of putting attributes into dump requests?  
>> 
>> I'm not aware of that.
>
>I vote to risk it and skip the nest, then :)

Okay, will implement strict parsing for dumps, treating attributes as
selectors. Cool.

