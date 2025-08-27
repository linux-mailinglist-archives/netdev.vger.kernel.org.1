Return-Path: <netdev+bounces-217164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F516B37A6D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED0A1B23D4E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE86275B0E;
	Wed, 27 Aug 2025 06:34:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF61EEF9;
	Wed, 27 Aug 2025 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276456; cv=none; b=p+Brz3ewcVSJIggBUT5OKFH0/2Ag8FzezdwrfDcFRurq2nd8JLwzRXzBiMgzS/3yZAd1tbEd1rhe8KwMtYHnEdZzZu0wLr7CSr4QGiOCtfbVqxPvBmrkr4IIdUNsBvwz/vQcEETyy5teiNctF8TNDITRW3bp8DgNwRZu4ssPIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276456; c=relaxed/simple;
	bh=08Bdfu7Abb5AyaLDYLBrHXSveiS/oZksGtOGJHCmkk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrGRfuhoKo4vJLF0FmwHwJO+knwalCR7XF23flEIkRL6i0RLFX9aVtvNcd17ycmYhL+pWc/mQD5bqv6Mcneece8OMg516TO9bHcW80HL3vK0kO1jYimhxuqZNGGtQSIjsOHyWq8/jB2HCRBRHxfiEu0eenKZ0xatPs0mz3TnCr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz3t1756276443te96eac14
X-QQ-Originating-IP: z93O1aUXQO9wJtNI9JgSSX/YEPfi2+9tuQMK75xB46U=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Aug 2025 14:34:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17250008978444675294
Date: Wed, 27 Aug 2025 14:34:01 +0800
From: Yibo Dong <dong100@mucse.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v8 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <4E0FB703028E42A8+20250827063401.GA504899@nic-Precision-5820-Tower>
References: <20250827034509.501980-1-dong100@mucse.com>
 <20250827034509.501980-5-dong100@mucse.com>
 <4b6eb676-10f5-4438-9457-6aeda0ee7fb0@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b6eb676-10f5-4438-9457-6aeda0ee7fb0@infradead.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ORqNQdnYjakC0GymvZaT7wSRhIi1hzcMqJ3OYYj+gj4GsX77VOLGWp48
	dGRpeSGHKgEK5z9Hy5HXCY58NBa74URD4BN5x6/gse3Rb7ADjevC+kCKIAodB4cRSmpmPqK
	2Rtsbt3n98XeM3WNuCZSIaxwJuupE7081p7XRlh55KlaOiERDDtxwJqGtGiFt1LAy1UvF/v
	nm6eCYKXAdlROy4GhlVswM2AxLO22wGXwhitGONrgEq1NRydAWJJKkmSKg1jEEG08bn/oIS
	zFVgXw+xhAYd9COuZ+oRUtioe9RqXAuYhzcHZvMq/Z9yFGj5d0PlIQjsJqStfdOwMMgsNZX
	K86NhzhAE5g71hLCWthslSz9A5Vt37B+/++F/xmNzfwgGeSzy9f1vHgYJYIx5VieRZkwQ9Y
	paSr4//YXp45OtyBGFMWZ9l86KAI++9LqpUGSSSBUysBfVbvuZLnqD8Bsgc8pX1bFi2NtY6
	x8MoXHdRay/jZOCzlDRosyka2akuyu8DvRCuFb+KoozvEgkPJRiDTopSQuw2l6aZdHCFYSF
	BP9M2niaMeFuUq3bnacaI6l8HAc6UpRAnaiVXKDnXdz+zNcwLOj1kd09iz/mPUR/FkiCTfp
	eFdcPpJ+71vnsjgzM7F2MoSXurU8HOGra4M6Ne3EKQECTh9DqL3Pn93/E7VTmj2ENDg/pSM
	lvOpJcMt3bAc2xGXkDyUGmBE5K2jiSb7kql9gCQT/pg1s8mgy8BhPQHot6bWIQrsoXu+ZCP
	4/uBApBfSAtPuyyGVtggY8S3Zo3ESvvBqbQF3uThdWWN96DyDr+url2H0gRmqou/34EahIv
	vDCCyMjFqt4E5HxfSU2yYkIqMUC8KM3/lzI8Q4LnaZfb+4cJ/ivDXh+x3zarxjW3v6FZWn0
	RqTa6Ut5kXA+Ex+eL5/+pXiK7hignroVPCJqa9BKcSkksaUKFITlP6cbmq3GXAafGPGPuDc
	3v/dnOWz0ehS00gV/OMo02PW8XvREtiNTD6dxjQMAKWoRxH8bKI/ArCkitGqq0BOJzVK3VX
	Z8kgfcmw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Tue, Aug 26, 2025 at 10:26:38PM -0700, Randy Dunlap wrote:
