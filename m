Return-Path: <netdev+bounces-294535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HPaPMNidH2rinwAAu9opvQ
	(envelope-from <netdev+bounces-294535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:22:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE151633D86
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:21:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294535-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294535-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81DA330295B1
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 03:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89FE344025;
	Wed,  3 Jun 2026 03:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951D30E84B
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 03:21:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456867; cv=none; b=mLR3rZSlvRwvT0GTLscJf2s0KFZRpj1PRXPeHUHYf1/5PDxT8PXTn4NXYgcLM40NuLATv2icf1MAbdQ87rESXoIVvAgTZwW0czJbqJU5IBYhLzPbPiizp+X+eM27eLwGFcHWGsArRbFswQWflh5F3Z2eiVAAKU7wH2cpud3du8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456867; c=relaxed/simple;
	bh=udjl9bDiHDQlKRHW+Pxjnahb2P+yYsN7blzZvZHWpEs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=q3va/ADOIAEjy3raKtdWAPGeoe3mngoWsy7TTbFzvyKI63MKY1TUM5JMvjN+OWe/OK27cLs11VKAxDEa2ZUg2zytNzd69UQL/ZVVVj/j9AOYnhXspU79oME30J6tRYKSiZONjHgwmpnYTGFZpKBp3hQP2xDKZZcgpZMja9Q/7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
X-QQ-mid:Yeas5t1780456769t120t00492
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.207.111])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 1108301633170802462
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Simon Horman'" <horms@kernel.org>,
	<netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Simon Horman'" <horms@kernel.org>
References: <F3DA1ECDCE0A1E9E+20260602025443.332456-1-jiawenwu@trustnetic.com> <9945fe19-815b-4e27-8446-c21cdfaa16d9@lunn.ch>
In-Reply-To: <9945fe19-815b-4e27-8446-c21cdfaa16d9@lunn.ch>
Subject: RE: [PATCH net] net: txgbe: fix module identification
Date: Wed, 3 Jun 2026 11:19:27 +0800
Message-ID: <095b01dcf307$c8af8920$5a0e9b60$@trustnetic.com>
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
Thread-Index: AQJEeGsThjjHI0KHzdi2i+gMs9V+4wJaFDfptUpIx1A=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NTApVg+ltz2MQrluYiP8s9ZFVfv0iIH0RsFqAA1TDXuR1Yux4ig2Sb/4
	dkwP1QjrsORQvx4m3jkdB83iGFLDmyQuV3HIjfOkxofO2JgJbd7g9fJ4xYe29S6VmYgqxE2
	nZ1q8Wuk9b2WEAl2oFhpWDz8XqoCfvm+LpEDXhTJKnXFzsvBnhSi1eA7ZpdcRflyboyxgNR
	YoeQVj05uIDjkehmWuL9US8NmXxJ/Dy6EDGSsJN5hn3VDyra73mFZV9Gv7ePP0TyNEZpDot
	1TKOfk5qOtPDRF+3Qymeh77KC7HVrsV/Duc8RiNPGJ4DVTQEe97DU9lVbMwu2nRBVIavGVJ
	IkzS7Pq282m3cPSnxtNAmDokSxah+afMwgpGCPNBtSvuGRa5AWCAVoR1kBu/IbmkWk44b/D
	UL+Ro6I/S7YqZSaC6Yx9ly6FKIZNb1Iw5kLfSVu357Cd3o7uUTcrJa+IloVLgw/VXYN0bQg
	oY9lXFPqhpZdvJTAxx332z94BxW3ymydCI2PfKLYrBbNQ1WxKUKX8lEVqtlXUbdH3p2MSPZ
	4Rp3kAuFdaAROa6IlUCHHXbh/+l0aQJHe/jClknuTPvQedQzDN29zp9uXbXNpLqmlXgfoKR
	eiDbq1tryjDorRgTDf93Zema0CjAiO9iknOuhA9jmOcXkgddBNryzZJ8JcgqRXPnb73sL2M
	Xk+UXWjlM6s7+qgXACewrT2Qqz95zB6FY3FHwFghrx4Te+2xGCWfcNqaoAaZgbmduJVSsEG
	PTtK+epIMDCOOuEdG6c+SytQzG6nLDeiubMM83fvG2A8bryKjetOv/u/iKsgGDVP0ctfWbb
	ry0UGrznNbC5RTQOPYJ7VdoUSQCxR5snHTh2Q68NKVC/UdjL7X+mdmfgJpVwK61lqVEg9nO
	GAVYxr3iOkB4416EQ7PBP96vLNvRThY7INqnwS2wnYLhJBRj6LmCX+AKtctNRomURZEWZj+
	Kx6CxrsreZJVMX39EpmOT+AesYk9Z4aJoJ+hwoJ+iH1HVmZrs+pgl0X4fN1uuHS3cHoowvH
	Evd0tUjNRu9VSN7XktVqnwKZhj5nZr39yb4vT+Y+r+SJhl0Mjjgud5DrrVOFMjfqJp0D/aA
	mWGZmGRCpyTfTeD8v7xCynXBvo1KC//iw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:horms@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-294535-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE151633D86

On Tue, Jun 2, 2026 9:15 PM, Andrew Lunn wrote:
> On Tue, Jun 02, 2026 at 10:54:43AM +0800, Jiawen Wu wrote:
> > For AML devices, there are some issues where the wrong module
> > indentified then configure PHY failed.
> >
> > The module info buffers should be initialized to 0 before the firmware
> > returns information. And DECLARE_PHY_INTERFACE_MASK() does not guarantee
> > zeroed contents, so explicitly clear the temporary interface masks before
> > setting supported interfaces.
> >
> > Rework txgbe_identify_module() to validate module identifiers through
> > explicit type checks instead of relying on transceiver_type heuristics.
> > When using the SFP module, transceiver_type could be a random value,
> > because it was read from an invalid register.
> 
> This seems like multiple fixes. Please break the patch up.

OK.

> The current DECLARE_PHY_INTERFACE_MASK() is not great. It is mostly
> used by phylink in structures which get allocated and zeroed. But here
> you have it as a stack variable. Maybe we want a new variant which
> includes = {} ?

I'll change it to:
  unsigned long interfaces[PHY_INTERFACE_MODE_MAX] = {};

If PHYLINK could optimize DECLARE_PHY_INTERFACE_MASK(), it would be better.



