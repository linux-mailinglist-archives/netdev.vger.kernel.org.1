Return-Path: <netdev+bounces-216183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8849BB3261F
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 03:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FE7A042C7
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081C917B418;
	Sat, 23 Aug 2025 01:12:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D772C190
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911567; cv=none; b=gNgcPjTsZ7gL7L5zu55N8MEf54c2q5I7lEzxUcIXXdpRwQDetjzW5+askj6XD459/dWgJuUpGzxORZS9L/fLxZuRul3GZ3dC74QdbG2RWN5xp7YJW629vWh+dRoMuocckIE9oUJfSWJWOWyhtgfO7RHtU3pV/2wr9voHM5wOqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911567; c=relaxed/simple;
	bh=yA6j+LdZIh8VSNBUAvoV0zZeJUNVdCboDwO3ttQ8Akc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2uoK7s1apIDx8pybmHKqs/9fLSsDxqXRQvWe3n4vPAYgzZMRHH1zjgnZHLmUL4cN/oiTESZe0sDeRM1bChUASGn/f+e1DlqG15oitxcV1/6hgW4vWxjX40MOQZ7yxuTxzErYs4p/X0YjIx5xoKA5ltbDtwBxB/qJGQ69qikWK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1755911541t30cf4573
X-QQ-Originating-IP: CYYpVmL7PQRqYgMsqlkdc43DVUyX20KFhx33Uzp3ols=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 23 Aug 2025 09:12:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15638722221360569384
Date: Sat, 23 Aug 2025 09:12:18 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <EA6C27BA99B43454+20250823011218.GA1995939@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
 <39262c11-b14f-462f-b9c0-4e7bd1f32f0d@lunn.ch>
 <458C8E59A94CE79B+20250821024916.GF1742451@nic-Precision-5820-Tower>
 <47aa140e-552b-4650-9031-8931475f0719@lunn.ch>
 <7FCBCC1F18AFE0F3+20250821033253.GA1754449@nic-Precision-5820-Tower>
 <d7a38afc-58c1-468a-be47-442cec6db728@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7a38afc-58c1-468a-be47-442cec6db728@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mc5bctYcq+Xu5ZimkCNhyte4JzLvHFeTtXMTphtDekXi2R6XskD+pGSa
	5gBzmROmTfBsEw7HU/52G2BOpbdOnOne/1jQeo3Hk7neXtBsV1ElOH4arGcAgLv0KzWPdiX
	pLn3nwydBOjhX79ueBMKOSUD6ggLuDAhwTE1AonEZh9tHVVBYbTKYrqEul3F+nNTlWh+pQg
	9jDhqeGuJi4vlT6TlGZ3mRxKIPZ0g0QihsBQDQ1nHJj2VA0PSlX1/ioBBEZjZYF936YKZui
	lD7DZQYdhcEouFeEOVSXR2yqWpd20nvD+ujLQeebtYseFS7gUIpeJXTZVe8JLmzjr775p3h
	wNn2YNu0Rh+pIazN4mk47FKNtTlhGjCZfn1gGN+dd6eHTqm+HcM1JNBAcJ+3+BB+w7X+Tx8
	/UqiV8vUAM99rnPpufUxitb6M78CSaAHZuX/AbA32Ef5anqllYTW7PQb4a07lnET25E07ID
	HRXCcpznSD+45e90NzfKhq4S2glOaRIvXbGX2wys3gAlliVUdp+p0gYKS7dJKDPXCBmlWKk
	NPWSXsYUNMe+uBUXPTrJ3fb+HFjZpTUFVwuBxZ6/e7rUHxzPfykLddBiBMUG9DxY8Pb2ZMT
	WEXvvcKwN43uyd5JiA7K8EpmzcORzs7J5miMgDlBX/gFuuSjnmVEctDrhzhNzUwX0tJLCQS
	T217zaG2Pf06JJYp9tttLLTWsZ1zf04qgG8uAaljiDBeIbPl0E512QkSAMAn+Swuxf6SWts
	75Z6pKZb8PUFHlWgcjzisczi2kQjZlxPyPUuSmVolkpJRSzc3No0ZCyxWYT9YJro0lgnVZR
	FHBpgqgwRf1fcNllNpAnthGo4XagaF4VhQI/CT+Aks1alYpNLdZAnYYJLmmWCLXmXYXPzmI
	EVvZqGajdqFXdTETn8+PcengIWEriPcGCXeocx7amy9RIE1uCqe+7ZyQ9wrHzzOtkrqlDaU
	8KH20/9FkvntBE+iRJpGjRnw5QmGDUuy0OUaBRhF+HMWXWCjIfaHQ9tHCfEKebto6yqQTr4
	h1k2dQuA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 09:52:25PM +0200, Andrew Lunn wrote:
> > 'Update firmware operation' will take long time, maybe more than
> > 10s. If user use 'ethtool -f' to update firmware, and ^C before done?
> > If ^C before mucse_write_mbx, return as soon as possible. If after mucse_write_mbx,
> > wait until fw true response.
> 
> And what happens if the firmware writing is interrupted? Could you end
> up with a brick? This is actually one of the operations i would not
> expect to be able to ^C.
> 
> You might also want consider devlink flash.
> 
> https://www.kernel.org/doc/html/latest/networking/devlink/devlink-flash.html
> 
>  It replaces the older ethtool-flash mechanism, and doesn’t require
>  taking any networking locks in the kernel to perform the flash
>  update.
> 
> I assume this is meaning ethtool take RTNL, and while that is held, no
> other network configuration can be performed on any interface. devlink
> has its own lock so avoids this.
> 
>        Andrew
> 

ethtool or devlink both call mbx(mucse_mbx_fw_post_req)
to do the true update to firmware. FW not end up with a brick, it has
fault tolerance itself.
But that's not the point. The original question is
about 'wait_event_timeout', I add some comment link this in v6:
Wait fw response without interruptible.

static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
                                struct mbx_fw_cmd_req *req,
                                struct mbx_req_cookie *cookie)
{
       int len = le16_to_cpu(req->datalen);
       int err;

       cookie->errcode = 0;
       cookie->done = 0;
       init_waitqueue_head(&cookie->wait);
       err = mutex_lock_interruptible(&hw->mbx.lock);
       if (err)
               return err;
       err = mucse_write_mbx_pf(hw, (u32 *)req, len);
       if (err)
               goto out;
       /* if write succeeds, we must wait for firmware response or
        * timeout to avoid using the already freed cookie->wait
        */
       err = wait_event_timeout(cookie->wait,
                                cookie->done == 1,
                                cookie->timeout_jiffies);

       if (!err)
               err = -ETIMEDOUT;
       else
               err = 0;
       if (!err && cookie->errcode)
               err = cookie->errcode;
out:
       mutex_unlock(&hw->mbx.lock);
       return err;
}

