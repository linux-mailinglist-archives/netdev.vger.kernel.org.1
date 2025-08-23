Return-Path: <netdev+bounces-216215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9706EB32975
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEE01BC5F62
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0811DF756;
	Sat, 23 Aug 2025 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pIgnAKOy"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D684039
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755961367; cv=none; b=aK4t2+wBM5Ae1XBVW2j+qvHPiCdbr8/AZtt8kAT1WFD3LsxYoMGKqbU8/ET/eFhAAaV7JqP20fjQbL3d0BbkVvh+mY43bCb35ZXxHFVU1E09Sg3hn7nLccpJ4u0z1lSY949ZBbSICDY/OsIC8y5+V4cwFIjhEoFdMKWw1/pzqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755961367; c=relaxed/simple;
	bh=xIrTtpPP0rtR+68l/jhIDZ4hMaDCztMe8DbENOHYhfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LurOZxbxKeBjKz9E2SnB4g/b6XP7SKO0zcoJSKwHLlhUb7mavDJes871EqEnl9SBrpwIYvrRB7BYJ+9R521yLPRbcAeXfa+r2fzRs/sC4siObfuuPXR2SII/48FvqkMZ3Aq2+lQhHhRtGDZLFLClpKEBO/CfkXrwSi27klWfNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pIgnAKOy; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <29475ad1-125a-4b20-bff3-0a61b347985e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755961361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98e0EaNU2IJkh6MZS8syX0f5r0K6q1x7ml/S2ZP2hzQ=;
	b=pIgnAKOyYiunv+qODKNf7+/4ttzqT1uEP/E2ulJSp9HGcXSlkp5T0mRuEioggvGy9ZZXss
	C1pR7/F9CNTw9aPUDEPk7xOGB4r35T88Malq2uLxd5rhpkdMqOL0sg3ZKQEIRYkoqurt00
	O1MzTSXwfS7PIkP5O0Q/4vUzV/vw2n4=
Date: Sat, 23 Aug 2025 16:02:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250822023453.1910972-5-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/08/2025 03:34, Dong Yibo wrote:
> Initialize basic mbx_fw ops, such as get_capability, reset phy
> and so on.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

[...]

> +/**
> + * mucse_mbx_fw_post_req - Posts a mbx req to firmware and wait reply
> + * @hw: pointer to the HW structure
> + * @req: pointer to the cmd req structure
> + * @cookie: pointer to the req cookie
> + *
> + * mucse_mbx_fw_post_req posts a mbx req to firmware and wait for the
> + * reply. cookie->wait will be set in irq handler.
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
> +				 struct mbx_fw_cmd_req *req,
> +				 struct mbx_req_cookie *cookie)
> +{
> +	int len = le16_to_cpu(req->datalen);
> +	int err;
> +
> +	cookie->errcode = 0;
> +	cookie->done = 0;
> +	init_waitqueue_head(&cookie->wait);
> +	err = mutex_lock_interruptible(&hw->mbx.lock);
> +	if (err)
> +		return err;
> +	err = mucse_write_mbx_pf(hw, (u32 *)req, len);
> +	if (err)
> +		goto out;
> +	/* if write succeeds, we must wait for firmware response or
> +	 * timeout to avoid using the already freed cookie->wait
> +	 */
> +	err = wait_event_timeout(cookie->wait,
> +				 cookie->done == 1,
> +				 cookie->timeout_jiffies);
> +
> +	if (!err)
> +		err = -ETIMEDOUT;
> +	else
> +		err = 0;
> +	if (!err && cookie->errcode)
> +		err = cookie->errcode;

can cookie->errcode be non 0 if FW times out?


looks like this can be simplified to

if(!wait_event_timeout())
   err = -ETIMEDOUT
else
   err = cookie->errcode

> +out:
> +	mutex_unlock(&hw->mbx.lock);
> +	return err;
> +}
> +
> +/**
> + * build_ifinsmod - build req with insmod opcode
> + * @req: pointer to the cmd req structure
> + * @status: true for insmod, false for rmmod

naming is misleading here, I believe.. no strong feeling, but
is_insmod might be better

> + **/
> +static void build_ifinsmod(struct mbx_fw_cmd_req *req,
> +			   int status)
> +{
> +	req->flags = 0;
> +	req->opcode = cpu_to_le16(DRIVER_INSMOD);
> +	req->datalen = cpu_to_le16(sizeof(req->ifinsmod) +
> +				   MBX_REQ_HDR_LEN);
> +	req->cookie = NULL;
> +	req->reply_lo = 0;
> +	req->reply_hi = 0;
> +#define FIXED_VERSION 0xFFFFFFFF
> +	req->ifinsmod.version = cpu_to_le32(FIXED_VERSION);
> +	req->ifinsmod.status = cpu_to_le32(status);
> +}
> +
> +/**
> + * mucse_mbx_ifinsmod - Echo driver insmod status to hw
> + * @hw: pointer to the HW structure
> + * @status: true for insmod, false for rmmod

here as well

> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status)
> +{
> +	struct mbx_fw_cmd_req req = {};
> +	int len;
> +	int err;
> +
> +	build_ifinsmod(&req, status);
> +	len = le16_to_cpu(req.datalen);
> +	err = mutex_lock_interruptible(&hw->mbx.lock);
> +	if (err)
> +		return err;
> +
> +	if (status) {
> +		err = mucse_write_posted_mbx(hw, (u32 *)&req,
> +					     len);
> +	} else {
> +		err = mucse_write_mbx_pf(hw, (u32 *)&req,
> +					 len);
> +	}
> +
> +	mutex_unlock(&hw->mbx.lock);
> +	return err;
> +}

