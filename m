Return-Path: <netdev+bounces-30230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447F77867F8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 09:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9297228145A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2EA2454F;
	Thu, 24 Aug 2023 06:59:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8A21FB6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:59:48 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08C1AD
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:59:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fee8af9cb9so42297505e9.1
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692860384; x=1693465184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xVvlCGex8MTTZYxV9+n6jIh21hrXPC9JzY4cLwH6KA=;
        b=JA/SlRiSGXLmyf4uxdL8Ezug//3djjbWkWBwFLDDwMEZb8sfx3E/tGZNzckZiddzdY
         vzZdao/SmZppv1Jwr8TYyz+1EEMuiXtaqhPJ7UsLHabhBVyNQllseyx+wcxHnck5PYfx
         3hjWgKX243esYSmP+UJ9iPL8O54M2Y1okgV06RTexXMWQJin22ja0auiPFgIJxZxJuaI
         0qIi2d3hAdKgKRPFYf5Kr6t0K2llnb2ccWk78c7jf4OX2MR20VO/5sXnz2HOzK16yds/
         PV7MZCBC2Ro5kwyuyRG7lb7ghiiAWapS+FketmqQpxWVxUlSyzuqj3dxhlKM2K9It+vQ
         2oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692860384; x=1693465184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xVvlCGex8MTTZYxV9+n6jIh21hrXPC9JzY4cLwH6KA=;
        b=cJvV6WghH6hZT84sSO382suAM4ICSRYdwwEgw5ujxGw8p/vSgYl8t/AJtmZxEcWIMA
         nzze5lEpEanCpGCvaKvXZKOdx7g8PZsBxvujJ/TF+eOKpWfyiuEegwAC4dXFt+bUi9Ql
         I3XC02XLv6U/wgy6JkcqY1Z9l27RtiujPhf4dXyO4WAFACYacEbQEPej0WR2q8U+2prG
         MJ55BighjY9tUK8wWMqyVGj1MXGw2JJUCj2ly8VCROo13SOZRTgslrsBZlBXi/EAPOBa
         MmBPLj9sU2bGnV6PihCiBeK0Wq6guwcqWai5GkUtYiEQGJtFYpGqDjpNkjzKZ2gb4y/b
         Pq3g==
X-Gm-Message-State: AOJu0Ywydh/duOj3eyzuVuy+75inmjYhU0iaWIZrWWFw4QRhkzNTyYDy
	u9lzU2ifNRKLXizqaVUFrYsq+Q==
X-Google-Smtp-Source: AGHT+IHV5h/gWiGqWISIXTEBzuyi+BE2xkRY/zgFh1SxLekzv+sqKnQhfmfoEMGVAG+tjnX0+xWpsg==
X-Received: by 2002:adf:edca:0:b0:31a:d7fc:28f with SMTP id v10-20020adfedca000000b0031ad7fc028fmr12034332wro.19.1692860384103;
        Wed, 23 Aug 2023 23:59:44 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id y17-20020adfe6d1000000b003176eab8868sm21246718wrm.82.2023.08.23.23.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 23:59:43 -0700 (PDT)
Date: Thu, 24 Aug 2023 08:59:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v6 0/9] Create common DPLL configuration API
Message-ID: <ZOb/3qbGKS4+6Slu@nanopsycho>
References: <20230823225242.817957-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823225242.817957-1-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 24, 2023 at 12:52:33AM CEST, vadim.fedorenko@linux.dev wrote:
>Implement common API for DPLL configuration and status reporting.
>The API utilises netlink interface as transport for commands and event
>notifications. This API aims to extend current pin configuration 
>provided by PTP subsystem and make it flexible and easy to cover
>complex configurations.
>
>Netlink interface is based on ynl spec, it allows use of in-kernel
>tools/net/ynl/cli.py application to control the interface with properly
>formated command and json attribute strings. Here are few command
>examples of how it works with `ice` driver on supported NIC:
>
>- dump dpll devices:
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--dump device-get
>[{'clock-id': 4658613174691613800,
>  'id': 0,
>  'lock-status': 'locked-ho-acq',
>  'mode': 'automatic',
>  'mode-supported': ['automatic'],
>  'module-name': 'ice',
>  'type': 'eec'},
> {'clock-id': 4658613174691613800,
>  'id': 1,
>  'lock-status': 'locked-ho-acq',
>  'mode': 'automatic',
>  'mode-supported': ['automatic'],
>  'module-name': 'ice',
>  'type': 'pps'}]
>
>- get single pin info:
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-get --json '{"id":2}'
>{'board-label': 'C827_0-RCLKA',
> 'clock-id': 4658613174691613800,
> 'capabilities': 6,
> 'frequency': 1953125,
> 'id': 2,
> 'module-name': 'ice',
> 'parent-device': [{'direction': 'input',
>                    'parent-id': 0,
>                    'prio': 9,
>                    'state': 'disconnected'},
>                   {'direction': 'input',
>                    'parent-id': 1,
>                    'prio': 9,
>                    'state': 'disconnected'}],
> 'type': 'mux'}
>
>- set pin's state on dpll:
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-set --json '{"id":2, "parent-device":{"parent-id":1, "state":2}}'
>
>- set pin's prio on dpll:
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-set --json '{"id":2, "parent-device":{"parent-id":1, "prio":4}}'
>
>- set pin's state on parent pin:
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-set --json '{"id":13, "parent-pin":{"parent-id":2, "state":1}}'
>
>
>Changelog:
>
>v5 -> v6:
>- change dpll-caps to pin capabilities and adjust enum accordingly
>- remove dpll.h from netdevice.h

For the record, I'm fine with this version and my signed-offs stand.

Thanks!

