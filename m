Return-Path: <netdev+bounces-19794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B335C75C5B7
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38B61C21651
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081BF1D2EB;
	Fri, 21 Jul 2023 11:15:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA63D78
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:15:05 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC3030E3
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:14:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso11472345e9.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689938077; x=1690542877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsKYTxerwELik8pjR4/+BgcM5ijG8hNe+3EkcfX1ez0=;
        b=nwgrQtb4QMEpkERwBnAAEXwK4HunSVUwxvHmAvE+X1Ms3OgrBejoCzkC5kreACyzOp
         gzHmFDIw8MensyPWbiQn/89a7+8PkpX6GdY58mPU3/WnBpntIVAZYYsX0N08acW3St5s
         2PApigSYe3bV3OUtLu5PRP0so+DqsBwt6KaKX8S1gQvFLA9UwvxmQn8u/a5lyJ8EId19
         m/DjCtmji9+sEvne6YsinOUjwwJtvXqb2qYDowbV6guEWEbGLhGo/Xf/YigNS/4dRLAy
         iV0b9ZWI/yLJ167YZA1WUC9do6vW7zuyk8cE+Ap3zl0giRESNsGxdjQJ1t7d3lOkefHc
         MBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689938077; x=1690542877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsKYTxerwELik8pjR4/+BgcM5ijG8hNe+3EkcfX1ez0=;
        b=GMLgSQwZcNzxL+UMOLtrNxizPbfqn+5myhaF8JTSmZeqb4tVsDSa4VMAMUBPYngeol
         DCORaURQbHlBERF9yEJD3zGV54HAjVh25MFvTfQtnfUK59UIQsji189Ta5xlFoblW/nd
         pweSyrYYY8s0R8A7FCTPhuLEPTn/J6yQta052XODl7eu7acOjTfOuwooZXjRzs5S82/t
         37XMk1/CGJjRMVPcFuepkirOQOx/XacilRfxq5OxttmwLTwM5WBDvnoSEsb/lv8m9WFc
         8subCBgytR5G78OEeBNymFaCB8VrFarHsIXF08Pz9EUiBzQcGob9e77pK4/w5EHTl6JL
         /QmA==
X-Gm-Message-State: ABy/qLYpzirct+vIzxW3g2y+MbyJQHscd8RD8kHXbMjybTq0G4WrUmkq
	XIAVWLWPmjXtvEmH/9ULrwNUZYpqdvQo/xF+buI=
X-Google-Smtp-Source: APBJJlEWjQYHfhTevL2bgZ8/xfts+EcqB9AKykH+DAxcFu3KOQ5dhN2mwoZR93J97JYQKPD7VC+HoQ==
X-Received: by 2002:a05:600c:1d1b:b0:3f9:68f:9c1a with SMTP id l27-20020a05600c1d1b00b003f9068f9c1amr7350230wms.15.1689938077196;
        Fri, 21 Jul 2023 04:14:37 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f14-20020a7bcd0e000000b003fc01f7b415sm5937987wmj.39.2023.07.21.04.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 04:14:36 -0700 (PDT)
Date: Fri, 21 Jul 2023 13:14:35 +0200
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
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH net-next 00/11] Create common DPLL configuration API
Message-ID: <ZLpom60B+fkjsoG1@nanopsycho>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are couple of issues that came up during our internal ci run:

10:16:04  error: drivers/dpll/dpll_netlink.c:452:5: error: no previous prototype for '__dpll_device_change_ntf' [-Werror=missing-prototypes]
10:16:04  error: drivers/dpll/dpll_netlink.c:1283:13: error: no previous prototype for 'dpll_netlink_fini' [-Werror=missing-prototypes]
10:16:04  error: drivers/dpll/dpll_core.c:221:1: error: no previous prototype for 'dpll_xa_ref_dpll_find' [-Werror=missing-prototypes]

10:27:31  error: drivers/dpll/dpll_core.c:220:21: warning: symbol 'dpll_xa_ref_dpll_find' was not declared. Should it be static?
10:27:31  error: drivers/dpll/dpll_netlink.c:452:5: warning: symbol '__dpll_device_change_ntf' was not declared. Should it be static?
10:27:31  error: drivers/dpll/dpll_netlink.c:1283:13: warning: symbol 'dpll_netlink_fini' was not declared. Should it be static?
10:27:41  error: drivers/net/ethernet/intel/ice/ice_dpll.c:461:3: error: a label can only be part of a statement and a declaration is not a statement

I believe that you didn't run make with C=2, otherwise you would hit
these.

Checkpatch issue:
10:29:30  CHECK: struct mutex definition without comment
10:29:30  #6581: FILE: drivers/net/ethernet/intel/ice/ice_dpll.h:85:
10:29:30  +	struct mutex lock;

Spelling errors:
10:45:08  error: Documentation/netlink/specs/dpll.yaml:165: prority ==> priority
10:45:08  error: include/uapi/linux/dpll.h:128: prority ==> priority
10:45:08  error: drivers/net/ethernet/intel/ice/ice_dpll.c:2008: userpsace ==> userspace
10:45:08  error: drivers/net/ethernet/intel/ice/ice_dpll.h:20: properities ==> properties


Thu, Jul 20, 2023 at 11:18:52AM CEST, vadim.fedorenko@linux.dev wrote:
>Implement common API for clock/DPLL configuration and status reporting.
>The API utilises netlink interface as transport for commands and event
>notifications. This API aim to extend current pin configuration and

s/API aim/API aims/


>make it flexible and easy to cover special configurations.

I don't follow. How this could "aim to extend current pin configuration" ?
This is a new thing. Could you re-phrase?

What's "special configuration"? Sounds odd.


>
>Netlink interface is based on ynl spec, it allows use of in-kernel
>tools/net/ynl/cli.py application to control the interface with properly
>formated command and json attribute strings. Here are few command
>examples of how it works with `ice` driver on supported NIC:
>
>- dump dpll devices
>$# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \

"$#" looks a bit odd. Just "$" with "sudo" when you want to emphasize
root is needed to perform the command.


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
>$# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-get --json '{"pin-id":2}'
>{'clock-id': 282574471561216,
> 'module-name': 'ice',
> 'pin-board-label': 'C827_0-RCLKA',
> 'pin-dpll-caps': 6,
> 'pin-frequency': 1953125,
> 'pin-id': 2,
> 'pin-parenti-device': [{'id': 0,

This looks like manual edit went wrong :)
s/parenti/parent/


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
>$# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-set --json '{"pin-id":2, "pin-parent-device":{"id":1, "pin-state":2}}'
>
>- set pin's prio on dpll:
>$# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-set --json '{"pin-id":2, "pin-parent-device":{"id":1, "pin-prio":4}}'
>
>- set pin's state on parent pin:
>$# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>--do pin-set --json '{"pin-id":13, \
>                      "pin-parent-pin":{"pin-id":2, "pin-state":1}}'
>

[...]

