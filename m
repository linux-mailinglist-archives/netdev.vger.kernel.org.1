Return-Path: <netdev+bounces-20846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211FC761908
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECAA280987
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509401F177;
	Tue, 25 Jul 2023 12:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D871F176
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:56:59 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94EE76
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:56:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991da766865so923757866b.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690289815; x=1690894615;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I0KDBaGKZTZJhCcZx30aTIpkjJ/pRAvwQCEvucSLOFg=;
        b=Iv47ou5knmmJGBF7EUDP50o9yoj4P2JLuc5sZV7imwVDo6obawnlSXYtcfdWQkaP6V
         JSpVUWO0sLn3zaYuxRU04l9yeCp0WR2I186XqPKEOPOOfkwG7BToK4aGO1cNIoHqcnUo
         SGKbHqwY2fw7n0RjYwNP+Sa1Tqp6NbT3+YRb7wAA/tDk6MJh9MW3ucHhE8QoUxT38B5/
         k5LGYZl9wdbslkZko3Z1k8TDY+wTEQYpmuFChb+C+azND40a8kYxNEwMvgB3aZ/YJ5ub
         a0mo2SH54woMSbstNXblOvp3Nxu8cukj0BF5H2ACU9gJHr/hmE3Xuex3LAq47w35Jkeq
         NczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289815; x=1690894615;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0KDBaGKZTZJhCcZx30aTIpkjJ/pRAvwQCEvucSLOFg=;
        b=F8az/u3wQrQ4f1Rh9YN04wQBs4WzL3H2bhk60xzUdqZfehuNzqfEGVaP/et3f4iJls
         VEXuTzO/upfc1re//+fl+7/ISOk5sVFSO6sD8k1KtZXz19pJgSyBy5g5TeC6J215SJHE
         runKU84Am55BqJXgiwa6DrpaY7fOoJcCb6KvioSGMxJUBKRb+/UdAXsp9fjts09CXdTc
         TIOhGyMeKVt2ieKnYNImBF5l89Q/MWv0fmaRLwNG+0c/gSjdAuU/vAsLLD0a6hTRP97w
         CoKzaOse5C9+bOA0PUXmrfeU85VTph2cMuMOU9fxKtOqG+E7ExikRwhlHSiX+FyVeuOe
         zvUg==
X-Gm-Message-State: ABy/qLbtdoQMzYRMnT6H2TtJIrgE/Lw9S3QABAgOTReAex3iH0ohe+vs
	/R7v0XULEN9e7khrEbkCu0o=
X-Google-Smtp-Source: APBJJlFSlz06bU+XbQla3sc+Xcuk2HnU53a5bu+PPwqC0WTfN21xkIr76Y3CpLOfCINAem35R/R/PQ==
X-Received: by 2002:a17:906:74c6:b0:994:56d3:8a42 with SMTP id z6-20020a17090674c600b0099456d38a42mr14308317ejl.27.1690289815259;
        Tue, 25 Jul 2023 05:56:55 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:281d:e8db:fbf2:5ca7])
        by smtp.gmail.com with ESMTPSA id u15-20020a1709064acf00b00992025654c4sm8115677ejt.182.2023.07.25.05.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:56:54 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: kuba@kernel.org,  netdev@vger.kernel.org,  davem@davemloft.net,
  pabeni@redhat.com,  edumazet@google.com,  simon.horman@corigine.com
Subject: Re: [PATCH net-next v5 2/2] tools: ynl-gen: fix parse multi-attr
 enum attribute
In-Reply-To: <20230725101642.267248-3-arkadiusz.kubalewski@intel.com>
	(Arkadiusz Kubalewski's message of "Tue, 25 Jul 2023 12:16:42 +0200")
Date: Tue, 25 Jul 2023 13:56:41 +0100
Message-ID: <m2zg3kxi7q.fsf@gmail.com>
References: <20230725101642.267248-1-arkadiusz.kubalewski@intel.com>
	<20230725101642.267248-3-arkadiusz.kubalewski@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com> writes:

> When attribute is enum type and marked as multi-attr, the netlink
> respond is not parsed, fails with stack trace:
> Traceback (most recent call last):
>   File "/net-next/tools/net/ynl/./test.py", line 520, in <module>
>     main()
>   File "/net-next/tools/net/ynl/./test.py", line 488, in main
>     dplls=dplls_get(282574471561216)
>   File "/net-next/tools/net/ynl/./test.py", line 48, in dplls_get
>     reply=act(args)
>   File "/net-next/tools/net/ynl/./test.py", line 41, in act
>     reply = ynl.dump(args.dump, attrs)
>   File "/net-next/tools/net/ynl/lib/ynl.py", line 598, in dump
>     return self._op(method, vals, dump=True)
>   File "/net-next/tools/net/ynl/lib/ynl.py", line 584, in _op
>     rsp_msg = self._decode(gm.raw_attrs, op.attr_set.name)
>   File "/net-next/tools/net/ynl/lib/ynl.py", line 451, in _decode
>     self._decode_enum(rsp, attr_spec)
>   File "/net-next/tools/net/ynl/lib/ynl.py", line 408, in _decode_enum
>     value = enum.entries_by_val[raw].name
> TypeError: unhashable type: 'list'
> error: 1
>
> Redesign _decode_enum(..) to take a enum int value and translate
> it to either a bitmask or enum name as expected.
>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  tools/net/ynl/lib/ynl.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 027b1c0aecb4..3ca28d4bcb18 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -417,8 +417,7 @@ class YnlFamily(SpecFamily):
>          pad = b'\x00' * ((4 - len(attr_payload) % 4) % 4)
>          return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_payload + pad
>  
> -    def _decode_enum(self, rsp, attr_spec):
> -        raw = rsp[attr_spec['name']]
> +    def _decode_enum(self, raw, attr_spec):
>          enum = self.consts[attr_spec['enum']]
>          if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
>              i = 0
> @@ -430,7 +429,7 @@ class YnlFamily(SpecFamily):
>                  i += 1
>          else:
>              value = enum.entries_by_val[raw].name
> -        rsp[attr_spec['name']] = value
> +        return value
>  
>      def _decode_binary(self, attr, attr_spec):
>          if attr_spec.struct_name:
> @@ -438,7 +437,7 @@ class YnlFamily(SpecFamily):
>              decoded = attr.as_struct(members)
>              for m in members:
>                  if m.enum:
> -                    self._decode_enum(decoded, m)
> +                    decoded[m.name] = self._decode_enum(decoded[m.name], m)
>          elif attr_spec.sub_type:
>              decoded = attr.as_c_array(attr_spec.sub_type)
>          else:
> @@ -466,6 +465,9 @@ class YnlFamily(SpecFamily):
>              else:
>                  raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
>  
> +            if 'enum' in attr_spec:
> +                decoded = self._decode_enum(decoded, attr_spec)
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

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

