Return-Path: <netdev+bounces-158005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E171DA1014D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F7C168131
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82FE19F411;
	Tue, 14 Jan 2025 07:31:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684EA2343BE
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736839872; cv=none; b=nr7Cb9VrmDcDu0swRB4NcNYp1bZzkqWf20Ms7CiNF1/QO5JC7CPQInmqK/XtMgK288FQyk5rk9vQYUL3+Yao4IZD/TgtJ/BgviwJz8VBZoy6VUCt4OVkh4g/oCA6v1Z3WLJX7q7ZpsXGBwyycysyRcXL5EzIu36FHB4qkr96vZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736839872; c=relaxed/simple;
	bh=/ofsY16RxV1lB598N5qb89iT357S5JKt9DNIvmRBTDc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lpAeLN9hUZCqi6hQ6HHePud36elVQSr2Rn3UZEosUoZhw7aLQ9wbCk4KwcaEMzwt2qzj1I20MXNk+qaShjgz9Xqg/585dETYSO+9S3FoDrHwcnE+3bfsxx2QKUCBHk8uFmZeFTiJyayGO4HEp3bTN+DC3m0bbgkpdu23GLks5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1736839763t316t14003
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.58.48])
X-QQ-SSF:0001000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 15896848793313366868
To: "'Przemek Kitszel'" <przemyslaw.kitszel@intel.com>
Cc: <mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<netdev@vger.kernel.org>
References: <20250113103102.2185782-1-jiawenwu@trustnetic.com> <0be63e70-74bb-465a-a933-0258a45033a8@intel.com>
In-Reply-To: <0be63e70-74bb-465a-a933-0258a45033a8@intel.com>
Subject: RE: [PATCH net-next v2 1/2] net: txgbe: Add basic support for new AML devices
Date: Tue, 14 Jan 2025 15:29:21 +0800
Message-ID: <059d01db6656$07f4dcb0$17de9610$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKq9eOD9bLG7Mwu6gJPC9cEGkVpxgKu/t8ksWD07aA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M+0YV038q5N1J7A6m5Nep3yt0WYraanu9hgy8rAuzIo01VganfI3hCoS
	4J/Il1eac9AE8ofNHIuxf7T2v6FQ0Eow/n20vh7ZOoQmC6BaVbSICGvkOq4GqVPkr8+T6yC
	zWoJXSe/z/K5J59eJhZgTM7JU4nssnD3d5qMqMFr/rGURG+uji64xWMnltyOXSMAXvXQq5z
	ZheHl3FeEv6shGLk4Vt7emIPORmkwHx8uVtyVJT68C2Py4UjwiSR8FoAZ37J76a0JmbZ+xg
	jNzVxx+zJnRj+QPJRiGTLIqKqCjs4FhoUTM0nNGZkMVluCHeRMkJ+vOvF0zZvDSdIv5HjWP
	4equQLf+pmjItHNmXE/cOdPGj9DW0nwhR0VK0eZjKm380C2OJfSzBQRntJDI98S6mJgVTQ+
	QN3QT3WWr9Z/kqQpr2oc2+VvoLCMHsvRFWrIX8ENev5Zl2bDtGt1EG1O3091RlXazmLBpbD
	idTZMCyDNzON4oS0TcG8hxNG/5OJSeV89tG3aAKGTpCL3blWRfAfuGJoWREDh3DZo0Ze7yK
	Ucgt+goNt5uvCUrhSkZneNyZNNQClWW6aSMX5Q7lDQ/nK8K/nORStdi1ogHkotQ+BBCTLJA
	YoURduL7H182lUsfC9M9ZjN/w0nK+7N2xFahsSfPZV9zmPWWxI8J6I4xoGdXxZBO/1oalBL
	y9D/ZG8IQqbtEmkgoZJCFLa12luqlZYsUb3EaQ4pS0C2G8oBsFo2ikROKCptLCOW/1newxt
	Ct6VQ0PRPS8V01sUx33AwlLUA65BMI7l+iROJvhyoWlsbKfmf8+jK9k+TaKGIBmVyDOUM/E
	ymGz+83wfZWJ2IY607e7897Wkjwf33pjvqAUcLzZuS1HQ/jnXxFvaJxMVHorANFdG3ZiYtT
	6Sq5cyrfP2ZKrFkRjL0joDn1WLz8+XB/v3ZcuNHUPIPQEWW+KXy9dRKiJijan/2SbcJhy5B
	8zzXWX+AYwBXF+SsA/LeIf7++Lu0ro7J5GaBiI7RhCuCoE82DPnyVpmjiU0QAzMP5Qr0=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

> > +	/* index to unique seq id for each mbox message */
> > +	send_hdr->index = wx->swfw_index;
> > +	send_cmd = send_hdr->cmd;
> > +
> > +	dword_len = length >> 2;
> > +	/* write data to SW-FW mbox array */
> > +	for (i = 0; i < dword_len; i++) {
> > +		wr32a(wx, WX_SW2FW_MBOX, i, (__force u32)cpu_to_le32(buffer[i]));
> > +		/* write flush */
> > +		rd32a(wx, WX_SW2FW_MBOX, i);
> 
> do you really need to flush all registers?

Yes, hardware requires this.

> 
> > +	}
> > +
> > +	/* generate interrupt to notify FW */
> > +	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, 0);
> > +	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, WX_SW2FW_MBOX_CMD_VLD);
> > +
> > +	dword_len = hdr_size >> 2;
> > +
> > +	/* polling reply from FW */
> > +	timeout = 50;
> > +	do {
> > +		timeout--;
> > +		usleep_range(1000, 2000);
> > +
> > +		/* read hdr */
> > +		for (bi = 0; bi < dword_len; bi++)
> > +			buffer[bi] = rd32a(wx, WX_FW2SW_MBOX, bi);
> 
> no need for le32_to_cpu()?
> (if so, reexamine whole patch)

Indeed need.

> > +/**
> > + *  wx_host_interface_command - Issue command to manageability block
> > + *  @wx: pointer to the HW structure
> > + *  @buffer: contains the command to write and where the return status will
> > + *   be placed
> > + *  @length: length of buffer, must be multiple of 4 bytes
> > + *  @timeout: time in ms to wait for command completion
> > + *  @return_data: read and return data from the buffer (true) or not (false)
> > + *   Needed because FW structures are big endian and decoding of
> 
> In other places you were using cpu_to_le32(), this comment seems to
> contradict that

FW structures are big endian, and we agreed to transfer in the mailbox registers
according to 32-bit little endian. However, buffers contain 8 bits or 16 bits field
which is composed using CPU byte order. So we use cpu_to_le32() and le32_to_cpu()
in this driver.
 


