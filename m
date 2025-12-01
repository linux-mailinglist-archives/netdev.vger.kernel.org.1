Return-Path: <netdev+bounces-242864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C33EC9581B
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 02:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6463A2AF4
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 01:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287B735958;
	Mon,  1 Dec 2025 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RfVSjdyz"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970436D4F7;
	Mon,  1 Dec 2025 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764552992; cv=none; b=ecxOrrnpyKQ2CgOO1wumJUoHr7gVB7yvdz7DxlNqRg/eSB0kHngsjIladOcfGl6RYekTexav006flTazWTicSH+lbEaBbsZKVtcuYbqkeEpIT7T9LW2U9jET8E3OJgXJC/fWld5WLyfkkcm7ou+ADxxNMfx6FQnZ1/CxjurgWls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764552992; c=relaxed/simple;
	bh=i5JtFS7XLtOcD5HB7iMuaTFHZMasDhQNzqAqotDDq78=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dzQCJK04HqRrNVDAyh2zCiwJDXKh9vqOgpi8GsiZGAD58/Lz6blEkuOK8WQTCqIUU77XYM6f0DgCHXCwd1+KKO39c0KNR5T+cto8TN02NPipeN4EpvznVtc6eAvDDmNuEEg5ax2LHeUO/aknhzCP/Y0UWVNpZzNs/mCWBK7Vqaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RfVSjdyz; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1764552978; bh=WoR00mXRqcmIrzUT/ZjLb+MO4Y/wZIXJqzDfcrLYEJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RfVSjdyzGnKRpk2pc6BK5739M7C+AE2XnWBBxa/shmJLVSVkvPdOQF0YU/V8sWbZg
	 nvVg0oz2CXFuFz12rlbWGD+vhsKzaOEtWza9NApJebYOCev0pssVUyoeqEkVutqFyC
	 CEm5EN89UMbLOWszFjodOuwtP9kDfUquIsOyI2y0=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 8BBB22EA; Mon, 01 Dec 2025 09:34:59 +0800
X-QQ-mid: xmsmtpt1764552899tiab0swj4
Message-ID: <tencent_AF3D7D376E965E371A4BBE74CF765566DE09@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8BOSjpyDRh6RdCIM9WyWIAuA/crt8obmgqvwrv9ObpXfKcolT+5
	 w1YoBx7cVYmcMJU/kEPaYL+OhYmMOfsQSLie0bYaVI0vBHdpUs0Sadbidu0qLcpQuM+UZ7wdyZFB
	 pXSuGdZd1q5BBHEh+qAPZxW+MpnI5+HWNJgVJkAZi/PPyQnXN88KJSK3D67nBzOg23yjE7xn7air
	 GjKi7ov/lZrYlcoKmy/E4fzfpYUdp99twYLrE5Z9zEM7eV5w73oEsMKYyq74KA2bwDvT/NT38Ks6
	 ksVM8PQtn74zsJMu7Rel775KUYNl2cnacPoqeEw6PdJuWEWQ4TTXHsC37B5lQ1CX5xUcVnt/G308
	 qJyxKD/YQFa/wMyGx60dP4MdO1h3v1WtS7cIxTJ1zS+sxN/cAihoLYuwUIizk08keBWf+0keoSSZ
	 q4sCUA1IsqpbF3Q/8x+XVIkCa6xrVvHChPbSkEtIbC7VglTrWuzYbTspI0lAuJGfpuKCoeogHYoc
	 W+fHEPqiDqUCfPv7u/m0FIyrhrgbxDHhgsM6OVcyj9UD5jWeSihwIo5XMJVInzhV7o+BHblwPTuB
	 s1cFA6BSzPjRGPGGyVZ5sjfKkwLUDdFPhqzhAfTvn1awZUKhLmRWMVFr4EMUG0BkJ0KsWd3KAuvh
	 mtg2fX7mFEJRHfiqm2zg1JLc0xy3DXQ8IhmAf8mbLgI5YiVk4OQMO00fLFdzni4+E8767krU89B4
	 ONilCrinNe1FigjHcJvoNwb4OltNr9LFYsA/ET90gu0TOp4VBUs8LmyGwScydSfxcJ5A9T2U6cH+
	 mQlxt8y5c0+Y6nUOTyoj27sFPtQUNDjfKs2azyc1749dQ8LJdsgX7rUJf/JzHgjvSF6sgIWw+A1e
	 OzQi74oyRQb8IYjfHZMTZwk7TbwUuEr/ADvRPJqOpuoU4iHUa7PJWHzi0KGlygKds9BeoEVFaFmN
	 IrJztLSy2FZvG3hHdmssIMRofQgqe3oLTEqUTypwQ4oyUwMQUOWcRLShclqMH8brfNuIBywel/KN
	 ITgZSN6ba4ZAMepRGfJNAbc9drt7DHBno+e+75AhRWzyuNJkDN6lElH6MK+SI=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net: atm: targetless need more input msg
