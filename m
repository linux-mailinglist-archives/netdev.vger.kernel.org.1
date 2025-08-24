Return-Path: <netdev+bounces-216266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F3CB32D79
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 06:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2018F207E68
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 04:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A0A1EE7DC;
	Sun, 24 Aug 2025 04:11:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743D1F09A3;
	Sun, 24 Aug 2025 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756008677; cv=none; b=W6WhYX1uDEw+iw0aiPfgh83aQR1/zVOSqR9QFTxZbyCsWFKv5HjMEHtVP5Xk30BnkZmag6PbncMCsEbk9I7JgmKefU41d2A4C5z4wWC2lLoXk1boQwEhjvNyA0l2/5JXRm6Rem69ExjnhhAGYUhGBTz3+3lVzom2/HvtIFnEfIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756008677; c=relaxed/simple;
	bh=eB+zjcUra3bYcA5QWUOIAXeG5bTP7GkgqMHVuIlrCJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9Xo38RFRm+vXdDbisG47FrhItiYL9F0SHXZnbe4KGNoSgJEqnn6WU8DbMrotdACIuHboDgFwngd0pXOk/+zUem7lKid+GlmiEo3ovFtijy+YotTyM/RdCfSjDkX+S1IFjbqlHQtnxGeGWkL9mwd+nPdx5Yx23vPeQVLDi2X9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1756008655t540b1348
