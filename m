Return-Path: <netdev+bounces-218628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780B4B3DAFF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BE1189BA19
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A90926B764;
	Mon,  1 Sep 2025 07:28:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E47225EF90;
	Mon,  1 Sep 2025 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711696; cv=none; b=C8PfwMJ2R7lAweE6fWy7u+pt/OWPUvvZbQTHoRA3jbZ6k7R3aqhE6OYhPk0OLo3iRCtF5/FOXsnJsUfxG5/iU/uqmAEcR9GSRPBhawVAKb+3DaBV3JRW+JFJ1ztyz8gzKkDZoJYDGFiDuxvMFEJY26lQXzhKwsps8DD2AIGuDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711696; c=relaxed/simple;
	bh=WyutN1HMzH6FqcyA5Uczxnbny4elJi/VmjabBQ7hCrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sxs2twaKZ6aNg82oW8CvA6hkhZk0aMHgKr6plpFNajZysXYK0cc/+33FA+EvMLd7S2/22p1EjDMjH9vBofxG7pARFtTGE+ugrhnWxKMspEyaPNYcaNlg29xxdO0dC/ZQdeW+xNfS2zVyxuMLxKD8zU8lWYGgdUJdCEfHwHE+hfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz3t1756711656t10c6e8e3
X-QQ-Originating-IP: tVzeneQbHbBEPf+soc/iSUCyWo18TqE9wsu93lYtbdM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Sep 2025 15:27:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16594855159721192274
Date: Mon, 1 Sep 2025 15:27:34 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v9 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <1D189F224F826D6C+20250901072734.GA43225@nic-Precision-5820-Tower>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-5-dong100@mucse.com>
 <d61dd41c-5700-483f-847a-a92000b8a925@lunn.ch>
 <DB12A33105BC0233+20250829021254.GA904254@nic-Precision-5820-Tower>
 <8a76222e-8da7-4499-981f-64660e377e1c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a76222e-8da7-4499-981f-64660e377e1c@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ND3CPZxVFFQclkUGnDuw2Kh0ZWw17N34JtysW27CNosRZWpB3WoygoF0
	XUMnI+h/kqWMZwI9roCBPx/RhTXqrNBZ2bNE7Qot0gDsJIo7NlrLHNk+/lcxsKsViR6rtQ8
	nRMkWmG+TABfWXnrKtnB6woWfTqqY36jM9cCyz6yMzoalnWAXL6CUq24IU6Nu3+x4thmrDo
	iJ6xe5QIouQoo7jLSkcVfj2j5YeNrBvc5eiTxKFyZa49n+mdxscG2kiggA0jkyT7Kc14WnO
	G6rRCSb/LnVpNvjn2QX2U1yisQ1O3bWKMUvlfiD72m4beCZHByOTNt1vaC/Tb2I+72HaRiG
	wLXzR1DE4y87hIRxAObMkWbbzTmnqZFk/9SzZtKVqZoKnByU5jgT6ViNwSTfKWz6IhHzN4r
	TnWW4PHUTiUWaJlce8K22yPupzHS+M8+IHjR86mF6TQiA7gmEAmRIRQQdm1J3poWgdOyyBq
	rASKm2S/YWFS1zSe/ogNkrPHFYbwxUK7GohHHM1GRZW0Clg9yDqc659demNA8f4u3xvVyJU
	Vw/hquwPi3rMPjdI0lZHsQOBa3LgRFnZ3+ASNNY/Cnia/IMm9DCG2NSeimfrZSO5K9W7+Xf
	hL4AYa/S7i3LIr+3V0N7JsoPEVwG4fT4W1LpSkVHZBfzK2DhgFjnGmU5XFnPOW3v33jutLP
	I6Q0S1TB23qCyAuCi9Ep6H784sFOSrZ8irp3gQmTRY7A7SSC8PmH6y/2s3C3q7YlLZY4y4j
	mZDOvBcrNHdJRq3ONcCunbqHNdCqcd9dUR9yqCiecVm/Yl58DfgG2z7fqR+SBevfIXNwyeF
	Xg9mCDx8j895484qXxGEUoa0Klxqb6O+I4Ri6Lu5w6HlEwCBuPN8+Y8zhuBktnXm1dJMPJz
	OSrDVGm51DyHA2kj7rkTP+YOg3rWrELJqA9/dw+3RE4wBFTwR8QuzyzeEW3oGMgz0Kd0i1K
	S5mYt6K7wYm2ekOvOMfaFfWtIoqnVWLXxhMRNJC+7u7gVaSElVDJ+kZ3suHT8cWaHVH/T+k
	44ETNtfg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Fri, Aug 29, 2025 at 09:48:12PM +0200, Andrew Lunn wrote:
> > Maybe I should rename it like this?
> > 
> > /**
> >  * mucse_mbx_sync_fw_by_get_capability - Try to sync driver and fw
> >  * @hw: pointer to the HW structure
> >  *
> >  * mucse_mbx_sync_fw_by_get_capability tries to sync driver and fw
> >  * by get capabitiy mbx cmd. Many retrys will do if it is failed.
> >  *
> >  * Return: 0 on success, negative errno on failure
> >  **/
> > int mucse_mbx_sync_fw_by_get_capability(struct mucse_hw *hw)
> > {
> > 	struct hw_abilities ability = {};
> > 	int try_cnt = 3;
> > 	int err;
> > 	/* It is called once in probe, if failed nothing
> > 	 * (register network) todo. Try more times to get driver
> > 	 * and firmware in sync.
> > 	 */
> > 	do {
> > 		err = mucse_fw_get_capability(hw, &ability);
> > 		if (err)
> > 			continue;
> > 		break;
> > 	} while (try_cnt--);
> > 
> > 	if (!err)
> > 		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> > 	return err;
> > }
> 
> Why so much resistance to a NOP or firmware version, something which
> is not that important? Why do you want to combine getting sync and
> getting the capabilities?
> 
Maybe like this? 
mucse_mbx_sync_fw is called in probe with try_cnt. 
mucse_mbx_get_info is the same as old mucse_mbx_get_capability.
One function one purpose, not combine two.

static int mucse_mbx_get_info(struct mucse_hw *hw)
{
        struct mbx_fw_cmd_reply reply = {};
        struct mbx_fw_cmd_req req = {};
        struct hw_info info = {};
        int err;

        build_get_fw_info_req(&req);
        err = mucse_fw_send_cmd_wait(hw, &req, &reply);
        if (!err) {
                memcpy(&info, &reply.hw_info, sizeof(struct hw_info));
                hw->pfvfnum = le16_to_cpu(info.pfnum) & GENMASK_U16(7, 0);
        }

        return err;
}

/**
 * mucse_mbx_sync_fw - Try to sync with fw
 * @hw: pointer to the HW structure
 *
 * mucse_mbx_sync_fw tries get sync to fw hw.
 * It is only called in probe
 *
 * Return: 0 on success, negative errno on failure
 **/
int mucse_mbx_sync_fw(struct mucse_hw *hw)
{
        int try_cnt = 3;
        int err;

        do {
                err = mucse_mbx_get_info(hw);
                if (err == -ETIMEDOUT)
                        continue;
                break;
        } while (try_cnt--);

        return err;
}


