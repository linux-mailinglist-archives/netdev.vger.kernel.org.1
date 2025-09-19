Return-Path: <netdev+bounces-224658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E4AB8794A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 03:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6949D7C615F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3241DB92A;
	Fri, 19 Sep 2025 01:18:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E9635;
	Fri, 19 Sep 2025 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244691; cv=none; b=sEc6qpHza6Su8J/shrRwI7iJfWy3go7lK+G7H4u2bNuTv5LUVjm+jMYpeUaWCt0U/WSRkHlml/ZB/Yk4IymnlxLCX0NoXfYmyZqtqsZYFB8CHNvySvt6Nhp3vzi9y3dGGt7QGRhyNldWvS+i9YkZq5YSnLlJIQan9Xx3nyeX8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244691; c=relaxed/simple;
	bh=KfIMDG1uhk7mdManaKAb7Xl0e41w4jmdmNJOvYjMtmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vhff6p4+0A1JgOm7jVvlRjvtjHUrmDid/5u1PBNQX4KU0wdd9t626LuWEeZEkr1p7cOuvEWC+iBN5P2anxlxEJZqE7YHG/yUVdYxaf9oM2uSV7Ex+ZDLhu5vWQeS4D14OXM+bMNIE8jKkIG97Gqc66xCD5z214ZV2XKhcrg4bmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1758244656t34bd8618
X-QQ-Originating-IP: 98o6iFAarl7VbsuD0/5ogEYv6yQqe2Fnbu8FQliCn4s=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Sep 2025 09:17:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11517621768531048136
Date: Fri, 19 Sep 2025 09:17:33 +0800
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
Message-ID: <3E609187B0C91716+20250919011733.GA174153@nic-Precision-5820-Tower>
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-5-dong100@mucse.com>
 <3058c061-3a17-4077-8d4e-c91ad72b3831@linux.dev>
 <D7EC5E8B6F6E685E+20250917110540.GA91482@nic-Precision-5820-Tower>
 <fb8f876a-c2e5-49b0-bc64-bdf18ecd1ce4@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8f876a-c2e5-49b0-bc64-bdf18ecd1ce4@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OF6/1i2Al/nJzNgnnrzdpHialpMuzFFg1E0Mt0PxzLZcwzoBP3UhvWtC
	aDGBwL72GcWN1OtQkNmsua+D6kYeO1g4ZXxaR5ZFniJVSGjOCR7/HQnfqZeDQH4VcLzBGx8
	eWMv6HkK2hox7eBurez0ZkBlhtIWNSmORd1gblgjkGGMMsEhrqtgTTL/Wt751ZkgvN+mGf4
	StKhZ9fNs//IwuzCnk3H8Nf3AmZGOrxD0zplZ6Nlc5WCUASXSEHPxm+ohKyoqiwr+PN0rnG
	J0KdTdWdJ2E7yQ42KK05uW0OsbamrnJapigbJ6lcSpNHY3FbqxdsakmDgq58kC/WeN0Lrwj
	zTshZpbZRe8/E04zBkJVW5j8kYDiSaNERUVDXJfHxMi//Pn/ivBdUZKlJD9kOOV548E/9Td
	1V+xlCiq+uZsfIM4iejRPbDmuQ1x9ABCkGPefz9uGXN4KNJqZ9rfKXgiBDNzU0zSf6jiRTk
	sRIL7x9rr6TKa+lzPHnb47LQ+SaN1E8zjdhsQo7BJDsLmPWkfhMw+f3WEIEoRop6kbW+9Hp
	thzZFKy0BM7UIiR9irk6vnwKlUrnwwjqBIosVPEtG0HXpMqKMV/0Vwl7D9FfGsbwa2zkYkO
	IZkjEWmvyMhujj1cshNFub7wgXnQl0vLwkrXuQYYHX2qm3+3dG7gcRu6szUbzJzmxJ9cuOC
	ajp/8nG3PIblhYIpSvxHN9y2lsnxdnbkLPNRuNdY0rxrxM++Fyl8r9lCxQdWmUdcqvd91NY
	KW/Aay6ML60I5nzRylq7y6qH0wML9MlR/FuYcObG2EIaMS9IOnjJJe9T4KzGnObDhlB9TsU
	kdlJ1bIttAnNQdDAJNY2KWnTaZ/kMtWxNlNZ51sBznN77km/R+B2Au6MrBQh8JsNXd6ZdVI
	yXdj8QbwwbAazLkkdIBZEm2O9wmO28l8TDNGL80Odnt0U2eCbbNrVrkXWvGcKM3v80A+FUF
	tR0E2Rhgc7y8nmtzT07vteSgST3WYGwM7iCszN54Mq70Y9/+v61/nwVvt
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Wed, Sep 17, 2025 at 03:02:13PM +0100, Vadim Fedorenko wrote:
> On 17/09/2025 12:05, Yibo Dong wrote:
> > On Wed, Sep 17, 2025 at 11:45:31AM +0100, Vadim Fedorenko wrote:
> > > On 16/09/2025 12:29, Dong Yibo wrote:
> > > > Add fundamental firmware (FW) communication operations via PF-FW
> > > > mailbox, including:
> > > > - FW sync (via HW info query with retries)
> > > > - HW reset (post FW command to reset hardware)
> > > > - MAC address retrieval (request FW for port-specific MAC)
> > > > - Power management (powerup/powerdown notification to FW)
> > > > 
> > > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > 
> > > Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > > 
> > > small nits below
> > > 
> > > 
> > > > +static void build_get_hw_info_req(struct mbx_fw_cmd_req *req)
> > > > +{
> > > > +	req->flags = 0;
> > > > +	req->opcode = cpu_to_le16(GET_HW_INFO);
> > > > +	req->datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN);
> > > > +	req->reply_lo = 0;
> > > > +	req->reply_hi = 0;
> > > > +}
> > > 
> > > All these build*() functions re-init flags and reply to 0, but all
> > > mbx_fw_cmd_req are zero-inited on the stack. Might be better clean
> > > things assignments, but no strong opinion because the code is explicit
> > > 
> > > If you will think of refactoring this part, it might be a good idea to
> > > avoid build*() functions at all and do proper initialization of
> > > mbx_fw_cmd_req in callers?
> > > 
> > > > +
> > > > +/**
> > > > + * mucse_mbx_get_info - Get hw info from fw
> > > > + * @hw: pointer to the HW structure
> > > > + *
> > > > + * mucse_mbx_get_info tries to get hw info from hw.
> > > > + *
> > > > + * Return: 0 on success, negative errno on failure
> > > > + **/
> > > > +static int mucse_mbx_get_info(struct mucse_hw *hw)
> > > > +{
> > > > +	struct mbx_fw_cmd_reply reply = {};
> > > > +	struct mbx_fw_cmd_req req = {};
> > > 
> > > something like:
> > > 
> > > struct mbx_fw_cmd_req req =
> > > 	{
> > > 	  .opcode = cpu_to_le16(GET_HW_INFO),
> > > 	  .datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN),
> > > 	}
> > > 
> > > 
> > > 
> > 
> > That's a good idea! That makes the code more compact.
> > I think I should update this as your suggestion.
> > 
> > Regarding adding your "Reviewed-by" tag in the next version:
> > Would it be acceptable to include it when I submit the updated patch (with
> > the initialization logic adjusted), or should I wait for your further
> > review of the modified code first?
> 
> If you will submit another version with this refactoring, I'll better do
> another review.
> 

I see, I will submit another version later, with this refactoring.
Looking forward to your next review.

Thanks for your feedback.