Date: Mon,  1 Dec 2025 09:35:00 +0800
X-OQ-MSGID: <20251201013459.200747-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aSxpOjsmyMPlB-Mg@horms.kernel.org>
References: <aSxpOjsmyMPlB-Mg@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sun, 30 Nov 2025 15:56:42 +0000, Simon Horman wrote:
> > syzbot found an uninitialized targetless variable. The user-provided
> > data was only 28 bytes long, but initializing targetless requires at
> > least 44 bytes. This discrepancy ultimately led to the uninitialized
> > variable access issue reported by syzbot [1].
> > 
> > Adding a message length check to the arp update process eliminates
> > the uninitialized issue in [1].
> > 
> > [1]
> > BUG: KMSAN: uninit-value in lec_arp_update net/atm/lec.c:1845 [inline]
> >  lec_arp_update net/atm/lec.c:1845 [inline]
> >  lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
> >  vcc_sendmsg+0x1052/0x1190 net/atm/common.c:650
> > 
> > Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
> 
> I think it would be useful to also include:
> 
> Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057
> 
> And as a fix for Networking code it should include a fixes tag.
> Briefly examining the history of this code, using git annotate,
> it seems that this problem has existed since the beginning of git history.
> If so, this tag seems appropriate:
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> Also, as a fix for Networking code present in the net tree,
> it should be targeted at that tree, like this:
> 
> Subject: [PATCH net] ...
Thanks very much for your oppinions. I will send v2 for it.
> 
> More information on the Networking development workflow can be found here:
> https://docs.kernel.org/process/maintainer-netdev.html
> 
> 
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  net/atm/lec.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/net/atm/lec.c b/net/atm/lec.c
> > index afb8d3eb2185..178132b2771a 100644
> > --- a/net/atm/lec.c
> > +++ b/net/atm/lec.c
> > @@ -382,6 +382,15 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
> >  			break;
> >  		fallthrough;
> >  	case l_arp_update:
> > +	{
> > +		int need_size = offsetofend(struct atmlec_msg,
> > +				content.normal.targetless_le_arp);
> > +		if (skb->len < need_size) {
> 
> As per Eric's comment on a similar fix [1],
> you should probably be using pskb_may_pull().
The pskb_may_pull() function performs a more thorough check of the skb
length, which is especially suitable for handling non-linear data areas.
> 
> Also, I see that this patch addresses the l_arp_update case.
> But it looks like a similar problem exist in least in the l_config case
> too.
I noticed this, and it's not just these; several types of atmlec_msg
handled in lec_atm_send() are also involved.
Strictly speaking, they all require relevant checks.
> 
> So I think it would be useful take a more holistic approach.
> Perhaps in the form of a patchset if you want to restrict this
> patch to addressing the specific problem flagged by syzbot.
Okay, I'll carefully consider how to handle the others.
> 
> [1] https://lore.kernel.org/netdev/20251126034601.236922-1-ssranevjti@gmail.com/
> 
> > +			pr_info("Input msg size too small, need %d got %u\n",
> > +				 need_size, skb->len);
> > +			dev_kfree_skb(skb);
> > +			return -EINVAL;
> > +		}
> >  		lec_arp_update(priv, mesg->content.normal.mac_addr,
> >  			       mesg->content.normal.atm_addr,
> >  			       mesg->content.normal.flag,


