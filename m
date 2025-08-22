Return-Path: <netdev+bounces-215962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E00B3127F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92840AC78B1
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809A22ECD27;
	Fri, 22 Aug 2025 09:05:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012C4C83;
	Fri, 22 Aug 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853504; cv=none; b=NAdyAVWYnqfEyYYJjZbyxfxWVGaNFGCcM+YTHanc1REaQw02/yOr4VSU+KQsh2e0S8iynbzEHNCCZFGPADgZCYEETTiK+wu2eA2smhYkkzxVTT54xdtB8X5b7FL7e2//8+lMJtOFdIh1lV6zKqHwK6vQiVNaA9h8s0oHWR7luP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853504; c=relaxed/simple;
	bh=60t7hl/zu+umYs+4sITncQYOpqFbM2NUS4qjxJ79ijo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA2GdtK2A4HHHCJL7xSzVqCNwRmU6eY8Xbak3iEnLpLi2LEALQ4nhXXAtzjLsfc19TY1OqPAt/TRkyR+8rxNlPWoIvVsV6w8dRrEHpsNFsex0eYJhZEXlxd1neMLiAhn0sKSnRe05oYuLmErCvjTTnHbf4YjiXJKoxppHgnue+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz3t1755853484t91f67561
X-QQ-Originating-IP: KdZQdKjiVmOq80u/rGcJtR2w8ZFqoQtAd8QF7QfZ6dY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 17:04:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7948226793383003131
Date: Fri, 22 Aug 2025 17:04:43 +0800
From: Yibo Dong <dong100@mucse.com>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <42CB765B997D9FF5+20250822090443.GA1963638@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <9fc58eb7-e3d8-4593-9d62-82ec40d4c7d2@microchip.com>
 <7D780BA46B65623F+20250822053740.GC1931582@nic-Precision-5820-Tower>
 <8fc334ac-cef8-447b-8a5b-9aa899e0d457@microchip.com>
 <A1F3F9E0764A4308+20250822065132.GA1942990@nic-Precision-5820-Tower>
 <bb6826d4-2e17-4cdd-a64f-26d346224805@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb6826d4-2e17-4cdd-a64f-26d346224805@microchip.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MvyKdZyVtFx3iDqIOOqiI+Q5eJhbMIlR8m01Gf3QOToIc0p3a49b83IG
	2LiIn9BBM6BvVNS4joP77MnOrGWz/iKg/2cedWjFY6oLuFTn3UApyJf3lA8ekAtuW1fK7Fd
	8oEQWdZ84A9BUX9lgiHIdxFIVl2c0rcG4q471WUUOOcNzCKWHrOYk+46MtsTLxAY4FzpcIF
	LqBCNNuP81qn8f0w7Kc9cZN8s1n9Jj4Mh/pM0UvYkKH73p/JNNoXYIf/33nBIz21PmNJBJB
	fRM8A2jdAcaHukEEm3SdWGkOLv1heFKKtQGTpxBOMJK2xOZfEASLDSWZjipZA3xTw6Lpqz2
	qtSj3q4uc2AE4Sa+sBn41MjKFCqNSvcQnClwJYN28QgUmAPEMpQxEWf5HVPI3IepKLH4aP2
	ObNghqcyLtlbTcGZNY6l4QBS2HwNL5daDhzN5lyFaafioan3HfPrtJYNUWzyDvO0bJmM7QK
	w1md2Gipi8aVxbOkWGcgfQkNOLmPQxQRUpJZstP9RdXUs4Zwt3iFGGSKU2P4gvfgnMOF63H
	0i3xsuzcYc2q3/do9oxByBuh5SpzcghKV5TMeJK/4SRHwtI6uM1XW4f1TvX6Jf3Sdq2D4dv
	kWZz+dqlk/CudtXD2KhLW+eKiavG4P30hD2vvqBRrxBx3chIj5RfmwWUtQJOePMWQoH+gwB
	qYS1HyxMmlFCDrHyOWBeUe0vv5017fLvTrRD7k3Pgg3rE/mPWvMUPySVBYBF/bwZfiziT37
	28/lK84a2xZIpd3W/1fv4napn/Iw4P5QbH9ZHn9P+XhG9CJFbER/Kmyv1tQmi/j7O/gMPQr
	wUZZAquBxAXMWI39vsdcR4XKvNoqqK2xpGV59+ek5RrsQdpIZ5qsg+8yMDrvgAxsNG9vPXR
	H2ZOR0YOTqy4KAv1PHyxWYdzX3ylUaleJil/1Cgg4efn8NquLqLI+Aat8enEb1XVny3fuaT
	hGtGJHvv+58mceVRYbJJ/yivJakFK0SjwkaCb+3wgb++FJtQ/en5Q2Ya8mI8O6RYs7U5VO2
	UUZ75rcQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 08:05:50AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> On 22/08/25 12:21 pm, Yibo Dong wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Fri, Aug 22, 2025 at 06:07:51AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> >> On 22/08/25 11:07 am, Yibo Dong wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> On Fri, Aug 22, 2025 at 04:49:44AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> >>>> On 22/08/25 8:04 am, Dong Yibo wrote:
