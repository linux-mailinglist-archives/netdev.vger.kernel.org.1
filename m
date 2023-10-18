Return-Path: <netdev+bounces-42144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C80A7CD5B7
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148611F22BAA
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 07:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD711722;
	Wed, 18 Oct 2023 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="m/Cp2/g3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F911C80
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:52:15 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AE7C6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:52:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso548035666b.0
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697615527; x=1698220327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsbQTM4tV7/Cp2zRZVYIKVbc+oimlEHp+yK3cs5idpg=;
        b=m/Cp2/g3z3ky+ukEmCPMJ0ADSXt/zG2swKYsNQW/IJImGHFwyurtEy4R3xljg9/h0a
         J/YaNmyzYiU5BgPxUiJeNbi1fhy+w2RhTDkg0teQwpdmcs8fn89AD+2QB1A6piV2BH9C
         K8xalrH6S8iCzWb01d6XOBiyDJV33oodfV2Eukk66tkaMm4epN2thZGZsST1o5e3Vd26
         5SF0a7j+Gqtn0hO2F3Fv04t/bjeXxQi8Od+Al7/HvyNzR80pAtPcwylGwe/mx/2s3/LX
         zVa1QzVBFtOULSfIu+Fm0bvdJnymLr9foDWtKtMc1yT+1JZLjs4oz8nuZ4TQe2gGooOs
         cssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697615527; x=1698220327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsbQTM4tV7/Cp2zRZVYIKVbc+oimlEHp+yK3cs5idpg=;
        b=isxkB8e7aI6CKobDdH/WasSClLcIxRoyCy3Glx9UEygckv9Rdv3431lAQyyfjg3atF
         F5b072lwIO50u2f31pI+txSvd2V1NdQGECEGYeMuyo7jk605RXdLawN9tRNR0bBvPRPX
         ttdfp8HjXnIZERfyb/aeyRoa2SqVBqGAte7d8AU1AZDeH0sShJL+JBPl17gJ84kNcsh/
         Rf2V69LxWXYNEjf/Vhj2D12q4sE71T9ra1xAhvIHoFPDUsK5sYVQ8111umij681rzyLz
         PMgYfGqnO7xHDx8M4RG14UK5SrmH5FYtnGoUtRxFOntGmJBSp0kbeN5zVfyv6Kg0d+o0
         DteQ==
X-Gm-Message-State: AOJu0YxWDVGSRvurdsPpPdLUSu4XjhlJI9F+lyE4m4VKTYK7wJ5HQmMj
	JONbUQOeYNTUkx6jFv/Txd5ry8vv5tpFWs9gHho=
X-Google-Smtp-Source: AGHT+IFZ7hi//kJ2q81sOFiY5uMqhuBHqAF42WmDgKHzIw4ZWi7f2b1jtV6BDTgCoNglxX5kvMu/nw==
X-Received: by 2002:a17:907:74a:b0:9bf:d70b:9873 with SMTP id xc10-20020a170907074a00b009bfd70b9873mr3140176ejb.39.1697615527191;
        Wed, 18 Oct 2023 00:52:07 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090651cc00b0099bd86f9248sm1139336ejk.63.2023.10.18.00.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 00:52:06 -0700 (PDT)
Date: Wed, 18 Oct 2023 09:52:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next v2] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <ZS+OpBfxCkX1hQAj@nanopsycho>
References: <20231016110222.465453-1-jiri@resnulli.us>
 <20231016175903.605f61aa@kernel.org>
 <ZS4nJeM+Svk+WUq+@nanopsycho>
 <20231017085053.63d4af40@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017085053.63d4af40@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 17, 2023 at 05:50:53PM CEST, kuba@kernel.org wrote:
>On Tue, 17 Oct 2023 08:18:13 +0200 Jiri Pirko wrote:
>> Tue, Oct 17, 2023 at 02:59:03AM CEST, kuba@kernel.org wrote:
>> >On Mon, 16 Oct 2023 13:02:22 +0200 Jiri Pirko wrote:  
>> >> +class FakeSpecAttr:
>> >> +    def __init__(self, name):
>> >> +        self.dict = {"name": name, "type": None}
>> >> +        self.is_multi = False
>> >> +
>> >> +    def __getitem__(self, key):
>> >> +        return self.dict[key]
>> >> +
>> >> +    def __contains__(self, key):
>> >> +        return key in self.dict  
>> >
>> >Why the new class? Why not attach the NlAttr object directly?  
>> 
>> It's not NlAttr, it's SpecAttr. And that has a constructor with things I
>> cannot provide for fake object, that's why I did this dummy object.
>
>Just to be able to do spec["type"] on it?

Nope. Need .is_multi() and spec["name"] as well.

>
>There is an if "ladder", just replace the first
>
>	if attr_spec["type"] == ...
>
>with
>	if attr_spec is None:
>		# your code
>	elif attr_spec["type"] == ...
>
>hm?

Well, I need the same processing for "else".

Okay, I'll to this with local variables instead. Fake class looked a bit
more elegant.


>
>> >I have an idea knocking about in my head to support "polymorphic"
>> >nests (nests where decoding depends on value of another attr,
>> >link rtnl link attrs or tc object attrs). The way I'm thinking 
>> >about doing it is to return NlAttr / struct nla_attr back to the user.
>> >And let the users call a sub-parser of choice by hand.  
>> 
>> Sounds parallel to this patch, isn't it?
>
>I'm just giving you extra info to explain my thinking.
>Given how we struggle to understand each other lately :S

Yeah :/


>
>> >So returning a raw NlAttr appeals to me more.  
>> 
>> Wait, you suggest not to print out attr.as_bin(), but something else?
>
>Yea, it should not be needed. NlAttr has a __repr__ which *I think*
>should basically do the same thing? Or you may need to call that
>__repr__ from __str__, I don't know what PrettyPrinter uses internally


Instead of:
{'129': {'0': b'\x00\x00\x00\x00\x00\x00\x00\x00',
         '1': b'\x00\x00\x00\x00\x00\x00\x00\x00',
         '2': b'(\x00\x00\x00\x00\x00\x00\x00'},
You'd get:
{'129': {'0': [type:0 len:12] b'\x00\x00\x00\x00\x00\x00\x00\x00',
         '1': [type:1 len:12] b'\x00\x00\x00\x00\x00\x00\x00\x00',
         '2': [type:2 len:12] b'(\x00\x00\x00\x00\x00\x00\x00'},
Looks like unnecessary redundant info, I would rather stick with
"as_bin()". __repr__() is printable representation of the whole object,
we just need value here, already have that in a structured object.



>
>> >> +                if not self.process_unknown:
>> >> +                    raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
>> >> +                if attr._type & Netlink.NLA_F_NESTED:
>> >> +                    subdict = self._decode(NlAttrs(attr.raw), None)
>> >> +                    decoded = subdict
>> >> +                else:
>> >> +                    decoded = attr.as_bin()  
>> >
>> >Again, I wouldn't descend at all.  
>> 
>> I don't care that much. I just thought it might be handy for the user to
>> understand the topology. Actually, I found it quite convenient already.
>> It's basically a direct dump. What is the reason not to do this exactly?
>
>No strong reason but you need to rewrite it to at least not access
>attr._type directly.

Okay.

>
>I have a weak preference for putting this code in NlAttr's __repr__,
>could be more broadly useful?

As I pointed out above, it's a different use case. Here we do decoding
into structured object. __repr__() is fro plain str conversion.

