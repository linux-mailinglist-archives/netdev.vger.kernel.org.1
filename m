Return-Path: <netdev+bounces-213288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A579AB2464E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D2C3B0FB7
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AB32F0C52;
	Wed, 13 Aug 2025 09:52:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F421256D
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078746; cv=none; b=H3MbG/RN1a+o997VAEx1ALQqc9hjLuVaO39Ngut2cGVMAJQlm2LTY261tpnYJWTNLtX18OkMFHCK3gn+YIjUy5QLRy9Dr35c+UMmEBcUg/TIKx6aN9MTgwTTxA5kZWWTZoRC56xDW8UY6fY5svsFbEk5kGqOU9gYyZdWXxEwZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078746; c=relaxed/simple;
	bh=+WZMCb2th4q4S3QCII5BAqLwjZKqas5JP8nnZISgNUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k09X5n+Hy5NfRRB70e+Tld6rASOudqAl5IfZqYluAGICuS9HujwgCmSZNTuSvF/eYss59TnuZtJ+CvDAm/yIEQdymHx67J98QhVbSnhUq2eP9uybovHJlVkIYSDvPJsbNWYne57o7Ryt7RHYVHhegby3HbbjSEsP1oNednPQnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz5t1755078736t6188a4b4
X-QQ-Originating-IP: Fzg1HaXRH1kgNyX7pYbXPr6PlV+6nK7OiSq/8/Z95Fc=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 17:52:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 535063988125251016
Date: Wed, 13 Aug 2025 17:52:14 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-5-dong100@mucse.com>
 <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NQ1SesBsQjVtoJAu6dG38/eCbe+SBCJLugfE8LC2Eah7FXgG4G/Kw1eS
	vBrQZ0cR+Wooo1yS6VP9xK5LYAna29WOobl3n1wdPvfidGVc/+eS8GTbiiOJZvB3eVzON2a
	aVPggBkI15+7ajXSrbGKDX/2lGSUvfE6l6B6jCVO1PY85Y6PEcw0GZtxhzXvXf65sr384es
	+q9rzFi0oGK/tpKlPKbLmgOjsnYKsjORt5nNTYZS84v+XmFdN84yJPArb+/iFaJxlrfpdFE
	3h1ie5MbETWDzhonh4GsXyBbB5KPOtiMhM+xTJWjm1ZJPHM7RQicpGCycqjVFPpE+9xSREw
	gJAvKRAKaqyFx+0t1Z4XkERBUlei/FiEumAzl7jfjGZh2McLzx7ZpShVJOvrEt5bCqz+oIO
	AIGP+zV6mtO5GsuG4g3jzLXyhnnXHHseuG4kiq25/EYFWIJO/g4K1d2cWjlXBDlsbpBUqfr
	yT/3QCRyO56/h521K6VM7knCWBtd+YSqeQ4l10jNg4gZoi0l70hBGo/YjxtnrCYV89tce4g
	eoDObs/rpTgSAnD19ARwhEIxHowWyncHSiib0vWHA5qsY4Opq2QP0syT9+3pHyHdhPqFOeT
	/bFKenqqWRjHYVRjq2v6RNxJwVICsmfXuk4KtpsGK+Jn9vYYHyodK/40rPEc+h46YC3amfP
	zUaFBShoisg1Ce3XdlP1zFYgHPy4YTz/na7lpfgGpyCYUpeR8GtroddTXT+LbkyuYgMzukS
	xev98tEPBMAoDeqbSdElsMwd030QG6CKwqMZ2Gh2bpI3dykzrcYPB+z5FBB5o2ZiYmNkZ9g
	bhhkaWg5o7oFuRv2vFUd6OZc9YGzvATCr0kjxlL/WxbUomuLgSEcCk57sIAnlZNOHNnCXON
	vEzpnL+v4j+wU43Qm6tQ62+bfclXAD4cwYcOdn2Dj33OxEz/5qGq0bkZCUL4BbnaLvEDxyM
	2pYBFcIAegsgFVBXpX4yFCR8gS03YhjmtwbJRSJxjxCLz4w9db5/b7T2EDVncm2xwmqn/uS
	LMjG5VGmBLCG9+gj44
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 05:14:15PM +0100, Vadim Fedorenko wrote:
> On 12/08/2025 10:39, Dong Yibo wrote:
> > Initialize basic mbx_fw ops, such as get_capability, reset phy
> > and so on.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> > +				  struct mbx_fw_cmd_req *req,
> > +				  struct mbx_fw_cmd_reply *reply)
> > +{
> > +	int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> > +	int retry_cnt = 3;
> > +	int err;
> > +
> > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > +	if (err)
> > +		return err;
> > +	err = hw->mbx.ops->write_posted(hw, (u32 *)req,
> > +					L_WD(len));
> > +	if (err) {> +		mutex_unlock(&hw->mbx.lock);
> > +		return err;
> > +	}
> 
> it might look a bit cleaner if you add error label and have unlock code
> once in the end of the function...
> 

If it is more cleaner bellow?

static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
                                  struct mbx_fw_cmd_req *req,
                                  struct mbx_fw_cmd_reply *reply)
{
        int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
        int retry_cnt = 3;
        int err;

        err = mutex_lock_interruptible(&hw->mbx.lock);
        if (err)
                return err;
        err = hw->mbx.ops->write_posted(hw, (u32 *)req,
                                        L_WD(len));
        if (err)
                goto quit;
        do {
                err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
                                               L_WD(sizeof(*reply)));
                if (err)
                        goto quit;
        } while (--retry_cnt >= 0 && reply->opcode != req->opcode);

        mutex_unlock(&hw->mbx.lock);
        if (retry_cnt < 0)
                return -ETIMEDOUT;
        if (reply->error_code)
                return -EIO;
        return 0;
quit:
        mutex_unlock(&hw->mbx.lock);
        return err;
}


