Return-Path: <netdev+bounces-26614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48837785A5
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 04:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCF9281C13
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB84A46;
	Fri, 11 Aug 2023 02:54:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90CA3D
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:54:33 +0000 (UTC)
X-Greylist: delayed 526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 19:54:31 PDT
Received: from out-108.mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E3A2D5F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:54:31 -0700 (PDT)
Message-ID: <6adc1b56-c714-b60e-f274-4e82e276e52f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691721943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qOGyHwJQegjUEjIKNLPS/UJ81OV2tyW98Si8f2LJZI=;
	b=idmnwzhmxBAGO/IP7csDdPE/GFyfK/koSZ77lRWtNT0Rp1ZCEfRblnDGxAv0SMjnuEJ/dk
	yHjynI115G8NJDkF/f1xHLxjY1g4Rh5iM09JQpv/PWxLsCVZsybVBXQ815q/bs8YXLRZI+
	znPfRuTirXz2IH57hnTuRIZxrFuYC2g=
Date: Fri, 11 Aug 2023 10:45:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] netlink: allow nl_sset return -EOPNOTSUPP to fallback
 to do_sset
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
 gang.li@linux.dev
References: <51b2f9c6-fc0f-9e77-6863-2d6b71130c51@linux.dev>
 <20230810100117.0b562777@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
In-Reply-To: <20230810100117.0b562777@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/11 01:01, Jakub Kicinski wrote:
> On Thu, 10 Aug 2023 20:53:02 +0800 Gang Li wrote:
>> Subject: [PATCH 1/1] netlink: allow nl_sset return -EOPNOTSUPP to fallback to  do_sset
> 
> Please make sure to add the project to the subject next time.
> [PATCH ethtool]

Sure, thanks!

