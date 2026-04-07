Return-Path: <netdev+bounces-275872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OoqIimn1GmkwAcAu9opvQ
	(envelope-from <netdev+bounces-275872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:41:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D19213AA615
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 08:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92882300420B
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 06:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB8238911E;
	Tue,  7 Apr 2026 06:38:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D01714AA;
	Tue,  7 Apr 2026 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543929; cv=none; b=tzAHPKdj5semHm1XBHue01q2goc8dRFYxu60zkBBgseyYGDt2URJFmM51t58IhXR4tsArVah5SgzyJakG1Agbe5uWFKq4dl75XMd9wIkjhNRXSbF2FGJLbN80j2oJzH1GiUjHmjFmmvCHTpfEy9Sm3IZKEsAzxghk/WoorBTU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543929; c=relaxed/simple;
	bh=bQ0NPfQrH9aRloyz9hsGdMpWuPwHTHTVHl3EKJRvqZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feqADWzqInLvuCrqyDLbYKzdafeQxI3nfUe6Yw3p53h1ZwgGNHsss5nqf76s6XE6X1dgGWvtlKcLfumaLiAUQXTFmJBJNsSr7b+iMIGpzKRDvEHi4K6L0NwtsN5H51zsDUXzUcIUphfQG2JoUV6fLrMU29r4cr0K9ZvczPppmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz7t1775543833te1d1fa37
X-QQ-Originating-IP: UWJwNfHu5YXjRpxjmzuYSBOpwYyUtZzKZCVjtQ8Ovn4=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 14:37:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17181006639664093960
Date: Tue, 7 Apr 2026 14:37:11 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, danishanwar@ti.com, vadim.fedorenko@linux.dev,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: rnpgbe: Add TX/RX and link status
 support
Message-ID: <F24BC5BA45D23AFB+20260407063711.GA699604@nic-Precision-5820-Tower>
References: <20260403025713.527841-1-dong100@mucse.com>
 <20260403081249.50e25acd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403081249.50e25acd@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OTaQrRjuGKLtceVz+2FFZQ0hb627hf+8/XBtl/5CZBO4Nt1L9BEvuYIy
	iDcyMVGAxxxwubd9/Wif/rqCbSJ4Me7sUHl3Ci6vNXw0ehZNG5FlJhKdicpKlNavE0sR+a8
	RcLwKfmIiXhn5gi/7hHdUKOuZtNGxHDqxuaslfg41jBX3DCMkVTm9KcU2r8A7guDxuVjjk/
	DsbXSlHsUTrmYyfBlXP1aY88oWlCAdcDRRRF5Kkk+Gx+aL2YwTyFRu4N1O6CNWdBHujpnA4
	9MO1wOnEcChP+O8cHZdNl34zBXcoKVgGs+DsKTQ+KEdiLAdzhlK6I2IVKBJmg8FWNzdTE22
	w1Gpii2SXW9vpK+IvoqgMqB+2MMbftsuCrdtLKrxc7H6qpTLjHESBR5uvg+QMwjnfhkvHlu
	dVaOPhQZFfrj4MGUDvr5FnihjJqJqxRwbgvP95uTBg83r/tia4S7zwdWCUtXfonqR4K2sVa
	zNxfyprjXYjnngNJpgG0TPrLf3C2BwCpSkqEA2vJlatRzbiCZtDn0GPO9mu5G/fSjg533BZ
	/KfGP4GQEzmwGHg4uz0F3BqBnhRoCjTekmaG0GltmDGpuD8m2IGHFYw+kxQVYtFG0cnqJvU
	QTEFWj4RJp0mt8P9ff+AgROekOJo4DFw8MWYtnZLdUUJO12qNCu+0ynsZCLIcaqbbmgy3V2
	x5bfo9doY6shJ+8oQjERkUheSff3cx8fGkW/UsfD9/TatPltNyo7gfa/1Bk5J/KWUifNEzt
	joYh6+gKPainjF55WjC/PWlFUQXYmc9AOiuLXj3LoxE6/F96mWYmwn8kDO5sIJ3j3o8jyyX
	t8xjs5c1ituSe4dDKwpHejY52SvtDsCnzIKjb+ZgSDfQmuXfQmEcSGDpUp3Cfvr/AvmbPV2
	DzS3U+odf+OP9hkm0rqrLqW1CJzy6fG3T2gW34/nK9wB8NiAr6cRDtqP71Y/sTlLMFjO8eU
	Uaf7LKEbltljw+oUG5Sord5zK6A32wlU6Fur7jn1Sxqvc1tX+hzXb1i+tLoeNVtFnR2TRxd
	5paSD8yS8NiTio/xd8PXVIZ9hSbZg=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-275872-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.770];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D19213AA615
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 08:12:49AM -0700, Jakub Kicinski wrote:
> On Fri,  3 Apr 2026 10:57:09 +0800 Dong Yibo wrote:
> > This patch series adds the packet transmission, reception, and link status
> > management features to the RNPGBE driver, building upon the previously
> > introduced mailbox communication and basic driver infrastructure.
> 
> drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h:183:19-23: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> nit: checkpatch complains about a few lines over 80 chars too
> -- 
> pw-bot: cr
> 

Be fixed in next version.

Thanks for you feedback.

