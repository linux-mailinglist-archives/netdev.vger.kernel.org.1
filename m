Return-Path: <netdev+bounces-220187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F93B44B3F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 03:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648A2176017
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 01:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EF21EB5F8;
	Fri,  5 Sep 2025 01:27:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305372625;
	Fri,  5 Sep 2025 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035664; cv=none; b=pewsgUvNVC80ALRsEnQXdPeO1wWE+vpCXel5I1G5v34vq8kHQyzD0oRyK8V88Gu5MGUAQV4TiSuvwIck/digTfqYpxiCiuwaP1uXaOy9yN+LORshENZApVeDclID6cHZ8O3Un1KAXjs2ucxfjkfnmVZl7+O6XRHPDDJjXVspHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035664; c=relaxed/simple;
	bh=aLoUEbTCoN/MH/WK/QqOpgP8wArG/ACDrW/eNmUJ7uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC8DI6Nxf8NWeC04wutrLcpSJaSYzq7DaQT1SsMtqvoo2vop2fCg0p6cwgZ6bHHWiMD/ZBfYS42CmJ8tON7a3Z7u2c1bj0WkmyNdMDQsEFktqcMmK8clytxXXVawQ6xOhqlAeURu3vmhXDeTfpYDvecBUd6K4ZgpUOQxdcyni7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1757035636t24995ae0
X-QQ-Originating-IP: KAmy+BY7HNVDxa0q8N84syxILER9oNes0rHc+WSM7oI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Sep 2025 09:27:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2911186365626881652
Date: Fri, 5 Sep 2025 09:27:14 +0800
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
Subject: Re: [PATCH net-next v10 5/5] net: rnpgbe: Add register_netdev
Message-ID: <6B75891C2763EAF3+20250905012714.GB1091337@nic-Precision-5820-Tower>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-6-dong100@mucse.com>
 <b9a066d0-17b5-4da5-9c5d-8fe848e00896@lunn.ch>
 <6B193997D4E4412A+20250904030621.GD1015062@nic-Precision-5820-Tower>
 <d30ee369-3711-41d2-95ad-85fa3e1cb65c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d30ee369-3711-41d2-95ad-85fa3e1cb65c@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OQNQM5UP8StMXU05C0AxZJUErtG60xO/kxQ8ntDfEnuccGtkoGyfswaJ
	TxU7iDpvEk+nDEzqZCpfvYZnU6cT178TgJQEMczfOCU0k56/oQhP4bv3VoxvMcl4DT9fNoM
	hPfEBR6kwATXJj2tl/qvDHn2ff9xD3KFJHJVSTEGI6ZriMPkbK7Vk0e33tpRqGtqJxy/x0W
	5QvihwK5k+3o09/qs/n7+ztad8eBJXqaQen2haDWn9t0T/63bzrQf5FqVreaMoLO/iQ+Dc5
	vL/ExWz9TjxptXJydgGxdvwy3+vb2RRdxA/qzQBnRAUv/xEEGoFlC50Au8f2OoshY4C7xBj
	9PTy6txwrc5gg8BeUnRLCmaEzeZu3kLFDl/z97NZoV/4VzGNci+ApqCnRIMJHBv7GUftsph
	GaHDjVAkTGNj2B79pVoe/khtGTpHAkN9mFLSmhJ3EDPCBeP1fc15wvFnbaYteW0TB5JGfcc
	AAZj2gZg6sFcXvgX5O64xACQkOw5jcbb/4CLYfBa39iqnwnu8lwoifOyBBTTFGsOuHdHW6m
	dhxlAzWpSgYlZVckZv09KsB4ypwYR90TrwwTVUYkKPTSjq7pHTnzfZiNXQBQjrhS7fA6RqL
	ATojsHJhIXZCTUSsPbvSvvM9bgq0dlI0VeFiLbRDDkFtRZvvOkj4Rj88HSFcCyJxIWRJ6Fr
	SfMpu4nj3h7ntewjsun6uOE4QHAr3QwlwNo0i8SX3iTiJHmo6q55HC1mdO/ReeCpl2+c5FS
	AXQTvEyMRLzwgVPmDV0u2HFFMgESGgMgBbtDse2PbRAYuIRcCXsVf8Iwlybd5Yquu+XB/QR
	F70/lNHdAGhv6/NYoz2vSwcgZDRbqbGnEGj7YHJekTBi0qlHEDWAB4MFZAMkVYm4zXhQk3c
	/JA37pvPspxX/b4GeM4m+Q7heFwGwj5CPRuhT0GW5Dh0eWeQN3ajrHGqycfqZdPz7c8qwG8
	G5oF20PfQ2n0hQH09mnUCfvevtMzwLuIsfl4cY2ZbV4/5ue5tS65VkDvvJAx2PhxJuZajps
	cu5ZSrWw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Thu, Sep 04, 2025 at 02:35:06PM +0200, Andrew Lunn wrote:
