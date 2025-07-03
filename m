Return-Path: <netdev+bounces-203570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C297AF66E0
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560D87A8378
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1642CCC1;
	Thu,  3 Jul 2025 00:44:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19972F29;
	Thu,  3 Jul 2025 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751503488; cv=none; b=SIhS0VYuIxWeMb0QNfqJ5ofMKaNtttB5V+jAtfhuqtxnvsh/Z3TtvoIcN5qfj8tD2X9oGOpgL6C+Zv36Rc8oCGLf1VRNpReoLBb3VeZrpbQLC7TV3IsuvphZwfjxqeornSZjY58B70gjJn+cK3t6z/G4xEpo/2XczvWFW+e6EyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751503488; c=relaxed/simple;
	bh=9t98IKG3iIzsvVxpLKy1yWHEyggTRxAlznMox1HXnHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGQ07Q7nEeHI9we6KOPgYoyIO25lg8kX8fiWSF2yY2AaYE6GOpJ5nBTvN85CMTYmZxjeP+irMxVwXnrAi1DHSK3QcNOnNM5RGNqZcAYYMokhYKPUqeKHZ1l7EZk+h67/jbwli6wlis4TfND5pCcS7SnTwn0yKzXNo+o1mVaBEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bXdJL212yz1R7Xh;
	Thu,  3 Jul 2025 08:42:10 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 9073014022E;
	Thu,  3 Jul 2025 08:44:41 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 08:44:39 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <pabeni@redhat.com>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <sumang@marvell.com>, <vadim.fedorenko@linux.dev>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v06 4/8] hinic3: Command Queue interfaces
Date: Thu, 3 Jul 2025 08:44:33 +0800
Message-ID: <20250703004433.11160-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <f875faa2-718d-4244-bb86-2178fed55922@redhat.com>
References: <f875faa2-718d-4244-bb86-2178fed55922@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> > +static void cmdq_sync_cmd_handler(struct hinic3_cmdq *cmdq,
> > +				  struct cmdq_wqe *wqe, u16 ci)
> > +{
> > +	spin_lock(&cmdq->cmdq_lock);
> > +	cmdq_update_cmd_status(cmdq, ci, wqe);
> > +	if (cmdq->cmd_infos[ci].cmpt_code) {
> > +		*cmdq->cmd_infos[ci].cmpt_code = CMDQ_DIRECT_SYNC_CMPT_CODE;
> > +		cmdq->cmd_infos[ci].cmpt_code = NULL;
> > +	}
> > +
> > +	/* Ensure that completion code has been updated before updating done */
> > +	smp_rmb();
>
> There is something off with the above barrier. It's not clear where is
> the paired wmb() and the comment looks misleading as this barrier order
> reads operation and not writes (as implied by 'updating').

Thanks for your reviewing. The comment is right and using read barrier here
is wrong. I will correct smp_rmb to smp_wmb in next version.

> > +	spin_lock_bh(&cmdq->cmdq_lock);
> > +	curr_wqe = cmdq_get_wqe(wq, &curr_prod_idx);
> > +	if (!curr_wqe) {
> > +		spin_unlock_bh(&cmdq->cmdq_lock);
> > +		return -EBUSY;
> > +	}
> > +
> > +	wrapped = cmdq->wrapped;
> > +	next_prod_idx = curr_prod_idx + CMDQ_WQE_NUM_WQEBBS;
> > +	if (next_prod_idx >= wq->q_depth) {
> > +		cmdq->wrapped ^= 1;
> > +		next_prod_idx -= wq->q_depth;
> > +	}
> > +
> > +	cmd_info = &cmdq->cmd_infos[curr_prod_idx];
> > +	init_completion(&done);
> > +	refcount_inc(&buf_in->ref_cnt);
> > +	cmd_info->cmd_type = HINIC3_CMD_TYPE_DIRECT_RESP;
> > +	cmd_info->done = &done;
> > +	cmd_info->errcode = &errcode;
> > +	cmd_info->direct_resp = out_param;
> > +	cmd_info->cmpt_code = &cmpt_code;
> > +	cmd_info->buf_in = buf_in;
> > +	saved_cmd_info = *cmd_info;
> > +	cmdq_set_lcmd_wqe(&wqe, CMDQ_CMD_DIRECT_RESP, buf_in, NULL,
> > +			  wrapped, mod, cmd, curr_prod_idx);
> > +
> > +	cmdq_wqe_fill(curr_wqe, &wqe);
> > +	(cmd_info->cmdq_msg_id)++;
> > +	curr_msg_id = cmd_info->cmdq_msg_id;
> > +	cmdq_set_db(cmdq, HINIC3_CMDQ_SYNC, next_prod_idx);
> > +	spin_unlock_bh(&cmdq->cmdq_lock);
> > +
> > +	err = wait_cmdq_sync_cmd_completion(cmdq, cmd_info, &saved_cmd_info,
> > +					    curr_msg_id, curr_prod_idx,
> > +					    curr_wqe, CMDQ_CMD_TIMEOUT);
> > +	if (err) {
> > +		dev_err(cmdq->hwdev->dev,
> > +			"Cmdq sync command timeout, mod: %u, cmd: %u, prod idx: 0x%x\n",
> > +			mod, cmd, curr_prod_idx);
> > +		err = -ETIMEDOUT;
> > +	}
> > +
> > +	if (cmpt_code == CMDQ_FORCE_STOP_CMPT_CODE) {
> > +		dev_dbg(cmdq->hwdev->dev,
> > +			"Force stop cmdq cmd, mod: %u, cmd: %u\n", mod, cmd);
> > +		err = -EAGAIN;
> > +	}
> > +
> > +	smp_rmb(); /* read error code after completion */
>
> Isn't the errcode updated under the spinlock protection? Why is this
> barrier neeed?

"spin_unlock_bh(&cmdq->cmdq_lock)" is executed before the errcode assignment.
So the errcode is updated out of the spinlock protection and we need this barrier. 

