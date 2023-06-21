Return-Path: <netdev+bounces-12602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C3738470
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B91C1C20D64
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D21811CA1;
	Wed, 21 Jun 2023 13:07:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA2174E6
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:07:48 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41628199B
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:07:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31126037f41so5649316f8f.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687352863; x=1689944863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TU5pe+asCSSBXdxRD62Pc73zx7uMR0rLSJrHUbp5re0=;
        b=CkUcMHVR+Z8yWrVCs3aa+R3jQV4jFsz4M5P2+9ftWZgzt/db2V9KrQOJMxJ11GhMwT
         hAUWMvFrEi/d7CfH6HI+KC5ld9dLAWsTabouLLOzs9dkdlrE7FpQ4f2msqpavhbA422u
         Cuix2KNbn4SkOv7AgpXv5F+qCn68JKCtGu+8+yEDR5xIpJogQEKUIBdi70OV5u40ETay
         PH4+qljOaIEG09l2kO/O5FKZplJPDhwdInH3YBc7tz5gLDA/1FS6JieSn676ZDAHvUVq
         9/0iAliOIzsBAlDf0OM3844UB/cUR0YMJAZTe+YI30MfMoVxhr94NC9haKVShpVdLDCu
         ng4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687352863; x=1689944863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU5pe+asCSSBXdxRD62Pc73zx7uMR0rLSJrHUbp5re0=;
        b=hRM0y4lihQ+MVWDTTTe4rqDIJRXAaWhnneD8lqlIoWPXjIOV+9WGPfmfIz0GtKJdQ+
         MinypSCamm523NHv2md+Rm72Y8h7/2yoCvrEOnaae61bO1S3K7PzJmH2w3NsDKUJxo3u
         T36wUrdiyP19IRf+4N1yA0QF/UAMGg5Cb+KY0K0dnw4UQ1pKpCXJwEUhoV5jlgXBRHwV
         pqvCpkXgmhEYDpke6eWplKb0yr3A2y5zXKiZ8FQs7G1GekYhWs0l/ggR+8WWbp7lmZoO
         JtgmfeHkCrQ7v+mHMLeVIT5iTewfXjq0vPGFEjX1P+WJKV7k7L1l967nA5h3oLddq13h
         S2ug==
X-Gm-Message-State: AC+VfDzQxMzgk0A9pzHiLTdJ1R5BMDLRmWcJzjnMd+X67/XW3SWCgVai
	3lJwglGqqIPxjUGWIxZuXQhN8w==
X-Google-Smtp-Source: ACHHUZ4DJdasIxxt0P5VQ3mJXiKww1/aS5p50nS9gK+lncj65MULR6+GXjSyIdfexJKVJjvw3OKC9Q==
X-Received: by 2002:adf:fe48:0:b0:311:10c0:85f0 with SMTP id m8-20020adffe48000000b0031110c085f0mr12540283wrs.14.1687352863404;
        Wed, 21 Jun 2023 06:07:43 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f7-20020adff8c7000000b0030e6096afb6sm4453467wrq.12.2023.06.21.06.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:07:42 -0700 (PDT)
Date: Wed, 21 Jun 2023 15:07:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Oros <poros@redhat.com>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, kuba@kernel.org,
	vadfed@meta.com, jonathan.lemon@gmail.com, pabeni@redhat.com,
	corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
	vadfed@fb.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
	richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
	ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
	michal.michalik@intel.com, gregkh@linuxfoundation.org,
	jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
	ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
	axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
	benjamin.tissoires@redhat.com, geert+renesas@glider.be,
	milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
	hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
	idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
	phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, mschmidt@redhat.com,
	linux-clk@vger.kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v8 04/10] dpll: netlink: Add DPLL framework base
 functions
Message-ID: <ZJL2HUkAtHEw5rq+@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-5-arkadiusz.kubalewski@intel.com>
 <c7480d0a71fb8d62108624878f549c0d91d4c9e6.camel@redhat.com>
 <ZJLktA6RJaVo3BdH@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJLktA6RJaVo3BdH@nanopsycho>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 21, 2023 at 01:53:24PM CEST, jiri@resnulli.us wrote:
>Wed, Jun 21, 2023 at 01:18:59PM CEST, poros@redhat.com wrote:
>>Arkadiusz Kubalewski píše v Pá 09. 06. 2023 v 14:18 +0200:
>>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>
>[...]
>
>Could you perhaps cut out the text you don't comment? Saves some time
>finding your reply.
>
>
>>> +static int
>>> +dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info
>>> *info)
>>> +{
>>> +       const struct dpll_device_ops *ops = dpll_device_ops(dpll);
>>> +       struct nlattr *tb[DPLL_A_MAX + 1];
>>> +       int ret = 0;
>>> +
>>> +       nla_parse(tb, DPLL_A_MAX, genlmsg_data(info->genlhdr),
>>> +                 genlmsg_len(info->genlhdr), NULL, info->extack);
>>> +       if (tb[DPLL_A_MODE]) {
>>Hi,
>>
>>Here should be something like:
>>               if (!ops->mode_set)
>>                       return -EOPNOTSUPP;
>
>Why? All drivers implement that.
>I believe that it's actullaly better that way. For a called setting up
>the same mode it is the dpll in, there should be 0 return by the driver.
>Note that driver holds this value. I'd like to keep this code as it is.

Actually, you are correct Petr, my mistake. Actually, no driver
implements this. Arkadiusz, could you please remove this op and
possibly any other unused  op? It will be added when needed.

Thanks!


>
>[...]

