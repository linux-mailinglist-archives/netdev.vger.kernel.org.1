Return-Path: <netdev+bounces-28736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3474780718
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8559A1C21546
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 08:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495EB174D8;
	Fri, 18 Aug 2023 08:25:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F8E56C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:25:16 +0000 (UTC)
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 01:25:14 PDT
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E032A2684;
	Fri, 18 Aug 2023 01:25:13 -0700 (PDT)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6705042627;
	Fri, 18 Aug 2023 10:05:17 +0200 (CEST)
Message-ID: <1bd4cb9c-4eb8-3bdb-3e05-8689817242d1@proxmox.com>
Date: Fri, 18 Aug 2023 10:05:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: linux-kernel@vger.kernel.org
Cc: siva.kallam@broadcom.com, prashant@broadcom.com, mchan@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, jdelvare@suse.com,
 Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
 linux-hwmon@vger.kernel.org, keescook@chromium.org
Subject: "Use slab_build_skb() instead" deprecation warning triggered by tg3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
we've got a user report about the WARN_ONCE introduced by ce098da1497c
("skbuff: Introduce slab_build_skb()") [0]. The stack trace indicates
that the call comes from the tg3 module. While this is still kernel 6.2
and I can't verify that the issue is still there with newer kernels, I
don't see related changes in drivers/net/ethernet/broadcom/tg3.* after
ce098da1497c, so I thought I should let you know.

[0]: https://forum.proxmox.com/threads/132338/

Best Regards,
Fiona


