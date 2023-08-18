Return-Path: <netdev+bounces-28917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E372781299
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F6B282267
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AD71AA9A;
	Fri, 18 Aug 2023 18:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733463A0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:11:23 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B02D70
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:11:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31ad9155414so1039590f8f.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692382279; x=1692987079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yx7ydbFXOFOcbgp6wjE1tfbmEGixjYufuR1BaVyq6Qg=;
        b=4Znm6XI+3sxP48r2SnWfj0/LO4ED0zSYKa4kec4msVxHbUe7S5M98WvTMJ97ButMuk
         um2TlxNYEY4vD/gfF0xaoBMEyDoesC6z7JyZk9yk2OITXg2PznbmqgI51IFZmdYiXCHp
         0sh4WFrAZF+11c76mi/WVAfq8W2HxxB9f/2jItE/z5wq0RJr/f1yw/y58MHaQsJOzrr1
         JhZu/lQtVIWPEK/jxaJIOmWue00oomdnwdoTiMndBCQMzqCNJv9gfiYsubUTUkpieQ7a
         P1jwsAh1YYBCmPQdv+IA1quTmG/tP743kuygAp+eDWFxhrRHQBqUbwvDD3kLlW9Rr2bL
         9Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692382279; x=1692987079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx7ydbFXOFOcbgp6wjE1tfbmEGixjYufuR1BaVyq6Qg=;
        b=KMcYxlwL+fDVXqX4wCo6dZQWfarDRXWGoMTwwY+kyONTGZka7LvdQY4++0KcNIBtKm
         kzYwavYNeAmTOwwGZ4BRim1c8pFOAtxaI/hlWjEkbcDlOc5PWoO+L9TjDPMhYyrELVr3
         5RzJAP8gy9QI/cn+o2SjmLA/QlLHXMLeRvfHyxQjT3pk1cFuLPL3EG3oPLQ51ftrcSa9
         edXVa7PdvnfWewfJEKtW/6iophMeACzaMONq9NtviJ4eRX16WCLDymEUcUN3f6zVb6dE
         w7CKrHkHNOYprQcA1wmf8B4176Nh5vtt+vgqVPcQq83K8WxoXSHtxDDTKYcQrwSanMqR
         QyoA==
X-Gm-Message-State: AOJu0Yzo/0BnkBCF5py4GEnFZz/KfxlPHc1mgSJCqOtfysk0rbzlQlS7
	E5s/T+rVyiEFTecQjhKOQY9SHg==
X-Google-Smtp-Source: AGHT+IE6zcyFZqjwKp+V6KIu+pyviQnRV+i3HFVtFzLu+kToM1BrvabjT1hHHluXGMXwwl9tRyOW5g==
X-Received: by 2002:a5d:4f8e:0:b0:317:e04c:6791 with SMTP id d14-20020a5d4f8e000000b00317e04c6791mr2708827wru.62.1692382279306;
        Fri, 18 Aug 2023 11:11:19 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d594c000000b00317878d83c6sm3540276wri.72.2023.08.18.11.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:11:17 -0700 (PDT)
Date: Fri, 18 Aug 2023 20:11:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: ynl - mutiple policies for one nested attr used in multiple cmds
Message-ID: <ZN+0RCxWBL74Ff+C@nanopsycho>
References: <ZM01ezEkJw4D27Xl@nanopsycho>
 <20230804125816.11431885@kernel.org>
 <ZN8tv9bH1Bq8s7SS@nanopsycho>
 <20230818085535.3826f133@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818085535.3826f133@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 18, 2023 at 05:55:35PM CEST, kuba@kernel.org wrote:
>On Fri, 18 Aug 2023 10:37:19 +0200 Jiri Pirko wrote:
>> >I'm not sure if you'll like it but my first choice would be to skip
>> >the selector attribute. Put the attributes directly into the message.
>> >There is no functional purpose the wrapping serves, right?  
>> 
>> I have another variation of a similar problem.
>> There might be a different policy for nested attribute for get and set.
>> Example nest: DEVLINK_ATTR_PORT_FUNCTION
>> 
>> Any suggestion how to resolve this?
>
>You mean something like:
>
>GET:
> [NEST_X]
>   [ATTR_A]
>   [ATTR_B]
>
>GET:
> [NEST_X]
>   [ATTR_A]
>   [ATTR_C]
>
>Where ATTR_A, ATTR_B and ATTR_C are from the same set but depending 
>on the command the nest can either contain A,C or A,B?
>
>That can happen in legit ways :( I don't have a good solution for it.

More precisely, it is:
GET:
 [NEST_X]
   [ATTR_A]
   [ATTR_B]
   [ATTR_C]
   [ATTR_D]

SET:
 [NEST_X]
   [ATTR_A]
   [ATTR_C]

Okay, you don't have good solution, do you have at least the least bad
one? :)

