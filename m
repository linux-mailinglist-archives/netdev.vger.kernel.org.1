Return-Path: <netdev+bounces-221923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9B0B525EB
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E21C83271
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6051C7012;
	Thu, 11 Sep 2025 01:46:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1182A930;
	Thu, 11 Sep 2025 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555219; cv=none; b=ugsGNSCTOy7Mcl3j2Gyt1QMUBcxa1kng0Zv4sNKrBnr2kLCZHaMmo7TppqILpxz0Sf7/5C+wlaXhd+BvzI+JOSsjvzL9l8XPA+bBmXs+BlOJO34M/p/rHpWGgnPhSvW/YmSkV9wMM7GCDO16s+w+ZKgO1QhKDqVeSsKRtDgKJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555219; c=relaxed/simple;
	bh=Quvnw4HtY1riqNXx80c3mdjoAI+Ws3rVYjGmILzWrwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFRwz3OJt8KVYZ6pkkk8AUhbvUpPdEdXMaN8h0Sr2cOMpSprjnk5lL5WODg3kfXj4Y3hIRf0qoAir5AewPA1Emjrckfc53RhYINPozUmq+UhpubeP+lIf3cDRHsJqS76ml2SvW0duYU4SQA6AMZ2gVFzAAq/w0/QfzRNrVCIqCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz8t1757555175tc409ef7e
X-QQ-Originating-IP: UCCnIvMWRRGFwnsIf4Xst+jxauXoZcRcccyhCHqkzsY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Sep 2025 09:46:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 435666682981691034
Date: Thu, 11 Sep 2025 09:46:12 +0800
From: Yibo Dong <dong100@mucse.com>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
Cc: Jakub Kicinski <kuba@kernel.org>, "Anwar, Md Danish" <a0501179@ti.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v11 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <D0FA3B21AAFDF094+20250911014612.GA1855388@nic-Precision-5820-Tower>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-5-dong100@mucse.com>
 <68fc2f5c-2cbd-41f6-a814-5134ba06b4b5@ti.com>
 <20250909135822.2ac833fc@kernel.org>
 <00A30C785FE598BA+20250910060821.GB1832711@nic-Precision-5820-Tower>
 <vfarjsi3uf55kb5uj25stnjriemyvra7gomxmtik3jowsp24n5@k44vc2gdmyaf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vfarjsi3uf55kb5uj25stnjriemyvra7gomxmtik3jowsp24n5@k44vc2gdmyaf>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NZcrde3zhHkVc4vD6pFJ0MtqYdCNebH6u2ep2Hql14kZ+IQEGGxv2qFv
	ohysdzHJ2nPG3Q6OW1GUJlrZjX04G7Sq2LzWlx53ZgRT2B8YnGyOYBz9cyOttm7yLH32Zna
	JYPXYAmWl37mpG9ezgcvkmjSgVZx4rzch4UU11yMr0ws+Jex/tWBRhMMhhWbqumzDh8/C24
	8WkyZXvKQveX8WKVnisR5cJe4CWVym/a2Xxk7gE30qZhM8gekKyuT1H0046ArWfByu2gYGy
	GW7yinUPVHJcnw5Sa3junvwaqOCr5oCC9x/O6vxXpjyGIAi5UJr5wwhQ5Z+6VJjv5o5iXoZ
	rDV2zGv/3/e3ykcZkjJ8SFR/e2ryjYn/p4hTIIDAy+xUccUZiL5qSs6HFGlWL6YBY9RKhWC
	XytyvUX8QzyL4Jp++cxdl7500+Jxi3Jdo5l0gQI38SOU2EvyzUIq0oMLnFHkZ4HM+8r+By5
	X6EQW/6FZHzSwiprdmnsJeNHvPR/io6Yu9QTqUBe0LPnvy7uypF1YhcGKZWFY6BV/0LDcrz
	KgJw6yXc2o1MiiTdXCR2d93XUBEuj/Q12gtDGA/16K1ZoxO3tXDbBr98S4nyTUd3lkuSYgh
	HGXett0EpFdB5LrgdwzKZe6vP2op38UQVI7uN+SMYbpF31FR5DeD4QAXi/kvkRHwkFofqoe
	7DeBoCoTVeQ6tZbPQMYWMve69fIU+KUVcBSpkte4E9S0wRIN35PqQm9dRXsvc2fLGRQUfe4
	3d9PmLx5BdupCLIbwn1oA8fHXy9iebjpBFh4c3ONW20yNkJInsv9avpf+Lk2b0EEPeLMSiy
	jaQiACLhSlLkmRzaf2AoAQsFvEzDubMWRoU173L006YGTcuBdwCU8IoZbS8AyCMY04rd23/
	bPk4e8YpHaDC7mkLK9omuJDMpI+l9e4O5Csc36I1IkUpjLi5Ls9rY3xntbJ0huin/3B9uTy
	phaYSoWFZ2ZHkp23kwULIOJd11MvmUO8T3dV2I3IiEtnTc40kznuv4Oc3u1XOU14lmPQz46
	3Hzf/z9akPyBzZEr4BCCHtSRU1/zQtCcGwmXqp/Q==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Wed, Sep 10, 2025 at 10:21:58AM +0200, Jörg Sommer wrote:
