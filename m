Return-Path: <netdev+bounces-28741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00075780741
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9346328232B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 08:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37B14285;
	Fri, 18 Aug 2023 08:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C413EAF1
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:37:24 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D743A94
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:37:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so6496965e9.2
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692347841; x=1692952641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+O4WPWfoXsCzBGstfczdeT9Y09dSmyx72ksm2QeEmas=;
        b=HpFcsdWNhimYDwYSG2jAOAbvXy6epAZS7dsJs7+HlGxf0yBlILkzZuch9iB7NtoQGb
         N4mpTy/W732BBhl7xH2f5wLdj6BE79Y89XyGNAOt8MnCKX0hDeVAMxsFbpZipMihPMUN
         /MMeXDPZtnxDmHzq/4TWx1ZvQy0bEaBpXOl8JoSvMfo2bjcjHTpK5MKqpffSohdtUoII
         j16P2dzDHBN0K1eZjlmM/R7b2xicoT3nJkH0tKeI58yuldczauPcw0nHFm7dX0xkIvpX
         kpoAPuM7zTC9IoYxWskTNi4fPcfFtPmGkTXW0LXzQah4F3rYC/BASGIh8WG8hTgajSYx
         PyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347841; x=1692952641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O4WPWfoXsCzBGstfczdeT9Y09dSmyx72ksm2QeEmas=;
        b=bvlfOYgIilKZwvaN+JwzPI5AZrMtQCmKIO+Do/4m1m2jg9GOHIJ1jcpyGYrDVuDCeM
         H86U44hYj5RLXqDDSgKJ6XuPc5by7TOueO2nOD/ec5d+it383RoiIMirjI8Ty3msIM1u
         Cx+/fYxeghjEult9Qwgi+9Eu9OI9XHTwdUpKySXRLVIRTGU3KptuNLVQD3wQQ8J9BTQD
         WzPTyu2cp0HJj5F99DHPKoaAws+o1WWpHRlaK9SJMcmGETa2ZPQj8mC1Yp2npdfWJA5d
         vzDkmfIkQ6tsP+/IBn4azQgt4br/SnksBbRx6MZvkFCI36Jh3d8tay7b6Ktf5dn8qAze
         PUCA==
X-Gm-Message-State: AOJu0YwMM5t+8MFtGdPC2HprtXvd1o7HEhb5dxGjwnVUYm7XttHQKKBO
	fPoUz5G6NAqd+/T3FCEHqeXqshC0BqxFJPlzKbyPHQ==
X-Google-Smtp-Source: AGHT+IG1SQQAIEs7U3yIgYGoM7W2iYcrwJ0SpNOEPdmJlvXwVfGcDleUQx6wefkRff19mKfth7J99Q==
X-Received: by 2002:a05:600c:21d5:b0:3fe:173e:4a54 with SMTP id x21-20020a05600c21d500b003fe173e4a54mr1563518wmj.17.1692347840817;
        Fri, 18 Aug 2023 01:37:20 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c210a00b003fed70fb09dsm286879wml.26.2023.08.18.01.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:37:20 -0700 (PDT)
Date: Fri, 18 Aug 2023 10:37:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: ynl - mutiple policies for one nested attr used in multiple cmds
Message-ID: <ZN8tv9bH1Bq8s7SS@nanopsycho>
References: <ZM01ezEkJw4D27Xl@nanopsycho>
 <20230804125816.11431885@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804125816.11431885@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 04, 2023 at 09:58:16PM CEST, kuba@kernel.org wrote:
>On Fri, 4 Aug 2023 19:29:31 +0200 Jiri Pirko wrote:
>> I need to have one nested attribute but according to what cmd it is used
>> with, there will be different nested policy.
>> 
>> If I'm looking at the codes correctly, that is not currenly supported,
>> correct?
>> 
>> If not, why idea how to format this in yaml file?
>
>I'm not sure if you'll like it but my first choice would be to skip
>the selector attribute. Put the attributes directly into the message.
>There is no functional purpose the wrapping serves, right?

I have another variation of a similar problem.
There might be a different policy for nested attribute for get and set.
Example nest: DEVLINK_ATTR_PORT_FUNCTION

Any suggestion how to resolve this?

Thanks!

