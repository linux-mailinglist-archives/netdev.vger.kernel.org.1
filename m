Return-Path: <netdev+bounces-44677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE457D91AF
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB88B28229E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D7F156DC;
	Fri, 27 Oct 2023 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="n9+Zp336"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E2156E2
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:36:57 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5F71A5
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:36:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9cf83c044b7so174532066b.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698395813; x=1699000613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGT7UKNovc/TaNcYe1itRFB9y+L2wQb8zAuvGKOpt10=;
        b=n9+Zp336HhU0ORE8VfIcNHVM0+wqhaKDLZ4KyuY010731ZJHOgcjzKi9Mw9JyKl2PI
         qrJq5wmfd7eOq1mMu2w3z6YWA8LPCzctTa//Mu3768b6s8LbHO0vANLXr/rAXcNttor6
         qq8bufycNjoIOLvtLYcyU62oblnvNh4SBMv0RBOH8HhoK4Yh6BcwjkP1eWVIFl6QjK8P
         C2r6oO7QDsOH8BpefD8NKG0CyNAoduZF/vwnXpIa/7bwpVWDWviIlGpBVeY8p5jnNRLa
         9lmrbtrNlLJEmsWG2GaIrAm3cn+R07jFXYzbhKjkza2sWe0w9EL8UMvXz/VLCMzlR62u
         ymnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698395813; x=1699000613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGT7UKNovc/TaNcYe1itRFB9y+L2wQb8zAuvGKOpt10=;
        b=Lh6MFI4qGzjx9mnClPaWY42LFANMxIY62y/W6Omr6e9sKqzgp0A56HB397KKb5ykzf
         KPfBpjbWyAYlk686fhAtJVufPCkWUwwNjD7PZ+gIRKmiAF5GzcIP/EMw+XFeT+0R7FC8
         CZK11C2pDhuKkiZeVeYutQR0R1FavfqSngMY4mQzLQzYOBWZjpZLbU/QM2pMWD+67xxH
         pvbclNoZWrPrDGjTU8cgkrZQ+zjTaCfSayyfTXFV+kzamqTq3oG/F5STz+N1tFqt1Tm/
         vXca7QdyJcDUbrcNYI/ClK6x3jr8cR+McSgoq1C41VuLb8MFj+Sr7hPEuYMA4aIHgOlA
         HT4w==
X-Gm-Message-State: AOJu0YyljrXEJxYrAtLql8n0D0FAQlkP7BTXjW1ZwsJE+Hb9VJifVf8M
	O6vjOzvWUbmvz1c9K/z2KCJ0AeP0naZ3gBCIePs=
X-Google-Smtp-Source: AGHT+IH90BOyjt/lxP33RLfz1OwGRWTkYANKybbx+iZ9gMn1pKjQNh+YYjykB/RpjqQNYlsgIM2MWQ==
X-Received: by 2002:a17:907:1c92:b0:9bd:c336:21e5 with SMTP id nb18-20020a1709071c9200b009bdc33621e5mr1602196ejc.56.1698395812977;
        Fri, 27 Oct 2023 01:36:52 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id w15-20020a50d78f000000b00530a9488623sm911900edi.46.2023.10.27.01.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:36:52 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:36:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next v3] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <ZTt2o294RMW+MwKs@nanopsycho>
References: <20231025095736.801231-1-jiri@resnulli.us>
 <20231025175636.2a7858a6@kernel.org>
 <ZTn7v05E2iirB0g2@nanopsycho>
 <20231026074120.6c1b9fb5@kernel.org>
 <ZTqS6hePUFrxuBLM@nanopsycho>
 <20231026123058.140072c7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026123058.140072c7@kernel.org>

Thu, Oct 26, 2023 at 09:30:58PM CEST, kuba@kernel.org wrote:
>On Thu, 26 Oct 2023 18:25:14 +0200 Jiri Pirko wrote:
>> Thu, Oct 26, 2023 at 04:41:20PM CEST, kuba@kernel.org wrote:
>> >On Thu, 26 Oct 2023 07:42:33 +0200 Jiri Pirko wrote:  
>> >> {'129': {'0': [type:0 len:12] b'\x00\x00\x00\x00\x00\x00\x00\x00',
>> >>          '1': [type:1 len:12] b'\x00\x00\x00\x00\x00\x00\x00\x00',
>> >>          '2': [type:2 len:12] b'(\x00\x00\x00\x00\x00\x00\x00'},
>> >> Looks like unnecessary redundant info, I would rather stick with
>> >> "as_bin()". __repr__() is printable representation of the whole object,
>> >> we just need value here, already have that in a structured object.
>> >> 
>> >> 
>> >> What is "type" and "len" good for here?  
>> >
>> >I already gave you a longer explanation, if you don't like the
>> >duplication, how about you stop keying them on a (stringified?!) id.  
>> 
>> I don't care that much, it just looks weird :)
>
>As I said my key requirement is that the NlAttr object must still 
>be there in the result.

Yeah, that I don't how to do honestly. See below.


>
>Maybe a good compromise is to stick it into the key, instead of the
>value. Replacing the stringified type id. Then you can keep the
>value as binary.

Okay, that sounds good. But "key": \bvalue is not something to be
printed out by __repr__() as it outs string. Therefore I don't
understand how this compiles with your key requirement above.
I have to be missing something, pardon my ignorance.



>We'd need to wrap it into another class but whatever,
>compromises.

Will check on how to implement this.

>
>IDK how this works in Python exactly but to give you a rough idea
>here's pseudo code typed in the email client:
>
>class UnknownNlAttrKey:
>	def __init__(self, nlattr):
>		self.nla = nlattr
>	def __hash__(self):
>		return self.nla.type
>	def __eq__(self, other):
>		if isintance(other, Unknown...):
>			return other.nla.type == self.nla.type
>		return False
>	def __repr__():
>		return f"UnknownAttr({self.nla.type})"

I see, will check if this is needed.

