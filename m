Return-Path: <netdev+bounces-273833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGMZCgeBzGkFTgYAu9opvQ
	(envelope-from <netdev+bounces-273833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:20:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB95373C8D
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10F6C307B573
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A6E2D8DC4;
	Wed,  1 Apr 2026 02:18:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C80156CA
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009921; cv=none; b=KSSdjuzeLoU8K4GV5yq1S0eo/3jTt+1gD8ovmlyQsEoUKdub8Iq7Oeib4oixOvpxDWBC42Zwk/peMP98IU4Bkvh6mV4QC1CxmVqr1T8phkB28tPS+MZfYBAOG2Knh/l+KkW9zz/81//hK497YP1U1k/OQpRGd+jF0qvAaeey5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009921; c=relaxed/simple;
	bh=o64+1RkjX8yy7bj4xpp8kQYTPeJethVN3dN34VjYyw8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=gq0AhkIeKmD3Ivq5s5eSuwhtT/w3B+YO4zAqG8ESBfmiHocK7M5kT9JjjErIcTfDD6KcN/E9z/o2A4mfDiNdl/9/0WHkxBlvaIVbdxtGgrqedBjbtO8yUsifME1tZxefWBK9GiaagbdNGBq9uxR3Qe8q/kiVoWxLEVkn7k5cPGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas1t1775009796t108t02985
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.227.224.139])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 10809986777126156013
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
	<stable@vger.kernel.org>,
	<netdev@vger.kernel.org>,
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
References: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com> <acvHIpPd8BL_wFFU@shell.armlinux.org.uk>
In-Reply-To: <acvHIpPd8BL_wFFU@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: txgbe: fix RTNL assertion warning when remove module
Date: Wed, 1 Apr 2026 10:16:34 +0800
Message-ID: <076401dcc17d$905c40b0$b114c210$@trustnetic.com>
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
Thread-Index: AQJzBzpg8BZoKCpC0lQLuqOa6+34FQF9cQKNtJEALcA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M3ZkD08p3wd5vOJbC/P1EZnZgqEl1VixJs8K5GB0PipZjcGm3zrSugpv
	n0rf7J69Rs1eLdRswq2OuQtfdq+5dPbgOuLV9Zq7sR/7zK5ung2lz5mWaHw0YsfzzbxcU7r
	S23Xs4l7NCERa+sUAeZ0rT0nwX0sXUxj55tyGuvoIFG+AvBbbKBStGK6Q/nAOZJ5konTJqJ
	o/S5yM9kc/siLQSrLQ8SSWRh7Br43vXFTyc0du+PhHY7J1Rtugdszj+IImb8limmhdTRbjS
	CFnoLut9bIcxlsyHT3uotAP0YsQFzqZ+cAnRwTJzEKNq5nRg1mvnErURc4xnTJvK0p39507
	rv+H44AVI4O8IZ7aNIB5ttz0+ESMNA0FyjoSBhSGI6qeceZBFqQokBTdhjA5DwYmgx9O3dj
	+6oVxH5RlyP7BYcIw2kwrDDleJTHYZWWLDOWVhcujaqUudajA0ahxOfeqnvjIF7wU+g5QmK
	ED5dMsFGSWHUfKembPPJt1JZ+07NZVJfr5DLPOUSCkUlHvkrE403/0KUqyBDRrNgx4QfIL+
	jZ5pyoEbkl9OMNJ1jnJes9HT+KAemD4H0l59mbrevtC5w4cHNJgXpulCdIojbGc8x47kYxK
	8M2OG7Xdog9yxhCT6jjq1FpUEvo+cQeSu10APLu87tTH1OLPT/IjvNBziFPII3uPCTTD+mG
	tJzvFsLnbg14lG61kOnS0QFvxxanWM+zlFGj4PiiIt98dDtgN5wxm7sUKyEyu477hBQH14y
	iWpAvWJaw5hLVds80rElPR/ko0q5421TMdZ8AovfADgzfbHNKd1MpZaWzXGVLCB8euTC7Es
	pA6VUl1cOoiXkAf0PgCHAwMcsxhOO1LQPsupLCwZ0Ie1iC1IYXBjv51vwsE3Eka1t4h4T0I
	gHaX6gck7ybdMe7y1ef6TTqnOyjKqmYTiVO/F6t63zU6ParAr9Pmv0gZKUan0PlruKSBOmo
	tGyIs4rbckxP835hWtvoLV8cWRFy27BXlH7+EXiu0nRmWXF1ZzEKDVgZkIu3/CO88vq2o2x
	ra9VxUctS6hp3GmOIiQZeS/ltxZ+Z4gPNtCz0pbw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273833-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.839];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AB95373C8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 9:08 PM, Russell King (Oracle) wrote:
> On Tue, Mar 31, 2026 at 03:11:07PM +0800, Jiawen Wu wrote:
> > For the copper NIC with external PHY, the driver called
> > phylink_connect_phy() during probe and phylink_disconnect_phy() during
> > remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> > upon module remove.
> >
> > To fix this, move the phylink connect/disconnect PHY to ndo_open/close.
> 
> Wouldn't it be simpler to just wrap the phylink_disconnect_phy() in the
> remove function with rtnl_lock()..rtnl_unlock() ?

This is also a solution. But I think it would be nice to unify with other drivers
that call the functions in ndo_open/close.


