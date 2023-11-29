Return-Path: <netdev+bounces-52204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301B57FDDCF
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D920D28259B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136CD32C87;
	Wed, 29 Nov 2023 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZI3HVQI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA09210C3;
	Wed, 29 Nov 2023 08:59:07 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b4f60064eso17004705e9.1;
        Wed, 29 Nov 2023 08:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701277146; x=1701881946; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BOfb4QUnr3jYEHugyY71tdfEezoV7AI3GfOfIzO0Gg8=;
        b=HZI3HVQITfyKwUqMCrrIRQud4WNxawjzuqGWlwea31+1EBh43VYgd54BCtb+152VtM
         /+/h/aAJp6Ig6ZQJrwCmwJ1ugxEdXcsW6fG2KCdfGs7+cF8MQQqDC26EZsKob1vzJUE1
         BbWJeP5CKIwOEba5iTxaxOR435gFfu1A2RbdenTLlaYehVGnwn2i5x6EkWMJfDlWLKiO
         Lp9I+SAWoOQzcw7GIQ8COC8usAoOuLaWmExqzHhCalNYdOAbcupAVjW7r+1GiA8y9WNO
         SEDC9+AMcezhF4hiZa217CV24pMZXk+QUed3K2U5+R2tgovLKt3c/7XiPBmxjvHDyUWw
         5FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277146; x=1701881946;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOfb4QUnr3jYEHugyY71tdfEezoV7AI3GfOfIzO0Gg8=;
        b=oKhvRjEZkoc9jzdm/jj57+JgZXEcFomLwE3nWzPzXpKqUIKTgzjL4qGRo6BqwZViNq
         Pbeu5f0oZHLl5s/1gnUI/O3fRyhTCsQNGwXDZ+o4TvofxZESg2KDIxbW+J+k3dScJbvc
         Y1w5goR4YZgOwTlE7N+XNlVLaHLlqQwJqdBGfWdCkoZA7SWQmrQ/6Ux0eYAzDdvDQXPU
         ZBXEKIwb/oRJR6H81RIzNOy8+KCp7tGMBvVQcFGEeMPlUYkR70BZB6TZj9s3x2wlUEid
         hczQkdLVoOuMwN+RzMNElzyirq/VMHMmOHNzavvJ2vdYbE35JxnAIlrmzL8DdD+56mhg
         DFWw==
X-Gm-Message-State: AOJu0Yze5wtIRe2htpgWUGVsUIAAFEh1NcoXdZWaVnH2jb0oRrphWHiO
	3d8EfG0PN9ioeyT2jXKkQrIboQLV5vAGZQ==
X-Google-Smtp-Source: AGHT+IGQtns4j8/Ahi1fstWxcuVWc8JuyIpdfN54lYXjzgNg19SQQsD3ajr2bIfSXG90ojpfmM+XqA==
X-Received: by 2002:a05:600c:4fd0:b0:40b:5401:f02 with SMTP id o16-20020a05600c4fd000b0040b54010f02mr1566980wmq.32.1701277146025;
        Wed, 29 Nov 2023 08:59:06 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:1c53:9d4e:6a62:308f])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c139300b0040b540ff0a5sm2486600wmf.19.2023.11.29.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:59:05 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,
  donald.hunter@redhat.com
Subject: Re: [RFC PATCH net-next v1 0/6] tools/net/ynl: Add dynamic selector
 for options attrs
In-Reply-To: <20231129080943.01d81902@kernel.org> (Jakub Kicinski's message of
	"Wed, 29 Nov 2023 08:09:43 -0800")
Date: Wed, 29 Nov 2023 16:58:57 +0000
Message-ID: <m2bkbc8pim.fsf@gmail.com>
References: <20231129101159.99197-1-donald.hunter@gmail.com>
	<20231129080943.01d81902@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 29 Nov 2023 10:11:53 +0000 Donald Hunter wrote:
