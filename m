Return-Path: <netdev+bounces-292527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIG0ENeoF2qhMQgAu9opvQ
	(envelope-from <netdev+bounces-292527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:30:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 524DA5EBCCA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF7F8306CACE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BDC2F6160;
	Thu, 28 May 2026 02:30:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C62F7F03
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935400; cv=none; b=TiR4CI1saH8hUzJBRShUiK1AoRsPgXLhLWkqKzIgpkDTYWRH6Oa97fRdfUv1MBIAPEHjAM89KKPa3J1ZqYEzTmp3Ng+htr+EDyPRDK0sQjkJcgsrug5+UWko/4T5ij+SydZrhIy/komib7rPKDih+zLsAoOp44ULi9I+3BQu8Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935400; c=relaxed/simple;
	bh=JF0sTtMh/iXms6hZAHqTCAFqi23P9uzM/Uqn23eXiyY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=LWxvrIqQhZ415moaK5P2OhXxMwDRtXyRfSuv7g6HA3ndx6g8q0pmmJb5/ntEYlqXLkHAxtoWc+9pcxsbygHBzGWexD/uWM9eEe8e7J8zf0U6UxNLD63VJO67gH/D0UEBhRL6npwlziXoKuOCI+OIcrQtelE2+cdWUJyWFa48/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1779935309t605t26495
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.231.28.113])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12221602337143095102
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>
References: <20260525100543.27140-1-jiawenwu@trustnetic.com> <20260527143114.GM2256768@horms.kernel.org>
In-Reply-To: <20260527143114.GM2256768@horms.kernel.org>
Subject: RE: [PATCH net-next v2 0/3] wangxun: improve service task synchronization
Date: Thu, 28 May 2026 10:28:28 +0800
Message-ID: <065b01dcee49$ab3f2de0$01bd89a0$@trustnetic.com>
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
Thread-Index: AQLGqosUc2I+RjMA+jgobyDmpqrvcgI1wUn7tD2J9rA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MuYE5/Bk7PRmE8RUP+6izm2uEmgzCqcR0E7y5B/aVXVjWFMkGZJ+T4/8
	mEL+VP5GZ6MxDINe4G9PtLUQKchBq4+uSENq7KHEkqi6/DZOznggGUp+M+PNdoxE2d0qd/A
	hyvF4Zoix9wetXZ/tCQhC2Qw5Bv5FJ/ZW1XqLkrVtFbkssaUBFodYnb58K2WQ0D5KBjnXPQ
	9WJq7Jo4WGEN0RJ7Y0hWNyiP5pl1vxsL+nJNNO2nAfja7plI7gZ3SA5+5FByB+U9dxVtCgw
	64RNkuz2ezrNxwz+UX2bXOYxGvX8vlYgUHKjuIflbuXmVio8jfNGxlCUY6Zax3omWQr/Y0m
	O5ytmIb5FPDB1FhFGvMHD/ST4LRttoYWzGU/IaUcShBwo9QvBbmlPVRcTa7zrTw8FE5haRl
	7KT22qgALvJUwGDnFaSegK+M5/JtFtuhYPOWCQ0TK7+jpqlItQbBmFTi+Dx4bqtYpH+rbVJ
	Lxa4SVeWxAQ45ipwKS7ZYfBCwqvz7fltWDm3fBrQDRWtsclr2yXn3rDZMCO47ULo5QaA3XV
	TVQMqNkzIWU5fFytf5H4jJ2urqrx2kqZj8HgHw1iyr0FE5UuF2sUGO0LFQ9NkbptcGFs/Jy
	SwmEuWQ6ZV0/LxVn8kF1GfvxBUrZoy9kk8AAJIoPQrJg+mMHLApnmhzpWld0cLYupyqMje7
	luI5aD3DssTDbP6mW6UBfI+RTUPr7ZiQa8y+vnCWBk74hDZAPPCQL4hiLDSPO3tszYW3eFK
	Qh5d191wwD6gaP6a4lxWgOpeJB7UtIkti/G6gTqSFqimxQB5kR6uayc9ErmdE5kCS7NGJZ8
	GHAZjKBGSD+jmLSBS48KWxBRY/VtUB28brZF2r2O7BXipwcPeua/PZiHCL1EqU/aWiDNZN0
	+7bHjuz/2r2xtiSYwlG42KRRA6eiWUrwg36WA2joAdZHsyfm34pO7xkvfnCja0n5GXMUkrJ
	bd8a5kXw6lBu/z/guAMRVCy2BFFXDQBs50af5tf2SZ5S13Klk+pKXpI/NhZm2yyh1oyrIpq
	REDvZuZSnbS5E/N0cHre48vwzD5G4t8aTZqejWfYUSKSmOnCgVZbgzqCD9BdIBUR/PAPTm5
	w==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292527-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,trustnetic.com:mid]
X-Rspamd-Queue-Id: 524DA5EBCCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 10:31 PM, Simon Horman wrote:
> On Mon, May 25, 2026 at 06:05:40PM +0800, Jiawen Wu wrote:
> > This series improves synchronization between asynchronous service work,
> > device teardown, and module event handling in the Wangxun drivers.
> >
> > ---
> > v2:
> > - Check WX_STATE_DOWN before setting WX_STATE_SERVICE_SCHED.
> >
> > v1: https://lore.kernel.org/all/20260519080048.7448-1-jiawenwu@trustnetic.com
> 
> Hi Jiawen,
> 
> There are AI-generated reviews of this patch-set available at
> https://netdev-ai.bots.linux.dev/ and https://sashiko.dev/
> 
> I would appreciate it if you could look over them and address any
> issues that are either introduced by this patch-set, or directly
> impact it.
> 
> I would not suggest expanding this patchset to address any other
> pre-existing issues, but rather address them separately as appropriate.

Hi,

Looked over AI-generated reviews, there are some issues need to be clarified.

Sashiko-nipa exposes an existing issue in the wxvf resume flow.  The VF PM
resume path currently calls wx_init_interrupt_scheme() followed by
netif_device_attach(), but does not reopen the device when the interface
was running before suspend. I plan to address this separately by fixing the
wxvf resume flow.

Sashiko-gemini exposes some issues but none of them were introduced by
this patch set. And one issue I've clarified in the previous version.



