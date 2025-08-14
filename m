Return-Path: <netdev+bounces-213553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599E7B2594B
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 03:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192C772519C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 01:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49648230BD2;
	Thu, 14 Aug 2025 01:53:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31941E5B9A
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755136436; cv=none; b=V86Ll5BGtDxEhINGqQk9W49TJBbwUSnNBQwPN1SbZdwBXlGTySolqWFerOfTEta/7K3AGM+nxaCIdSZrKAFg2o63DC2KYTC7qtBsBUILTwcrl1B9Yh6aCN0a3grANVXnMPO2tPMo/0pw+Isbl3qVRLgMV2lyqfm9lOmmXMqPfdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755136436; c=relaxed/simple;
	bh=Ac3maCaIZzqWgg+Pzfw4v81Zk72IU43wq9/V06+1a0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtaNH3fFzHKsF72ec84XpfsTfcD1UdfcaS7YclEL4gWDrxe+OJXqGUURZAq+Gqk4aMr3PnxJpLGbMYVDt4UR81/DPGASR7MrA8wpDCVsOT/Cju+o165JKNA4glL1npKnaD/KGnTn7gYq/PEcfAVDcpPDLSkEgEXbAiQf2lffDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1755136417t11072677
X-QQ-Originating-IP: m/6wtrsB7RUkOkSTUYXbZsMfDHOmwTUKxwgLbPBVHBI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 09:53:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12872293914549841660
Date: Thu, 14 Aug 2025 09:53:35 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <3B3BFEBA13D607F2+20250814015335.GB1031326@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-5-dong100@mucse.com>
 <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
 <9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>
 <2ef60880-f85d-4a1a-b50c-9ea73fee70b0@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ef60880-f85d-4a1a-b50c-9ea73fee70b0@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: McoPngcDBvM5cNSzrcaqcrupfOKcBlYEv4D7d5GwlmHk8DWT2/hQHSgj
	Xx/pnzfGH/7OiSZqCOoqgGZ9RfPzJr9gYvPzWb04em2lSKD5WB4ZgALSfjRZpmkRs96nHau
	p/cAQ+tZKUcMIISIwQQqts5sf7LPEZ8E48FsD+Xrr/QolGPvpM0mqG/CRLsyUYkF7pIAdAM
	PM111LZtM1p3hPwG0T6Nus8kG/dG6WN9jx1yrpUluPyUJ1cQcad+RBZB+HCn4kQ/aHC3eL/
	nLZtz/SCgEHVfOUgTpezoNnEPbuCvab5/FUROXmw5lIJ9Xy8izxxUgCLj7ea8mW8FGLPZ+p
	We83F6fZsdkZ1djNKWoV/bGxY8kt0UlSL/+lRY3EEBHBEfVfOCEcoSXIuQ0yIvEPpbuw5Wt
	tsLyhvp1ucgwrzb6G/CW9tuM5F/dy8C37Dxj+641NXalnDQt/+vJ/yG79A1WZA5MzWjqNOm
	+XlsjGYyLF8nYL6ETyq6zyxm71EMmMuS15i+O72sSXRVut7WSECyi4xSRNHszBmoqVz1Hp2
	Q2xTP5IBtYuFKgbW6EkQJVIJYQekfryy3/RD/Wfq2Bnn6DDQuNnocZ9mtGKgCbbKnLj3q7w
	7lxjxZTlwPSNcOXsJbyLteebxuT3CVjop7Q+uDT0B8Z6AIaRv+dRUk+KYHGlUazW1OV6PSA
	qKuFpkkVaxVtOPKcpbIGGrEKhQo0sTqP+3TpBZf5ekuzvNoaDOpjWC2RBSdNIxZJSKK/ZoK
	Qgo8NjgU9jvFA4i7dcqKLe5cYLQEbqsGaKkvYaI1esooPZdK65hxV0U2dkBlEAHBafAlUNY
	Wu0xr8OP4kNNp52WhBPyqneALlRDpMaUifryEVIJO7prnOIbXBu+gr0CD1BnIkURjCU4CKv
	shZa/Y57hcvn26I4Gl2gHYxMfPTK06zCUkv6R1/owXaV+JNDFR7/aZue+a96ag39YK5lc0N
	yxlZ/SruAx5SeXm4JtH9GJqkHImLnXHf9DXx8xgyL6Q23D6qJnIM2HhnC24y3ld0crcx1yt
	ypdzxRIw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Wed, Aug 13, 2025 at 02:33:39PM +0100, Vadim Fedorenko wrote:
> On 13/08/2025 10:52, Yibo Dong wrote:
> > On Tue, Aug 12, 2025 at 05:14:15PM +0100, Vadim Fedorenko wrote:
> > > On 12/08/2025 10:39, Dong Yibo wrote:
> > > > Initialize basic mbx_fw ops, such as get_capability, reset phy
> > > > and so on.
> > > > 
> > > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > > +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> > > > +				  struct mbx_fw_cmd_req *req,
> > > > +				  struct mbx_fw_cmd_reply *reply)
> > > > +{
> > > > +	int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> > > > +	int retry_cnt = 3;
> > > > +	int err;
> > > > +
> > > > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > > > +	if (err)
> > > > +		return err;
> > > > +	err = hw->mbx.ops->write_posted(hw, (u32 *)req,
> > > > +					L_WD(len));
> > > > +	if (err) {> +		mutex_unlock(&hw->mbx.lock);
> > > > +		return err;
> > > > +	}
> > > 
> > > it might look a bit cleaner if you add error label and have unlock code
> > > once in the end of the function...
> > > 
> > 
> > If it is more cleaner bellow?
> > 
> > static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> >                                    struct mbx_fw_cmd_req *req,
> >                                    struct mbx_fw_cmd_reply *reply)
> > {
> >          int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> >          int retry_cnt = 3;
> >          int err;
> > 
> >          err = mutex_lock_interruptible(&hw->mbx.lock);
> >          if (err)
> >                  return err;
> >          err = hw->mbx.ops->write_posted(hw, (u32 *)req,
> >                                          L_WD(len));
> >          if (err)
> >                  goto quit;
> >          do {
> >                  err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
> >                                                 L_WD(sizeof(*reply)));
> >                  if (err)
> >                          goto quit;
> >          } while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> > 
> >          mutex_unlock(&hw->mbx.lock);
> >          if (retry_cnt < 0)
> >                  return -ETIMEDOUT;
> >          if (reply->error_code)
> >                  return -EIO;
> >          return 0;
> > quit:
> >          mutex_unlock(&hw->mbx.lock);
> >          return err;
> > }
> > 
> 
> Maybe:
> 
>           } while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> 
>  quit:
>           mutex_unlock(&hw->mbx.lock);
>           if (!err && retry_cnt < 0)
>                   return -ETIMEDOUT;
>           if (!err && reply->error_code)
>                   return -EIO;
>           return err;
> 
> 
> looks cleaner
> 
> 

Got it, I will update this, thanks. 


