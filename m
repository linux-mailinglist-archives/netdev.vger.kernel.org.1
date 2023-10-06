Return-Path: <netdev+bounces-38642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4293E7BBD56
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F541C209BE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4032942A;
	Fri,  6 Oct 2023 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fQzLwbjS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71128E23
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 16:55:43 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DABFC2
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 09:55:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b98a699f45so404037866b.3
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696611341; x=1697216141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ELyR6s0FsCfN5rMtpom3ZBEeSdSq0wiuuVBwt3jRG8=;
        b=fQzLwbjSYf3eu/jM2bL9AFg5lT4qNqNNLrhsPO0nhBJBzIM7Kwt41JM4Jzfhpfvwu5
         tclKV7Jhs0ohulPfJJ37CcqAFUPB4zMWQtjEzYlPr2U1eIMCdrNNSgqborSpwEM62yS5
         NYtiiLAjUHqsXYPetQM71knYnT1J7r1PoE2YkiQgdVddkVsXD0ur3go5HHhQIKb7hmi0
         bN7jz8bYav7M6WyFmtK62CKjhaGxuvQjjBSkugW2Bwihn3+MY7NMRh4s4L0xPtGa+nrD
         tyXklmZu9Y2h5rNz6FanlyOFtdUH34AWQgB3/y/YXJi8uE42PCI4QI40P5pAKGZ3FpzY
         +Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696611341; x=1697216141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ELyR6s0FsCfN5rMtpom3ZBEeSdSq0wiuuVBwt3jRG8=;
        b=VZiHTCFoguEn2zzJjA/d054c35Y3WSr1H6jchXtY8VUehA8H3L4dDZ+iYOAXnR6BL4
         N/leeuaLkKIAr8rSakkj8hrdjeDZAWvTt/ttNvhrvTmyyi9IlZuFlubBQiAywfTpOHs6
         eFiZ6UhXqsVqa/t9WHsMIWOvSfVXFiGl+FRwKniOAd2fzUWWhNgJKedKCbP3LCo+Jfdy
         Jel0C3lGimgBedBk0OT85ikTHTwGQMURXmN1kcEceulAXqpmpitoetgzmsONk+LzH591
         Novvjzwd6RstmUaFv4qxprZqed4ktTgIZtQEnDRzCvvZ58iCPwnQLX/OdqIIEgcaOMuN
         PBjg==
X-Gm-Message-State: AOJu0YwvmYqIFxcTV/3rwRnN+9HN/4kvhbVz0gE+bUprkbOr7XzcC7oQ
	nBiLGq9Ht1n4ajRTcUVryNdS2g==
X-Google-Smtp-Source: AGHT+IHbJk072pbAQTGSzT0ca4ib3vENZ5SuPaFhziRneWIn/1IA43vWox9DabMo0o2UPH6ozwtBUg==
X-Received: by 2002:a17:906:53d4:b0:9ae:5bd7:d2b4 with SMTP id p20-20020a17090653d400b009ae5bd7d2b4mr8478061ejo.68.1696611340713;
        Fri, 06 Oct 2023 09:55:40 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e10-20020a1709062c0a00b009b64987e1absm3097809ejh.139.2023.10.06.09.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:55:39 -0700 (PDT)
Date: Fri, 6 Oct 2023 18:55:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next v3 1/2] tools: ynl-gen: lift type requirement
 for attribute subsets
Message-ID: <ZSA8CVP6+DnPrHly@nanopsycho>
References: <20231006114436.1725425-1-jiri@resnulli.us>
 <20231006114436.1725425-2-jiri@resnulli.us>
 <20231006080039.1955914d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006080039.1955914d@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 06, 2023 at 05:00:39PM CEST, kuba@kernel.org wrote:
>On Fri,  6 Oct 2023 13:44:35 +0200 Jiri Pirko wrote:
>> +      # type property is only required if not in subset definition
>> +      if:
>> +        properties:
>> +          subset-of:
>> +            not:
>> +              type: string
>> +      then:
>> +        properties:
>> +          attributes:
>> +            items:
>> +              required: [ type ]
>
>Nice!

Took me like 3 hours debugging this. These json schemas are from
different world than I am...


>
>Reviewed-by: Jakub Kicinski <kuba@kernel.org>

