Return-Path: <netdev+bounces-54236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C0980659D
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493571F21188
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0AECA7B;
	Wed,  6 Dec 2023 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzZ+bX6/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF9CA69
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF90C433C8;
	Wed,  6 Dec 2023 03:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701833028;
	bh=0icMTsZffc3HsofoVIIMmjh5hP1g6SqIcxw749v3E9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fzZ+bX6/C+v8bCMDCwhFV48Ta3s6YrX5ZoYHymZP8IlclkW0Izsp085wVdQC2s9vc
	 AOav5FbkiRVeDUNao10HWQA23RJLyYwlKSAnHU6l5IxwhujVyewsDCCbwgj3A3IIRf
	 Jj2Cr+YtK+g4aIP0P4Q4+gWb7i/KBqVuL2TzfUNBREmRm8tPQBG1pktUVn0phmOu52
	 /9w6j+vjmv7vPkVNa4eyiOJbLXg84YlBRyUSDq/ym45PgDBzXRal2jZCI+ShRk70hH
	 Hu5iGt2dR6vzctYiaW3z5/iLro2p2/T/+7wGmGqil8b6X9hd2o6c5sXeKgpC80L8Xx
	 mjGyYUK4FSiig==
Date: Tue, 5 Dec 2023 19:23:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Hao Chen
 <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] net: hns3: reduce stack usage in
 hclge_dbg_dump_tm_pri()
Message-ID: <20231205192346.4409ee16@kernel.org>
In-Reply-To: <7df7cfcb-d39b-4643-a378-a18b8d2b5b35@huawei.com>
References: <20231204085735.4112882-1-arnd@kernel.org>
	<7df7cfcb-d39b-4643-a378-a18b8d2b5b35@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 22:50:55 +0800 Jijie Shao wrote:
> >   static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
> >   {
> > -	char data_str[ARRAY_SIZE(tm_pri_items)][HCLGE_DBG_DATA_STR_LEN];
> > +	char *data_str;  
> 
> We want to define variables in an inverted triangle based on the code length.
> so, "char *data_str" should move four lines down.
> 
>    	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
> 	char *result[ARRAY_SIZE(tm_pri_items)], *sch_mode_str;
> 	char content[HCLGE_DBG_TM_INFO_LEN];
> 	u8 pri_num, sch_mode, weight, i, j;
> 	char *data_str;
> 	int pos, ret;

I took the liberty of fixing this when applying.
Don't want this to fall thru the cracks.

Applied to net-next now, thanks!