> >>>>> +/**
> >>>>> + * mucse_mbx_get_capability - Get hw abilities from fw
> >>>>> + * @hw: pointer to the HW structure
> >>>>> + *
> >>>>> + * mucse_mbx_get_capability tries to get capabities from
> >>>>> + * hw. Many retrys will do if it is failed.
> >>>>> + *
> >>>>> + * @return: 0 on success, negative on failure
> >>>>> + **/
> >>>>> +int mucse_mbx_get_capability(struct mucse_hw *hw)
> >>>>> +{
> >>>>> +       struct hw_abilities ability = {};
> >>>>> +       int try_cnt = 3;
> >>>>> +       int err = -EIO;
> >>>> Here too you no need to assign -EIO as it is updated in the while.
> >>>>
> >>>> Best regards,
> >>>> Parthiban V
> >>>>> +
> >>>>> +       while (try_cnt--) {
> >>>>> +               err = mucse_fw_get_capability(hw, &ability);
> >>>>> +               if (err)
> >>>>> +                       continue;
> >>>>> +               hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> >>>>> +               return 0;
> >>>>> +       }
> >>>>> +       return err;
> >>>>> +}
> >>>>> +
> >>>
> >>> err is updated because 'try_cnt = 3'. But to the code logic itself, it should
> >>> not leave err uninitialized since no guarantee that codes 'whthin while'
> >>> run at least once. Right?
> >> Yes, but 'try_cnt' is hard coded as 3, so the 'while loop' will always
> >> execute and err will definitely be updated.
> >>
> >> So in this case, the check isn’t needed unless try_cnt is being modified
> >> externally with unknown values, which doesn’t seem to be happening here.
> >>
> >> Best regards,
> >> Parthiban V
> >>>
> >>> Thanks for your feedback.
> >>>
> >>>
> >>
> > 
> > Is it fine if I add some comment like this?
> > .....
> > /* Initialized as a defensive measure to handle edge cases
> >   * where try_cnt might be modified
> >   */
> >   int err = -EIO;
> > .....
> > 
> > Additionally, keeping this initialization ensures we’ll no need to consider
> > its impact every time 'try_cnt' is modified (Although this situation is
> > almost impossible).
> If you're concerned that 'try_cnt' might be modified, then let's keep 
> the existing implementation as is. I also think the comment might not be 
> necessary, so feel free to ignore my earlier suggestion.
> 
> Best regards,
> Parthiban V
> > 
> > Thanks for your feedback.
> > 
> > 
> 

Thank you for your understanding and flexibility. I'll keep the current
implementation with the initialization of err = -EIO as a defensive measure,
as you suggested. I appreciate your willingness to accommodate this consideration.