> On Thu, Sep 04, 2025 at 11:06:21AM +0800, Yibo Dong wrote:
> > On Thu, Sep 04, 2025 at 12:53:27AM +0200, Andrew Lunn wrote:
> > > >   * rnpgbe_add_adapter - Add netdev for this pci_dev
> > > >   * @pdev: PCI device information structure
> > > > @@ -78,6 +129,38 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
> > > >  
> > > >  	hw->hw_addr = hw_addr;
> > > >  	info->init(hw);
> > > > +	mucse_init_mbx_params_pf(hw);
> > > > +	err = hw->ops->echo_fw_status(hw, true, mucse_fw_powerup);
> > > > +	if (err) {
> > > > +		dev_warn(&pdev->dev, "Send powerup to hw failed %d\n", err);
> > > > +		dev_warn(&pdev->dev, "Maybe low performance\n");
> > > > +	}
> > > > +
> > > > +	err = mucse_mbx_sync_fw(hw);
> > > > +	if (err) {
> > > > +		dev_err(&pdev->dev, "Sync fw failed! %d\n", err);
> > > > +		goto err_free_net;
> > > > +	}
> > > 
> > > The order here seems odd. Don't you want to synchronise the mbox
> > > before you power up? If your are out of sync, the power up could fail,
> > > and you keep in lower power mode? 
> > > 
> > 
> > As I explained before, powerup sends mbx and wait fw read out, but
> > without response data from fw. mucse_mbx_sync_fw sends mbx and wait for
> > the corect response from fw, after mucse_mbx_sync_fw, driver->fw
> > request and fw->driver response will be both ok.
> 
> Because this is logically the wrong order, this deserves a comment.
> 
> You choice of function names for the lower level functions also does
> not help. It is not so easy to look at the function used to know if it
> is a request/response to the firmware, or just a request without a
> response.
> 
> 	Andrew
> 

Got it, I will add comment.

...
    /*
     * Step 1: Send power-up notification to firmware (no response expected)
     * This informs firmware to initialize hardware power state, but firmware
     * only acknowledges receipt without returning data. Must be done before
     * synchronization as firmware may be in low-power idle state initially.
     */
    mucse_init_mbx_params_pf(hw);
    err = hw->ops->mbx_send_notify(hw, true, mucse_fw_powerup);
    if (err) {
        dev_warn(&pdev->dev, "Failed to send power-up notification to firmware: %d\n", err);
        dev_warn(&pdev->dev, "Performance may be limited\n");
    }

    /*
     * Step 2: Synchronize mailbox communication with firmware (requires response)
     * After power-up, confirm firmware is ready to process requests with responses.
     * This ensures subsequent request/response interactions work reliably.
     */
    err = mucse_mbx_sync_fw(hw);
...
And lower lever function names will be consided to be renamed.

Thanks for your feedback.


