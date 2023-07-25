Return-Path: <netdev+bounces-20845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D7761906
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B50628166A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0F1ED32;
	Tue, 25 Jul 2023 12:56:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC95C8C3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:56:58 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8594A13D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:56:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5223fbd54c6so1614047a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690289814; x=1690894614;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ho3GejCh9s0eGakroYl0akP3uIeiMqZai+ZwK04km0w=;
        b=GK1qu4JeKW89CXZred8cq0vSFJQcVkodhQW/xfzgca+LPEoewJcLRVWPHhsgohRr2j
         9ZXw6tuV1mcoyi0qEpTN4IfY6OiYka2WFmQ/2EL8yGUD8/o9hrxuLCa3I4sNFBxdspRb
         4URWwaCc2+DIzcq3fQUMNinh4VvOSopY80mtbjrcIsi1SDK/ghNUN4aMEDXHfaM0oXZ/
         xuvM/qFqBc/fztGrbDDScpM3N6nRZrThyNkWuATVqnSVdBe744X4Vk+lgDlMunbELENx
         ZvcP3nR0KV+6bn3ftHNgmQu2W6xM6gtOQNHFFVl5iEu51T3iUloCQ2HveQTAuYNLV9iW
         YtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289814; x=1690894614;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho3GejCh9s0eGakroYl0akP3uIeiMqZai+ZwK04km0w=;
        b=AAGswy0pQZDOIOcwoqylJ0tdDC2GOXvXiOJ0VDKShA/l3iiw6JaTurEBvt6LmKnSiB
         dud/7BtL6vR26WgibxV51lkiPRyExs3J1tGlzls3pxdZTAfmIuxdyWqRoGg+UXje3OmW
         d1HpAbKepZ5YAbDmekGSo8zHWachH86SHOV5hD1u5GlTxhiIi84L7E66Iz634YAYWuoe
         1dBNMBHVaR5fTYQmpHEVtN2fhxH2Y8u+ewXjTjaf/g0Tetf55NVR8m35MytUtRc1h8yc
         U+jyWmOyRTOlM35TqXnIKlOG1CPB76kQN9qnzbZlrS3lDnpPMGB6Fy2VTWaQhM/l6vmS
         bMiA==
X-Gm-Message-State: ABy/qLaTUs0te2qUMzcc/+0SXVZiXbO2BbHicckV4Wc6/O2u326Z+Asi
	5c+tAaWXb0X8T4xdvTV0U14=
X-Google-Smtp-Source: APBJJlH8+3ONd2K18r5T8WRsmWE+pmagfAxPaStNGOFDYp1omwdPC9zTzbK0gK80P5NsIM8VEWTcZQ==
X-Received: by 2002:aa7:d8cf:0:b0:522:4dd0:de6e with SMTP id k15-20020aa7d8cf000000b005224dd0de6emr1420005eds.8.1690289813748;
        Tue, 25 Jul 2023 05:56:53 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:281d:e8db:fbf2:5ca7])
        by smtp.gmail.com with ESMTPSA id t23-20020a05640203d700b005223f398df1sm1371040edw.91.2023.07.25.05.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:56:52 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: kuba@kernel.org,  netdev@vger.kernel.org,  davem@davemloft.net,
  pabeni@redhat.com,  edumazet@google.com,  simon.horman@corigine.com
Subject: Re: [PATCH net-next v5 1/2] tools: ynl-gen: fix enum index in
 _decode_enum(..)
In-Reply-To: <20230725101642.267248-2-arkadiusz.kubalewski@intel.com>
	(Arkadiusz Kubalewski's message of "Tue, 25 Jul 2023 12:16:41 +0200")
Date: Tue, 25 Jul 2023 13:53:52 +0100
Message-ID: <m24jlsywwv.fsf@gmail.com>
References: <20230725101642.267248-1-arkadiusz.kubalewski@intel.com>
	<20230725101642.267248-2-arkadiusz.kubalewski@intel.com>
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

> Remove wrong index adjustment, which is leftover from adding
> support for sparse enums.
> enum.entries_by_val() function shall not subtract the start-value, as
> it is indexed with real enum value.
>
> Fixes: c311aaa74ca1 ("tools: ynl: fix enum-as-flags in the generic CLI")
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  tools/net/ynl/lib/ynl.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 1b3a36fbb1c3..027b1c0aecb4 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -420,8 +420,8 @@ class YnlFamily(SpecFamily):
>      def _decode_enum(self, rsp, attr_spec):
>          raw = rsp[attr_spec['name']]
>          enum = self.consts[attr_spec['enum']]
> -        i = attr_spec.get('value-start', 0)
>          if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
> +            i = 0
>              value = set()
>              while raw:
>                  if raw & 1:
> @@ -429,7 +429,7 @@ class YnlFamily(SpecFamily):
>                  raw >>= 1
>                  i += 1
>          else:
> -            value = enum.entries_by_val[raw - i].name
> +            value = enum.entries_by_val[raw].name
>          rsp[attr_spec['name']] = value
>  
>      def _decode_binary(self, attr, attr_spec):

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