X-QQ-Originating-IP: EPudnYuXcQD4DchPgHmnm0BlP6r/SlIAuyr9jAbEI0g=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 24 Aug 2025 12:10:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14133604353308470334
Date: Sun, 24 Aug 2025 12:10:52 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <424D721323023327+20250824041052.GB2000422@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <a066746c-2f12-4e70-b63a-7996392a9132@lunn.ch>
 <C2BF8A6A8A79FB29+20250823015824.GB1995939@nic-Precision-5820-Tower>
 <f375e4bf-9b0b-49ca-b83d-addeb49384b8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f375e4bf-9b0b-49ca-b83d-addeb49384b8@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MlIcwAHh6GgKwOZPVFa7QyiDhPPc5muSlo7ME3Vkev37thWGpSwAyWc1
	UfplUrPB6fXqP3/p8mxUB/Lr229y+PLDVEkxgQqO/gDo1A8JHIrP3WD+ZGzi7fdeL2TJUzZ
	lB+EpQF1IIiL7ez4Rr3oKTSAkj/9R9lckis610pRM+V9HzoWHEz/OUQCmJKkO6ebki05xUC
	XeDgfc3eQip4DLVQm8+4yBM+muzYbuAKTttNKxkl7d8C+GmOids7ROEtAUuyiwJLl00bus8
	eBfcejzf9hADJgku32637Tdt/O+xTKO+38Ia82O0LUjdSIdaCvam0H/ILgAIEBaC+NPfiwN
	mmxXgFvdK7OfaGjACc7f1ag77ArvAn7ozB4uDTEMzOCbbeMwJn1iK6VsjnMbxCy+C7aOrEY
	CzwEoZUyKzTJcKdXHBouU9zMCZANCqZve2iXa1cmjvlScg3W2hu5Z5rQ05DXiwaPUMjJ7ZY
	gdmPGjriJgiMNOGH7qGviGElUm3PUy0RyyAwRmL/IgVan/8G52CIiGv7DefZMC91/S3YBl2
	izRXCuBQubVCONImVbD9AbfaLiQbo8pAth1uuYA3YsBA3l9BlhGvGA7imROdobQkG9LSVS5
	uIczCmnv7X0QCp0+BN1rwl/OB0mY5uxjanws9FTzHBBuGbS+zJyWZaPrsFiJNgzOaCwlOX/
	b8Wev/t49mEe/0jNmLeymQRj40da7uj0Vu8fjHWoPScqnBtN0Og4hLbRA+Ys8OWOJeqhGqo
	gS9ms5F6L21Ewl85PyQiJDl8+Gd7E6K8fIKdnrSUaCvknw/gHDg4D8faO466S3e9Tu1uEDm
	zDQJ4XJveJ0BtP4YFQrRiPVDyXFVFPRiwBR5IieFpkn2mLJzTm9N5Jq7SvjCNnxMbaaAQP0
	lo33OSUbcffLbes2qGBlAaJHeExh8QC4g9qHqlzlm6I3xIZe8bARmVQljewj+EIggT5l6jd
	Ip7CfGssxCVyVWW3wVVcoyVh/jbD0upiYozbw0KZauFcbfJETJVvQRS84/hw6qB0RgZwcHz
	NdaqdeeXkbJd1cc2wQ
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Sat, Aug 23, 2025 at 05:17:45PM +0200, Andrew Lunn wrote:
> On Sat, Aug 23, 2025 at 09:58:24AM +0800, Yibo Dong wrote:
> > On Fri, Aug 22, 2025 at 04:43:16PM +0200, Andrew Lunn wrote:
> > > > +/**
> > > > + * mucse_mbx_get_capability - Get hw abilities from fw
> > > > + * @hw: pointer to the HW structure
> > > > + *
> > > > + * mucse_mbx_get_capability tries to get capabities from
> > > > + * hw. Many retrys will do if it is failed.
> > > > + *
> > > > + * @return: 0 on success, negative on failure
> > > > + **/
> > > > +int mucse_mbx_get_capability(struct mucse_hw *hw)
> > > > +{
> > > > +	struct hw_abilities ability = {};
> > > > +	int try_cnt = 3;
> > > > +	int err = -EIO;
> > > > +
> > > > +	while (try_cnt--) {
> > > > +		err = mucse_fw_get_capability(hw, &ability);
> > > > +		if (err)
> > > > +			continue;
> > > > +		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> > > > +		return 0;
> > > > +	}
> > > > +	return err;
> > > > +}
> > > 
> > > Please could you add an explanation why it would fail? Is this to do
> > > with getting the driver and firmware in sync? Maybe you should make
> > > this explicit, add a function mucse_mbx_sync() with a comment that
> > > this is used once during probe to synchronise communication with the
> > > firmware. You can then remove this loop here.
> > 
> > It is just get some fw capability(or info such as fw version).
> > It is failed maybe:
> > 1. -EIO: return by mucse_obtain_mbx_lock_pf. The function tries to get
> > pf-fw lock(in chip register, not driver), failed when fw hold the lock.
> 
> If it cannot get the lock, isn't that fatal? You cannot do anything
> without the lock.
> 
> > 2. -ETIMEDOUT: return by mucse_poll_for_xx. Failed when timeout.
> > 3. -ETIMEDOUT: return by mucse_fw_send_cmd_wait. Failed when wait
> > response timeout.
> 
> If its dead, its dead. Why would it suddenly start responding?
> 
> > 4. -EIO: return by mucse_fw_send_cmd_wait. Failed when error_code in
> > response.
> 
> Which should be fatal. No retries necessary.
> 
> > 5. err return by mutex_lock_interruptible.
> 
> So you want the user to have to ^C three times?
> 
> And is mucse_mbx_get_capability() special, or will all interactions
> with the firmware have three retries?

It is the first 'cmd with response' from fw when probe. If it failed,
return err and nothing else todo (no registe netdev ...). So, we design
to give retry for it.
fatal with no retry, maybe like this? 

int mucse_mbx_get_capability(struct mucse_hw *hw)
{
        struct hw_abilities ability = {};
        int try_cnt = 3;
        int err;

        do {
                err = mucse_fw_get_capability(hw, &ability);
                if (err == -ETIMEDOUT)
                        continue;

		break;
        } while(try_cnt--);

	if (!err)
		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
        return err;
}

> 
> 	Andrew
> 

Thanks for your feedback.


