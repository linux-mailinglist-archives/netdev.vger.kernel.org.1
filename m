Return-Path: <netdev+bounces-218592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE7BB3D68A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 04:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F033B9C26
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 02:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721B2080C0;
	Mon,  1 Sep 2025 02:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96F1B0F19;
	Mon,  1 Sep 2025 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692527; cv=none; b=aUKywGhSwRWNmSHhDWmMLZsw5ZnI672LeDQk+Q6HIf4sXB8tdKyfbKxe+2aUq4fO3LZtLfLXVJ1zmiigvR8STYkutMDqWLrGF21qnt6hGJRrhMhZfj00qOdrGcR3Pn4D8+knqVvLpwKyVUgsRpEe/aOTNfe/E/GHe52o7CZ5Uzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692527; c=relaxed/simple;
	bh=Vm/kZN9c7s81CxsjYSlovb7fQlggwebCdtC5M962/Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhhUVqpd8AvRTok1mQBrW1Kn0f4LspOaStDR9Akh8mrQJJ26a0uTNNYQkiAD15ApwQuZPlDCrrn6nmOAQFK/ze/vHgWKukXzqQGBZQh+1M5tQ5NyyhjbfqqL3G9Qf43mEyQJ99bU0xZKSRC299paVj4RnmwRc7Qz8zasDsepfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz9t1756692493t00716bf8
X-QQ-Originating-IP: 4hWyaNGsfTG/p5ecPAf++Im/XolX69MjIDgC8Pm9QiU=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Sep 2025 10:08:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17451087102426230808
Date: Mon, 1 Sep 2025 10:08:11 +0800
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
Message-ID: <384738E266C55C1A+20250901020811.GA21078@nic-Precision-5820-Tower>
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
X-QQ-XMAILINFO: NkLA2q2LD229wshJrtN9PYJ1yPuxDSKIY4fbApA8Kr64XeR+MrKuCA8i
	APafXAyKbnp8x/DwZXUgYDSCXsQPlf3kWJfVXWf/6mizZE5ui37ddNb1tqUrXrUVQiQ3yUu
	98zcZ+Xf+71Aocf/hrUtCX0zMN8aTLRLxaxy1sA6taS4PfHEl1TY0pMISft/c4DAeHQcUBz
	MQGisJWRrzpXPotfOTeVyr40VIeXQoKT6NsCmhyHxQUShOQQaSm8DtjiogaJnhpWBOAZFWh
	IaMaeDehiTPVwzRffvrMvBcnwn2WdsuK5KvLZPu9Xxhvpf+bmLpgvPqicl1WhM8mzGt1Crd
	E8BveBLvAQ+zJmXyUPtKCFgyOXVnhXy697xe4AXM2c/cqpEEzRkIZT3rT/0lprRSJZ3hGMP
	+GoXFkI+0PMhSIhZzKJ+SWTJ7GEN+H/xxm0RoTrJPh9hQlHXuk3xA3leA/fI3897qVDNuym
	3JAwFIK2sbo80t6GmOiXavi2ISnbLcQU0OkOuTYGkKnJOewC5XGyXyNiOVk9nQeVTfDejfi
	+2EDr3WJrj/k1BccH2KKeT/eMp7YOO4WoPhKzPMiVErPFByt8LEbW2i/t+89qAfuOZ7EtnE
	jcR3sbSDboUhvilQleS/LkNteBCg8sT86aowHzOi2kdPMBQlxszT4ueRiv1hB3f69K3Md62
	TJwVc78voN0ykCq44L/sAz8XlA7qrhChkgwaar+MVzQ7hOueVJNUgoA0MqWivF/QkEJ2Tor
	zEUTI6fHr5eGsbq1xXlTnpvmGxpvLIH1E0P7bH+qqjzq77WeohkUsmXTbUzd1XkTwxgxBXA
	CVQ9xE2+Hvh1v/oparjaItivnAiYiil3zq9/zrwZQdBxwBnRJshUoDvtLccglULCI81G/4A
	GkK0dM5/r3fqf7Xuz4G6tw58Nxx9/beCSTMyR/9idQx3P/qBNelZMDOVWVFWoRYpz5SbWyL
	7GOabwhtB3jRyAPvAKPGn6/EcVB7D0BIRPohaHZEGNjfCa3+j2ZwT5VrzBt/b9sO6HHqUH+
	ZLhUbYWBEZXeEjAQaWU3LybNPQY6o=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

But firmware not offer a NOP command.
(https://lore.kernel.org/netdev/8989E7A85A9468B0+20250825013053.GA2006401@nic-Precision-5820-Tower/) 

I will rename it like 'mucse_mbx_sync_fw', and rename opcode
'GET_PHY_ABILITY = 0x0601' to 'SYNC_FW = 0x0601'.

> > fw reduce working frequency to save power if no driver is probed to this
> > chip. And fw change frequency to normal after recieve insmod mbx cmd.
> 
> So why is this called ifinsmod? Why not power save? If you had called
> this power save, i would not of questioned what this does, it is
> pretty obvious, and other drivers probably have something
> similar. Some drivers probably have something like open/close, which
> do similar things. Again, i would not of asked. By not following what
> other drivers are doing, you just cause problems for everybody.

Sorry for it.

> 
> So please give this a new name. Not just the function, but also the
> name of the firmware op and everything else to do with this. The
> firmware does not care what the driver calls it, all it sees is a
> binary message format, no names.
> 
> Please also go through your driver and look at all the other names. Do
> they match what other drivers use. If not, you might want to rename
> them, in order to get your code merged with a lot less back and forth
> with reviewers.
> 

I see, I will check all names.

> 	Andrew
> 

Thanks for you feedback.


