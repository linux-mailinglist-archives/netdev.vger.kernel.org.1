Return-Path: <netdev+bounces-214436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B12B296D5
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 04:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE024E76B8
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 02:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DF8246766;
	Mon, 18 Aug 2025 02:14:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6462459FB
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 02:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483298; cv=none; b=nzcz1+ipWoojKuzMKE+KeDJKouYPJ6yLOPqYKhkkHZdWa69DC+o06n/gMlQjzj9hHo5LDd51L7HnHTI/VhQlJna9Ev1apl4wdYV9gvnnmp15HFMUPKki25XFip472momnvOlMXHV3nee8cI24vwOQj+zhBOHTadF67cczBCZArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483298; c=relaxed/simple;
	bh=DkI8PHPeptSQVxGgA+vwNi4TFVYR9eQDIXUem0HipI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2mZKOxpQvgRi/D4E7Yn8wi5Nu/oCLRgnygTp3oyhUvxS0gdfexjOeuunI0NkHPnEX7U5LgRlVQN8IiOdYoABg/jVofhrtTAZGvkQE8LEwyiSA4SFiS2AM5M2XgIUIA3cQXHQp4TpuwYE+5Fc1DgniaNLWM4M2lluSpE/Q2LSBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz9t1755483266t232adb71
X-QQ-Originating-IP: UCwSp3ZXIX+i4qABggLBvhtpUNEtadG3qkHLkiDF9cI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 10:14:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12181084716518767878
Date: Mon, 18 Aug 2025 10:14:24 +0800
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
Subject: Re: [PATCH v4 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <955130413833E341+20250818021424.GA1385422@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-5-dong100@mucse.com>
 <eebc7ed8-f6c5-4095-b33e-251411f26f0a@lunn.ch>
 <3A381A779EB97B74+20250815063656.GA1148411@nic-Precision-5820-Tower>
 <0890f9e0-1115-4fa3-8c1c-0f2e8e5625de@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0890f9e0-1115-4fa3-8c1c-0f2e8e5625de@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NyqG2qnv0b2d+TN8LMTZzOlKB+2a5jkngoMmqwflVQuY6rlN2f+IKpPt
	D7FxKUYOZzl112zQ0AHxeek8ZNyK6yVV/HJB2uqhvYjtqia3xPrbscfDwPJm9OtJCOjQ2qF
	aALOf10MqzSmTiH6I4g7X9hbH/EUieqYNSBQSJ76fQn59w3subMQkfojbjR9kCu1OWuRMyo
	aCLI110eygeybwIr0e4T82HQIUtPsH9h5THa6++WFNpMDDfgKjloTFjceFbc4yuhvVQzKaP
	8Oqwnp2KUjv4t5Sd6dvajurfuJTkCEYuhSTEEMCZ4dlGXQWooJdbYFdidL2YNj14Q9j9uYN
	yW85uGDP4wf6OCoWWwtaKfK55mwctjMmq5WkfD1fUJ3JziRMveRMrPSCwMgAQY911nIH+/M
	H+/vGDmetl3BZcGG1sdc6Fp1H3T80nGbfPnHEJhtwPcL89lNwmaBAbvkN9an7CerSv6c7oW
	iTxs5pGvAbEb93pcGqK33wqeBSdLVfAf4BlLUxYy17v8QIV99D/LWvO5LkrLe9POEjkUhA3
	H/ZMdZNsdU19SE+1pcNTgQSF2CQl0yFryJCzm1tjLngMTLQBML2Cb225+jDl0zBD/kxWqn8
	mAm2v6J9lm6QPZXRiqzNUQuqQW+JCbYmLLcH9DWzmzVRepCeYw49Ex2ko+r/yTLzygT/C6C
	j/38exVhaiWhb6SRoce/SciDZArELwRYJ+3GyjKPLqrWkt+pqHZnsCsGO/WvzMuF7UU9qni
	NMugP7fpx+CLzR4c1Be98t7evn8CiIhfNZ5eFzUwJ8AvhIBOwJEU2W/lK//79E1gWC+/Qq6
	sEY744rO4Yvr97xn8UWHJ9S/o0agiZh2Pd6fMy18aisH2Jt27ulld8fmtjEIumddO6bHqX2
	6WFEZdAilQxAymwM5K+/u4aeFMUv+YvXuhb2y0QvMD0P734t+JxPsFqlMw97nSo/A16tEO1
	hzbFYv1Zo6E4C3pH9r0rGk1SzOfovkQITyakzl+TUjBHGRETT20mHzfrtqzz7GmGL6aGPiF
	FWU9H6+jPFZn046Az3
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 03:21:33PM +0200, Andrew Lunn wrote:
> > > > +		return err;
> > > > +	}
> > > > +	do {
> > > > +		err = wait_event_interruptible_timeout(cookie->wait,
> > > > +						       cookie->done == 1,
> > > > +						       cookie->timeout_jiffes);
> > > > +	} while (err == -ERESTARTSYS);
> > > 
> > > This needs a comment, because i don't understand it.
> > > 
> > > 
> > 
> > wait_event_interruptible_timeout return -ERESTARTSYS if it was interrupted
> > by a signal, which will cause misjudgement about cookie->done is timeout. 
> > In this case, just wait for timeout.
> > Maybe comment link this?
> > /* If it was interrupted by a signal (-ERESTARTSYS), it is not true timeout,
> >  * just wait again.
> >  */
> 
> But why use wait_event_interruptible_timout() if you are going to
> ignore all interrupts, a.k.a. signals? Why not use
> wait_event_timeout()?
> 

