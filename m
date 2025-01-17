Return-Path: <netdev+bounces-159158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D91A14891
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 04:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE71E188CD9C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 03:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709F1E1A32;
	Fri, 17 Jan 2025 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="Gdl1/rQ2"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6746434
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737085361; cv=none; b=k8Ek0AfmsSxhSoBAU56EmQZC818fmp4L9nvCdx6VjDN1aIXK1YC+YLDko5cE7cfj7VFXSm9NZmWuaYxwfBzo7pTG4Al24N1WKQLuf550oyJLkFCRzE6kQKbXMQVaHBOe2ZDDvdKzo+rMYl4bKGoCpOYQlJjIdOjgkCqh0ti/Shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737085361; c=relaxed/simple;
	bh=wO8DGu/0x+gYYSv3LrEBtDt1xz5DnOMuMmoWURNZiH8=;
	h=Subject:Mime-Version:In-Reply-To:Cc:Content-Type:References:To:
	 From:Date:Message-Id; b=lmWIfl2Sdts2LD2gXUlAiCgFuCyEry752mPk91VlNGgGGU6oXKJwIQh8dc4NcySku6Q8XoxcL3b/U8m7gn2dDpN9i6KLH+ljVqqPgT9f9nLZcaUWMXcspzGfc7FRECBpXniiJUmDlFmDj/rqLEmBU9GP/QNRR1N/P5GsgS0Wtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=Gdl1/rQ2; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1737085347; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ENFCR1roiWXmv4jpmUiFnoi+I6YO0VmU4zCe29nZ/CE=;
 b=Gdl1/rQ2fRDH8EgVqvi01V9ZQecw366kpQCIxkCb5dr6Db9ykqxuGj+BAJeyiy7plZK+qh
 fFv4AJDNZ5r27/1cGsgw0f9AQUtzmVFR869Lg2fl88dj6f721O0nLKU0+hw7ocubYGAZeK
 aTurn+hyHjPjlUrKLRmyPgnomX9RmIIUiN5loYznk9KomGlfsor9qnWnaC69UhbYf7dPl4
 PSOXDM8ScrVVwaifG2BL96V3lHDqxvRY8R1n8mPyD7DVnLySdGv3/lFsNydrS8B3aPxL3e
 lOIj5R6p86sAaT428HXx71lv6agjRm1ncfRmOGMakCiK4bOn3aVJ3UAMDFY2KA==
Subject: Re: [PATCH v3 02/14] net-next/yunsilicon: Enable CMDQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26789d1a1+7594ff+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Received: from [127.0.0.1] ([218.1.137.133]) by smtp.feishu.cn with ESMTPS; Fri, 17 Jan 2025 11:42:23 +0800
In-Reply-To: <20250116135559.GB6206@kernel.org>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: tianx <tianx@yunsilicon.com>
References: <20250115102242.3541496-1-tianx@yunsilicon.com> <20250115102245.3541496-3-tianx@yunsilicon.com> <20250116135559.GB6206@kernel.org>
User-Agent: Mozilla Thunderbird
To: "Simon Horman" <horms@kernel.org>
From: "tianx" <tianx@yunsilicon.com>
Date: Fri, 17 Jan 2025 11:42:22 +0800
Message-Id: <0ed84d3f-9571-4bd9-831e-7aff64de3eb8@yunsilicon.com>

On 2025/1/16 21:55, Simon Horman wrote:
> On Wed, Jan 15, 2025 at 06:22:46PM +0800, Xin Tian wrote:
>> Enable cmd queue to support driver-firmware communication.
>> Hardware control will be performed through cmdq mostly.
>>
>> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
>> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
>> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
>> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> ...
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
> ...
>
>> +static void cmd_work_handler(struct work_struct *work)
>> +{
>> +	struct xsc_cmd_work_ent *ent = container_of(work, struct xsc_cmd_work_ent, work);
>> +	struct xsc_cmd *cmd = ent->cmd;
>> +	struct xsc_core_device *xdev = container_of(cmd, struct xsc_core_device, cmd);
>> +	struct xsc_cmd_layout *lay;
>> +	struct semaphore *sem;
>> +	unsigned long flags;
> Hi Xin Tian,
>
> Please consider arranging local variables in reverse xmas tree order -
> longest line to shortest - as is preferred in Networking code.
> Separating initialisation from declarations as needed.
>
> And also, please consider limiting lines to 80 columns wide or less,
> where it can be achieved without reducing readability. This is also
> preferred in Networking code.
>
> I think that in this case that both could be achieved like this
> (completely untested):
>
> 	struct xsc_cmd_work_ent *ent;
> 	struct xsc_core_device *xdev;
> 	struct xsc_cmd_layout *lay;
> 	struct semaphore *sem;
> 	struct xsc_cmd *cmd;
> 	unsigned long flags;
>
> 	ent = container_of(work, struct xsc_cmd_work_ent, work);
> 	cmd = ent->cmd;
> 	xdev = container_of(cmd, struct xsc_core_device, cmd);
>
> With regards to reverse xmas tree ordering, this tool can be useful:
> https://github.com/ecree-solarflare/xmastree
>
> ...
Thank you for the tool. I will address the same issue across the entire 
patch set.
>> +static void xsc_cmd_comp_handler(struct xsc_core_device *xdev, u8 idx, struct xsc_rsp_layout *rsp)
>> +{
>> +	struct xsc_cmd *cmd = &xdev->cmd;
>> +	struct xsc_cmd_work_ent *ent;
>> +	struct xsc_inbox_hdr *hdr;
>> +
>> +	if (idx > cmd->max_reg_cmds || (cmd->bitmask & (1 << idx))) {
>> +		pci_err(xdev->pdev, "idx[%d] exceed max cmds, or has no relative request.\n", idx);
>> +		return;
>> +	}
>> +	ent = cmd->ent_arr[idx];
>> +	ent->rsp_lay = rsp;
>> +	ktime_get_ts64(&ent->ts2);
>> +
>> +	memcpy(ent->out->first.data, ent->rsp_lay->out, sizeof(ent->rsp_lay->out));
>> +	if (!cmd->checksum_disabled)
>> +		ent->ret = verify_signature(ent);
>> +	else
>> +		ent->ret = 0;
>> +	ent->status = 0;
>> +
>> +	hdr = (struct xsc_inbox_hdr *)ent->in->first.data;
> nit: hdr is set but otherwise unused in this function.
>       Perhaps it can be removed (and added in a later patch if needed there)?
>
>       Flagged by W=1 builds.
Ack, will remove.
>> +	free_ent(cmd, ent->idx);
>> +	complete(&ent->done);
>> +	up(&cmd->sem);
>> +}
> ...