>> This patchset adds a dynamic selector mechanism to YNL for kind-specific
>> options attributes. I am sending this as an RFC solicit feedback on a
>> couple of issues before I complete the patchset.
>
> Exciting stuff!
>  
>> I started adding this feature for the rt_link spec which is monomorphic,
>> i.e. the kind-specific 'data' attribute is always a nest. The selector
>> looked like this:
>> 
>>   -
>>     name: data
>>     type: dynamic
>>     selector:
>>       attribute: kind
>>       list:
>>         -
>>           value: bridge
>>           nested-attributes: linkinfo-bridge-attrs
>>         -
>>           value: erspan
>>           nested-attributes: linkinfo-gre-attrs
>
> It's kinda moot given your discovery below :(, but FWIW this is very
> close to what I've been thinking.
>
> After some pondering I thought it'd be better to structure it just
> a bit differently:
>
>  -
>    name: data
>    type: poly-nest
>    selector: kind    # which attr carries the key
>
> that's it for the attr, and then in attr-set I'd add a "key":
>
>  -
>    name: linkinfo-bridge-attrs
>    poly-key: bridge
>
> putting the key on the attr set is worse if we ever need to "key"
> the same attr set with different selectors, but it makes the attr
> definition a lot smaller. And in practice I didn't expect us
> to ever need keying into one attr set with different selectors. 
> If we did - we could complicate it later, but start simple.

rt_link shares attribute-sets between different kinds of link so I think
that rules out putting the key on the attribute-set. I think we may also
see reuse across stats attribute sets in tc.

FWIW I initially considered avoiding a selector list by using a template
to generate the attribute set name, but that broke pretty quickly.

>> ...
>> I now see a few possible ways forward and would like feedback on the
>> preferred approach:
>> 
>> 1. Simplify the current patchset to implement fixed-header & nest
>>    support in the dynamic selector. This would leave existing
>>    fixed-header support for messages unchanged. We could drop the 'type'
>>    field.
>> 
>>    -
>>      value: netem
>>      fixed-header: tc-netem-qopt
>>      nested-attributes: tc-netem-attrs
>> 
>> 2. Keep the 'type' field and support for the 'binary' type which is
>>    useful for specifying nests with unknown attribute spaces. An
>>    alternative would be to default to 'binary' behaviour if there is no
>>    selector entry.
>> 
>> 3. Refactor the existing fixed-header support to be an optional part of
>>    all attribute sets instead of just messages (in legacy and raw specs)
>>    and dynamic attribute nests (in raw specs).
>> 
>>    attribute-sets:
>>      -
>>        name: tc-netem-attrs
>>        fixed-header: tc-netem-qopt
>>        attributes:
>
> Reading this makes me feel like netem wants to be a "sub-message"?
> It has a fixed header followed by attrs, that's quite message-like.

Yeah, I guess we could call it sub-message because it's not a pure nest
and the different name makes it an explicitly netlink-raw concept.

> Something along the lines of 1 makes most sense to me, but can we
> put the "selector ladder" out-of-line? I'm worried that the attr
> definition will get crazy long.

It seems reasonable to pull the selector list out of line because
they do get big, e.g. over 100 lines for tc "options".

My preference is 1, probably including a fallback to "binary" if there
is no selector match.

> attribute-sets:
>   -
>     name: outside-attrs
>     attributes:
>       ...
>       -
>          name: kind
>          type: string
>       -
>          name: options
>          type: sub-message
>          sub-type: inside-msg  # reuse sub-type or new property?
>          selector: kind
>     ...
>   -
>     name: inside-attrs:
>     attributes: 
>       ...
>
> sub-messages:
>   list:
>     -
>       name: inside-msg
>       formats: # not a great name?..
>         -
>           value: some-value
>           fixed-header: struct-name
>         -
>           value: other-value
>           fixed-header: struct-name-two
>           nested-attributes: inside-attrs
>         -
>           value: another-one
>           nested-attributes: inside-attrs
>     -
>       name: different-inside-msg
>       ...
>
> operations:
>   ...
>
> At least that's what comes to my mind after reading the problem
> description. Does it make sense?

I think that once you have broken out to a sub-message, they're no
longer "nested-attributes" and we should maybe reuse "attribute-set".

I don't think we can reuse "sub-type" because the schema for it is the
set of netlink type names, not a free string. Maybe we add "sub-message"
instead? So how about this:

attribute-sets:
  -
    name: outside-attrs
    attributes:
      ...
      -
         name: kind
         type: string
      -
         name: options
         type: sub-message
         sub-message: inside-msg
         selector: kind
    ...
  -
    name: inside-attrs:
    attributes:
      ...

sub-messages:
  -
    name: inside-msg
    formats:
      -
        value: some-value
        fixed-header: struct-name
      -
        value: other-value
        fixed-header: struct-name-two
        attribute-set: inside-attrs
      -
        value: another-one
        attribute-set: inside-attrs
  -
    name: different-inside-msg
    ...

operations:
  ...

I cannot think of a better name than "formats" so happy to go with that.
Did you want an explicit "list:" in the yaml schema?

Thanks,
Donald.

