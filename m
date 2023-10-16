Return-Path: <netdev+bounces-41476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283547CB169
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C4328145F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CFA31A98;
	Mon, 16 Oct 2023 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoyO6nLo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF430CED
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 17:34:51 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2AE83
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 10:34:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7dac80595so70564877b3.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697477688; x=1698082488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdg0e3ntFTtv2Dafon8kmpSpFtJlb0KBcmQdXqXbSJU=;
        b=LoyO6nLoUZvBlC1AscmIVzB+RrW6aYtooqQ9v+strp2+PZGtCLJjnkYcXiMrKv7p0/
         CerrjPGRNj9CBfK1ZCiq57o834RLGo3WlGPYfOCKTfiqoHbT4Cy0cKMuTZYhpl1WPiOR
         uV3ZhPZQoe3vDb3PjhXwnhqVTmUzEAozZQp/MWwMiWMwacH3V3ddQgOaiR6hoGbinRgc
         O/5bqCqbYivB28dxnZTiEhE3rd75AxJZGwA3o11qurD6VJKUqzYYeP5dokaQtMZONxFV
         vtR/oTbjJyin+RPBeP53yh9YvJFX9bjmw3u/8a5PPUKrnFob1+hZ5p7xDU89UN6wAiJt
         7rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477688; x=1698082488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdg0e3ntFTtv2Dafon8kmpSpFtJlb0KBcmQdXqXbSJU=;
        b=JrG3wHA1SU+Lg6WnrhrElh2W3qxJAacuAjF8b7B4yO05WgP3l/8bYxLlm/uOqQweBy
         GzM6lhv3AyGh0doeSJi0l0hkhlSqyn4mQBtKb2TMvilAjLBhx51rTu+ZVqKiju4owMYn
         5QgudMjyT3KUgClw6TwCNASNCmMP9qcpBIySypK3DxNzLTRd9VOxxxJYYXFJ4GWSd0DF
         4UdnFoCFBu02yVkdS1LwJqZ+0rC44aaWLAyxiNhWVTb8Mo/tiv/02ib4sTWd9Fc9Uha/
         NxL9dmOPpCzRDsXl9dVBs4vq5Ed8IyKNcxwCwx4Aqj8PmCb0HzRVZT56R/qUMF2b93Yn
         /P4w==
X-Gm-Message-State: AOJu0Yx+xceGlEu1tv+ZJ279Ex1rpSMW60Xp72s5BImkiNGw76zuErC+
	rfy4iesGRgas6CpZ0vCd+4DFU88=
X-Google-Smtp-Source: AGHT+IGvOTPVLTbGNVcb7CkA+o2+ORfNO6VwwKOAfBLygdSpR3YvaHz8TPMvLvneRr1hIwFZFBhGTjU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:ea90:0:b0:5a8:6162:b69 with SMTP id
 t138-20020a0dea90000000b005a861620b69mr128429ywe.3.1697477688685; Mon, 16 Oct
 2023 10:34:48 -0700 (PDT)
Date: Mon, 16 Oct 2023 10:34:46 -0700
In-Reply-To: <20231003153416.2479808-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003153416.2479808-1-kuba@kernel.org> <20231003153416.2479808-2-kuba@kernel.org>
Message-ID: <ZS10NtQgd_BJZ3RU@google.com>
Subject: Re: [PATCH net-next 1/3] ynl: netdev: drop unnecessary enum-as-flags
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, lorenzo@kernel.org, willemb@google.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/03, Jakub Kicinski wrote:
> enum-as-flags can be used when enum declares bit positions but
> we want to carry bitmask in an attribute. If the definition
> is already provided as flags there's no need to indicate
> the flag-iness of the attribute.

Jakub, Willem hit an issue with this commit when running cli.py:

./cli.py --spec $KDIR/Documentation/netlink/specs/netdev.yaml --dump dev-get --json='{"ifindex": 12}'

Traceback (most recent call last):
  File "/usr/local/google/home/sdf/net-next/tools/net/ynl/./cli.py", line 60, in <module>
    main()
  File "/usr/local/google/home/sdf/net-next/tools/net/ynl/./cli.py", line 51, in main
    reply = ynl.dump(args.dump, attrs)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", line 729, in dump
    return self._op(method, vals, [], dump=True)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", line 714, in _op
    rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", line 540, in _decode
    decoded = self._decode_enum(decoded, attr_spec)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", line 486, in _decode_enum
    value = enum.entries_by_val[raw].name
            ~~~~~~~~~~~~~~~~~~~^^^^^
KeyError: 127

I do see we have special handing for enum-as-flags to parse out the
individual fields:
	if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index c46fcc78fc04..14511b13f305 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -74,7 +74,6 @@ name: netdev
>          doc: Bitmask of enabled xdp-features.
>          type: u64
>          enum: xdp-act
> -        enum-as-flags: true
>        -
>          name: xdp-zc-max-segs
>          doc: max fragment count supported by ZC driver
> @@ -87,7 +86,6 @@ name: netdev
>               See Documentation/networking/xdp-rx-metadata.rst for more details.
>          type: u64
>          enum: xdp-rx-metadata
> -        enum-as-flags: true
>  
>  operations:
>    list:
> -- 
> 2.41.0
> 

