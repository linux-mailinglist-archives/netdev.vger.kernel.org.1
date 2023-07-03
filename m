Return-Path: <netdev+bounces-15113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB143745BB6
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 13:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C523280D6B
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D5EDF56;
	Mon,  3 Jul 2023 11:55:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA7DDA5
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 11:55:35 +0000 (UTC)
X-Greylist: delayed 377 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 04:55:29 PDT
Received: from mail.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3348810E
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 04:55:29 -0700 (PDT)
Received: from localhost (cpc147930-brnt3-2-0-cust60.4-2.cable.virginm.net [86.15.196.61])
	by mail.monkeyblade.net (Postfix) with ESMTPSA id 2589983844AA;
	Mon,  3 Jul 2023 04:49:07 -0700 (PDT)
Date: Mon, 03 Jul 2023 12:48:57 +0100 (BST)
Message-Id: <20230703.124857.1785883665481694727.davem@davemloft.net>
To: matt@codeconstruct.com.au
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jk@codeconstruct.com.au, alexandre.belloni@bootlin.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH 3/3] mctp i3c: MCTP I3C driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20230703053048.275709-4-matt@codeconstruct.com.au>
References: <20230703053048.275709-1-matt@codeconstruct.com.au>
	<20230703053048.275709-4-matt@codeconstruct.com.au>
X-Mailer: Mew version 6.9 on Emacs 28.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Mon, 03 Jul 2023 04:49:11 -0700 (PDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Matt Johnston <matt@codeconstruct.com.au>
Date: Mon,  3 Jul 2023 13:30:48 +0800

> +static void mctp_i3c_xmit(struct mctp_i3c_bus *mbus, struct sk_buff *skb)
> +{
> +	struct net_device_stats *stats = &mbus->ndev->stats;
> +	struct i3c_priv_xfer xfer = { .rnw = false };
> +	struct mctp_i3c_internal_hdr *ihdr = NULL;
> +	struct mctp_i3c_device *mi = NULL;
> +	u8 *data = NULL;
> +	unsigned int data_len;
> +	u8 addr, pec;
> +	int rc = 0;
> +	u64 pid;
 ...
> +/* Returns an ERR_PTR on failure */
> +static struct mctp_i3c_bus *mctp_i3c_bus_add(struct i3c_bus *bus)
> +__must_hold(&busdevs_lock)
> +{
> +	struct mctp_i3c_bus *mbus = NULL;
> +	struct net_device *ndev = NULL;
> +	u8 addr[PID_SIZE];
> +	char namebuf[IFNAMSIZ];
> +	int rc;


Please order local variables from longest to shortest line.

Please do this for your entire submission.

Thank you.

