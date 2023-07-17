Return-Path: <netdev+bounces-18236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BB1755F27
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A511B281458
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC73A922;
	Mon, 17 Jul 2023 09:24:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B12947E
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:24:13 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B473610DF
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:24:05 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9F3E961E5FE01;
	Mon, 17 Jul 2023 11:23:32 +0200 (CEST)
Message-ID: <e5e7a277-9591-4154-15de-b78be569a498@molgen.mpg.de>
Date: Mon, 17 Jul 2023 11:23:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: Accept LAG netdevs in
 bridge offloads
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, jiri@resnulli.us,
 simon.horman@corigine.com, anthony.l.nguyen@intel.com, netdev@vger.kernel.org
References: <20230717091843.108015-1-wojciech.drewek@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230717091843.108015-1-wojciech.drewek@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear Wojciech,


Thank you for your patch.


Am 17.07.23 um 11:18 schrieb Wojciech Drewek:
> Allow LAG interfaces to be used in bridge offload using
> netif_is_lag_master. In this case, search for ice netdev in
> the list of LAG's lower devices.

Why weren’t these interfaces allowed to be used like that before? It’d 
be great if you added that information.

> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

[…]


Kind nregards,

Paul

