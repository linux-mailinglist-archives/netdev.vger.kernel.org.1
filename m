Return-Path: <netdev+bounces-27008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02507779DAE
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 08:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F66281D7A
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 06:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAE11CCB7;
	Sat, 12 Aug 2023 06:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5341CCAF
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 06:22:14 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE061FE6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 23:22:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so40164391fa.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 23:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691821330; x=1692426130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIaxLGslRcW1QcwxO7GUCWkC9wgWwk1uDGheKD/YCrw=;
        b=4PctNgLywMMJCSp6BUcfrAV8WOEPnbG4kVlmHd2WEFjSmqXBcuZ/AfSLxuR4EXNmR0
         nyhBBFjS8+zL8ucP4+zurnj7NAahlSvniN3ONxIhuWJ9dvgDuArke3IfQT+NN+WfuUUZ
         CEuniya89+TOZA/kXssDd9PJmlBDK1KJK95gLegPBhP0srsdaJRI6k/9oYkGutLxC4+B
         Gv9kIZ8yJiQ1ScPq94nDqLgNVp6BZTOJ2yHdCHtyxQs9poN3oI5/f1PY9BBjLxUN3d/C
         6IMnuaPJcQrwDpiF71wfSivHhhz4qCAUuJ6sN4sQJpZwS12RLCmaUqs11Cp57p36sm1N
         IbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691821330; x=1692426130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIaxLGslRcW1QcwxO7GUCWkC9wgWwk1uDGheKD/YCrw=;
        b=Kz4PcZ3WC/Le9jr1iNkZz2E9vwiny/OpMcvY/LICjeZ7JPKwAdC5VbKGKqXnS/dZsm
         6kVicgWgl41Y6OpcZIKTbjtcIXQXAVXD6HPvjx/EL4J9Me5GQbS3Fv7Fi2pwNzA7BdF2
         du3nd+M2DTXOiBQaG+4nKyd2NOX8HBw7Skg4NQ8YoystKiRcA682ROi9+oaYL7yt5clD
         YXLYG+CP0dKbqrvcM+PtmQ3yvDTudnlsbqpXWPnc7TLfRAj1qpFo1LyfHXkBh3dnQg7R
         OWRd1831yeNvgQZN/q53XqsGzj5tgToWYXxyyRJWfoySrwQTpvHBlhBLq1xKsBA4paqo
         9KYw==
X-Gm-Message-State: AOJu0YyfC4hV5zEOkFRYhcbzawYnlSf1Nu70iwt6vDEiPKe1njg72pO4
	ZNI7jtxDeH1iUf4DaE4w6GwlPw==
X-Google-Smtp-Source: AGHT+IEjyBAvqlEbHIM9xPstbrjCcgXcTfotTEm4wwyq+KYhjkim0j7pUrNecCBDyycYcldKCLSwcA==
X-Received: by 2002:a05:6512:3da0:b0:4f8:71cc:2b6e with SMTP id k32-20020a0565123da000b004f871cc2b6emr3913300lfv.33.1691821330468;
        Fri, 11 Aug 2023 23:22:10 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l26-20020aa7c31a000000b005224d15d3dfsm2883854edq.87.2023.08.11.23.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 23:22:09 -0700 (PDT)
Date: Sat, 12 Aug 2023 08:22:08 +0200
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
Subject: Re: [PATCH net-next v4 0/9] Create common DPLL configuration API
Message-ID: <ZNclEAXpyAFrhCh5@nanopsycho>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 11, 2023 at 10:03:31PM CEST, vadim.fedorenko@linux.dev wrote:
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
>- dump dpll devices
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--dump device-get
>[{'clock-id': 282574471561216,
>  'id': 0,
>  'lock-status': 'unlocked',
>  'mode': 'automatic',
>  'module-name': 'ice',
>  'type': 'eec'},
> {'clock-id': 282574471561216,
>  'id': 1,
>  'lock-status': 'unlocked',
>  'mode': 'automatic',
>  'module-name': 'ice',
>  'type': 'pps'}]
>
>- get single pin info:
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-get --json '{"pin-id":2}'
>{'clock-id': 282574471561216,
> 'module-name': 'ice',
> 'pin-board-label': 'C827_0-RCLKA',
> 'pin-dpll-caps': 6,
> 'pin-frequency': 1953125,
> 'pin-id': 2,
> 'pin-parent-device': [{'id': 0,
>                         'pin-direction': 'input',
>                         'pin-prio': 11,
>                         'pin-state': 'selectable'},
>                        {'id': 1,
>                         'pin-direction': 'input',
>                         'pin-prio': 9,
>                         'pin-state': 'selectable'}],
> 'pin-type': 'mux'}
>
>- set pin's state on dpll:
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-set --json '{"pin-id":2, "pin-parent-device":{"id":1, "pin-state":2}}'
>
>- set pin's prio on dpll:
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-set --json '{"pin-id":2, "pin-parent-device":{"id":1, "pin-prio":4}}'
>
>- set pin's state on parent pin:
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-set --json '{"pin-id":13, \
>                      "pin-parent-pin":{"pin-id":2, "pin-state":1}}'
>

For the record, I'm fine with this patchset version now.
Please merge and make this jurney to be over. Thanks!


