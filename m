Return-Path: <netdev+bounces-216879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6315DB35AB6
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4F67AC52D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E97F286881;
	Tue, 26 Aug 2025 11:06:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC053227599;
	Tue, 26 Aug 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206365; cv=none; b=O9lShujttBI2gKPQQaACZmr1lw/C6wq652ROiL8d1BSv0c+t1/ZUMoqweimwILr9KIw51oJTZULTyBZM9+iWvtBPNr8IBR6fYtFwW2sXf7M8kd/IuDbwuNtSSyEx+LiCCtViVuvSIiDFZty85vkmi6QT+qmPVVzuCUE7zNoXHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206365; c=relaxed/simple;
	bh=puUDhC4W4Gr0+K/N7lGMbyHwNybWPdiZJ8MsvVpgv/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh9KuxWzQiIXMMQsU/uLoqaRV9i6Z4JrrUiLcPJF8SJ53sCDTDkLnXjkJlnjxpVjSosZV4HHxbCRcrc+lte8AKAxbKTiGwHZCgtaX5ZsxbsYVXWe0sjjZ0eV2ZUCR2PrLl1y6HQN7lmKSVFPGX7z7s8py+2ZZT6ez+kSd7NJR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz13t1756206342t345aa432
X-QQ-Originating-IP: N2q7GcQAvwDoHq1fe0d0NqiL+NXhfi6yxI3W5XwgU2g=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 Aug 2025 19:05:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3791947949160299687
Date: Tue, 26 Aug 2025 19:05:39 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
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
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <8C1007761115185D+20250826110539.GA461663@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <316f57e3-5953-4db6-84aa-df9278461d30@linux.dev>
 <82E3BE49DB4195F0+20250826013113.GA6582@nic-Precision-5820-Tower>
 <bbdabd48-61c0-46f9-bf33-c49d6d27ffb0@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbdabd48-61c0-46f9-bf33-c49d6d27ffb0@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mf+wQkWJ2TuYoRAc945Q+9sC8ifU9Hx1TRauavHXeevaF+iEinTCc6pI
	T+avn7OfwJyA74dE7RJakJ5Kk6T0BC8IfB+FPUY8w8mILtnB6V6zQgLFFQq2170myFTgJZy
	qVIfKT4Miu22IGKqh233zAwsR2LAT1vHsSsLjVTgFYbJK/TziJZodeEFQeN0RAvJup/yYT9
	bhe8okRPkPR/jA4Z9bv0jNXf2oTTXYyzGVRgOQwdZv94CqtH9zMTE0U77XGirQStWQvaJ4+
	yOGjaO+VJFTu9pvH7TTiiUzZKNd4PB36WW/yPemcPN/BzQY2WiXrJYq910+U8Oby6AqIf7E
	BSFaSZuf9yKGPL89o7jO9XE4cWsyESNIsDMUqfDzB4tHJdr5g+tHME87XbUrqors7Uk5cbQ
	jXZfOBkrMuij0v+1JaCRMcPW/U9H/JShDmf+jMTP3gEtfe1wBUqAwjf/7C9zF6lqD1JJxlV
	basLrJ3+3kKuBsY7IpnrRs2xRQ/YaYbqEWRSzjN7In1XrOeXPv516QTXOFaZV+2oGJEDRce
	87C6Ned7XDMgegzfTbAUj/eMoJ6GrEo4d8ZzIqdnhwugimO7tns9irSgvi13DTU6dPwxDy6
	kkXnjJWzAcuEAQRvHsIXCTrRiUbftKufneSq3AbqOdtiLGQIiBCcdQkzOcrwjXSwZTy0/yW
	of+eXnx852asUoIKky0nCHN6voVrc85vo72CoUbBnmraA5ksRN46P6sPnzi4kDEjdfZnj80
	GvmbYOtiAC1rtsNoRq9GzPmlhDMD0cICCRWvSUI890ejARs32xbGgwxsc0n7Bph2IVFXNXq
	8bHMXZ+IdBV7JeoCMIoNsuyptttzHCWXX4xVs90b1x0CsOIPHQbifpYYzBZ7jwjtz2qh1Su
	5+MHm3Q2HQBfzob5/Lwpxubz7BtDVw/9L5Gz+cQjAO1C2ORGN6FlGzr9JGwqYuPVNvun+Qc
	SPJ09W7WgIcMwlxtL3Lhoi5/DBI2NnaZaIWsIbbH4oO6BMQNcrJtn2zPxGSIFuvVVLYSSVp
	vRfsCMqz54hV1CQQQr
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Tue, Aug 26, 2025 at 11:14:19AM +0100, Vadim Fedorenko wrote:
> On 26/08/2025 02:31, Yibo Dong wrote:
> > On Mon, Aug 25, 2025 at 05:37:27PM +0100, Vadim Fedorenko wrote:
> > > On 22/08/2025 03:34, Dong Yibo wrote:
> > > 
> > > [...]
> > > > +/**
> > > > + * mucse_mbx_fw_post_req - Posts a mbx req to firmware and wait reply
> > > > + * @hw: pointer to the HW structure
> > > > + * @req: pointer to the cmd req structure
> > > > + * @cookie: pointer to the req cookie
> > > > + *
> > > > + * mucse_mbx_fw_post_req posts a mbx req to firmware and wait for the
> > > > + * reply. cookie->wait will be set in irq handler.
> > > > + *
> > > > + * @return: 0 on success, negative on failure
> > > > + **/
> > > > +static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
> > > > +				 struct mbx_fw_cmd_req *req,
> > > > +				 struct mbx_req_cookie *cookie)
> > > > +{
> > > > +	int len = le16_to_cpu(req->datalen);
> > > > +	int err;
> > > > +
> > > > +	cookie->errcode = 0;
> > > > +	cookie->done = 0;
> > > > +	init_waitqueue_head(&cookie->wait);
> > > > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > > > +	if (err)
> > > > +		return err;
> > > > +	err = mucse_write_mbx_pf(hw, (u32 *)req, len);
> > > > +	if (err)
> > > > +		goto out;
> > > > +	/* if write succeeds, we must wait for firmware response or
> > > > +	 * timeout to avoid using the already freed cookie->wait
> > > > +	 */
> > > > +	err = wait_event_timeout(cookie->wait,
> > > > +				 cookie->done == 1,
> > > > +				 cookie->timeout_jiffies);
> > > 
> > > it's unclear to me, what part of the code is managing values of cookie
> > > structure? I didn't get the reason why are you putting the address of
> > > cookie structure into request which is then directly passed to the FW.
> > > Is the FW supposed to change values in cookie?
> > > 
> > 
> > cookie will be used in an irq-handler. like this:
> > static int rnpgbe_mbx_fw_reply_handler(struct mucse *mucse,
> >                                         struct mbx_fw_cmd_reply *reply)
> > {
> >          struct mbx_req_cookie *cookie;
> > 
> >          cookie = reply->cookie;
> > 
> >          if (cookie->priv_len > 0)
> >                  memcpy(cookie->priv, reply->data, cookie->priv_len);
> >          cookie->done = 1;
> >          if (le16_to_cpu(reply->flags) & FLAGS_ERR)
> >                  cookie->errcode = -EIO;
> >          else
> >                  cookie->errcode = 0;
> >          wake_up(&cookie->wait);
> >          return 0;
> > }
> > That is why we must wait for firmware response.
> > But irq is not added in this patch series. Maybe I should move all
> > cookie relative codes to the patch will add irq?
> 
> well, yes, in general it's better to introduce the code as a solid
> solution. this way it's much easier to review
> 

Ok, I will remove it in this series and add later.

> > 
> > > > +
> > > > +	if (!err)
> > > > +		err = -ETIMEDOUT;
> > > > +	else
> > > > +		err = 0;
> > > > +	if (!err && cookie->errcode)
> > > > +		err = cookie->errcode;
> > > > +out:
> > > > +	mutex_unlock(&hw->mbx.lock);
> > > > +	return err;
> > > > +}
> > > 
> > > [...]
> > > 
> > > > +struct mbx_fw_cmd_req {
> > > > +	__le16 flags;
> > > > +	__le16 opcode;
> > > > +	__le16 datalen;
> > > > +	__le16 ret_value;
> > > > +	union {
> > > > +		struct {
> > > > +			__le32 cookie_lo;
> > > > +			__le32 cookie_hi;
> > > > +		};
> > > > +
> > > > +		void *cookie;
> > > > +	};
> > > > +	__le32 reply_lo;
> > > > +	__le32 reply_hi;
> > > 
> > > what do these 2 fields mean? are you going to provide reply's buffer
> > > address directly to FW?
> > > 
> > 
> > No, this is defined by fw. Some fw can access physical address.
> > But I don't use it in this driver.
> 
> FW can access physical address without previously configuring IOMMU?
> How can that be?
> 

memory is allocated by dma_alloc_coherent, and get physical address.
Then fw use it.

> > 
> > > > +	union {
> > > > +		u8 data[32];
> > > > +		struct {
> > > > +			__le32 version;
> > > > +			__le32 status;
> > > > +		} ifinsmod;
> > > > +		struct {
> > > > +			__le32 port_mask;
> > > > +			__le32 pfvf_num;
> > > > +		} get_mac_addr;
> > > > +	};
> > > > +} __packed;
> > > > +
> > > > +struct mbx_fw_cmd_reply {
> > > > +	__le16 flags;
> > > > +	__le16 opcode;
> > > > +	__le16 error_code;
> > > > +	__le16 datalen;
> > > > +	union {
> > > > +		struct {
> > > > +			__le32 cookie_lo;
> > > > +			__le32 cookie_hi;
> > > > +		};
> > > > +		void *cookie;
> > > > +	};
> > > 
> > > This part looks like the request, apart from datalen and error_code are
> > > swapped in the header. And it actually means that the FW will put back
> > > the address of provided cookie into reply, right? If yes, then it
> > > doesn't look correct at all...
> > > 
> > 
> > It is yes. cookie is used in irq handler as show above.
> > Sorry, I didn't understand 'the not correct' point?
> 
> The example above showed that the irq handler uses some value received
> from the device as a pointer to kernel memory. That's not safe, you
> cannot be sure that provided value is valid pointer, and that it points
> to previously allocated cookie structure. It is a clear way to corrupt
> memory.
> 

Yes. It is not safe, so I 'must wait_event_timeout before free cookie'....
But is there a safe way to do it?
Maybe:
->allocate cookie
  -> map it to an unique id
    ->set the id to req->cookie
      ->receive response and check id valid? Then access cookie?
Please give me some advice... 

> > 
> > > > +	union {
> > > > +		u8 data[40];
> > > > +		struct mac_addr {
> > > > +			__le32 ports;
> > > > +			struct _addr {
> > > > +				/* for macaddr:01:02:03:04:05:06
> > > > +				 * mac-hi=0x01020304 mac-lo=0x05060000
> > > > +				 */
> > > > +				u8 mac[8];
> > > > +			} addrs[4];
> > > > +		} mac_addr;
> > > > +		struct hw_abilities hw_abilities;
> > > > +	};
> > > > +} __packed;
> > > 
> 
> 

