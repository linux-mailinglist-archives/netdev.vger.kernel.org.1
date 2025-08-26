Return-Path: <netdev+bounces-216758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BECB350FE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69090200507
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26F1A238C;
	Tue, 26 Aug 2025 01:31:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875415D3;
	Tue, 26 Aug 2025 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756171900; cv=none; b=oePn3G3bqnqZBhXPUfBX3PZWnImoGfodAoZgGEqb24v3TK2cAv1N4nTSWX5PAAgOxv9A17bwA8UZB7yLPPd+GaiEnYHV0jxqUM7i3gKLlE+Gizipm1+xRHc+VCPnMhzQaqLSEx/ksZj6YMFBWXSkQ4eDjKJtrDX8pCg+qmBEd0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756171900; c=relaxed/simple;
	bh=2CAfInhMBlEheWI50chGaNttiRjZFFWB2jkfwM/74SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBVOZzKTD/3l7aeV5M1C0SuJCzAZ/N4FloQMYw2m5wb/V7E4xJc5+Joyrc44F2kyqWHcbXyauFYrjsfqWpty8A2EepPIpl1am5+10izync6E6v7ooQ/wMvu+/JcM49aq5WrX7LltYz440n6T0KMbL1NhN52FVAaxuswym20QQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1756171875tdaf462a0
X-QQ-Originating-IP: JG4CTHw+p2KwTkKW/C8uuarVnjApQNroGADEHk0tpcY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 Aug 2025 09:31:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5786060330741140375
Date: Tue, 26 Aug 2025 09:31:13 +0800
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
Message-ID: <82E3BE49DB4195F0+20250826013113.GA6582@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <316f57e3-5953-4db6-84aa-df9278461d30@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <316f57e3-5953-4db6-84aa-df9278461d30@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OQNQM5UP8StMXU05C0AxZJUxwGUJleeF6slPjPlLNWqCHQtnEEGp2zI4
	h9bZtMi5wjc39AZuTDu4fQvOKoplGiT9KkbYDuwSBdZw+quPVNXmDiAimhgYLU1hIZcALmd
	vfqe13vm5SceoXV46PVlI4TGO1MS4Y1Pa5bbJFj+CpO5BdKTDbic48o5n8HWT2zgSVXysux
	X/14RmUstCRjUst1kQ/AlbUTdc2Uh4al76Re4fTRWFCqQqiDtDUpBQxnUnUF+rFZE5oJz32
	jpqfHVZPqOFlyWvzs4I7omytuWlGG77XTiSAaKWEz+++Kpi7HIsDP6U6Mr7rY6vN6LVAgEV
	WnAmzR8Q7J4lVi8Jnq7jKh4RkpupTXVXvSX77hn77nanKOOLHELkjMlwFu3TaWDo9iwocR9
	BFJXaFhogGQw/XQW9MF+zyouCb66czPnC4Jg8+BPNR0oFeVnvclpA0h8UQrj6Uimi5SrVTp
	C9QNoohbeHoc6KOcU/nMglTo059UScC4etaqui4nrYrbGbO68lewkdKV7uLjw1Y9iuev94Z
	DWBQ9ac2SXhLdEJNh1OFfQRIkexPj77mn8qL6X5YwG4a7HDvLehIjyj9RyKINASGWMXP4jk
	AsF+r0eabP0AURMYoAoLwfCQLBOi8SXv3jJDM6pYuiDQeaMH3u3lemnyKl0m3hoVRMLleNG
	AEb2J4nlSetu9s4XQooIEK0MAWAvqrPHH3peTSWRdPAjOs+HEP6FDXjdvj2HuNqCeo/6tFI
	EsgO2LkmjFIwzJO1k0yq5vqsCwETbq+/iN4EUbfQHsCcatKhEFTVUkx21gbm3EMHtU8UPzP
	OLH0eBjyz9/zd9poybfXIbsrFeVuObsXIk3YuyOvV/qiIvaWv+LjULqTNl28gzWVc1fXttm
	U160fKexBMtBiNzUviwq4osUpvIt3GqFWqKxlnJJA//Yi13nvy0YKiSY9CskbByKQAA4CgL
	4kmoFY2fWyAyp93SeNLzgi8hNJu721QwCdcnUkfalAYWutS3BHORoUNjF
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Mon, Aug 25, 2025 at 05:37:27PM +0100, Vadim Fedorenko wrote:
> On 22/08/2025 03:34, Dong Yibo wrote:
> 
> [...]
> > +/**
> > + * mucse_mbx_fw_post_req - Posts a mbx req to firmware and wait reply
> > + * @hw: pointer to the HW structure
> > + * @req: pointer to the cmd req structure
> > + * @cookie: pointer to the req cookie
> > + *
> > + * mucse_mbx_fw_post_req posts a mbx req to firmware and wait for the
> > + * reply. cookie->wait will be set in irq handler.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
> > +				 struct mbx_fw_cmd_req *req,
> > +				 struct mbx_req_cookie *cookie)
> > +{
> > +	int len = le16_to_cpu(req->datalen);
> > +	int err;
> > +
> > +	cookie->errcode = 0;
> > +	cookie->done = 0;
> > +	init_waitqueue_head(&cookie->wait);
> > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > +	if (err)
> > +		return err;
> > +	err = mucse_write_mbx_pf(hw, (u32 *)req, len);
> > +	if (err)
> > +		goto out;
> > +	/* if write succeeds, we must wait for firmware response or
> > +	 * timeout to avoid using the already freed cookie->wait
> > +	 */
> > +	err = wait_event_timeout(cookie->wait,
> > +				 cookie->done == 1,
> > +				 cookie->timeout_jiffies);
> 
> it's unclear to me, what part of the code is managing values of cookie
> structure? I didn't get the reason why are you putting the address of
> cookie structure into request which is then directly passed to the FW.
> Is the FW supposed to change values in cookie?
> 

