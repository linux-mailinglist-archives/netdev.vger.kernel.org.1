Return-Path: <netdev+bounces-275871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHPQDpuk1GmkwAcAu9opvQ
	(envelope-from <netdev+bounces-275871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:30:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6163AA4BD
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E98A33004C44
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 06:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDFD3876AE;
	Tue,  7 Apr 2026 06:29:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3013859F0
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543387; cv=none; b=gu9ew98oJYYgqzme9nVodA6ZZ0J9NHXLQjsZtEh/ViNyvKqtRmHF4iAkNRjT46FDUmF7M2BKAF1wuioV+JljmILhA9WnGgCxxDC3Whtk8ICcmsD9l5QP6Qg/ffVO34cXqiU4PQu1zMz4G3K4BbILEoSh66nbdEU16TKiVkpS7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543387; c=relaxed/simple;
	bh=hPjuMrsYaKsfJl9vhjdZBalaE0Arx0M1rCXOaSNOhjc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=C3Rp+Qc4B2BjNWt7cqpjcBePoF91yoTGcJvy6z0ZzI4pY14mK+djfAHrnUGCMobiRZWkLcQbsuuKdD/z26ukSKY0Ac+CtPIrWySBoE4lYfqQx+DMLM9SQ1xPsLxd9hRk3g8S4Re3e8dJ8eXlQDHqcyIw++WaMkt+VDvwIi/GYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1775543262t439t25697
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.220.225.134])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6191075983948110156
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Abdun Nihaal'" <abdun.nihaal@gmail.com>,
	<stable@vger.kernel.org>
References: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com> <acvHIpPd8BL_wFFU@shell.armlinux.org.uk> <076401dcc17d$905c40b0$b114c210$@trustnetic.com> <acy5evlrUesbcB46@shell.armlinux.org.uk>
In-Reply-To: <acy5evlrUesbcB46@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: txgbe: fix RTNL assertion warning when remove module
Date: Tue, 7 Apr 2026 14:27:34 +0800
Message-ID: <096d01dcc657$9ee42b00$dcac8100$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJzBzpg8BZoKCpC0lQLuqOa6+34FQF9cQKNAr0WQJ0BAb3yubR8vYjA
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NoSKVpKsmOWeg5OUEV5r+IO2XtkenAHxZLROiQmyOYigHKRXxKaJFwG6
	vk4DWbjecceFEdvghAbUATFM6dADZpvYsEpYhQ8PH+eXRYsoSMpu2/xQyIffvp2XEDjtbzp
	otmw3uPs/0MtVyFuI3SCFL5d7tSF0QsI0AdPHjvfRiCQBXIP8gMmMoCep0i53C5FkL2fAPn
	EhTNiG1iYUhA0WdOSlr3G0RXRxo94s86a29ttlSvNH1oBo+WmkIOpIaHkhEdf+0Yb8Nsgme
	RF+r+vB7mFHLFrSeF2seuLzzXxJrIqjDkiAtzP8Divm140kuMJUlOaFc0bef+Wrd4ra8gWt
	iJOszwzVkOmOWjKYZILxftzfpdBsuHqIzwXDNGlCiW9TczwQq5zy8bGKz4eBhfZrVO6Fmrz
	J5O5cb70PdgeKFQzkEOOFGVIqrXEY5CbnrEXbN05MQh/7GAIIzrxBqMH3occgup1yK6/JBG
	3Vf+pmW9DwTRpyuNyEQd7XTDih4oxnEobghA5+XrzEprbATqSms+Bqxn3ONvNP41TQD5eIn
	7enOnPEq3po+591+iQMl7ldOhjKDX01tZ19Qj8gLLpTu0XbeH5GYLXAXb8Tt9RIqb5xRdYp
	UGcuz+hD3a/xO8rc7IIZgjECpUOIAegc6LHPX6yArL8F+2ohO8ENq9PsGZhUS7hKidEzI0s
	3nRYDVLtOfUqh7QAViEKzve6/uysE+3DHOM80fPD3dOT0m8JtSk+jRmJGGO6YPWY3iIM/kJ
	uLemyRQtVpI2XWABl6IXyw2qMdSVsG8AbiTHdIMEXNbTXLh1MNf7rAmHv2qeHsGOvwiukSc
	5Cdjmgjc73YsUoOI+lWZtbaYayUTtUnkrRFJzJ+NIhpM9KI4yBcpJG+R13+6wIhNo33Cggx
	6RFEjbrx0domsdxSJVZIH1IOAktTV2kLOQMC48/X/254+or9fWPh3PvJiJlTKFFC62U2Q2Z
	s737Lzzku7YLKYkcu1d74uJ6TaoAfg30rUbNs/M13Wd+CuUyAa14VdUkXGaAHyLUE50hjmb
	xYqHPN35E5oanHSpX+LiJPgVtubKtIG3Nq8u7CdsomGnq4tq6N7HqFTQvi+mI=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275871-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.098];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD6163AA4BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 2:22 PM, Russell King (Oracle) wrote:
> On Wed, Apr 01, 2026 at 10:16:34AM +0800, Jiawen Wu wrote:
> > On Tue, Mar 31, 2026 9:08 PM, Russell King (Oracle) wrote:
> > > On Tue, Mar 31, 2026 at 03:11:07PM +0800, Jiawen Wu wrote:
> > > > For the copper NIC with external PHY, the driver called
> > > > phylink_connect_phy() during probe and phylink_disconnect_phy() during
> > > > remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> > > > upon module remove.
> > > >
> > > > To fix this, move the phylink connect/disconnect PHY to ndo_open/close.
> > >
> > > Wouldn't it be simpler to just wrap the phylink_disconnect_phy() in the
> > > remove function with rtnl_lock()..rtnl_unlock() ?
> >
> > This is also a solution. But I think it would be nice to unify with other drivers
> > that call the functions in ndo_open/close.
> 
> Both approaches are equally valid. Some network drivers attach the PHY
> at probe time (and thus can return -EPROBE_DEFER if the PHY is specified
> but not present). Others attach in .ndo_open which can only fail in this
> circumstance with no retry without userspace manually implementing that.
> 
> There are other advantages and disadvantages to each approach.

Hi,

So is it still recommended that add rtnl_lock()...rtnl_unlock() instead of moving it?



