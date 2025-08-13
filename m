Return-Path: <netdev+bounces-213280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 010ABB24568
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E425717A927
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A62F1FEC;
	Wed, 13 Aug 2025 09:26:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612772EFD88;
	Wed, 13 Aug 2025 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077170; cv=none; b=JIiKLRYCZH1pmCir043qHWFtavXz145QeBMkQxZkLW3TNosPsmdyYSq2NVS8VepKihc5A107EPiOx41uuOUneysQ12K2v7mteiioQj7f+Wz+bNSbWvbKRuhk7Y/Zg/lmrOb60JQU2Uz2V80fwgNjtffTy9C4Hpj+xFsUsNUnAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077170; c=relaxed/simple;
	bh=W0fDeH3owiTJmJEu38Nsuox8tXL/1QJYakS3THLxyr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ird0/b47v5lGztK7tZFOxIcXIXPQJgkxwjOlxU8m2VfHjmTDYY5UpRGUsaaj9K8MnOw4c3g7E0w8RtG2umlJyYZzKywQl3DvZGizmwI/r1LlLeZJ5KlTGKPSE21KULk3D7xubaaXDWQ3bFooBWrEterRuVLfZCMXn3QponZWw10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1755077099t6929a8c0
X-QQ-Originating-IP: qX5Zu+msax9MombwIM22WgfZgxWtcqcwdj7qeK0v1bQ=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 17:24:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2005654415926057517
Date: Wed, 13 Aug 2025 17:24:57 +0800
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
Subject: Re: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <3F4725F9F2582F05+20250813092457.GA972027@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-5-dong100@mucse.com>
 <ab6e5c8c-6f91-4017-b68b-7fdf93980a17@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab6e5c8c-6f91-4017-b68b-7fdf93980a17@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MdoRYM9mYrydKvT79W+P8unt2r8jfFFecPzf+nWWC6A2P8JMZujryXbC
	Ppy66kmUaNY+hZNR0My8j4QLu3AmMydjiBFz9VoTL9uvRUfvRro0PZeparnBr+gQoNkvvbT
	gQTA+9Pi3RvrC0mka48oCpsus4DTkCkaejQzRQPWbjqz9JR3K6WRDrLlHNUKEZ7HaGLbVej
	8BV5Smbqff5sTjP5T2Clsbo3gPVdo50wdN4778py/TCRXYqw1ByD7SbvoRwS+yKYI4MWy1u
	r7gX5r5Hj8sBPyTLhSWl6BNShNKJrEEJb1cLTnuUYySGw3OFln6ZVEHoKGUsL6qwww5GtLr
	XZwJEz4pKBCOwYdtVElrhQ9z+w65EndHU/xgBIq5jE8zpRLUmJDLb2vAH/mKKbf6jCWExbI
	iiyCnk9dnGBs3AL1AXnNxH5bEdFO2ey1Cqaoc71EpqCfVdmIzEw+VTBktYCgawvGgN5qXk4
	wgqwyAF6dbMJNoXQdjOBCamDnD6Erot34GTUra8kUiAecg4qf9crGeqzxjFo2tPQPnYr1S/
	nY4YIfZN3YntF86D5dJD0/PYRhW9Rx7y7tqI3T/YptWXyb6wvmbRaQ9390Y7kA20Q7mZKEq
	uMYlS43eHRMLrZS6fhldFZNl/OgzX+uk8OVY6uFFUryVsoIJijPAvN/+TFRiLwU+a55/4Nl
	Ql5ZX3n/ZV21r71+sSgnzDiA9o/hSE+nna9Hb6FZAtfZIfVF9E33K6spks0FLWDSWAzb37s
	ICLF+XDtBBONTc3nm7AfOQBIay2uQnAb9k67E7wA/BKvg4D0MNqkR+jIzMESHXSDeIxMOY1
	7775lrp00p8UbtS2V+vLYAR/jxIdYx0yDhGV9yW5MdAdKvv34ptDmtMcuAP7rZVXHaXpw/l
	C55b44lBsxxp17rJszgPwJ8vaXoVArWGYgcLAzyUhkzXMJ8ZpxpSxjyGmHuo7UtNMXKNnDg
	lYohgb5cIDYVYlce0D16YghkGtyN3ZrPbJk6m09PJr45kbcK0Ib/Wy+6nBTREBVUxOUuVkj
	3qliK0gw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Wed, Aug 13, 2025 at 01:50:08PM +0530, MD Danish Anwar wrote:
> On 12/08/25 3:09 pm, Dong Yibo wrote:
> > +/**
> > + * mucse_fw_get_capability - Get hw abilities from fw
> > + * @hw: pointer to the HW structure
> > + * @abil: pointer to the hw_abilities structure
> > + *
> > + * mucse_fw_get_capability tries to get hw abilities from
> > + * hw.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int mucse_fw_get_capability(struct mucse_hw *hw,
> > +				   struct hw_abilities *abil)
> > +{
> > +	struct mbx_fw_cmd_reply reply;
> > +	struct mbx_fw_cmd_req req;
> > +	int err;
> > +
> > +	memset(&req, 0, sizeof(req));
> > +	memset(&reply, 0, sizeof(reply));
> > +	build_phy_abalities_req(&req, &req);
> 
> Typo in function name. You probably meant "build_phy_abilities_req".
> 

You are right, I will update it.

> > +	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
> > +	if (!err)
> > +		memcpy(abil, &reply.hw_abilities, sizeof(*abil));
> > +	return err;
> > +}
> > +
> > +/**
> > + * mucse_mbx_get_capability - Get hw abilities from fw
> > + * @hw: pointer to the HW structure
> > + *
> > + * mucse_mbx_get_capability tries to some capabities from
> > + * hw. Many retrys will do if it is failed.
> > + *
> 
> Typo in comment: "tries to some capabities" should be "tries to get
> capabilities"
> 

Got it, I will fix it.

> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_mbx_get_capability(struct mucse_hw *hw)
> > +{
> > +	struct hw_abilities ability;
> > +	int try_cnt = 3;
> > +	int err;
> > +
> > +	memset(&ability, 0, sizeof(ability));
> > +	while (try_cnt--) {
> > +		err = mucse_fw_get_capability(hw, &ability);
> > +		if (err)
> > +			continue;
> > +		hw->pfvfnum = le16_to_cpu(ability.pfnum);
> > +		hw->fw_version = le32_to_cpu(ability.fw_version);
> > +		hw->axi_mhz = le32_to_cpu(ability.axi_mhz);
> > +		hw->bd_uid = le32_to_cpu(ability.bd_uid);
> > +		return 0;
> > +	}
> > +	return err;
> > +}
> 
> 
> Missing initialization of err variable before the last return, which
> could lead to undefined behavior if all attempts fail.
> 

Got it, I will init it by 'int err = -EIO'.

> > +
> > +/**
> > + * mbx_cookie_zalloc - Alloc a cookie structure
> > + * @priv_len: private length for this cookie
> > + *
> 
> 
> -- 
> Thanks and Regards,
> Danish
> 
> 

Thanks for your feedback.


