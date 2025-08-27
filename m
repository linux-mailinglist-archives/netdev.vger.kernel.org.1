Return-Path: <netdev+bounces-217130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D24B37747
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4912D8E0286
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C18E1F582A;
	Wed, 27 Aug 2025 01:42:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1600530CD95;
	Wed, 27 Aug 2025 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258962; cv=none; b=ibktkUvPc6kEtpLJTo8FWLSLp4bkbE+5uCUkSQU4Pgy+ZD1aq82GGWb/o65V23D7x+ZlFyBwtH5NAIsUa3zlRNCr/44+dgs5KVNJjzMtkqEW6D8mdtScmmYuaIb4T5Rx/Zfjl+YMDNui5HiMjQpobxgXFma96lgOV5VJfSUvGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258962; c=relaxed/simple;
	bh=uH2VFSJMyCnSLjpcnGx56opsnpfl5naJHZ3WXF5SFAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWEEeKqu/8RgS81NY3rFwGip0t4pkXeSesXxllCRwCjp1rr9WLER5gJO/56qzNgi0SyJwNzPjiFrds+SwiiRxtvEocEcAmgl77vds/Iigpg/vLOph3g3CwZHkhn0pr/U0q/pCfGzTHHoDbnJfU2ms+38Uu8E9M2zNDLsfxj55Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz20t1756258933t53080512
X-QQ-Originating-IP: 1lOMaAuA9nfuwe2FeABSvz6MykdgCUNe1qBMkBQJ4Vg=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Aug 2025 09:42:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10885226712742933272
Date: Wed, 27 Aug 2025 09:42:11 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <05B2D818DB1348E6+20250827014211.GA469112@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <316f57e3-5953-4db6-84aa-df9278461d30@linux.dev>
 <82E3BE49DB4195F0+20250826013113.GA6582@nic-Precision-5820-Tower>
 <bbdabd48-61c0-46f9-bf33-c49d6d27ffb0@linux.dev>
 <8C1007761115185D+20250826110539.GA461663@nic-Precision-5820-Tower>
 <bd1d77b2-c218-4dce-bbf6-1cbdecabb30b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1d77b2-c218-4dce-bbf6-1cbdecabb30b@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MNsLylogNlqc6nEp4WVIUhq56of8guHz52MSHB8r89kVkvD5Sqrq9HQD
	7V1CMGDOCVUhFU4MNcBTcz4D+A+5nJmGIiU/HOh+0o3A1KzX6gRwhbARZJ9Jh7jPegIH80M
	xqRrxn840BbUOJBXhtaDbLpb3OtHqi/3rqpP+7vM7h9DPb+BGHAaEcij6/VQzDjBjLahzWr
	SukMm0WfpCrbPOlSq/8BWYA45jhx/rqSTxYB6MPh38iqKSc8g3uHkxQJyuZcRO7oyEp7glv
	MtU07FrRXgTgUXDIjOYWkjTFw0bpCM8NibLSehKerqXOAj1oBsz3p37B0NjJuJ7a8LKDkKZ
	YROF59AsqPduzBBYpgjakUOt3l5nSV+1Z8yg+7PxaIaDVBhiL4HN+lvsvNU+WEteW1/P1ng
	x/WfoUqt1CzhPjzyTZLmuXij5WIj5aQu+yGW4dLzjHJ3IGF4fdsrsh+w0cy1Xul9mfyxq+u
	YmmnMFZysLpccjPKVt8/qU6omzGArZXpnHmF7eBsh2JDUmJGXW7YBGZQUzIL7B1kVVWrGfz
	7fFQPPseO8huV2WchoUM2MMWRVFEH9GvZP4dWnCztZRAcQumInWnFn7pFAPNQYrHupKkvs/
	Tzh3D2jVcfI9DwobeFgv5+8SqmGcDeBqnvRhxhe07dvA+PzxCp8IDvb8E9xNUV8aVd3LoHm
	sjsSQYbI84wGqSL0eLHEjEdvzS6iNCYDYM47uJHTIhLUVR/zU/3TOwB4Om9RVYOODYEnz6D
	pad7SxviHVzTwDKSQWqjaDX8/oH31wcjdPsp7Fd0ItmwBL9JVuxgp//Vu9BfGGzAG8rvX45
	8sTj05502IWdtL1fxgFFMgRVlL8a5dUmrHmu5wT3BtKdCB+ustkp3vj+Eg347yh8igVV0G8
	gPPCziKvbdWVZRgFygVMji6gqm0Hf/RkSE/dDtXuRjODqzKgwoyCgbVfcbyc7xedNiH37Pp
	Ffqyzbeto8fzam3t714l2BYyLBIHDq7zDkvpwWa/XeWEUNlJFL7OcjvE/
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Tue, Aug 26, 2025 at 02:39:07PM +0200, Andrew Lunn wrote:
> > Yes. It is not safe, so I 'must wait_event_timeout before free cookie'....
> > But is there a safe way to do it?
> > Maybe:
> > ->allocate cookie
> >   -> map it to an unique id
> >     ->set the id to req->cookie
> >       ->receive response and check id valid? Then access cookie?
> 
> This is part of why adding cookies in a separate patch with a good
> commit message is important.
> 
> Please take a step back. What is the big picture? Why do you need a
> cookie? What is it used for? If you describe what your requirements
> are, we might be able to suggest a better solution, or point you at a
> driver you can copy code from.
> 
> 	Andrew
> 

I try to explain the it:

driver-->fw, we has two types request:
1. without response, such as mucse_mbx_ifinsmod
2. with response, such as mucse_fw_get_macaddr

fw --> driver, we has one types request:
1. link status (link speed, duplex, pause status...)

fw tiggers irq when it sends response or request.
In order to handle link status timely, we do an irqhandle like this:

static int rnpgbe_rcv_msg_from_fw(struct mucse *mucse)
{
        u32 msgbuf[MUCSE_FW_MAILBOX_WORDS];
        struct mucse_hw *hw = &mucse->hw;
        struct mbx_fw_cmd_reply *reply;
        int retval;
	/* read mbx data out */
        retval = mucse_read_mbx(hw, msgbuf, MUCSE_FW_MAILBOX_WORDS);
        if (retval)
                return retval;

        reply = (struct mbx_fw_cmd_reply *)msgbuf;
	/* judge request or response */
        if (le16_to_cpu(reply->flags) & FLAGS_DD) {
		/* if it is a response, call wake_up(cookie) */
                return rnpgbe_mbx_fw_reply_handler(mucse,
                                (struct mbx_fw_cmd_reply *)msgbuf);
        } else {
		/* if it is a request, handle link status */
                return rnpgbe_mbx_fw_req_handler(mucse,
                                (struct mbx_fw_cmd_req *)msgbuf);
        }
}

And driver requests with response is bellow 'without' irqhandle:

static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
				  struct mbx_fw_cmd_req *req,
				  struct mbx_fw_cmd_reply *reply)
{
...
	mucse_write_posted_mbx(hw, (u32 *)req, len);

	...
	/* but as irqhandle be added, mbx data is read out in the
	 * handler, mucse_read_posted_mbx cannot read anything */
	mucse_read_posted_mbx(hw, (u32 *)reply, sizeof(*reply));

}

To solve mucse_read_posted_mbx cannot read data with irq, we add 'cookie'.
After mucse_write_posted_mbx, call wait_event_timeout. wake_up is called
in irqhandle.

Thanks for your feedback.


