Return-Path: <netdev+bounces-41686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D274B7CBAD1
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14239B20FB6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 06:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328A11709;
	Tue, 17 Oct 2023 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xIiRNe4T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFB111BC
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:18:18 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2A9AB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:18:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so4720179f8f.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697523495; x=1698128295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw519DlGQVDHTmvnzcS4CEjGQr0PqfsvHwmxJCpOpCA=;
        b=xIiRNe4TCdZSeaR81bhfPDv0bf9xOFr6OTRYljiG8zO4NHorRpOzg6oWn0pWqh7IhS
         jP53bbkqHWe9FVwxy4QCn8EQt2/6qpySghhEbOqUKrUWFg8FweISNMYxf8Hk3hZAnbgz
         CGeQmpnFIhp7iUnmGFI+13e8tD7DRgtcGWBvpaFTXBWm9IanrqZEulE+FjhkbQ0NRq4I
         64Vqivb4gbYtyPcY/Q8VwvBmas9EBlQksHDHDNRIZV536OCV93RfGo7+BYZqIlUgwLgG
         ed9uSgNh3gMKamo7VqCJsy+OPtMam/wc7qpY4Mt8vUqsL7fhvJPy3md91Wg1sIINs99q
         mDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697523495; x=1698128295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw519DlGQVDHTmvnzcS4CEjGQr0PqfsvHwmxJCpOpCA=;
        b=B0XKJsUvucoe5idE+OkSJFEZvuRYpDkwbeWpXULJGFI6GEiZFIdWryoBFKRjCkFLw5
         Q7jl8L5IMWwF8eSFK6YrjMn1bw2gKjpFmaxl7LeqnLcgNMDVxFPUvvdx8zR8Y2UQbe34
         +jhyq77YSgnO5iZ8mqHaDMETQ49tOqpvugxf+A3deSIU/+DlAT37wQqwtYUf5ftVnyYO
         RuXA6AUiT4BcWl324WAM1siUMPmfSmMZPaLKYXqYo83k7N22rS9DbTob1UorhGUQdz/1
         6f7qPA9suFAJRXM/MIhXIOdlsDX+NSyqAc8W2LktGcQTncSOn6k2zmstaHzuMC+ve322
         82OA==
X-Gm-Message-State: AOJu0YzApsXGyLYBMYvCCbGESKRVyPbqbN1NKJwSJuSu174eTu2xax8x
	i1P2N3VhZQdQbHUcsLiVRu9rdg==
X-Google-Smtp-Source: AGHT+IHkpw0mxu93ViP3cO2thgxteklBMkTWy444lktlMRDguJVzLrQtZrI72NVergMBba4lipYXfA==
X-Received: by 2002:a5d:5109:0:b0:319:7c0f:d920 with SMTP id s9-20020a5d5109000000b003197c0fd920mr1161453wrt.57.1697523495082;
        Mon, 16 Oct 2023 23:18:15 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600000d200b0032cc35c2ef7sm894246wrx.29.2023.10.16.23.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 23:18:14 -0700 (PDT)
Date: Tue, 17 Oct 2023 08:18:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next v2] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <ZS4nJeM+Svk+WUq+@nanopsycho>
References: <20231016110222.465453-1-jiri@resnulli.us>
 <20231016175903.605f61aa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016175903.605f61aa@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 17, 2023 at 02:59:03AM CEST, kuba@kernel.org wrote:
>On Mon, 16 Oct 2023 13:02:22 +0200 Jiri Pirko wrote:
>> +class FakeSpecAttr:
>> +    def __init__(self, name):
>> +        self.dict = {"name": name, "type": None}
>> +        self.is_multi = False
>> +
>> +    def __getitem__(self, key):
>> +        return self.dict[key]
>> +
>> +    def __contains__(self, key):
>> +        return key in self.dict
>
>Why the new class? Why not attach the NlAttr object directly?

It's not NlAttr, it's SpecAttr. And that has a constructor with things I
cannot provide for fake object, that's why I did this dummy object.


>
>I have an idea knocking about in my head to support "polymorphic"
>nests (nests where decoding depends on value of another attr,
>link rtnl link attrs or tc object attrs). The way I'm thinking 
>about doing it is to return NlAttr / struct nla_attr back to the user.
>And let the users call a sub-parser of choice by hand.

Sounds parallel to this patch, isn't it?


>
>So returning a raw NlAttr appeals to me more.

Wait, you suggest not to print out attr.as_bin(), but something else?


>
>> +                if not self.process_unknown:
>> +                    raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
>> +                if attr._type & Netlink.NLA_F_NESTED:
>> +                    subdict = self._decode(NlAttrs(attr.raw), None)
>> +                    decoded = subdict
>> +                else:
>> +                    decoded = attr.as_bin()
>
>Again, I wouldn't descend at all.

I don't care that much. I just thought it might be handy for the user to
understand the topology. Actually, I found it quite convenient already.
It's basically a direct dump. What is the reason not to do this exactly?