> Yibo Dong schrieb am Mi 10. Sep, 14:08 (+0800):
> > On Tue, Sep 09, 2025 at 01:58:22PM -0700, Jakub Kicinski wrote:
> > > On Tue, 9 Sep 2025 19:59:11 +0530 Anwar, Md Danish wrote:
> > > > > +int mucse_mbx_sync_fw(struct mucse_hw *hw)
> > > > > +{
> > > > > +	int try_cnt = 3;
> > > > > +	int err;
> > > > > +
> > > > > +	do {
> > > > > +		err = mucse_mbx_get_info(hw);
> > > > > +		if (err == -ETIMEDOUT)
> > > > > +			continue;
> > > > > +		break;
> > > > > +	} while (try_cnt--);
> > > > > +
> > > > > +	return err;
> > > > > +}  
> > > > 
> > > > There's a logical issue in the code. The loop structure attempts to
> > > > retry on ETIMEDOUT errors, but the unconditional break statement after
> > > > the if-check will always exit the loop after the first attempt,
> > > > regardless of the error. The do-while loop will never actually retry
> > > > because the break statement is placed outside of the if condition that
> > > > checks for timeout errors.
> > > 
> > 
> > What is expected is 'retry on ETIMEDOUT' and 'no retry others'. 
> > https://lore.kernel.org/netdev/a066746c-2f12-4e70-b63a-7996392a9132@lunn.ch/
> > 
> > > The other way around. continue; in a do {} while () look does *not*
> > > evaluate the condition. So this can loop forever.
> > > 
> > 
> > Maybe I can update like this ?
> > 
> > int mucse_mbx_sync_fw(struct mucse_hw *hw)
> > {
> > 	int try_cnt = 3;
> > 	int err;
> > 
> > 	do {
> > 		err = mucse_mbx_get_info(hw);
> > 		if (err != -ETIMEDOUT)
> > 			break;
> > 		/* only retry with ETIMEDOUT, others just return */
> > 	} while (try_cnt--);
> > 
> > 	return err;
> > }  
> 
> How about something like this?
> 
> int mucse_mbx_sync_fw(struct mucse_hw *hw)
> {
> 	for (int try = 3; try; --try) {
> 		int err = mucse_mbx_get_info(hw);
> 		if (err != -ETIMEDOUT)
> 			return err;
> 	}
> 
> 	return ETIMEDOUT;
> }
> 

I think Jakub Kicinski's suggestion is clearer, right?
	do {
		err = mucse_mbx_get_info(hw);
	} while (err == -ETIMEDOUT && try_cnt--);

> 
> My 2cent.
> 
> Regards Jörg
> 
> -- 
> „Es wurden und werden zu viele sprachlose Bücher gedruckt, nach deren
> schon flüchtiger Lektüre man all die Bäume um Vergebung bitten möchte,
> die für den Schund ihr Leben lassen mussten.“ (Michael Jürgs,
>                       Seichtgebiete – Warum wir hemmungslos verblöden)

Thanks for your feedback.



