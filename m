Return-Path: <netdev+bounces-213939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F10B276A2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120B2A0673E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F251AF4D5;
	Fri, 15 Aug 2025 03:15:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733C18C011
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227742; cv=none; b=dOy6PfQvrmxVNe64ucF0nB+vnI2qf5TT3yKcRfgdzjqUMbf6prpW3brCjttz/+xtDhBzJ6zSVyrp80yJ5mN/EgWjb4vVjN8beJ15X5PN6sLIg9dW+8gJ+IAFv/ueRcqG8l38SipTxi6acIzdD4JqPTVasobV+rCK04vqMaAjfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227742; c=relaxed/simple;
	bh=T1sh+P7hG/l43OUvLJm9SoI62WnK76nbGCjSpnoUIhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7FWaT4HbxFOF40dUl+1RoDykqlDDm1dWy9LnP5US80v1tuwEq3i1/Edk+d6n3HWSZAdG9TjoVgTylUHQ3ft4AdsUWTUf14OJkEIH8f8Ga0/swc4KX/G83dHatMYXgIgMRZPNayxMDzy4Lx0UQ7fMyVBgG8f0WfmlZGpI+DOH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz21t1755227724tda874541
X-QQ-Originating-IP: SYs96dYgVOR/5RRgXZvpgPmZ38GjwJyNFCQsbJZuGLE=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 11:15:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17237872932614161195
Date: Fri, 15 Aug 2025 11:15:22 +0800
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
Subject: Re: [PATCH v4 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <047254CB5E8480A1+20250815031522.GA1138819@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-4-dong100@mucse.com>
 <edf9be27-fdbf-44c9-8ce8-86ba25147f02@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edf9be27-fdbf-44c9-8ce8-86ba25147f02@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M8X+OvqqReHCn4jzLQWtt6Lv92biL8EhsWSc67NU58me8hNecZbX9Gjf
	arX84nGGHqjQsAodYgp6pemoZ9XpYNsvXJyw5ZpVXo1nuVpn9lRrVr00PciGjxToBKYsu3K
	xVzSEEucuifaQ+oFKowlNMWNXFVC6mzqZYWtZI9WA31+ydKefNRs1bIBS3h9P8vx62m5u3k
	Nb9jlZCMht5OEk2MKiibClpQT0uyOLAjcj8kRgcNeAMUve2EUcOHEUBYJTaMnU4M4WNLlpL
	74OQGuv2xbsxlcIyrUJSsFtB4V7WMWqNrOQWQoUA2DdxThLXY2RDIqb40+KBveB/pT/QK3H
	7WMcLjiM2mK7ppOHaHbrbkaZz3ywLX4EYo+ynR+dT1T1zxPNqHwdSpDnzQ7bX9litVI1Qor
	IIJ5D2RFIVvzSL06mPhRqqomESjFTv31+xqT5PejzyelK73ScxkUf81zgqOSY57hDEUrVS2
	u2/QFB8GsDCM4KHVPdQcf2jVUyXn5dMgTPjqoK3a5ntwh/xysyrbjpp6PCoX1Jj3PdZTzvl
	sC7A+qNSIdRzOaXxWi+bP45qsQ8B8rR+FEUaUsfFRz8bxyYH3wlQlWui0Gjb2wmrbZQtb/c
	TxuCrtF9Hqx0eQ51CwgpPoWlDvznitcTJiUCU9mfNRuD3c2umE+x+KtnvJwhj90d+hQ2dEy
	bxdoYfQ/aDV9T1uOlD4O1d+1+QLtYCipWswEojbxsXgGpedgQS9/4eUmYH9sKDsZ43PvDd/
	/7IrmZuw9OCy9Ipf43wYkKk81ARByFMydtowJrUfAx4RiCYG/XfGPioJbVh3O8JtoF0KYNm
	YBac/3UPxty5Ln6OVCeZd5++XyUT6y3PPK1MAJfZ63YrhHB+265Ay2yvFNcyX9zgZP9N7+x
	wLvSuTp7am67bq+oE/z8QfnJCruMdzpTzwAkNUxCckB32IhUriohUXoZKXzO61phjUUMEl2
	Ya9BeBDgAyzLrw3+jCFjX4IVeCGlsVZHbWNVGiGhBClhfV7HvlFdRPWQx9aNT03yOvukncM
	bM8xd7ScXeU50rGQvfIxHjhbjmaNR4h7gPNJsKukzYbvPCuYOl5hl+dF3oIp/XWx0k3Au9u
	O2v2KdqT4Lep4RPTyL70KUJ9TXvY18zNbexIxQaowdUoIKnsiicv4TICu0JJM5Rhg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 04:29:28AM +0200, Andrew Lunn wrote:
> > +#define MUCSE_MAILBOX_WORDS 14
> > +#define MUCSE_FW_MAILBOX_WORDS MUCSE_MAILBOX_WORDS
> > +#define FW_PF_SHM(mbx) ((mbx)->fw_pf_shm_base)
> > +#define FW2PF_COUNTER(mbx) (FW_PF_SHM(mbx) + 0)
> > +#define PF2FW_COUNTER(mbx) (FW_PF_SHM(mbx) + 4)
> > +#define FW_PF_SHM_DATA(mbx) (FW_PF_SHM(mbx) + 8)
> 
> There seems to be quite a bit of obfuscation here. Why is both
> MUCSE_MAILBOX_WORDS and MUCSE_FW_MAILBOX_WORDS needed?
> 

I will remove MUCSE_MAILBOX_WORDS.

> Why not
> 
> #define FW2PF_COUNTER(mbx) (mbx->fw_pf_shm_base + 0)
> 
> Or even better
> 
> #define MBX_FW2PF_COUNTER	0
> #define MBX_W2PF_COUNTER	4
> #define MBX_FW_PF_SHM_DATA	8
> 
> static u32 mbx_rd32(struct mbx *mbx, int reg) {
> 
>        return readl(mbx->hw->hw_addr + reg);
> }
> 
> 	u32 val = mbx_rd32(mbx, MBX_FW2PF_COUNTER);
> 
> Look at what other drivers do. They are much more likely to define a
> set of offset from the base address, and let the read/write helper do
> the addition to the base.
> 
> 	Andrew
> 

Ok, I will use 'static u32 mbx_rd32(struct mbx *mbx, int reg)' way.

Thanks for your feedback.