cookie will be used in an irq-handler. like this:
static int rnpgbe_mbx_fw_reply_handler(struct mucse *mucse,
                                       struct mbx_fw_cmd_reply *reply)
{
        struct mbx_req_cookie *cookie;

        cookie = reply->cookie;

        if (cookie->priv_len > 0)
                memcpy(cookie->priv, reply->data, cookie->priv_len);
        cookie->done = 1;
        if (le16_to_cpu(reply->flags) & FLAGS_ERR)
                cookie->errcode = -EIO;
        else
                cookie->errcode = 0;
        wake_up(&cookie->wait);
        return 0;
}
That is why we must wait for firmware response.
But irq is not added in this patch series. Maybe I should move all
cookie relative codes to the patch will add irq?

> > +
> > +	if (!err)
> > +		err = -ETIMEDOUT;
> > +	else
> > +		err = 0;
> > +	if (!err && cookie->errcode)
> > +		err = cookie->errcode;
> > +out:
> > +	mutex_unlock(&hw->mbx.lock);
> > +	return err;
> > +}
> 
> [...]
> 
> > +struct mbx_fw_cmd_req {
> > +	__le16 flags;
> > +	__le16 opcode;
> > +	__le16 datalen;
> > +	__le16 ret_value;
> > +	union {
> > +		struct {
> > +			__le32 cookie_lo;
> > +			__le32 cookie_hi;
> > +		};
> > +
> > +		void *cookie;
> > +	};
> > +	__le32 reply_lo;
> > +	__le32 reply_hi;
> 
> what do these 2 fields mean? are you going to provide reply's buffer
> address directly to FW?
> 

No, this is defined by fw. Some fw can access physical address.
But I don't use it in this driver.

> > +	union {
> > +		u8 data[32];
> > +		struct {
> > +			__le32 version;
> > +			__le32 status;
> > +		} ifinsmod;
> > +		struct {
> > +			__le32 port_mask;
> > +			__le32 pfvf_num;
> > +		} get_mac_addr;
> > +	};
> > +} __packed;
> > +
> > +struct mbx_fw_cmd_reply {
> > +	__le16 flags;
> > +	__le16 opcode;
> > +	__le16 error_code;
> > +	__le16 datalen;
> > +	union {
> > +		struct {
> > +			__le32 cookie_lo;
> > +			__le32 cookie_hi;
> > +		};
> > +		void *cookie;
> > +	};
> 
> This part looks like the request, apart from datalen and error_code are
> swapped in the header. And it actually means that the FW will put back
> the address of provided cookie into reply, right? If yes, then it
> doesn't look correct at all...
> 

It is yes. cookie is used in irq handler as show above.
Sorry, I didn't understand 'the not correct' point?

> > +	union {
> > +		u8 data[40];
> > +		struct mac_addr {
> > +			__le32 ports;
> > +			struct _addr {
> > +				/* for macaddr:01:02:03:04:05:06
> > +				 * mac-hi=0x01020304 mac-lo=0x05060000
> > +				 */
> > +				u8 mac[8];
> > +			} addrs[4];
> > +		} mac_addr;
> > +		struct hw_abilities hw_abilities;
> > +	};
> > +} __packed;
> 

