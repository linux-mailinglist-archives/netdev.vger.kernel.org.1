Return-Path: <netdev+bounces-18981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F99759408
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAEE1C20E68
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E07512B95;
	Wed, 19 Jul 2023 11:18:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D5101F0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:18:02 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3A10D4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:17:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-262fa79e97fso3417327a91.2
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689765479; x=1692357479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oNQJB6d11xIAC9iz1241YLCciNaVxiXZtTFMaH4ztPk=;
        b=T+iYKWCSAHvWbUT8/jJ+KvlTUg9Y64M75OzSj3rY0woq2H6t5F1PzBpOJscU19Vi4x
         9B/fZjEig275RE5oyarR4HhX2BfCLp5SdqBvs2xP7SvjJ8nom5yzjyDwK6J96ahJHXNd
         Zsv7KuIP221I9mjqb+cWiwbKWgFDODJapyQkEX0LrqYWtLI6qz1n1Y8Pw8eUPUGhwc59
         UucF9AA/FaKBhWaEzQ6oFDjebm//YI8a56qHlDM2kTGF4Ok+QH5bpXE54gz+AmFsYXzM
         DzElhn8FYYyiYYtGu8Q126vBqNaHAAsevL0zNyNpRGqMf8w2UoMk2PppG5USr7OzaLz1
         li/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689765479; x=1692357479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNQJB6d11xIAC9iz1241YLCciNaVxiXZtTFMaH4ztPk=;
        b=VNSELwlrH46lMXhHBoZhhepUta72IuFneyWsIqSuhvEgBgM8uqY2654b/R2Q+1pf34
         yD+nlsA+aGqHxrsOLX9NgZcmT5StvUfN3nU1UNeeFLWO/3vJleRZ8Ug/OnYa7qo7e2E6
         17tu7/TaOm9SufNyN1RVVCM3POX090n0TS5zu76ibrhnfGkOe2G6wCdCEzZtCVtZ9BLq
         o9UyCw7Q6rg3QzbDFU5dFZmWcLpel+x2dkBKf6qEsVzDOZs6106py/pbBD1nXWMRMDJ1
         F4ymfaEMfnM8i+LUfT5ZVN+Ity012+oJALl361pzC/y0+hVqjjx0RgXFUuIafFnQ3qqr
         x5jw==
X-Gm-Message-State: ABy/qLZg+zDwkDY+lIE0/nHtjf2tlbhEgkFkV3zlcJ26XUwD3+zXToIm
	Cp+otQ/pukhAmGp4kKhxqxwcY/vOctF4VUvHguEMp1EDbkGQEg==
X-Google-Smtp-Source: APBJJlH8eWNK23FUVMxhs/ftTMsZWUqN1zS/xa4lK8lH+6fvXnZnq+Bh282pJY6zxPqJXurtb+NuwH0duoTz6XGeCT0=
X-Received: by 2002:a17:90a:ac17:b0:263:f5a5:fb98 with SMTP id
 o23-20020a17090aac1700b00263f5a5fb98mr13924168pjq.28.1689765478754; Wed, 19
 Jul 2023 04:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230718162225.231775-1-arkadiusz.kubalewski@intel.com> <20230718162225.231775-3-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20230718162225.231775-3-arkadiusz.kubalewski@intel.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 19 Jul 2023 12:17:47 +0100
Message-ID: <CAD4GDZzJkBrrwDXwXe0XLrP6swP_T6wYOfLhTcYvX_oRfMy7Mg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] tools: ynl-gen: fix parse multi-attr enum attribute
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 18 Jul 2023 at 17:24, Arkadiusz Kubalewski
<arkadiusz.kubalewski@intel.com> wrote:
>
>  tools/net/ynl/lib/ynl.py | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 5db7d47067f9..671ef4b5eaa6 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -135,7 +135,7 @@ class NlAttr:
>          format = self.get_format(type)
>          return [ x[0] for x in format.iter_unpack(self.raw) ]
>
> -    def as_struct(self, members):
> +    def as_struct(self, members, attr_spec):

No need to pass attr_spec - it's the spec for the struct, not for the members.

>          value = dict()
>          offset = 0
>          for m in members:
> @@ -147,6 +147,9 @@ class NlAttr:
>                  format = self.get_format(m.type, m.byte_order)
>                  [ decoded ] = format.unpack_from(self.raw, offset)
>                  offset += format.size
> +
> +            if m.enum:
> +                decoded = self._decode_enum(decoded, attr_spec)

_decode_enum is not a method on NlAttr so I'm pretty sure this will
fail. Looks like we need to move _decode_enum() into NlAttr?

The second param to _decode_enum should be 'm' which is the attr spec
for the member.

>              if m.display_hint:
>                  decoded = self.formatted_string(decoded, m.display_hint)
>              value[m.name] = decoded
> @@ -417,8 +420,7 @@ class YnlFamily(SpecFamily):
>          pad = b'\x00' * ((4 - len(attr_payload) % 4) % 4)
>          return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_payload + pad
>
> -    def _decode_enum(self, rsp, attr_spec):
> -        raw = rsp[attr_spec['name']]
> +    def _decode_enum(self, raw, attr_spec):
>          enum = self.consts[attr_spec['enum']]
>          if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
>              i = attr_spec.get('value-start', 0)
> @@ -430,15 +432,12 @@ class YnlFamily(SpecFamily):
>                  i += 1
>          else:
>              value = enum.entries_by_val[raw].name
> -        rsp[attr_spec['name']] = value
> +        return value
>
>      def _decode_binary(self, attr, attr_spec):
>          if attr_spec.struct_name:
>              members = self.consts[attr_spec.struct_name]
> -            decoded = attr.as_struct(members)
> -            for m in members:
> -                if m.enum:
> -                    self._decode_enum(decoded, m)
> +            decoded = attr.as_struct(members, attr_spec)
>          elif attr_spec.sub_type:
>              decoded = attr.as_c_array(attr_spec.sub_type)
>          else:
> @@ -466,6 +465,9 @@ class YnlFamily(SpecFamily):
>              else:
>                  raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
>
> +            if 'enum' in attr_spec:
> +                decoded = self._decode_enum(int.from_bytes(attr.raw, "big"), attr_spec)

As Jakub said, this should just be self._decode_enum(decoded, attr_spec)

> +
>              if not attr_spec.is_multi:
>                  rsp[attr_spec['name']] = decoded
>              elif attr_spec.name in rsp:
> @@ -473,8 +475,6 @@ class YnlFamily(SpecFamily):
>              else:
>                  rsp[attr_spec.name] = [decoded]
>
> -            if 'enum' in attr_spec:
> -                self._decode_enum(rsp, attr_spec)
>          return rsp
>
>      def _decode_extack_path(self, attrs, attr_set, offset, target):
> --
> 2.38.1

