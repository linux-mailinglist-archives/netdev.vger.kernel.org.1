Return-Path: <netdev+bounces-216554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7BAB347AD
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A855F3B7294
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5374B10E0;
	Mon, 25 Aug 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AXjDp+G6"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3163301007
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139886; cv=none; b=EYq21IzM+4H2EJSy6y2fCeIHCxbill9YFrr36b262bh/OvgXYujM4qctE09p1LjMbfCAxYN2KIIIewr9DY61kb1XoP0LIrwBe0+KiedjtwunoQ10mmSRBFnpec5rk3yxKkEiFn22vXydQpQd/CkAPPztAvk6iu3+OCfeZy2fhHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139886; c=relaxed/simple;
	bh=49R1XUoVprLMJDRl704H1HRBpYFddqWu0RvHcoPBUlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uD83HYRIrEEyyrPtHsDnz+HtOBoRYAhgHYVnE4CchAYL6etkR4EbPzEmz4B1s9v8SCb2PVGu+r4rOyDNegLGwb+JA5IzBS8OWwd7C5M+47aj6LhBRZT34HsJRFgse68tMWJZZhtRMZJ7fe6XFOch6eKcpyCcaJaLmyJbwK4Zf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AXjDp+G6; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <316f57e3-5953-4db6-84aa-df9278461d30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756139870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irO/0C7BR+axJtgXqBSOvuib9XTOGqEywKCWh0ZA8Ow=;
	b=AXjDp+G6ZFTa4wnUJLVDBSLiLa/JC3S7lCg+Dc/OUA1Xw/gXWpRaT+ZsqO86MNvaeyIRf3
	c3/7p59iH1LNGAPc8xfbTR7EyMzLYLYmrqkzG13zC6+QXd16PlYuMAABRIuIeELfBSResh
	Csb5N9uB9tfqnQniqPTBBYcvtTT7jSE=
Date: Mon, 25 Aug 2025 17:37:27 +0100
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

it's unclear to me, what part of the code is managing values of cookie
structure? I didn't get the reason why are you putting the address of
cookie structure into request which is then directly passed to the FW.
Is the FW supposed to change values in cookie?

> +
> +	if (!err)
> +		err = -ETIMEDOUT;
> +	else
> +		err = 0;
> +	if (!err && cookie->errcode)
> +		err = cookie->errcode;
> +out:
> +	mutex_unlock(&hw->mbx.lock);
> +	return err;
> +}

[...]

> +struct mbx_fw_cmd_req {
> +	__le16 flags;
> +	__le16 opcode;
> +	__le16 datalen;
> +	__le16 ret_value;
> +	union {
> +		struct {
> +			__le32 cookie_lo;
> +			__le32 cookie_hi;
> +		};
> +
> +		void *cookie;
> +	};
> +	__le32 reply_lo;
> +	__le32 reply_hi;

what do these 2 fields mean? are you going to provide reply's buffer
address directly to FW?

> +	union {
> +		u8 data[32];
> +		struct {
> +			__le32 version;
> +			__le32 status;
> +		} ifinsmod;
> +		struct {
> +			__le32 port_mask;
> +			__le32 pfvf_num;
> +		} get_mac_addr;
> +	};
> +} __packed;
> +
> +struct mbx_fw_cmd_reply {
> +	__le16 flags;
> +	__le16 opcode;
> +	__le16 error_code;
> +	__le16 datalen;
> +	union {
> +		struct {
> +			__le32 cookie_lo;
> +			__le32 cookie_hi;
> +		};
> +		void *cookie;
> +	};

This part looks like the request, apart from datalen and error_code are
swapped in the header. And it actually means that the FW will put back
the address of provided cookie into reply, right? If yes, then it
doesn't look correct at all...

> +	union {
> +		u8 data[40];
> +		struct mac_addr {
> +			__le32 ports;
> +			struct _addr {
> +				/* for macaddr:01:02:03:04:05:06
> +				 * mac-hi=0x01020304 mac-lo=0x05060000
> +				 */
> +				u8 mac[8];
> +			} addrs[4];
> +		} mac_addr;
> +		struct hw_abilities hw_abilities;
> +	};
> +} __packed;

