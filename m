Return-Path: <netdev+bounces-213347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913C4B24AA3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A34E3B100D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A654D2EA156;
	Wed, 13 Aug 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GjLjiH8l"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3402E8DEC
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092035; cv=none; b=teM6LdsaRL3Av8SflcFI2ST/mHSTw9cWm7fSTS6372YzmlsBaHiP5zIjRFM6AOxuiBzKOkwImsn3UuxQte6s//dh7FXhPnQIioamJdBzFkeLlEMkrI2e/OEwaqq87wrgAXO6JmfwmZuRdksxUyzBX8KN2LFD1EVBe6j8TxvseQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092035; c=relaxed/simple;
	bh=RZ4mnwVlRbDPvOCejubqWmrOp20r8CBvEyimsVYww/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHprTiqHPSWRkw0JSrzZOgsLRU/kAzPaKdkUguO3mhjvgBsiYWce3oJLqKQPK2L0YTd0UGTtZqf2TU6lGIIDY4S8/KtlIHwHqqlLuNj9UsoOlYTLHOAk0/LKq/oBOkw5RV5MzBu8s7tHqE7MFqafMgwmhY/Gpz22z/LgWDr0PX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GjLjiH8l; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ef60880-f85d-4a1a-b50c-9ea73fee70b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755092031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHfW8g/rsB+5dU0XiMHu3ntmBzwmOgGngFO55tJbn64=;
	b=GjLjiH8lFRKkFDgNoo0yJ1J4+6AOlh8sU246QMwRbkqXNGC8gbgj7I6epD8WEmEbWRyLYV
	EO/7I2rsXp4glRWLurgPr0/NVnvTUxvGfYJdS/X/Utd8ks2sNFT11dbUg8zwKmhw4El5iY
	BsMCyHDbbYTc8aQKnMpCdDpuSzDWP2s=
Date: Wed, 13 Aug 2025 14:33:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
 geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
 lukas.bulwahn@redhat.com, alexanderduyck@fb.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-5-dong100@mucse.com>
 <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
 <9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/08/2025 10:52, Yibo Dong wrote:
> On Tue, Aug 12, 2025 at 05:14:15PM +0100, Vadim Fedorenko wrote:
>> On 12/08/2025 10:39, Dong Yibo wrote:
>>> Initialize basic mbx_fw ops, such as get_capability, reset phy
>>> and so on.
>>>
>>> Signed-off-by: Dong Yibo <dong100@mucse.com>
>>> +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
>>> +				  struct mbx_fw_cmd_req *req,
>>> +				  struct mbx_fw_cmd_reply *reply)
>>> +{
>>> +	int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
>>> +	int retry_cnt = 3;
>>> +	int err;
>>> +
>>> +	err = mutex_lock_interruptible(&hw->mbx.lock);
>>> +	if (err)
>>> +		return err;
>>> +	err = hw->mbx.ops->write_posted(hw, (u32 *)req,
>>> +					L_WD(len));
>>> +	if (err) {> +		mutex_unlock(&hw->mbx.lock);
>>> +		return err;
>>> +	}
>>
>> it might look a bit cleaner if you add error label and have unlock code
>> once in the end of the function...
>>
> 
> If it is more cleaner bellow?
> 
> static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
>                                    struct mbx_fw_cmd_req *req,
>                                    struct mbx_fw_cmd_reply *reply)
> {
>          int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
>          int retry_cnt = 3;
>          int err;
> 
>          err = mutex_lock_interruptible(&hw->mbx.lock);
>          if (err)
>                  return err;
>          err = hw->mbx.ops->write_posted(hw, (u32 *)req,
>                                          L_WD(len));
>          if (err)
>                  goto quit;
>          do {
>                  err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
>                                                 L_WD(sizeof(*reply)));
>                  if (err)
>                          goto quit;
>          } while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> 
>          mutex_unlock(&hw->mbx.lock);
>          if (retry_cnt < 0)
>                  return -ETIMEDOUT;
>          if (reply->error_code)
>                  return -EIO;
>          return 0;
> quit:
>          mutex_unlock(&hw->mbx.lock);
>          return err;
> }
> 

Maybe:

           } while (--retry_cnt >= 0 && reply->opcode != req->opcode);

  quit:
           mutex_unlock(&hw->mbx.lock);
           if (!err && retry_cnt < 0)
                   return -ETIMEDOUT;
           if (!err && reply->error_code)
                   return -EIO;
           return err;


looks cleaner


