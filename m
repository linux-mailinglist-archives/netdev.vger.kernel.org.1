Return-Path: <netdev+bounces-231624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627C9BFB9C0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF4A426E07
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020B133438F;
	Wed, 22 Oct 2025 11:21:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19933374C;
	Wed, 22 Oct 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132091; cv=none; b=kKrL/o+mDW3TFP7WrKX+y8U+HlMkV6mbsGMuMOQOLuwM2e8eSOwZSyvmYJRM2vvgNZxjhSW4Jp0O4w6ucPShLcSTLAZy3QPdNY7+Wkryug2flk1npowSUlxO1RWAkDlI6ispupbjQQPvnWodsW9+BTzT3AtlRO+zkw8qnfIxV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132091; c=relaxed/simple;
	bh=fP7buK1er2UCVxFe/13kgYi2s+JhBGAJkdAoOJbzpo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1aGMJLKeKvbSDkY+9NtThFWr3WJefoL40TnCH7h9tVLxRwIm/sO8N6Nd4P/YkvGUXlu0RtaHw6vEnWVcddwd9wDJs8ZRC0vkoHAlEGBUIek3noD2Pq4QX+ks8g/whjYRXqEtV4eApRTxmYKzgbdDGf2CsDrfl8xgfen0VILMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1761132062tf02c5ba1
X-QQ-Originating-IP: tbMILMwLIwoOeiMjYUPtdlDM1kxUWMOdiuIdLLC3FwQ=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Oct 2025 19:21:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2560357849048192699
Date: Wed, 22 Oct 2025 19:21:00 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, danishanwar@ti.com, geert+renesas@glider.be,
	mpe@ellerman.id.au, lorenzo@kernel.org, lukas.bulwahn@redhat.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v15 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <3CA6D21491D51426+20251022112100.GA61682@nic-Precision-5820-Tower>
References: <20251022081351.99446-1-dong100@mucse.com>
 <20251022081351.99446-5-dong100@mucse.com>
 <d46abe01-2f1d-42ec-ab93-a0be3d431c09@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d46abe01-2f1d-42ec-ab93-a0be3d431c09@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Ndw/mc8X39ObfM92LSarzqTzS5nW1avRkMDlxqA0z/KhET26JNUrNDsi
	QqMhOteiMtOMn8awuvYuu1hFW8lFM5osddR5QE9XHuzOFmSIoILwxyzutdFEeatuOiJ8HFl
	QJsm5UPm2AXTiT4O/dFaU+JPSbrR4tS3VBOUB5shdaJYOEuYZoQvNjsWRsi+B0IcyFBNwH9
	VSzJ+nFA7ejCXlesv8lMEIDOViVn4diwD80rMPA+LMlpHrljVaMpAvb5dTZpbiQdzXM1ZUI
	eDiAO9Put2pLiCIzHD/zxSLnW2kJ+b7lUydml6V8kcEUTYi+JYH7BO94G9+VW1yMBcy7Agk
	wsRt+qSr35FUiwhbfpEYAgISThnCbU9vSgPwoSmB8h0UBzfb4+/HZwO63vedMgwnUXgjkNy
	YkMVggVKm7YxeeqLug2g5ZeTPsCG2L3THUNKWQ0xPcDtLKFStB5QhRDg0LyPmCyltPeCPDC
	hvseNvfKn/HxyPJliUvfEe+mVEWX/uDLHibBgZNDJ2XrHj+mVq1YKprxea/JmlOuR5Msldn
	Rvxmm4yTznp/rb1ItEN90OCeIUnUPM2t7zY4lBB14FyT5B+dZ1kiJdLoFslx8MnO6COOQ46
	V3/zaoEipPiflB8MdntY/96WlVAwMCx5PmHWPsosvSjP03PXHHY7p6Twuk+icOwYrIQ+oip
	8WzSZxrUqRLgt/OX2+dRs+6PgocpqG6n2cJz/GpuJyWc83mfbnwzAB1EErLVbPzT49e+ftY
	e479Do1l1zEuYbyXPdLlpMUy06mhgTeu3gMi881OAXQ4OJCHvG8QGXf2iYVul3BwWiMczwK
	QkUdvLlRm1uzM/NVjzivsNCbosoTTF/+ilyP0GsrEMsWsYShJMfvaoPhpzw+PUxPtv+3Jd+
	QVLnwW4MoJ63ZrHKxEx1WT9rR7stAVZoQ+jaZ3xLpubDF4wSm0TGHUqq/Xtk+gH5reAs8+y
	ZvAVVVaYtZPnUsv0W+Ska8m5EX9ikAIedHO111eqXOAgvsGBlhIw+WUQ/TRtzolooBMWc4o
	oKZ6mJfDYCLT9YI51e
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Wed, Oct 22, 2025 at 12:07:59PM +0100, Vadim Fedorenko wrote:
> On 22/10/2025 09:13, Dong Yibo wrote:
> > Add fundamental firmware (FW) communication operations via PF-FW
> > mailbox, including:
> > - FW sync (via HW info query with retries)
> > - HW reset (post FW command to reset hardware)
> > - MAC address retrieval (request FW for port-specific MAC)
> > - Power management (powerup/powerdown notification to FW)
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
> >   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   4 +
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   1 +
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 194 ++++++++++++++++++
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  88 ++++++++
> >   5 files changed, 289 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> >   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
> 
> [...]
> 
> > +static int mucse_mbx_get_info(struct mucse_hw *hw)
> > +{
> > +	struct mbx_fw_cmd_req req = {
> > +		.datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN),
> > +		.opcode  = cpu_to_le16(GET_HW_INFO),
> > +	};
> > +	struct mbx_fw_cmd_reply reply = {};
> > +	struct mucse_hw_info info = {};
> > +	int err;
> > +
> > +	err = mucse_fw_send_cmd_wait_resp(hw, &req, &reply);
> > +	if (!err) {
> > +		memcpy(&info, &reply.hw_info, sizeof(struct mucse_hw_info));
> > +		hw->pfvfnum = FIELD_GET(GENMASK_U16(7, 0),
> > +					le16_to_cpu(info.pfnum));
> 
> why do you need local struct mucse_hw_info info? The reply is stack
> allocated, nothing else will use it afterwards. You clear out
> info on allocation (40 bytes memset), then you copy whole structure from
> reply to info (another round of 40 bytes reads/writes) and then use only
> 2 bytes out of it - it does look like an overkill, you can access
> reply.hwinfo.pfnum directly.
> 

mm, you are right, I should access it directly. Thanks. 

> 
> 