Yes, I should use wait_event_timeout, I will fix it.

> > > What exactly is a lane here? Normally we would think of a lane is
> > > -KR4, 4 SERDES lanes making one port. But the MAC address is a
> > > property of the port, not the lane within a port.
> > > 
> > 
> > lane is the valid bit in 'reply.mac_addr.ports'.
> > Maybe change it to 'port', that is more appropriate.
> 
> You need to be careful with your terms. I read in another patch, that
> there is a dual version and a quad version. I've not yet seen how you
> handle this, but i assume they are identical, and appear on the PCI
> bus X number of times, and this driver will probe X times, once per
> instance. We would normally refer to each instance as an
> interface. But this driver also mentions PF, so i assume you also have
> VFs? And if you have VF, i assume you have an embedded switch which
> each of the VFs are connected to. Each VF would normally be connected
> to a port of the switch.
> 
> So even though you don't have VF support yet, you should be thinking
> forward. In the big picture architecture, what does this lane/port
> represent? What do other drivers call it?
> 

"lane/port" in the code does not refer to SERDES physical lanes (like KR4’s
4 lanes per port). It is for physical network ports (or a PF). We use
it as a valid bit since fw cmd support multiple physical network ports
within a pci device (with one mbx handler). So, for each PCI bus X, 'port'
is started from 0. 

PCI bus X -- port0
	  |
	  -- port1

PCI bus Y -- port0
	  |
	  -- port1

> > > Another example of a bad structure layout. It would of been much
> > > better to put the two u8 after speed.
> > > 
> > > > +} __packed;
> > > 
> > > And because this is packed, and badly aligned, you are forcing the
> > > compiler to do a lot more work accessing these members.
> > > 
> > 
> > Yes, It is bad. But FW use this define, I can only follow the define...
> > Maybe I can add comment here?
> > /* Must follow FW define here */ 
> 
> No need. When somebody sees __packed, it becomes obvious this is ABI
> and cannot be changed. Just think about it for any future extensions
> to the firmware ABI.
> 
> > 
> > > > +
> > > > +static inline void ability_update_host_endian(struct hw_abilities *abi)
> > > > +{
> > > > +	u32 host_val = le32_to_cpu(abi->ext_ability);
> > > > +
> > > > +	abi->e_host = *(typeof(abi->e_host) *)&host_val;
> > > > +}
> > > 
> > > Please add a comment what this is doing, it is not obvious.
> > > 
> > > 
> > 
> > Maybe link this?
> > /* Converts the little-endian ext_ability field to host byte order,
> >  * then copies the value into the e_host field by reinterpreting the
> >  * memory as the type of e_host (likely a bitfield or structure that
> >  * represents the extended abilities in a host-friendly format).
> >  */
> 
> This explains what you are doing, but why? Why do you do this only to
> this field? What about all the others?
> 
>      Andrew
> 

FW stores extended ability information in `ext_ability` as a 32-bit
little-endian value. To make these flags easily accessible in the kernel
(via named 'bitfields' instead of raw bitmask operations), we use the union's
`e_host` struct, which provides named bits (e.g., `wol_en`, `smbus_en`).
Others 'not bitfields' is just use 'lexx_to_cpu' when value is used.

Thanks for your feedback.


