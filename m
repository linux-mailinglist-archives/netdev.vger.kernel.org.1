Return-Path: <netdev+bounces-213919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132D9B274CB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29203BAB4B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9D2561B6;
	Fri, 15 Aug 2025 01:37:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45059475;
	Fri, 15 Aug 2025 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221831; cv=none; b=dayBGlvyZ0Ul8PkpHTHWpzv8lujUlmOogwiGXoJROjH0NMerd/VvG7bxyf3iBnrMFuw9IdSt9y8dcbJffH99Kkwhai69K9P6OyQm27Bozvti7u6QM0gp6hAnO7M1/xZCxJIgdjbtPlTmGELxzZnjDT5kmrmCkRxAKvn2Q/VYbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221831; c=relaxed/simple;
	bh=W49tmC8pMPCmtFcn3qEiXKG1KBDWgCmX4g9K7vu18jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXHnVtr2x66xRXniUM44WG9xWEr8E2Fbny/7Ueu/cg9qlTbt9kmfjdd9g9KpqfV1vrB3nqGZnrfNRrDDa9TasmXAjK8NRZygYIbt3+33SAEubpg5J0kQ3AbZf6WO1VF2l5CpVPcApqbjsgr7zQcxb9MbTEmMjEm567xCzFffhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz8t1755221820tf5699c30
X-QQ-Originating-IP: tlNQ7+NHEjaXcRky/Tvj9nySe0eW04M+BZV9Y0tdcD4=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 09:36:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9320296151560598808
Date: Fri, 15 Aug 2025 09:36:58 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <AC9522804BA5F115+20250815013658.GB1129045@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-5-dong100@mucse.com>
 <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
 <9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>
 <9af5710c-e465-4e21-8705-4698e544c649@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af5710c-e465-4e21-8705-4698e544c649@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mf2c2cXG8XEiQMetGMQwjHFRz3d1mTlEqgChonH+LMVTfGtqcMKhYJqA
	RfFeG5nC/kUqDkIIFcRU+8FBjJqqNUowxQ4x6nJMS+GKncHBLlyD6eVVQkkQIkK0GxU9Vqp
	YUB+lADqqGLInqT8xu/8RODmrJN/kIe0DJz6ASzz9hcLd99u1S7WQNIQBXAdPCvmykt3wRK
	F4dmqDbfzK8Sj+L+l94DowLlBnpocPKZM7Jd4wTbO3r3q+XMAafy2zifucHMZ9MV3rkSrQn
	KQ3MzLujzXI/U47WlN6nPU6GCekCAMvWdRGzDD4KQrIjzYkJQr07zd2ZlFBzcLx4mWI2D2X
	cW6EfY4JK2mSu8K10lUmFC4epMgiMMS3ASTTP7oLpRY1QqKI6l5kG9TyRQps3bMg90NA9AY
	68XBA7ug2snJmHe5IOdawqXS0tKd6HLmLIPtspcEBEtyuXit0OKwTRMck9kiAiHnE2gvgOq
	Lty+g5RlcIuA2p+bBD6X2HS6RKWTfTi6Q6jMZTW+tqQaxEZSKlKueFb8W8tQJjtiLCSpC25
	fxzoC2BKxOzPWSL/lSl1HpjvBkVlqk6YtBEqGFTRjRXq80Pa36Z/LhMKEtjUIhvAKES+wmR
	AXzQddM43v0rYROWfaFGFayBecNQHSaz5xGvCuK/tQvwDKp1/hIncGsqFoRNH8vVBjV5seA
	wEllzqwKmq5k1erp6atEnb8QCX5+ijzT2kUzBhYerRhLQFTmN03ptyDKuCXnrUCGIZlPw7H
	ZRN/oelfe7yEUok7zS9/zXusqf8aaEgwTqxNmt6JQ0iaTM5lrpvMVtccbvjr4slqBqHIp9o
	Q3WB+4zEiG7fPETQNcrShZqEcxZt5XM3C00LSz57qWQ5+zEcp2jWzbEJruXsdTtQ1fXFRWe
	yccW0KRdJwpTTGAtmuSslwU6a9XxFOrnuQOx+yjzATYTqR3nCl5nhKkOtJMr8X9wX/PbIXw
	viDJ+gdphOr7epFFNI4l/qUbGc2GouJJUXIOOctK9r8S9dA5R/GG622FQ/Q1Yv0HmTE3Gmf
	sSTYqNJ83DEgw5vj6t
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 02:04:57AM +0200, Andrew Lunn wrote:
> > If it is more cleaner bellow?
> > 
> > static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> >                                   struct mbx_fw_cmd_req *req,
> >                                   struct mbx_fw_cmd_reply *reply)
> > {
> >         int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> >         int retry_cnt = 3;
> >         int err;
> > 
> >         err = mutex_lock_interruptible(&hw->mbx.lock);
> >         if (err)
> >                 return err;
> >         err = hw->mbx.ops->write_posted(hw, (u32 *)req,
> >                                         L_WD(len));
> >         if (err)
> >                 goto quit;
> >         do {
> >                 err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
> >                                                L_WD(sizeof(*reply)));
> >                 if (err)
> >                         goto quit;
> >         } while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> > 
> >         mutex_unlock(&hw->mbx.lock);
> >         if (retry_cnt < 0)
> >                 return -ETIMEDOUT;
> >         if (reply->error_code)
> >                 return -EIO;
> >         return 0;
> > quit:
> >         mutex_unlock(&hw->mbx.lock);
> >         return err;
> > }
> 
> You might want a read a few other drivers in mailine. Look at the
> naming. I doubt you will find many using "quit" for a label. "out" or
> "unlock" is more popular.
> 
> When it comes to locks, it is better to have one lock statement and
> one unlock statement. It then becomes easy to see all paths lead to
> the unlock.
> 
> 	Andrew
> 

Got it, I will change label 'quit' to 'out'.
And I will try to keep 'one lock statement and one unlock statement'
principle in mind.

Thanks for your feedback.