> On 8/26/25 8:45 PM, Dong Yibo wrote:
> > Initialize basic mbx_fw ops, such as get_capability, reset phy
> > and so on.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   1 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 253 ++++++++++++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 126 +++++++++
> >  4 files changed, 382 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
> > 
> 
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> > new file mode 100644
> > index 000000000000..d3b323760708
> > --- /dev/null
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> > @@ -0,0 +1,253 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > +
> > +#include <linux/pci.h>
> > +#include <linux/if_ether.h>
> > +
> > +#include "rnpgbe.h"
> > +#include "rnpgbe_hw.h"
> > +#include "rnpgbe_mbx.h"
> > +#include "rnpgbe_mbx_fw.h"
> > +
> > +/**
> > + * mucse_fw_send_cmd_wait - Send cmd req and wait for response
> > + * @hw: pointer to the HW structure
> > + * @req: pointer to the cmd req structure
> > + * @reply: pointer to the fw reply structure
> > + *
> > + * mucse_fw_send_cmd_wait sends req to pf-fw mailbox and wait
> > + * reply from fw.
> > + *
> > + * @return: 0 on success, negative on failure
> 
> Use of @return: is not a documented feature although kernel-doc does accept it.
> I prefer that people don't use it, but I can't insist since it does work.
> 
> 

Maybe change it like this?
Return: 0 on success, negative errno on failure

> > + **/
> > +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> > +				  struct mbx_fw_cmd_req *req,
> > +				  struct mbx_fw_cmd_reply *reply)
> > +{
> > +	int len = le16_to_cpu(req->datalen);
> > +	int retry_cnt = 3;
> > +	int err;
> > +
> > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > +	if (err)
> > +		return err;
> > +	err = mucse_write_posted_mbx(hw, (u32 *)req, len);
> > +	if (err)
> > +		goto out;
> > +	do {
> > +		err = mucse_read_posted_mbx(hw, (u32 *)reply,
> > +					    sizeof(*reply));
> > +		if (err)
> > +			goto out;
> > +		/* mucse_write_posted_mbx return 0 means fw has
> > +		 * received request, wait for the expect opcode
> > +		 * reply with 'retry_cnt' times.
> > +		 */
> > +	} while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> > +out:
> > +	mutex_unlock(&hw->mbx.lock);
> > +	if (!err && retry_cnt < 0)
> > +		return -ETIMEDOUT;
> > +	if (!err && reply->error_code)
> > +		return -EIO;
> > +	return err;
> > +}
> 
> 
> [snip]
> 
> > +
> > +/**
> > + * mucse_fw_get_capability - Get hw abilities from fw
> > + * @hw: pointer to the HW structure
> > + * @abil: pointer to the hw_abilities structure
> > + *
> > + * mucse_fw_get_capability tries to get hw abilities from
> > + * hw.
> > + *
> > + * @return: 0 on success, negative on failure
> 
> negative errno or just some negative number?
> 

errno, -EINTR, -EIO, -ETIMEDOUT
Maybe update it like this?

Return: 0 on success, negative errno on failure

> > + **/
> > +static int mucse_fw_get_capability(struct mucse_hw *hw,
> > +				   struct hw_abilities *abil)
> > +{
> > +	struct mbx_fw_cmd_reply reply = {};
> > +	struct mbx_fw_cmd_req req = {};
> > +	int err;
> > +
> > +	build_phy_abilities_req(&req);
> > +	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
> > +	if (!err)
> > +		memcpy(abil, &reply.hw_abilities, sizeof(*abil));
> > +	return err;
> > +}
> 
> -- 
> ~Randy
> 
> 

Thanks for your feedback.


