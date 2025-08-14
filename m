Return-Path: <netdev+bounces-213754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF82B26865
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696A55E65F3
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9894D3019A3;
	Thu, 14 Aug 2025 13:56:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A843002DB;
	Thu, 14 Aug 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179777; cv=none; b=KvblzUYFX/qZPUAeMpWz4I6wI/nbltdVo136OFagnqypUM85wb4mbq7ErHnBfnsL8kfNW06GSRIQDmbEQJBwfmgz9w97ifGMrJRanndEkeDv2OKZ8GMJ4g379yBzKDWgk/drfuBDFRUwKSPJNpKc741r1UBoOxOfe5Xv/Fc1RjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179777; c=relaxed/simple;
	bh=FY5sbNBK7qZlnMcmmL7hNtLU1I+7sRKJWqEJAf4IRlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GglJZeI2UEK3aLJ5770UdZAqGBg8GAzVrShhIpiRAoeThNUosG314XPvurwWasa86s7VUP/ZxbKPfR1Xqxqgrak5czfZsWuEEu8pNn6I8sCgjN/Ge/BL8kWe7qbJBm99twNi9GufInFzXjVUMuom9o1c1vLwkdWDip7McysVnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz9t1755179680t7764a06f
X-QQ-Originating-IP: kAirI4c1dFDqOa0MCUTbPS30JYAfzpXeBXjviMMwVKo=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 21:54:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2664948985724009700
Date: Thu, 14 Aug 2025 21:54:37 +0800
From: Yibo Dong <dong100@mucse.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <3866866DBCE66734+20250814135437.GB1094497@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-5-dong100@mucse.com>
 <c69d6a87-3d9f-49dc-836e-f33508c62c1a@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c69d6a87-3d9f-49dc-836e-f33508c62c1a@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M18A+sp1qNHzq4pS8N4zhVqEyqkwpR7zx0f9witggg/dsBSbKWlYGfF+
	KSC3lTws0MRn5ALXJj3gWlUBde/tPG8qQZIuw9kYIoRZfRZFFtLRp+junxyMZti2Y0gpduW
	YJvddH7f3qf9BSTA5DlQbk7u4lQOr81HEloppjsHkh4IY0H4N0j1iGLdtiSFmC7Tiep5KtS
	x5HCbA5ul6dHGomY8MnWW0mF4TEIetJeX+JpNx70Y69THDIlK+LDPGsT0snlthmprBriTCX
	gLjd5NXoy++aH4VXnniVSMjqSTcpE+GTDgXx0Y9ClnxggdliMF1Zhm+TaIcpY3n4mZuGgke
	r91IrVzsmG1cXNYDJOMnxFI+mgoaYnzgBVsSAkE2WC2yOOf23Vf564Ju7WfUROmfH3lmIbz
	oxhyuUqnz0GkXDFo3xuiIYkJKLbPQnu/D8kuNE8OM5R+bIXCZ8TjPer9yIOS6SKuFgxyAHN
	JWDBSBQg/O4lTgpE7zDkYTG3vbd8ihzhTF4zhVTWiwrc2ANPUClZogOFwW85B2YORNc/nUX
	Tw3t5IqeEZDNTAxEqPPZLp6isxWQck0MbYfrXVg9Ng1Rlp2nr8nkkOO+L8voZ/E8B1HDF3j
	BmD8X7NhUAyPd14ehGsElAF88EpUCfIfTt0y1KAtwsfTlx0vXFuKxkzz90tRRqyby/VPZ2E
	Madd51B/uDQTEwJ0O+IOE8eKQQfg6BpPytaA+hIbG1fonPhJPRqn3ZfmwH46QPy/letg+QU
	B9Cmw0mRbrZrgSIqOirE2lanKLFbdwrR0DcelfVeZJvc/jFnTMquoosSt4s0h5RPUKhNlND
	gMbW1ojh9bKBSXBy4wHnI+HJGcVoe3bFhvVJe7AzRckIGs9m8y9pXE6w2WE5c/qS0bh7UcD
	2ajtooU3vBi8EoJZmYDSQ2sSvbaNl6YvVqOACdx4qk4boRWpiSdNMMI4uH/szhcvORE71/G
	q2goKo/jxgMfHnfjGbEYM2rbw2Mku9KbuAwxBYgVx8bFIv0rFKBY//hgPQNwAeHnulXuGFd
	rHcFCNrbtfvTuuPIpuut2ALHBsU8M=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Thu, Aug 14, 2025 at 05:40:14PM +0530, MD Danish Anwar wrote:
> On 14/08/25 1:08 pm, Dong Yibo wrote:
> > Initialize basic mbx_fw ops, such as get_capability, reset phy
> > and so on.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   4 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 264 ++++++++++++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 201 +++++++++++++
> >  4 files changed, 471 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
> > 
> 
> > +
> > +/**
> > + * mbx_cookie_zalloc - Alloc a cookie structure
> > + * @priv_len: private length for this cookie
> > + *
> > + * @return: cookie structure on success
> > + **/
> > +static struct mbx_req_cookie *mbx_cookie_zalloc(int priv_len)
> > +{
> > +	struct mbx_req_cookie *cookie;
> > +
> > +	cookie = kzalloc(struct_size(cookie, priv, priv_len), GFP_KERNEL);
> > +	if (cookie) {
> > +		cookie->timeout_jiffes = 30 * HZ;
> 
> Typo: should be "timeout_jiffies" instead of "timeout_jiffes"
> 

Got it, I will fix it.

> > +		cookie->magic = COOKIE_MAGIC;
> > +		cookie->priv_len = priv_len;
> > +	}
> > +	return cookie;
> > +}
> > +
> > +/**
> 
> 
> -- 
> Thanks and Regards,
> Danish
> 
> 

Thanks for you feedback.


