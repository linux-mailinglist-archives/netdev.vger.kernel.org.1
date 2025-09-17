Return-Path: <netdev+bounces-223971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F868B7D531
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E20F7A861F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBDF2C21E2;
	Wed, 17 Sep 2025 11:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E002DAFA5;
	Wed, 17 Sep 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107175; cv=none; b=W3ytlmWshnfH9h0We00xQryL8hDgUP++7ZlBuYK6RBDIFoc4DzS0VFNCZR3cZ9WmkbjzWIOTM7+FZYLejA+ykAQst4ZvdDxLoqmjlhKo990A9PQbODHzpQKLJuctpx199F0zDxULmWSHe7VSYc8d2Q+LCYh/eSd12ABnGJOw5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107175; c=relaxed/simple;
	bh=qUsp7FIwmTAFssINAeQmhTm8DdUAGD6ER7hbOPzidRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogkwLOfNX+zcEWKguJjecK8Dp882f/obZBxGrN37iu1KY89tIC+jVVPlU5KDhlAIDKrkcpkllh6xhfq4MFgYws/PMSgLcvebXS5eTl10uC4Az6Gw4XmGR9ffw1JK0xFZv85DaMrxB1WR00AchCgxeVWjRWl4RvWV3pziL+lQEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1758107143tfd4595b3
X-QQ-Originating-IP: KyjLbqrSwWDsBL167vTWTlsLOGuQf/XO+VF1mGtMYgQ=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Sep 2025 19:05:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14013483781731506798
Date: Wed, 17 Sep 2025 19:05:40 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org, joerg@jo-so.de,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v12 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <D7EC5E8B6F6E685E+20250917110540.GA91482@nic-Precision-5820-Tower>
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-5-dong100@mucse.com>
 <3058c061-3a17-4077-8d4e-c91ad72b3831@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3058c061-3a17-4077-8d4e-c91ad72b3831@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MnvGtZwO7LbyrzQzy3gSHZpndqqwTFAD5/Ae+NgTmFBU3bMcwjYbP9X4
	JygP+AELsD9LsI6vEN5nT9Sn+Jx33MzhoY5CycW1lXPnpPquSXTtb1fiDRyWRK3hbIYkEcs
	TpEHel0XMPaNIzv91OfktmfkF8v6L0prtnbgl5uEiIq4b7gyGT59Q2oDaqFVDP6oIHePRtP
	3Z02o4hmjgAjWrPDJ/eirNyr2/0e/IyXA+KDqY8xtsTzhLwIkFPy/4y+rrs79AvnAh9KXkl
	07mw0+FoHAkiRrGk4iVx120LnNUG6JL+k7nq3hJ8AVmGVbvX/JwTlXU8NfpoJ2AtkbCoNC5
	TF5aA91iewsjDKkaOOo4Ywzb1gHitCxuSEU45M9l8W1al+46F5xxk04pDdrIT7Qs4XYqaE4
	fsmwuKgZKGa85Auy00JK2CQ3FUYo6vvYeM5u4Gj1LgrgJdOJu+NxOPofjK/xzyuc28WMIfH
	5ssTzCFEW/ZGePPkamaWB5yc/+2yp/wMvNL2V8P2RPmIKP+lFtI/xX8PhVHYaIkvRrvIbHD
	53GrWF81/VW8JMnjSklS7xDFB8afGeJVe0Qv0knuaTm96O4EU50Fe8yd/NkxG/ixZbCsPs6
	NRVJZEtxbETljjMujNrK5J4Qu0vzTu41C4WLb4JNQa0VETovxx5ECpsvqdNPrB76EdmPSqS
	GS5APoy7YAww9vsyw2r3buItsteWzZXkgU93wnEe/ofZK/j5DITAQ9x92EqIRIh9bc8x6U5
	hw0Vya09oIBVxMdll0WGciNwcwwPA5DzPaRTc1NODP6TL6sz9KD9Z3Bfg39+zx/vokSDnZU
	TPz53oN19CF1Kwai2+7N2gmL2ne5OHj2l/LcvPfLs/J8k6BrsqqqVuW8nA4mJdJMtJSTAWh
	1QqiLCvaSKZWU04D5I9BhuArYln3eWezSFKxJLH/GdbSBYHenHbXkMpsMT5l3p0GHTtv60L
	oe8PND9S7Bz0oJ6AaUWpwoHm2Xh6AO7ZNZjxdMHoD2z+xI/hLV0566KNU50uy37SvfAOOfE
	qnzlWp0teWx8xpDy52
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Wed, Sep 17, 2025 at 11:45:31AM +0100, Vadim Fedorenko wrote:
> On 16/09/2025 12:29, Dong Yibo wrote:
> > Add fundamental firmware (FW) communication operations via PF-FW
> > mailbox, including:
> > - FW sync (via HW info query with retries)
> > - HW reset (post FW command to reset hardware)
> > - MAC address retrieval (request FW for port-specific MAC)
> > - Power management (powerup/powerdown notification to FW)
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> small nits below
> 
> 
> > +static void build_get_hw_info_req(struct mbx_fw_cmd_req *req)
> > +{
> > +	req->flags = 0;
> > +	req->opcode = cpu_to_le16(GET_HW_INFO);
> > +	req->datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN);
> > +	req->reply_lo = 0;
> > +	req->reply_hi = 0;
> > +}
> 
> All these build*() functions re-init flags and reply to 0, but all
> mbx_fw_cmd_req are zero-inited on the stack. Might be better clean
> things assignments, but no strong opinion because the code is explicit
> 
> If you will think of refactoring this part, it might be a good idea to
> avoid build*() functions at all and do proper initialization of
> mbx_fw_cmd_req in callers?
> 
> > +
> > +/**
> > + * mucse_mbx_get_info - Get hw info from fw
> > + * @hw: pointer to the HW structure
> > + *
> > + * mucse_mbx_get_info tries to get hw info from hw.
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +static int mucse_mbx_get_info(struct mucse_hw *hw)
> > +{
> > +	struct mbx_fw_cmd_reply reply = {};
> > +	struct mbx_fw_cmd_req req = {};
> 
> something like:
> 
> struct mbx_fw_cmd_req req =
> 	{
> 	  .opcode = cpu_to_le16(GET_HW_INFO),
> 	  .datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN),
> 	}
> 
> 
> 

That's a good idea! That makes the code more compact.
I think I should update this as your suggestion.

Regarding adding your "Reviewed-by" tag in the next version:
Would it be acceptable to include it when I submit the updated patch (with
the initialization logic adjusted), or should I wait for your further
review of the modified code first?

Thanks for your feedback.


